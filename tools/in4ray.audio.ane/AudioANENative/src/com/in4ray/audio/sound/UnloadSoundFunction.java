package com.in4ray.audio.sound;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.in4ray.audio.AudioExtensionContext;

public class UnloadSoundFunction implements FREFunction {

	@Override
	public FREObject call(FREContext context, FREObject[] args) {
		FREObject result = null;
		try {
			// Get application context
			AudioExtensionContext ac = (AudioExtensionContext) context;
			// Get soundId
			int soundId = args[0].getAsInt();
			// Unload sound
			boolean unloaded;
			unloaded = ac.soundPool.unload(soundId);
			result = FREObject.newObject(unloaded);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

}
