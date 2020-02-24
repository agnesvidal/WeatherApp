package interfaces {
	//----------------------------------------------------------------------
	// Public interface
	//----------------------------------------------------------------------
	
	/**
	* Represents observer to be notified by subject.
	*/	
	public interface IObserver {
		function update(forecast: Vector.<Object>):void;
	}
}
