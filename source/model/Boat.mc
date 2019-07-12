


class Boat {


	function getOptimalSpeed(wheater, heading) {
		return 2;
	}
	
	// knots to rangeindex 6 8 10 12 14 16 20
	function knotsToRange(knots){
		if (knots <= 7) { return 0; }
		if (knots <= 9) { return 1; }
		if (knots <= 11) { return 2; }
		if (knots <= 13) { return 3; }
		if (knots <= 15) { return 4; }
		if (knots <= 18) { return 5; }
		else { return 6; }
	}
	
	function changeAngleToSailingPortTack(weather, heading) {
		var angle = getOptimalUpWindAngle(weather);
		weather.setWindAngle(heading - angle);
	}
	
	function changeAngleToSailingSBTack(weather, heading) {
		var angle = getOptimalUpWindAngle(weather);
		weather.setWindAngle(heading + angle);
	}
	
	function getName() {
		return "Generic";
	}
}

class Europe extends Boat {
	const upwindSpeed = [3.8, 4.0, 4.2, 4.4, 4.6, 4.7, 4.8];
	const upwindAngle = [42, 42.2, 42.4, 42.6, 42.7, 42.9, 43];
	const downwindSpeed = [3.2, 4.1, 4.7, 5.4, 6.1, 6.8, 8.0];
	const downwindAngle = [165, 165.3, 165.4, 165.5, 165.6, 165.7, 166];
	
	
	function initialize() {
		Boat.initialize();
	}

	function getOptimalSpeed(weather, heading) {
		var angleToWind = weather.calcAngleToWind(heading).abs();
		
		// upwind
		if (angleToWind < 90) {
			return getOptimalUpWindSpeed(weather);
		}
		else { // downwind
			return getOptimalDownWindSpeed(weather);
		}
	}
	
	function getOptimalAngleOffset(weather, heading) {
		var angleToWind = weather.calcAngleToWind(heading).abs();
		
		// upwind
		if (angleToWind < 90) {
			return getOptimalUpWindAngle(weather) - angleToWind;
		}
		else { // downwind
			return getOptimalDownWindAngle(weather) - angleToWind;
		}
	}
	
	function getOptimalDownWindAngle(weather) {
		var windSpeedIndex = knotsToRange(weather.windSpeed);
		return downwindAngle[windSpeedIndex];
	}
	
	function getOptimalUpWindAngle(weather) {
		var windSpeedIndex = knotsToRange(weather.windSpeed);
		return upwindAngle[windSpeedIndex];
	}	
	
	function getOptimalDownWindSpeed(weather) {
		var windSpeedIndex = knotsToRange(weather.windSpeed);
		return downwindSpeed[windSpeedIndex];
	}
	
	function getOptimalUpWindSpeed(weather) {
		var windSpeedIndex = knotsToRange(weather.windSpeed);
		return upwindSpeed[windSpeedIndex];
	}
	
	function getName() {
		return "Europe";
	}
}