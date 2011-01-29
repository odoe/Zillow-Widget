package widgets.Zillow.main.service
{
	import com.esri.ags.Graphic;
	import com.esri.ags.SpatialReference;
	import com.esri.ags.geometry.MapPoint;
	import com.esri.ags.utils.WebMercatorUtil;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	import mx.collections.XMLListCollection;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import widgets.Zillow.main.events.ZillowEvent;

	public class ZillowService extends EventDispatcher
	{

		public function ZillowService()
		{
			service=new HTTPService();
			service.showBusyCursor=true;
			zillow_dict=new Dictionary();
		}

		public var results:Object;
		public var zillow_dict:Dictionary;
		
		protected var makeMeMove:XMLListCollection;
		protected var forSaleByOwner:XMLListCollection;
		protected var forSaleByAgent:XMLListCollection;
		protected var reportForSale:XMLListCollection;
		protected var forRent:XMLListCollection;
		// sample string
		// http://www.zillow.com/webservice/GetRegionPostings.htm?zws-id=<ZWSID>&zipcode=98102&rental=true

		protected var service:HTTPService;

		private const zillowURL:String="http://www.zillow.com/webservice/GetRegionPostings.htm";
		private const zwsid:String="xxxxxxxxx";

		public function regionPostings(zipcode:String="", citystatezip:String="", rental:Boolean=false, postingType:String="all"):void
		{
			service.url=zillowURL;
			service.resultFormat = "e4x";
			service.addEventListener(ResultEvent.RESULT, onRegionPostingsResult);
			service.send({'zws-id': zwsid, zipcode: zipcode, citystatezip: citystatezip, rental: rental, postingType: postingType});
		}

		protected function onRegionPostingsResult(event:ResultEvent):void
		{
			service.removeEventListener(ResultEvent.RESULT, onRegionPostingsResult);
			results=event.result;
			
			var xmlList:XMLList = results.response;
			makeMeMove = new XMLListCollection(xmlList[0].makeMeMove.result);
			forSaleByOwner = new XMLListCollection(xmlList[0].forSaleByOwner.result);
			forSaleByAgent = new XMLListCollection(xmlList[0].forSaleByAgent.result);
			reportForSale = new XMLListCollection(xmlList[0].reportForSale.result);
			forRent = new XMLListCollection(xmlList[0].forRent.result);
			var coll:ArrayCollection = toGraphics(makeMeMove);
			trace("collection of graphics", coll.length);
			/*trace("my item: forSaleByOwner", xmlList[0].forSaleByOwner.count);
			trace("my item: forSaleByAgent", xmlList[0].forSaleByAgent.count);
			trace("my item: reportForSale", xmlList[0].reportForSale.count);
			trace("my item: forRent", xmlList[0].forRent.count);*/
			
			dispatchEvent(new ZillowEvent(ZillowEvent.POSTINGS_READY, coll));
		}
		
		protected function toGraphics(list:XMLListCollection):ArrayCollection
		{
			var gProvider:ArrayCollection = new ArrayCollection();
			for each(var result:XML in list)
			{
				var attr:Object = {};
				attr.zpid = result.zpid;
				attr.price = result.price;
				attr.lastRefreshedDate = result.lastRefreshedDate;
				attr.homedetails = result.property.links.homedetails;
				attr.street = result.property.address.street;
				attr.zipcode = result.property.address.zipcode;
				attr.city = result.property.address.city;
				attr.state = result.property.address.state;
				attr.latitude = result.property.address.latitude;
				attr.longitude = result.property.address.longitude;
				attr.useCode = result.property.useCode;
				attr.lotSizeSqFt = result.property.lotSizeSqFt;
				attr.finishedSqFt = result.property.finishedSqFt;
				attr.bathrooms = result.property.bathrooms;
				attr.bedrooms = result.property.bedrooms;
				attr.images = result.images;
				
				var wgs:MapPoint = new MapPoint(attr.longitude, attr.latitude, new SpatialReference(4326));
				var mp:MapPoint = WebMercatorUtil.geographicToWebMercator(wgs) as MapPoint;
				
				var g:Graphic = new Graphic(mp, null, attr);
				gProvider.addItem(g);
				trace("price", result.price);
			}
			return gProvider;
		}
	}
}