//--------------------------------------------------------------------//
//	Banner Ad Rotator version 2.0
//	Author: Brian Weil
//	Email: brian@brianweil.com
//	Web: http://brianweil.com
//--------------------------------------------------------------------//

DESCRIPTION:
----------------------
This is a Flash MX application handy for managing the rotation of banners through a simple xml file. 
You can edit the XML file to add /remove or modify the behavior of the advertisements. 
The first Banner is randomly selected, then the banners are rotated in the order they are listed in the XML file.
The first version was built in Flash 4 and distributed through FlashKit. Using feedback from various 
users around the world, I modified the text file syntax into an xml format and added several requested features.
The code should be portable to flash 5*, but the movie must be exported in flash 5 swf format.

*NOTE: Flash 5 will not support JPG banners.

NEW FEATURES:
---------------------------
1. The external text file now uses xml instead of the old URLencoded text format. This simplifies the management of your banner library.

2. Banner specific timeouts. The prior version used a global timeout value for all banners. The new version allows you to override this value by using a timeout attribute in the banner tag.

3. Target window option. If you are using frames or need to target a new window you may specify the target in the banner attributes.

4. Absoulte URL support. You may now use absolute or relative URLs in both the src and href attributes of the banner.

5. JPG banners now supported. Flash MX allows loading JPG files, so the banner may be a swf or jpg file.

6. Button Disabling. If your Flash banner has buttons inside, you may want to disable the global button. This is done by excluding the href attribute from the banner tag.

USAGE:
------------
The swf file can be EMBEDed into HTML or the banner movieClip can be copied into an existing flash movie.
All code for the application is on the banner movieclip instance. You MUST copy the instance from the stage, NOT the library if you need to use the application in another flash movie.
All configuration is done in the xml file: "banners.xml", the Flash file DOES NOT require any editing.

CONFIGURATION:
---------------------------
These instructions assume that you are at least partially familiar with XML.
The banners.xml file has two basic parts the <banners> tag and the <banner> tags.

1.The <banners> tag must have a timeout attribute. This is the length of time, in seconds, for which each banner will be visible. This MUST be the first tag in the XML document.

EXAMPLE, the following tag will display the banners for 20 seconds, then rotate to the next banner:

<banners timeout="20">

2. The <banner> tags must be nested within the <banners> tag. And must contain at least, the src attribute.

EXAMPLE 
<banners timeout="20">
	<banner src="example.swf" />
</banners>

3. The <banner> tag has three optional attributes, href , window and timeout. 

The href attribute is the url that the banner will link to. If none is provided, it is assumed that you have links within the swf banner, and the global button is not activated. The value may be an absolute or relative URL. The "javascript:" protocol can also be used to call client side javascript from the banner click.

EXAMPLE:
<banners timeout="20">
	<banner src="example.swf" href="http://example.com" />
	<banner src="popup.jpg" href="javascript:popWindow();" />
</banners>

The window attribute is only useful if you provide the href attribute. This specifies the target window in which the link will open. The default value is set to "_self", so if window is not specified, the link will open in the same window. Other acceptible values are: "_parent", _"top","_blank", or the id of any named window or frame.

EXAMPLE:
<banners timeout="20">
	<banner src="example.swf" href="http://example.com" window="_blank" />
	<banner src="example.jpg" href="example.htm" window="mainFrame" />
</banners>

The timeout attribute of the <banner> tag will override the timeout attribute of the <banners> tag for the specified banner. Suppose one of your banners contains a 30 second animation, but all of the others are standard jpg banners that only need to be visible for 15 seconds. 

EXAMPLE:
<banners timeout="15">
	<banner src="30second-ani.swf" timeout="30" />
	<banner src="example.jpg" href="example.htm" />
	<banner src="example2.jpg" href="example2.htm" />
</banners>

--- xxx ---