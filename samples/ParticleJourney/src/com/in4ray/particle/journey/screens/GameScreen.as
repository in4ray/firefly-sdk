package com.in4ray.particle.journey.screens
{
	import com.firefly.core.display.IScreen;
	import com.firefly.core.textures.helpers.DragonBonesFactory;
	import com.in4ray.particle.journey.textures.CommonTextures;
	import com.in4ray.particle.journey.textures.GameTextures;
	
	import dragonBones.Armature;
	import dragonBones.animation.WorldClock;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	
	public class GameScreen extends Sprite implements IScreen
	{
		private var factory:DragonBonesFactory;
		private var armature:Armature;
		public function GameScreen()
		{
			super();
			
			addChild(new Image(new CommonTextures().human));
			
			factory = new GameTextures().bones1;
			armature = factory.buildArmature("Dragon");
			var armatureClip:Sprite = armature.display as Sprite;
			armatureClip.x = 200;
			armatureClip.y = 400;
			addChild(armatureClip);
			WorldClock.clock.add(armature);
			armature.animation.gotoAndPlay("walk");
		}
		
		private function onEnterFrameHandler(e:EnterFrameEvent):void
		{
			WorldClock.clock.advanceTime(-1);
		}
		
		public function startShowTransition():void
		{
		}
		
		public function startHideTransition():void
		{
		}
		
		public function show(data:Object):void
		{
			addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrameHandler);
		}
		
		public function hide():void
		{
			removeEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrameHandler);
		}
	}
}