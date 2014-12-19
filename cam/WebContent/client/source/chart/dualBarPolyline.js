//DualBarPolylineChart继承自DualAxisChart，是双轴图形的实现类
function DualBarPolylineChart() {
	DualAxisChart.call(this);
	this.chartHeight = 240;//图形的高度
	this.chartWidth = 396;// 图形的宽度
	this.eleWidth=34;//每个矩形的宽度
	this.spaceWidth=32;//矩形间的间隔宽度
	
	this.leftColors=["#8B008B"];
	this.colorsL=new Array();
	this.leftCurrentColor=0;
	this.leftGroup=new Array();
	this.leftElements = new Array();
	this.leftEleValues = new Array();//每个柱形的值
	this.leftEleNames = new Array();//每个柱形的名称
	this.valuesLeft = new Array();
	this.maxSizeLeft=0;	
	
	this.rightColor="red";
	this.colorsR=new Array();
	this.rightCurrentColor=0;
	this.rightGroup=new Array();
	this.lineColor="red";	
	this.rightElements = new Array();//每个点
	this.rightEleValues = new Array();//每个点的值	
	this.valuesRight = new Array();
	this.maxSizeRight=0;
	this.minSizeRight=0;
	this.diffGradRight=0;
	
	this.names = new Array();
	this.angleFactor = Math.pow(2, 0.5);
	
}
DualBarPolylineChart.prototype=new DualAxisChart();

DualBarPolylineChart.prototype.initSvg = function() {
	this.coordType=2;
	this.showScrool=true;
	this.drawSvg();
	this.leftGroup = this.getDoc().getElementById("leftShapeGroup");
	this.rightGroup=this.getDoc().getElementById("rightShapeGroup");
}

DualBarPolylineChart.prototype.drawSvg=function(){
	//在basechart.js基础上绘制各自图形的元素  start
	//3.1、双轴图形的组，隶属于chart，包括每个柱体的组、折线图的组、坐标轴的组、坐标刻度的组
	var dualAxisChart = document.createElementNS("http://www.w3.org/2000/svg", "g");
	chart.appendChild(dualAxisChart);
	dualAxisChart.setAttribute("id", "dualAxisChart");

	//图形，包括左侧数据和右侧数据展示的图形
	var parentChart=document.createElementNS("http://www.w3.org/2000/svg", "g");
	dualAxisChart.appendChild(parentChart);
	parentChart.setAttribute("id", "parentChart");

	//3.1.1、左侧数据展现的图形组，隶属于dualAxisChart，包括图形（柱形）、名称、值
	var chartLeft = document.createElementNS("http://www.w3.org/2000/svg", "g");
	parentChart.appendChild(chartLeft);
	chartLeft.setAttribute("id", "chartleft");
	//3.1.1.1、每个图形的形状
	var leftShapeGroup = document.createElementNS("http://www.w3.org/2000/svg", "g");
	chartLeft.appendChild(leftShapeGroup);
	leftShapeGroup.setAttribute("id", "leftShapeGroup");
	//leftShape.setAttribute("style", "filter:url(#DropShadowFilter)");
	//3.1.1.2、每个图形显示的名称
	var leftLabels = document.createElementNS("http://www.w3.org/2000/svg", "g");
	chartLeft.appendChild(leftLabels);
	leftLabels.setAttribute("id", "leftLabels");
	leftLabels.setAttribute("transform", "translate(16, 12)");
	//3.1.1.3、每个图形显示的值
	var leftValues = document.createElementNS("http://www.w3.org/2000/svg", "g");
	chartLeft.appendChild(leftValues);
	leftValues.setAttribute("id", "leftValues");

	//3.1.2、右侧数据展现的图形组，隶属于dualAxisChart，包括图形（点）、值、折线
	var chartRight = document.createElementNS("http://www.w3.org/2000/svg", "g");
	parentChart.appendChild(chartRight);
	chartRight.setAttribute("id", "chartRight");
	//3.1.2.2、折线
	var rightLine = document.createElementNS("http://www.w3.org/2000/svg", "g");
	chartRight.appendChild(rightLine);
	rightLine.setAttribute("id", "rightLine");
	//rightLine.setAttribute("style", "fill:none;stroke:yellow");
	//3.1.2.1、每个图形
	var rightShapeGroup = document.createElementNS("http://www.w3.org/2000/svg", "g");
	chartRight.appendChild(rightShapeGroup);
	rightShapeGroup.setAttribute("id", "rightShapeGroup");
	//3.1.1.4、每个图形显示的值
	var rightValues = document.createElementNS("http://www.w3.org/2000/svg", "g");
	chartRight.appendChild(rightValues);
	rightValues.setAttribute("id", "rightValues");
//	rightValues.setAttribute("style", "stroke:yellow");
	rightValues.setAttribute("transform", "translate(10, -52)");

}

DualBarPolylineChart.prototype.addChartItemLeft = function(hasLegend,value, name, repress,count,index) {
	value = value * 1;
	if ((value < 0) || (isNaN(value))) {
		alert("Negative, textual or null values are not allowed");
		return;
	}
	this.valuesLeft.push(value);
	
	var color=this.getColorLeft();
	this.colorsL.push(color);	
	var eleValue= this.getDoc().createElementNS('http://www.w3.org/2000/svg','text');
	eleValue.setAttribute("style","text-anchor:middle;font-weight:bold;font-size:13");
	eleValue.appendChild(this.getDoc().createTextNode(value + ""));
	this.getDoc().getElementById("leftValues").appendChild(eleValue);
	this.leftEleValues.push(eleValue);
	
	var eleName= this.getDoc().createElementNS('http://www.w3.org/2000/svg','text');
	eleName.setAttribute("transform", "rotate(45)");
	eleName.setAttribute("font-family", "SimSun");
	eleName.setAttribute("font-size", "14");
	eleName.appendChild(this.getDoc().createTextNode(name + ""));
	this.getDoc().getElementById("leftLabels").appendChild(eleName);
	this.leftEleNames.push(eleName);
	
	//创建每个柱形图形的svg元素（用svg path创建，尚未输入path数据）
	//为保持ff兼容性，使用createElementNS方法，而不要使用createElement方法
	var ele= this.getDoc().createElementNS('http://www.w3.org/2000/svg','rect');
	ele.setAttribute("id","barEle" + index);
	ele.setAttribute("style","stroke:none;fill:" + color);
	this.leftGroup.appendChild(ele);
	this.leftElements.push(ele);
	
	if((this.leftColors.length>1)&&(hasLegend)){
		//设置图例
		this.createDesList("deslist","destext",index, name, color);
	}
	if(value>this.maxSizeLeft){
		this.maxSizeLeft=value;
	}	
	
	if (this.valuesLeft.length==count){
		var barStart = 0;
		var totalGrad=this.getTotalGrad(this.maxSizeLeft);
		for ( var I = 0; I < this.valuesLeft.length; I++) {
			//Values[I]/totalGrad：每个显示值/总刻度=每个显示值在坐标中的显示高度比例
			barStart = this.drawBarSegment(barStart, this.valuesLeft[I]/totalGrad, this.leftElements[I],  this.leftEleNames[I], this.leftEleValues[I],count,I,this.colorsL[I]);
		}
	}
}
DualBarPolylineChart.prototype.addChartItemRight = function(hasLegend,value, repress,count,index) {
	value = value * 1;
	if ((isNaN(value))) {
		alert("Negative, textual or null values are not allowed");
		return;
	}
	this.valuesRight.push(value);	
	var color=this.getColorRight();
	this.colorsR.push(color);
	var eleValue= this.getDoc().createElementNS('http://www.w3.org/2000/svg','text');
	eleValue.setAttribute("style","text-anchor:middle;font-weight:bold;font-size:13");
	eleValue.setAttribute("style", "stroke:"+this.lineColor);
	eleValue.appendChild(this.getDoc().createTextNode(value + "%"));
	this.getDoc().getElementById("rightValues").appendChild(eleValue);
	this.rightEleValues.push(eleValue);
		
	var ele= this.getDoc().createElementNS('http://www.w3.org/2000/svg','circle');
	ele.setAttribute("style","stroke:none;fill:" + color);
	ele.setAttribute("r","4");
	this.getDoc().getElementById("rightShapeGroup").appendChild(ele);
	this.rightElements.push(ele);
	
	var polyLine= this.getDoc().createElementNS('http://www.w3.org/2000/svg','polyline');
	polyLine.setAttribute("style", "fill:none;stroke:"+this.lineColor);
	this.getDoc().getElementById("rightLine").appendChild(polyLine);

	if(value>this.maxSizeRight){
		this.maxSizeRight=value;
	}
	if(value<this.minSizeRight){
		this.minSizeRight=value;
	}	
	if (this.valuesRight.length==count){		
		var pointStart = 0;		
		var maxGrad=this.getMaxGrad(this.maxSizeRight);
		var minGrad=this.getMinValue(this.minSizeRight);
		this.diffGrad=this.getDiffGrad(maxGrad,minGrad);
		var totalGrad=this.diffGrad*10;
		minGrad=this.getMinGrad(maxGrad,this.diffGrad);
		for ( var I = 0; I < this.valuesRight.length; I++) {
			//Values[I]/totalGrad：每个显示值/总刻度=每个显示值在坐标中的显示高度比例
			pointStart = this.drawPolys(count,pointStart, (this.valuesRight[I]-minGrad)/totalGrad, this.rightElements[I], this.rightEleValues[I],I,this.colorsR[I]);
			
		}
		//用折线连接节点
		var pointsStr=this.getPolylinePath(this.rightElements);
		polyLine.setAttribute("points", pointsStr);
	}
}
//根据数据点组织折线路径
DualBarPolylineChart.prototype.getPolylinePath=function(polys){
	var points="";	
	for ( var I = 0; I < polys.length; I++) {	
		points=points+polys[I].getAttribute("cx")+", "+polys[I].getAttribute("cy")+" ";
	}
	return points;
}
//根据数据画点
DualBarPolylineChart.prototype.drawPolys = function(count,Start, Height, Element, Value,index,color) {
	var h=this.chartHeight*Height;//每个点的高度
	var x=Start+this.spaceWidth/2;
	var y=-h;
	this.setLinearGrad(index+"l",color);
	Element.setAttribute("cx", x);
	Element.setAttribute("cy", y);	
	Element.setAttribute("style","stroke:none;fill:" + "url(#linearGrad"+index+"l"+")");
	Value.setAttribute("x", x-this.spaceWidth/2);//点值位于矩形的左边线，避免和矩形值重叠
	Value.setAttribute("y", y+70);	
	return Start+this.eleWidth+this.spaceWidth;
}
DualBarPolylineChart.prototype.drawBarSegment = function(Start, Height, Element,  Label,Value,count,index,color) {	
	//方法2：设置每个矩形的宽度
	var h=this.chartHeight*Height;//每个矩形的高度
	var x=Start+this.spaceWidth/2;
	var y=-h;
	this.setLinearGrad(index+"r",color);
	Element.setAttribute("x", x);
	Element.setAttribute("y", y);
	Element.setAttribute("width", this.eleWidth);
	Element.setAttribute("height", h);
	Element.setAttribute("style","stroke:none;fill:" + "url(#linearGrad"+index+"r"+")");
	Label.setAttribute("x", Start / this.angleFactor)
	Label.setAttribute("y", Start * -1 / this.angleFactor)

	Value.setAttribute("x", x+this.eleWidth/2);
	Value.setAttribute("y", y-6);
		
	return Start+this.eleWidth+this.spaceWidth;
}
//存取纵轴右边连线的显示颜色
DualBarPolylineChart.prototype.getLineColor= function() {
	return this.lineColor;
}
DualBarPolylineChart.prototype.setLineColor = function(color) {
	this.lineColor=color;
}