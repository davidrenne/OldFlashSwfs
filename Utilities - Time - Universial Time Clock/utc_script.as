/**
 * Universial Time Clock 
 * - a Modified version of FSmartClock
 *
 * Purpose: Simple cut and paste movie object that display universial
 *          time.  Clock relies on the local computer clock to determine
 *          GMT (or Universial Time) then by adding specified timezone
 *          to produce wanted display, also allowed multiple instance.
 *
 * Programmed by Andrew Yau (akayau@goconnect.net)
 * Copyright 2000 Jellyfish Production
 *
 *
 * Respect the author, please leave this comment along with original script. 
 * If you have made any modifications, please email the author, he would like 
 * to know your script, too!
 *
 * Any comments or suggestions, please email the author.
 *
 */

onClipEvent (load) {

    /**
     * Weekdays and Months Strings
     */
    var weekdays = new Array('Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday');
    var months = new Array('January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December');


    /**
     * Date Instance Variable
     */
    var timedate = new Date();
}



onClipEvent (enterFrame) {

    /** 
     * Timezone Setup
     */
    if (timezone != "local time" && timezone != "GMT") {
        timezone_hours = Number(timezone.substring(5,7));
        timezone_minutes = Number(timezone.substring(8,10));
        if (timezone.charAt(4) == "-") {
            timezone_hours *= -1;
            timezone_minutes *= -1;
        }
    } else if (timezone == "local time") {
        offset = -timedate.getTimezoneOffset();
        if (offset % 60 == 0) {
            timezone_hours = offset/60;
            timezone_minutes = 0;
        } else {
            timezone_hours = Math.floor(offset/60);
            timezone_minutes = offset - (60 * timezone_hours);
        }
    } else {       
        timezone_hours = 0;
        timezone_minutes = 0;     
    }
       
    timedate.setDate(timedate.getUTCDate());
    timedate.setHours(timedate.getUTCHours() + timezone_hours);
    timedate.setMinutes(timedate.getUTCMinutes() + timezone_minutes);

    /**
     * Other Variables
     */
    var hour = timedate.getHours();  
    var minutes = timedate.getMinutes();
    var seconds = timedate.getSeconds();
    var todaydate = timedate.getDate();
    var day = timedate.getDay();
    var dayname = weekdays[day];
    var month = timedate.getMonth();
    var monthname = months[month];
    var year = timedate.getFullYear();


    /**
     * Leading Zeroes Setup
     */
    if (length(minutes) == 1) {
        minutes = "0" add minutes;
    }
    if (length(seconds) == 1) {
        seconds = "0" add seconds;
    }


    /** 
     * Date Format Setup
     */
    if (date_display == "disable") {
        currentdate = "";
    } else if (date_display == "short date") {
        if (style == "american") {           
            currentdate = Number(month+1) add "/" add todaydate add "/" add year;
        } else {
            currentdate = todaydate add "/" add Number(month+1) add "/" add year;
        }
    } else {
        if (style == "american") {
            currentdate = monthname add " " add todaydate add ", " add year;
        } else {
            currentdate = todaydate add " " add monthname add ", " add year;
        }
    }


    /**
     * Time Format Setup
     */
    if (time_display == "disable") {
        currenttime = "";
    } else if (time_display == "12 hours") {
        if (hour < 12) {
            prefix = "am";
        } else {
            hour = hour - 12;
            prefix = "pm";
        }
        currenttime = hour add ":" add minutes add ":" add seconds add prefix add "  ";
    } else {
        currenttime = hour add ":" add minutes add ":" add seconds add "  ";
    }


    /**
     * Date Of Week Setup
     */
    if (date_of_week == "disable") {
        textfield = currenttime add currentdate;
    } else {
        textfield = currenttime add dayname add " " add currentdate;
    }


    /**
     * Refresh Date Instance
     */
    delete timedate;
    timedate = new Date();
}

