package widgets.Zillow.main.events
{
	import flash.events.Event;
	
	import mx.collections.XMLListCollection;
	public class ReturnedSearchResultsEvent extends Event
	{
		public static const SEARCH_RESULTS_RETURNED:String = "searchResultsReturned";
		
		public function ReturnedSearchResultsEvent(type:String, xmlCollection:XMLListCollection)
		{
			super(type, true, true);
			_xmlCollection = xmlCollection;
		}
        
		private var _xmlCollection:XMLListCollection;
		
		public function get xmlCollection():XMLListCollection
		{
			return _xmlCollection;
		}
		
		override public function clone():Event
		{
			return new ReturnedSearchResultsEvent(ReturnedSearchResultsEvent.SEARCH_RESULTS_RETURNED, xmlCollection);
		}
	}
}