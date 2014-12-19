
function init() {
	var ds = L5.DatasetMgr.lookup("ds");
	resetSome();
	ds.setParameter("morgArea",organArea);
	ds.setParameter("status",'1');
	ds.load();
	L5.QuickTips.init();
};
function resetSome(){
	//document.getElementById("domicileCode").value=organArea;
	//document.getElementById("domicileName").value=organName;
	document.getElementById("statusQuery").value='1';
}

function resetAll() {
	document.getElementById("queryForm").reset();
	resetSome();
}


function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	//if(value=="") value=undefined;
	return value;
}
function query(){

	var ds = L5.DatasetMgr.lookup("ds");
	ds.setParameter("serialNum","%"+getParam("serialNumQuery")+"%");
	ds.setParameter("companyName","%"+getParam("companyNameQuery")+"%");
	ds.setParameter("economicNatureCode",getParam("economicNatureCodeQuery"));
	ds.setParameter("regFunds",getParam("regFunds"));
	ds.setParameter("regFunde",getParam("regFunde"));
	ds.setParameter("workerNums",getParam("workerNums"));
	ds.setParameter("workerNume",getParam("workerNume"));
	ds.setParameter("disNums",getParam("disNums"));
	ds.setParameter("disNume",getParam("disNume"));
	ds.setParameter("cognizanceDateQuerys",getParam("cognizanceDateQuerys"));
	ds.setParameter("cognizanceDateQuerye",getParam("cognizanceDateQuerye"));
	ds.setParameter("legalPeople","%"+getParam("legalPeopleQuery")+"%");
	ds.setParameter("status",document.getElementById("statusQuery").value);
/*	var domicileCode=document.getElementById("domicileCode").value;
	if(domicileCode){
		ds.setParameter("morgArea",domicileCode);
	}else{
		ds.setParameter("morgArea",organArea);
	}*/
	ds.load();
	
	
}
function detail() {
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	var data = new L5.Map();
	data.put("taskCode",selected[0].get("TASK_CODE"));
	data.put("fitId",selected[0].get('FIT_ID'));
	var url='jsp/cams/welfare/query/fit/fitInfoQueryDetail.jsp';
	var text = '假矫装配企业';
	L5.forward(url,text,data);
}
//导出基本信息查询列表
function exportExcel(){
	var dataset = L5.DatasetMgr.lookup("ds");
	if(dataset.getCount()<1){
		L5.Msg.alert("提示","没有要导出的信息！");
		return;
	}
	var startCursor = dataset.pageInfo.startCursor;
	dataset.baseParams["excelType"]="1";  //导出类型 0：导出当前页；1：导出符合查询条件所有记录
	dataset.baseParams["startExcel"]=startCursor;  //总记录中当前页记录起始位置
	dataset.baseParams["limitExcel"]=dataset.getTotalCount();  //导出记录数，如导出类型为导出符合查询条件所有记录时，其值为ds.getTotalCount()
	var filename="假矫基本信息查询列表";
	var class_path = "com.inspur.cams.welfare.comm.cmd.WealCSVCommand";
	var gridObj = L5.getCmp("editGridPanel");
	L5.grid2excel(dataset, gridObj, filename, class_path);
	dataset.baseParams["excelType"]="reset"; //重置导出类型
}
// 弹出本地的行政区划
function func_ForDomicileSelect() {
	var revalue = window.showModalDialog(
			L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=-2&organCode="
					+ organArea + "&organName="
					+ escape(encodeURIComponent(organName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("domicileCode").value = list[0];
		document.getElementById("domicileName").value = list[1];
	}
}