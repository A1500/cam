function init() {
	document.getElementById("domicileName").value=organName;
	document.getElementById("domicileCode").value=organArea;
	document.getElementById("assistanceType").value=assistanceType;
	var releaseDetailListDS=L5.DatasetMgr.lookup("releaseDetailListDS");
	releaseDetailListDS.setParameter("SAM_RELEASE_DETAIL.RELEASE_ID@=",releaseId);	
	releaseDetailListDS.setParameter("dir", "ASC");
	releaseDetailListDS.setParameter("sort", "DOMICILE_CODE");	
	releaseDetailListDS.load();
	releaseSummaryDs.setParameter("SAM_RELEASE_SUMMARY.RELEASE_ID@=",releaseId);
	releaseSummaryDs.load();
}
function resetQ(){
	document.getElementById("queryForm").reset();
	document.getElementById("domicileName").value=organName;
	document.getElementById("domicileCode").value=organArea;
	document.getElementById("assistanceType").value=assistanceType;
}

function query(){
	var releaseDetailListDS = L5.DatasetMgr.lookup("releaseDetailListDS");
	releaseDetailListDS.setParameter("NAME", document.getElementById("familyName").value);
	releaseDetailListDS.setParameter("ID_CARD", document.getElementById("familyCardNo").value);
	releaseDetailListDS.setParameter("ASSISTANCE_TYPE", assistanceType);
	var domicileCode = document.getElementById("domicileCode").value;
	if (domicileCode) {
		if(domicileCode.indexOf('000')>-1){
			releaseDetailListDS.setParameter("DOMICILE_CODE@like",domicileCode.substring(0, domicileCode.indexOf('000')));
		}else{
			releaseDetailListDS.setParameter("DOMICILE_CODE",domicileCode);
		}
	}
	releaseDetailListDS.setParameter("RELEASE_ID",releaseId);
	releaseDetailListDS.setParameter("dir", "ASC");
	releaseDetailListDS.setParameter("sort", "DOMICILE_CODE");
	releaseDetailListDS.load();
}
function getParam(ElementId) {
	var value = document.getElementById(ElementId).value;
	if (value == "")
		value = undefined;
	return value;
}

function exportDetail(){
	var dataset = L5.DatasetMgr.lookup("releaseDetailListDS");
	if(dataset.getCount()<1){
		L5.Msg.alert("提示","没有要导出的信息！");
		return;
	}
	if("01"==assistanceType){
		assitanceTypeText="城市低保";
	}else if("02"==assistanceType){
		assitanceTypeText="农村低保";	
	}else if("03"==assistanceType){
		assitanceTypeText="五保";	
	}else{
		assitanceTypeText="";	
	}
	var filename=releaseDate+assitanceTypeText+"专项补贴明细";
	var class_path = "com.inspur.cams.drel.funds.release.cmd.SamReleaseCSVCommand";
	var gridObj = L5.getCmp("editGridPanel");
	L5.grid2excel(dataset, gridObj, filename, class_path);
}
function insert() {
	var width = screen.width - 200;
	var height = 448;
	var url = "samFamilySpecialAss.jsp?assistanceType=" + assistanceType
			+ "&releaseDate=" + releaseDate + "&releaseId=" + releaseId;
	var win = window.showModalDialog(url, window,
			"scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:"
					+ height + "px;resizable:1");
	releaseDetailListDS.reload();
}

function update() {
	var editGrid = L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录修改!");
		return false;
	}
	var data = new L5.Map();
	data.put("method", "UPDATE");
	data.put("dataBean", selected[0].get('detailId'));
	var url = 'jsp/release/samreleasedetail_edit.jsp';
	var text = '修改SAM_RELEASE_DETAIL';
	L5.forward(url, text, data);
}

function del() {
	var editGrid = L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length < 1) {
		L5.Msg.alert('提示', "请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?', function(state) {
		if (state == "yes") {
			var delIds = [];
			for (var i = 0; i < selected.length; i++) {
				delIds[i] = selected[i].get("detailId");
			}
			var command=new L5.Command("com.inspur.cams.drel.funds.release.cmd.SamReleaseSummaryCmd");
			command.setParameter("delIds", delIds);
			command.setParameter("releaseId", releaseId);
			command.execute("delDetail");
			if (!command.error) {
				releaseDetailListDS.reload();
			} else {
				L5.Msg.alert('提示', "保存时出现错误！" + command.error);
			}
		} else {
			return false;
		}
	});
}
function colseWin() {
	var parent = window.dialogArguments;
	parent.releaseSummaryListDs.reload();
	window.close();
}

function editDetail() {
	releaseDetailDs.removeAll();
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录修改!");
		return false;
	}
	releaseDetailDs.add(selected[0]);
	L5.getCmp("releaseDetailWin").show();
}
function saveReleaseDetail() {
	var releaseMonSum=document.getElementById("releaseMonSum").value;
	if(releaseMonSum==""){
		L5.Msg.alert('提示',"请输入救助金!");
		return;
	}
	if(releaseMonSum.match(/(^[0-9]{1,14}(\.[0-9]{1,2}){0,1}$)/)==null){
		L5.Msg.alert('提示',"救助金格式不正确!");
		return;
	}
	var command=new L5.Command("com.inspur.cams.drel.application.special.cmd.SamSpecialAssPlanCmd");
	command.setParameter("releaseDetailRecord", releaseDetailDs.getCurrent());
	command.execute("updateReleaseDetail");
	if (!command.error) {
		releaseDetailListDS.reload();
	} else {
		L5.Msg.alert('提示', "保存时出现错误！" + command.error);
	}
	L5.getCmp("releaseDetailWin").hide();
}
function closeReleaseDetailWin() {
	L5.getCmp("releaseDetailWin").hide();

}
// 弹出本地的行政区划
function func_ForDomicileSelect() {
	var revalue = window
			.showModalDialog(
					L5.webPath
							+ "/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=0&organCode="
							+ organArea + "&organName="
							+ escape(encodeURIComponent(organName)), "",
					"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("domicileCode").value = list[0];
		document.getElementById("domicileName").value = list[1];
	}
}