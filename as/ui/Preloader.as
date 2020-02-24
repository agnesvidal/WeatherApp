package ui {
	//----------------------------------------------------------------------
	// Imports
	//----------------------------------------------------------------------
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import ui.Button;
	import ui.Text;
	import interfaces.IView;

	//----------------------------------------------------------------------
	// Public class
	//----------------------------------------------------------------------
	/**
	 *	Loading screen (view). Shown before all data has been loaded from requests.
	 */
	public class Preloader extends MovieClip implements IView {
		//----------------------------------------------------------------------
		// Private constants
		//----------------------------------------------------------------------
		/**
		 * Bakground color
		 * @default uint 0x000000
		 */
		private static const BACKGROUND: uint = 0x000000;
		//----------------------------------------------------------------------
		// Private properties
		//----------------------------------------------------------------------
		/**
		 * Reference to button.
		 * @default null
		 */
		private var _errBtn: Button;

		/**
		 * Callback function; activates geolocation. Used on button.
		 * @default null
		 */
		private var _callback: Function;

		//----------------------------------------------------------------------
		// Constructor method
		//----------------------------------------------------------------------
		public function Preloader(callback: Function) {
			this._callback = callback;
			addEventListener(Event.ADDED_TO_STAGE, initUI);
		}
		
		//----------------------------------------------------------------------
		// Public methods
		//----------------------------------------------------------------------
		/**
		 * Handles animation when error occurs.
		 *
		 * @param msg String
		 * @return void
		 */
		public function handleError(msg: String): void {
			gotoAndStop(2);
			centerFrame();
			var text:Text = createText(msg);
			this.addChild(text);
			createBtn();
		}
		//----------------------------------------------------------------------
		// Private methods
		//----------------------------------------------------------------------

		/**
		 * Initalizes background and loading animation when the Preloader object has been added to the stage.
		 *
		 * @param event Event
		 * @return void
		 */
		public function initUI(event: Event): void {
			initBackground();
			load();
		}

		/**
		 * Starts the loading animation.
		 *
		 * @return void
		 */
		private function load(): void {
			gotoAndStop(1);
			centerFrame();
		}
		
		/**
		 * Creates error message.
		 *
		 * @param msg String
		 * @return Text
		 */
		private function createText(msg: String): Text {
			var errMsg 		 = new Text(12, 0xFFFFFF, "Roboto light", "center");
				errMsg.text  = msg;
				errMsg.width = 300;
				errMsg.x 	 = (this.width - errMsg.width) / 2;
				errMsg.y 	 = (this.height - errMsg.height - 70) / 2;
			return errMsg;
		}
		
		/**
		 * Creates button for reloading.
		 *
		 * @return Text
		 */
		private function createBtn(): void {
			_errBtn 	= new Button("Try again", 150, 45, 0xFFFFFF);
			_errBtn.x 	= (this.width - _errBtn.width) / 2;
			_errBtn.y 	= (this.height - _errBtn.height - 50) / 2;
			addChild(_errBtn);

			_errBtn.addEventListener("click", reload);
		}

		/**
		 * Removes error handing objects and starts reloading.
		 *
		 * @param Event
		 * @return void
		 */
		private function reload(event: MouseEvent): void {
			_errBtn.removeEventListener("click", load);
			while (this.numChildren > 0) {
				this.removeChildAt(0);
			}
			this.load();
			this._callback();
		}

		/**
		 * Centering object on stage/background.
		 *
		 * @return void
		 */
		private function centerFrame(): void {
			var child 	= this.getChildAt(0);
				child.x = (this.width - child.width) / 2;
				child.y = (this.height - child.height - 100) / 2;
		}

		/**
		 * Creates background.
		 *
		 * @return void
		 */
		private function initBackground(): void {
			this.graphics.beginFill(BACKGROUND);
			this.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			this.graphics.endFill();
		}

	}
}