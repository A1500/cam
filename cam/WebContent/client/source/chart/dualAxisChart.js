//DualAxisChart继承自BaseChart，是双轴图形的基类
function DualAxisChart() {
	BaseChart.call(this);	
	this.rightYAxisTitle="";//纵轴右侧坐标名称
}
DualAxisChart.prototype=new BaseChart();

DualAxisChart.prototype.setRightYAxisTitle = function(rightYAxisTitle) {
	this.rightYAxisTitle=rightYAxisTitle;
}

//覆写BaseChart.prototype.drawAsixCoord方法，画双轴坐标轴
DualAxisChart.prototype.drawAsixCoord=function(){
	var dualAsixGroup = document.createElementNS("http://www.w3.org/2000/svg", "g");
	chart.appendChild(dualAsixGroup);
	dualAsixGroup.setAttribute("id", "asixGroup");
	var dualAxis=document.createElementNS("http://www.w3.org/2000/svg", "path");
	dualAsixGroup.appendChild(dualAxis);
	dualAxis.setAttribute("d", "M0,0V -250V 0H 396V-250");
	dualAxis.setAttribute("style", "fill:none;stroke:black");
	
	//3.1.4、坐标轴左侧纵轴刻度的组，隶属于dualAxisChart
	var gradLeft = document.createElementNS("http://www.w3.org/2000/svg", "g");
	dualAsixGroup.appendChild(gradLeft);
	gradLeft.setAttribute("id", "gradLeft");
	gradLeft.setAttribute("transform", "translate(-30, -236)");

	//3.1.5、坐标轴右侧纵轴刻度的组，隶属于dualAxisChart
	var gradRight = document.createElementNS("http://www.w3.org/2000/svg", "g");
	dualAsixGroup.appendChild(gradRight);
	gradRight.setAttribute("id", "gradRight");
	
	this.createGraduation();	
}

//覆写BaseChart.prototype.createGraduation方法，设置坐标轴刻度（按10个刻度间隔显示）
DualAxisChart.prototype.createGraduation = function(){
	var gradGroup=this.doc.getElementById("gradLeft");
	var gradUnit=this.chartHeight/10;
	for(var i=10;i>=0;i--){
		var gradValue=this.getDoc().createElementNS('http://www.w3.org/2000/svg','text');
		gradValue.appendChild(this.getDoc().createTextNode(this.getTotalGrad(this.maxSizeLeft)-this.getTotalGrad(this.maxSizeLeft)/10*i));
		gradValue.setAttribute("transform", "translate(0,"+ gradUnit*i + ")");
		gradGroup.appendChild(gradValue);
		
		var gradLeftLine=this.getDoc().createElementNS('http://www.w3.org/2000/svg','line');
		gradLeftLine.setAttribute("x1", "30");
		gradLeftLine.setAttribute("y1", -4+gradUnit*i);
		gradLeftLine.setAttribute("x2", "34");
		gradLeftLine.setAttribute("y2", -4+gradUnit*i);
		gradLeftLine.setAttribute("stroke", "black");
		gradGroup.appendChild(gradLeftLine);
		
		var gradValueRight=this.getDoc().createElementNS('http://www.w3.org/2000/svg','text');
		gradValueRight.appendChild(this.getDoc().createTextNode(this.getMaxGrad(this.maxSizeRight)-this.diffGrad*i+"%"));
		gradValueRight.setAttribute("transform", "translate(432,"+ gradUnit*i + ")");
		gradGroup.appendChild(gradValueRight);
		
		var gradRightLine=this.getDoc().createElementNS('http://www.w3.org/2000/svg','line');
		gradRightLine.setAttribute("x1", "422");
		gradRightLine.setAttribute("y1", -4+gradUnit*i);
		gradRightLine.setAttribute("x2", "426");
		gradRightLine.setAttribute("y2", -4+gradUnit*i);
		gradRightLine.setAttribute("stroke", "black");
		gradGroup.appendChild(gradRightLine);		
	}
	//设置坐标轴名称
	var gradXAsixName=this.getDoc().createElementNS('http://www.w3.org/2000/svg','text');
	gradXAsixName.appendChild(this.getDoc().createTextNode(this.xAxisTitle));
	gradXAsixName.setAttribute("style","text-anchor:middle;font-weight:normal;font-size:14");
	gradXAsixName.setAttribute("transform", "translate(10,270)");
	gradGroup.appendChild(gradXAsixName);
	var gradLeftName=this.getDoc().createElementNS('http://www.w3.org/2000/svg','text');
	gradLeftName.appendChild(this.getDoc().createTextNode(this.yAxisTitle));
	gradLeftName.setAttribute("style","text-anchor:middle;font-weight:normal;font-size:14");
	gradLeftName.setAttribute("transform", "translate(0,-20)");
	gradGroup.appendChild(gradLeftName);
	var gradRightName=this.getDoc().createElementNS('http://www.w3.org/2000/svg','text');
	gradRightName.appendChild(this.getDoc().createTextNode(this.rightYAxisTitle));
	gradRightName.setAttribute("style","text-anchor:middle;font-weight:normal;font-size:14");
	gradRightName.setAttribute("transform", "translate(456,-20)");
	gradGroup.appendChild(gradRightName);
}
DualAxisChart.prototype.getMaxGrad =function(maxValue){
	var b=maxValue%10;
	var maxGrad=0;
	if((b>0)&&(b<10)){
		maxGrad=maxValue+(10-maxValue%10);
	}else if(b==0){
		maxGrad=maxValue;
	}else if((b<0)&&(b>-10)){
		maxGrad=maxValue-(maxValue%10);		
	}
	return maxGrad;
}
DualAxisChart.prototype.getMinValue =function(minValue){
	var b=minValue%10;
	if((b>0)&&(b<10)){
		minValue=minValue-minValue%10;
	}else if(b==0){
		minValue=minValue;
	}else if((b<0)&&(b>-10)){
		minValue=minValue+(-10-minValue%10);		
	}
	return minValue;
}
DualAxisChart.prototype.getDiffGrad =function(maxTempGrad,minTempGrad){
	var diffGrad=(maxTempGrad-minTempGrad)/10;
	var b=diffGrad%5;
	if((b>0)&&(b<5)){
		diffGrad=diffGrad+(5-diffGrad%5);
	}else if(b==0){
		diffGrad=diffGrad;		
	}
	return diffGrad;
}
DualAxisChart.prototype.getMinGrad =function(maxGrad,diffGrad){			
	var totalGrad=diffGrad*10;
	var minGrad=maxGrad-diffGrad*10;
	return minGrad;
}

DualAxisChart.prototype.createDualAxisDes = function(){	
		//左侧数据图例
		var ele=this.getDoc().createElementNS('http://www.w3.org/2000/svg','rect');
		//ele.setAttribute("transform", "translate(80,70)");
		ele.setAttribute("width", "13");
		ele.setAttribute("height", "13");
		ele.setAttribute("style","stroke:white;fill:" + this.getColorLeft());
		this.getDoc().getElementById("deslist").appendChild(ele);
		var ele2=this.getDoc().createElementNS('http://www.w3.org/2000/svg','text');
		//ele2.setAttribute("transform", "translate(100,80)");
		ele2.appendChild(this.getDoc().createTextNode(this.yAxisTitle));	
		this.getDoc().getElementById("destext").appendChild(ele2);	
		//右侧数据图例
		var ele3=this.getDoc().createElementNS('http://www.w3.org/2000/svg','circle');	
		ele3.setAttribute("transform", "translate(5,50)");
		ele3.setAttribute("r", "5");
		ele3.setAttribute("style","stroke:white;fill:" + this.getColorRight());		
		this.getDoc().getElementById("deslist").appendChild(ele3);		
		var ele4=this.getDoc().createElementNS('http://www.w3.org/2000/svg','text');
		ele4.setAttribute("transform", "translate(0,45)");
		ele4.appendChild(this.getDoc().createTextNode(this.rightYAxisTitle));	
		this.getDoc().getElementById("destext").appendChild(ele4);	
}


//存取纵轴左边数据的显示颜色
DualAxisChart.prototype.getColorLeft = function() {
	var color = this.leftColors[this.leftCurrentColor];
	this.leftCurrentColor++;
	if (this.leftCurrentColor >= this.leftColors.length){
		this.leftCurrentColor = 0;
	}
	return color;
}
DualAxisChart.prototype.setColorsLeft = function(colors) {
	this.leftColors=colors;
}
//存取纵轴右边数据的显示颜色
DualAxisChart.prototype.getColorRight = function() {
	return this.rightColor;
}

DualAxisChart.prototype.setColorRight = function(color) {
	this.rightColor=color;
}
//统一设置左侧数据和右侧数据显示的图表元素的颜色，即左侧和右侧数据颜色相同。
DualAxisChart.prototype.setColors = function(colors) {
	this.rightColors=colors;
	this.leftColors=colors;
}

//addEvent：在原有事件的基础上增加新事件
DualAxisChart.prototype.addEvent = function(group,evtName,func) {
	var evtGroup="";
	if(group=="l"){
		evtGroup=this.leftGroup;
	}else if(group=="r"){
		evtGroup=this.rightGroup;
	}
	var EleList=evtGroup.childNodes;//取子节点ff不支持getChildNodes()方法	
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

//modifyEvent：将原有事件修改为新事件，group=l:表示左边数据，group=r:表示右边数据
DualAxisChart.prototype.modifyEvent = function(group,evtName,func) {
	var evtGroup="";
	if(group=="l"){
		evtGroup=this.leftGroup;
	}else if(group=="r"){
		evtGroup=this.rightGroup;
	}
	var EleList=evtGroup.childNodes;
	for(var i=0;i<EleList.length;i++){
		objet=EleList.item(i);
		objet.setAttribute(evtName,func);		
	}
}

