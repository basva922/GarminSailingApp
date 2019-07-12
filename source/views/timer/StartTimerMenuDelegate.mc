using Toybox.WatchUi;
using Toybox.System;

class StartTimerMenuDelegate extends WatchUi.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item) {
    	var timer = TimerNotifyService.getInstance();
        if (item == :start_1) {
            timer.start(1);
        } else if (item == :start_4) {
            timer.start(4);
        } else if (item == :start_5) {
            timer.start(5);
        } else if (item == :start_10) {
            timer.start(10);
        }
    }

}