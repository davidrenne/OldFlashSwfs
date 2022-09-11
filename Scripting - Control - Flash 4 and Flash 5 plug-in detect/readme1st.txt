Flash 5 and Flash 4 detect

I've tried many flash plug-in detect from different sites. However, the problem I had was that Flash 5 and Flash 4 have the same Mime.Types name and plugin names.

After a few poking arounds, I decided to write my own flash movie to differentiate Flash 5 from Flash 4. To do this, I exploited the Flash 5 "bug" that will not jump to a concatenated label using Flash 4 scripting.

This "bug" is documented on Macromedia at:
http://www.macromedia.com/support/flash/ts/documents/goto_expression.htm

WARNING: The FLA is written in Flash 4 and due to this "bug" Flash 5 will "fail to open the document".