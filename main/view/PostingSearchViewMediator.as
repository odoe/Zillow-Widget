package widgets.Zillow.main.view
{
    import org.robotlegs.mvcs.Mediator;
    
    import widgets.Zillow.main.events.GraphicsEvent;
    import widgets.Zillow.main.events.SearchPostingsEvent;
    import widgets.Zillow.main.view.ui.PostingSearchView;
    
    public class PostingSearchViewMediator extends Mediator
    {
        [Inject]
        public var view:PostingSearchView;
        
        override public function onRegister():void
        {
            //trace("ZillowSearchViewMediator registered");
            eventMap.mapListener(view, SearchPostingsEvent.POSTINGS_SEARCH, onSearchForZipCode);
            eventMap.mapListener(view, GraphicsEvent.GRAPHICS_CLEAR, onClearGraphics);
        }
        
        override public function onRemove():void
        {
            //trace("ZillowSearchViewMediator removed");
            eventMap.unmapListener(view, SearchPostingsEvent.POSTINGS_SEARCH, onSearchForZipCode);
            eventMap.unmapListener(view, GraphicsEvent.GRAPHICS_CLEAR, onClearGraphics);
        }
        
        protected function onClearGraphics(event:GraphicsEvent):void
        {
            dispatch(event);
        }
        
        protected function onSearchForZipCode(event:SearchPostingsEvent):void
        {
            dispatch(event);
        }
    }
}