package weather {
	//----------------------------------------------------------------------
	// Imports
	//----------------------------------------------------------------------
	import flash.display.Sprite;
	import flash.events.Event;
	import interfaces.IView;
	import interfaces.ISubject;
	import interfaces.IObserver;

	//----------------------------------------------------------------------
	// Public class
	//----------------------------------------------------------------------
	/**
	 * Weather view. Displays current weather and forecast.
	 */
	public class Weather extends Sprite implements IView, ISubject {
		//----------------------------------------------------------------------
		// Private constants
		//----------------------------------------------------------------------
		/**
		 * Background color
		 * @default uint 0x333434
		 */
		private static const BACKGROUND = 0x333434;

		//----------------------------------------------------------------------
		// Private properties
		//----------------------------------------------------------------------
		/**
		 * Reference to instance of the forecast timeline.
		 * @default null
		 */
		private var _timeline: Timeline;

		/**
		 * Reference to array which contains 24 hour forecast.
		 * @default 
		 */
		private var _forecast:Vector.<Object> = new Vector.<Object>();

		/**
		 * Reference to instance representing the current weather.
		 * @default null
		 */
		private var _currentWeather: CurrentWeather;

		/**
		 * List of all observers that subscribes to subject (this).
		 * @default 
		 */
		private var _observers: Vector.<Object> = new Vector.<Object>();

		/**
		 * Reference to app top bar.
		 * @default null
		 */
		private var _topbar: Topbar;
		
		/**
		* Callback function that is passed along to Topbar. 
		* @default null
		*/
		private var _callback:Function; 
		
		//----------------------------------------------------------------------
		// Constructor method
		//----------------------------------------------------------------------
		public function Weather(callback:Function) {
			addEventListener(Event.ADDED_TO_STAGE, initUI);
			_callback = callback;
		}

		//----------------------------------------------------------------------
		// Public methods
		//----------------------------------------------------------------------		
		/**
		 * Initializes UI.
		 *
		 * @param event Event
		 * @return void
		 */
		public function initUI(event: Event): void {
			initBackground();
			initTimeline();
			initTopbar();
			initCurrentWeather();
		}
		
		/**
		 * Setter; sets location name in the application's top bar.
		 *
		 * @param event Event
		 * @return void
		 */
		public function set location(locationName: String): void {
			_topbar.updateLocation = locationName;
		}
		
		/**
		 * Setter; sets new forecast to array and updates all observers.
		 *
		 * @param forecast Array
		 * @return void
		 */
		public function set forecast(forecast: Vector.<Object>): void {
			_forecast = forecast;
			updateObserver();
		}
		
		/**
		 * Adds an object instance to subscriber list (observers).
		 *
		 * @param observer Observer
		 * @return void
		 */
		public function subscribeObserver(observer: IObserver): void {
			_observers.push(observer);
		}

		/**
		 * Unsubscribes an object instance to subscriber list (observers).
		 *
		 * @param observer Observer
		 * @return void
		 */
		public function unsubscribeObserver(observer: IObserver): void {
			for (var i: int = 0; i < _observers.length; i++) {
				if (_observers[i] == observer) {
					_observers.splice(i, 1);
					break;
				}
			}
		}

		/**
		 * Updates all observers when new forecast har been requested and recieved.
		 *
		 * @return void
		 */
		public function updateObserver(): void {
			for (var obj in _observers) {
				_observers[obj].update(_forecast);
			}
		}
		
		//----------------------------------------------------------------------
		// Private methods
		//----------------------------------------------------------------------		
		/**
		 * Creates the timeline that visualizes the forecast for the coming 24 hours. 
		 *
		 * @return void
		 */
		private function initTimeline(): void {
			_timeline = new Timeline();
			_timeline.x = (stage.stageWidth - 100);
			_timeline.y = 0;
			subscribeObserver(_timeline);
			addChildAt(_timeline, 0);
		}

		/**
		 * Instantiates new object of the Topbar class and creates the application's top bar.
		 *
		 * @return void
		 */
		private function initTopbar(): void {
			_topbar = new Topbar(_callback);
			addChild(_topbar);
		}

		/**
		 * Instantiates new object of the CurrentWeather class and creates
		 * the visualization for the current weather situation.
		 *
		 * @return void
		 */
		private function initCurrentWeather(): void {
			_currentWeather = new CurrentWeather();
			subscribeObserver(_currentWeather);
			this.addChild(_currentWeather);
		}

		/**
		 * Creates the graphics for the background.
		 *
		 * @return void
		 */
		private function initBackground(): void {
			graphics.beginFill(BACKGROUND);
			graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			graphics.endFill();

			graphics.beginFill(0x059B61);
			graphics.drawCircle(200, 655, 210);
			graphics.endFill();
			graphics.beginFill(0x03DA87);
			graphics.drawCircle(60, 655, 210);
			graphics.endFill();
		}
	}
}