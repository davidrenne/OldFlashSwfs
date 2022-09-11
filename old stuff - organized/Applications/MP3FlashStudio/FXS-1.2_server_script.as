XML.prototype.ignoreWhite = true;
serverData = new XML();
serverData.load(serverfile);
n=100;

imove = new Array();

function serverSetup () {
		rootChild = serverdata.firstChild;
		if(rootChild.nodeName == "server"){
			if (rootChild.attributes.startPosY != "" and rootChild.attributes.startPosY != null){
				startPosY = Number(rootChild.attributes.startPosY);
				udScroll._y=startPosY;
			}
			if (rootChild.attributes.startPosX != "" and rootChild.attributes.startPosX != null){
				startPosX = Number(rootChild.attributes.startPosX);
				ssScroll._x=startPosX;
			}
			if (rootChild.attributes.xspace != "" and rootChild.attributes.xspace != null){
				xspace = Number(rootChild.attributes.xspace);
			}
			if (rootChild.attributes.yspace != "" and rootChild.attributes.yspace != null){
				yspace = Number(rootChild.attributes.yspace);
			}
			if (rootChild.attributes.speed != "" and rootChild.attributes.speed != null){
				speed = Number(rootChild.attributes.speed);
			}
			if (rootChild.attributes.barrierX != "" and rootChild.attributes.barrierX != null){
				barrierX = Number(rootChild.attributes.barrierX);
				udScroll._x= Number(rootChild.attributes.barrierX);
			}
			if (rootChild.attributes.barrierY != "" and rootChild.attributes.barrierY != null){
				barrierY = Number(rootChild.attributes.barrierY);
				ssScroll._y = Number(rootChild.attributes.barrierY);
			}
			if (rootChild.attributes.scrollfunc != "" and rootChild.attributes.scrollfunc != null){
				scrollfunc = String(rootChild.attributes.scrollfunc);
			}
			if (rootChild.attributes.sound != "" and rootChild.attributes.sound != null){
				if (rootChild.attributes.sound == "true" or rootChild.attributes.sound == true){
					soundStart = true;
				}
				if (rootChild.attributes.sound == "false" or rootChild.attributes.sound == false){
					soundStart = false;
				}
			}
			if (rootChild.attributes.defaultOverSound != null){
				defaultOverSound = rootChild.attributes.defaultOverSound;
			}	
			if (rootChild.attributes.defaultClickSound != null){
				defaultClickSound = rootChild.attributes.defaultClickSound;
			}
			if(rootChild.attributes.sideScrollYDeviation != null){
				_root.sideScrollYDeviation = Number(rootChild.attributes.sideScrollYDeviation);
			}
			if(rootChild.attributes.bottomScrollXDeviation != null){
				_root.bottomScrollXDeviation = Number(rootChild.attributes.bottomScrollXDeviation);
				_root.ssScroll._x= startPosX + _root.bottomScrollXDeviation;
			}
			if(rootChild.attributes.highlightEnabled != null){
				if(rootChild.attributes.highlightEnabled=="false"){
					_root.highlightEnabled=false;
				}else if(rootChild.attributes.highlightEnabled=="true"){
					_root.highlightEnabled=true;
				}
			}
			if (rootChild.attributes.defaultOverSound != null){
				_root.defaultOverSound = rootChild.attributes.defaultOverSound;
			}	
			if (rootChild.attributes.defaultClickSound != null){
				_root.defaultClickSound = rootChild.attributes.defaultClickSound;
			}
			if(rootChild.attributes.visitedLinkColoring != null){
				if(rootChild.attributes.visitedLinkColoring=="false"){
					_root.visitedLinkColoring=false;
				}else if(rootChild.attributes.visitedLinkColoring=="true"){
					_root.visitedLinkColoring=true;
				}
			}
			if(rootChild.attributes.udScrollJump != null){
				_root.udScrollJump = Number(rootChild.attributes.udScrollJump);
			}
			if(rootChild.attributes.udScrollJump2 != null){
				_root.udScrollJump2 = Number(rootChild.attributes.udScrollJump2);
			}
			if(rootChild.attributes.ssScrollJump2 != null){
				_root.ssScrollJump2 = Number(rootChild.attributes.ssScrollJump2);
			}
			if(rootChild.attributes.defaultIconsEnabled != null){
				if(rootChild.attributes.defaultIconsEnabled=="false"){
					_root.defaultIconsEnabled=false;
				}else if(rootChild.attributes.defaultIconsEnabled=="true"){
					_root.defaultIconsEnabled=true;
				}
				//_root.defaultIconsEnabled = Boolean(rootChild.attributes.defaultIconsEnabled);
			}
			if(rootChild.attributes.defaultFolderIcon != null){
				_root.defaultFolderIcon = Number(rootChild.attributes.defaultFolderIcon);
			}
			if(rootChild.attributes.defaultLinkIcon != null){
				_root.defaultLinkIcon = Number(rootChild.attributes.defaultLinkIcon);
			}
			if(rootChild.attributes.defaultTargetIcon != null){
				_root.defaultTargetIcon = Number(rootChild.attributes.defaultTargetIcon);
			}
			if(rootChild.attributes.defaultMovieIcon != null){
				_root.defaultMovieIcon = Number(rootChild.attributes.defaultMovieIcon);
			}
			if(rootChild.attributes.defaultMP3Icon != null){
				_root.defaultMP3Icon = Number(rootChild.attributes.defaultMP3Icon);
			}
			if(rootChild.attributes.statusLinkDisplay != null){
				if(rootChild.attributes.statusLinkDisplay=="false"){
					_root.statusLinkDisplay=false;
				}else if(rootChild.attributes.statusLinkDisplay=="true"){
					_root.statusLinkDisplay=true;
				}
			}
		}

		if (scrollfunc == "mouse"){
			ssScroll._visible=0;
			udScroll._visible=0;
		}
		speed=11-speed;
		xmlSetup();
}

function scrollIt(){
	if (scrollfunc == "mouse"){
		scrollX = (_xmouse*xFarLevel/barrierx*xspace)-(xspace*(yyyInc*.01));
		scrollY = (_ymouse*yFarLevel/barriery*yspace)-(yspace*(yyyInc*.025));
	}
	if (scrollfunc == "scrollbars"){
		scrollX = (((ssScroll._x-(startPosX+bottomScrollXDeviation))/(barrierX-((startPosX+bottomScrollXDeviation)+ssScroll._width+udScroll._width)))*barrierX)*xFarLevel2/barrierx*xspace;
		//trace(moveX);
		scrollY = (((udScroll._y-(startPosY))/(barrierY-(startPosY+udScroll._height)))*barrierY)*yFarLevel/barriery*yspace;
		/*trace(yspace);
		trace(yFarLevel);
		trace(udScroll._y);
		trace(scrollY);
		trace(move);
		trace(eval("lvlLength"+1));
		trace(" ");*/
	}
}

function increment(){
	move+=ySpace;
	yyyInc++;
	yFarLevel = move/ySpace - eval("lvlLength"+1) + 1;
}

function incrementX(xinc){
	moveX=xSpace*(xinc-1);
	if (xinc > xFarLevel){
		xFarLevel = moveX/xSpace;
	}
	//for scrollbars:
	moveX2=xSpace*xinc;
	if (xinc > xFarLevel){
		xFarLevel2 = moveX2/xSpace;
	}
}

function memorize(child, clip){
	mem = String(not child.attributes.open);
	child.attributes.open = mem;
}
function memorizeVisited(child,clip){
	if(_root.visitedLinkColoring){
		child.attributes.visited = "true";
		_root[clip].visited=true;
	}
}

function highlightIt(clipToHighlight){
	if(_root.highlightEnabled){
		_root[clipToHighlight].highlighter._visible=1;
		if(clipToHighlight!=prevHighlightedClip){
			_root[prevHighlightedClip].highlighter._visible=0;
			prevHighlightedClip=clipToHighlight;
		}
	}
}

function parameters(child, clip){

	_root[clip].child = child;
	_root[clip].sound = soundStart;
	_root[clip].nodeName = clip;
	
	if(child.nodeName == "object"){
		if(child.attributes.type == "link"){
			_root[clip].type = "link";
			_root[clip].url = child.attributes.url;
			if(child.attributes.window != "" and child.attributes.window != null){
				_root[clip].window = child.attributes.window;
			}else{
				_root[clip].window = null;
			}
		}
		if(child.attributes.type == "target"){
			_root[clip].type = "target";
			_root[clip].clip = child.attributes.clip;
			_root[clip].frame = child.attributes.frame;
		}
		if(child.attributes.type == "movie"){
			_root[clip].type = "movie";
			_root[clip].file = child.attributes.file;
			_root[clip].clip = child.attributes.clip;
		}
		if(child.attributes.type == "mp3"){
			_root[clip].type = "mp3";
			_root[clip].track = child.attributes.track;
		}
	}
	if(child.nodeName == "folder"){
		if (child.attributes.open == "true" or child.attributes.open == true){
			child.attributes.open = true;
			_root[clip].dropDown = Boolean(true);
		}else{
			child.attributes.open = false;
			_root[clip].dropDown = Boolean(false);
		}
		_root[clip].isFolder=true;
	}
	if (child.attributes.lock == "true"){
		_root[clip].locked = Boolean(true);
	}
	if (child.attributes.name != null){
		_root[clip].title.text = child.attributes.name;
		nameString = child.attributes.name;
		_root[clip].hitArea._width = (nameString.length+1)*11;
	}
	if (child.attributes.icon != null){
		_root[clip].icon.ImageList.gotoAndStop(child.attributes.icon);
	}else{
		if(defaultIconsEnabled){
			switch(child.nodeName){
				case "folder":
					_root[clip].icon.ImageList.gotoAndStop(_root.defaultFolderIcon);
					break;
				case "object":
					switch(child.attributes.type){
						case "link":
							_root[clip].icon.ImageList.gotoAndStop(_root.defaultLinkIcon);
							break;
						case "target":
							_root[clip].icon.ImageList.gotoAndStop(_root.defaultTargetIcon);
							break;
						case "movie":
							_root[clip].icon.ImageList.gotoAndStop(_root.defaultMovieIcon);
							break;
						case "mp3":
							_root[clip].icon.ImageList.gotoAndStop(_root.defaultMP3Icon);
							break;
					}
					break;
			}
		}else{
			_root[clip].icon.ImageList.gotoAndStop(1);
		}
	}
	
	_root[clip].statusOverMsg=child.attributes.statusOverMsg;
	_root[clip].statusClickMsg=child.attributes.statusClickMsg;
	_root[clip].errorMsg=child.attributes.errorMsg;
	
	if (child.attributes.sound != null){
				if (child.attributes.sound == "true" or child.attributes.sound == true){
				_root[clip].sound = true;}
				if (child.attributes.sound == "false" or child.attributes.sound == false){
				_root[clip].sound = false;}
	}
	if (child.attributes.mouseOverSound != null){
		_root[clip].mouseOverSound = child.attributes.mouseOverSound;
	}else{
		_root[clip].mouseOverSound = defaultOverSound;
	}
	if (child.attributes.mouseClickSound != null){
		_root[clip].mouseClickSound = child.attributes.mouseClickSound;
	}else{
		_root[clip].mouseClickSound = defaultClickSound;
	}
	if(child.attributes.visited=="true"){
		_root[clip].visited=true;
	}
}

function xmlSetup(){
	change=0;
	move=0;
	incNum=0;
	xFarLevel=0;
	totalClips=0;
	xmlCalc(serverdata.firstChild.childNodes, "rootClip");
}

function xmlCalc (levelArray, parentClip) {
	incNum++;
	set ("lvlArray"+incNum, new Array());
	set ("lvlArray"+incNum, levelArray);
	set ("lvlLength"+incNum, levelArray.length);
	for(set ("inc"+incNum, 0); eval("inc"+incNum)<eval("lvlLength"+incNum); set ("inc"+incNum, eval("inc"+incNum)+1)){
				incrementX(incNum);
				ID=_root[parentClip].ID + "l" + eval("inc"+(incNum));
				set ("nodeName" + incNum, ID+"node"+eval("inc"+(incNum)));
				if (_root[eval("nodeName" + incNum)]) {
					//
				}else{
					n++;
					duplicateMovieClip ("rootClip", eval("nodeName" + incNum), n);
					parameters(eval("lvlArray"+incNum)[eval("inc"+incNum)], eval("nodeName" + incNum));
					_root[eval("nodeName" + incNum)].ID = ID;
					_root[eval("nodeName" + incNum)].parent = parentClip;
					_root[eval("nodeName" + incNum)]._y = _root[parentClip]._y;
					_root[eval("nodeName" + incNum)]._x = startPosX + moveX;
					
				}
				totalClips++;
				imove[totalClips] = eval("nodeName" + incNum);
				_root[eval("nodeName" + incNum)].goalX = startPosX + moveX;
				_root[eval("nodeName" + incNum)].goalY = startPosY + move;
				increment();
				if (eval("lvlArray"+incNum)[eval("inc"+incNum)].haschildNodes){
					if (_root[eval("nodeName" + incNum)].dropDown == true) {
						xmlCalc (eval("lvlArray"+incNum)[eval("inc"+incNum)].childNodes, eval("nodeName" + incNum));
					}else{
						removeClips (eval("lvlArray"+incNum)[eval("inc"+incNum)].childNodes, eval("nodeName" + incNum));
					}
				}
	}
	incNum--;
}

function removeClips (levelArray, parentClip) {
	set ("lvlArray"+deincNum, new Array());
	set ("lvlArray"+deincNum, levelArray);
	set ("lvlLength"+deincNum, levelArray.length);
	for(set ("inc"+deincNum, 0); eval("inc"+deincNum)<eval("lvlLength"+deincNum); set ("inc"+deincNum, eval("inc"+deincNum)+1)){
				ID=_root[parentClip].ID + "l" + eval("inc"+(deincNum));
				set ("nodeName" + deincNum, ID+"node"+eval("inc"+(deincNum)));
				if (_root[eval("nodeName" + deincNum)]) {
					removeMovieClip (eval("nodeName" + deincNum));
				}
	}
	for(cu=totalClips+1;cu<imove.length;cu++){
		imove[cu]=""; //clear history
	}
}

serverData.onLoad = serverSetup;

