package widgets.Zillow.main.events
{
	import flash.events.Event;
	
	import widgets.Zillow.main.model.vo.PostingsSearch;
	public class SearchPostingsEvent extends Event
	{
		public static const POSTINGS_SEARCH:String = "postingsSearch";
		
		public function SearchPostingsEvent(type:String, criteria:PostingsSearch)
		{
			super(type, true, true);
			_criteria = criteria;
		}
		private var _criteria:PostingsSearch
		
		public function get criteria():PostingsSearch
		{
			return _criteria;
		}
		
		override public function clone():Event
		{
			return new SearchPostingsEvent(type, criteria);
		}
	}
}