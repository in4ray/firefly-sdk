package com.in4ray.particle.journey.screens
{
	import com.firefly.core.Firefly;
	import com.firefly.core.assets.AssetManager;
	import com.firefly.core.assets.AssetState;
	import com.firefly.core.async.Future;
	import com.firefly.core.textures.helpers.DragonBonesFactory;
	import com.in4ray.particle.journey.textures.CommonTextures;
	import com.in4ray.particle.journey.textures.GameTextures;
	import com.in4ray.particle.journey.textures.MenuTextures;
	
	import flash.utils.setTimeout;
	
	import dragonBones.Armature;
	import dragonBones.animation.WorldClock;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.textures.TextureAtlas;
	
	import textures.CompanyLogo;
	import textures.MenuBackground;

	public class MainScreen extends Sprite
	{
		private var quad:Quad;
		public function MainScreen()
		{
			super();
			
			quad = new Quad(50,50,0xFF0000);
			addChild(quad);
			
			setTimeout(init, 1000);
		}
		
		public function init():void
		{
			var date:Number = new Date().time;
			
			
			/*Starling.current.addEventListener(Event.CONTEXT3D_CREATE, function(e:Event):void {
				trace("Context restore.")
			});*/
			
			
			menuState = new AssetState("menu", new MenuTextures(), new CommonTextures()); 
			gameState = new AssetState("game", new CommonTextures(), new GameTextures()); 
			
			manager = new AssetManager(menuState, gameState);
			
			menuState.load().progress(lll).then(function():void{
				menuState.release();
				manager.switchToState(gameState).progress(lll).then(loaded);
			});
		}
		
		private function loaded():void
		{
				addBkg(MenuBackground, 1);
				
				var im:Image = new Image(new CommonTextures().human);
				im.scaleX = im.scaleY = 0.9;
				im.x = Firefly.current.width * 0.05 +  200;
				im.y = Firefly.current.height * 0.05 +  200;
				addChild(im);
				
				im = new Image(new MenuTextures().tex1);
				im.x = 100;
				im.y = 100;
				addChild(im);
				
				im = new Image(new MenuTextures().tex2);
				im.x = 200;
				im.y = 100;
				addChild(im);
				
				var clip:MovieClip = new MovieClip(new CommonTextures().swftest);
				clip.x = 0;
				clip.y = 200;
				addChild(clip);
				
				im = new Image(new MenuTextures().getTexture(CompanyLogo));
				im.x = 200;
				im.y = 300;
				addChild(im);
				
				var ta:TextureAtlas = new MenuTextures().getTextureAtlas("texAtlas");
				im = new Image(ta.getTexture("hipopotame"));
				im.x = 200;
				im.y = 400;
				addChild(im);
				
				ta = new MenuTextures().getTextureAtlas("atfAtlas");
				im = new Image(ta.getTexture("button_back"));
				im.x = 100;
				im.y = 600;
				addChild(im);
				
				im = new Image(new MenuTextures().fxfAtlas);
				im.x = 100;
				im.y = 500;
				addChild(im);
			
				im = new Image(new MenuTextures().getTexture("atfLeaf"));
				im.scaleX = im.scaleY = 0.9;
				im.x = Firefly.current.width * 0.05 +  200;
				im.y = Firefly.current.height * 0.05 +  200;
				addChild(im);
				
				im = new Image(new GameTextures().companyLogo);
				im.x = 10;
				im.y = 50;
				addChild(im);
				
				createDragonBones(new GameTextures().bones1);
				
				setTimeout(testRelease, 3000);
				setTimeout(loadAgain, 6000);
		}
		
		private var armature:Armature;

		private var menuState:AssetState;
		private var gameState:AssetState;
		private var manager:AssetManager;
		
		private function addBkg(texture:Class, delta:int):void
		{
			var im:Image = new Image(new GameTextures().getTexture(texture));
			im.scaleX = im.scaleY = 0.98;
			im.x = Firefly.current.width * 0.01 +  delta;
			im.y = Firefly.current.height * 0.01 +  delta;
			addChild(im);
		}
		
		private function lll(ratio:Number):void
		{
			//trace(ratio*100 + "%")
			quad.scaleX = 3*ratio + 1;
		}
		
		private function testRelease():void
		{
			manager.switchToState(null);
		}
		
		private function loadAgain():void
		{
			manager.switchToStateName("menu").progress(lll);
		}
		
		private function createDragonBones(factory:DragonBonesFactory):void
		{
			armature = factory.buildArmature("Dragon");
			var armatureClip:Sprite = armature.display as Sprite;
			armatureClip.x = 400;
			armatureClip.y = 400;
			addChild(armatureClip);
			WorldClock.clock.add(armature);
			armature.animation.gotoAndPlay("walk");
			addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrameHandler);
		}
		
		private function onEnterFrameHandler(e:EnterFrameEvent):void
		{
			WorldClock.clock.advanceTime(-1);
		}
	}
}