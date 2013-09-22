package com.firefly.core.textures.atlases
{
	import com.firefly.core.textures.loaders.SWFLoader;

	[ExcludeClass]
	/** The loader that loads SWF asset for creation texture atlas based on bitmap data. */
	public class AtlasSWFLoader extends AtlasLoader
	{
		/** Constructor.
		 * 
		 *  @param id Unique identifier.
		 *  @param paths List of .swf source path.
		 * 	@param xmlPath Path to the xml file.
		 *  @param autoScale Specifies whether use autoscale algorithm. Based on design size and stage size texture will be 
		 * 		   proportionally scale to stage size. E.g. design size is 1024x768 and stage size is 800x600 the formula is
		 * 		   <code>var scale:Number = Math.min(1024/800, 768/600);</code></br> 
		 * 		   Calculated scale is 1.28, all bitmaps and described textures in xml scale based on it. 
		 *  @param checkPolicyFile Specifies whether the application should attempt to download a URL 
		 * 		   policy file from the loaded object's server before beginning to load the object itself. */
		public function AtlasSWFLoader(id:String, paths:Array, xmlPath:String, autoScale:Boolean = true, checkPolicyFile:Boolean = false)
		{
			var loaders:Array = [];
			for each (var path:String in paths) 
			{
				loaders.push(new SWFLoader(path.split("/").pop().split(".")[0], path, autoScale, false, "", "", checkPolicyFile));
			}
			
			super(id, loaders, xmlPath, autoScale);
		}
	}
}