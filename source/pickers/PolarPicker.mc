using Toybox.Graphics;
using Toybox.WatchUi;

class PolarPicker extends WatchUi.Picker {

    function initialize() {
        var title = new WatchUi.Text({:text=>"Pick boat", :locX =>WatchUi.LAYOUT_HALIGN_CENTER, :locY=>WatchUi.LAYOUT_VALIGN_BOTTOM, :color=>Graphics.COLOR_WHITE});
        var factory = new WordFactory(["Europe", "None"], {:font=>Graphics.FONT_MEDIUM});
        Picker.initialize({:title=>title, :pattern=>[factory]});
    }

    function onUpdate(dc) {
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();
        Picker.onUpdate(dc);
    }
}

class PolarPickerDelegate extends WatchUi.PickerDelegate {

    function initialize() {
        PickerDelegate.initialize();
    }

    function onCancel() {
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }

    function onAccept(values) {
    	System.println("Chose the following boat: " + values[0]);
        if(values[0] == "Europe") {
            AppData.getInstance().boat = new Europe();
        }
		
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }

}
