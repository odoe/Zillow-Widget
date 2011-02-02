package widgets.Zillow.test.command
{
	import flash.events.EventDispatcher;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertNull;
	import org.hamcrest.assertThat;
	import org.robotlegs.mvcs.Command;
	
	import widgets.Zillow.main.command.GetSearchResultsCommand;
	import widgets.Zillow.main.events.GetSearchResultsEvent;
	import widgets.Zillow.main.model.ZillowModel;
	import widgets.Zillow.main.model.vo.GetSearchResults;
	import widgets.Zillow.main.service.IService;
	import widgets.Zillow.main.service.ZillowService;

	public class GetSearchResultsCommandTest
	{
		protected var command:GetSearchResultsCommand;
		protected var event:GetSearchResultsEvent;
		protected var criteria:GetSearchResults;
        protected var model:ZillowModel;

		public var service:ZillowService;
		
		[Before]
		public function setUp():void
		{
			command = new GetSearchResultsCommand();
            model = new ZillowModel();
            // MUST ADD YOUR OWN ZWSID FOR TESTS PASS
			criteria = new GetSearchResults("2114 Bigelow Ave", "Seattle, WA");
			event = new GetSearchResultsEvent(GetSearchResultsEvent.GET_SEARCH_RESULTS, criteria);
			command.event = event;
			service = new ZillowService();
			service.eventDispatcher = new EventDispatcher();
			command.service = service;
            command.model = model;
            
		}
		
		[After]
		public function tearDown():void
		{
			command = null;
			service = null;
			event = null;
			criteria = null;
            model = null;
		}
		
		[Test]
		public function testThatCommandHasProperValues():void
		{
			//Assert.fail("test not ready yet");
			assertThat("GetSearchResultsCommand is of type RobotLegs Command", command is Command);
			assertThat("GetSearchResultsCommand.event is a GetSearchResultsEvent", command.event is GetSearchResultsEvent);
			assertEquals("GetSearchResultsCommand event is same as test event", event, command.event);
			
			assertNotNull("Test service should not be null", service);
			assertNotNull("Command service should not be null", command.service);
			
			assertEquals("Test service should be same as Command service", service, command.service);
		}
	}
}