package widgets.Zillow.main.view.ui
{
    import flash.events.MouseEvent;
    
    import mx.events.FlexEvent;
    import mx.utils.ObjectUtil;
    import mx.utils.StringUtil;
    
    import spark.components.Button;
    import spark.components.DataGroup;
    import spark.components.DropDownList;
    import spark.components.RadioButton;
    import spark.components.TextInput;
    import spark.components.supportClasses.SkinnableComponent;
    
    import widgets.Zillow.main.events.GraphicsEvent;
    import widgets.Zillow.main.events.SearchPostingsEvent;
    import widgets.Zillow.main.model.vo.PostingsSearch;
    
    public class PostingSearchView extends SkinnableComponent
    {
        public function PostingSearchView()
        {
            super();
        }
        
        [SkinPart(required="true")]
        public var searchInput:TextInput;
        
        [SkinPart(required="true")]
        public var searchButton:Button;
        
        [SkinPart(required="true")]
        public var clearButton:Button;
        
        [SkinPart(required="true")]
        public var rbYes:RadioButton;
        
        [SkinPart(required="true")]
        public var ddlType:DropDownList;
        
        protected override function partAdded(partName:String, instance:Object):void {
            //TODO Auto-generated method stub
            super.partAdded(partName,instance);
            if (instance == searchButton)
                searchButton.addEventListener(MouseEvent.CLICK, onSearchButtonClicked);
			else if (instance == searchInput)
				searchInput.addEventListener(FlexEvent.ENTER, onInputEntered);
            else if (instance == clearButton)
                clearButton.addEventListener(MouseEvent.CLICK, onClearButtonClicked);
        }

        protected override function partRemoved(partName:String, instance:Object):void {
            //TODO Auto-generated method stub
            super.partRemoved(partName,instance);
            if (instance == searchButton)
                searchButton.removeEventListener(MouseEvent.CLICK, onSearchButtonClicked);
			else if (instance == searchInput)
				searchInput.removeEventListener(FlexEvent.ENTER, onInputEntered);
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
			var input:String = StringUtil.trim(searchInput.text);
            
			if (input.length > 0)
			{
                var rentals:Boolean = rbYes.selected;
                var type:String = ddlType.selectedItem.data;
                var search:PostingsSearch;
                if (!isNaN(Number(input)))
                {
                    search = new PostingsSearch(input, "", rentals, type);
                }
                else
                {
                    search = new PostingsSearch("", input, rentals, type);
                }
                dispatchEvent(new SearchPostingsEvent(SearchPostingsEvent.POSTINGS_SEARCH, search));
			}
		}
    }
}