using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Time.Gregorian as Calendar;
using Toybox.Time as Time;
using Toybox.ActivityMonitor as Act;

class batmanView extends Ui.WatchFace {
		
	function initialize() {
        WatchFace.initialize();
        }

    //! Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    //! Called when this View is brought to the foreground. Restore
    //! the state of this View and prepare it to be shown. This includes
    //! loading resources into memory.
    function onShow() {
    }

    //! Update the view
    function onUpdate(dc) {
    	
    	// Get steps, update the field
        var act = Act.getInfo( );
        if( act.stepGoal == 0 ) {

            act.stepGoal = 5000;

        }
        // Get and show the current time
        var now = Time.now();
        var today = Calendar.info(now, Time.FORMAT_MEDIUM);
        var settings=Sys.getDeviceSettings();
        var systemStats = Sys.getSystemStats();
        var flags = "";
    	if (settings.notificationCount>0) {flags = flags + "l";}
        var dateString=Lang.format("$1$ $2$",[today.day_of_week,today.day]);
        var stepString = act.steps.toString( ) + " / " + act.stepGoal.toString( );
        var timeString;
                
        if(settings.is24Hour) {
        	timeString = Lang.format("$1$:$2$", [today.hour, today.min.format("%.2d")]);
        }
        else {
			var hour = today.hour % 12;
            hour = (hour == 0) ? 12 : hour;
            timeString = Lang.format("$1$:$2$", [hour, today.min.format("%.2d")]);
        }
        var view = View.findDrawableById("TimeLabel");
        view.setText(timeString);
        
        view = View.findDrawableById("DateLabel");
        view.setText(dateString);
        
        view = View.findDrawableById("StepLabel");
        view.setText(stepString);
        
        view = View.findDrawableById("flags");
        view.setText(flags);
        
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    //! Called when this View is removed from the screen. Save the
    //! state of this View here. This includes freeing resources from
    //! memory.
    function onHide() {
    }

    //! The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
    }

    //! Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
    }

}