package widgets.Zillow.main.view.ui
{
	import com.esri.ags.Map;
	import com.esri.ags.layers.GraphicsLayer;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	import spark.components.SkinnableContainer;

	[Event(name="mapChange",type="flash.events.Event")]
	public class ViewManager extends SkinnableContainer
	{
		public static const MAP_CHANGE_EVENT:String = "mapChange";
		
		public function ViewManager()
		{
			super();
		}
		private var _map:Map;
		
		protected var zillowLayer:GraphicsLayer;
        
		[Bindable(event="mapChange")]
		public function get map():Map
		{
			return _map;
		}
		
		public function set map(value:Map):void
		{
			if (_map != value)
			{
				_map = value;
                if (!zillowLayer)
                {
                    zillowLayer = new GraphicsLayer();
                    zillowLayer.id = "ZillowData";
                    // TODO - set Zillow Renderer
                    if (!map.getLayer(zillowLayer.id))
                        map.addLayer(zillowLayer);
                    
                    trace("zillow layer should be in map");
                }
				dispatchEvent(new Event(MAP_CHANGE_EVENT));
			}
		}
        
        public function updateLayer(graphicProvider:ArrayCollection):void
        {
            if (zillowLayer)
                zillowLayer.graphicProvider = graphicProvider;
        }
	}
}