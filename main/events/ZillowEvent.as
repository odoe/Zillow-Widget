package widgets.Zillow.main.events
{
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	import widgets.Zillow.main.vo.ZillowPosting;
	
	public class ZillowEvent extends Event
	{
		public static const POSTINGS_READY:String = "postingsReady";
		
		private var _zillowPostings:ZillowPosting;
		
		public function get zillowPostings():ZillowPosting
		{
			return _zillowPostings;
		}
		
		public function ZillowEvent(type:String, postings:ZillowPosting)
		{
			super(type, true, true);
			_zillowPostings = postings;
		}
		
		override public function clone():Event
		{
			return new ZillowEvent(type, zillowPostings);
		}
	}
}