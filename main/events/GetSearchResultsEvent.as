package widgets.Zillow.main.events
{
	import flash.events.Event;
	
	import widgets.Zillow.main.model.vo.GetSearchResults;
	
	public class GetSearchResultsEvent extends Event
	{
		public static const GET_SEARCH_RESULTS:String = "getSearchResults";
		
		private var _criteria:GetSearchResults;
		
		public function get criteria():GetSearchResults
		{
			return _criteria;
		}
		
		public function GetSearchResultsEvent(type:String, criteria:GetSearchResults)
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