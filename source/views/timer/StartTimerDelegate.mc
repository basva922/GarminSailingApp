

class StartTimerDelegate extends PageDelegate {

    function initialize(index) {
        PageDelegate.initialize(index);
    }

    function onMenu() {
        WatchUi.pushView(new Rez.Menus.StartTimerMenu(), new StartTimerMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

    function onKey(evt) {
        var key = evt.getKey();
        if (WatchUi.KEY_ENTER == key) {
            TimerNotifyService.getInstance().syncToClosestMinute();
        } 
    }
	
}