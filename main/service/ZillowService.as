package widgets.Zillow.main.service
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	import mx.utils.ObjectUtil;
	
	public class ZillowService extends EventDispatcher
	{
		private const zwsid:String = "xxxx";
		
		private const zillowURL:String = "http://www.zillow.com/webservice/GetRegionPostings.htm?zws-id=";
		// sample string
		// http://www.zillow.com/webservice/GetRegionPostings.htm?zws-id=<ZWSID>&zipcode=98102&rental=true
		
		protected var service:HTTPService;
        
        public var results:Object;
		
		public function ZillowService()
		{
			service = new HTTPService();
			service.showBusyCursor = true;
		}
		
		public function regionPostings(zipcode:String="", citystatezip:String="", rental:Boolean=false, postingType:String="all"):void
		{
			service.url = zillowURL + zwsid;
			if (zipcode.length > 0)
			{
				service.url += ("&zipcode=" + zipcode);
			}
			else if (citystatezip.length > 0)
			{
				service.url += ("&citystatezip=" + citystatezip);
			}
			else if (rental)
			{
				service.url += ("&rental=" + String(rental));
			}
			
			service.url += ("&postingType=" + postingType);
			service.addEventListener(ResultEvent.RESULT, onRegionPostingsResult);
            service.send();
		}
		
		protected function onRegionPostingsResult(event:ResultEvent):void
		{
			service.removeEventListener(ResultEvent.RESULT, onRegionPostingsResult);
            trace("my zillow results",ObjectUtil.toString(event.result));
            dispatchEvent(new Event("zillowResults"));
		}
	}
}