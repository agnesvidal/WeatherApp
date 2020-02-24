package interfaces {
	import flash.events.Event;
	//----------------------------------------------------------------------
	// Public interface
	//----------------------------------------------------------------------
	
	/**
	* Represents a view of the application.
	*/	
	public interface IView {
		function initUI(event:Event):void;
	}
}
