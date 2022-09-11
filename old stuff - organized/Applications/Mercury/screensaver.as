// ----------- params, should be in admin screen
application = "MercuryWeb"; // MercuryScr | MercuryApp | MercuryWeb | MercuryIEtoolbar | MercuryTicker
version = 1.3;   // > > > See rss_and_flash.php VERSION number
//
offset = 000;
curChannelID = 1;
finishedLoading = 0;
channelsArray = new Array();
channelsHTMLArray = new Array();
// ----------- params, coming from html/php/asp/jsp page
ipnrs = _level0.ipnrs;
// get IP number for logging, either from html file or from projector application
// variable is passed as <filename.swf>?ipnrs=<value>
ipNRLogged = false;
// logs user, if not done already
//
// ----------- params, should be in user screen
step = 6;
// scroll speed for titles
//
//scrollingContent._width=100;
loadStylesheet();
// loads stylesheet
// ------------------------------------------------------------------
function loadStylesheet() {
	var format = new TextField.StyleSheet();
	var path = "http://www.keizerkarelpodia.nl/css/flash.css";
	var quick = "loading...";
	format.load(path);
	format.onLoad = function(loaded) {
		if (loaded) {
			scrollingContent.styleSheet = format;
			output.text = quick;
		} else {
			output.text = "Error loading CSS file!";
		}
	};
}

// ------------------------------------------------------------------
function logUsage() {
	trace("logUsage");
	myLVUsage = new LoadVars();
	myLVUsage.a = "logUsage";
	myLVUsage.ipnrs = ipnrs;
	myLVUsage.application = application;
	myLVUsage.version = version;
	myLVUsage.onLoad = function(success) {
		if (success) {
			trace.htmlText = this.trace;
			error_length = this.p_error.length+0;
			if (error_length>0) {
				dialogue = "p_error"+p_error+", "+error_length;
			}
			//content;
		} else {
			message = "<b><font color=\"#ff0000\">Server not found</font></b>";
			trace("SERVER NOT FOUND");
			trace("you're an utterly stupid cow!!!!!!");
		}
	};
	myLVUsage.sendAndLoad("http://www.keizerkarelpodia.nl/cms/flash/rss_and_flash.php", myLVUsage, "POST");
}
// ------------------------------------------------------------------
function gotoPrefs() {
	message = "You will be directed to a URL to personalise your RSS feeds.<br>Press the close button to go back to the ticker or <a href=\"asfunction:resetPrefs\"><u>log off</u></a>.";
	trace(cookie.data.RSSID);
	cookie = SharedObject.getLocal("flashCookie");
	if (cookie.data.RSSID != undefined && cookie.data.RSSID>0) {
		trace(cookie.data.RSSID);
		redirectTo = cookie.data.redirect;
		getURL(redirectTo, "_blank");
		gotoAndPlay(5);
	} else {
		gotoAndPlay(6);
	}
}
// ------------------------------------------------------------------
function resetPrefs() {
	trace("resetting prefs");
	// local resetting of cookies
	cookie.clear();
	// remote resetting of cookies
	myLV = new LoadVars();
	myLV.a = "logoff";
	myLV.onLoad = function(success) {
		if (success) {
			message = this.message;
			trace(message);
			error_length = this.p_error.length+0;
			if (error_length>0) {
				dialogue = "p_error"+p_error+", "+error_length;
			}
			//content;
		} else {
			message = "<b><font color=\"#ff0000\">Server not found</font></b>";
			trace("SERVER NOT FOUND");
			trace("you're an utterly stupid cow!!!!!!");
		}
	};
	myLV.sendAndLoad("http://www.keizerkarelpodia.nl/cms/flash/rss_and_flash.php", myLV, "POST");
	trace("cleared prefs");
}
// ------------------------------------------------------------------
function gotoAbout() {
	if (finishedLoading == 0) {
		scrollingContent.text = "<b>Not yet finished loading</b><br><br>Please wait...<br>";
	} else {
		displayAbout();
	}
}
// ------------------------------------------------------------------
// retrieve feed from selected channel
function getFeed(title, mode) {
	content = "retrieveing feed from source";
	myLV = new LoadVars();
	myLV.a = "getFeed";
	myLV.version = "sc1";
	myLv.timestamp = new Date();
	myLV.title = title;
	myLV.onLoad = function(success) {
		if (success) {
			titles = this.titles;
			if (titles>0) {
				populateTitleBar();
				populateTextArea();
				// position feed logo
				logo_img_w = this.logo_img_w;
				logo_img_h = this.logo_img_h;
				logo_pos_width = 125;
				logo_pos_height = 35;
				mcImage._x = -85+logo_pos_width-logo_img_w;
				mcImage._y = -184+logo_pos_height-logo_img_h;
				// place logo
				img_url = this.img_url;
				mcImage.loadMovie(img_url);
				// position feed Image
				feedImg_w = this.feedImg_w;
				feedImg_h = this.feedImg_h;
				feedImage._x = 40-feedImg_w;
				// place feed Image
				feedImg_url = this.feedImg_url;
				feedImage.loadMovie(feedImg_url);
				// place caption with image
				caption = this.caption;
				captionField.removeTextField();
				// first remove any existing text field
				caption_x = feedImage._x;
				caption_w = feedImg_w;
				caption_h = 5;
				caption_y = feedImg_h-76;
				createTextField("captionField", 2, caption_x, caption_y, caption_w, caption_h);
				with (captionField) {
					htmlText = caption;
					multiline = true;
					wordWrap = true;
					autoSize = "left";
					border = true;
					borderColor = 0x000000;
					background = true;
					backgroundColor = 0x63767C;
				}
				// Formatting text
				myFormat = new TextFormat();
				myFormat.font = "_sans";
				myFormat.size = 10;
				myFormat.color = 0xffffff;
				captionField.setTextFormat(myFormat);
				// apply format
			}
			error_length = this.p_error.length+0;
			if (error_length>0) {
				dialogue = "p_error"+p_error+", "+error_length;
			}
			//content;
		} else {
			message = "<b><font color=\"#ff0000\">Server not found</font></b>";
			trace("SERVER NOT FOUND");
			trace("you're an utterly stupid cow!!!!!!");
		}
	};
	myLV.sendAndLoad("http://www.keizerkarelpodia.nl/cms/flash/rss_and_flash.php", myLV, "POST");
}
// ------------------------------------------------------------------
function populateTitleBar() {
	// titles within channel
	titles = myLV.titles;
	titleStr = '';
	for (i=1; i<titles+1; i++) {
		var thisTitle = eval("myLV.title"+i);
		l = Number(thisTitle.length);
		if (l>0) {
			titleStr += " +++ "+thisTitle;
		}
	}
	titleStr += " +++ ";
	feedTitles.titleStr.multiline = false;
	feedTitles.titleStr.wordWrap = false;
	feedTitles.titleStr.autoSize = "left";
	feedTitles.titleStr._width = 1;
	feedTitles.titleStr.htmlText = titleStr;
	finishedLoading = 1;
}
// ------------------------------------------------------------------
function populateTextArea(title) {
	titles = myLV.titles;
	scrollingContent.text = myLV.content;
}
// ------------------------------------------------------------------
// populate the combobox with channels
function populateChannelTicker() {
	rssChannels = myLV.channels;
	strLength = myLV.strLength;
	allChannelTitles = '';
	for (i=1; i<=Number(rssChannels); i++) {
		var label = eval("myLV.plain"+i);
		pushed = channelsArray.push(label);
		var label = eval("myLV.channel"+i);
		pushed = channelsHTMLArray.push(label);
	}
}
// ------------------------------------------------------------------
// get all channels from php script
function getChannels() {
	// stylesheet
	var css = new TextField.StyleSheet();
	myLV = new LoadVars();
	myLV.a = "getChannels";
	myLV.version = 2;
	//determines the resultstring
	myLV.onLoad = function(success) {
		if (success) {
			// check version
			checkedVersion = this.version;
			updateVersionText = this.updateVersionText;
			if (checkedVersion>version) {
				attachMovie("mc_messages", "mc_messages", 2);
				mc_messages._x = -220.1;
				mc_messages._y = -181.3;
				_level0.RSS_pane_ticker.mc_messages.messages.htmlText = updateVersionText;
			}
			// look for the number of channels
			rssChannels = this.channels;
			trace("Number of channels: "+rssChannels);
			if (rssChannels>0) {
				if (mode == 'sc1') {
					populateChannelTicker();
				} else {
					populateChannelTicker();
				}
			}
			error_length = this.p_error.length+0;
			if (error_length>0) {
				dialogue = "p_error"+p_error+", "+error_length;
			}
			//content;
			getAllChannelTitles();
		} else {
			message = "<b><font color=\"#ff0000\">Server not found</font></b>";
			trace("SERVER NOT FOUND");
			trace("you're an utterly stupid cow!!!!!!");
		}
	};
	myLV.sendAndLoad("http://www.keizerkarelpodia.nl/cms/flash/rss_and_flash.php", myLV, "POST");
}
// ------------------------------------------------------------------
function getAllChannelTitles() {
	channelTitles.multiline = false;
	channelTitles.wordWrap = false;
	channelTitles.channelTitle.autoSize = "left";
	channelTitles.channelTitle.htmlText = channelsArray[curChannelID];
	//
	fading.title.multiline = false;
	fading.title.wordWrap = false;
	fading.title.autoSize = "left";
	fading.title.htmlText = channelsArray[curChannelID];
	//
	feedTitles.titleStr._width = 1;
	getFeed(channelsArray[curChannelID], "sc1");
}
// ------------------------------------------------------------------
function showNextChannel() {
	curChannelID += 1;
	// rewind to first channel
	if (curChannelID>channelsArray.length-1) {
		curChannelID = 1;
	}
	scrollingContent.text += "<br>Loading next channel... <br>"+curChannelID+", "+channelsArray.length+", "+channelsArray[curChannelID];
	// display active channel title
	channelTitles.channelTitle._width = 1;
	channelTitles.channelTitle.htmlText = channelsArray[curChannelID];
	//
	fading.title.multiline = false;
	fading.title.wordWrap = false;
	fading.title.autoSize = "left";
	fading.title.htmlText = channelsArray[curChannelID];
	//
	// display article titles within channel
	feedTitles.titleStr.htmlText = '';
	feedTitles.titleStr._width = 1;
	finishedLoading = 0;
	getFeed(channelsArray[curChannelID], "sc1");
	//	getFeed(channelsArray[curChannelID], "sc1.content");
}
// ------------------------------------------------------------------
function displayAbout() {
	curChannelID = 0;
	scrollingContent.text += "<br>"+curChannelID+", "+channelsArray.length+", "+channelsArray[curChannelID];
	// display active channel title
	channelTitles.channelTitle._width = 1;
	channelTitles.channelTitle.htmlText = channelsArray[curChannelID];
	//
	fading.title.multiline = false;
	fading.title.wordWrap = false;
	fading.title.autoSize = "left";
	fading.title.htmlText = channelsArray[curChannelID];
	//
	// display article titles within channel
	feedTitles.titleStr.htmlText = '';
	feedTitles.titleStr._width = 1;
	finishedLoading = 0;
	getFeed(channelsArray[curChannelID], "sc1");
	//	getFeed(channelsArray[curChannelID], "sc1.content");
}
// ------------------------------------------------------------------
getChannels();
