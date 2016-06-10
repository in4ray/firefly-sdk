package com.firefly.core.assets
{
	import com.firefly.core.firefly_internal;
	import com.firefly.core.utils.SingletonLocator;
	
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	
	import avmplus.getQualifiedClassName;
	
	import starling.textures.Texture;
	
	use namespace firefly_internal;
	
	public class StatefulTextureBundle extends StatefulBundle
	{
		/** @private */
		firefly_internal var _textures:Dictionary;
		/** @private */
		firefly_internal var _textureLists:Dictionary;
		/** @private */
		firefly_internal var _dbFactories:Dictionary;
		/** @private */
		firefly_internal var _textureAtlases:Dictionary;
		
		public function StatefulTextureBundle()
		{
			_name = getQualifiedClassName(this);
			_singleton = SingletonLocator.getInstance(getDefinitionByName(_name) as Class, this);
			
			if(_singleton == this)
			{
				_textures = new Dictionary();
				_dbFactories = new Dictionary();
				_textureLists = new Dictionary();
				_textureAtlases = new Dictionary();
			}
			
			super();
		}
		
		override protected function regState(state:String, bundle:IAssetBundle):void
		{
			if(_singleton != this)
				return (_singleton as StatefulTextureBundle).regState(state, bundle);
			
			super.regState(state, bundle);
			
			(bundle as TextureBundle)._textures = _textures;
			(bundle as TextureBundle)._textureLists = _textureLists;
			(bundle as TextureBundle)._dbFactories = _dbFactories;
			(bundle as TextureBundle)._textureAtlases = _textureAtlases;
		}
		
		public function getTexture(id:String):Texture
		{
			if(_singleton != this)
				return (_singleton as StatefulTextureBundle).getTexture(id);
			
			return _bundles[currentState].getTexture(id);
		}
	}
}