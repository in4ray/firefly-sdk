package test.model
{
	import flash.events.EventDispatcher;
	
	import org.flexunit.Assert;
	
	import test.model.helpers.GameModel;
	
	public class ModelTest extends EventDispatcher
	{
		private var _model:GameModel;
		
		public function ModelTest()
		{
			super();
		}
		
		[Before]
		public function prepareModel() : void 
		{
			_model = new GameModel("MyObj");
			_model.clear();
		}
		
		[Test]
		public function initModel() : void 
		{
			Assert.assertTrue(_model.prop = "value");	
		}
		
		[Test]
		public function saveAndLoadModel() : void 
		{
			_model.prop = "newVal";
			_model.save();
			_model.prop = "value";
			_model.load();
			
			Assert.assertTrue(_model.prop = "newVal");	
				
		}
	}
}