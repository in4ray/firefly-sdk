package com.in4ray.audio.sound;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.in4ray.audio.AudioExtensionContext;

public class StopSoundFunction implements FREFunction {

	@Override
	public FREObject call(FREContext context, FREObject[] args) {
		try {
			// Get application context
			AudioExtensionContext ac = (AudioExtensionContext) context;
			// Get streadmID returned by the play() function
			int streamID = args[0].getAsInt();
			// Stop sound
			ac.soundPool.stop(streamID);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}

}
