package com.in4ray.particle.journey.screens
{
	import com.firefly.core.Firefly;
	import com.firefly.core.assets.AssetManager;
	import com.firefly.core.assets.AssetState;
	import com.firefly.core.async.Future;
	import com.firefly.core.layouts.Layout;
	import com.firefly.core.layouts.constraints.$bottom;
	import com.firefly.core.layouts.constraints.$hCenter;
	import com.firefly.core.layouts.constraints.$height;
	import com.firefly.core.layouts.constraints.$left;
	import com.firefly.core.layouts.constraints.$right;
	import com.firefly.core.layouts.constraints.$top;
	import com.firefly.core.layouts.constraints.$vCenter;
	import com.firefly.core.layouts.constraints.$width;
	import com.firefly.core.layouts.constraints.$x;
	import com.firefly.core.layouts.constraints.$y;
	import com.firefly.core.textures.helpers.DragonBonesFactory;
	import com.in4ray.particle.journey.audio.GameAudioBundle;
	import com.in4ray.particle.journey.textures.CommonTextures;
	import com.in4ray.particle.journey.textures.GameTextures;
	import com.in4ray.particle.journey.textures.MenuTextures;
	
	import flash.events.Event;
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
			
			Firefly.current.main.addEventListener(flash.events.Event.ACTIVATE, onActivate);
		}
		
		override public function get height():Number
		{
			return Firefly.current.stageHeight;
		}
		
		override public function get width():Number
		{
			return Firefly.current.stageWidth;
		}
		
		protected function onActivate(event:flash.events.Event):void
		{
			manager.loadCurrentState();
		}
		
		public function init():void
		{
			var date:Number = new Date().time;
			
			
			menuState = new AssetState("menu", new MenuTextures(), new CommonTextures(), new GameAudioBundle()); 
			gameState = new AssetState("game", new CommonTextures(), new GameTextures(), new GameAudioBundle()); 
			
			manager = new AssetManager(menuState, gameState);
			
			menuState.load().progress(lll).then(function():void{
				menuState.release();
				manager.switchToState(gameState).progress(lll).then(loaded);
			});
			
			Starling.current.stage3D.addEventListener(flash.events.Event.CONTEXT3D_CREATE, contextCreateHandler, false, 0, true);
		}
		
		
		
		protected function contextCreateHandler(event:flash.events.Event):void
		{
			manager.loadCurrentState();
		}
		
		private function loaded():void
		{
			new GameAudioBundle().menuMusic.play(1000);
			 
			Firefly.current.audioMixer.fadeMusic(0.2, 2);
			
			addBkg(MenuBackground, 1);
			
			
			var layout:Layout = new Layout(this);
				
			var im:Image = new Image(new CommonTextures().human);
			layout.addElement(im, $vCenter(0), $hCenter(0), $height(40));
		}
		
		private var armature:Armature;

		private var menuState:AssetState;
		private var gameState:AssetState;
		private var manager:AssetManager;
		
		private function addBkg(texture:Class, delta:int):void
		{
			var im:Image = new Image(new GameTextures().getTexture(texture));
		/*	im.scaleX = im.scaleY = 0.98;
			im.x = Firefly.current.stageWidth * 0.01 +  delta;
			im.y = Firefly.current.stageHeight * 0.01 +  delta;*/
			addChild(im);
		}
		
		private function lll(ratio:Number):void
		{
			//trace(ratio*100 + "%")
			quad.scaleX = 3*ratio + 1;
		}
		
		private function testRelease():void
		{
			manager.releaseCurrentState();
		}
		
		private function loadAgain():void
		{
			manager.loadCurrentState().progress(lll);
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