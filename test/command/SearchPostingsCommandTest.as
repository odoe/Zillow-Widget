package widgets.Zillow.test.command
{
    import flash.events.EventDispatcher;
    
    import org.flexunit.asserts.assertEquals;
    import org.flexunit.asserts.assertNotNull;
    import org.flexunit.asserts.assertNull;
    import org.flexunit.asserts.assertTrue;
    import org.flexunit.async.Async;
    import org.hamcrest.assertThat;
    import org.robotlegs.mvcs.Command;
    
    import widgets.Zillow.main.command.SearchPostingsCommand;
    import widgets.Zillow.main.events.SearchPostingsEvent;
    import widgets.Zillow.main.events.ZillowEvent;
    import widgets.Zillow.main.model.vo.PostingsSearch;
    import widgets.Zillow.main.model.vo.ZillowPosting;
    import widgets.Zillow.main.service.ZillowService;

    public class SearchPostingsCommandTest
    {
        protected var command:SearchPostingsCommand;
        protected var event:SearchPostingsEvent;
        protected var criteria:PostingsSearch;
        protected var service:ZillowService;
        
        [Before]
        public function setUp():void
        {
            command = new SearchPostingsCommand();
            service = new ZillowService();
            service.eventDispatcher = new EventDispatcher();
            criteria = new PostingsSearch("90022");
            event = new SearchPostingsEvent(SearchPostingsEvent.POSTINGS_SEARCH, criteria);
            command.event = event;
        }
        
        [After]
        public function tearDown():void
        {
            command = null;
            service = null;
            event = null;
            criteria = null;
        }
        
        [Test(async)]
        public function canCommandProcessEvent():void
        {
            //Assert.fail("test not ready yet");
            assertThat("SearchPostingsCommand is of type RobotLegs Command", command is Command);
            assertThat("ZillowCommand.event is a ZillowEvent", command.event is SearchPostingsEvent);
            assertEquals("ZillowCommand event is same as test event", event, command.event);
            
            assertNotNull("Test service should not be null", service);
            assertNull("Command service should be null", command.service);
            
            command.service = service;
            assertEquals("Test service should be same as Command service", service, command.service);
            
            // Lets update model
            Async.handleEvent(this, service.eventDispatcher, ZillowEvent.POSTINGS_READY, onZillowResultsReturned, 500);
            command.execute();
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