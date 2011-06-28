package widgets.Zillow.main.view.ui
{
	import com.esri.ags.Graphic;
	import com.esri.ags.Map;
	import com.esri.ags.geometry.MapPoint;
	import com.esri.ags.layers.GraphicsLayer;
	import com.esri.ags.utils.GraphicUtil;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	import spark.components.SkinnableContainer;
	
	import widgets.Zillow.main.events.ZillowIdEvent;
	import widgets.Zillow.main.renderers.DefaultGraphicRenderer;

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
                    zillowLayer.renderer = new DefaultGraphicRenderer();
                    if (!map.getLayer(zillowLayer.id))
                        map.addLayer(zillowLayer);
                }
				dispatchEvent(new Event(MAP_CHANGE_EVENT));
			}
		}
        
        public function updateLayer(graphicProvider:ArrayCollection):void
        {
            if (zillowLayer)
			{
				zillowLayer.graphicProvider = graphicProvider;
                if (graphicProvider.length == 1)
                {
                    var mp:MapPoint = Graphic(graphicProvider[0]).geometry as MapPoint;
                    map.centerAt(mp);
                    map.level = map.lods.length -3;
                }
                else if (graphicProvider.length != 0)
                {
                    map.extent = GraphicUtil.getGraphicsExtent(graphicProvider.toArray()).expand(2);
                }
			}
        }
        
        public function clearLayer():void
        {
            if (zillowLayer)
                zillowLayer.clear();
        }
        
        public function set zwsid(value:String):void
        {
            if (value && value.length > 1)
                dispatchEvent(new ZillowIdEvent(ZillowIdEvent.ZILLOW_ID_READY, value));
        }
	}
}