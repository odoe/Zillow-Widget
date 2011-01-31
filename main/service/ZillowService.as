package widgets.Zillow.main.service
{
	import mx.collections.XMLListCollection;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import org.robotlegs.mvcs.Actor;
	
	import widgets.Zillow.main.events.ZillowEvent;
	import widgets.Zillow.main.model.ZillowModel;
	import widgets.Zillow.main.model.vo.ZillowPosting;

	public class ZillowService extends Actor
	{

		public function ZillowService()
		{
			service=new HTTPService();
			service.showBusyCursor=true;
		}
		
		protected var makeMeMove:XMLListCollection;
		protected var forSaleByOwner:XMLListCollection;
		protected var forSaleByAgent:XMLListCollection;
		protected var reportForSale:XMLListCollection;
		protected var forRent:XMLListCollection;
		// sample string
		// http://www.zillow.com/webservice/GetRegionPostings.htm?zws-id=<ZWSID>&zipcode=98102&rental=true

		protected var service:HTTPService;

		private const zillowURL:String="http://www.zillow.com/webservice/GetRegionPostings.htm";
		private const zwsid:String="xxxxxx";

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
			if (event.result)
            {
                var xmlList:XMLList = event.result.response;
                parseXML(xmlList);
            }
            // TODO - display a message that no results were returned
		}

        protected function parseXML(xmlList:XMLList):void {
            makeMeMove = new XMLListCollection(xmlList[0].makeMeMove.result);
            forSaleByOwner = new XMLListCollection(xmlList[0].forSaleByOwner.result);
            forSaleByAgent = new XMLListCollection(xmlList[0].forSaleByAgent.result);
            reportForSale = new XMLListCollection(xmlList[0].reportForSale.result);
            forRent = new XMLListCollection(xmlList[0].forRent.result);
            
            var zillowPosting:ZillowPosting = new ZillowPosting();
            zillowPosting.makeMeMove = makeMeMove;
            zillowPosting.forSaleByAgent = forSaleByAgent;
            zillowPosting.forSaleByOwner = forSaleByOwner;
            zillowPosting.forRent = forRent;
            zillowPosting.reportForSale = reportForSale;
            
            dispatch(new ZillowEvent(ZillowEvent.POSTINGS_READY, zillowPosting));
        }


	}
}