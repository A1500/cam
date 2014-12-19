var  orgName ;
function init() {
	if (autoQuery == "true") {
		if (query_organCode != null && query_organCode != "") {
			var command = new L5.Command("com.inspur.cams.comm.diccity.cmd.DicCityCommand");
			command.setParameter("ID", query_organCode);
			command.execute("findOrganName");
			var fullName = command.getReturn("organName");
			if (fullName != null && fullName != "") {
				document.getElementById("domicileName").value = fullName;
			}
		}
		document.getElementById("domicileCode").value = query_organCode;
		document.getElementById("cxsj_q").value = startTime;
		document.getElementById("cxsj_z").value = endTime;
		var selects = document.getElementById("domicileType").options;
		for (var i = 0; i < selects.length; i++) {
			if (selects[i].value == domicileType) {
				selects[i].selected = true;
				break;
			}
		}
		if(query_organCode!=null&&query_organCode!=""){
			query();
		}

	} else {
	var time = new Date();
	var times = time.format("Y");
	var timeq = times+"-01-01";
	var timez = times+"-12-31";
	document.getElementById("cxsj_q").value=timeq;
	document.getElementById("cxsj_z").value=timez;
	var OrgNameDataset = L5.DatasetMgr.lookup("OrgNameDataset");
	OrgNameDataset.setParameter("filterSql","id='"+organCode+"'");
	
	OrgNameDataset.load();
	OrgNameDataset.on("load",function() {
		orgName = OrgNameDataset.get("text");
		document.getElementById("domicileName").value = orgName;
	});
	document.getElementById("domicileCode").value = organCode;
	
	L5.QuickTips.init();
	}
}
function set(){
	reset();
	//document.getElementById("domicileName").value = orgName;
	//document.getElementById("domicileCode").value = organCode;
	
}
function toExcel(){
	var ds = L5.DatasetMgr.lookup("BptPeopleDemobilizedDataSet");
	if(ds.getCount()<1){
		alert("没有数据导出");
		return ;
	}	
	L5.dataset2excel(ds,"/jsp/cams/bpt/query/excel_export/dependentQueryStatistics_excel.jsp");

}
function getParam(ElementId) {
	var value = document.getElementById(ElementId).value;
	return value;
}
function query() {

	var domicileCode =_$("domicileCode");
	if (domicileCode == '') {
		L5.Msg.alert('提示', '所属县区不能为空！');
		return false;
	}
	var cxsj_q = _$("cxsj_q");
	if (cxsj_q == '') {
		L5.Msg.alert('提示', '查询起始时间不能为空！');
		return false;
	}
	if(cxsj_q!=''&&!validateDateFormat(cxsj_q)){
		L5.Msg.alert("提示","查询起始时间格式不正确！");
		return false;
	}
	var cxsj_z = _$("cxsj_z");
	if (cxsj_z == '') {
		L5.Msg.alert('提示', '查询结束时间不能为空！');
		return false;
	}
	if(cxsj_z!=''&&!validateDateFormat(cxsj_z)){
		L5.Msg.alert("提示","查询结束时间格式不正确！");
		return false;
	}
	
	var ds = L5.DatasetMgr.lookup("BptPeopleDemobilizedDataSet");
	ds.setParameter("xzqu", getParam("domicileCode"));
	ds.setParameter("name", getParam("name"));
	//ds.setParameter("pinyin", getParam("pinyin"));
	ds.setParameter("idCard", getParam("idCard"));
	ds.setParameter("domicileType", getParam("domicileType"));
	ds.setParameter("demobilizedState",getParam("demobilizedState"));
	ds.setParameter("demobilizedno", getParam("demobilizedno"));
	ds.setParameter("cxsj_q", getParam("cxsj_q"));
	ds.setParameter("cxsj_z", getParam("cxsj_z"));
	ds.load();
	noReclick(ds,"queryButton");
}

function reset() {
	document.getElementById("domicileName").value = "";
	document.getElementById("domicileCode").value = "";
	document.getElementById("name").value = "";
	//document.getElementById("pinyin").value = "";
	document.getElementById("idCard").value = "";
	document.getElementById("domicileType").value = "";
	document.getElementById("demobilizedState").value = "";
	document.getElementById("demobilizedno").value = "";
	document.getElementById("cxsj_q").value = "";
	document.getElementById("cxsj_z").value = "";
}

function confirmValue() {
	var editGrid = L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录!");
		return false;
	}

	var idCard = selected[0].get('ID_CARD');

	window.returnValue = idCard;
	window.close();
}

function closew() {
	window.returnValue = "";
	window.close();
}

function clears() {
	window.returnValue = ";;;;;;;"
	window.close();
}

function func_xzqu() {
	var revalue = window
			.showModalDialog(
					L5.webPath
							+ "/jsp/cams/comm/diccity/dicCityCounty.jsp?organCode=370000000000&organName=山东省",
					"",
					"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("domicileName").value = list[1];
		document.getElementById("domicileCode").value = list[0];
	}
}