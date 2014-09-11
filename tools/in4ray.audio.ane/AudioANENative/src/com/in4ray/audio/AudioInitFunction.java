package com.in4ray.audio;

import java.util.HashMap;

import android.media.AudioManager;
import android.media.MediaPlayer;
import android.media.SoundPool;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;

public class AudioInitFunction implements FREFunction {

	@Override
	public FREObject call(FREContext context, FREObject[] args) {
		try {
			// Get application context
			AudioExtensionContext ac = (AudioExtensionContext) context;
			// Get maximum number of simultaneous streams for this SoundPool object.
			int maxStreams = args[0].getAsInt();
			// Initialize sound pool with max streams
			SoundPool soundPool = new SoundPool(maxStreams, AudioManager.STREAM_MUSIC, 0);
			ac.soundPool = soundPool;
			// Initialize media player hash table
			ac.mediaPlayerMap = new HashMap<Integer, MediaPlayer>();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

}
