package widgets.Zillow.main
{
	import flash.display.DisplayObjectContainer;
	
	import org.robotlegs.mvcs.Context;
	
	import widgets.Zillow.main.command.SearchPostingsCommand;
	import widgets.Zillow.main.command.ZillowUpdateCommand;
	import widgets.Zillow.main.events.SearchPostingsEvent;
	import widgets.Zillow.main.events.ZillowEvent;
	import widgets.Zillow.main.model.ZillowModel;
	import widgets.Zillow.main.service.ZillowService;
	import widgets.Zillow.main.view.ViewManagerMediator;
	import widgets.Zillow.main.view.ZillowSearchViewMediator;
	import widgets.Zillow.main.view.ui.ViewManager;
	import widgets.Zillow.main.view.ui.ZillowSearchView;

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
            
            // model
            injector.mapSingleton(ZillowModel);
            
            // service
            injector.mapSingleton(ZillowService);
            
            // views
            mediatorMap.mapView(ZillowSearchView, ZillowSearchViewMediator);
            mediatorMap.mapView(ViewManager, ViewManagerMediator);
		}
	}
}