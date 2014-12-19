function init() {

		year=(new Date).getYear();
		month=(new Date).getMonth()+1;
		if(month<10){
			month='0'+month;
		}
		day=(new Date).getDate();
		if(day<10){
			day='0'+day;
		}
		date=year+''+month+''+day;

	ds.setParameter("lrsjquery", date.toString()+" 00:00:00");
    L5.DatasetMgr.lookup("ds").load();
	DmXzqhDataSetStreet.setParameter("filterSql"," leve='3' and substr(id,1,6)= '"+organArea+"'");
    L5.DatasetMgr.lookup("DmXzqhDataSetStreet").load();
    L5.QuickTips.init();
};

function getParam(ElementId) {
    var value = document.getElementById(ElementId).value;
    if (value == "") value = undefined;
    return value;
}
function query() {
    var lrsj = document.getElementById("lrsjquery").value;
    var conDate;
	if(lrsj!=undefined&&lrsj!="") {
		year=(new Date).getYear();
		month=(new Date).getMonth()+1;
		if(month<10){
			month='0'+month;
		}
		day=(new Date).getDate();
		if(day<10){
			day='0'+day;
		}
		date=year+''+month+''+day;
		if(day<lrsj){
			conDate = date-lrsj-69;
		}else{
			conDate = date-lrsj;
		}
	}
    var dzZhen = document.getElementById("dzZhenquery").value;
    var dzCun = document.getElementById("dzCunquery").value;
    var shbz = getParam("shbzquery");
	var jzlx = getParam("jzlxquery");
	if(lrsj==1){
		ds.setParameter("lrsjquery", date.toString()+" 00:00:00");
	}else{
		ds.setParameter("lrsjquery", conDate.toString()+" 00:00:00");
	}
    ds.setParameter("dzZhenquery", dzZhen);
    ds.setParameter("dzCunquery", dzCun);
    ds.setParameter("shbzquery", shbz);
    ds.setParameter("jzlxquery", jzlx);
    ds.load();
}
function forExcel() {
	var pageSize = ds.pageInfo.pageSize;
	var pageIndex = ds.pageInfo.pageIndex;
	var startCursor = ds.pageInfo.startCursor;
	ds.baseParams["excelType"]="0";  //导出类型 0：导出当前页；1：导出符合查询条件所有记录
	ds.baseParams["startExcel"]=startCursor;  //总记录中当前页记录起始位置
	ds.baseParams["limitExcel"]=pageSize;  //导出记录数，如导出类型为导出符合查询条件所有记录时，其值为ds.getTotalCount()
	L5.dataset2excel(ds,"/jsp/sdmz/comm/query/recentQnhQuery/forExcel.jsp");
	ds.baseParams["excelType"]="reset"; //重置导出类型
}
function getDzCun() {
	var dzZhenquery = document.getElementById("dzZhenquery").value;
	DmXzqhDataSetVillage.setParameter("filterSql"," leve='4' and substr(id,1,9)= '"+dzZhenquery.substr(0,9)+"'");
    L5.DatasetMgr.lookup("DmXzqhDataSetVillage").load();
}
function jzlxRenderer(value) {
	if(value==undefined||value=="") return "";
	var jzlxArr = value.split(",");
	var reStr = "";
	for(var i=0;i<jzlxArr.length;i++) {
		var index = jzlxDs.find("value",jzlxArr[i],0);
		if(index>-1) {
			if(reStr=="") {
				reStr = jzlxDs.getAt(index).get("text");
			} else {
				reStr += ","+jzlxDs.getAt(index).get("text");
			}
		}
	}
	return reStr;
}