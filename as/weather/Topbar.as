package weather  {
	//----------------------------------------------------------------------
	// Imports
	//----------------------------------------------------------------------
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;	
	import ui.Text;
	
	//----------------------------------------------------------------------
	// Public class
	//----------------------------------------------------------------------
	/**
	* Represents the application's top bar containing the name of the location and the date.
	*/	
	public class Topbar extends Sprite {
		//----------------------------------------------------------------------
		// Private properties
		//----------------------------------------------------------------------
		/**
		 * Reference to textfield containing the name of the location.
		 * @default null
		 */
		private var _textField:Text;
		
		//----------------------------------------------------------------------
		// Private properties
		//----------------------------------------------------------------------
		/**
		 * Reference to button updating geolocation.
		 * @default null
		 */
		private var _geoBtn:Sprite;
		
		/**
		* Callback function; when the button (_geoBtn) is pressed this callback 
		* restarts the loading animation (preloader) and the geolocation update.
		* @default null
		*/
		private var _onUpdate:Function; 

		//----------------------------------------------------------------------
		// Constructor method
		//----------------------------------------------------------------------
		public function Topbar(callback:Function) {
			addEventListener(Event.ADDED_TO_STAGE, initUI);
			_onUpdate = callback;
		}
		
		//----------------------------------------------------------------------
		// Public methods
		//----------------------------------------------------------------------
		/**
		* Initalizes the UI.
		*
		* @param 	event 	Event
		* @return 	void
		*/
		public function initUI(event:Event):void {
			initBackground();
			initDate();
			initBtn();
			addChild(_geoBtn);
			
			createTextField();
		}
		
		/**
		* Setter; sets name of the location.
		*
		* @param 	locationName 	Name of the current position
		* @return 	void
		*/
		public function set updateLocation(locationName:String):void {
			_geoBtn.addEventListener(MouseEvent.CLICK, updateGeo);
			_textField.text = locationName;
		}
		
		//----------------------------------------------------------------------
		// Private methods
		//----------------------------------------------------------------------
		/**
		* Creates the background.
		*
		* @return void
		*/
		private function initBackground():void {
			graphics.beginFill(0xFFFFFF);
			graphics.drawRect(0,0,stage.stageWidth,50);
			graphics.endFill();
		}
		
		/**
		* Creates the button used to update the geolocation.
		*
		* @return void
		*/
		private function initBtn(): void {
			_geoBtn = new Sprite();
			_geoBtn.graphics.beginFill(0xFFFFFF, 0);
			_geoBtn.graphics.drawRect(0,0,50,50);
			_geoBtn.graphics.endFill();
			var icon = initIcon();
			_geoBtn.addChild(icon);
		}
		
		/**
		* Creates the icon for the button.
		*
		* @return 	icon 	Geoposition icon
		*/
		private function initIcon(): LocationButton {
			var icon:LocationButton = new LocationButton();
				icon.x = 15;
				icon.y = 14;
			return icon;
		}

		/**
		* Creates textfield for the name of the location.
		*
		* @return void
		*/
		private function createTextField():void {	
			_textField = new Text(14,0x6633CC,"Roboto light","left");
			_textField.x = 30; 
			_textField.y = 13;
			_textField.width = 210;
			_textField.height = 30;
			addChild(_textField);
		}
		
		/**
		* Creates textfield with the current date.
		*
		* @return void
		*/
		private function initDate():void {
			var date:Date = new Date();
			var dateTxt:Text = new Text(14,0x6633CC,"Roboto light","left");
				dateTxt.text = convertDay(date.day) + ", " + date.date + " " + convertMonth(date.month);
				dateTxt.x = 245;
				dateTxt.y = 15;
				dateTxt.width = 125;
			addChild(dateTxt);
		}
		
		/**
		* Converts recieved integer (day) into name (day).
		* 
		* @param 	day 	Integer represeting a day
		* @return 	String
		*/
		private function convertDay(day:int):String {
			var d:String = "";
				switch(day) {
					case 1: d = "Måndag"; 	break;
					case 2: d = "Tisdag"; 	break;
					case 3: d = "Onsdag"; 	break;
					case 4: d = "Torsdag"; 	break;
					case 5: d = "Fredag"; 	break;
					case 6: d = "Lördag"; 	break;
					case 0: d = "Söndag"; 	break;
					}
			return d;
		}
		
		/**
		* Converts recieved integer (month) into name (month).
		* 
		* @param 	moth 	Integer representing a month
		* @return 	String
		*/
		private function convertMonth(month:int):String {
			var m:String = "";
				switch(month) {
					case 0: 	m = "Jan"; break;
					case 1: 	m = "Feb"; break;
					case 2: 	m = "Mar"; break;
					case 3: 	m = "Apr"; break;
					case 4: 	m = "Maj"; break;
					case 5: 	m = "Jun"; break;
					case 6: 	m = "Jul"; break;
					case 7: 	m = "Aug"; break;
					case 8: 	m = "Sep"; break;
					case 9: 	m = "Okt"; break;
					case 10: 	m = "Nov"; break;
					case 11: 	m = "Dec"; break;
					}
			return m;
		}
		
		/**
		* Restarts update of geolocation. 
		*
		* @param 	event 	Event
		* @return 	void
		*/
		private function updateGeo(event:Event):void {
			_geoBtn.removeEventListener(MouseEvent.CLICK, updateGeo);
			_onUpdate();
		}
	}
}
