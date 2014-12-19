//加载该js时在图形的svg文件上创建标题、时间、图形、图例、引用效果、右键菜单   start
//取svg文件中第一个svg标记作为根节点
var svgRoot = document.getElementsByTagName('svg').item(0);

//1、标题，隶属于svgRoot
var titleGroup = document.createElementNS("http://www.w3.org/2000/svg", "g");
svgRoot.appendChild(titleGroup);
var titleText = document.createElementNS("http://www.w3.org/2000/svg", "text");
titleGroup.appendChild(titleText);
titleText.setAttribute("id", "title");
titleText.setAttribute("font-family", "SimSun");
titleText.setAttribute("font-size", "20");
titleText.setAttribute("transform", "translate(300,50)");
titleText.setAttribute("style","font-weight:bold;text-anchor:middle;font-size:20");

//2、数据刷新时间，隶属于svgRoot
var timeGroup = document.createElementNS("http://www.w3.org/2000/svg", "g");
svgRoot.appendChild(timeGroup);
timeGroup.setAttribute("id", "skeleton");
var timeText = document.createElementNS("http://www.w3.org/2000/svg", "text");
timeGroup.appendChild(timeText);
timeText.setAttribute("id", "updateTime");
timeText.setAttribute("font-family", "SimSun");//必须设置字体，否则svg默认字体在某些浏览器中会显示乱码
timeText.setAttribute("font-size", "14");
timeText.setAttribute("transform", "translate(180, 480)");

//3、图形组，隶属于svgRoot
var chart = document.createElementNS("http://www.w3.org/2000/svg", "g");
chart.setAttribute("id", "chart");
chart.setAttribute("transform", "translate(100, 340)");
svgRoot.appendChild(chart);
//3.1、图形背景组，隶属于chart
var backGroup = document.createElementNS("http://www.w3.org/2000/svg", "g");
chart.appendChild(backGroup);
backGroup.setAttribute("id", "backGroup");

//4、图例的组，隶属于svgRoot，包括图例和说明
var des = document.createElementNS("http://www.w3.org/2000/svg", "g");
svgRoot.appendChild(des);
des.setAttribute("id", "des");
//4.1、图例
var deslist = document.createElementNS("http://www.w3.org/2000/svg", "g");
des.appendChild(deslist);
deslist.setAttribute("id", "deslist");
deslist.setAttribute("transform", "translate(600,80)");
//4.2、说明
var destext = document.createElementNS("http://www.w3.org/2000/svg", "g");
des.appendChild(destext);
destext.setAttribute("id", "destext");
destext.setAttribute("font-family", "SimSun");
destext.setAttribute("font-size", "12");
destext.setAttribute("transform", "translate(620,89)");



//5、滤镜，隶属于svgRoot
var defs= document.createElementNS("http://www.w3.org/2000/svg", "defs");
svgRoot.appendChild(defs);
var filter= document.createElementNS("http://www.w3.org/2000/svg", "filter");
defs.appendChild(filter);
filter.setAttribute("id", "DropShadowFilter");
filter.setAttribute("filterUnits", "objectBoundingBox");
filter.setAttribute("x", "-10%");
filter.setAttribute("y", "-10%");
filter.setAttribute("width", "120%");
filter.setAttribute("height", "120%");
var feGaussianBlur= document.createElementNS("http://www.w3.org/2000/svg", "feGaussianBlur");
filter.appendChild(feGaussianBlur);
feGaussianBlur.setAttribute("in", "SourceAlpha");
feGaussianBlur.setAttribute("stdDeviation", "2");
feGaussianBlur.setAttribute("result", "BlurAlpha");
var feOffset= document.createElementNS("http://www.w3.org/2000/svg", "feOffset");
filter.appendChild(feOffset);
feOffset.setAttribute("in", "BlurAlpha");
feOffset.setAttribute("dx", "4");
feOffset.setAttribute("dy", "4");
feOffset.setAttribute("result", "OffsetBlurAlpha");
var feMerge= document.createElementNS("http://www.w3.org/2000/svg", "feMerge");
filter.appendChild(feMerge);
var feMergeNode1= document.createElementNS("http://www.w3.org/2000/svg", "feMergeNode");
feMerge.appendChild(feMergeNode1);
feMergeNode1.setAttribute("in", "OffsetBlurAlpha");
var feMergeNode2= document.createElementNS("http://www.w3.org/2000/svg", "feMergeNode");
feMerge.appendChild(feMergeNode2);
feMergeNode2.setAttribute("in", "SourceGraphic");

//6、线性渐变效果的引用
var defsLinearGrad= document.createElementNS("http://www.w3.org/2000/svg", "defs");
svgRoot.appendChild(defsLinearGrad);
var linearGrad= document.createElementNS("http://www.w3.org/2000/svg", "linearGradient");
defsLinearGrad.appendChild(linearGrad);
linearGrad.setAttribute("id", "linearGrad");
linearGrad.setAttribute("gradientUnits","userSpaceOnUse");


//7、右键菜单，隶属于svgRoot
var defsMenu= document.createElementNS("http://www.w3.org/2000/svg", "defs");
svgRoot.appendChild(defsMenu);
var menuId= document.createElementNS("http://www.w3.org/2000/svg", "menu");
defsMenu.appendChild(menuId);
menuId.setAttribute("id", "myContextMenu");
var header=document.createElementNS("http://www.w3.org/2000/svg", "header");
menuId.appendChild(header);
var headerValue=document.createTextNode("Custom Menu");
header.appendChild(headerValue);
var item=document.createElementNS("http://www.w3.org/2000/svg", "item");
menuId.appendChild(item);
item.setAttribute("id", "About");
item.setAttribute("action", "About");
var itemValue=document.createTextNode("about Adobe SVG Viewer");
item.appendChild(itemValue);
//加载该js时在图形的svg文件上创建标题、时间、图形、图例、引用效果、右键菜单   end


var seq=0;
function BaseChart() {
	this.id=seq++;
	this.count=0;
	this.title="";
	this.xAxisTitle="";
	this.yAxisTitle="";	
	this.dataUrl=null;
	this.doc=document;
	this.colors=["#FF7744","#C2A00E","#66FFCC", "#FF66CC", "#3399CC", "#C2CC0E", "#CC99FF","#71A214","#FFCC66",   "#CCFF66"];//设置图表元素的颜色数组
	this.backgroudColors=null;//线性渐变效果背景色的颜色数组
	this.xLineColor=null;//横坐标线颜色
	this.yLineColor=null;//纵坐标线颜色
	this.currentColor=0;//当前使用的颜色
	this.chartEleGroup =[];
	this.desList = new Array();//该数组中的元素表示每个柱形的图例
	this.desTextList = new Array();//该数组中的元素表示每个柱形图例的说明
	this.coordType=0;
	this.maxSize=0;
	this.showScrool=false;
	this.data=null;
	window[this.id]=this;
}

//显示图像。showLegend：是否显示图例,showTime：是否显示更新时间
BaseChart.prototype.show = function(showLegend,showTime) {
	this.initSvg();
	this.drawChart(showLegend,showTime);
	this.drawMenu();
}

BaseChart.prototype.getColor = function() {
	var color = this.colors[this.currentColor];
	this.currentColor++;
	if (this.currentColor >= this.colors.length){
		this.currentColor = 0;
	}
	return color;
}

BaseChart.prototype.setColors = function(colors) {
	this.colors=colors;
}
BaseChart.prototype.getBackgroudColors = function() {
	return this.backgroudColors;
}
//使用默认的线性渐变效果
BaseChart.prototype.setBackgroudColors = function() {
	this.backgroudColors=["#FFFFFF", "#FFAA33", "#EE7700"];
}
//用户自定义线性渐变效果的颜色
BaseChart.prototype.customBackgroudColors = function(colorArray) {
	this.backgroudColors=colorArray;
}

//取得web应用的根目录
BaseChart.prototype.getWebPath = function() {
	var paths=top.document.location.pathname.split("/");
	var webPaht="";
	if(paths[0]==''){//ie下面有时候paths[0]是空
		webPath = "/"+paths[1];
	} else {
		webPath = "/"+paths[0];
	}
	return webPath;
}

BaseChart.prototype.setTitle = function(title) {
	this.title=title;
}

BaseChart.prototype.setXAxisTitle = function(xAxisTitle) {
	this.xAxisTitle=xAxisTitle
}


BaseChart.prototype.setYAxisTitle = function(yAxisTitle) {
	this.yAxisTitle=yAxisTitle;
}

BaseChart.prototype.initSvg = function() {
	
}
BaseChart.prototype.getDoc = function() {
	return this.doc;
}

BaseChart.prototype.setDataUrl = function(url) {
	this.dataUrl=url;
}

BaseChart.prototype.setChartData = function(data) {
	this.data=data;	
}
BaseChart.prototype.getChartData = function() {
	if(this.data){
		return this.data;
	}
	if(this.dataUrl){
		this.data=BaseChart.requestData(this.dataUrl);
	}
	return this.data;
}


BaseChart.prototype.drawChart = function(showLegend,showTime) {
	//设置图表标题
	this.setTextNodeValue("title", this.title);
	//this.coordType含义0：无坐标轴(饼图)；1：有坐标轴且纵轴为左侧单轴(三维柱状图)；2：有坐标轴且纵轴为双侧坐标轴(双轴图);3：有坐标轴且纵轴为左侧单轴+分组(分组、堆型柱状图)
	if(this.coordType==0){		
		var data=this.getChartData();//获取要显示的数据
		this.count=data.length;
		for(i=0;i<data.length;i++){
			var dataName = data[i].name;
			var dataValue = Number(data[i].value);	
			this.addChartItem(showLegend,dataValue, dataName, false,this.count,i);// 根据数据画图	
		}
	}else if(this.coordType==1){
		var data=this.getChartData();
		this.count=data.length;
		//显示数据超过10个时显示滚动条
		if(this.count>10){
			if(this.showScrool){
				createScrool(this.count,this.eleWidth,this.spaceWidth,this.chartWidth);
			}			
		}		
		for(i=0;i<data.length;i++){
			var dataName = data[i].name;
			var dataValue =data[i].value;
			this.addChartItem(showLegend,dataValue, dataName, false,this.count,i);		
		}	
		this.createCoord(this.count);//设置坐标轴	
	}else if(this.coordType==2){
		var data=this.getChartData();
		this.count=data.length;			
		for(i=0;i<data.length;i++){
			var dataName = data[i].name;
			var dataLeftValue = Number(data[i].leftValue);
			var dataRightValue=Number(data[i].rightValue);
			this.addChartItemLeft(showLegend,dataLeftValue, dataName, false,this.count,i);		
			this.addChartItemRight(showLegend,dataRightValue, false,this.count,i);

		}
		//显示数据超过6个时显示滚动条	
		if(this.count>6){
			if(this.showScrool){
				createScrool(this.count,this.eleWidth,this.spaceWidth,this.chartWidth);
			}			
		}
		this.createCoord(this.count);//设置坐标轴		
		//设置图例:如果左侧数据颜色为一种且显示图例，则按照左侧、右侧两种分类显示图例；如果左侧数据颜色不止一种，则按照左侧数据名称显示图例(在addChartItemLeft()方法中处理)
		if((this.leftColors.length==1)&&showLegend){
			this.createDualAxisDes();
		}
	}else if(this.coordType==3){
		var data=this.getChartData();
		this.count=data.length;		
		for(i=0;i<data.length;i++){
			var dataComboName = data[i].comboName;
			var dataGroupName = data[i].groupName;		
			var dataValue =data[i].value;	
			this.addChartItem(showLegend,dataValue, dataComboName, dataGroupName,false,this.count,i);	
		}
		//显示数据组数*每组个数超过10个时显示滚动条	
		if(this.count*dataGroupName.length>10){
			if(this.showScrool){
				createScrool(this.count*dataGroupName.length,this.eleWidth,this.spaceWidth,this.chartWidth);
			}			
		}	
		this.createCoord(this.count);//设置坐标轴
	}
	//显示数据刷新时间
	if(showTime){	
		this.refeshDateTime();
	}
}

//设置坐标系统。默认坐标系统包括坐标轴、刻度、名称，用户也可添加背景、坐标线。
BaseChart.prototype.createCoord = function(count){
	this.drawAsixCoord();
	this.setCoordBack();
	this.drawCoordLines(count);	
}

//取得最大值
BaseChart.prototype.getMaxValue=function(){
	var data=this.getChartData();//获取要显示的数据
	for(i=0;i<data.length;i++){
		var dataValue = Number(data[i].value);
		if(dataValue>this.maxSize){			
			this.maxSize=dataValue;
		}	
	}
}

//画坐标轴、刻度、坐标轴名称
BaseChart.prototype.drawAsixCoord = function(){
	var asixGroup = document.createElementNS("http://www.w3.org/2000/svg", "g");
	chart.appendChild(asixGroup);
	asixGroup.setAttribute("id", "asixGroup");
	var asixPath=document.createElementNS("http://www.w3.org/2000/svg", "path");
	asixGroup.appendChild(asixPath);
	asixPath.setAttribute("d", "M0,0H-5 0V-240 h -5 10 -5 V 0H396 0");
	asixPath.setAttribute("style", "fill:none;stroke:black;filter:url(#DropShadowFilter)");

	var gradUnit=this.chartHeight/10;
	this.getMaxValue();
	for(var i=10;i>=0;i--){
		var gradValue=this.getDoc().createElementNS('http://www.w3.org/2000/svg','text');
		gradValue.appendChild(this.getDoc().createTextNode(this.getTotalGrad(this.maxSize)-this.getTotalGrad(this.maxSize)/10*i+"-"));
		gradValue.setAttribute("transform", "translate(-30,"+ (gradUnit*i-236) + ")");
		asixGroup.appendChild(gradValue);
	}
	//设置坐标轴名称
	var gradXAsixName=this.getDoc().createElementNS('http://www.w3.org/2000/svg','text');
	gradXAsixName.setAttribute("id","xAxisTitle");
	gradXAsixName.setAttribute("font-family", "SimSun");
	asixGroup.appendChild(gradXAsixName);
	this.setTextNodeValue("xAxisTitle", this.xAxisTitle);
	gradXAsixName.setAttribute("style","text-anchor:middle;font-weight:normal;font-size:14");
	gradXAsixName.setAttribute("transform", "translate(-20,34)");
	
	var gradLeftName=this.getDoc().createElementNS('http://www.w3.org/2000/svg','text');
	gradLeftName.setAttribute("id","yAxisTitle");
	gradLeftName.setAttribute("font-family", "SimSun");
	asixGroup.appendChild(gradLeftName);
	this.setTextNodeValue("yAxisTitle", this.yAxisTitle);
	gradLeftName.setAttribute("style","text-anchor:middle;font-weight:normal;font-size:14");
	gradLeftName.setAttribute("transform", "translate(-30,-256)");
	
}

//设置背景
BaseChart.prototype.setCoordBack=function(){
	if(this.getBackgroudColors()){
		var rect=this.getDoc().createElementNS('http://www.w3.org/2000/svg','rect');
		rect.setAttribute("x", 0);
		rect.setAttribute("y", -240);
		rect.setAttribute("width", this.chartWidth);
		rect.setAttribute("height", this.chartHeight);	
		this.doc.getElementById("backGroup").appendChild(rect);
		if(this.getBackgroudColors().length==1){
			rect.setAttribute("fill", this.getBackgroudColors()[0]);
		}else if(this.getBackgroudColors().length==3){			
			//给坐标系背景添加渐变效果
			var bc0=this.getBackgroudColors()[0];
			var bc1=this.getBackgroudColors()[1];
			var bc2=this.getBackgroudColors()[2];
			var stop1= document.createElementNS("http://www.w3.org/2000/svg", "stop");
			linearGrad.appendChild(stop1);
			stop1.setAttribute("stop-color", bc0);
			stop1.setAttribute("offset","0%");
			var stop2= document.createElementNS("http://www.w3.org/2000/svg", "stop");
			linearGrad.appendChild(stop2);
			stop2.setAttribute("stop-color", bc1);
			stop2.setAttribute("offset","30%");
			var stop3= document.createElementNS("http://www.w3.org/2000/svg", "stop");
			linearGrad.appendChild(stop3);
			stop3.setAttribute("stop-color",bc2);
			stop3.setAttribute("offset","60%");
			rect.setAttribute("fill", "url(#linearGrad)");
//			rect.setAttribute("style", "filter:url(#DropShadowFilter)");
		}
	}	
}
//设置是否显示坐标线
BaseChart.prototype.setCoordLineColor=function(xLineColor,yLineColor){
	this.xLineColor=xLineColor;
	this.yLineColor=yLineColor;
}
//画坐标线
BaseChart.prototype.drawCoordLines = function(count){
	var xx=0;
	var yy=0;
	if(this.xLineColor){	
		for(var t=0;t<=10;t++){
			yy=-this.chartHeight/10*t;
			var xline=this.getDoc().createElementNS('http://www.w3.org/2000/svg','line');
			xline.setAttribute("style","stroke-width:0.5;stroke:"+this.xLineColor);
			xline.setAttribute("x1", 0);
			xline.setAttribute("y1", yy);
			xline.setAttribute("x2", this.chartWidth);
			xline.setAttribute("y2", yy);
			this.doc.getElementById("backGroup").appendChild(xline);		
		}
		//如果设置了横坐标线，则用同颜色画纵轴最右端坐标线
		var yline=this.getDoc().createElementNS('http://www.w3.org/2000/svg','line');
		yline.setAttribute("style","stroke-width:0.2;stroke:"+this.xLineColor);
		yline.setAttribute("x1", this.chartWidth);
		yline.setAttribute("y1", 0);
		yline.setAttribute("x2", this.chartWidth);
		yline.setAttribute("y2", -this.chartHeight);
		this.doc.getElementById("backGroup").appendChild(yline);
	}
	if(this.yLineColor){
		for(var m=0;m<count;m++){
			xx=this.chartWidth/(count-1)*m
			var yline=this.getDoc().createElementNS('http://www.w3.org/2000/svg','line');
			yline.setAttribute("style","stroke-width:0.2;stroke:"+this.yLineColor);
			yline.setAttribute("x1", xx);
			yline.setAttribute("y1", 0);
			yline.setAttribute("x2", xx);
			yline.setAttribute("y2", -this.chartHeight);
			this.doc.getElementById("backGroup").appendChild(yline);
		}
	}
}

//创建图例
BaseChart.prototype.createDesList = function(DesListGroup,DesTextGroup,EleID, EleName, EleColor) {
	//var ele=this.getDoc().createElement("rect");
	var ele=this.getDoc().createElementNS('http://www.w3.org/2000/svg','rect');
	ele.setAttribute("transform", "translate(0,"+ 18 * EleID + ")");
	ele.setAttribute("width", "10");
	ele.setAttribute("height", "10");
	ele.setAttribute("style","stroke:white;fill:" + EleColor);
//	this.desList.push(ele);	
	this.getDoc().getElementById(DesListGroup).appendChild(ele);
	
	var ele2=this.getDoc().createElementNS('http://www.w3.org/2000/svg','text');
	ele2.setAttribute("transform", "translate(0,"+ 18 * EleID + ")");
	ele2.appendChild(this.getDoc().createTextNode(EleName));
//	this.desTextList.push(ele2);	
	this.getDoc().getElementById(DesTextGroup).appendChild(ele2);
}

//设置数据更新时间
BaseChart.prototype.refeshDateTime = function() {
	var datetime, temp, date, time;
	datetime = new Date().toLocaleString();
	temp = datetime.lastIndexOf(" ");
	date = datetime.substring(0, temp);
	time = datetime.substring(temp + 1, datetime.length);
	this.setTextNodeValue("updateTime", "数据更新时间: " + date + " " + time);
}

//定义图表元素的线性渐变效果
BaseChart.prototype.setLinearGrad=function(index,color){
	var linearGrad= document.createElementNS("http://www.w3.org/2000/svg", "linearGradient");
	defsLinearGrad.appendChild(linearGrad);
	linearGrad.setAttribute("x1", "0%");
	linearGrad.setAttribute("y1", "0%");
	linearGrad.setAttribute("x2", "0%");
	linearGrad.setAttribute("y2", "100%");
	linearGrad.setAttribute("id", "linearGrad"+index);
	linearGrad.setAttribute("gradientUnits","objectBoundingBox");//objectBoundingBox:以能包裹引用该linearGradient元素的图形对象的最小矩形边界为参考坐标系
	
	var stop1= document.createElementNS("http://www.w3.org/2000/svg", "stop");
	linearGrad.appendChild(stop1);
	stop1.setAttribute("stop-color", color);
	stop1.setAttribute("offset","10%");
	stop1.setAttribute("stop-opacity", 0.5);
	var stop2= document.createElementNS("http://www.w3.org/2000/svg", "stop");
	linearGrad.appendChild(stop2);
	stop2.setAttribute("stop-color", color);
	stop2.setAttribute("stop-opacity", 1);
	stop2.setAttribute("offset","90%");
	
}

BaseChart.prototype.setTextNodeValue = function(id, value) {
	if (this.doc.getElementById(id).hasChildNodes() == true){
		var a=this.doc.getElementById(id);
		var b=a.firstChild;
		//b.setData(value);
		b.nodeValue=value;
	}
	else {
		var item = this.doc.createTextNode(value)
		this.doc.getElementById(id).appendChild(item);
	}
}

//BaseChart.prototype.clearChart = function() {}
//
//BaseChart.prototype.refresh = function() {
//	this.clearChart();
//	this.drawChart(showLegend,showTime);	
//	this.addEvent();
//	this.modifyEvent();
//}

//取得最大显示刻度
BaseChart.prototype.getTotalGrad = function(maxSize){
	var a=Number(maxSize%10);
	var b=Math.floor(maxSize/10);
	var c=0;
	c=b+(10-b%10);
	var totalGrad=c*10;//单元显示刻度*10=最大显示刻度
	return totalGrad;	
}

//addEvent：在原有事件的基础上增加新事件
BaseChart.prototype.addEvent = function(evtName,func) {
	var EleList=this.chartEleGroup.childNodes;//取子节点ff不支持getChildNodes()方法	
	for(var i=0;i<EleList.length;i++){
		objet=EleList.item(i);		
		var pre=objet.getAttribute(evtName);
		if(!pre){
			objet.setAttribute(evtName,func);
		}else{
			objet.setAttribute(evtName,pre+";"+func);
		}		
	}
}

//modifyEvent：将原有事件修改为新事件
BaseChart.prototype.modifyEvent = function(evtName,func) {
	var EleList=this.chartEleGroup.childNodes;
	for(var i=0;i<EleList.length;i++){
		objet=EleList.item(i);
		objet.setAttribute(evtName,func);		
	}
}

//创建右键菜单
BaseChart.prototype.drawMenu = function() {
	if (window.navigator.appName.match(/Adobe/gi)) {
		//contextMenu变量只在Adobo SVG Viewer 3.0中有效，它 同document变量一样，也是window对象的静态全局变量
		var newMenuRoot = parseXML( printNode( document.getElementById( 'myContextMenu' ) ), contextMenu );
		contextMenu.replaceChild( newMenuRoot.firstChild, contextMenu.firstChild );
	}
}


/*
 * 创建一个新的XMLHttpRequest对象
 */
BaseChart.msxmlNames = [ "MSXML2.XMLHTTP.5.0","MSXML2.XMLHTTP.4.0","MSXML2.XMLHTTP.3.0","MSXML2.XMLHTTP","Microsoft.XMLHTTP" ];
 
BaseChart.createXHR =function(){	

	if(BaseChart.httpObjectName){
		try{
			if(BaseChart.httpObjectName=="XMLHttpRequest"){
				return new XMLHttpRequest();
			}else{
				return new ActiveXObject(BaseChart.httpObjectName);
			}
		}catch(e){
			BaseChart.httpObjectName=null;
		}
	}		
	
    /* Mozilla XMLHttpRequest */
    try {
		BaseChart.httpObjectName = "XMLHttpRequest";
		return new XMLHttpRequest();
    } catch(e) {}

    /* Microsoft MSXML ActiveX */
    for (var i=0;i < JSONRpcClient.msxmlNames.length; i++) {
	try {
	    JSONRpcClient.httpObjectName = JSONRpcClient.msxmlNames[i];
	    return new ActiveXObject(JSONRpcClient.msxmlNames[i]);
	} catch (e) {}
    }
    
	BaseChart.httpObjectName=null;
    throw new Error("Can't create XMLHttpRequest object");
};


BaseChart.requestData =function(url){	
	var xhr=BaseChart.createXHR();
	if(xhr!=null){
		xhr.open("GET", url, false);
		xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		xhr.send();
		return eval("("+xhr.responseText+")");		
	}
};

//在图表的周围画矩形（用于遮盖超出滚动条范围的图表）和滚动条
BaseChart.drawScrool = function(){
	var coverRect1=document.createElementNS("http://www.w3.org/2000/svg", "rect");
	chart.appendChild(coverRect1);
	coverRect1.setAttribute("id", "hiddenrectleft");
	coverRect1.setAttribute("transform", "translate(-1000, -500)");//使用x、y属性定位坐标ff不兼容
	coverRect1.setAttribute("width", "1000");
	coverRect1.setAttribute("height", "620");
	coverRect1.setAttribute("style", "fill:white;stroke:none");
	var coverRect2=document.createElementNS("http://www.w3.org/2000/svg", "rect");
	chart.appendChild(coverRect2);
	coverRect2.setAttribute("id", "hiddenrectright");
	coverRect2.setAttribute("transform", "translate(398, -500)");
	coverRect2.setAttribute("width", "1000");
	coverRect2.setAttribute("height", "506");
	coverRect2.setAttribute("style", "fill:white;stroke:none");
	var coverRect3=document.createElementNS("http://www.w3.org/2000/svg", "rect");
	chart.appendChild(coverRect3);
	coverRect3.setAttribute("id", "hiddenrectright2");
	coverRect3.setAttribute("transform", "translate(402, 0)");
	coverRect3.setAttribute("width", "1000");
	coverRect3.setAttribute("height", "100");
	coverRect3.setAttribute("style", "fill:white;stroke:none");
	
	var scrool = document.createElementNS("http://www.w3.org/2000/svg", "g");
	chart.appendChild(scrool);
	scrool.setAttribute("id", "scrool");
}

//滚动条 start
var myMapApp=null;
function createScrool(count,eleWidth,eleSpace,chartWidth) {
	BaseChart.drawScrool();
	myMapApp = new mapApp(false,undefined);
	//scrollbar styles
	var scrollbarStyles = {"fill":"whitesmoke","stroke":"dimgray","stroke-width":1};
	var scrollerStyles = {"fill":"lightgray","stroke":"dimgray","stroke-width":1};
	var triangleStyles = {"fill":"dimgray"};
	var highlightStyles = {"fill":"dimgray","stroke":"dimgray","stroke-width":1};
	var sw=chartWidth-(eleWidth*count+eleSpace*count);//滚动条最大活动宽度	(图形宽度-间隔*个数-宽度*个数)
	//create scrolledObjects to react on scrollbar,50.5,250.5,899,15
	scrolledObject1 = new scrolledObject("parentChart",0,sw,0,-300,"sb1horiz","sb1vert");
	//id,parentNode,x,y,width,height,startValue,endValue,initialWidthPerc,initialOffset,scrollButtonLocations,scrollbarStyles,scrollerStyles,triangleStyles,highlightStyles,functionToCall
	myMapApp.scrollbars["sb1horiz"] = new scrollbar("sb1horiz","scrool",-30,60,446,15,scrolledObject1.maxX,scrolledObject1.minX,0.2495,0,0.005,"top_bottom",scrollbarStyles,scrollerStyles,triangleStyles,highlightStyles,scrolledObject1);
	//myMapApp.scrollbars["sb1vert"] = new scrollbar("sb1vert","bardrag",511,-230,15,660,scrolledObject1.maxY,scrolledObject1.minY,0.4756,0,0.025,"top_bottom",scrollbarStyles,scrollerStyles,triangleStyles,highlightStyles,scrolledObject1);
	return myMapApp;
}
//this object controls the panning and scrolling of the svg elements (panoramas)
//contentId:,maxX,minX,maxY,minY,sbXId,sbYId
function scrolledObject(contentId,maxX,minX,maxY,minY,sbXId,sbYId) {
	this.content = document.getElementById(contentId);
	this.transX = 0;
	this.transY = 0;
	this.maxX = maxX;
	this.minX = minX;
	this.maxY = maxY;
	this.minY = minY;
	this.sbXId = sbXId;
	this.sbYId = sbYId;
	this.panActive = false;
	this.parent = this.content.parentNode;
}
scrolledObject.prototype.scrollbarChanged = function(id,changeType,valueAbs,valuePerc) {
	if (changeType == "scrollChange" || "scrolledStep") {
		if (id.match(/horiz/gi)) {
			this.transX = valueAbs;
		}
		if (id.match(/vert/gi)) {
			this.transY = valueAbs;
		}
		this.content.setAttributeNS(null,"transform","translate("+this.transX+","+this.transY+")");
	}
}
scrolledObject.prototype.handleEvent = function(evt) {
	if (evt.type == "mousedown") {
		this.coords = myMapApp.calcCoord(evt,this.parent);
		this.panActive = true;
	}
	if (evt.type == "mousemove" && this.panActive) {
		var coords = myMapApp.calcCoord(evt,this.parent);
		this.transX += coords.x - this.coords.x;
		this.transY += coords.y - this.coords.y;
		if (this.transX < this.minX) {
			this.transX = this.minX;
		}
		if (this.transX > this.maxX) {
			this.transX = this.maxX;
		}
		if (this.transY < this.minY) {
			this.transY = this.minY;
		}
		if (this.transY > this.maxY) {
			this.transY = this.maxY;
		}
		this.content.setAttributeNS(null,"transform","translate("+this.transX+","+this.transY+")");
		//set scrollbars
		if (myMapApp.scrollbars[this.sbXId]) {
			myMapApp.scrollbars[this.sbXId].scrollToValue(this.transX);
		}
		if (myMapApp.scrollbars[this.sbYId]) {
			myMapApp.scrollbars[this.sbYId].scrollToValue(this.transY);
		}
		this.coords = coords;
	}
	if (evt.type == "mouseup" || evt.type == "mouseout") {
		this.panActive = false;
	}
	//the preventDefault() method is called because there is some evt problem in Webkit because it tries to drag the raster image to desktop or other applications
	evt.preventDefault();
}
//滚动条 end