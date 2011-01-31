package widgets.Zillow.main.model.vo
{
    public class PostingsSearch
    {
        public var zipcode:String;
        public var citystatezip:String;
        public var rental:Boolean;
        public var postingType:String;
        
        public function PostingsSearch(zipcode:String="", citystatezip:String="", rental:Boolean=false, postingType:String="all")
        {
            this.zipcode = zipcode;
            this.citystatezip = citystatezip;
            this.rental = rental;
            this.postingType = postingType;
        }
    }
}