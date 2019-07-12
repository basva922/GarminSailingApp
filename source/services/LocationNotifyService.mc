

class LocationNotifyService extends NotifyService {
	
	static var thisObj = null;
	
	function initialize() {
		NotifyService.initialize();
	}
	
	function notifyAll(info) {
		for (var i = 0; i < listeners.size(); i++) {
			var listener = listeners[i];
			if (listener has :locationChanged) {
				listener.locationChanged(info);
			} else {
				System.println("Error: listener has no locationChanged function");
			}
		}
	}
	
	static function getInstance() {
		if (thisObj == null) {
			thisObj = new LocationNotifyService();
		}
		return thisObj;
	}
}