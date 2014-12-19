function init() {
	if(sign=="1"){
		 var DmXzqhDataSetQu = L5.DatasetMgr.lookup("DmXzqhDataSetQu");
		DmXzqhDataSetQu.setParameter("filterSql"," leve='2' and substr(id,0,4)= '"+organArea1+"'");
	    L5.DatasetMgr.lookup("DmXzqhDataSetQu").load();
	}else{
		document.getElementById("quQuery").disabled="disabled";
	    var DmXzqhDataSetQu = L5.DatasetMgr.lookup("DmXzqhDataSetQu");
	    var DmXzqhDataSetStreet = L5.DatasetMgr.lookup("DmXzqhDataSetStreet");
	    
		DmXzqhDataSetStreet.setParameter("filterSql"," leve='3' and substr(id,1,6)= '"+organArea+"'");
	    DmXzqhDataSetStreet.load();
	    
	    DmXzqhDataSetQu.setParameter("filterSql"," leve='2' and  id= '"+organArea2+"'");
	    DmXzqhDataSetQu.on("load", function onDmXzqhDataSetQuLoad() {
	    	document.getElementById("quQuery").selectedIndex=1;
	    });
	    DmXzqhDataSetQu.load();
	    
    }
    L5.QuickTips.init();
    L5.getCmp("ygjzjtxxGrid").on("rowclick", forRowDetail);
	xzqhDs.on("load",showWin);
	singleDs.on("load",getXzqhDs);
	directOrder();
};
function getDzStreet(){
	var DmXzqhDataSetStreet = L5.DatasetMgr.lookup("DmXzqhDataSetStreet");
	var DzQuQuery=document.getElementById("quQuery").value;
	DmXzqhDataSetStreet.setParameter("filterSql"," leve='3' and substr(id,1,6)= '"+DzQuQuery.substr(0,6)+"'");
    L5.DatasetMgr.lookup("DmXzqhDataSetStreet").load();
}
function destroyWin() {
}
function getParam(ElementId) {
    var value = document.getElementById(ElementId).value;
    if (value == "") value = undefined;
    return value;
}
function query() {
    var hzxm = getParam("hzxmquery");
    var sfzh = getParam("sfzhquery");
    var dzZhen = getParam("dzZhenquery");
    var dzCun = getParam("dzCunquery");
    var shbz = getParam("shbzquery");
	var jzlx = getParam("jzlxquery");
	var quQuery = getParam("quQuery");
	var sm = getParam("smquery");
	var qm = getParam("queryMode");
	var direct = getParam("direct");
	var orderQ = getParam("orderQ");
	var orderZ = getParam("orderZ");
	if(direct!="desc"&&direct!="asc"){
		direct="desc";
	}
	if(qm!='mr'&&qm!='dz'){
		if(sm==undefined && orderQ==undefined && orderZ==undefined){
		L5.Msg.alert("提示","请输入查询条目数或排名起止!");
		return;
		}
	}
		
	if(sm!=undefined && !_isNum(sm) ){
		L5.Msg.alert("提示","校验未通过：查询条目数应为整数！");
		return;
	}
	if(orderQ!=undefined && !_isNum(orderQ) ){
		L5.Msg.alert("提示","校验未通过：排名起止应为整数！");
		return;
	}
	if(orderZ!=undefined && !_isNum(orderZ) ){
		L5.Msg.alert("提示","校验未通过：排名起止应为整数！");
		return;
	}
	if(orderQ>orderZ){
		L5.Msg.alert("提示","校验未通过：排名起止输入错误！");
		return;
	}	
	if(qm=='dz'){
		 ds.setParameter("jtdzquery", qm);
	}
    ds.setParameter("hzxmquery", hzxm);
    ds.setParameter("sfzhquery", sfzh);
    ds.setParameter("dzZhenquery", dzZhen);
    ds.setParameter("dzCunquery", dzCun);
    ds.setParameter("shbzquery", shbz);
    ds.setParameter("jzlxquery", jzlx);
    ds.setParameter("quQuery", quQuery);
    ds.setParameter("smquery", sm);
	ds.setParameter("direct", direct);
	ds.setParameter("orderQ", orderQ);
	ds.setParameter("orderZ", orderZ);    
    
    zhcxJtxxNumDs.setParameter("hzxmquery", hzxm);
    zhcxJtxxNumDs.setParameter("sfzhquery", sfzh);
    zhcxJtxxNumDs.setParameter("dzZhenquery", dzZhen);
    zhcxJtxxNumDs.setParameter("dzCunquery", dzCun);
    zhcxJtxxNumDs.setParameter("shbzquery", shbz);
    zhcxJtxxNumDs.setParameter("jzlxquery", jzlx);
    zhcxJtxxNumDs.setParameter("quQuery", quQuery);
    zhcxJtxxNumDs.setParameter("smquery", sm);
	zhcxJtxxNumDs.setParameter("direct", direct);
	zhcxJtxxNumDs.setParameter("orderQ", orderQ);
	zhcxJtxxNumDs.setParameter("orderZ", orderZ);    
    ds.load();
    zhcxJtxxNumDs.load();
}
function forExcel() {
	var pageSize = ds.pageInfo.pageSize;
	var pageIndex = ds.pageInfo.pageIndex;
	var startCursor = ds.pageInfo.startCursor;
	var total = ds.getTotalCount();
	ds.baseParams["excelType"]="1";  //导出类型 0：导出当前页；1：导出符合查询条件所有记录
	ds.baseParams["startExcel"]=startCursor;  //总记录中当前页记录起始位置
	ds.baseParams["limitExcel"]=total;  //导出记录数，如导出类型为导出符合查询条件所有记录时，其值为ds.getTotalCount()
	L5.dataset2excel(ds, "/jsp/sdmz/comm/query/qnhQuery/forExcel.jsp");
	ds.baseParams["excelType"]="reset"; //重置导出类型
}
function getDzCun() {
	var DmXzqhDataSetVillage = L5.DatasetMgr.lookup("DmXzqhDataSetVillage");
	var dzZhenquery = document.getElementById("dzZhenquery").value;
	DmXzqhDataSetVillage.setParameter("filterSql"," leve='4' and substr(id,1,9)= '"+dzZhenquery.substr(0,9)+"'");
    L5.DatasetMgr.lookup("DmXzqhDataSetVillage").load();
}
function forRowDetail(grid, rowIndex ,e) {
	var jtid = grid.getDataset().getAt(rowIndex).get("JTID");
    singleDs.setParameter("BASEINFO_FAMILY.FAMILY_ID@=", jtid);
    singleDs.load();
    var sfzh = grid.getDataset().getAt(rowIndex).get("SFZH");
    jzlsDs.setParameter("SAM_PLAN_DETAIL.ID_CARD@=",sfzh);
    jzlsDs.load();
}
function showWin() {
	var win = L5.getCmp("knjt_detail");
	win.show(this);
	L5.getCmp("tab").setActiveTab("0");
}
function closeWin(){
	var win = L5.getCmp("knjt_detail");
	win.setVisible(false);
}
function getXzqhDs() {
	if(singleDs.getAllRecords().length<1) return;
	//alert('village='+singleDs.getAllRecords()[0].get("village"));
	xzqhDs.setParameter("filterSql"," id in('"+singleDs.getAllRecords()[0].get("province").trim()+"','"+singleDs.getAllRecords()[0].get("city").trim()+"','"+singleDs.getAllRecords()[0].get("county").trim()+"','"+singleDs.getAllRecords()[0].get("town").trim()+"','"+singleDs.getAllRecords()[0].get("village").trim()+"')");
	xzqhDs.load();
}
/**
 * value:是当前单元格的值
 * cellmeta里保存的是cellId单元格id，id不知道是干啥的，似乎是列号，css是这个单元格的css样式。
 * record是这行的所有数据，你想要什么，record.data["id"]这样就获得了。
 * rowIndex是行号，不是从头往下数的意思，而是计算了分页以后的结果。
 * columnIndex列号太简单了。
 * store 这个是你构造表格时候传递的ds，也就是说表格里所有的数据，你都可以随便调用
*/
function shbzRenderer(value, cellmeta, record, rowIndex, columnIndex, store) {
	var re = "";
	if(value=="0") {
		re = "<span style='color:green;'>转更正</span>";
	} else if (value=="1") {
		re = "<span style='color:black;'>未审核</span>";
	} else if (value=="2") {
		re = "<span style='color:red;'>审核不同意</span>";
	}else if (value=="3") {
		re = "<span style='color:red;'>审核通过</span>";
	}
	return re;
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
function szdxlxdmRenderer(value) {
	if(value==undefined||value=="") {
		return "";
	} else if(value=="0") {
		return "个人";
	} else if(value=="1") {
		return "家庭";
	} else if(value=="2") {
		return "单位";
	} 
}
function beforeshow(code) {
	if(code==undefined||code==""){
		return;
	}
	var index = xzqhDs.find("value",code.trim(),0);
	if(index<0){
		return code;
	}
	var reValue = xzqhDs.getAt(index).get("text");
	if(reValue=="") {
		return code;
	}
	return reValue;
}

function test() {
	var url=L5.webPath+"/jsp/bsp/organization/getselect.jsp?returnValueType=array";
	var revalue=window.showModalDialog(url,window,"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
}
function directOrder(){
	if(getParam("queryMode") == "sm"){
		document.getElementById("directSpan").style.display = "block";
		document.getElementById("QZSpan").style.display = "none";
		document.getElementById("orderQ").value="";
		document.getElementById("orderZ").value="";
	}else if(getParam("queryMode") == "QZ"){
		document.getElementById("directSpan").style.display = "none";
		document.getElementById("QZSpan").style.display = "block";
		document.getElementById("smquery").value="";
	}else{
		document.getElementById("directSpan").style.display = "none";
		document.getElementById("QZSpan").style.display = "none";
		document.getElementById("smquery").value="";
	}
}
