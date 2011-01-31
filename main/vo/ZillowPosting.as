package widgets.Zillow.main.vo
{
	import flash.events.EventDispatcher;
	
	import mx.collections.XMLListCollection;

	public class ZillowPosting extends EventDispatcher
	{
		public var makeMeMove:XMLListCollection;
		public var forSaleByOwner:XMLListCollection;
		public var forSaleByAgent:XMLListCollection;
		public var reportForSale:XMLListCollection;
		public var forRent:XMLListCollection;
		
		public function ZillowPosting()
		{
			makeMeMove = new XMLListCollection();
			forSaleByOwner = new XMLListCollection();
			forSaleByAgent = new XMLListCollection();
			reportForSale = new XMLListCollection();
			forRent = new XMLListCollection();
		}
	}
}