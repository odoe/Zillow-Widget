package widgets.Zillow.test.service
{
    import flash.events.EventDispatcher;
    
    import mx.collections.XMLListCollection;
    
    import org.flexunit.asserts.assertNotNull;
    import org.flexunit.asserts.assertNull;
    import org.flexunit.asserts.assertTrue;
    import org.flexunit.asserts.fail;
    import org.flexunit.async.Async;
    import org.robotlegs.mvcs.Actor;
    
    import widgets.Zillow.main.events.ReturnedSearchResultsEvent;
    import widgets.Zillow.main.events.ZillowEvent;
    import widgets.Zillow.main.model.vo.GetSearchResults;
    import widgets.Zillow.main.model.vo.PostingsSearch;
    import widgets.Zillow.main.model.vo.ZillowPosting;
    import widgets.Zillow.main.service.ZillowService;

    public class ZillowServiceTest
    {
        protected var service:ZillowService;
        
        [Before]
        public function setUp():void
        {
            service = new ZillowService();
            service.eventDispatcher = new EventDispatcher();
        }
        
        [After]
        public function tearDown():void
        {
            service = null;
        }
        
        [Test]
        public function isAValidActor():void
        {
            assertTrue("Service is an instance of Actor", service is Actor);
        }
        
        [Test(async="true")]
        public function testRegionPostings():void
        {
            Async.handleEvent(this, service.eventDispatcher, ZillowEvent.POSTINGS_READY, onZillowResultsReturned, 1000);
            // MUST ADD YOUR OWN ZWSID FOR TESTS PASS
            var post:PostingsSearch = new PostingsSearch("90022");
            service.getRegionPostings("", post);
        }
        
        [Test(async="true")]
        public function canReturnGetSearchResults():void
        {
            //fail("test not ready yet");
            Async.handleEvent(this, service.eventDispatcher, ReturnedSearchResultsEvent.SEARCH_RESULTS_RETURNED, onSearchResultsReturned, 1000);
            // MUST ADD YOUR OWN ZWSID FOR TESTS PASS
            var criteria:GetSearchResults = new GetSearchResults("2114 Bigelow Ave", "Seattle, WA");
            service.getSearchResults("", criteria);
        }
        
        protected function onSearchResultsReturned(e:ReturnedSearchResultsEvent, ...args):void
        {
            assertNotNull("xml list collection not null", e.xmlCollection);
            assertTrue("e.xmlCollection is XMLListCollection", e.xmlCollection is XMLListCollection);
            assertTrue("xml collection containes items", e.xmlCollection.length > 0);
        }
        
        protected function onZillowResultsReturned(e:ZillowEvent, ...args):void
        {
			//trace(ObjectUtil.toString(service.results));
            assertNotNull("array collection is not null", e.zillowPostings);
            assertTrue("e.zillowPostings is instance ZillowPosting", e.zillowPostings is ZillowPosting);
			assertTrue("array collection contains items", e.zillowPostings.makeMeMove.length > 0);
        }
    }
}