package widgets.Zillow.test.service
{
    import flash.events.EventDispatcher;
    
    import org.flexunit.asserts.assertNotNull;
    import org.flexunit.asserts.assertNull;
    import org.flexunit.asserts.assertTrue;
    import org.flexunit.async.Async;
    
    import widgets.Zillow.main.events.ZillowEvent;
    import widgets.Zillow.main.service.ZillowService;

    public class ZillowServiceTest
    {
        protected var service:ZillowService;
        
        [Before]
        public function setUp():void
        {
            service = new ZillowService();
        }
        
        [After]
        public function tearDown():void
        {
            service = null;
        }
        
        [Test(async="true")]
        public function testRegionPostings():void
        {
			assertTrue("Service is an instance of EventDispatcher", service is EventDispatcher);
            assertNull(service.results);
            Async.handleEvent(this, service, ZillowEvent.POSTINGS_READY, onZillowResultsReturned, 500);
            service.regionPostings("90022");
        }
        
        protected function onZillowResultsReturned(e:ZillowEvent, ...args):void
        {
			//trace(ObjectUtil.toString(service.results));
            assertNotNull("array collection is not null", e.zillowPostings);
			assertTrue("array collection contains items", e.zillowPostings.makeMeMove.length > 0);
        }
    }
}