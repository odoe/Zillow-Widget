package widgets.Zillow.main.events
{
	import flash.events.Event;
	public class ZillowIdEvent extends Event
	{
		public static const ZILLOW_ID_READY:String = "zillowIdReady";
		
		public function ZillowIdEvent(type:String, zwsid:String)
		{
			super(type, true, true);
			_zwsid = zwsid;
		}
		private var _zwsid:String;
		
		public function get zwsid():String
		{
			return _zwsid;
		}
		
		override public  function clone():Event
		{
			return new ZillowIdEvent(type, zwsid);
		}
	}
}