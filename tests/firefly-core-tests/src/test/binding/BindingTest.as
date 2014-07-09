package test.binding
{
	import flash.events.EventDispatcher;
	
	import flexunit.framework.Assert;
	
	import test.model.helpers.GameModel;
	
	public class BindingTest extends EventDispatcher
	{
		private var _model:GameModel;
		
		public function BindingTest()
		{
			super();
		}
		
		[Before]
		public function prepareBinding() : void 
		{
			_model = new GameModel("MyObj2");
		}
		
		[Test]
		public function bindTest():void 
		{
			_model.onProp.bind(onPropChanged);
			_model.prop = "newStr";
			
			Assert.assertTrue(_model.prop == _model.prop2);	
		}	
		
		[Test]
		public function unbindTest():void 
		{
			_model.onProp.bind(onPropChanged);
			_model.onProp.unbind(onPropChanged);
			_model.prop = "newStr1";
			
			Assert.assertFalse(_model.prop == _model.prop2);	
		}
		
		[Test]
		public function bindWeakTest():void 
		{
			_model.onProp.bindWeak(this, onPropChanged);
			_model.prop = "newSt2";
			
			Assert.assertTrue(_model.prop == _model.prop2);	
		}
		
		[Test]
		public function unbindWeakTest():void 
		{
			_model.onProp.unbindWeak(this, onPropChanged);
			_model.prop = "newStr3";
			
			Assert.assertFalse(_model.prop == _model.prop2);	
		}
		
		public function onPropChanged(v:String):void
		{
			_model.prop2 = v;
		}
	}
}