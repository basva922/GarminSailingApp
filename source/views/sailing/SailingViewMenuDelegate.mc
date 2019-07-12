using Toybox.WatchUi;
using Toybox.System;

class SailingViewMenuDelegate extends WatchUi.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item) {
    	var data = AppData.getInstance();
        if (item == :port_tack) {
            data.boat.changeAngleToSailingPortTack(data.weather, data.sailor.getHeading());
        } else if (item == :sb_tack) {
            data.boat.changeAngleToSailingSBTack(data.weather, data.sailor.getHeading());
        } else if  (item == :set_wind_speed) {
            System.println("WindSpeed");
        	var windSpeedPicker = new WindSpeedPicker();
            WatchUi.pushView(
                windSpeedPicker,
                new WindSpeedPickerDelegate(),
                WatchUi.SLIDE_IMMEDIATE
            );
        } else if  (item == :polar_picker) {
            System.println("Boat picker");
        	var boatPicker = new PolarPicker();
            WatchUi.pushView(
                boatPicker,
                new PolarPickerDelegate(),
                WatchUi.SLIDE_IMMEDIATE
            );
        }
    }

}