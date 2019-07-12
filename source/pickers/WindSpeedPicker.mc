using Toybox.WatchUi;


class WindSpeedPicker extends WatchUi.Picker {

    function initialize() {

        var title = new WatchUi.Text({:text=>"Choose wind speed", :locX=>WatchUi.LAYOUT_HALIGN_CENTER, :locY=>WatchUi.LAYOUT_VALIGN_BOTTOM, :color=>Graphics.COLOR_WHITE});
        var factories = [new NumberFactory(0, 50, 1, {})];
		var defaults = [AppData.getInstance().weather.windSpeed];
		
        Picker.initialize({:title=>title, :pattern=>factories, :defaults=>defaults});
    }

    function onUpdate(dc) {
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();
        Picker.onUpdate(dc);
    }
}

class WindSpeedPickerDelegate extends WatchUi.PickerDelegate {

    function initialize() {
        PickerDelegate.initialize();
    }

    function onCancel() {
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }

    function onAccept(values) {
        AppData.getInstance().weather.windSpeed = values[0];

        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }

}

