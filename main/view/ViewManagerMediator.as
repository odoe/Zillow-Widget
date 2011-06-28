package widgets.Zillow.main.view
{
    import org.robotlegs.mvcs.Mediator;
    
    import widgets.Zillow.main.events.GraphicsEvent;
    import widgets.Zillow.main.events.ZillowIdEvent;
    import widgets.Zillow.main.view.ui.ViewManager;
    
    public class ViewManagerMediator extends Mediator
    {
        [Inject]
        public var view:ViewManager;
        
        override public function onRegister():void
        {
            //trace("ViewManagerMediator registered");
            eventMap.mapListener(eventDispatcher, GraphicsEvent.GRAPHICS_UPDATED, onGraphicsUpdated, GraphicsEvent);
            eventMap.mapListener(eventDispatcher, GraphicsEvent.GRAPHICS_CLEAR, onGraphicsClear, GraphicsEvent);
            eventMap.mapListener(view, ZillowIdEvent.ZILLOW_ID_READY, onZillowIdReady, ZillowIdEvent);
        }
        
        override public function onRemove():void
        {
            //trace("ViewManagerMediator removed");
            eventMap.unmapListener(eventDispatcher, GraphicsEvent.GRAPHICS_UPDATED, onGraphicsUpdated, GraphicsEvent);
            eventMap.unmapListener(eventDispatcher, GraphicsEvent.GRAPHICS_CLEAR, onGraphicsClear, GraphicsEvent);
        }
        
        protected function onGraphicsUpdated(event:GraphicsEvent):void
        {
            view.updateLayer(event.graphicsCollection);
        }
        
        protected function onGraphicsClear(event:GraphicsEvent):void
        {
            view.clearLayer();
        }
        
        protected function onZillowIdReady(event:ZillowIdEvent):void
        {
            dispatch(event);
        }
    }
}