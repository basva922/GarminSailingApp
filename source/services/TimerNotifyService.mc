using Toybox.Time;
using Toybox.Timer;


class TimerNotifyService extends NotifyService {
	
	static var thisObj = null;
	
	
	var _timer = null;
	var _startTime = null;
	var _duration = null;
	
	function initialize() {
		NotifyService.initialize();
	}
	
	
	function notifyAll() {
		for (var i = 0; i < listeners.size(); i++) {
			var listener = listeners[i];
			if (listener has :timerChanged) {
				listener.timerChanged();
			} else {
				System.println("Error: listener has no timerChanged function");
			}
		}
	}
	
	function start(minutes) {
		stop();
		
		_startTime = Time.now();
		_duration = new Time.Duration(minutes*60);
		_timer = new Timer.Timer();
		_timer.start(method(:notifyAll), 1000, true);
	}
	
	function stop() {
		if (_timer != null) {
			_timer.stop();
		}
		_timer = null;
		_startTime = null;
		_duration = null;
	}
	
	function syncToClosestMinute() {
		if (!isRunning()) { return; }
		
		var seconds = getTimer().value().abs() % 60;
		if (seconds > 30) {
			_duration = _duration.add(new Time.Duration(60-seconds));
		}
		if (seconds <= 30) {
			_duration = _duration.subtract(new Time.Duration(seconds));
		}
		
	}
	
	function isRunning() { return _timer != null; }
	
	function getTimer() {
		if (isRunning()) {
			return _duration.subtract(Time.now().subtract(_startTime));
		}
		return new Time.Duration(0);
	}
	
	static function getInstance() {
		if (thisObj == null) {
			thisObj = new TimerNotifyService();
		}
		return thisObj;
	}
	
	
}