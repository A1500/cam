
function query(){
	var fisOrganReportDs = L5.DatasetMgr.lookup("fisOrganReportDs");
	var qParentOrganCode = document.getElementById("qParentOrganCode").value;
	var queryUnitId = document.getElementById("queryUnitId").value;
	var qIsFile = document.getElementById("qIsFile").value;
	var qUploadTime = document.getElementById("qUploadTime").value;
	var qUploadETime = document.getElementById("qUploadETime").value;
	var qStartTime = document.getElementById("qStartTime").value;
	var qStartETime = document.getElementById("qStartETime").value;
	var qEndTime = document.getElementById("qEndTime").value;
	var qEndETime = document.getElementById("qEndETime").value;
	if(qParentOrganCode!=""&&qParentOrganCode!="370000000000"){
		fisOrganReportDs.setParameter("organCode",qParentOrganCode);
	}
	if(queryUnitId!=""){
		fisOrganReportDs.setParameter("fId",queryUnitId);
	}
	if(qIsFile!=""){
		fisOrganReportDs.setParameter("qIsFile",qIsFile);
	}
	if(qUploadTime!=""){
		fisOrganReportDs.setParameter("qUploadTime",qUploadTime);
	}
	if(qUploadETime!=""){
		fisOrganReportDs.setParameter("qUploadETime",qUploadETime);
	}
	if(qStartTime!=""){
		fisOrganReportDs.setParameter("qStartTime",qStartTime);
	}
	if(qStartETime!=""){
		fisOrganReportDs.setParameter("qStartETime",qStartETime);
	}
	if(qEndTime!=""){
		fisOrganReportDs.setParameter("qEndTime",qEndTime);
	}
	if(qEndETime!=""){
		fisOrganReportDs.setParameter("qEndETime",qEndETime);
	}
	fisOrganReportDs.load();
}
function resetQuery(){
	document.getElementById("qParentOrganCode").value = "";
	document.getElementById("qParentOrganName").value = "";
	document.getElementById("queryUnitName").value = "";
	document.getElementById("qIsFile").value = "";
	document.getElementById("qUploadTime").value = "";
	document.getElementById("qUploadETime").value = "";
	document.getElementById("qStartTime").value = "";
	document.getElementById("qStartETime").value = "";
	document.getElementById("qEndTime").value = "";
	document.getElementById("qEndETime").value = "";
}

function getTimes(item) {
	LoushangDate(item.previousSibling);
}

function downloadFile() {
	var editGridPanel = L5.getCmp("editGridPanel");
	var records=editGridPanel.getSelectionModel().getSelections();
	if(records.length!=1){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var record = records[0];
	if(record.get("IF_FILE")=="1"){
		L5.MessageBox.confirm('确定', '当前单位为离线提交，文件已加密，确认直接下载?',function(state){
			if(state=="yes"){
				var recordId = record.get("RECORD_ID");
				var url = L5.webPath
						+ "/download?table=FIS_IMPORT_DATA&column=UPLOAD_CONTENT&filename=UPLOAD_FILE&pk=RECORD_ID&RECORD_ID='"
						+ recordId + "'";
				window.open(url);
			}else{
				return;
			}
		});
	}else{
		var recordId = record.get("RECORD_ID");
		var url = L5.webPath
				+ "/download?table=FIS_IMPORT_DATA&column=UPLOAD_CONTENT&filename=UPLOAD_FILE&pk=RECORD_ID&RECORD_ID='"
				+ recordId + "'";
		window.open(url);
	}
}

function decryptDownload(){
    var editGridPanel = L5.getCmp("editGridPanel");
	var records=editGridPanel.getSelectionModel().getSelections();
	if(records.length!=1){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var record = records[0];
	if(record.get("IF_FILE")=="1"){
	    window.open("fisImportDownload.jsp?recordId="+record.get("RECORD_ID")+"&unitId="+record.get("UPLOAD_UNIT")+"&fileName="+record.get("UPLOAD_FILE"));
	}else{
	    window.open("fisImportDownload.jsp?recordId="+record.get("RECORD_ID")+"&unitId="+record.get("UPLOAD_UNIT")+"&fileName="+record.get("UPLOAD_FILE"));
	}
	
}
function exportExcel(){
	var dataset=L5.DatasetMgr.lookup("fisOrganReportDs");
	if(dataset.getCount()<=0){
		L5.Msg.alert('提示', "无查询结果，不能导出!");
		return false;
	}
	var queryCondition ="";
	var qParentOrganName = document.getElementById("qParentOrganName").value;
	if(qParentOrganName!=""){
		queryCondition=qParentOrganName.substring(0,qParentOrganName.length-3)
	}
	var pageSize = dataset.pageInfo.pageSize;
	var pageIndex = dataset.pageInfo.pageIndex;
	var startCursor = dataset.pageInfo.startCursor;
	dataset.baseParams["excelType"]="1";  //导出类型 0：导出当前页；1：导出符合查询条件所有记录
	dataset.baseParams["startExcel"]=startCursor;  //总记录中当前页记录起始位置
	dataset.baseParams["limitExcel"]=dataset.getTotalCount();  //导出记录数，如导出类型为导出符合查询条件所有记录时，其值为dataset.getTotalCount()
	L5.dataset2excel(dataset,"/jsp/cams/fis/base/fisOrganReportExcel.jsp?queryCondition="+queryCondition);
	dataset.baseParams["excelType"]="reset"; //重置导出类型s
}

//选择管辖单位-无Ds赋值
function selectOrganNoDs(flag) {
	var userInfo;
	var command = new L5.Command("com.inspur.cams.fis.util.InformSessionCmd");
	command.execute("getUserInfo");
	if (!command.error) {
		userInfo = command.getReturn("userInfo");
	} else {
		alert("用户没有登录！");
		return;
	}

	var cantCode = userInfo.cantCode;
	var cantName = userInfo.cantName;
	var cantType = userInfo.userDepOrganType;

	var url = L5.webPath + "/jsp/cams/fis/comm/approvalOrganTree.jsp?cantCode="
			+ cantCode + "&cantName=" + escape(encodeURIComponent(cantName))
			+ "&cantType=" + cantType;
	var win = showModalDialog(url, null,
			"scroll:no;status:no;dialogWidth:500px;dialogHeight:550px");
	if (win == null) {
		return;
	}
	var id = "";
	var name = "";
	var id_name = "";
	// 如果是点击的是【确定】
	if (win[0].length > 0) {
		// 第一个值前面没有逗号
		id = win[0][0];// id1,id2,id3......
		name = win[1][0];// name1,name2,name3......
		id_name = id + "[" + name + "]";// id1[name1],id2[name2],id3[name3].......
		// 其余值之间用逗号分隔
		if (win[0].length > 1) {
			for (var i = 1; i < win[0].length; i++) {
				id = id + "," + win[0][i];
				name = name + "," + win[1][i];
				id_name = id_name + "," + win[0][i] + "[" + win[1][i] + "]";
			}
		}
	}
	document.getElementById("qParentOrganName").value = name;
	document.getElementById("qParentOrganCode").value = id;
}

function getFuneralInfo(){
	var returnValue = window.showModalDialog("../fisorganconfig/fisFuneralInfo.jsp", "","dialogHeight:400px;dialogWidth:400px;resizable:yes;scroll:yes;status:no;");
	var list = returnValue.split(",");
	document.getElementById("queryUnitId").value=list[0];
	document.getElementById("queryUnitName").value=list[1];
}