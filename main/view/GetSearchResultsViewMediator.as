package widgets.Zillow.main.view
{
	import org.robotlegs.mvcs.Mediator;
	
	import widgets.Zillow.main.events.GetSearchResultsEvent;
	import widgets.Zillow.main.view.ui.GetSearchResultsView;
	
	public class GetSearchResultsViewMediator extends Mediator
	{
		[Inject]
		public var view:GetSearchResultsView;
		
		override public function onRegister():void
		{
			//trace("ResultSearchViewMediator registered");
			eventMap.mapListener(view, GetSearchResultsEvent.GET_SEARCH_RESULTS, onSearchForResult);
		}
		
		override public function onRemove():void
		{
			//trace("ResultSearchViewMediator removed");
			eventMap.unmapListener(view, GetSearchResultsEvent.GET_SEARCH_RESULTS, onSearchForResult);
		}
		
		protected function onSearchForResult(event:GetSearchResultsEvent):void
		{
			//trace("send search for get results");
			dispatch(event);
		}
	}
}