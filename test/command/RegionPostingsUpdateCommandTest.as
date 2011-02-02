package widgets.Zillow.test.command
{
    import flash.events.EventDispatcher;
    
    import flexunit.framework.Assert;
    
    import org.flexunit.asserts.assertEquals;
    import org.flexunit.asserts.assertNotNull;
    import org.flexunit.asserts.assertNull;
    import org.flexunit.asserts.assertTrue;
    import org.hamcrest.assertThat;
    import org.robotlegs.mvcs.Command;
    
    import widgets.Zillow.main.command.RegionPostingsUpdateCommand;
    import widgets.Zillow.main.events.ZillowEvent;
    import widgets.Zillow.main.model.ZillowModel;
    import widgets.Zillow.main.model.vo.ZillowPosting;
    
    public class RegionPostingsUpdateCommandTest extends Command
    {
        protected var command:RegionPostingsUpdateCommand;
        protected var event:ZillowEvent;
        protected var zPosting:ZillowPosting;
        protected var model:ZillowModel;
        
        [Before]
        public function setUp():void
        {
            command = new RegionPostingsUpdateCommand();
            model = new ZillowModel();
            model.eventDispatcher = new EventDispatcher();
        }
        
        [After]
        public function tearDown():void
        {
            command = null;
            event = null;
            zPosting = null;
            model = null;
        }
        
        [Test]
        public function canCommandProcessEvent():void
        {
            //Assert.fail("test not ready yet");
            zPosting = new ZillowPosting();
            event = new ZillowEvent(ZillowEvent.POSTINGS_READY, zPosting);
            command.event = event;
            assertThat("ZillowCommand is of type RobotLegs Command", command is Command);
            assertThat("ZillowCommand.event is a ZillowEvent", command.event is ZillowEvent);
            assertEquals("ZillowCommand event is same as test event", event, command.event);
            assertEquals("Posting in Command event, same as test posting", zPosting, command.event.zillowPostings);
            
            assertNotNull("Test model should not be null", model);
            assertNull("Command model should be null", command.model);
            
            command.model = model;
            assertEquals("Test model should be same as Command model", model, command.model);
            
            // Lets update model
            command.execute();
            assertEquals("Model zillow posting should now be same as test posting", model.zillowPosting, zPosting);
            // the graphics collection of model should be updated with data
            assertNotNull("Model graphics collection will be updated via this command as well", model.graphicsCollection);
        }
    }
}