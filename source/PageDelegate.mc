//
// Copyright 2015-2016 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

using Toybox.WatchUi;

class PageDelegate extends WatchUi.BehaviorDelegate {
    private var _index;
    const N_PAGES = 3;

    function initialize(index) {
        WatchUi.BehaviorDelegate.initialize();

        _index = index;
    }

    function onNextPage() {
        _index = (_index + 1) % N_PAGES;
        WatchUi.switchToView(getView(_index), getDelegate(_index), WatchUi.SLIDE_DOWN);
    }

    function onPreviousPage() {
        _index = _index - 1;
        if (_index < 0) {
            _index = N_PAGES - 1;
        }
        WatchUi.switchToView(getView(_index), getDelegate(_index), WatchUi.SLIDE_UP);
    }

    function getView(index) {
        switch (index) {
        case 0:
        	return new SailingView();
        case 1:
        	return new StartTimerView();
       	case 2:
        	return new WindView();
        default:
        	return new SailingView();
        }

    }

    function getDelegate(index) {
        switch (index) {
        case 0:
        	return new SailingViewDelegate(index);
        case 1:
        	return new StartTimerDelegate(index);
        case 2:
        	return new SailingViewDelegate(index);
        default:
        	return new PageDelegate(index);
        }
    }

}
