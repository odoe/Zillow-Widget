package widgets.Zillow.main.view.ui
{
    import flash.events.MouseEvent;
    
    import mx.utils.StringUtil;
    
    import spark.components.Button;
    import spark.components.DataGroup;
    import spark.components.TextInput;
    import spark.components.supportClasses.SkinnableComponent;
    
    import widgets.Zillow.main.events.SearchPostingsEvent;
    import widgets.Zillow.main.model.vo.PostingsSearch;
    
    public class ZillowSearchView extends SkinnableComponent
    {
        public function ZillowSearchView()
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
        }

        protected override function partRemoved(partName:String, instance:Object):void {
            //TODO Auto-generated method stub
            super.partRemoved(partName,instance);
            if (instance == searchButton)
                searchButton.removeEventListener(MouseEvent.CLICK, onSearchButtonClicked);
        }
        
        protected function onSearchButtonClicked(event:MouseEvent):void
        {
            trace("button clicked");
            var zip:String = StringUtil.trim(searchInput.text);
            if (zip.length > 0)
            {
                var search:PostingsSearch = new PostingsSearch(zip);
                dispatchEvent(new SearchPostingsEvent(SearchPostingsEvent.POSTINGS_SEARCH, search));
            }
        }
    }
}