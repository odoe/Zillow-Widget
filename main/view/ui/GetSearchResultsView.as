package widgets.Zillow.main.view.ui
{
	import flash.events.MouseEvent;
	
	import mx.events.FlexEvent;
	import mx.utils.StringUtil;
	
	import spark.components.Button;
	import spark.components.TextInput;
	import spark.components.supportClasses.SkinnableComponent;
	
	import widgets.Zillow.main.events.GetSearchResultsEvent;
	import widgets.Zillow.main.events.GraphicsEvent;
	import widgets.Zillow.main.model.vo.GetSearchResults;
	
	public class GetSearchResultsView extends SkinnableComponent
	{
		[SkinPart(required="true")]
		public var addressInput:TextInput;
		
		[SkinPart(required="true")]
		public var cityStateZipInput:TextInput;
		
		[SkinPart(required="true")]
		public var searchButton:Button;
        
        [SkinPart(required="true")]
        public var clearButton:Button;
		
		public function GetSearchResultsView()
		{
			super();
		}
		
		protected override function partAdded(partName:String, instance:Object):void {
			//TODO Auto-generated method stub
			super.partAdded(partName,instance);
			if (instance == searchButton)
				searchButton.addEventListener(MouseEvent.CLICK, onSearchButtonClicked);
			else if (instance == cityStateZipInput)
				cityStateZipInput.addEventListener(FlexEvent.ENTER, onInputEntered);
            else if (instance == clearButton)
                clearButton.addEventListener(MouseEvent.CLICK, onClearButtonClicked);
		}
		
		protected override function partRemoved(partName:String, instance:Object):void {
			//TODO Auto-generated method stub
			super.partRemoved(partName,instance);
			if (instance == searchButton)
				searchButton.removeEventListener(MouseEvent.CLICK, onSearchButtonClicked);
			else if (instance == cityStateZipInput)
				cityStateZipInput.removeEventListener(FlexEvent.ENTER, onInputEntered);
            else if (instance == clearButton)
                clearButton.removeEventListener(MouseEvent.CLICK, onClearButtonClicked);
		}
		
		protected function onInputEntered(event:FlexEvent):void
		{
			doSearch();
		}
		
		protected function onSearchButtonClicked(event:MouseEvent):void
		{
			doSearch();
		}
        
        protected function onClearButtonClicked(event:MouseEvent):void
        {
            dispatchEvent(new GraphicsEvent(GraphicsEvent.GRAPHICS_CLEAR, null));
        }
		
		protected function doSearch():void
		{
			var csz:String = StringUtil.trim(cityStateZipInput.text);
			var address:String = StringUtil.trim(addressInput.text);
			if (csz.length > 0 && address.length > 0)
			{
				var search:GetSearchResults = new GetSearchResults(address, csz);
				dispatchEvent(new GetSearchResultsEvent(GetSearchResultsEvent.GET_SEARCH_RESULTS, search));
			}
		}
	}
}