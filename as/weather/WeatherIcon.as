package weather {
	//----------------------------------------------------------------------
	// Imports
	//----------------------------------------------------------------------
	import flash.display.MovieClip;
	//----------------------------------------------------------------------
	// Public class
	//----------------------------------------------------------------------
	/**
	 * Represents a weather icon. Consists of 9 frames; one blank frame to
	 * hide the icon and 8 frames representing the different weather situations.
	 */
	public class WeatherIcon extends MovieClip {
		//----------------------------------------------------------------------
		// Constructor method
		//----------------------------------------------------------------------
		public function WeatherIcon() {
			this.stop();
			gotoAndStop(1);
		}

		//----------------------------------------------------------------------
		// Public methods
		//----------------------------------------------------------------------
		/**
		 * Updates instance and displays it on stage.
		 *
		 * @param 	code 	Value representing weather situation.		 
		 * @return 	void
		 */
		public function updateIcon(code: int): void {
			gotoAndStop(code);
		}
	}
}