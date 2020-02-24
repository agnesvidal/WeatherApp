package net  {	
	//----------------------------------------------------------------------
	// Public class
	//----------------------------------------------------------------------
	/**
	* Handles communication between application and Google Geocoding API. 
	*/	
	public class GeocodingRequest extends DataRequest {
		//----------------------------------------------------------------------
		// Private constants
		//----------------------------------------------------------------------	
		/**
		* Address for API request.
		*
		* @default String
		*/
		private static const URL_STEM:String = "https://maps.googleapis.com/maps/api/geocode/json?location_type=ROOFTOP&result_type=street_address&latlng=";
		
		/**
		* API key.
		*
		* @default String
		*/		
		private static const API_KEY:String = "&key=YOUR_API_KEY";		
		
		/**
		* Callback function; reference to a function that activates when the request is completed. 
		*
		* @default null
		*/
		private var _onComplete:Function;
		
		//----------------------------------------------------------------------
		// Constructor method
		//----------------------------------------------------------------------
		public function GeocodingRequest(onErrorCallback:Function) {
			super(onErrorCallback);
		}
		
		//----------------------------------------------------------------------
		// Public methods
		//----------------------------------------------------------------------
		/**
		* Calls superclass's request method to make a new request.
		*
		* @param 	lat			Current positions latitude 	
		* @param 	lng			Current positions longitude 
		* @param 	callback 	Callback used when request is completed 
		* @return 	void
		*/
		public function requestLocation(lat:Number, lng:Number, callback:Function):void {
			this._onComplete = callback;
			request(createURL(lat,lng));
		}
		
		//----------------------------------------------------------------------
		// Protected methods
		//----------------------------------------------------------------------
		/**
		* Parses data in JSON-object (implementation of superclass's abstract method). 
		*
		* @param 	data 	Object containing the requested data 
		* @return 	void 
		*/
		override protected function parseNodes(data:Object):void {
			var locationName = "";
			if (data.results < 1) {
				locationName = data.plus_code.compound_code;
				var tempArr = locationName.split(" ");
				if (tempArr.length > 1) {
					tempArr = tempArr[1].split(",");
				}
				locationName = tempArr[0];
			} else {
				locationName = data.results[0].address_components[1].long_name;		
			}
			this._onComplete(locationName);
		}
		
		//----------------------------------------------------------------------
		// Private methods
		//----------------------------------------------------------------------
		/**
		* Creates request url based on latitude and longitude.
		*
		* @param 	lat			Current positions latitude 	
		* @param 	lng			Current positions longitude 
		* @return 	String
		*/
		private function createURL(lat:Number, lng:Number):String {
			return URL_STEM + lat + "," + lng + API_KEY;
		}
	}
}