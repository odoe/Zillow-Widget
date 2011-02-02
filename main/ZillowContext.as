package widgets.Zillow.main
{
	import flash.display.DisplayObjectContainer;
	
	import org.robotlegs.mvcs.Context;
	
	import widgets.Zillow.main.command.GetSearchResultsCommand;
	import widgets.Zillow.main.command.SearchPostingsCommand;
	import widgets.Zillow.main.command.ZillowUpdateCommand;
	import widgets.Zillow.main.events.GetSearchResultsEvent;
	import widgets.Zillow.main.events.SearchPostingsEvent;
	import widgets.Zillow.main.events.ZillowEvent;
	import widgets.Zillow.main.model.ZillowModel;
	import widgets.Zillow.main.service.IService;
	import widgets.Zillow.main.service.ZillowService;
	import widgets.Zillow.main.view.GetSearchResultsViewMediator;
	import widgets.Zillow.main.view.PostingSearchViewMediator;
	import widgets.Zillow.main.view.ViewManagerMediator;
	import widgets.Zillow.main.view.ui.GetSearchResultsView;
	import widgets.Zillow.main.view.ui.PostingSearchView;
	import widgets.Zillow.main.view.ui.ViewManager;

	public class ZillowContext extends Context
	{
		public function ZillowContext(contextView:DisplayObjectContainer=null, autoStartup:Boolean=true)
		{
			super(contextView, autoStartup);
		}
		
		override public  function startup():void
		{
			//TODO Auto-generated method stub
            // commands
            commandMap.mapEvent(ZillowEvent.POSTINGS_READY, ZillowUpdateCommand, ZillowEvent);
            commandMap.mapEvent(SearchPostingsEvent.POSTINGS_SEARCH, SearchPostingsCommand, SearchPostingsEvent);
			commandMap.mapEvent(GetSearchResultsEvent.GET_SEARCH_RESULTS, GetSearchResultsCommand, GetSearchResultsEvent);
            
            // model
            injector.mapSingleton(ZillowModel);
            
            // service
            injector.mapSingletonOf(IService, ZillowService);
            
            // views
            mediatorMap.mapView(PostingSearchView, PostingSearchViewMediator);
            mediatorMap.mapView(ViewManager, ViewManagerMediator);
			mediatorMap.mapView(GetSearchResultsView, GetSearchResultsViewMediator);
		}
	}
}