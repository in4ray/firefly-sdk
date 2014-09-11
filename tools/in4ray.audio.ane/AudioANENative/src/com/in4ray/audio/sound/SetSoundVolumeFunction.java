package com.in4ray.audio.sound;

import android.content.Context;
import android.media.AudioManager;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.in4ray.audio.AudioExtensionContext;

public class SetSoundVolumeFunction implements FREFunction {

	@Override
	public FREObject call(FREContext context, FREObject[] args) {
		try {
			// Get application context
			AudioExtensionContext ac = (AudioExtensionContext) context;
			// Get streadmID returned by the play() function
			int streamID = args[0].getAsInt();
			// Get volume factor (min=0.0 max=1.0) 
			float volumeFactor = (float)args[1].getAsDouble();
			
			// Getting the user sound settings
			AudioManager audioManager = (AudioManager) ac.getActivity().getSystemService(Context.AUDIO_SERVICE);
			float actualVolume = (float) audioManager.getStreamVolume(AudioManager.STREAM_MUSIC);
			float maxVolume = (float) audioManager.getStreamMaxVolume(AudioManager.STREAM_MUSIC);
			float volume = actualVolume / maxVolume * volumeFactor;
			
			// Stop sound
			ac.soundPool.setVolume(streamID, volume, volume);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}

}
