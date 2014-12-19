function init(){
	document.getElementById("queryDate").value=getCurDate().substring(0,7);
	document.getElementById("reDiv").style.display="none";

	
}
function query(){
document.getElementById("reDiv").style.display="block";
    var beginDate = document.getElementById("queryDate").value;//查询结束时间止
    var endDate = document.getElementById("queryDate").value;//行政区划
    
    if(beginDate=="") {
		L5.Msg.alert("提示","请填写统计起始日期！");
		return;
	}
	if(endDate=="") {
		L5.Msg.alert("提示","请填写统计截止日期！");
		return;
	}
	ds.setParameter("releaseDate", beginDate);
	ds.setParameter("releaseArea",organCode);
	ds.setParameter("assistanceType",assistanceType);
	ds.load();
	
}
/**
 *  8-事件处理：点击地区链接跳转下级明细数据
 *  最低生活保障家庭信息列表
 *  licb
 */
function queryNextLevel(obj){
	var organCode = obj.parentNode.parentNode.parentNode.cells[0].firstChild.innerHTML; // 行政区划
    var beginDate = document.getElementById("queryDate").value;//查询结束时间止
    var endDate = document.getElementById("queryDate").value;//行政区划
    if(beginDate=="") {
		L5.Msg.alert("提示","请填写统计起始日期！");
		return;
	}
	if(endDate=="") {
		L5.Msg.alert("提示","请填写统计截止日期！");
		return;
	}
	if(organCode.indexOf('000')==-1){
		return;
	}
	ds.setParameter("beginDate", beginDate);
	ds.setParameter("endDate",endDate);
	ds.setParameter("releaseArea",organCode);
	ds.setParameter("isSpecial",isSpecial);
	ds.setParameter("assistanceType",assistanceType);
	ds.load();
}

function reset(){

	
}