package widgets.Zillow.main.service
{
	import widgets.Zillow.main.model.vo.GetSearchResults;
	import widgets.Zillow.main.model.vo.PostingsSearch;

	public interface IService
	{
		function getRegionPostings(criteria:PostingsSearch):void;
		function getSearchResults(criteria:GetSearchResults):void;
	}
}