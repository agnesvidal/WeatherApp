package net {
	//----------------------------------------------------------------------
	// Imports
	//----------------------------------------------------------------------
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.errors.IllegalOperationError;
	
	//----------------------------------------------------------------------
	// Public class
	//----------------------------------------------------------------------
	/**
	* ABSTRACT CLASS representing a request to an API (must be subclassed, not instantiated).  
	*/	
	public class DataRequest extends URLLoader {
		//----------------------------------------------------------------------
		// Private properties
		//----------------------------------------------------------------------
		/**
		* Callback function; handles the loading screen when an error occurs.
		*
		* @default null
		*/
		protected var onError:Function;

		//----------------------------------------------------------------------
		// Constructor method
		//----------------------------------------------------------------------
		public function DataRequest(callback:Function) {
			this.onError = callback;
		}
		
		//----------------------------------------------------------------------
		// Protected methods
		//----------------------------------------------------------------------
		/**
		* Requests data from url and loads external data (JSON). 
		*
		* @param 	url 	Url used to make request
		* @return 	void
		*/
		protected function request(url:String):void {
			try {
					this.load(new URLRequest(url));
			} catch (error:SecurityError) {
				this.onError("A security error has occurred.");
				
			}
			addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			addEventListener(Event.COMPLETE, getData);
		}
		
		/**
		* Abstract method (must be overridden in subclass).
		* Parses data in JSON-object
		*
		* @param 	data 	Object containing the requested data
		*/
		protected function parseNodes(data:Object):void {
			throw new IllegalOperationError("Call to abstract method (must be overridden in a subclass)");
			return null;
		}

		//----------------------------------------------------------------------
		// Private methods
		//----------------------------------------------------------------------
		
		/**
		* Parses JSON-string into native object.
		* 
		* @param 	event 	Event
		* @return 	void
		*/
		private function getData(event:Event):void {
			try {
					var data:Object = JSON.parse(data);	
					parseNodes(data);
			} catch(e:TypeError) {
					this.onError("Sorry, we coudln't load the file.");
			}
		}
		
		/**
		* Handles errors when loading JSON file.
		*
		* @return 	void
		*/
		private function errorHandler(event:IOErrorEvent):void {
				this.onError("Sorry, we couldn't load the weather data.");	
		}
	}
}
