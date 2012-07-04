package me.imcj.as3object
{
	import flash.events.Event;
	
	public class ObjectEvent extends Event
	{
		static public const SOURCE_OPEN : String = "open";
		static public const RESULT : String = "result";
		
		private var _result:Object;
		
		public function ObjectEvent(type:String, result : Object, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			_result = result;
			super(type, bubbles, cancelable);
		}

		public function get result():Object
		{
			return _result;
		}

	}
}