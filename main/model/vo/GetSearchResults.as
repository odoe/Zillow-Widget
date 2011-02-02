package widgets.Zillow.main.model.vo
{
	public class GetSearchResults
	{
		public var address:String;
		public var citystatezip:String;
		
		public function GetSearchResults(address:String="", citystatezip:String="")
		{
			this.address = address;
			this.citystatezip = citystatezip;
		}
	}
}