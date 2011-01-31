package widgets.Zillow.main.service
{
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.collections.XMLListCollection;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import widgets.Zillow.main.events.ZillowEvent;
	import widgets.Zillow.main.util.ZillowUtil;
	import widgets.Zillow.main.vo.ZillowPosting;

	public class ZillowService extends EventDispatcher
	{

		public function ZillowService()
		{
			service=new HTTPService();
			service.showBusyCursor=true;
		}

		public var results:Object;
		
		protected var makeMeMove:XMLListCollection;
		protected var forSaleByOwner:XMLListCollection;
		protected var forSaleByAgent:XMLListCollection;
		protected var reportForSale:XMLListCollection;
		protected var forRent:XMLListCollection;
		// sample string
		// http://www.zillow.com/webservice/GetRegionPostings.htm?zws-id=<ZWSID>&zipcode=98102&rental=true

		protected var service:HTTPService;

		private const zillowURL:String="http://www.zillow.com/webservice/GetRegionPostings.htm";
		private const zwsid:String="xxxxxxxxxxxxxxxx";

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
			var zillowPosting:ZillowPosting = new ZillowPosting();
			var coll:ArrayCollection = ZillowUtil.toGraphics(makeMeMove);
			
			dispatchEvent(new ZillowEvent(ZillowEvent.POSTINGS_READY, zillowPosting));
		}
	}
}