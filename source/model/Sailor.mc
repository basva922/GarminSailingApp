
class Sailor {

    const EXP_SPEED = 0.5;
	var _speed = 0;
	var _heading = 0;
	var _avgSpeed = null;

	
	function setPositionUpdate(info) {
		_speed = info.speed;
		_heading = info.heading;
		if (_avgSpeed == null) {
			_avgSpeed = _speed;
		}
		else {
			_avgSpeed = EXP_SPEED * _avgSpeed + (1-EXP_SPEED) * _speed;
		}
	}
	
	function getSpeedScore(weather, boat) {
		var optimalSpeed = boat.getOptimalSpeed(weather, _heading);
		return (_speed*_speed*_speed) / (optimalSpeed*optimalSpeed*optimalSpeed);
	} 
	

	
	function getSpeed() {return _speed; }
	
	function getAvgSpeed() {return _avgSpeed; }
	
	function getHeading() { return _heading; }
	
	function getAngleToTheWind(weather) { return weather.calcAngleToWind(_heading); }
}