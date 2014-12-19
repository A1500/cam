
function thisMovie(movieName) {
	if (navigator.appName.indexOf("Microsoft") != -1) {
		return window[movieName];
	} else {
		return document[movieName];
	}
}

//设置提示框的格式化字符串
	// 例如 传入的字符串为 "销量为#大箱"  提示框显示为  济南市: 销量为12万大箱
	//		# 会自动代替单值图数据中的value字段的值,格式字符串内只准出现一个'#' 	
	//		默认格式为 xx市 12
function setFormatString(swfId, formatString)
{
	thisMovie(swfId).send2SetFormatString(formatString);
}

//仅测试单值图
	//参数为: swfObject的id, 单值图的基本信息串(最小值,最大值,显示几种颜色), 单值图的数据, 颜色类型
function renderSingleValue(swfId, _svColor, _svData, _svType) {
	thisMovie(swfId).clearAll();
	if (_svType != "") {
		thisMovie(swfId).send2ColorValue(_svType);
	} else {
		thisMovie(swfId).send2ColorValue("0xD0F4F4|0x0600F7");
	}
	thisMovie(swfId).send2SingleValueColor(_svColor);
	thisMovie(swfId).send2SingleValueData(_svData);
}

//仅测试饼图
	//参数为	swfObject的id, 饼图的数据
function renderPieChart(swfId, _pieData) {
	thisMovie(swfId).clearAll();
	thisMovie(swfId).send2PieChartData(_pieData);
}

var _tId;
var _tData;
function tRenderPieChart() {
	try{
		thisMovie(_tId).clearAll();
		thisMovie(_tId).send2PieChartData(_tData);
	}catch(e) {
		setTimeout(tRenderPieChart, 1000);
	}
}

//测试饼图和单值图
	//参数为: swfObject的id, 单值图的基本信息串(最小值,最大值,显示几种颜色), 单值图的数据, 饼图的数据
function renderAll(swfId, _svColor, _svData, _pieData, _svType) {
	renderSingleValue(swfId, _svColor, _svData, _svType);
	thisMovie(swfId).send2PieChartData(_pieData);
}

//清除swf上的所有效果
	//参数为: swfObject的id
function clearAll(swfId) {
	thisMovie(swfId).clearAll();
}

//设置标题名称
	//参数为: swfObject的id, 标题名称
//function setTitle(swfId, value) {
//	thisMovie(swfId).send2PanelTitle(value);
//}

//设置地图是否显示城市名称
function setIsDisplayName(swfId, value) {
	thisMovie(swfId).send2IsDisplayName(value);
}

//设置地图是否显示单值图数值或饼图
function setIsDisplayNum(swfId, value) {
	thisMovie(swfId).send2IsDisplayNum(value);
}

//设置Legend的标题
function setLegendTitle(swfId, value) {
	thisMovie(swfId).send2LegendTitle(value);
}

//设置Legend是否显示
function setLegendVisible(swfId, value) {
	thisMovie(swfId).send2LegendVisible(value);
}









//当点击地图的任意一个县市时接收县市名称
	//自己用时把这个注释掉
//function send2JsMapFeature(value) {
//	document.getElementById('data').value = "接收: " + value;
//}

