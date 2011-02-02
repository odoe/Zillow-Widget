package widgets.Zillow.main.command
{
	import org.robotlegs.mvcs.Command;
	import widgets.Zillow.main.events.ZillowIdEvent;
	import widgets.Zillow.main.model.ZillowModel;
	public class ZillowIdReadyCommand extends Command
	{
		[Inject]
		public var event:ZillowIdEvent;
		
		[Inject]
		public var model:ZillowModel;
		
		override public function execute():void
		{
			model.zwsid = event.zwsid;
		}
	}
}