package widgets.Zillow.main.view
{
    import org.robotlegs.mvcs.Mediator;
    
    import widgets.Zillow.main.events.SearchPostingsEvent;
    import widgets.Zillow.main.view.ui.ZillowSearchView;
    
    public class ZillowSearchViewMediator extends Mediator
    {
        [Inject]
        public var view:ZillowSearchView;
        
        override public function onRegister():void
        {
            trace("ZillowSearchViewMediator registered");
            eventMap.mapListener(view, SearchPostingsEvent.POSTINGS_SEARCH, onSearchForZipCode);
        }
        
        override public function onRemove():void
        {
            trace("ZillowSearchViewMediator removed");
            eventMap.unmapListener(view, SearchPostingsEvent.POSTINGS_SEARCH, onSearchForZipCode);
        }
        
        protected function onSearchForZipCode(event:SearchPostingsEvent):void
        {
            dispatch(event);
        }
    }
}