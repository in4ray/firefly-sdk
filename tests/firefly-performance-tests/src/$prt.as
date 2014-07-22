package {
	import com.firefly.core.utils.SingletonLocator;
	
	
	public function get $prt():ParticleBundle
	{
		return SingletonLocator.getInstance(ParticleBundle);
	}
}