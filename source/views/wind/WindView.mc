//!
//! Copyright 2015 by Garmin Ltd. or its subsidiaries.
//! Subject to Garmin SDK License Agreement and Wearables
//! Application Developer Agreement.
//!

using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Lang;
using Toybox.Math;
using Toybox.Position;
using Toybox.Activity;

class WindView extends WatchUi.View {

    var data = null;
    

    function initialize() {
        View.initialize();
        data = AppData.getInstance();
    }

    //! Load your resources here
    function onLayout(dc) {
    }

    function onHide() {
    
    }

    //! Restore the state of the app and prepare the view to be shown
    function onShow() {
    	WatchUi.requestUpdate();
    }

    //! Update the view
    function onUpdate(dc) {
        var string;
        var weather = data.weather;
        var boat = data.boat;

        // Set background color
        dc.setColor( Graphics.COLOR_TRANSPARENT, Graphics.COLOR_BLACK );
        dc.clear();
        dc.setColor( Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT );
        dc.setPenWidth(1);
    
    	// Wind data
    	string = "wind: " + angleToString(weather.windAngle);
    	dc.drawText( (dc.getWidth() / 2), ((dc.getHeight() / 2) - 80), Graphics.FONT_XTINY, string, Graphics.TEXT_JUSTIFY_CENTER );
    	string = "wind: " + speedToText(weather.windSpeed);
    	dc.drawText( (dc.getWidth() / 2), ((dc.getHeight() / 2) - 95), Graphics.FONT_XTINY, string, Graphics.TEXT_JUSTIFY_CENTER );
    	
    	// Boat type
    	string = "boat: " + boat.getName();
    	dc.drawText( (dc.getWidth() / 2), ((dc.getHeight() / 2) - 40), Graphics.FONT_XTINY, string, Graphics.TEXT_JUSTIFY_CENTER );
    	
    	
    	// Upwind
    	dc.drawText( (dc.getWidth() / 2) - 50, ((dc.getHeight() / 2)), Graphics.FONT_XTINY, "Upwind", Graphics.TEXT_JUSTIFY_CENTER );
    	string = angleToString(boat.getOptimalUpWindAngle(weather));
    	dc.drawText( (dc.getWidth() / 2) - 50, ((dc.getHeight() / 2) + 20), Graphics.FONT_XTINY, string, Graphics.TEXT_JUSTIFY_CENTER );
    	string = speedToText(boat.getOptimalUpWindSpeed(weather));
    	dc.drawText( (dc.getWidth() / 2) - 50, ((dc.getHeight() / 2) + 40), Graphics.FONT_XTINY, string, Graphics.TEXT_JUSTIFY_CENTER );    	
    	
    	// Downwind
    	dc.drawText( (dc.getWidth() / 2) + 50, ((dc.getHeight() / 2)), Graphics.FONT_XTINY, "Downwind", Graphics.TEXT_JUSTIFY_CENTER );
    	string = angleToString(boat.getOptimalDownWindAngle(weather));
    	dc.drawText( (dc.getWidth() / 2) + 50, ((dc.getHeight() / 2) + 20), Graphics.FONT_XTINY, string, Graphics.TEXT_JUSTIFY_CENTER );
    	string = speedToText(boat.getOptimalDownWindSpeed(weather));
    	dc.drawText( (dc.getWidth() / 2) + 50, ((dc.getHeight() / 2) + 40), Graphics.FONT_XTINY, string, Graphics.TEXT_JUSTIFY_CENTER );
    	
    	
    	// Show Optimal wind angles
    	dc.setPenWidth(10);
    	dc.setColor( Graphics.COLOR_BLUE, Graphics.COLOR_TRANSPARENT );  
    	drawAngle(dc, boat.getOptimalDownWindAngle(weather));
    	drawAngle(dc, -boat.getOptimalDownWindAngle(weather));
    	drawAngle(dc, boat.getOptimalUpWindAngle(weather));
    	drawAngle(dc, -boat.getOptimalUpWindAngle(weather));
    	        	
    }
    
	function drawAngle(dc, angle) {
		angle -= 90;
    	var m = dc.getWidth() / 2;     
    	var x = Math.cos(Math.toRadians(angle))*m + m;
    	var y = Math.sin(Math.toRadians(angle))*m + m;
    	dc.drawPoint(x, y);
	}
	
	function angleToString(angle) {
		return Math.round(angle).toNumber().toString() + "°";
	}
    
    function speedToText(speed) {
	    var string = speed.toString();
        var i = string.find(".");
        if (i == null) {return string + " kt"; }
        
        return string.substring(0, i+3) + " kt";
    }
    
}
