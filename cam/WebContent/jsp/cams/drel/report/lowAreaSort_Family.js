var ifQuery = false;

function init() {
    var ds = L5.DatasetMgr.lookup("ds");
    if(query_organCode.indexOf('000')!=-1){
    ds.setParameter("DOMICILE_CODE@like@String",query_organCode.substring(0,query_organCode.indexOf('000')));
    
    }else{
    	
  	  ds.setParameter("DOMICILE_CODE@like@String",query_organCode);
    }
    ds.setParameter("RELEASE_DATE@>=@String",startTime);
    ds.setParameter("RELEASE_DATE@<=@String",endTime);
    ds.setParameter("BELONGING",sortType);
    ds.load();
    L5.QuickTips.init();
};

function getParam(ElementId) {
    var value = document.getElementById(ElementId).value;
    if (value == "") value = undefined;
    return value;
} 
 /*
*从数据库dic_city中查询organName
*/
function queryOrganName() {
	if(!ifQuery) {
		if(organCode != null && organCode != "") {
			var command = new L5.Command("com.inspur.cams.comm.diccity.cmd.DicCityCommand");
			command.setParameter("ID",organCode);
			command.execute("findOrganName");
			var fullName = command.getReturn("organName");
			if(fullName != null && fullName != "") {
				organName = fullName;
			}
			ifQuery = true;
		}
	}	
}
/**
 * 查询页面中选择行政区划查询
 */
function query_selectDomicile() {
	queryOrganName();
	var revalue = window.showModalDialog(L5.webPath
					+ "/jsp/cams/comm/diccity/dicCity.jsp?organCode="
					+ organCode + "&radioMaxlevel=0&organName="
					+ escape(encodeURIComponent(organName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("domicileName").value = list[4];
		document.getElementById("domicileCode").value = list[0];
	}
}
/*
 * 通用帮助
 */
function forHelp(){
	var revalue=window.showModalDialog("../../bsp/organization/getselect.jsp?rootId="+struId+"&showOrganType=0&organType=12,13,14,15&isExact=1&isCheckBox=1&isTree=1","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
		//list[0] == organId,list[1]==organName,list[2]==struId
//		var userDataset = L5.DatasetMgr.lookup("userDataset");
//		var userRecord = userDataset.getCurrent();
		document.getElementById("lrdwId").value = list[0];
		document.getElementById("lrdwmc").value = list[1];

	}
}
/**
 * 选择属地行政区划窗口
 */
function func_ForDomicileSelect() {
	var revalue = window.showModalDialog(
			L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=0&radioType=checkbox&organCode="
					+ organArea + "&organName="
					+ escape(encodeURIComponent(organName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("lrdwId").value = list[0];
		document.getElementById("lrdwmc").value = list[1];
	}
}
function goBack(){
	var pagePath = "/jsp/cams/drel/report/lowAreaSortQuery.jsp";
	var	url = pagePath+"?autoQuery=true&query_organCode="+ organCode + "&startTime=" + startTime + "&endTime=" + endTime+"&sortType="+sortType;
	var text="";
	L5.forward(url,text);
}
/**
 * 事件：点击查询按钮
 *     查询家庭信息
 */
function query(){
	var dataset = L5.DatasetMgr.lookup("ds");
 	var name=document.getElementById("name").value;//户主姓名
 	var idCard=document.getElementById("idCard").value;//户主身份证
 	 
	if(name=="") name=undefined;//姓名
	  dataset.setParameter("name",name);

	if(idCard=="") idCard=undefined;//户主身份证
	dataset.setParameter("id_Card", idCard);
    if(query_organCode.indexOf('000')!=-1){
      ds.setParameter("DOMICILE_CODE@like@String",query_organCode.substring(0,query_organCode.indexOf('000')));
    }else{
    	
  	  ds.setParameter("DOMICILE_CODE@like@String",query_organCode);
    }
    dataset.setParameter("BELONGING", sortType);//属别
    ds.setParameter("RELEASE_DATE@>=@String",startTime);//查询起始时间
    ds.setParameter("RELEASE_DATE@<=@String",endTime);//查询截至时间
	dataset.load();
 
}

/**
 *  事件处理：点击重置按钮
 *  困难家庭登记列表
 *  licb
 */
function reset(){
	var form=L5.getDom("queryForm");
	form.reset();
}
