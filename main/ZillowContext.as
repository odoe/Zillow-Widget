package widgets.Zillow.main
{
	import flash.display.DisplayObjectContainer;
	
	import org.robotlegs.mvcs.Context;
	
	public class ZillowContext extends Context
	{
		public function ZillowContext(contextView:DisplayObjectContainer=null, autoStartup:Boolean=true)
		{
			super(contextView, autoStartup);
		}
	}
}