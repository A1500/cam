var deptId = "";
function init() {
	var ds = L5.DatasetMgr.lookup("ds");
	
	// 根据登录人员获得婚姻登记处
	var infocommand = new L5.Command("com.inspur.cams.comm.informUtil.InformSessionCmd");
	infocommand.execute("getUserInfo");
	var userLoginName = "";
	var organCode = "";
	var organName = "";
	if (!infocommand.error) {
		var info = infocommand.getReturn("userInfo");
		userLoginName = info.userLoginName;// 通过登录账号查找对应的婚姻登记处。
		organCode = info.cantCode;// 通过登录账号查找对应的婚姻登记处。
		organName = info.userDepOrganName;
	}

	var ds = L5.DatasetMgr.lookup("ds");
	if (organType != 11) { // 非省级用户
		var mrmBasePersonCommand = new L5.Command("com.inspur.cams.marry.base.cmd.MrmBasePersonCommand");
		mrmBasePersonCommand.setParameter("loginId", userLoginName);
		mrmBasePersonCommand.execute("getDeptId");
		if (!mrmBasePersonCommand.error) {
			deptId = mrmBasePersonCommand.getReturn("deptId");
			deptName = mrmBasePersonCommand.getReturn("deptName");
		}

		if (deptId == "" || deptId == null) {
			alert("没有对应的婚姻登记处！");
			return false;
		}
		
		ds.setParameter("deptId", deptId);
	}
	ds.on("load", function onDsLoad() {
	//	if (ds.getTotalCount() == 0) {
			//L5.Msg.alert("提示", "无符合条件的结果！");
	//	}else {
			var qrToolbar = L5.getCmp("qrToolbar");
			qrToolbar.setText("合计(共" + ds.getTotalCount() + "人)");
	//	}
	});
	ds.load();
	L5.QuickTips.init();
}

function reset() {
	window.history.go(-1);
}

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){
	ds.setParameter("name",getParam("name"));
	ds.setParameter("startYear",getParam("startYear"));
	ds.setParameter("technical",getParam("technical"));	
	
	var paraDeptId = getParam("deptId");
	if(paraDeptId != null && paraDeptId != "" ) {
		ds.setParameter("deptId",paraDeptId);
	} else {
		ds.setParameter("deptId",deptId);
	}
	
	ds.load();
}
//所属部门
function forHelp(){
	var dept = window.showModalDialog(L5.webPath+"/jsp/cams/marry/dept/mrmRadioTree.jsp","","dialogHeight:500px;dialogWidth:350px;resizable:no;scroll:yes;");
	if(dept == ''){
		document.getElementById("deptName").value = '';
		document.getElementById("deptId").value = '';
	}else if (dept != "" && dept != undefined) {
		var list = dept.split(";");
		document.getElementById("deptName").value = list[1];
		document.getElementById("deptId").value = list[2];
	}
}

//明细
function detailHref(value,cellmeta,record,rowindex,colindex,dataset){
	return 	'<a href="javascript:detail(\''+record.get("PERSON_ID")+'\')">'+value+'</a>';
}

function detail(personId){
/*	var data = new L5.Map();
	data.put("dataBean",personId);
	data.put("method","UPDATE");
	data.put("flag","2");
	var url='jsp/cams/marry/person/mrmbaseperson_detail.jsp';
	var text = '人员信息';
	L5.forward(url,text,data);*/
	var url="mrmbaseperson_detail.jsp?method=UPDATE&dataBean="+personId;
	var width = 1024;
	var height = 500;
    window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	
}

function forExcel() {
	var pageSize = ds.pageInfo.pageSize;
	var pageIndex = ds.pageInfo.pageIndex;
	var startCursor = ds.pageInfo.startCursor;
	var total = ds.getTotalCount();
	ds.baseParams["excelType"]="1";  //导出类型 0：导出当前页；1：导出符合查询条件所有记录
	ds.baseParams["startExcel"]=startCursor;  //总记录中当前页记录起始位置
	ds.baseParams["limitExcel"]=total;  //导出记录数，如导出类型为导出符合查询条件所有记录时，其值为ds.getTotalCount()
	L5.dataset2excel(ds, "/jsp/cams/marry/person/exportCertifier_query.jsp");
	ds.baseParams["excelType"]="reset"; //重置导出类型
}

//打印
function print(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	var personId = selected[0].get('PERSON_ID');
	document.getElementById("docpath").value = "jsp/cams/marry/person/print/mrmPersonBZY.doc";
	document.getElementById("personId").value = personId; 
	
	var url="../../comm/print/jspcommonprint.jsp";
	var width = 1024;
	var height = 768;
    window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
}