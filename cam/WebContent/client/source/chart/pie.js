function PieChart() {
	BaseChart.call(this);
	this.moveDistance = 40;
	this.values = new Array();
	this.names = new Array();
	this.chartEleGroup=null;
	this.maxSize=0;
	this.totalSize=0;	
	this.pieEvt="";	
	this.chartHeight = 240;// 图形的高度，用于设置背景
	this.chartWidth = 396;// 图形的宽度
	
	this.pieTopEles = new Array();//存储顶部饼图的扇形元素
	this.pieSideEles = new Array();//存储侧面饼图的扇形元素
	this.pieBottomEles = new Array();//存储底部饼图的扇形元素

	this.topPiePaths=new Array();//存储顶部饼图的路径
	this.topColors=new Array();//存储顶部饼图的颜色
	this.startValues = new Array();//存储画饼图时path起始位置，供重画顶部时用
	this.sizeValues = new Array();//存储画饼图时每个扇形的大小，供重画顶部时用
}

PieChart.prototype=new BaseChart();

PieChart.prototype.initSvg = function() {
	this.drawSvg();
	this.chartEleGroup = this.getDoc().getElementById("slices");
}

//在basechart.js基础上绘制各自图形的元素  
PieChart.prototype.drawSvg = function() {
	//3.1、饼图的组，隶属于chart，包括每个扇形图的组
	var pieChart = document.createElementNS("http://www.w3.org/2000/svg", "g");
	chart.appendChild(pieChart);
	pieChart.setAttribute("id", "pieChart");
	pieChart.setAttribute("transform", "translate(200, -100) scale(1, 0.5)");
	pieChart.setAttribute("style", "filter:url(#DropShadowFilter)");
	//3.1.1、每个扇形的组，隶属于pieChart
	var chartPies = document.createElementNS("http://www.w3.org/2000/svg", "g");
	pieChart.appendChild(chartPies);
	chartPies.setAttribute("id", "slices");
	//3.2、每个扇形显示的名称和值
	var pieitemlabel = document.createElementNS("http://www.w3.org/2000/svg", "g");
	chart.appendChild(pieitemlabel);
	pieitemlabel.setAttribute("id", "pieitemlabel");
	pieitemlabel.setAttribute("transform", "translate(200, -300)");
	var labelitem = document.createElementNS("http://www.w3.org/2000/svg", "text");
	pieitemlabel.appendChild(labelitem);
	labelitem.setAttribute("id", "labelitem");
	labelitem.setAttribute("font-family", "SimSun");
	labelitem.setAttribute("transform", "translate(-10, 330)");
	labelitem.setAttribute("style", "text-anchor:end;font-size:13");
	var labelcolon = document.createElementNS("http://www.w3.org/2000/svg", "text");
	pieitemlabel.appendChild(labelcolon);
	labelcolon.setAttribute("id", "labelcolon");
	labelcolon.setAttribute("transform", "translate(0, 330)");
	labelcolon.setAttribute("style", "text-anchor:middle;font-size:13");
	var labelamount = document.createElementNS("http://www.w3.org/2000/svg", "text");
	pieitemlabel.appendChild(labelamount);
	labelamount.setAttribute("id", "labelamount");
	labelamount.setAttribute("transform", "translate(10, 330)");
	labelamount.setAttribute("style", "text-anchor:begin;font-size:13");
}

//给饼图元素增加click事件
PieChart.prototype.addPieClickEvt = function(func) {
	this.pieEvt=func;
}
//给饼图元素增加click事件
PieChart.prototype.getPieClickEvt = function() {
	return this.pieEvt;
}

//重写BaseChart的画图方法：在完成画图后重画饼图顶部，覆盖其他path
PieChart.prototype.drawChart= function(showLegend,showTime) {
	//设置图表标题
	this.setTextNodeValue("title", this.title);
	if(this.coordType==0){
		var data=this.getChartData();//获取要显示的数据
		this.count=data.length;
		this.setCoordBack();
		this.drawCoordLines();
		for(i=0;i<data.length;i++){
			var dataName = data[i].name;
			var dataValue = Number(data[i].value);	
			this.addChartItem(showLegend,dataValue, dataName, false,this.count,i);// 根据数据画图			
		}
		//重画饼图顶部，覆盖其他path
		this.coverTop(data);
	}	
	//显示数据刷新时间
	if(showTime){	
		this.refeshDateTime();
	}
}

PieChart.prototype.addChartItem = function(hasLegend,value, name, repress,count,index) {
	value = value * 1;
	if ((value < 0) || (isNaN(value))) {
		alert("Negative, textual or null values are not allowed");
		return;
	}	
	this.values.push(value);	
	var color=this.getColor(index);
	
	//创建每个扇形图形的svg元素（用svg path创建，尚未输入path数据）
	//为保持ff兼容性，使用createElementNS方法，而不要使用createElement方法	
	var eleGroup=this.getDoc().createElementNS('http://www.w3.org/2000/svg','g');
	eleGroup.setAttribute("id","elegroup" + index);
	this.chartEleGroup.appendChild(eleGroup);
		
	var eleTop0= this.getDoc().createElementNS('http://www.w3.org/2000/svg','path')
	eleTop0.setAttribute("id","pieEle_" + index);
	eleTop0.setAttribute("style","stroke:none;fill:" + "none");

	var eleBottom= this.getDoc().createElementNS('http://www.w3.org/2000/svg','path')
	eleBottom.setAttribute("id","pieBottom_" + index);
	eleBottom.setAttribute("style","stroke:white;fill:"+"none");
	
	var eleSide= this.getDoc().createElementNS('http://www.w3.org/2000/svg','path')
	eleSide.setAttribute("id","pieSide_" + index);
	eleSide.setAttribute("style","stroke:white;fill:"+color);
	eleSide.setAttribute("onmouseover","window["+this.id+"].displayInfo(evt,'" + name + "', '" + value + "')");
	eleSide.setAttribute("onmouseout","window["+this.id+"].displayInfo(evt,' ', ' ')");
	this.topColors.push(color);
	
	eleGroup.appendChild(eleTop0);
	eleGroup.appendChild(eleSide);
	eleGroup.appendChild(eleBottom);
	
	this.pieTopEles.push(eleTop0);
	this.pieSideEles.push(eleBottom);
	this.pieBottomEles.push(eleSide);
		
	if(hasLegend){
		//设置图例
		this.createDesList("deslist","destext",index, name, color);
	}
	
	if(value>this.maxSize){
		this.maxSize=value;
	}	
	this.totalSize+=value;
	
	if (this.totalSize > 0&&this.values.length==count){
		var PieStart = 0;
		for ( var I = 0; I < this.values.length; I++) {			
			PieStart = this.drawPieSegment(PieStart, this.values[I] / this.totalSize,this.pieTopEles[I],this.pieSideEles[I],this.pieBottomEles[I],I);			
		}		
	}
}

PieChart.prototype.drawPieSegment = function(Start, Size,EleTop, EleBottom,ElemSide,ID) {
	this.startValues.push(Start);
	this.sizeValues.push(Size);
	var PieChartSize = 140;
	var pathBottom = "M0,0L";
	var pathTop="M0,-50L";
	var pathSide="M";
	pathBottom = pathBottom + PieChartSize * Math.sin(Start * Math.PI * 2) + ","+ PieChartSize * Math.cos(Start * Math.PI * 2);
	pathTop=pathTop + PieChartSize * Math.sin(Start * Math.PI * 2) + ","+ (PieChartSize * Math.cos(Start * Math.PI * 2)-50);
	pathSide=pathSide+PieChartSize * Math.sin(Start * Math.PI * 2) + ","+ (PieChartSize * Math.cos(Start * Math.PI * 2)-50);
	if (Size > .5){
		pathBottom = pathBottom + "A" + PieChartSize + " " + PieChartSize
		+ " 1 1 0 " + PieChartSize
		* Math.sin((Start + Size) * Math.PI * 2) + "," + PieChartSize
		* Math.cos((Start + Size) * Math.PI * 2);
		pathTop=pathTop + "A" + PieChartSize + " " + PieChartSize
		+ " 1 1 0 " + PieChartSize
		* Math.sin((Start + Size) * Math.PI * 2) + "," + (PieChartSize
		* Math.cos((Start + Size) * Math.PI * 2)-50);
		pathSide=pathSide + "A" + PieChartSize + " " + PieChartSize
		+" 1 1 0 " + PieChartSize
		* Math.sin((Start + Size) * Math.PI * 2) + "," + (PieChartSize
		* Math.cos((Start + Size) * Math.PI * 2)-50)
		+"L"+PieChartSize
		* Math.sin((Start + Size) * Math.PI * 2) + "," + PieChartSize
		* Math.cos((Start + Size) * Math.PI * 2)
		+"A"+ PieChartSize + " " + PieChartSize
		+" 1 1 1 "+PieChartSize * Math.sin(Start * Math.PI * 2) + ","+ PieChartSize * Math.cos(Start * Math.PI * 2);
		
	}else{
		pathBottom = pathBottom + "A" + PieChartSize + " " + PieChartSize
		+ " 0 0 0 " + PieChartSize
		* Math.sin((Start + Size) * Math.PI * 2) + "," + PieChartSize
		* Math.cos((Start + Size) * Math.PI * 2);
		pathTop=pathTop + "A" + PieChartSize + " " + PieChartSize
		+ " 0 0 0 " + PieChartSize
		* Math.sin((Start + Size) * Math.PI * 2) + "," + (PieChartSize
		* Math.cos((Start + Size) * Math.PI * 2)-50);
		pathSide=pathSide + "A" + PieChartSize + " " + PieChartSize
		+" 0 0 0 " + PieChartSize
		* Math.sin((Start + Size) * Math.PI * 2) + "," + (PieChartSize
		* Math.cos((Start + Size) * Math.PI * 2)-50)
		+"L"+PieChartSize
		* Math.sin((Start + Size) * Math.PI * 2) + "," + PieChartSize
		* Math.cos((Start + Size) * Math.PI * 2)
		+"A"+ PieChartSize + " " + PieChartSize
		+" 0 0 1 "+PieChartSize * Math.sin(Start * Math.PI * 2) + ","+ PieChartSize * Math.cos(Start * Math.PI * 2);
	}
	pathBottom = pathBottom + "z";
	EleTop.setAttribute("d", pathBottom);
	pathTop = pathTop + "z";
	EleBottom.setAttribute("d", pathTop);
	this.topPiePaths.push(pathTop);
	pathSide = pathSide + "z";
	ElemSide.setAttribute("d", pathSide);
	if (Start > 0){	
		EleBottom.setAttribute("onclick", "window["+this.id+"].moveSegment(evt, "+ (Start + Size / 2) + ", true, " + ID + ")");
		ElemSide.setAttribute("onclick", "window["+this.id+"].moveSegment(evt, "+ (Start + Size / 2) + ", true, " + ID + ")");
	}else {
		var Angle = Start + Size / 2;
		X = this.moveDistance * Math.sin(Angle * 2 * Math.PI);
		Y = this.moveDistance * Math.cos(Angle * 2 * Math.PI);
		EleBottom.setAttribute("transform", "translate(" + X + "," + Y + ")");
		ElemSide.setAttribute("transform", "translate(" + X + "," + Y + ")");
		EleBottom.setAttribute("onclick", "window["+this.id+"].moveSegment(evt, "+ ((Start + Size / 2) * -1) + ", false, " + ID + ")");
		ElemSide.setAttribute("onclick", "window["+this.id+"].moveSegment(evt, "+ ((Start + Size / 2) * -1) + ", false, " + ID + ")");
	}
	return Start + Size;
}


PieChart.prototype.coverTop = function(data) {
	for(i=0;i<data.length;i++){
		var eleTop= this.getDoc().createElementNS('http://www.w3.org/2000/svg','path');			
		eleTop.setAttribute("d", this.topPiePaths[i]);
		eleTop.setAttribute("style","stroke:white;fill:"+this.topColors[i]);
		eleTop.setAttribute("id","pieTop_"+i);
		this.chartEleGroup.appendChild(eleTop);
		eleTop.setAttribute("onmouseover","window["+this.id+"].displayInfo(evt,'" + data[i].name + "', '" + data[i].value + "')");
		eleTop.setAttribute("onmouseout","window["+this.id+"].displayInfo(evt,' ', ' ')");
		if (this.startValues[i] > 0){		
			eleTop.setAttribute("onclick", "window["+this.id+"].moveSegment(evt, "+ (this.startValues[i] + this.sizeValues[i] / 2) + ", true, " + i + ")");
		}else {
			var Angle = this.startValues[i] + this.sizeValues[i] / 2;
			X = this.moveDistance * Math.sin(Angle * 2 * Math.PI);
			Y = this.moveDistance * Math.cos(Angle * 2 * Math.PI);
			eleTop.setAttribute("transform", "translate(" + X + "," + Y + ")");
			eleTop.setAttribute("onclick", "window["+this.id+"].moveSegment(evt, "+ ((this.startValues[i] + this.sizeValues[i] / 2) * -1) + ", false, " + i + ")");
		}
	}	
}

//鼠标移动到饼图的扇形元素时会显示该元素代表的含义值
PieChart.prototype.displayInfo = function(MouseEvent,Text,Value) {
	if (Text != " "){
		Percent = " (" + Math.round(Value / this.totalSize * 10000) / 100 + "%)";
	}else{
		Percent = "";
	}			
	this.setTextNodeValue("labelamount",Value + Percent);	
	this.setTextNodeValue("labelitem",Text + "");
	if (Text + Value == "  "){
		s = " ";
	}else{
		s = ":";
	}
	this.setTextNodeValue("labelcolon",s);	
}

//鼠标点击饼图的扇形元素时，该元素会移动
PieChart.prototype.moveSegment = function(MouseEvent, Angle, CanBeDeleted, ID) {
	var ele = MouseEvent.target;
	if (Angle < 0) {
		X = 0
		Y = 0
	} else {
		X = this.moveDistance * Math.sin(Angle * 2 * Math.PI);
		Y = this.moveDistance * Math.cos(Angle * 2 * Math.PI);
	}
//	扇形被点击弹出时（即CanBeDeleted=true时）调用增加的事件
	if(CanBeDeleted){
		eval(this.getPieClickEvt());
	}
	
	var svgdoc = MouseEvent.target.ownerDocument;
	var id=MouseEvent.target.id.toString().substr(MouseEvent.target.id.toString().indexOf("_")+1);
	var pieSide=svgdoc.getElementById("pieSide_"+id);
	var pieTop=svgdoc.getElementById("pieTop_"+id);
	var pieBottom=svgdoc.getElementById("pieBottom_"+id);
 
	pieSide.setAttribute("transform", "translate(" + X + "," + Y + ")");
	pieTop.setAttribute("transform", "translate(" + X + "," + Y + ")");
	pieBottom.setAttribute("transform", "translate(" + X + "," + Y + ")");
	
	pieSide.setAttribute("onclick","window["+this.id+"].moveSegment(evt, " + (Angle * -1) + ", "+ (!CanBeDeleted) + ", " + ID + ")");
	pieTop.setAttribute("onclick","window["+this.id+"].moveSegment(evt, " + (Angle * -1) + ", "+ (!CanBeDeleted) + ", " + ID + ")");
	pieBottom.setAttribute("onclick","window["+this.id+"].moveSegment(evt, " + (Angle * -1) + ", "+ (!CanBeDeleted) + ", " + ID + ")");
}

//覆盖Basechart.prototype.createDesList方法，重画图例
PieChart.prototype.createDesList = function(DesListGroup,DesTextGroup,EleID, EleName, EleColor) {
	var ele=this.getDoc().createElementNS('http://www.w3.org/2000/svg','path');
	var size = 10;
	var path = "M 0 ";
	path=path+18 * EleID+" L "+(size * Math.sin(Math.PI/6)*-1)+","+(size * Math.cos(Math.PI/6)+18 * EleID);
	path=path+" A " + size + " " + size+ " 0 0 0 " + size* Math.sin(Math.PI/6) + "," + (size* Math.cos(Math.PI/6)+18 * EleID)+" z";
	ele.setAttribute("d", path);
	ele.setAttribute("style","stroke:none;fill:" + EleColor);
	this.desList.push(ele);
	
	this.getDoc().getElementById(DesListGroup).appendChild(ele);

	//var ele2=this.getDoc().createElement("text");
	var ele2=this.getDoc().createElementNS('http://www.w3.org/2000/svg','text');
	ele2.setAttribute("transform", "translate(0,"+ 18 * EleID + ")");
	ele2.appendChild(this.getDoc().createTextNode(EleName));
	this.desTextList.push(ele2);
	
	this.getDoc().getElementById(DesTextGroup).appendChild(ele2);
}



