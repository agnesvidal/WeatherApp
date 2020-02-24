package sensors  {
	//----------------------------------------------------------------------
	// Imports
	//----------------------------------------------------------------------
	import flash.sensors.Geolocation;
	import flash.events.GeolocationEvent;
	import flash.events.StatusEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
		
	//----------------------------------------------------------------------
	// Public class
	//----------------------------------------------------------------------
	/**
	*	Represents geolocation point (latitude & longitude). Handles response from the device's location sensor.
	*/
	public class Geopoint{
		/**
		* Represents instance of Geolocation.
		* @default null
		*/
		private var _geo:Geolocation;
		
		/**
		* Counter to track number of geolocation updates.
		* @default null
		*/
		private var _count:int;
		
		/**
		* Callback function; function that handles latitude and longitude after 
		* position has been updated.
		* @default null
		*/
		private var _onComplete:Function; 
		
		/**
		* Callback function; handles the loading screen when an error occurs.
		*
		* @default null
		*/
		protected var onError:Function;
	
		//----------------------------------------------------------------------
		// Constructor method
		//----------------------------------------------------------------------
		public function Geopoint() {
			if (Geolocation.isSupported) {
					_geo = new Geolocation();
			} else {
					trace("Geolocation is not supported."); // @TODO 
			}
		}
		
		//----------------------------------------------------------------------
		// Public methods
		//----------------------------------------------------------------------
		/**
		 * Saves callback and calls method to update geo.
		 *
		 * @param 	completeCallback 	 
		 * @param 	errorCallback 		
		 * @return 	void
		 */
		public function getPoint(completeCallback:Function, errorCallback:Function): void {
			initGeo();
			_onComplete = completeCallback;
			onError = errorCallback; 
		}
		
		//----------------------------------------------------------------------
		// Private methods
		//----------------------------------------------------------------------
		/**
		 * Checks if the device's location sensor (geolocation) is turned on/off.
		 *
		 * @return void
		 */
		private function initGeo():void {
			if (!_geo.muted) { 
				handleGeoListeners(true);
				_count = 0;
			} else {
				onError("Location is not available.");
			}
			_geo.addEventListener(StatusEvent.STATUS, handleGeoStatus);
		}
		
		/**
		 * Handles listeners based on whether geolocation is muted or not.
		 *
		 * @return void
		 */
		private function handleGeoStatus(event:StatusEvent):void {
			if (_geo.muted) {
				_geo.removeEventListener(GeolocationEvent.UPDATE, handleGeo);
			} else {
				_geo.addEventListener(GeolocationEvent.UPDATE, handleGeo);
			}
		}
		
		/**
		 * Handles update listeners. Used when geolocation has been updated twice,
		 * or when the location button has been pressed.
		 *
		 * @param 	active	Boolean
		 * @return 	void
		 */
		private function handleGeoListeners(active:Boolean):void {
			if (active) {
				_geo.addEventListener(GeolocationEvent.UPDATE, handleGeo);
			} else {
				_geo.removeEventListener(GeolocationEvent.UPDATE, handleGeo);
			}	
		}

		/**
		 * Handles geolocation update, and turns off the update process after the
		 * second update. Returns latitude & longitude through callback.
		 *
		 * @return void
		 */
		private function handleGeo(event:GeolocationEvent):void {
			if (_count == 1) {
				handleGeoListeners(false);
				_onComplete(event.latitude.toPrecision(7), event.longitude.toPrecision(7)); 
			}
				_count++;	
		}
	}
}
