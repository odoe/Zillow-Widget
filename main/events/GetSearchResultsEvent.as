package widgets.Zillow.main.events
{
	import flash.events.Event;
	
	import widgets.Zillow.main.model.vo.ResultsSearch;
	
	public class GetSearchResultsEvent extends Event
	{
		public static const GET_SEARCH_RESULTS:String = "getSearchResults";
		
		private var _criteria:ResultsSearch;
		
		public function get criteria():ResultsSearch
		{
			return _criteria;
		}
		
		public function GetSearchResultsEvent(type:String, criteria:ResultsSearch)
		{
			super(type, true, true);
			_criteria = criteria;
		}
		
		override public function clone():Event
		{
			return new GetSearchResultsEvent(type, criteria);
		}
	}
}