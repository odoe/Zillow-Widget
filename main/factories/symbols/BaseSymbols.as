package widgets.Zillow.main.factories.symbols
{
	import com.esri.ags.Graphic;
	import com.esri.ags.geometry.Geometry;
	import com.esri.ags.symbols.PictureMarkerSymbol;
	import com.esri.ags.symbols.SimpleFillSymbol;
	import com.esri.ags.symbols.SimpleLineSymbol;
	import com.esri.ags.symbols.SimpleMarkerSymbol;
	import com.esri.ags.symbols.Symbol;
	
	/**
	 * Abstract class: Do not instantiate
	 * @author rrubalcava
	 *
	 */
	public class BaseSymbols implements IGraphicSymbols
	{
		protected var polySymbol:SimpleFillSymbol;
		protected var lineSymbol:SimpleLineSymbol;
		protected var pointSymbol:SimpleMarkerSymbol;
        protected var picSymbol:PictureMarkerSymbol;
		protected var geometry:Geometry;
		protected var sGraphic:Graphic;
		
		protected var outline:SimpleLineSymbol;
		
		public function getSymbol(graphic:Graphic):Symbol
		{
			sGraphic = graphic;
			geometry = graphic.geometry;
			
			if (geometry.type == Geometry.POLYLINE)
				return getLineSymbol();
			else if (geometry.type == Geometry.MAPPOINT)
				return getPictureMarkerSymbol();
			else if (geometry.type == Geometry.POLYGON)
				return getPolySymbol();
			
			return new Symbol();
		}
		
		protected function getLineSymbol():Symbol
		{
			return lineSymbol;
		}
		
		protected function getPolySymbol():Symbol
		{
			return polySymbol;
		}
		
		protected function getPointSymbol():Symbol
		{
			return pointSymbol;
		}
		
		protected function getOutline():SimpleLineSymbol
		{
			return outline;
		}
        
        protected function getPictureMarkerSymbol():PictureMarkerSymbol
        {
            return picSymbol;
        }
	}
}