package me.imcj.as3object
{
	import flash.events.Event;
	
	public class AsyncRepositoryEvent extends Event
	{
		static public const READY : String = "ready";
		
		public function AsyncRepositoryEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}