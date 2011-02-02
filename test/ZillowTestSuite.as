package widgets.Zillow.test
{
    import org.flexunit.asserts.assertNotNull;
    
    import widgets.Zillow.main.service.ZillowService;
    import widgets.Zillow.test.command.GetSearchResultsCommandTest;
    import widgets.Zillow.test.command.SearchPostingsCommandTest;
    import widgets.Zillow.test.command.RegionPostingsUpdateCommandTest;
    import widgets.Zillow.test.model.ZillowModelTest;
    import widgets.Zillow.test.service.ZillowServiceTest;
    import widgets.Zillow.test.util.ZillowUtilTest;
    import widgets.Zillow.test.view.PostingSearchViewMediatorTest;
    import widgets.Zillow.test.view.ViewManagerMediatorTest;

    [Suite]
    [RunWith("org.flexunit.runners.Suite")]
    public class ZillowTestSuite
    {
        public var zillowServiceTest:ZillowServiceTest;
		public var zillowUtilTest:ZillowUtilTest;
        public var zillModelTest:ZillowModelTest;
        public var zillowUpdateCommandTest:RegionPostingsUpdateCommandTest;
        public var zillowSearchViewMediatorTest:PostingSearchViewMediatorTest;
        public var searchPostingsCommandTest:SearchPostingsCommandTest;
		//public var viewManagerMediatorTest:ViewManagerMediatorTest;
		public var getSearchResultsCommandTest:GetSearchResultsCommandTest;
    }
}