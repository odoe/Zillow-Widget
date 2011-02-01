package widgets.Zillow.test.view
{
	import com.esri.ags.Map;
	import com.esri.ags.layers.GraphicsLayer;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertNull;
	import org.flexunit.async.Async;
	import org.fluint.uiImpersonation.UIImpersonator;
	import org.hamcrest.assertThat;
	import org.robotlegs.mvcs.Mediator;
	
	import widgets.Zillow.main.events.GraphicsEvent;
	import widgets.Zillow.main.view.ViewManagerMediator;
	import widgets.Zillow.main.view.components.skins.ViewManagerSkin;
	import widgets.Zillow.main.view.components.skins.PostingSearchViewSkin;
	import widgets.Zillow.main.view.ui.ViewManager;

    public class ViewManagerMediatorTest
    {
		protected var view:ViewManager;
		protected var mediator:ViewManagerMediator;
		protected var gColl:ArrayCollection;
		
		[Before(async, ui)]
		public function setUp():void
		{
			gColl = new ArrayCollection();
			
			this.view = new ViewManager();
			view.setStyle("skinClass", widgets.Zillow.main.view.components.skins.ViewManagerSkin);
			this.mediator = new ViewManagerMediator();
			
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
			//assertThat("Test mediator is instance of Robotlegs Mediator", this.mediator is Mediator);
			//assertThat("Mediator view is same as test view", this.mediator.view == view);
			assertNotNull("Check that view is not null", this.mediator.view);
			assertNotNull("Check that mediator view component is not null", this.mediator.getViewComponent());
		}
		
		[Test(async)]
		public function testViewUpdatesMap():void
		{
			assertNull("Map should start null", view.map);
			view.map = new Map();
			assertNotNull("Map contains a graphic layer", view.map.getLayer("ZillowData"));
			
			Async.handleEvent(this, mediator.eventDispatcher, GraphicsEvent.GRAPHICS_UPDATED, onGraphicsUpdated, 500);
			var event:GraphicsEvent = new GraphicsEvent(GraphicsEvent.GRAPHICS_UPDATED, gColl);
			mediator.eventDispatcher.dispatchEvent(event);
		}
		
		protected function onGraphicsUpdated(event:GraphicsEvent):void
		{
			assertEquals("Event graphics collection should be same as sent", gColl, event.graphicsCollection);
			assertEquals("Map graphic should be same as what was sent", GraphicsLayer(view.map.getLayer("ZillowData")).graphicProvider, event.graphicsCollection);
		}
    }
}