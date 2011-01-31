package widgets.Zillow.main.model
{
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Actor;
	
	import widgets.Zillow.main.events.GraphicsEvent;
	import widgets.Zillow.main.events.ZillowEvent;
	import widgets.Zillow.main.model.vo.ZillowPosting;

	public class ZillowModel extends Actor
	{
		
		public function ZillowModel()
		{
			super();
		}
		private var _graphicsCollection:ArrayCollection;
		
		
		public function get graphicsCollection():ArrayCollection
		{
			return _graphicsCollection;
		}
		
		public function set graphicsCollection(value:ArrayCollection):void
		{
			_graphicsCollection = value;
			dispatch(new GraphicsEvent(GraphicsEvent.GRAPHICS_UPDATED, graphicsCollection));
		}
		
		private var _zillowPosting:ZillowPosting;
		
		public function get zillowPosting():ZillowPosting
		{
			return _zillowPosting;
		}
		
		public function set zillowPosting(value:ZillowPosting):void
		{
			_zillowPosting = value;
            dispatch(new ZillowEvent(ZillowEvent.POSTINGS_UPDATED, zillowPosting));
		}
	}
}