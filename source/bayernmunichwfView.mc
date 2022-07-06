import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class bayernmunichwfView extends WatchUi.WatchFace {

	var image;
	var font;

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
    	font = WatchUi.loadResource(Rez.Fonts.font);
    	image = WatchUi.loadResource(Rez.Drawables.Logo);
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Get the current time and format it correctly
        var timeFormat = "$1$:$2$";
        var hourFormat = "$1$";
        var minuteFormat = "$1$";
        var clockTime = System.getClockTime();
        var hours = clockTime.hour;
        if (!System.getDeviceSettings().is24Hour) {
            if (hours > 12) {
                hours = hours - 12;
            }
        } else {
            if (getApp().getProperty("UseMilitaryFormat")) {
                //timeFormat = "$1$$2$";
                hourFormat = "$1$";
        		minuteFormat = "$2$";
                hours = hours.format("%02d");
            }
        }
        
        var hoursString = Lang.format(hourFormat, [hours]);
        var minutesString = Lang.format(minuteFormat, [clockTime.min.format("%02d")]);
 
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
        
        var widthScreen = dc.getWidth();
		var heightScreen = dc.getHeight();
  		var heightCenter = heightScreen / 2;
  		var widthCenter = widthScreen / 2;
  		var widthHour = widthScreen / 6;
        var widthMinute = (widthScreen / 6) * 5;
        var heightTime = heightCenter - 34;
  		
  		dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_WHITE);
        dc.fillRectangle(widthCenter - 25, 0, 10, heightScreen);
        
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_WHITE);
        dc.fillRectangle(widthCenter -5, 0, 10, heightScreen);
        
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_WHITE);
        dc.fillRectangle(widthCenter + 15, 0, 10, heightScreen);
        
        dc.drawBitmap(widthCenter -50,heightCenter - 50, image);
        
        dc.setColor(getApp().getProperty("ForegroundColor"), Graphics.COLOR_TRANSPARENT);
		dc.drawText(widthHour , heightTime, font, hoursString, Graphics.TEXT_JUSTIFY_CENTER);
		
		dc.setColor(getApp().getProperty("ForegroundColor"), Graphics.COLOR_TRANSPARENT);
		dc.drawText(widthMinute , heightTime,font, minutesString, Graphics.TEXT_JUSTIFY_CENTER);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {
    }

}
