

class AppData {
	var weather = null;
	var sailor = null;
	var boat = null;
	
	static var thisObj = null;
	
	static function getInstance() {
	 	if (thisObj == null) {
	 		thisObj = new AppData();
	 	}
	 	return thisObj;
	}
}