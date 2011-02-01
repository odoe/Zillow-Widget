package widgets.Zillow.main.model.vo
{
	public class ResultsSearch
	{
		public var address:String;
		public var citystatezip:String;
		
		public function ResultsSearch(address:String="", citystatezip:String="")
		{
			this.address = address;
			this.citystatezip = citystatezip;
		}
	}
}