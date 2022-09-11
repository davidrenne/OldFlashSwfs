XML.prototype.ignoreWhite = true;
serverData = new XML();
serverData.load(serverfile);
currentElements = new array();
backIconIncrement=false;
n=100;

function analyzeParameter(param,datatype){
	if(rootChild.nodeName == "server"){
		paramVal=eval("rootChild.attributes."+param);
		if(paramVal!=null && paramVal!=""){
			trace(param+": "+paramVal);
			switch(datatype){
				case "string":
					set("_root."+param,paramVal);
					break;
				case "bool":
					if(paramVal=="true"){
						set("_root."+param,true);
					}else{
						set("_root."+param,false);
					}
					break;
				default:
					set("_root."+param,Number(paramVal));
					
			}
		}
	}
}

function serverSetup () {
	rootChild = serverdata.firstChild;
	//step 1: get necessary custom parameters
	trace("#custom data taken from the xml file:");
	analyzeParameter("clipWidth");
	analyzeParameter("clipHeight");
	analyzeParameter("tabSpeed");
	analyzeParameter("scrollSpeed");
	analyzeParameter("scrollJumps");
	analyzeParameter("scrollButtonIncrement");
	analyzeParameter("defaultFolderIconNumber");
	analyzeParameter("backFolderIconNumber");
	analyzeParameter("linesOfTextAllowedInIconTitles");
	analyzeParameter("tabStraightOrRounded","string"); 
	analyzeParameter("iconHorizSpacing");
	analyzeParameter("iconVertSpacing");
	analyzeParameter("topMargin");
	analyzeParameter("leftMargin");
	analyzeParameter("rightMargin");
	analyzeParameter("backFolderTitle","string");
	analyzeParameter("includeExtraLinesInIconMargins","bool");
	analyzeParameter("whenToExecuteIconRefresh","string");
	analyzeParameter("soundEnabled","bool");
	analyzeParameter("defaultOverSound");
	analyzeParameter("defaultClickSound");
	analyzeParameter("tabSoundEnabled","bool");
	analyzeParameter("defaultTabOverSound");
	analyzeParameter("defaultTabClickSound");
	analyzeParameter("tabAllreadyOpenErrorSound");
	analyzeParameter("backFolderOverSound");
	analyzeParameter("backFolderClickSound");
	//step 2: get general information
	tabGo=false;
	tabBounds = _root.tabTemplate.getBounds(_root);
	tabWidth = tabBounds.xMax - tabBounds.xMin;
	tabHeight = tabBounds.yMax - tabBounds.yMin;
	tabGo=true;
	iconBounds = _root.objectTemplate.getBounds(_root);
	iconWidth = iconBounds.xMax - iconBounds.xMin;
	iconHeight = iconBounds.yMax - iconBounds.yMin;
	scrollbarBounds = _root.scrollbar.getBounds(_root);
	scrollbarWidth = scrollbarBounds.xMax-scrollbarBounds.xMin;
	scrollbarHeight = scrollbarBounds.yMax-scrollbarBounds.yMin;
	scrollButtonBounds = _root.scrollLeftButton.getBounds(_root);
	scrollButtonWidth = scrollButtonBounds.xMax-scrollButtonBounds.xMin;
	scrollButtonHeight = scrollButtonBounds.yMax-scrollButtonBounds.yMin;
	scrollerBounds = _root.scrollbar.scroller.getBounds(_root);
	scrollerWidth = scrollerBounds.xMax - scrollerBounds.xMin;
	scrollbarSpacing = tabWidth+scrollButtonWidth;
	_root.scrollbar._y = clipHeight;
	_root.scrollbar._visible=0;
	_root.scrollRightButton._y = clipHeight;
	_root.scrollLeftButton._y = clipHeight;
	_root.scrollRightButton._visible=0;
	_root.scrollLeftButton._visible=0;
	iconHeightWithSpacing=iconHeight+iconVertSpacing;
	roundedIconRows = Math.round(clipHeight/iconHeightWithSpacing);
	if(roundedIconRows<clipHeight/iconHeightWithSpacing){
		numberOfIconRows = roundedIconRows;
	}else{
		numberOfIconRows = roundedIconRows-1;		
	}
	//step 3: initial render
	xmlSetup();
	if(initialOpenTabID!=null){
		_root.openTabIDChange(initialOpenTabID,initialNumberOfElements);
		_root.tabClip(initialOpenTabID);
	}else{
		_root.openTabIDChange(tabNum,numberOfIconsInTab);
		_root.tabClip(tabNum);
	}
}

function parameters(child, clip){

	if (child.nodeName=="spacer"){
		_root[clip].title.text = "";
		_root[clip].shading.text="";
		_root[clip].icon.ImageList.gotoAndStop("blank");
		_root[clip].spacer=true;
		_root[clip].gotoAndStop(2);
		//
		return;
	}

	if (child.attributes.name != null){
		_root[clip].title.text = child.attributes.name;
		_root[clip].shading.text = child.attributes.name;
		nameString = child.attributes.name;
		_root[clip].hitArea._width = (nameString.length+1)*11;
	}else{
		_root[clip].title.text="<untitled>";
		_root[clip].shading.text="<untitled>";
	}
	
	if (child.attributes.icon != null){
		_root[clip].icon.ImageList.gotoAndStop(child.attributes.icon);
	}else{
		_root[clip].icon.ImageList.gotoAndStop(1);
	}
	
	if(child.nodeName == "tab"){
		if(child.attributes.open=="true"){
			initialOpenTabID=tabNum;
			initialNumberOfElements=child.childNodes.length;
		}
	}
	
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
	}
	
	if(child.nodeName == "folder"){
		_root[clip].type="folder";
		if (child.attributes.icon==null){
			_root[clip].icon.imagelist.gotoAndStop(_root.defaultFolderIconNumber);
		}
	}
	
	if(child.attributes.lock=="true"){
		_root[clip].lock=true;			
	}
	
	if (child.attributes.sound != null){
		if (child.attributes.sound == "true" or child.attributes.sound == true) _root[clip].sounds.isEnabled = true;
		if (child.attributes.sound == "false" or child.attributes.sound == false) _root[clip].sounds.isEnabled = false;
	}else{
		_root[clip].sounds.isEnabled = _root.soundEnabled;
	}
	if(child.nodeName=="tab"){
		if (child.attributes.mouseOverSound != null){
			_root[clip].sounds.mouseOverSound = child.attributes.mouseOverSound;
		}else{
			_root[clip].sounds.mouseOverSound = _root.defaultTabOverSound;
		}
		if (child.attributes.mouseClickSound != null){
			_root[clip].sounds.mouseClickSound = child.attributes.mouseClickSound;
		}else{
			_root[clip].sounds.mouseClickSound = _root.defaultTabClickSound;
		}
	}else{
		if (child.attributes.mouseOverSound != null){
			_root[clip].sounds.mouseOverSound = child.attributes.mouseOverSound;
		}else{
			_root[clip].sounds.mouseOverSound = _root.defaultOverSound;
		}
		if (child.attributes.mouseClickSound != null){
			_root[clip].sounds.mouseClickSound = child.attributes.mouseClickSound;
		}else{
			_root[clip].sounds.mouseClickSound = _root.defaultClickSound;
		}
	}
}

function iconPositionCalc(){
	remainderArea = rowWidth - getCurrentScrollWidth();
	scrollDeviation = (_root.scrollbar.scroller._x * remainderArea) / (scrollbarWidth-scrollerWidth);
	_root.backFolder.goalX = _root.backFolder.originalX-scrollDeviation;
	for(i=0;i<numberOfIcons;i++){
		_root["nodeName"+i].goalX = _root["nodeName"+i].originalX-scrollDeviation;
	}
}

function folderClick(child){
	if(child.nodeName=="tab"){
		_root["tab"+openTabID].openChild=null;
		openTabIDChange(openTabID,child.childNodes.length);
		_root["tab"+openTabID].numberOfElements = child.childNodes.length;
		incNum = 0;
		xmlCalc(serverdata.firstChild.childNodes);
		scrollbarSetup(openTabID);
		_root.rowWidthCalc();
	}else{
		_root["tab"+openTabID].openChild=child;
		openTabIDChange(openTabID,child.childNodes.length+1);
		_root["tab"+openTabID].numberOfElements = child.childNodes.length+1;
		backIconIncrement=true;
		incNum = 0;
		xmlCalc(serverdata.firstChild.childNodes);
		scrollbarSetup(openTabID);
		_root.rowWidthCalc(true);
	}

}


function returnIconPositions(){
	iconPositionCalc();
	_root.backFolder._x = _root.backFolder.goalX;
	for(i=0;i<numberOfIcons;i++){
		_root["nodeName"+i]._x = _root["nodeName"+i].goalX;
	}
}

function rowWidthCalc(isFolder){
	if(_root.backFolder._x!=null){
		isFolder=true;
	}
	if(isFolder){
		rowWidth = (_root["nodeName"+(_root.evenRow-2)]._x+iconWidth) - _root.backFolder._x + _root.leftMargin + _root.rightMargin;
	}else{
		rowWidth = (_root["nodeName"+(_root.evenRow-1)]._x+iconWidth) - _root.nodeName0._x + _root.leftMargin + _root.rightMargin;
		
	}
	if(rowWidth>getCurrentScrollWidth()){
		showScrollBar();
	}
}

function scrollit(){
	iconPositionCalc();
	_root.byframeClip.frames=30;
	_root.byframeClip.clipFunc="scrolling";
	_root.byframeClip.initFrames=true;
	_root["tab"+openTabID].scrollbarMemPos = _root.scrollbar.scroller._x;
}

function getCurrentScrollWidth(){
	scrollBounds = _root.scrollbar.getBounds(_root);
	scrollWidth = scrollBounds.xMax - scrollBounds.xMin;
	return scrollWidth;
}

function showScrollBar(){
	_root.scrollbar._visible=1;
	_root.scrollRightButton._visible=1;
	_root.scrollLeftButton._visible=1;
	_root.scrollbar._x = 1+_root["tab"+openTabID].goalX + _root.scrollbarSpacing;
	_root.scrollLeftButton._x = 1+_root["tab"+openTabID].goalX+_root.tabWidth;
	_root.scrollLeftButton._y = _root.scrollbar._y;
	_root.scrollRightButton._y = _root.scrollbar._y;
	_root.scrollRightButton._x = _root.nextTabValue;
	if(_root["tab"+openTabID].scrollbarMemPos!=null){
		_root.scrollbar.scroller._x=_root["tab"+openTabID].scrollbarMemPos;
		returnIconPositions();
	}
}

function scrollbarSetup(tabID){
	scrollDeviation=0;
	_root.scrollbar._width = nextTabValue - (_root["tab"+tabID].goalX+(scrollbarSpacing+scrollButtonWidth));
	_root.scrollbar.scroller.scrollBounds = _root.scrollbar.getBounds(_root.scrollbar);
	_root.scrollbar.scroller.bounds = _root.scrollbar.scroller.getBounds(_root.scrollbar);
	_root.scrollbar.scroller.width = _root.scrollbar.scroller.bounds.xMax - _root.scrollbar.scroller.bounds.xMin;
	_root.scrollbar._visible=0;
	_root.scrollbar.scroller._x=0;
	_root.scrollRightButton._visible=0;
	_root.scrollLeftButton._visible=0;
}

function tabClip(tabID){
	for(i=1;i<tabNum+1;i++){
		if(i>tabID){
			remainingTabs = (tabNum+1)-i;
			_root["tab"+i].icon.gotoAndStop("right");
			_root["tab"+i].goalX=clipWidth-(remainingTabs*(tabWidth-1));
		}else{
			_root["tab"+i].icon.gotoAndStop("left");
			_root["tab"+i].goalX=(i-1)*(tabWidth-1);
		}
		byframeClip.frames=30;
		byframeClip.clipFunc="tabs";
		byframeClip.initFrames=true;
	}
	_root["tab"+tabID].icon.gotoAndStop("open");
	byframeClip.tabID=tabID;
	if(_root["tab"+(tabID+1)].goalX!=null){
		nextTabValue = _root["tab"+(tabID+1)].goalX;
	}else{
		nextTabValue = clipWidth;
	}
	incNum = 0;
	scrollbarSetup(tabID);
	if(_root.whenToExecuteIconRefresh!="end_of_slide"){
		xmlCalc(serverdata.firstChild.childNodes);
	}
}

function openTabIDChange(tabID,newNumberOfElements){
	prevOpenTabID=openTabID;
	openTabID = tabID;
	for(i=0;i<currentElements.length;i++){
		removeMovieClip (currentElements[i]);
	}
	numberOfElements=newNumberOfElements;
	if(tabID==prevOpenTabID){
		return true;
	}else{
		return false;
	}
}

function typeofNode(child){
	return child.nodeName
}

function xmlSetup(){
	xmlCalc(serverdata.firstChild.childNodes);
	incNum = 0;
}

function xmlCalc (lvlArray) {
	addBackButton=false;
	lvlLength = lvlArray.length;
	if(lvlArray.length<1){
		lvlLength++;
		addBackButton=true;
	}
	numberOfIcons = numberOfElements; //lvlLength;
	evenRow = Math.ceil(numberOfIcons/numberOfIconRows);
	oddRow = Math.ceil((numberOfIcons - evenRow)/(numberOfIconRows-1));
	for(inc=0; inc<lvlLength; inc++){
		n++;
		thisChild = lvlArray[inc];
		type=typeofNode(lvlArray[inc]);
		switch (type){
			case "tab":
				if(allreadyProcessed!=true){
					tabNum++;
					tabNumTmp=tabNum;
				}else{
					tabNumTmp++;
				}
				newName = "tab" + tabNumTmp;
				if(allreadyProcessed!=true){
					numberOfTabs = lvlLength;
					numberOfIconsInTab = lvlArray[inc].childNodes.length;
					duplicateMovieClip ("tabTemplate", newName, n+10000);
					parameters(lvlArray[inc], newName);
					_root[newName].tabID = tabNum;
					_root[newName].numberOfElements = lvlArray[inc].childNodes.length;
					_root[newName]._y = 0;
					_root[newName]._x = (tabNum-1)*(tabWidth-1);
				}else{ 
					if(openTabID==tabNumTmp){
						if(_root[newName].openChild==null){
							xmlCalc(lvlArray[inc].childNodes,_root[newName]);
						}else{
							xmlCalc(_root[newName].openChild.childNodes,_root[newName]);
							backIconIncrement=true;
						}
					}
				}
				break;
			default:
				iconNum++;
				tabSize=_root["tab"+openTabID].goalX+tabWidth+leftMargin;
				if(backIconIncrement and _root["tab"+openTabID].openChild != null){ //and _root["tab"+openTabID].openChild != null
					duplicateMovieClip ("objectTemplate", "backFolder", 80);
					_root.backFolder.title.iconTitleConfig();
					_root.backFolder.shading.gotoAndStop(5);
					_root.backFolder._x = tabSize+(((iconNum-1)*iconWidth)+((iconNum-1)*iconHorizSpacing));
					_root.backFolder.originalX = _root.backFolder._x;
					_root.backFolder._y = topMargin+iconHeight;
					_root.backFolder.dragAllowed = false;
					_root.backFolder.sounds.isEnabled=_root.soundEnabled;
					_root.backFolder.sounds.mouseOverSound = _root.backFolderOverSound;
					_root.backFolder.sounds.mouseClickSound = _root.backFolderClickSound;
					_root.backFolder.type="backFolder";
					_root.backFolder.icon.imagelist.gotoAndStop(_root.backFolderIconNumber);
					_root.backFolder.title.text = _root.backFolderTitle;
					_root.backFolder.shading.text = _root.backFolderTitle;
					currentElements[lvlLength+1]="backFolder";
					if(thisChild!=null){
						_root.backFolder.child = thisChild.parentNode.parentNode;
					}else{
						_root.backFolder.child=lastElement.parentNode;
					}
					iconNum++;
					backIconIncrement=false;
				}
				lastElement=thisChild;
				if(!addBackButton){
					newName = "nodeName"  + inc;
					currentElements[inc]=newName;
					duplicateMovieClip ("objectTemplate", newName, n);
					_root[newName].title.gotoAndStop(5);
					_root[newName].shading.gotoAndStop(5);
					parameters(lvlArray[inc], newName);
					_root[newName].tabID = tabNum;
					for(j=1;j<numberOfIconRows+1;j++){
						if(iconNum<=(j*evenRow)){
							currentRow=j;
							j=10;
						}
					}
					if(thisChild.attributes.x==null){
						if(currentRow!=1){
							previousIcons = (currentRow-1)*evenRow;
							_root[newName]._x = tabSize+(((iconNum-previousIcons-1)*iconWidth)+((iconNum-previousIcons-1)*iconHorizSpacing));
							_root[newName]._y = topMargin+(iconHeight*currentRow)+(iconVertSpacing*(currentRow-1));

						}else{
							_root[newName]._x = tabSize+(((iconNum-1)*iconWidth)+((iconNum-1)*iconHorizSpacing));
							_root[newName]._y = topMargin+iconHeight;
						}
					}else{
						_root[newName]._x = thisChild.attributes.x;
						_root[newName]._y = thisChild.attributes.y;
					}
					_root[newName].originalX = _root[newName]._x;
					_root[newName].child = lvlArray[inc];
					_root[newName].child.attributes.x = _root[newName]._x;
					_root[newName].child.attributes.y = _root[newName]._y;
				}
		}
	}
	allreadyProcessed=true;
	tabNumTmp=0;
	iconNum=0;
}

serverData.onLoad = serverSetup;


