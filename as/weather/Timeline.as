package weather {
	//----------------------------------------------------------------------
	// Imports
	//----------------------------------------------------------------------
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.Shape;
	import flash.events.MouseEvent;
	import interfaces.IObserver;

	//----------------------------------------------------------------------
	// Public class
	//----------------------------------------------------------------------
	/**
	 * Represents the timeline in the weather view. The timeline itself is a
	 * visualization of a 24 hour forecast.
	 */
	public class Timeline extends Sprite implements IObserver {
		//----------------------------------------------------------------------
		// Private constants
		//----------------------------------------------------------------------		
		/**
		 * Background color
		 * @default uint 0x333434
		 */
		private static const BACKGROUND = 0x212121;

		/**
		 * The containers start position (y-axis).
		 * @default 0
		 */
		private static const START_POS_CONTAINER = 0;

		//----------------------------------------------------------------------
		// Private properties
		//----------------------------------------------------------------------
		/**
		 * Container that is used to enable swiping up/down on the timeline.
		 * @default null
		 */
		private var _container: Sprite;

		/**
		 * List of all items (objects) on the timeline. An item represents an
		 * hour in the forecast.
		 * @default 
		 */
		private var _timelineItems: Vector.<TimelineItem> = new Vector.<TimelineItem>();

		/**
		 * Start position of mouse/touch (y-axis).
		 * @default null
		 */
		private var _startPosMouse;
		
		//----------------------------------------------------------------------
		// Constructor method
		//----------------------------------------------------------------------
		public function Timeline() {
			addEventListener(Event.ADDED_TO_STAGE, initUI);
		}

		//----------------------------------------------------------------------
		// Public methods
		//----------------------------------------------------------------------
		/**
		 * Initiates UI/graphics.
		 *
		 * @param event Event
		 * @return void
		 */
		public function initUI(event: Event): void {
			removeEventListener(Event.ADDED_TO_STAGE, initUI); // fixes issue with initUI() executing twice.
			initBackground();
			drawLine();
			initContainer();
			createItems();
		}

		/**
		 * Updates all items in the timeline.
		 *
		 * @param forecast Array
		 * @return void
		 */
		public function update(forecast: Vector.<Object>): void {
			for (var i: int = 0; i < forecast.length; i++) {
				var tempItem = _container.getChildAt(i);
				tempItem.update(forecast[i].hour, forecast[i].temp, forecast[i].code);
			}
		}

		//----------------------------------------------------------------------
		// Private methods
		//----------------------------------------------------------------------
		/**
		 * Creates background.
		 *
		 * @return void
		 */
		private function initBackground(): void {
			graphics.beginFill(BACKGROUND);
			graphics.drawRect(0, 0, 100, this.stage.stageHeight);
			graphics.endFill();
		}

		/**
		 * Creates container.
		 *
		 * @return void
		 */
		private function initContainer(): void {
			_container = new Sprite();
			_container.graphics.beginFill(0xFF0000, 0);
			_container.graphics.drawRect(0, 0, 100, this.height);
			_container.graphics.endFill();
			_container.addEventListener(MouseEvent.MOUSE_DOWN, mouseHandler);
			this.addChild(_container);
		}
		
		/**
		 * Draws line.
		 *
		 * @return void
		 */
		private function drawLine(): void {
			var line: Shape = new Shape();
			line.graphics.lineStyle(1, 0xB2B2B2, 1);
			line.graphics.moveTo(this.width - 33, 51);
			line.graphics.lineTo(this.width - 33, stage.stageHeight - 1);
			line.graphics.endFill();
			addChild(line);
		}

		/**
		 * Creates empty items used later to set a 24 hour forecast.
		 *
		 * @return void
		 */
		private function createItems(): void {
			for (var i: int = 0; i < 25; i++) {
				_timelineItems.push(new TimelineItem());
			}

			var posY = 0;
			for (var j: int = 0; j < _timelineItems.length; j++) {
				posY += 82;
				_timelineItems[j].y = posY;
				_container.addChild(_timelineItems[j]);
			}
		}

		/***************************************************************************************
		 *  Title: mouseHandler
		 *	Author: Atriace
		 *	Date: 2017
		 *	Availability: https://stackoverflow.com/a/45423252
		 ***************************************************************************************/
		/**
		 * Handles mouse events.
		 *
		 * @param event MouseEvent
		 * @return void
		 */
		private function mouseHandler(event: MouseEvent): void {
			switch (event.type) {
				case "mouseDown":
					_startPosMouse = mouseY;
					addEventListener("mouseUp", mouseHandler);
					addEventListener("releaseOutside", mouseHandler);
					addEventListener("mouseMove", mouseHandler);
					break;
				case "releaseOutside":
				case "mouseUp":
					removeEventListener("mouseUp", mouseHandler);
					removeEventListener("mouseMove", mouseHandler);
					break;
				case "mouseMove":
					_container.y = move(mouseY - _startPosMouse + START_POS_CONTAINER);
					break;
			}
		}

		/**
		 * Moves timeline on swipe.
		 *
		 * @param pos Number
		 * @return Number
		 */
		private function move(pos: Number): Number {
			var minPos = stage.stageHeight - _container.height;
			var maxPos = 0;
			var posY: Number;
			if (pos > maxPos) {
				posY = maxPos;
			} else if (pos < minPos) {
				posY = minPos;
			} else {
				posY = pos;
			}
			return posY;
		}
	}
}