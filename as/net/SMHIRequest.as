package net {	
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import flash.events.ProgressEvent;

	//----------------------------------------------------------------------
	// Public class
	//----------------------------------------------------------------------
	/**
	* Handles communication between application and SMHI's API.
	*/	
	public class SMHIRequest extends DataRequest {
		//----------------------------------------------------------------------
		// Private constants
		//----------------------------------------------------------------------	
		/**
		* Address for API request.
		*
		* @default String
		*/
		private static const URL_STEM:String = "https://opendata-download-metfcst.smhi.se/api/category/pmp3g/version/2/geotype/point/";
		
		//----------------------------------------------------------------------
		// Private properties
		//----------------------------------------------------------------------
		/**
		* Callback function; reference to a function that activates when the request is completed. 
		*
		* @default null
		*/
		private var _onComplete:Function;
		
		/**
		 * Reference to array which contains 24 hour forecast.
		 * @default <Vector>
		 */
		private var forecast:Vector.<Object> = new Vector.<Object>();

		//----------------------------------------------------------------------
		// Constructor method
		//----------------------------------------------------------------------
		public function SMHIRequest(onErrorCallback:Function) {
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
		public function requestWeather(lat:Number, lng:Number, callback:Function):void {
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
			clearArray();
				for (var i = 0; i<25; i++) {
				forecast.push(new Object());
				forecast[i].hour = data.timeSeries[i].validTime.substr(11,5);
				for each(var hour in data.timeSeries[i].parameters) {
					switch(hour.name) {
						case "t": forecast[i].temp = Math.round(hour.values[0]); break;
						case "ws": forecast[i].wind =  Math.round(hour.values[0]); break;
						case "Wsymb2": forecast[i].code = getWeatherCode(hour.values[0]); break;
						}
				}
			}
			this._onComplete(forecast);
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
			return URL_STEM + "lon/" + lng + "/lat/" + lat + "/data.json";
		}
		
		/**
		* Checks if array is empty. If not, it removes objects from array.
		*
		* @return 	void
		*/
		private function clearArray():void {
			if (forecast.length > 0) {
			var i:int = forecast.length
				while (i--) {
					forecast.splice(i, 1);
				} 
			}
		}
		
		/**
		 * The application supports 8 different weather situations, but the code  
		 * provided by the API ranges from 1-27 possible values. Therefore, this    
		 * method converts the possible values into 1-8.  
		 *
		 * @param 	code 	Value representing weather situation.
		 * @return 	int 	Integer between 1 and 8.
		 */
		private function getWeatherCode(code: int): int {
			var symb: int;
			switch (code) {
				case 1:
				case 2: symb = 1; break; // Clear sky
				case 3:
				case 4: symb = 2; break; // halfclear sky
				case 5:
				case 6: symb = 3; break; // overcast
				case 7: symb = 4; break; // fog
				case 8:
				case 9:
				case 10: symb = 5; break; // rain
				case 11: symb = 6; break; // thunder
				case 12:
				case 13:
				case 14: symb = 7; break; // sleet
				case 15:
				case 16:
				case 17: symb = 8; break; // snow
				case 18:
				case 19:
				case 20: symb = 5; break; // rain
				case 21: symb = 6; break; // thunder
				case 22:
				case 23:
				case 24: symb = 7; break; // sleet
				case 25:
				case 26:
				case 27: symb = 8; break; // snow
			}
			return symb;
		}
	}
}
