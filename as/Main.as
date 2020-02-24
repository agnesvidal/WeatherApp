package {
	//----------------------------------------------------------------------
	// Imports
	//----------------------------------------------------------------------
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.desktop.SystemIdleMode;
	import flash.desktop.NativeApplication;
	import sensors.Geopoint;
	import net.GeocodingRequest;
	import net.SMHIRequest;
	import weather.Weather;
	import ui.Preloader;
	
	//----------------------------------------------------------------------
	// Public class
	//----------------------------------------------------------------------
	/**
	 * Represents the application's base class.
	 */
	public class Main extends Sprite {		
		/**
		* Reference to instance of Geopoint
		* @default null
		*/
		private var geopoint: Geopoint;
		
		/**
		* Reference to instance of Weather (view)
		* @default null
		*/
		private var weatherView: Weather;
		
		/**
		* Reference to instance of GeocodingRequest
		* @default null
		*/
		private var location: GeocodingRequest;
		
		/**
		* Reference to instance of SMHIRequest
		* @default null
		*/
		private var forecast: SMHIRequest;

		/**
		* Reference to instance of Preloader
		* @default null
		*/
		private var preloader: Preloader;
		
		/**
		* Reference to native application (represents this AIR-application)
		* @default null
		*/
		private var _app:NativeApplication;
		//----------------------------------------------------------------------
		// Constructor method
		//----------------------------------------------------------------------
		public function Main() {
			_app = NativeApplication.nativeApplication;
			_app.addEventListener(Event.EXITING, exitApplication);
			location = new GeocodingRequest(onError);
			forecast = new SMHIRequest(onError);
			geopoint = new Geopoint();
			initLoading();
			initView();
		}
		
		//----------------------------------------------------------------------
		// Public methods
		//----------------------------------------------------------------------
		/**
		 * Starts loading animation
		 *
		 * @return void
		 */
		
		public function initLoading(): void {
			preloader = new Preloader(activateGeo);
			addChild(preloader);
			activateGeo();
		}
		
		/**
		 * Initiates update of geolocation
		 *
		 * @return void
		 */
		public function activateGeo(): void {
			geopoint.getPoint(getData, onError);
		}
		
		/**
		 * Handles error in Preloader object.
		 *
		 * @param 	msg 	Error message to be displayed.
		 * @return 	void
		 */
		public function onError(msg:String): void {
			preloader.handleError(msg);
		}
		
		//----------------------------------------------------------------------
		// Private methods
		//----------------------------------------------------------------------
		/**
		 * Initializes the weather view. Runs in background while the loader is shown.
		 *
		 * @return void
		 */
		private function initView(): void {
			weatherView = new Weather(initLoading);
			addChildAt(weatherView, 0);
		}

		/**
		 * Handles requests to APIs'. 
		 *
		 * @param 	lat			Current positions latitude 	
		 * @param 	lng			Current positions longitude 	 	
		 * @return 	void
		 */
		private function getData(lat:Number, lng:Number): void {
			location.requestLocation(lat, lng, handleLocation);
			forecast.requestWeather(lat, lng, handleForecast);	
		}
		
		/**
		 * Handles response from API and updates location in the weather view.
		 * 
		 * @param 	name 		Name of current position
		 * @return 	void
		 */
		public function handleLocation(name:String): void {
			weatherView.location = name;
		}
		
		/**
		 * Handles response from API and updates forecast in the weather view.
		 *
		 * @param 	forecast	 Forecast for the following 24 hours	
		 * @return 	void
		 */
		private function handleForecast(forecast:Vector.<Object>): void {
			weatherView.forecast = forecast;
			removeChild(preloader);
		}
		
		/**
		 * Runs right before exiting the application. Removes all objects.
		 *
		 * @param 	event 
		 * @return 	void
		 */
		private function exitApplication(event:Event): void {
			_app.removeEventListener(Event.EXITING, exitApplication);
			_app.systemIdleMode = SystemIdleMode.NORMAL;
			while (this.numChildren > 0) {
					this.removeChildAt(0);
			}
		}
	}
}