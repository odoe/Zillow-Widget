package widgets.Zillow.main.command
{
	import org.robotlegs.mvcs.Command;
	
	import widgets.Zillow.main.events.GetSearchResultsEvent;
	import widgets.Zillow.main.model.ZillowModel;
	import widgets.Zillow.main.service.IService;
	
	public class GetSearchResultsCommand extends Command
	{
		[Inject]
		public var event:GetSearchResultsEvent;
		
        [Inject]
        public var model:ZillowModel;
        
		[Inject]
		public var service:IService;
		
		override public function execute():void
		{
			if (event.criteria)
			{
				service.getSearchResults(model.zwsid, event.criteria);
			}
		}
	}
}