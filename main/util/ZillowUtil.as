package widgets.Zillow.main.util
{
	import com.esri.ags.Graphic;
	import com.esri.ags.SpatialReference;
	import com.esri.ags.geometry.MapPoint;
	import com.esri.ags.utils.WebMercatorUtil;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.collections.XMLListCollection;
	import mx.core.ClassFactory;
	import mx.managers.CursorManager;
	
	import widgets.Zillow.main.view.components.renderers.RegionPostingsRenderer;
	import widgets.Zillow.main.view.components.renderers.SearchResultsRenderer;
	public class ZillowUtil
	{
		[Embed("../assets/images/zillowlogo_cursor_24x24.png")]
		private static var cursor:Class;
		
		private static var cursorID:int;
		
		public static function regionPostingsToGraphics(list:XMLListCollection, destination:ArrayCollection):ArrayCollection
		{
			if (!destination)
				destination = new ArrayCollection();
			
			if (list && list.length > 0)
			{
				for each (var result:XML in list)
				{
					var attr:Object = {};
					attr.type = "regionPostings";
					attr.zpid = result.zpid;
					// general property data
					attr.price = result.price;
					//attr.lastRefreshedDate = result.lastRefreshedDate;
					
					// need to parse out the date here
					var date:String = result.lastRefreshedDate;
					date = date.substr(0, date.length - 11);
					var chars:Array = date.split("-");
					attr.lastRefreshedDate = new Date(chars[0], chars[1], chars[2]);
					attr.homedetails = result.property.links.homedetails;
					// address
					attr.street = result.property.address.street;
					attr.zipcode = result.property.address.zipcode;
					attr.city = result.property.address.city;
					attr.state = result.property.address.state;
					attr.latitude = result.property.address.latitude;
					attr.longitude = result.property.address.longitude;
					// property details
					attr.useCode = result.property.useCode;
					attr.lotSizeSqFt = result.property.lotSizeSqFt;
					attr.finishedSqFt = result.property.finishedSqFt;
					attr.bathrooms = result.property.bathrooms;
					attr.bedrooms = result.property.bedrooms;
					attr.images = result.images;
					
					var wgs:MapPoint = new MapPoint(attr.longitude, attr.latitude, new SpatialReference(4326));
					var mp:MapPoint = WebMercatorUtil.geographicToWebMercator(wgs) as MapPoint;
					
					var g:Graphic = new Graphic(mp, null, attr);
					g.toolTip = attr.street + "\n" + attr.city + ", " + attr.state + "\n" + attr.zipcode;
					
					var rend:ClassFactory = new ClassFactory(RegionPostingsRenderer);
					g.infoWindowRenderer = rend;
					
					assignListeners(g);
					
					destination.addItem(g);
				}
			}
			return destination;
		}
		
		public static function searchResultsToGraphics(list:XMLListCollection, destination:ArrayCollection):ArrayCollection
		{
			if (!destination)
				destination = new ArrayCollection();
			
			if (list && list.length > 0)
			{
				for each (var result:XML in list)
				{
					var attr:Object = {};
					attr.type = "searchResults";
					attr.zpid = result.zpid;
					// links
					attr.homedetails = result.links.homedetails;
					attr.graphsanddata = result.links.graphsanddata;
					attr.mapthishome = result.links.mapthishome;
					attr.myestimator = result.links.myestimator;
					attr.comparables = result.links.comparables;
					// address
					attr.street = result.address.street;
					attr.zipcode = result.address.zipcode;
					attr.city = result.address.city;
					attr.state = result.address.state;
					attr.latitude = result.address.latitude;
					attr.longitude = result.address.longitude;
					// zestimate data
					attr.zestimateAmount = result.zestimate.amount;
					attr.zestimateAmountCurrency = result.zestimate.amount.@currency;
					attr.zestimateLastUpdated = result.zestimate["last-updated"];
					
					attr.zestimateValueChange = result.zestimate.valueChange;
					attr.zestimateValueChangeDuration = result.zestimate.valueChange.@duration;
					attr.zestimateValueChangeCurrency = result.zestimate.valueChange.@currency;
					
					attr.zestimateValuationRangeLow = result.zestimate.valuationRange.low;
					attr.zestimateValuationRangeHigh = result.zestimate.valuationRange.high;
					attr.zestimateValuationRangeCurrency = result.zestimate.valuationRange.high.@currency;
					attr.zestimatePercentile = result.zestimate.percentile;
					// convert to map point
					var wgs:MapPoint = new MapPoint(attr.longitude, attr.latitude, new SpatialReference(4326));
					var mp:MapPoint = WebMercatorUtil.geographicToWebMercator(wgs) as MapPoint;
					
					var g:Graphic = new Graphic(mp, null, attr);
					g.toolTip = attr.street + "\n" + attr.city + ", " + attr.state + "\n" + attr.zipcode;
					
					var rend:ClassFactory = new ClassFactory(SearchResultsRenderer);
					g.infoWindowRenderer = rend;
					
					assignListeners(g);
					
					destination.addItem(g);
				}
			}
			return destination;
		}
		
		private static function assignListeners(g:Graphic):void
		{
			g.addEventListener(MouseEvent.ROLL_OVER, onGraphicRollOver, false, 0, true);
			g.addEventListener(MouseEvent.ROLL_OUT, onGraphicsRollOut, false, 0, true);
			g.addEventListener(Event.REMOVED_FROM_STAGE, onGraphiscRemovedFromStage, false, 0, true);
		}
		
		private static function onGraphicRollOver(event:MouseEvent):void
		{
			cursorID = CursorManager.setCursor(cursor, 2, -8, -4);
		}
		
		private static function onGraphicsRollOut(event:MouseEvent):void
		{
			CursorManager.removeCursor(cursorID);
		}
		
		private static function onGraphiscRemovedFromStage(event:Event):void
		{
			var g:Graphic = event.currentTarget as Graphic;
			g.removeEventListener(Event.REMOVED_FROM_STAGE, onGraphiscRemovedFromStage);
			g.removeEventListener(MouseEvent.ROLL_OVER, onGraphicRollOver);
			g.removeEventListener(MouseEvent.ROLL_OUT, onGraphicsRollOut);
			g = null;
		}
	}
}