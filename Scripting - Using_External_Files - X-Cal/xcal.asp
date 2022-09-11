<HTML>
<HEAD>
<TITLE>X-Cal 1.0</TITLE>





<SCRIPT LANGUAGE="JavaScript">
<!--
var flasher = false
function MakeArray(n) {
	this.length = n
	return this
}
monthNames = new MakeArray(12)
monthNames[1] = "1"
monthNames[2] = "2"
monthNames[3] = "3"
monthNames[4] = "4"
monthNames[5] = "5"
monthNames[6] = "6"
monthNames[7] = "7"
monthNames[8] = "8"
monthNames[9] = "9"
monthNames[10] = "10"
monthNames[11] = "11"
monthNames[12] = "12"

dayNames = new MakeArray(7)
dayNames[1] = "Sunday"
dayNames[2] = "Monday"
dayNames[3] = "Tuesday"
dayNames[4] = "Wednesday"
dayNames[5] = "Thursday"
dayNames[6] = "Friday"
dayNames[7] = "Saturday"

function time()
  {
var InternetExplorer = navigator.appName.indexOf("Microsoft") != -1;
var map = InternetExplorer ? clocka : document.embeds[0];
	var today=new Date();
        var theDay=dayNames[today.getDay() + 1]
        var theDate=today.getDate() 
        var theMonth = monthNames[today.getMonth() + 1]
        var year=today.getFullYear()
        var min=today.getMinutes()
	var hr=today.getHours()
        var theTime = "" + ((hr> 12) ? hr - 12 : hr)
	theTime += ((min < 10) ? ":0" : ":") + min
	theTime  += (hr >= 12) ? " pm" : " am"
        theTime += ((flasher) ? " " : "*")
        flasher = !flasher
        map.SetVariable('theTime', theTime)
        map.SetVariable('date', theDate)
        map.SetVariable('fminutes', min)
        map.SetVariable('fhours', hr)
	map.SetVariable('fday', theDay)
	map.SetVariable('fmonth', theMonth)
	map.SetVariable('fyear', year)
	timerID=setTimeout("time()",1000)
  }  
//-->
</SCRIPT>
</HEAD>
<BODY onload="time()" bgcolor="#FFFFCC" topmargin="0" leftmargin="0">
<table border="0" width="1028" cellspacing="0" cellpadding="0" bgcolor="#610E0E">
  <tr>
    <td width="4">
      <p align="center">&nbsp;</p>
    </td>
    <td width="568"><img border="0" src="file:///C:/Documents%20and%20Settings/jamin/Desktop/WORK/Mcakister/images/baner2.gif"></td>
    <td width="451" bgcolor="#610E0E"><img border="0" src="images/bbg.gif"></td>
  </tr>
</table>
<table border="0" width="145%" cellspacing="0" cellpadding="0">
  <tr>
    <td hight width="31%" bgcolor="#610E0E">
      <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=5,0,0,0" WIDTH="637" HEIGHT="26">
        <param NAME="movie" VALUE="nav.swf">
        <param NAME="quality" VALUE="high">
        <param NAME="bgcolor" VALUE="#660000"><embed src="nav.swf" quality="high" bgcolor="#660000" WIDTH="637" HEIGHT="26" TYPE="application/x-shockwave-flash" PLUGINSPAGE="http://www.macromedia.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash">
      </object>
    </td>
  </tr>
</table>
<font color="#000000">X-CAL&nbsp; Calendar Beta 1.0&nbsp;</font>
<p>
<OBJECT classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
 codebase="http://active.macromedia.com/flash2/cabs/swflash.cab#version=4,0,0,0"
 ID=clocka WIDTH=100% HEIGHT=100%>
  <PARAM NAME=movie VALUE="calendar.swf">
  <PARAM NAME=quality VALUE=high>
  <PARAM NAME=bgcolor VALUE=#660000>
  <EMBED  src="DigitalClock2.swf" quality=high bgcolor=#000000  WIDTH=100% HEIGHT=100%	swLiveConnect=true
 TYPE="application/x-shockwave-flash" PLUGINSPAGE="http://www.macromedia.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash">
  </EMBED> 
</OBJECT> 
</p>
<table border="0" width="100%" bgcolor="#610E0E" cellspacing="0" cellpadding="0">
  <tr>
    <td width="100%"><a href="http://www.ctechcharleston.com"><font size="1" color="#FFFFCC">Copyright
      2000,© Computer Technologies Inc. All Rights Reserved.</font></a>
      <p><font size="1" color="#FFFFCC">X-CAL&nbsp; Calendar Beta 1.0 Copyright
      2000,© Jamin Quimby All Rights Reserved.&nbsp; (An Employee of Computer
      Technologies Web Programming Team)</font></p>
    </td>
  </tr>
</table>
</BODY>
</HTML>
