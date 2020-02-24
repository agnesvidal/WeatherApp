package interfaces {
	//----------------------------------------------------------------------
	// Public interface
	//----------------------------------------------------------------------
	
	/**
	* Represents subject that notifies observer(s).
	*/	
	public interface ISubject {
		function subscribeObserver(observer:IObserver):void;
		function unsubscribeObserver(observer:IObserver):void;
		function updateObserver():void;
	}
}
