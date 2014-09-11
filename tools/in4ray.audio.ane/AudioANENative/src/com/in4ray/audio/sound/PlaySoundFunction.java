package com.in4ray.audio.sound;

import android.content.Context;
import android.media.AudioManager;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.in4ray.audio.AudioExtensionContext;

public class PlaySoundFunction implements FREFunction {

	@Override
	public FREObject call(FREContext context, FREObject[] args) {
		FREObject result = null;
		try {
			// Get application context
			AudioExtensionContext ac = (AudioExtensionContext) context;
			// Get soundId. This is the value returned by the load() function.
			int soundId = args[0].getAsInt();
			// Get volume factor (min=0.0 max=1.0) 
			float volumeFactor = (float)args[1].getAsDouble();
			// Get stream priority 
			int priority = args[2].getAsInt();
			// Get loop value. A loop value of -1 means loop forever, a value of 0 means
			// don't loop, other values indicate the number of repeats 
			int loop = args[3].getAsInt();
			// Get playback rate. The playback rate allows the application to vary
			// the playback rate (pitch) of the sound.
			float rate = (float)args[4].getAsDouble();

			// Getting the user sound settings
			AudioManager audioManager = (AudioManager) ac.getActivity().getSystemService(Context.AUDIO_SERVICE);
			float actualVolume = (float) audioManager.getStreamVolume(AudioManager.STREAM_MUSIC);
			float maxVolume = (float) audioManager.getStreamMaxVolume(AudioManager.STREAM_MUSIC);
			float volume = actualVolume / maxVolume * volumeFactor;
			
			// Play sound
			int streamID;
			streamID = ac.soundPool.play(soundId, volume, volume, priority, loop, rate);
			result = FREObject.newObject(streamID);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

}
