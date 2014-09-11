package com.in4ray.audio.sound;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.in4ray.audio.AudioExtensionContext;

public class LoadSoundFunction implements FREFunction {

	@Override
	public FREObject call(FREContext context, FREObject[] args) {
		FREObject result = null;
		try {
			// Get application context
			AudioExtensionContext ac = (AudioExtensionContext) context;
			// Path to sound file
			String path = args[0].getAsString();
			// Load sound
			int soundID = ac.soundPool.load(path, 1);
			result = FREObject.newObject(soundID);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

}
