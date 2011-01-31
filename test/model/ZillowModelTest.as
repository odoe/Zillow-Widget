package widgets.Zillow.test.model
{
    import flash.events.EventDispatcher;
    
    import mx.collections.ArrayCollection;
    
    import org.flexunit.asserts.assertEquals;
    import org.flexunit.asserts.assertNotNull;
    import org.flexunit.asserts.assertNull;
    import org.flexunit.asserts.assertTrue;
    import org.flexunit.async.Async;
    import org.robotlegs.mvcs.Actor;
    
    import widgets.Zillow.main.events.GraphicsEvent;
    import widgets.Zillow.main.events.ZillowEvent;
    import widgets.Zillow.main.model.ZillowModel;
    import widgets.Zillow.main.model.vo.ZillowPosting;

    public class ZillowModelTest
    {
        protected var model:ZillowModel;
        protected var ac:ArrayCollection;
        protected var zPosting:ZillowPosting;
        
        [Before]
        public function setUp():void
        {
            model = new ZillowModel();
            model.eventDispatcher = new EventDispatcher();
            ac = new ArrayCollection([1, 2, 3, 4]);
            zPosting = new ZillowPosting();
        }
        
        [After]
        public function tearDown():void
        {
            model = null;
            ac = null;
            zPosting = null;
        }
        
        [Test(async)]
        public function testThatModelGraphicsCanBeUpdated():void
        {
            assertTrue("To begin, model should be instance of Actor", model is Actor);
            assertNotNull("Model should not be null.", model);
            assertNull("However, the arraycollection of graphics should be null", model.graphicsCollection);
            
            model.graphicsCollection = ac;
            assertEquals("Array Collections should be equal", ac, model.graphicsCollection); 
            model.graphicsCollection = null;
            
            assertNull("Reset collection to null", model.graphicsCollection);
            
            Async.handleEvent(this, model.eventDispatcher, GraphicsEvent.GRAPHICS_UPDATED, onGraphicsUpdated, 500);
            model.graphicsCollection = ac;
        }
        
        [Test(async)]
        public function testThatModelZillowPostingsCanBeUpdated():void
        {
            assertTrue("To begin, model should be instance of Actor", model is Actor);
            assertNotNull("Model should not be null.", model);
            assertNull("However, the Zillow Posting object  should be null", model.zillowPosting);
            
            Async.handleEvent(this, model.eventDispatcher, ZillowEvent.POSTINGS_UPDATED, onZillowPostingUpdated, 500);
            model.zillowPosting = zPosting;
        }
        
        protected function onGraphicsUpdated(event:GraphicsEvent, ...args):void
        {
            assertNotNull("The returned graphics collection should not be null", event.graphicsCollection);
            assertEquals("The returned graphics collection should be same as what was sent", event.graphicsCollection, ac);
        }
        
        protected function onZillowPostingUpdated(event:ZillowEvent, ...args):void
        {
            assertNotNull("Returned zillow posting should not be null", event.zillowPostings);
            assertEquals("Returned posting should be same as what was sent", event.zillowPostings, zPosting);
        }
    }
}