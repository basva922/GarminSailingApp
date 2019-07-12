//!
//! Copyright 2015 by Garmin Ltd. or its subsidiaries.
//! Subject to Garmin SDK License Agreement and Wearables
//! Application Developer Agreement.
//!

using Toybox.Application;
using Toybox.Position;
using Toybox.ActivityRecording;

class SailingApp extends Application.AppBase {

    var view;
    var session = null;

    function initialize() {
        AppBase.initialize();
        var data = AppData.getInstance();
        data.weather = new Weather(12, 0);
        data.boat = new Europe();
       	data.sailor = new Sailor();
    }

    //! onStart() is called on application start up
    function onStart(state) {
        Position.enableLocationEvents(Position.LOCATION_CONTINUOUS, method(:onPosition));
    	Sensor.setEnabledSensors( [Sensor.SENSOR_HEARTRATE, Sensor.SENSOR_TEMPERATURE] );
        session = ActivityRecording.createSession({:name=>"Sailing", :sport=>ActivityRecording.SPORT_GENERIC});
    }

    //! onStop() is called when your application is exiting
    function onStop(state) {
        Position.enableLocationEvents(Position.LOCATION_DISABLE, method(:onPosition));
        if ((session != null) && session.isRecording()){
        	session.stop();
        	session.save();
        	
        	System.println("Stoped and saved recording");
        }
    }

    function onPosition(info) {
		LocationNotifyService.getInstance().notifyAll(info);
        if ((info.accuracy == Position.QUALITY_GOOD) && !session.isRecording()) {
        	System.println("Start recording");
        	session.start();
        }
    }

    //! Return the initial view of your application here
    function getInitialView() {
        view = new SailingView();
        return [ view , new SailingViewDelegate(0) ];
    }
    
    

}
