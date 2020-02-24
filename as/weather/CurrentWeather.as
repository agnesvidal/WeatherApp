package weather {
	//----------------------------------------------------------------------
	// Imports
	//----------------------------------------------------------------------
	import flash.display.Sprite;
	import flash.events.Event;
	import ui.Text;
	import interfaces.IObserver;

	//----------------------------------------------------------------------
	// Public interface
	//----------------------------------------------------------------------
	/**
	* Represents the current weather. Shows temperature, wind speed, and 
	* weather situation (icon).
	*/	
	public class CurrentWeather extends Sprite implements IObserver  {
		/**
		 * Textfield containing temperature.
		 * @default null
		 */
		private var _temp:Text;
		
		/**
		 * Textfield containing wind speed.
		 * @default null
		 */
		private var _wind:Text;
		
		/**
		 * Reference to weather icon.
		 * @default null
		 */
		private var _icon:WeatherIcon;
				
		//----------------------------------------------------------------------
		// Constructor method
		//----------------------------------------------------------------------
		public function CurrentWeather() {
			this.addEventListener(Event.ADDED_TO_STAGE, initUI);
		}
		
		//----------------------------------------------------------------------
		// Public methods
		//----------------------------------------------------------------------
		/**
		 * Updates instance with new data.
		 *
		 * @param 	forecast 	Current forecast
		 * @return 	void	
		 */
		public function update(forecast: Vector.<Object>):void {
			_temp.text = forecast[0].temp + "\u00B0" + "C";
			_wind.text = forecast[0].wind + " m/s";
			_icon.updateIcon(forecast[0].code);
		}
		
		//----------------------------------------------------------------------
		// Private methods
		//----------------------------------------------------------------------
		/**
		 * Initiates UI/graphics.
		 *
		 * @param 	event 	
		 * @return 	void	
		 */
		private function initUI(event:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, initUI);
			initTextFieldTemp();
			initTextFieldWind();
			initIcon();
		}
		
		/**
		 * Creates icon.
		 *
		 * @return 	void	
		 */
		private function initIcon():void {
			_icon 	= new WeatherIcon();
			_icon.x = (stage.stageWidth - 220) - (_icon.width / 2);
			_icon.y = 200;
			addChild(_icon);
		}
		
		/**
		 * Creates textfield to hold current temperature.
		 *
		 * @return 	void	
		 */
		private function initTextFieldTemp():void {
			_temp 		 = new Text(46,0xFFFFFF,"Roboto light","center");
			_temp.x 	 = (stage.stageWidth - 220) / 2;
			_temp.y 	 = 85;
			_temp.width  = 120;
			_temp.height = 120;
			this.addChild(_temp);
		}		

		/**
		 * Creates textfield to hold current weather's wind speed.
		 *
		 * @return 	void	
		 */
		private function initTextFieldWind():void {
			_wind 		 = new Text(14,0xFFFFFF,"Roboto light","center");
			_wind.x 	 = (stage.stageWidth - 220) / 2;
			_wind.y 	 = 145;
			_wind.width  = 120;
			_wind.height = 24;
			this.addChild(_wind);
		}
	}	
}
