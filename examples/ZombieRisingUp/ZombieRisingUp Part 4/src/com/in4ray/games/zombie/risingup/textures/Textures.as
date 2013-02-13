// =================================================================================================
//
//	Zombie: Rising Up
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================
package com.in4ray.games.zombie.risingup.textures
{
	import com.in4ray.gaming.consts.TextureConsts;
	import com.in4ray.gaming.texturers.TextureBundle;
	
	import starling.textures.Texture;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	import textures.BackDownButton;
	import textures.BackUpButton;
	import textures.Blood;
	import textures.CloseDownButton;
	import textures.CloseUpButton;
	import textures.ConfirmDownButton;
	import textures.ConfirmUpButton;
	import textures.ContinueDownButton;
	import textures.ContinueUpButton;
	import textures.CreditsDownButton;
	import textures.CreditsUpButton;
	import textures.ExitDialogBkg;
	import textures.ExitDownRedButton;
	import textures.ExitUpRedButton;
	import textures.FacebookDownButton;
	import textures.FacebookUpButton;
	import textures.GameBackgroundLayer1;
	import textures.GameBackgroundLayer2;
	import textures.GameBackgroundLayer3;
	import textures.GameBackgroundLayer4;
	import textures.GameName;
	import textures.HelpHand;
	import textures.MenuBackground;
	import textures.MenuDownButton;
	import textures.MenuUpButton;
	import textures.MoreDownButton;
	import textures.MoreUpButton;
	import textures.PauseDownButton;
	import textures.PauseUpButton;
	import textures.PlayDownButton;
	import textures.PlayUpButton;
	import textures.RestartDownButton;
	import textures.RestartUpButton;
	import textures.Skull;
	import textures.SoundOffDownButton;
	import textures.SoundOffUpButton;
	import textures.SoundOnDownButton;
	import textures.SoundOnUpButton;
	import textures.Stone;
	import textures.TwitterDownButton;
	import textures.TwitterUpButton;
	import textures.ads.AdChristmasToys;
	import textures.ads.AdChristmasToysLong;
	import textures.ads.AdSqueezeMe;
	import textures.ads.AdSqueezeMeLong;
	import textures.bats.BatBigGray1;
	import textures.bats.BatBigGray2;
	import textures.bats.BatBigGray3;
	import textures.bats.BatBigGray4;
	import textures.bats.BatBigGray5;
	import textures.bats.BatBigGray6;
	import textures.bats.BatBigGray7;
	import textures.bats.BatBigGray8;
	import textures.bats.BatBigLightGray;
	import textures.bats.BatSmallBlack;
	import textures.bats.BatSmallLightGray;
	import textures.clouds.CloudBig;
	import textures.clouds.CloudSmall;
	import textures.crow.CrowGray;
	import textures.crow.CrowLightGray;
	import textures.griph.Griph1;
	import textures.griph.Griph10;
	import textures.griph.Griph11;
	import textures.griph.Griph2;
	import textures.griph.Griph3;
	import textures.griph.Griph4;
	import textures.griph.Griph5;
	import textures.griph.Griph6;
	import textures.griph.Griph7;
	import textures.griph.Griph8;
	import textures.griph.Griph9;
	import textures.owl.Owl1;
	import textures.owl.Owl2;
	import textures.zombies.ZombieBlack;
	import textures.zombies.ZombieBride;
	import textures.zombies.ZombieMexican;
	import textures.zombies.ZombieRed;
	import textures.zombies.ZombieViolet;
	import textures.zombies.ZombieWhite;
	
	public class Textures extends TextureBundle
	{
		public function Textures()
		{
			super();
			
			composerWidth = TextureConsts.MAX_WIDTH;
			composerHeight = TextureConsts.MAX_HEIGHT;
		}
		
		override protected function registerTextures():void
		{
			registerTexture(PlayUpButton);
			registerTexture(PlayDownButton);
			registerTexture(MenuUpButton);
			registerTexture(MenuDownButton);
			registerTexture(ContinueUpButton);
			registerTexture(ContinueDownButton);
			registerTexture(BackUpButton);
			registerTexture(BackDownButton);
			registerTexture(CloseUpButton);
			registerTexture(CloseDownButton);
			registerTexture(TwitterUpButton);
			registerTexture(TwitterDownButton);
			registerTexture(FacebookUpButton);
			registerTexture(FacebookDownButton);
			registerTexture(CreditsUpButton);
			registerTexture(CreditsDownButton);
			registerTexture(MoreUpButton);
			registerTexture(MoreDownButton);
			registerTexture(SoundOnUpButton);
			registerTexture(SoundOnDownButton);
			registerTexture(SoundOffUpButton);
			registerTexture(SoundOffDownButton);
			
			registerTexture(RestartUpButton);
			registerTexture(RestartDownButton);
			registerTexture(PauseUpButton);
			registerTexture(PauseDownButton);
			registerTexture(ExitUpRedButton);
			registerTexture(ExitDownRedButton);
			registerTexture(ConfirmUpButton);
			registerTexture(ConfirmDownButton);
			registerTexture(ExitDialogBkg);
			
			registerTexture(Skull);
			registerTexture(HelpHand);
			
			registerTexture(AdChristmasToys);
			registerTexture(AdChristmasToysLong);
			registerTexture(AdSqueezeMe);
			registerTexture(AdSqueezeMeLong);
			
			registerTexture(GameName);
			registerTexture(MenuBackground, HAlign.CENTER, VAlign.BOTTOM);
			registerTexture(GameBackgroundLayer1, HAlign.CENTER, VAlign.BOTTOM);
			registerTexture(GameBackgroundLayer2, HAlign.CENTER, VAlign.BOTTOM);
			registerTexture(GameBackgroundLayer3, HAlign.CENTER, VAlign.BOTTOM);
			registerTexture(GameBackgroundLayer4, HAlign.CENTER, VAlign.BOTTOM);
			registerTexture(Stone);
			registerTexture(Blood);
			
			registerTexture(CloudBig);
			registerTexture(CloudSmall);
			
			registerTexture(ZombieBlack);
			registerTexture(ZombieRed);
			registerTexture(ZombieWhite);
			registerTexture(ZombieViolet);
			registerTexture(ZombieMexican);
			registerTexture(ZombieBride);
			
			registerTexture(BatBigGray1);
			registerTexture(BatBigGray2);
			registerTexture(BatBigGray3);
			registerTexture(BatBigGray4);
			registerTexture(BatBigGray5);
			registerTexture(BatBigGray6);
			registerTexture(BatBigGray7);
			registerTexture(BatBigGray8);
			registerTexture(BatSmallBlack);
			registerTexture(BatSmallLightGray);
			registerTexture(BatBigLightGray);
			
			registerTexture(Owl1);
			registerTexture(Owl2);
			
			registerTexture(CrowGray);
			registerTexture(CrowLightGray);
			
			registerTexture(Griph1);
			registerTexture(Griph2);
			registerTexture(Griph3);
			registerTexture(Griph4);
			registerTexture(Griph5);
			registerTexture(Griph6);
			registerTexture(Griph7);
			registerTexture(Griph8);
			registerTexture(Griph9);
			registerTexture(Griph10);
			registerTexture(Griph11);
		}
		
		public function get playUpButton():Texture
		{
			return getTexture(PlayUpButton);
		}
		
		public function get playDownButton():Texture
		{
			return getTexture(PlayDownButton);
		}
		
		public function get menuUpButton():Texture
		{
			return getTexture(MenuUpButton);
		}
		
		public function get menuDownButton():Texture
		{
			return getTexture(MenuDownButton);
		}
		
		public function get continueUpButton():Texture
		{
			return getTexture(ContinueUpButton);
		}
		
		public function get continueDownButton():Texture
		{
			return getTexture(ContinueDownButton);
		}
		
		public function get backUpButton():Texture
		{
			return getTexture(BackUpButton);
		}
		
		public function get backDownButton():Texture
		{
			return getTexture(BackDownButton);
		}
		
		public function get closeUpButton():Texture
		{
			return getTexture(CloseUpButton);
		}
		
		public function get closeDownButton():Texture
		{
			return getTexture(CloseDownButton);
		}
		
		public function get twitterUpButton():Texture
		{
			return getTexture(TwitterUpButton);
		}
		
		public function get twitterDownButton():Texture
		{
			return getTexture(TwitterDownButton);
		}
		
		public function get facebookUpButton():Texture
		{
			return getTexture(FacebookUpButton);
		}
		
		public function get facebookDownButton():Texture
		{
			return getTexture(FacebookDownButton);
		}
		
		public function get creditsUpButton():Texture
		{
			return getTexture(CreditsUpButton);
		}
		
		public function get creditsDownButton():Texture
		{
			return getTexture(CreditsDownButton);
		}
		
		public function get moreUpButton():Texture
		{
			return getTexture(MoreUpButton);
		}
		
		public function get moreDownButton():Texture
		{
			return getTexture(MoreDownButton);
		}
		
		public function get soundOnUpButton():Texture
		{
			return getTexture(SoundOnUpButton);
		}
		
		public function get soundOnDownButton():Texture
		{
			return getTexture(SoundOnDownButton);
		}
		
		public function get soundOffUpButton():Texture
		{
			return getTexture(SoundOffUpButton);
		}
		
		public function get soundOffDownButton():Texture
		{
			return getTexture(SoundOffDownButton);
		}
		
		public function get restartUpButton():Texture
		{
			return getTexture(RestartUpButton);
		}
		
		public function get restartDownButton():Texture
		{
			return getTexture(RestartDownButton);
		}
		
		public function get pauseUpButton():Texture
		{
			return getTexture(PauseUpButton);
		}
		
		public function get pauseDownButton():Texture
		{
			return getTexture(PauseDownButton);
		}
		
		public function get exitDialog():Texture
		{
			return getTexture(ExitDialogBkg);
		}
		
		public function get confirmUpButton():Texture
		{
			return getTexture(ConfirmUpButton);
		}
		
		public function get confirmDownButton():Texture
		{
			return getTexture(ConfirmDownButton);
		}
		
		public function get exitUpRedButton():Texture
		{
			return getTexture(ExitUpRedButton);
		}
		
		public function get exitDownRedButton():Texture
		{
			return getTexture(ExitDownRedButton);
		}
		
		public function get skull():Texture
		{
			return getTexture(Skull);
		}
		
		public function get helpHand():Texture
		{
			return getTexture(HelpHand);
		}
		
		public function get adChristmasToys():Texture
		{
			return getTexture(AdChristmasToys);
		}
		
		public function get adChristmasToysLong():Texture
		{
			return getTexture(AdChristmasToysLong);
		}
		
		public function get adSqueezeMe():Texture
		{
			return getTexture(AdSqueezeMe);
		}
		
		public function get adSqueezeMeLong():Texture
		{
			return getTexture(AdSqueezeMeLong);
		}
		
		public function get gameName():Texture
		{
			return getTexture(GameName);
		}
		
		public function get menuBackground():Texture
		{
			return getTexture(MenuBackground);
		}
		
		public function get gameBackgroundLayer1():Texture
		{
			return getTexture(GameBackgroundLayer1);
		}
		
		public function get gameBackgroundLayer2():Texture
		{
			return getTexture(GameBackgroundLayer2);
		}
		
		public function get gameBackgroundLayer3():Texture
		{
			return getTexture(GameBackgroundLayer3);
		}
		
		public function get gameBackgroundLayer4():Texture
		{
			return getTexture(GameBackgroundLayer4);
		}
		
		public function get stone():Texture
		{
			return getTexture(Stone);
		}
		
		public function get blood():Texture
		{
			return getTexture(Blood);
		}
		
		public function get cloudBig():Texture
		{
			return getTexture(CloudBig);
		}
		
		public function get cloudSmall():Texture
		{
			return getTexture(CloudSmall);
		}
		
		public function get zombieBlack():Texture
		{
			return getTexture(ZombieBlack);
		}
		
		public function get zombieRed():Texture
		{
			return getTexture(ZombieRed);
		}
		
		public function get zombieWhite():Texture
		{
			return getTexture(ZombieWhite);
		}
		
		public function get zombieViolet():Texture
		{
			return getTexture(ZombieViolet);
		}
		
		public function get zombieMexican():Texture
		{
			return getTexture(ZombieMexican);
		}
		
		public function get zombieBride():Texture
		{
			return getTexture(ZombieBride);
		}
		
		public function get batSmallBlack():Texture
		{
			return getTexture(BatSmallBlack);
		}
		
		public function get batBigGray():Vector.<Texture>
		{
			var vector:Vector.<Texture> = new Vector.<Texture>();
			vector.push(getTexture(BatBigGray1));
			vector.push(getTexture(BatBigGray2));
			vector.push(getTexture(BatBigGray3));
			vector.push(getTexture(BatBigGray4));
			vector.push(getTexture(BatBigGray5));
			vector.push(getTexture(BatBigGray6));
			vector.push(getTexture(BatBigGray7));
			vector.push(getTexture(BatBigGray8));
			vector.push(getTexture(BatBigGray1));
			
			return vector;
		}
		
		public function get batSmallLightGray():Texture
		{
			return getTexture(BatSmallLightGray);
		}
		
		public function get batBigLightGray():Texture
		{
			return getTexture(BatBigLightGray);
		}
		
		public function get crowGray():Texture
		{
			return getTexture(CrowGray);
		}
		
		public function get crowLightGray():Texture
		{
			return getTexture(CrowLightGray);
		}
		
		public function get owl():Vector.<Texture>
		{
			var vector:Vector.<Texture> = new Vector.<Texture>();
			vector.push(getTexture(Owl1));
			vector.push(getTexture(Owl2));
			vector.push(getTexture(Owl1));
			
			return vector;
		}
		
		public function get griph():Vector.<Texture>
		{
			var vector:Vector.<Texture> = new Vector.<Texture>();
			vector.push(getTexture(Griph1));
			vector.push(getTexture(Griph2));
			vector.push(getTexture(Griph3));
			vector.push(getTexture(Griph4));
			vector.push(getTexture(Griph5));
			vector.push(getTexture(Griph6));
			vector.push(getTexture(Griph7));
			vector.push(getTexture(Griph8));
			vector.push(getTexture(Griph9));
			vector.push(getTexture(Griph10));
			vector.push(getTexture(Griph1));
			vector.push(getTexture(Griph11));
			
			return vector;
		}
	}
}