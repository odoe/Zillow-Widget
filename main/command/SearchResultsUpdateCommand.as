package widgets.Zillow.main.command
{
    import mx.collections.ArrayCollection;
    
    import org.robotlegs.mvcs.Command;
    
    import widgets.Zillow.main.events.ReturnedSearchResultsEvent;
    import widgets.Zillow.main.model.ZillowModel;
    import widgets.Zillow.main.util.ZillowUtil;
    
    public class SearchResultsUpdateCommand extends Command
    {
        [Inject]
        public var event:ReturnedSearchResultsEvent;
        
        [Inject]
        public var model:ZillowModel;
        
        override public function execute():void
        {
            if (event.xmlCollection)
            {
                var ac:ArrayCollection = ZillowUtil.searchResultsToGraphics(event.xmlCollection, ac);
                model.graphicsCollection = ac;
            }
        }
    }
}