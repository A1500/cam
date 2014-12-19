function BarChart() {
	BaseChart.call(this);
	this.chartHeight = 240;// 柱图的高度，即y轴高度
	this.chartWidth = 396;// 柱图的宽度度
	this.eleWidth=20;//每个矩形的宽度
	this.spaceWidth=20;//矩形间的间隔宽度
	this.barElements = new Array();
	this.barEleValues = new Array();//每个柱形的值
	this.barEleNames = new Array();//每个柱形的名称
	this.values = new Array();
	this.names = new Array();
	this.chartEleGroup=null;
	this.maxSize=0;
	this.totalSize=0;
	this.angleFactor = Math.pow(2, 0.5);
}
BarChart.prototype=new BaseChart();

BarChart.prototype.initSvg = function() {
	this.coordType=1;
	this.showScrool=true;
	this.drawSvg();
	this.chartEleGroup = this.getDoc().getElementById("bars");	
}

//在basechart.js基础上绘制各自图形的元素
BarChart.prototype.drawSvg = function() {
	//3.1.1、每个柱形的组，隶属于barChart，包括柱形、名称、值
	var parentChart = document.createElementNS("http://www.w3.org/2000/svg", "g");
	chart.appendChild(parentChart);
	parentChart.setAttribute("id", "parentChart");
	//3.1.1.1、每个柱形的形状
	var bars = document.createElementNS("http://www.w3.org/2000/svg", "g");
	parentChart.appendChild(bars);
	bars.setAttribute("id", "bars");
	bars.setAttribute("style", "filter:url(#DropShadowFilter)");
	//3.1.1.2、每个柱形显示的名称
	var labels = document.createElementNS("http://www.w3.org/2000/svg", "g");
	parentChart.appendChild(labels);
	labels.setAttribute("id", "labels");
	labels.setAttribute("transform", "translate(6, 12)");
	//3.1.1.3、每个柱形显示的值
	var barvalues = document.createElementNS("http://www.w3.org/2000/svg", "g");
	parentChart.appendChild(barvalues);
	barvalues.setAttribute("id", "barvalues");
	barvalues.setAttribute("transform", "translate(10, -300)");		
}


BarChart.prototype.addChartItem = function(hasLegend,value, name, repress,count,index) {
	value = value * 1;
	if ((value < 0) || (isNaN(value))) {
		alert("Negative, textual or null values are not allowed");
		return;
	}
	
	this.values.push(value);
	
	var color=this.getColor();
		
	var eleValue= this.getDoc().createElementNS('http://www.w3.org/2000/svg','text');
	eleValue.setAttribute("style","text-anchor:middle;font-weight:bold;font-size:13;visibility:hidden");
	eleValue.appendChild(this.getDoc().createTextNode(value + ""));
	this.getDoc().getElementById("barvalues").appendChild(eleValue);
	this.barEleValues.push(eleValue);
	
	var eleName= this.getDoc().createElementNS('http://www.w3.org/2000/svg','text');
	eleName.setAttribute("transform", "rotate(45)");
	eleName.setAttribute("font-family", "SimSun");
	eleName.setAttribute("font-size", "11");
	eleName.appendChild(this.getDoc().createTextNode(name + ""));
	this.getDoc().getElementById("labels").appendChild(eleName);
	this.barEleNames.push(eleName);
	
	
	//创建每个柱形图形的svg元素（用svg path创建，尚未输入path数据）
	//为保持ff兼容性，使用createElementNS方法，而不要使用createElement方法
	var ele= this.getDoc().createElementNS('http://www.w3.org/2000/svg','path');
	ele.setAttribute("id","barEle" + index);
	if(value==0){
		ele.setAttribute("style","stroke:white;fill:none");
	}else{
		ele.setAttribute("style","stroke:white;fill:" + color);
	}	
	if (window.navigator.appName.match(/Adobe/gi)) {
		//ie
		ele.setAttribute("onmouseover", "window["+this.id+"].barEleValues["+ index+ "].style.setProperty('visibility', 'show')");
		ele.setAttribute("onmouseout", "window["+this.id+"].barEleValues["+ index+ "].style.setProperty('visibility', 'hidden')");
	}
	if (window.navigator.appName.match(/Netscape/gi)) {
		//firefox
		ele.setAttribute("onmouseover", "window["+this.id+"].barEleValues["+ index+ "].style.visibility='visible'");
		ele.setAttribute("onmouseout", "window["+this.id+"].barEleValues["+ index+ "].style.visibility='hidden'");
	}

	this.chartEleGroup.appendChild(ele);
	this.barElements.push(ele);
		
	if(hasLegend){
		//设置图例
		this.createDesList("deslist","destext",index, name, color);
	}
	
	if(value>this.maxSize){
		this.maxSize=value;
	}	
	this.totalSize+=value;
	
	if (this.totalSize > 0&&this.values.length==count){
		var barStart = 0;
		var totalGrad=this.getTotalGrad(this.maxSize);
		for ( var I = 0; I < this.values.length; I++) {
			//Values[I]/totalGrad：每个显示值/总刻度=每个显示值在坐标中的显示高度比例
			barStart = this.drawBarSegment(barStart, this.values[I]/totalGrad, this.barElements[I],  this.barEleNames[I], this.barEleValues[I]);
		}
	}
}

BarChart.prototype.drawBarSegment = function(Start, Height, Element,  Label,Value) {
	var XOffset3D = 8;// 每个柱形宽度的x轴偏移数
	var YOffset3D = 5;// 每个柱形宽度的y轴偏移数
	
//	//方法1：根据显示数据个数计算相应的柱形宽度
//	var this.eleWidth;
//	var num0=Math.ceil(28/dataLenth);
//	var num1=Math.ceil(26/dataLenth);
//	var num2=Math.ceil(16/dataLenth);
//	if(dataLenth<=2){
//		this.eleWidth=(BarChartWidth-(dataLenth*num0-1)*this.spaceWidth)/BarTotalSize;
//	}else if(dataLenth<=4&&dataLenth>2){
//		this.eleWidth=(BarChartWidth-(dataLenth*num1-1)*this.spaceWidth)/BarTotalSize;
//	}else{
//		this.eleWidth=(BarChartWidth-(dataLenth*num2-1)*this.spaceWidth)/BarTotalSize;
//	}
	//方法2：柱形使用固定宽度
	var PathData = "M" + (Start + this.eleWidth) + ",0"
	PathData = PathData + "h" + (this.eleWidth * -1)
	PathData = PathData + "v" + (Height * this.chartHeight * -1)
	PathData = PathData + "l" + XOffset3D + ",-" + YOffset3D
	PathData = PathData + "h" + this.eleWidth
	PathData = PathData + "v" + (Height * this.chartHeight)
	PathData = PathData + "l-" + XOffset3D + "," + YOffset3D
	PathData = PathData + "v" + (Height * this.chartHeight * -1)
	PathData = PathData + "h" + (this.eleWidth * -1)
	PathData = PathData + "h" + this.eleWidth
	PathData = PathData + "l" + XOffset3D + ",-" + YOffset3D
	PathData = PathData + "l-" + XOffset3D + "," + YOffset3D

	Element.setAttribute("d", PathData);
	
	Label.setAttribute("x", Start / this.angleFactor)
	Label.setAttribute("y", Start * -1 / this.angleFactor)

	Value.setAttribute("x", Start);
	Value.setAttribute("y", (285 - this.chartHeight * Height));
	
	return Start + this.eleWidth+this.spaceWidth;//20表示每个柱形之间的间隔
}





