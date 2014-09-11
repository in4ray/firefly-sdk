package com.in4ray.audio.music;

import android.content.Context;
import android.media.AudioManager;
import android.media.MediaPlayer;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.in4ray.audio.AudioExtensionContext;

public class PlayMusicFunction implements FREFunction {

	@Override
	public FREObject call(FREContext context, FREObject[] args) {
		FREObject result = null;
		try {
			// Get application context
			AudioExtensionContext ac = (AudioExtensionContext) context;
			// Get media player ID
			int mediaID = args[0].getAsInt();
			// Get volume factor (min=0.0 max=1.0) 
			float volumeFactor = (float)args[1].getAsDouble();
			// Get loop value
			boolean loop = args[2].getAsBool();

			// Getting the user sound settings
			AudioManager audioManager = (AudioManager) ac.getActivity().getSystemService(Context.AUDIO_SERVICE);
			float actualVolume = (float) audioManager.getStreamVolume(AudioManager.STREAM_MUSIC);
			float maxVolume = (float) audioManager.getStreamMaxVolume(AudioManager.STREAM_MUSIC);
			float volume = actualVolume / maxVolume * volumeFactor;
			
			// Starts or resumes playback
			MediaPlayer mp = ac.mediaPlayerMap.get(mediaID);
			mp.setVolume(volume, volume);
			mp.setLooping(loop);
			mp.prepare();
			mp.seekTo(0);
			mp.start();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

}
