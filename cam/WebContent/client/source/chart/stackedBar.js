function StackedBarChart() {
	BaseChart.call(this);
	this.chartHeight = 240;// 柱图的高度，即y轴高度
	this.chartWidth = 396;// 柱图的宽度度
	this.eleWidth=26;//每个矩形的宽度
	this.spaceWidth=15;//矩形间的间隔宽度
	
	this.chartEleGroup=null;
	this.barEleNames = new Array();//每个柱形的名称
	this.sumValues = new Array();
	this.values = new Array();
	this.stackDesList=new Array();
	this.eventGroup=null;
	this.maxSize=0;
	this.angleFactor = Math.pow(2, 0.5);
}
StackedBarChart.prototype=new BaseChart();

StackedBarChart.prototype.initSvg = function() {	
	this.coordType=1;
	this.showScrool=true;
	this.drawSvg();
	this.chartEleGroup = this.getDoc().getElementById("parentChart");
}

//在basechart.js基础上绘制各自图形的元素
StackedBarChart.prototype.drawSvg=function(){
	//3.1、堆型柱状图的组，隶属于chart
	var stackedBarChart = document.createElementNS("http://www.w3.org/2000/svg", "g");
	chart.appendChild(stackedBarChart);
	stackedBarChart.setAttribute("id", "stackedBarChart");

	//3.1.1、柱形的组，隶属于chart
	var parentChart = document.createElementNS("http://www.w3.org/2000/svg", "g");
	stackedBarChart.appendChild(parentChart);
	parentChart.setAttribute("id", "parentChart");
	//3.1.1.1、每个柱形显示的名称
	var labels = document.createElementNS("http://www.w3.org/2000/svg", "g");
	parentChart.appendChild(labels);
	labels.setAttribute("id", "labels");
	labels.setAttribute("transform", "translate(6, 12)");

	//3.1.1.2、每个柱形的形状,每个柱形由多个矩形组成
	var stacks = document.createElementNS("http://www.w3.org/2000/svg", "g");
	parentChart.appendChild(stacks);
	stacks.setAttribute("id", "stacks");
	//stacks.setAttribute("style", "fill:none;stroke:none;filter:url(#DropShadowFilter)");
	//stacks.setAttribute("style", "filter:url(#DropShadowFilter)");
	//stacks.setAttribute("fill", "url(#linearGrad)");
	var stacksValue = document.createElementNS("http://www.w3.org/2000/svg", "g");
	parentChart.appendChild(stacksValue);
	stacksValue.setAttribute("id", "stacksValue");	
}

StackedBarChart.prototype.addChartItem = function(hasLegend,value, name, repress,count,index) {
	var sumValue=0;
	for(var i=0;i<value.length;i++){
		sumValue+=value[i];
	}
	this.sumValues.push(sumValue);
	this.values.push(value);

	var eleName= this.getDoc().createElementNS('http://www.w3.org/2000/svg','text');
	eleName.setAttribute("transform", "rotate(45)");
	eleName.setAttribute("font-family", "SimSun");
	eleName.setAttribute("font-size", "14");
	eleName.appendChild(this.getDoc().createTextNode(name + ""));
	this.getDoc().getElementById("labels").appendChild(eleName);
	this.barEleNames.push(eleName);
	
	if(sumValue>this.maxSize){
		this.maxSize=sumValue;
	}	
	
	if (this.sumValues.length==count){
		var barStart = 0;
		var totalGrad=this.getTotalGrad(this.maxSize);
		for ( var I = 0; I < this.sumValues.length; I++) {
			barStart = this.drawBarSegment(this.values[I],this.sumValues[I],barStart, this.sumValues[I]/totalGrad, this.barEleNames[I]);			
		}
		//设置图例
		var desList=this.getStackDesList();
		for(var d=0;d<desList.length;d++){
			this.createDesList("deslist","destext", d, desList[d], this.getColor(value.length));
		}
	}
}
StackedBarChart.prototype.drawBarSegment = function(value,sum,Start, Height,Label) {
	var subHeightPer=0;//每个子矩形占整组矩形的高度百分比
	var y=0;
	var x=0;
	
	for(var i=0;i<value.length;i++){
		//为每个矩形准备线性渐变效果
		this.setLinearGrad(i,this.getColor(value.length));
		//画矩形
		subHeightPer=value[i]/sum;
		var h=this.chartHeight*Height*subHeightPer;//每个子矩形的高度
		x=Start;
		y=y-h;
		var ele= this.getDoc().createElementNS('http://www.w3.org/2000/svg','rect');
		ele.setAttribute("x", x);
		ele.setAttribute("y", y);
		ele.setAttribute("width", this.eleWidth);
		ele.setAttribute("height", h);	
//		ele.setAttribute("style","fill:" + this.getColor(value.length));
		ele.setAttribute("style","stroke:none;fill:" + "url(#linearGrad"+i+")");
		this.getDoc().getElementById("stacks").appendChild(ele);
		//为 矩形设置鼠标事件
		var barValue=value[i];
		ele.setAttribute("onmouseover", "window["+this.id+"].displayValue(evt,'"+barValue+"')");
		ele.setAttribute("onmouseout", "window["+this.id+"].hiddenValue()");
	}
	Label.setAttribute("x", Start / this.angleFactor)
	Label.setAttribute("y", Start * -1 / this.angleFactor)
	
	return Start+this.eleWidth+this.spaceWidth;	
}
StackedBarChart.prototype.setStackDesList= function(desList){	
	this.stackDesList=desList;
}
StackedBarChart.prototype.getStackDesList= function(){
	return this.stackDesList;
}

StackedBarChart.prototype.displayValue= function(evt,value){
	var objet=evt.target;
	var x=Number(objet.getAttribute("x"));
	var y=Number(objet.getAttribute("y"));
	
	var eleValue=this.getDoc().createElementNS('http://www.w3.org/2000/svg','text');
	eleValue.setAttribute("style","text-anchor:start;font-weight:bold;font-size:13;visibility:show");
	eleValue.appendChild(this.getDoc().createTextNode(value));
	eleValue.setAttribute("x", x+this.eleWidth/3);
	eleValue.setAttribute("y", y+10);
	this.getDoc().getElementById("stacksValue").appendChild(eleValue);
}
StackedBarChart.prototype.hiddenValue= function(){
	var svChildren=this.getDoc().getElementById("stacksValue").childNodes;
	for(var i=0;i<svChildren.length;i++){
		this.getDoc().getElementById("stacksValue").removeChild(svChildren.item(i));
	}
}






