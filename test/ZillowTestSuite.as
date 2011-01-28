package widgets.Zillow.test
{
    import org.flexunit.asserts.assertNotNull;
    
    import widgets.Zillow.main.service.ZillowService;
    import widgets.Zillow.test.service.ZillowServiceTest;

    [Suite]
    [RunWith("org.flexunit.runners.Suite")]
    public class ZillowTestSuite
    {
        public var zillowServiceTest:ZillowServiceTest;
    }
}