package com.in4ray.audio;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;

public class AudioExtension implements FREExtension {

	@Override
	public FREContext createContext(String arg0) {
		return new AudioExtensionContext();
	}

	@Override
	public void dispose() {
		// TODO Auto-generated method stub

	}

	@Override
	public void initialize() {
		// TODO Auto-generated method stub

	}

}
