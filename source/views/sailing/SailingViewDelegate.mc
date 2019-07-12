

class SailingViewDelegate extends PageDelegate {

    function initialize(index) {
        PageDelegate.initialize(index);
    }

    function onMenu() {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new SailingViewMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

}