package com.in4ray.audio;

import java.util.HashMap;
import java.util.Map;

import android.media.MediaPlayer;
import android.media.SoundPool;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.in4ray.audio.music.IsMusicPlayingFunction;
import com.in4ray.audio.music.LoadMusicFunction;
import com.in4ray.audio.music.PlayMusicFunction;
import com.in4ray.audio.music.SetMusicVolumeFunction;
import com.in4ray.audio.music.StopMusicFunction;
import com.in4ray.audio.music.UnloadMusicFunction;
import com.in4ray.audio.sound.LoadSoundFunction;
import com.in4ray.audio.sound.PauseSoundFunction;
import com.in4ray.audio.sound.PlaySoundFunction;
import com.in4ray.audio.sound.SetSoundVolumeFunction;
import com.in4ray.audio.sound.StopSoundFunction;
import com.in4ray.audio.sound.UnloadSoundFunction;

public class AudioExtensionContext extends FREContext {

	// Reference to the sound pool
	public SoundPool soundPool = null;
	public HashMap<Integer, MediaPlayer> mediaPlayerMap = null;
	
	@Override
	public void dispose() {
		// TODO Auto-generated method stub

	}

	@Override
	public Map<String, FREFunction> getFunctions() {
		Map<String, FREFunction> functionMap = new HashMap<String, FREFunction>();
		
		functionMap.put("init", new AudioInitFunction());
		functionMap.put("loadSound", new LoadSoundFunction());
		functionMap.put("unloadSound", new UnloadSoundFunction()); 
		functionMap.put("playSound", new PlaySoundFunction());
		functionMap.put("stopSound", new StopSoundFunction());
		functionMap.put("pauseSound", new PauseSoundFunction());
		functionMap.put("setSoundVolume", new SetSoundVolumeFunction());
		
		functionMap.put("loadMusic", new LoadMusicFunction());
		functionMap.put("unloadMusic", new UnloadMusicFunction());
		functionMap.put("playMusic", new PlayMusicFunction());
		functionMap.put("stopMusic", new StopMusicFunction());
		functionMap.put("setMusicVolume", new SetMusicVolumeFunction());
		functionMap.put("isMusicPlaying", new IsMusicPlayingFunction());
		
		return functionMap;
	}

}
