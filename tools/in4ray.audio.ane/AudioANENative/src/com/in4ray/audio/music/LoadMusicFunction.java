package com.in4ray.audio.music;

import java.io.File;
import java.io.FileDescriptor;
import java.io.FileInputStream;

import android.media.AudioManager;
import android.media.MediaPlayer;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.in4ray.audio.AudioExtensionContext;

public class LoadMusicFunction implements FREFunction {

	@Override
	public FREObject call(FREContext context, FREObject[] args) {
		FREObject result = null;
		try {
			// Get application context
			AudioExtensionContext ac = (AudioExtensionContext) context;
			// Get media player ID
			int mediaID = args[0].getAsInt();
			// Path to sound file
			String path = args[1].getAsString();
			// Get file descriptor from path
			File file = new File(path);
			FileInputStream inputStream = new FileInputStream(file);
			FileDescriptor fd = inputStream.getFD();
			// Prepare media player
			MediaPlayer mp = new MediaPlayer();
			mp.setAudioStreamType(AudioManager.STREAM_MUSIC);
			mp.setDataSource(fd);
			// Store media player instance into hash map by mediaID 
			ac.mediaPlayerMap.put(mediaID, mp);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

}
