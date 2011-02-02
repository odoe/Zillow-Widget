package widgets.Zillow.main.service
{
	import mx.collections.XMLListCollection;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	import mx.utils.ObjectUtil;
	
	import org.robotlegs.mvcs.Actor;
	
	import widgets.Zillow.main.events.ZillowEvent;
	import widgets.Zillow.main.model.ZillowModel;
	import widgets.Zillow.main.model.vo.GetSearchResults;
	import widgets.Zillow.main.model.vo.PostingsSearch;
	import widgets.Zillow.main.model.vo.ZillowPosting;

	public class ZillowService extends Actor implements IService
	{

		public function ZillowService()
		{
			service=new HTTPService();
			service.showBusyCursor=true;
			service.resultFormat = "e4x";
		}
		
		protected var makeMeMove:XMLListCollection;
		protected var forSaleByOwner:XMLListCollection;
		protected var forSaleByAgent:XMLListCollection;
		protected var reportForSale:XMLListCollection;
		protected var forRent:XMLListCollection;
		// sample string
		// http://www.zillow.com/webservice/GetRegionPostings.htm?zws-id=<ZWSID>&zipcode=98102&rental=true

		protected var service:HTTPService;

		private const getRegionPostingsURL:String = "http://www.zillow.com/webservice/GetRegionPostings.htm";
		private const getSearchResultsURL:String = "http://www.zillow.com/webservice/GetSearchResults.htm";
        // You will need to add your own ZWSID to this application for use
		private const zwsid:String="xxxxxxxxxxxxxxxxx";
		
		public function getRegionPostings(criteria:PostingsSearch):void
		{
			service.url=getRegionPostingsURL;
			service.addEventListener(ResultEvent.RESULT, onRegionPostingsResult);
			service.send({	'zws-id': zwsid,
							zipcode: criteria.zipcode,
							citystatezip: criteria.citystatezip,
							rental: criteria.rental,
							postingType: criteria.postingType});
		}
		
		public function getSearchResults(criteria:GetSearchResults):void
		{
			service.url = getSearchResultsURL;
			service.addEventListener(ResultEvent.RESULT, onSearchResults);
			service.send({	'zws-id': zwsid,
							address: criteria.address,
							citystatezip: criteria.citystatezip});
		}
		
		protected function onRegionPostingsResult(event:ResultEvent):void
		{
			service.removeEventListener(ResultEvent.RESULT, onRegionPostingsResult);
			if (event.result)
            {
                var xmlList:XMLList = event.result.response;
                parseRegionPostingsXML(xmlList);
            }
            // TODO - display a message that no results were returned
		}
		
		protected function onSearchResults(event:ResultEvent):void
		{
			service.removeEventListener(ResultEvent.RESULT, onSearchResults);
			trace("search results returned");
			trace(ObjectUtil.toString(event.result));
		}
		
        protected function parseRegionPostingsXML(xmlList:XMLList):void {
            trace("parse xml results");
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