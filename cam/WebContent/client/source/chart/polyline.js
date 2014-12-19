function PolylineChart() {
	BaseChart.call(this);
	this.chartHeight = 240;// 图形的高度，即y轴高度
	this.chartWidth = 396;//图形的宽度
	this.polyElements = new Array();
	this.polyEleValues = new Array();//每个点的值
	this.polyEleNames = new Array();//每个点的名称
	this.values = new Array();
	this.names = new Array();
	this.chartEleGroup=null;
	this.maxSize=0;
	this.totalSize=0;
	this.angleFactor = Math.pow(2, 0.5);
}
PolylineChart.prototype=new BaseChart();

PolylineChart.prototype.initSvg = function() {
	this.coordType=1;
	this.drawSvg();
	this.chartEleGroup = this.getDoc().getElementById("points");
}


//在basechart.js基础上绘制各自图形的元素
PolylineChart.prototype.drawSvg = function() {
	//3.1、折线图的组，隶属于chart
	var polylineChart = document.createElementNS("http://www.w3.org/2000/svg", "g");
	chart.appendChild(polylineChart);
	polylineChart.setAttribute("id", "polylineChart");
	//3.1.1、折线图的组
	var chartPolys = document.createElementNS("http://www.w3.org/2000/svg", "g");
	polylineChart.appendChild(chartPolys);
	chartPolys.setAttribute("id", "polys");
	chartPolys.setAttribute("style", "filter:url(#DropShadowFilter)");	
	//3.1.1.1、连接点的线
	var line = document.createElementNS("http://www.w3.org/2000/svg", "g");
	chartPolys.appendChild(line);
	line.setAttribute("id", "line");
	line.setAttribute("style", "fill:none;stroke:black");
	//3.1.1.2、每个点图形
	var points = document.createElementNS("http://www.w3.org/2000/svg", "g");
	chartPolys.appendChild(points);
	points.setAttribute("id", "points");	
	//3.1.1.3、每个点显示的值
	var pointvalues = document.createElementNS("http://www.w3.org/2000/svg", "g");
	polylineChart.appendChild(pointvalues);
	pointvalues.setAttribute("id", "pointvalues");
	pointvalues.setAttribute("transform", "translate(8, -30)");	
	//3.1.2、x轴显示的名称
	var labels = document.createElementNS("http://www.w3.org/2000/svg", "g");
	polylineChart.appendChild(labels);
	labels.setAttribute("id", "labels");
	labels.setAttribute("transform", "translate(6, 12)");
}

PolylineChart.prototype.addChartItem = function(hasLegend,value, name, repress,count,index) {
	value = value * 1;
	if ((value <0) || (isNaN(value))) {
		alert("Negative, textual or null values are not allowed");
		return;
	}
	
	this.values[this.values.length] = value;
	
	var color=this.getColor();
		
	var eleValue= this.getDoc().createElementNS('http://www.w3.org/2000/svg','text');
	eleValue.setAttribute("style","text-anchor:middle;font-weight:bold;font-size:13;visibility:hidden");
	eleValue.appendChild(this.getDoc().createTextNode(name+": "+value + ""));
	this.getDoc().getElementById("pointvalues").appendChild(eleValue);
	this.polyEleValues.push(eleValue);
	
	var eleName= this.getDoc().createElementNS('http://www.w3.org/2000/svg','text');
	eleName.setAttribute("transform", "rotate(45)");
	eleName.setAttribute("font-family", "SimSun");
	eleName.setAttribute("font-size", "11");
	eleName.appendChild(this.getDoc().createTextNode(name + ""));
	this.getDoc().getElementById("labels").appendChild(eleName);
	this.polyEleNames.push(eleName);
	if(count<=15){
		if (window.navigator.appName.match(/Adobe/gi)) {
			eleName.style.setProperty('visibility', 'show');
		}
		if (window.navigator.appName.match(/Netscape/gi)) {
			eleName.style.visibility='visible';
		}
		
	}else{
		if (window.navigator.appName.match(/Adobe/gi)) {
			eleName.style.setProperty('visibility', 'hidden');
		}
		if (window.navigator.appName.match(/Netscape/gi)) {
			eleName.style.visibility='hidden';
		}
		
	}
	
	
	var ele= this.getDoc().createElementNS('http://www.w3.org/2000/svg','circle');
	ele.setAttribute("id","barEle" + index);
	ele.setAttribute("style","stroke:white;fill:" + color);
	ele.setAttribute("r","4");	
	if (window.navigator.appName.match(/Adobe/gi)) {
		//ie
		ele.setAttribute("onmouseover", "window["+this.id+"].polyEleValues["+ index+ "].style.setProperty('visibility', 'show')");
		ele.setAttribute("onmouseout", "window["+this.id+"].polyEleValues["+ index+ "].style.setProperty('visibility', 'hidden')");
	}
	if (window.navigator.appName.match(/Netscape/gi)) {
		//firefox
		ele.setAttribute("onmouseover", "window["+this.id+"].polyEleValues["+ index+ "].style.visibility='visible'");
		ele.setAttribute("onmouseout", "window["+this.id+"].polyEleValues["+ index+ "].style.visibility='hidden'");
	}
	this.getDoc().getElementById("points").appendChild(ele);
	this.polyElements.push(ele);
	
	var polyLine= this.getDoc().createElementNS('http://www.w3.org/2000/svg','polyline');
	this.getDoc().getElementById("line").appendChild(polyLine);	
	if(hasLegend){
		//设置图例
		this.createDesList("deslist","destext",index, name, color);
	}
		
	if(value>this.maxSize){
		this.maxSize=value;
	}	
	this.totalSize+=value;
	
	if (this.totalSize > 0&&this.values.length==count){
		var pointStart = -10;
		var totalGrad=this.getTotalGrad(this.maxSize);
		for ( var I = 0; I < this.values.length; I++) {
			//Values[I]/totalGrad：每个显示值/总刻度=每个显示值在坐标中的显示高度比例
			pointStart = this.drawPolys(count,pointStart, this.values[I]/totalGrad, this.polyElements[I],  this.polyEleNames[I], this.polyEleValues[I],I);
		}
		//用折线连接节点
		var pointsStr=this.getPolylinePath(this.polyElements);
		polyLine.setAttribute("points", pointsStr);
		
	}
}
PolylineChart.prototype.getPolylinePath=function(polys){
	var points="";	
	for ( var I = 0; I < polys.length; I++) {	
		points=points+polys[I].getAttribute("cx")+", "+polys[I].getAttribute("cy")+" ";
	}
	return points;
}

PolylineChart.prototype.drawPolys = function(count,Start, Height, Element,  Label,Value,I) {
	var cx=this.chartWidth/(count-1)*I;
	var cy=-this.chartHeight * Height;
	Element.setAttribute("cx", cx);
	Element.setAttribute("cy", cy);

	Label.setAttribute("x", Start / this.angleFactor)
	Label.setAttribute("y", Start * -1 / this.angleFactor)

	Value.setAttribute("x", Start);
	Value.setAttribute("y", (- this.chartHeight * Height));
	
	return Start + this.chartWidth/(count-1);
}

//覆盖Basechart.prototype.createDesList方法，重画图例
PolylineChart.prototype.createDesList = function(DesListGroup,DesTextGroup,EleID, EleName, EleColor) {
	//var ele=this.getDoc().createElement("rect");
	var ele=this.getDoc().createElementNS('http://www.w3.org/2000/svg','circle');
	ele.setAttribute("transform", "translate(0,4)");
	ele.setAttribute("cx", "0");
	ele.setAttribute("cy", 18 * EleID);
	ele.setAttribute("r", "5");
	ele.setAttribute("style","stroke:white;fill:" + EleColor);
	this.desList.push(ele);
	
	this.getDoc().getElementById(DesListGroup).appendChild(ele);

	//var ele2=this.getDoc().createElement("text");
	var ele2=this.getDoc().createElementNS('http://www.w3.org/2000/svg','text');
	ele2.setAttribute("transform", "translate(0,"+ 18 * EleID + ")");
	ele2.appendChild(this.getDoc().createTextNode(EleName));
	this.desTextList.push(ele2);
	
	this.getDoc().getElementById(DesTextGroup).appendChild(ele2);
}




