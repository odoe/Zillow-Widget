package widgets.Zillow.test.view
{
    import flash.events.Event;
    import flash.events.EventDispatcher;
    
    import org.flexunit.asserts.assertNotNull;
    import org.flexunit.async.Async;
    import org.fluint.uiImpersonation.UIImpersonator;
    import org.hamcrest.assertThat;
    import org.robotlegs.mvcs.Mediator;
    
    import widgets.Zillow.main.view.PostingSearchViewMediator;
    import widgets.Zillow.main.view.components.skins.PostingSearchViewSkin;
    import widgets.Zillow.main.view.ui.PostingSearchView;

    public class PostingSearchViewMediatorTest
    {
        protected var view:PostingSearchView;
        protected var mediator:PostingSearchViewMediator;
        
        [Before(async, ui)]
        public function setUp():void
        {
            this.view = new PostingSearchView();
            view.setStyle("skinClass", widgets.Zillow.main.view.components.skins.PostingSearchViewSkin);
			
            this.mediator = new PostingSearchViewMediator();
            
            this.mediator.view = view;
            this.mediator.setViewComponent(view);
            this.mediator.eventDispatcher = new EventDispatcher()
            
            mediator.onRegister();
            
            Async.proceedOnEvent(this, this.view, Event.ADDED_TO_STAGE);
            UIImpersonator.addChild( this.view );
        }
        
        [After(async, ui)]
        public function tearDown():void
        {
            this.mediator.onRemove();
            this.mediator.eventDispatcher = null;
            this.view = null;
            this.mediator.view = null;
        }
        
        [Test]
        public function testViewExists():void
        {
            assertThat("Test mediator is instance of Robotlegs Mediator", mediator is Mediator);
            assertThat("Mediator view is same as test view", mediator.view == view);
            assertNotNull("Check that view is not null", mediator.view);
            assertNotNull("Check that mediator view component is not null", mediator.getViewComponent());
        }
    }
}