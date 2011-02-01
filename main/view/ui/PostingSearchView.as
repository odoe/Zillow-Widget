package widgets.Zillow.main.view.ui
{
    import flash.events.MouseEvent;
    
    import mx.events.FlexEvent;
    import mx.utils.StringUtil;
    
    import spark.components.Button;
    import spark.components.DataGroup;
    import spark.components.TextInput;
    import spark.components.supportClasses.SkinnableComponent;
    
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
        
        
        protected override function partAdded(partName:String, instance:Object):void {
            //TODO Auto-generated method stub
            super.partAdded(partName,instance);
            if (instance == searchButton)
                searchButton.addEventListener(MouseEvent.CLICK, onSearchButtonClicked);
			else if (instance == searchInput)
				searchInput.addEventListener(FlexEvent.ENTER, onInputEntered);
        }

        protected override function partRemoved(partName:String, instance:Object):void {
            //TODO Auto-generated method stub
            super.partRemoved(partName,instance);
            if (instance == searchButton)
                searchButton.removeEventListener(MouseEvent.CLICK, onSearchButtonClicked);
			else if (instance == searchInput)
				searchInput.removeEventListener(FlexEvent.ENTER, onInputEntered);
        }
        
		protected function onInputEntered(event:FlexEvent):void
		{
			doSearch();
		}
		
        protected function onSearchButtonClicked(event:MouseEvent):void
        {
			doSearch();
        }
		
		protected function doSearch():void
		{
			var zip:String = StringUtil.trim(searchInput.text);
			if (zip.length > 0)
			{
				var search:PostingsSearch = new PostingsSearch(zip);
				dispatchEvent(new SearchPostingsEvent(SearchPostingsEvent.POSTINGS_SEARCH, search));
			}
		}
    }
}