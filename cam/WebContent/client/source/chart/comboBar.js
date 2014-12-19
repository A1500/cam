function ComboBarChart() {
	BaseChart.call(this);
	this.chartHeight = 240;// 柱图的高度，即y轴高度
	this.chartWidth = 396;// 柱图的宽度度
	this.eleWidth=26;//每个矩形的宽度
	
	this.groupNames=new Array();//每个柱形的名称
	this.comboNames = new Array();//每个组的名称
	this.sumValues = new Array();
	this.values = new Array();
	this.desList=new Array();
	this.chartEleGroup=null;
	this.maxSize=0;
	this.angleFactor = Math.pow(2, 0.5);
	this.startList=new Array();
}
ComboBarChart.prototype=new BaseChart();

ComboBarChart.prototype.initSvg = function() {	
	this.coordType=3;
	this.showScrool=true;
	this.drawSvg();
	this.chartEleGroup = this.getDoc().getElementById("parentChart");
}

ComboBarChart.prototype.drawSvg=function(){
	//在basechart.js基础上绘制各自图形的元素  start
	//3.1、分组柱状图的组，隶属于chart
	var comboBarChart = document.createElementNS("http://www.w3.org/2000/svg", "g");
	chart.appendChild(comboBarChart);
	comboBarChart.setAttribute("id", "comboBarChart");

	//3.1.1、柱形的组，隶属于chart
	var parentChart = document.createElementNS("http://www.w3.org/2000/svg", "g");
	comboBarChart.appendChild(parentChart);
	parentChart.setAttribute("id", "parentChart");
	//3.1.1.1、x轴显示的名称
	var labels = document.createElementNS("http://www.w3.org/2000/svg", "g");
	parentChart.appendChild(labels);
	labels.setAttribute("id", "labels");
	labels.setAttribute("transform", "translate(6, 12)");

	//3.1.1.2、每个柱形的形状,每个柱形由多个矩形组成
	var stacks = document.createElementNS("http://www.w3.org/2000/svg", "g");
	parentChart.appendChild(stacks);
	stacks.setAttribute("id", "stacks");
	var stacksValue = document.createElementNS("http://www.w3.org/2000/svg", "g");
	parentChart.appendChild(stacksValue);
	stacksValue.setAttribute("id", "stacksValue");
}

ComboBarChart.prototype.addChartItem = function(hasLegend,value, comboName,groupName, repress,count,index) {
	var eleName= this.getDoc().createElementNS('http://www.w3.org/2000/svg','text');
	eleName.setAttribute("y", "40");
	eleName.setAttribute("style","font-family:SimSun;text-anchor:start;font-size:14");
	eleName.appendChild(this.getDoc().createTextNode(comboName + ""));
	this.getDoc().getElementById("labels").appendChild(eleName);
	this.comboNames.push(eleName);
	
	

	for(var g=0;g<value.length;g++){
		var eleNameG= this.getDoc().createElementNS('http://www.w3.org/2000/svg','text');
		eleNameG.setAttribute("transform", "rotate(45)");
		eleNameG.setAttribute("style","font-family:SimSun;text-anchor:start;font-size:14");
		eleNameG.appendChild(this.getDoc().createTextNode(groupName[g] + ""));
		this.getDoc().getElementById("labels").appendChild(eleNameG);
		this.groupNames.push(eleNameG);
		
		var groupValue=value[g];
		var sumValue=0;
		for(var i=0;i<groupValue.length;i++){
			sumValue+=groupValue[i];
		}
		this.sumValues.push(sumValue);
		this.values.push(groupValue);
		if(sumValue>this.maxSize){
			this.maxSize=sumValue;
		}
		var eleCount=count*value.length;//count*value.length:图中出现的矩形总个数
		if (this.sumValues.length==eleCount){
			
			var barStart = 0;
			var totalGrad=this.getTotalGrad(this.maxSize);
			for ( var I = 0; I < this.sumValues.length; I++) {
				barStart = this.drawBarSegment(this.groupNames[I],this.values[I],this.sumValues[I],barStart, this.sumValues[I]/totalGrad, this.comboNames,I,value.length);			
				//this.startList存储每一组开始的x坐标
				if(I%value.length==0){
					this.startList.push(barStart-this.eleWidth-this.spaceWidth);
				}
			}
			//设置图例
			
			var desList=this.getStackDesList();
			for(var d=0;d<desList.length;d++){
				this.createDesList("deslist","destext", d, desList[d], this.getColor(value.length*this.values[0].length));
			}
			for(ii=0;ii<this.startList.length;ii++){
				this.comboNames[ii].setAttribute("x", this.startList[ii])
			}
		}		
	}	
}
ComboBarChart.prototype.drawBarSegment = function(groupName,value,sum,Start, Height,Labels,index,count) {
	
	if((index+1)%count==0){
		this.spaceWidth=30;		
	}else{
		this.spaceWidth=10;
	}
	var subHeightPer=0;//每个子矩形占整组矩形的高度百分比
	var y=0;
	var x=0;
	for(var i=0;i<value.length;i++){
		
		//为每个矩形准备线性渐变效果
		this.setLinearGrad(index+""+i,this.getColor(value.length*count));
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
		ele.setAttribute("style","stroke:none;fill:" + "url(#linearGrad"+index+""+i+")");
		this.getDoc().getElementById("stacks").appendChild(ele);
		//为 矩形设置鼠标事件
		var barValue=value[i];
		ele.setAttribute("onmouseover", "window["+this.id+"].displayValue(evt,'"+barValue+"')");
		ele.setAttribute("onmouseout", "window["+this.id+"].hiddenValue()");
	}	
	groupName.setAttribute("x", Start / this.angleFactor)
	groupName.setAttribute("y", Start * -1 / this.angleFactor)
	
	return Start+this.eleWidth+this.spaceWidth;	
}

ComboBarChart.prototype.displayValue= function(evt,value){
	var objet=evt.target;
	var x=Number(objet.getAttribute("x"));
	var y=Number(objet.getAttribute("y"));
	
	var eleValue=this.getDoc().createElementNS('http://www.w3.org/2000/svg','text');
	eleValue.setAttribute("style","text-anchor:start;font-weight:bold;text-anchor:middle;font-size:13;visibility:show");
	eleValue.appendChild(this.getDoc().createTextNode(value));
	eleValue.setAttribute("x", x+this.eleWidth/2);
	eleValue.setAttribute("y", y+12);
	this.getDoc().getElementById("stacksValue").appendChild(eleValue);
}
ComboBarChart.prototype.hiddenValue= function(){
	var svChildren=this.getDoc().getElementById("stacksValue").childNodes;
	for(var i=0;i<svChildren.length;i++){
		this.getDoc().getElementById("stacksValue").removeChild(svChildren.item(i));
	}
}

ComboBarChart.prototype.setStackDesList= function(desList){	
	this.desList=desList;
}
ComboBarChart.prototype.getStackDesList= function(){
	return this.desList;
}