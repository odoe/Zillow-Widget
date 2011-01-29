package widgets.Zillow.main.util
{
	import com.esri.ags.Graphic;
	import com.esri.ags.SpatialReference;
	import com.esri.ags.geometry.MapPoint;
	import com.esri.ags.utils.WebMercatorUtil;
	
	import mx.collections.ArrayCollection;
	import mx.collections.XMLListCollection;

	public class ZillowUtil
	{
		public function ZillowUtil()
		{
		}
		
		public static function toGraphics(list:XMLListCollection):ArrayCollection
		{
			var gProvider:ArrayCollection = new ArrayCollection();
			for each(var result:XML in list)
			{
				var attr:Object = {};
				attr.zpid = result.zpid;
				attr.price = result.price;
				attr.lastRefreshedDate = result.lastRefreshedDate;
				attr.homedetails = result.property.links.homedetails;
				attr.street = result.property.address.street;
				attr.zipcode = result.property.address.zipcode;
				attr.city = result.property.address.city;
				attr.state = result.property.address.state;
				attr.latitude = result.property.address.latitude;
				attr.longitude = result.property.address.longitude;
				attr.useCode = result.property.useCode;
				attr.lotSizeSqFt = result.property.lotSizeSqFt;
				attr.finishedSqFt = result.property.finishedSqFt;
				attr.bathrooms = result.property.bathrooms;
				attr.bedrooms = result.property.bedrooms;
				attr.images = result.images;
				
				var wgs:MapPoint = new MapPoint(attr.longitude, attr.latitude, new SpatialReference(4326));
				var mp:MapPoint = WebMercatorUtil.geographicToWebMercator(wgs) as MapPoint;
				
				var g:Graphic = new Graphic(mp, null, attr);
				gProvider.addItem(g);
				trace("price", result.price);
			}
			return gProvider;
		}
	}
}