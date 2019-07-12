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

class StartTimerView extends WatchUi.View {

    private var _timer = null;
    

    function initialize() {
        View.initialize();
        _timer = TimerNotifyService.getInstance();
        _timer.addListener(self);
    }

    //! Load your resources here
    function onLayout(dc) {
    }

    function onHide() {
    	_timer.removeListener(self);
    }

    //! Restore the state of the app and prepare the view to be shown
    function onShow() {
    	_timer.addListener(self);
    }

    //! Update the view
    function onUpdate(dc) {
    
    
        // Set background color
        dc.setColor( Graphics.COLOR_TRANSPARENT, Graphics.COLOR_BLACK );
        dc.clear();
        dc.setColor( Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT );
        dc.setPenWidth(1);

		var timer = _timer.getTimer().value();
		var timeString = (timer / 60).toString() + " : " + (timer % 60).toString();
        dc.drawText( (dc.getWidth() / 2), (dc.getHeight() / 2), Graphics.FONT_SYSTEM_NUMBER_HOT, timeString, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);

    }
    
	function timerChanged() {
		WatchUi.requestUpdate();
	}

}
