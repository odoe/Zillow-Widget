package widgets.Zillow.main.events
{
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	public class ZillowEvent extends Event
	{
		public static const POSTINGS_READY:String = "postingsReady";
		
		private var _results:ArrayCollection;
		
		public function get results():ArrayCollection
		{
			return _results;
		}
		
		public function ZillowEvent(type:String, results:ArrayCollection)
		{
			super(type, true, true);
			_results = results;
		}
		
		override public function clone():Event
		{
			return new ZillowEvent(type, results);
		}
	}
}