package ui {
	//----------------------------------------------------------------------
	// Imports
	//----------------------------------------------------------------------
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.text.TextField;
	import flash.display.Sprite;

	//----------------------------------------------------------------------
	// Public class
	//----------------------------------------------------------------------
	/**
	 * Represents a textfield. The class is used to simplify the creation of textfields.
	 */
	public class Text extends TextField {
		/**
		 * Text size
		 * @default NaN
		 */
		private var _size: Number;

		/**
		 * Text color
		 * @default 0
		 */
		private var _color: uint;

		/**
		 * Font face
		 * @default null
		 */
		private var _font: String;

		/**
		 * Alignment
		 * @default null
		 */
		private var _align: String;

		//----------------------------------------------------------------------
		// Constructor method
		//----------------------------------------------------------------------
		public function Text(size: Number, color: uint, font: String, align: String) {
			this._size = size;
			this._color = color;
			this._font = font;
			this._align = align;
			initFormat();
		}

		//----------------------------------------------------------------------
		// Private methods
		//----------------------------------------------------------------------
		/**
		 * Formats text.
		 *
		 * @return void
		 */
		private function initFormat(): void {
			var format = new TextFormat();
				format.size = _size;
				format.color = _color;
				format.font = "Roboto light";
			switch (_align) {
				case "left":
					format.align = TextFormatAlign.LEFT;
					break;
				case "center":
					format.align = TextFormatAlign.CENTER;
					break;
				case "right":
					format.align = TextFormatAlign.RIGHT;
					break;
				case "justify":
					format.align = TextFormatAlign.JUSTIFY;
					break;
				case "start":
					format.align = TextFormatAlign.START;
					break;
				case "end":
					format.align = TextFormatAlign.END;
					break;
			}
			this.defaultTextFormat = format;
		}
	}
}