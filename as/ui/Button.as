package ui {
	//----------------------------------------------------------------------
	// Imports
	//----------------------------------------------------------------------
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.display.Shape;
	import ui.Text;

	//----------------------------------------------------------------------
	// Public class
	//----------------------------------------------------------------------
	/**
	 * Represents a button based on SimpleButton.
	 */
	public class Button extends SimpleButton {
		/**
		 * Color used for buttons border.
		 * @default 0
		 */
		private var _color: uint;

		/**
		 * Text used in button.
		 * @default null
		 */
		private var _text: String;

		/**
		 * Width of button.
		 * @default NaN
		 */
		private var _width: Number;

		/**
		 * Height of button.
		 * @default NaN
		 */
		private var _height: Number;

		//----------------------------------------------------------------------
		// Constructor method
		//----------------------------------------------------------------------
		public function Button(text: String, width: Number, height: Number, color: uint) {
			this._color = color;
			this._text = text;
			this._width = width;
			this._height = height;

			this.upState = createButton();
			this.downState = createButton();
			this.overState = createButton();
			this.hitTestState = this.upState;
		}

		//----------------------------------------------------------------------
		// Private methods
		//----------------------------------------------------------------------
		/**
		 * Creates button.
		 *
		 * @return Sprite
		 */
		private function createButton(): Sprite {
			var container: Sprite = new Sprite();
			var bg: Shape = drawRect();
			var text: Text = createText();

			container.addChild(bg);
			container.addChild(text);
			return container;
		}

		/**
		 * Creates rectangle.
		 *
		 * @return Shape
		 */
		private function drawRect(): Shape {
			var rect: Shape = new Shape();
				rect.graphics.lineStyle(1, _color);
				rect.graphics.beginFill(0x000000, 0);
				rect.graphics.drawRect(0, 0, _width, _height);
				rect.graphics.endFill();
			return rect;
		}

		/**
		 * Creates text.
		 *
		 * @return Shape
		 */
		private function createText(): Text {
			var txt = new Text(14, _color, "Roboto light", "center");
				txt.text = _text;
				txt.height = 25;
				txt.y = (_height - txt.height) / 2;
				txt.x = (_width - txt.width) / 2;
			return txt;
		}
	}
}