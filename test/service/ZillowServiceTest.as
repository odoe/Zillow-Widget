package widgets.Zillow.test.service
{
    import flash.events.Event;
    
    import mx.utils.ObjectUtil;
    
    import org.flexunit.asserts.assertNotNull;
    import org.flexunit.asserts.assertNull;
    import org.flexunit.async.Async;
    
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
            assertNull(service.results);
            Async.handleEvent(this, service, "zillowResults", onZillowResultsReturned, 500);
            service.regionPostings("90022");
        }
        
        protected function onZillowResultsReturned(e:Event, ...args):void
        {
			//trace(ObjectUtil.toString(service.results));
            assertNotNull(service.results);
        }
    }
}