package widgets.Zillow.main.command
{
    import mx.collections.ArrayCollection;
    
    import org.robotlegs.mvcs.Command;
    
    import widgets.Zillow.main.events.ZillowEvent;
    import widgets.Zillow.main.model.ZillowModel;
    import widgets.Zillow.main.model.vo.ZillowPosting;
    import widgets.Zillow.main.util.ZillowUtil;
    
    public class ZillowUpdateCommand extends Command
    {
        [Inject]
        public var event:ZillowEvent;
        
        [Inject]
        public var model:ZillowModel;
        
        override public function execute():void
        {
            var postings:ZillowPosting = event.zillowPostings
            if(postings)
            {
                model.zillowPosting = postings;
                var ac:ArrayCollection = ZillowUtil.toGraphics(postings.forRent, ac);
                ac = ZillowUtil.toGraphics(postings.forRent, ac);
                ac = ZillowUtil.toGraphics(postings.forSaleByAgent, ac);
                ac = ZillowUtil.toGraphics(postings.forSaleByOwner, ac);
                ac = ZillowUtil.toGraphics(postings.makeMeMove, ac);
                ac = ZillowUtil.toGraphics(postings.reportForSale, ac);
                
                model.graphicsCollection = ac;
            }
        }
    }
}