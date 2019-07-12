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

class SailingView extends WatchUi.View {

    var posnInfo = null;
    var data = null;
    

    function initialize() {
        View.initialize();
        data = AppData.getInstance();
        
        LocationNotifyService.getInstance().addListener(self);
    }

    //! Load your resources here
    function onLayout(dc) {
    }

    function onHide() {
    
        LocationNotifyService.getInstance().removeListener(self);
    }

    //! Restore the state of the app and prepare the view to be shown
    function onShow() {
    
        LocationNotifyService.getInstance().addListener(self);
    }

    //! Update the view
    function onUpdate(dc) {
        var string;
        var speedScore;
        var weather = data.weather;
        var sailor = data.sailor;
        var boat = data.boat;

        // Set background color
        dc.setColor( Graphics.COLOR_TRANSPARENT, Graphics.COLOR_BLACK );
        dc.clear();
        dc.setColor( Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT );
        dc.setPenWidth(1);
        if( posnInfo != null && posnInfo.accuracy == Position.QUALITY_GOOD) {
                	
        	// True speed
       		// string = speedToText(sailor.getSpeed());
            // dc.drawText( (dc.getWidth() / 2), ((dc.getHeight() / 2) - 70), Graphics.FONT_SMALL, string, Graphics.TEXT_JUSTIFY_CENTER );
            
            // Avg speed
       		string = speedToText(sailor.getAvgSpeed());
            dc.drawText( (dc.getWidth() / 2), ((dc.getHeight() / 2) - 60), Graphics.FONT_LARGE, string, Graphics.TEXT_JUSTIFY_CENTER );            
                        
            // Show score
            speedScore = sailor.getSpeedScore(weather, boat);
        	dc.setColor(scoreToColorCode(speedScore), Graphics.COLOR_TRANSPARENT );
            dc.fillRectangle(0, ((dc.getHeight() / 2))-10, dc.getWidth() * 0.8 * speedScore, 20);
            
        	dc.setColor( Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT );
            dc.drawRectangle(0, ((dc.getHeight() / 2))-10, dc.getWidth() * 0.8, 20);
            
            dc.drawText( (dc.getWidth() * 0.90), (dc.getHeight() / 2)-10, Graphics.FONT_XTINY, speedToText(boat.getOptimalSpeed(weather, sailor.getHeading())), Graphics.TEXT_JUSTIFY_CENTER );
        	
        	// Show angle
        	var angleOffset = boat.getOptimalAngleOffset(weather, sailor.getHeading());
        	dc.setColor( angleOffset >= 0 ? Graphics.COLOR_GREEN : Graphics.COLOR_RED, Graphics.COLOR_TRANSPARENT );
            dc.drawText( (dc.getWidth() / 2), (dc.getHeight() / 2)+ 30, Graphics.FONT_LARGE, angleToString(angleOffset), Graphics.TEXT_JUSTIFY_CENTER );
        	
        	
        	
        	// Show Optimal wind angles
        	dc.setPenWidth(10);
        	dc.setColor( Graphics.COLOR_BLUE, Graphics.COLOR_TRANSPARENT );  
        	drawAngle(dc, boat.getOptimalDownWindAngle(weather));
        	drawAngle(dc, -boat.getOptimalDownWindAngle(weather));
        	drawAngle(dc, boat.getOptimalUpWindAngle(weather));
        	drawAngle(dc, -boat.getOptimalUpWindAngle(weather));
        	
        	// Show heading
        	dc.setColor( Graphics.COLOR_RED, Graphics.COLOR_TRANSPARENT );  
        	dc.setPenWidth(10);
        	drawAngle(dc, sailor.getAngleToTheWind(weather));
        	
        	
        }
        else if (posnInfo != null) {
            dc.drawText( (dc.getWidth() / 2), (dc.getHeight() / 2), Graphics.FONT_SMALL, "Waiting for better signal", Graphics.TEXT_JUSTIFY_CENTER );
        }
        else {
            dc.drawText( (dc.getWidth() / 2), (dc.getHeight() / 2), Graphics.FONT_SMALL, "No position info", Graphics.TEXT_JUSTIFY_CENTER );
        }
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
    
    function scoreToColorCode(score) {
   		if (score <= 0){
   			return 0xFF0000;
   		}
   		if (score >= 1){
   			return 0x00FF00;
   		}
   		if (score <= 0.5) {
   			return 0xFF0000 + Math.round((score/0.5)*256)*256;
   		}
   		else {
   			return 0x00FF00 + Math.round(((1-score)/0.5)*256)*256*256;
   		}
    }
    
    

    function locationChanged(info) {
    	info.speed *= 1.9438;
    	info.heading = Math.toDegrees(info.heading);
        posnInfo = info;
        data.sailor.setPositionUpdate(info);
        WatchUi.requestUpdate();
    }


}
