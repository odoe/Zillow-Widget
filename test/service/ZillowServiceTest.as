package widgets.Zillow.test.service
{
    import flash.events.EventDispatcher;
    
    import org.flexunit.asserts.assertNotNull;
    import org.flexunit.asserts.assertNull;
    import org.flexunit.asserts.assertTrue;
    import org.flexunit.async.Async;
    import org.robotlegs.mvcs.Actor;
    
    import widgets.Zillow.main.events.ZillowEvent;
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
        
        [Test(async="true")]
        public function testRegionPostings():void
        {
			assertTrue("Service is an instance of Actor", service is Actor);
            Async.handleEvent(this, service.eventDispatcher, ZillowEvent.POSTINGS_READY, onZillowResultsReturned, 1000);
            var post:PostingsSearch = new PostingsSearch("90022");
            service.regionPostings(post);
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