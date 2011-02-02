package widgets.Zillow.main.command
{
    import org.robotlegs.mvcs.Command;
    
    import widgets.Zillow.main.events.SearchPostingsEvent;
    import widgets.Zillow.main.service.IService;
    
    public class SearchPostingsCommand extends Command
    {
        [Inject]
        public var event:SearchPostingsEvent;
        
        [Inject]
        public var service:IService;
        
        override public function execute():void
        {
            if (event.criteria)
            {
                service.getRegionPostings(event.criteria);
            }
        }
    }
}