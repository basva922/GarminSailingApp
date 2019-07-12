using Toybox.Math;

class Weather {
	var windSpeed = 0;
	var windAngle = 0;
	
	function initialize(speed, angle) {
		windSpeed = speed;
		windAngle = angle;
	}
	
	function setWindAngle(angle) { 
		windAngle = normalizeAngle(angle);
	}
	
	function calcAngleToWind(heading) {
	heading = normalizeAngle(heading);
	 var diff = heading - windAngle;
	 diff = normalizeAngle(diff);
	 if (diff > 180) {
	 	diff -= 360;
	 } 
	 return diff;
	}
	

	static function normalizeAngle(angle) {
		if (angle >= 0) {
			return angle - (angle.toNumber() / 360)*360;
		}
		else {
			return angle + ((-angle.toNumber() / 360)*360) + 360;
		}
	}
}