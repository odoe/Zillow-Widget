package widgets.Zillow.main.events
{
	import flash.events.Event;
	
	import widgets.Zillow.main.model.vo.ZillowPosting;
	public class ZillowEvent extends Event
	{
		public static const POSTINGS_READY:String = "postingsReady";
        public static const POSTINGS_UPDATED:String = "postingsUpdated";
		
		public function ZillowEvent(type:String, postings:ZillowPosting)
		{
			super(type, true, true);
			_zillowPostings = postings;
		}
		private var _zillowPostings:ZillowPosting;
		
		public function get zillowPostings():ZillowPosting
		{
			return _zillowPostings;
		}
		
		override public function clone():Event
		{
			return new ZillowEvent(type, zillowPostings);
		}
	}
}