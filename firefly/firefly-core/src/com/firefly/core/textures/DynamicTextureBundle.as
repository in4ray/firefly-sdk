package com.firefly.core.textures
{
	import com.firefly.core.firefly_internal;
	import com.firefly.core.async.Completer;
	import com.firefly.core.async.Future;
	import com.firefly.core.async.GroupCompleter;
	import com.firefly.core.textures.helpers.DynamicTextureItem;
	import com.firefly.core.textures.loaders.ITextureLoader;
	import com.firefly.core.utils.Log;
	
	import flash.display.BitmapData;
	import flash.utils.Dictionary;
	
	import starling.textures.Texture;

	use namespace firefly_internal;
	
	/** Dynamic bundle place fxg and bitmap textures on atlases automatically 
	 *  using Max Rectangle algorithm. It's not good solution for release
	 *  version of games but it's good enough for quick prototyping. */	
	public class DynamicTextureBundle extends TextureBundle
	{
		/** @private */
		firefly_internal var textureAtlasItems:Dictionary;
		/** @private */
		firefly_internal var dynamicItems:Vector.<DynamicTextureItem>;
		
		/** Constructor. */		
		public function DynamicTextureBundle()
		{
			super();
			
			if(singleton == this)
			{
				textureAtlasItems = new Dictionary();
				dynamicItems = new Vector.<DynamicTextureItem>();
			}
		}
		
		/** Padding for texture placement in atlas. */		
		public var padding:int = 2;
		
		/** Size of texture atlases. */		
		public var atlasSize:Number = 2048;

		/** @private */
		private function get dynamicSingleton():DynamicTextureBundle
		{
			return singleton as DynamicTextureBundle;
		}
		
		/** @inheritDoc */
		override public function getTexture(id:*):Texture
		{
			if(singleton != this)
				return dynamicSingleton.getTexture(id);
			
			if(id in textureAtlasItems)
				return (textureAtlasItems[id] as DynamicTextureItem).textureAtlas.getTexture(id);
			
			CONFIG::debug {
				Log.error("Texture atlas {0} is not found.", name);
			};
			
			return super.getTexture(id);
		}
		
		/** @inheritDoc */
		override public function load():Future
		{
			if(singleton != this)
				return singleton.load();
			
			var group:GroupCompleter = new GroupCompleter();
			
			for each (var loader:ITextureLoader in loaders) 
			{
				group.append(thread.schedule(loadInternal, loader));
			}
			
			var completer:Completer = new Completer();
			group.future.then(loadComplete, completer);
			
			return completer.future;
		}
		
		/** @inheritDoc */
		override firefly_internal function createTextureFromBitmapData(id:*, bitmapData:BitmapData):void
		{
			var textureItem:DynamicTextureItem = textureAtlasItems[id];
			if (!textureItem)
			{
				for each (var existedItem:DynamicTextureItem in dynamicItems) 
				{
					// try to pack on existed atlases
					if(existedItem.packData(id, bitmapData))	
					{
						textureAtlasItems[id] = existedItem;
						return;
					}
				}
				
				// create new atlas
				textureItem = new DynamicTextureItem(padding, atlasSize, generateMipMaps);
				textureAtlasItems[id] = textureItem;
				dynamicItems.push(textureItem);
				textureItem.packData(id, bitmapData);
			}
			else
			{
				textureItem.packData(id, bitmapData);
			}
		}
		
		/** @private */		
		private function loadComplete(completer:Completer):void
		{
			for (var i:int = 0; i < dynamicItems.length; i++) 
			{
				var item:DynamicTextureItem = dynamicItems[i];
				item.prepareAtlas();
			}
			
			CONFIG::debug {
				Log.info("Dynamic Texture Bundle composed from {0} atlases.", dynamicItems.length);
			};
			
			completer.complete();
		}	
	}
}