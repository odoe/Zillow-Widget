package widgets.Zillow.main.events
{
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	public class GraphicsEvent extends Event
	{
		public static const GRAPHICS_UPDATED:String = "graphicsUpdated";
		
		public function GraphicsEvent(type:String, graphicsCollection:ArrayCollection)
		{
			super(type, true, true);
			_graphicsCollection = graphicsCollection;
		}
		private var _graphicsCollection:ArrayCollection;
		
		public function get graphicsCollection():ArrayCollection
		{
			return _graphicsCollection;
		}
		
		override public function clone():Event
		{
			return new GraphicsEvent(type, graphicsCollection);
		}
	}
}