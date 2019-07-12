


class NotifyService {
	protected var listeners = new [0];
	
	function addListener(obj) {
		listeners.remove(obj);
		listeners.add(obj);
	}
	
		
	function removeListener(obj) {
		listeners.remove(obj);
	}
	
}