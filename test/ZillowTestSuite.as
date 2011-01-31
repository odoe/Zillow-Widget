package widgets.Zillow.test
{
    import org.flexunit.asserts.assertNotNull;
    
    import widgets.Zillow.main.service.ZillowService;
    import widgets.Zillow.test.command.ZillowUpdateCommandTest;
    import widgets.Zillow.test.model.ZillowModelTest;
    import widgets.Zillow.test.service.ZillowServiceTest;
    import widgets.Zillow.test.util.ZillowUtilTest;

    [Suite]
    [RunWith("org.flexunit.runners.Suite")]
    public class ZillowTestSuite
    {
        public var zillowServiceTest:ZillowServiceTest;
		public var zillowUtilTest:ZillowUtilTest;
        public var zillModelTest:ZillowModelTest;
        public var zillowUpdateCommandTest:ZillowUpdateCommandTest;
    }
}