package weather {
	//----------------------------------------------------------------------
	// Imports
	//----------------------------------------------------------------------
	import flash.display.Sprite;
	import ui.Text;
	
	//----------------------------------------------------------------------
	// Public class
	//----------------------------------------------------------------------
	/**
	 * Represents an item on the timeline. 
	 */
	public class TimelineItem extends Sprite {
		/**
		 * The hour which the item represents.
		 * @default "00:00"
		 */
		private var _hour:String;
		
		/**
		 * Temperature
		 * @default 0
		 */
		private var _temp:int;
		
		/**
		 * Integer representing the weather situation.
		 * @default 0
		 */
		private var _code:int;
		
		/**
		 * Reference to icon representing the weather situation.
		 * @default null
		 */
		private var _icon:WeatherIcon;
		
		/**
		 * Reference to textfield.
		 * @default null
		 */
		private var _text:Text;

		//----------------------------------------------------------------------
		// Constructor method
		//----------------------------------------------------------------------
		public function TimelineItem(hour:String = "00:00", temp:int = 0, code:int = 9) {
			this._hour = hour;
			this._temp = temp;
			this._code = code;
			initIcon();
			initText();
		}
		
		//----------------------------------------------------------------------
		// Public methods
		//----------------------------------------------------------------------
		/**
		 * Updates instance with new data.
		 *
		 * @param 	hour 	Hour
		 * @param 	temp 	Temperature
		 * @param 	code 	Value representing weather situation
		 * @return 	void	
		 */
		public function update(hour:String, temp:int, code:int):void {
			_text.text = hour + "\n" + temp + "\u00B0 C";
			_icon.updateIcon(code);
		}
		
		//----------------------------------------------------------------------
		// Private methods
		//----------------------------------------------------------------------
		/**
		 * Creates icon.
		 *
		 * @return void
		 */
		private function initIcon():void {
			_icon = new WeatherIcon();
			_icon.scaleX = 0.25;
			_icon.scaleY = 0.25;
			_icon.x = 66 - (_icon.width / 2);
			this.addChild(_icon);
		}
		
		/**
		 * Creates textfield.
		 *
		 * @return void
		 */
		private function initText():void {
			_text = new Text(11,0xFFFFFF,"Roboto light","left");
			_text.x = 12;
			_text.width = 50;
			_text.height = 50;
			_text.text = _hour + "\n" + _temp + "\u00B0 C";
			this.addChild(_text);
		}
	}
}
