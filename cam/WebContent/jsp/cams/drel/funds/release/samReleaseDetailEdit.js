function init() {
	document.getElementById("domicileName").value=organName;
	document.getElementById("domicileCode").value=organArea;
	releaseDetailListDs.setParameter("SAM_RELEASE_DETAIL.RELEASE_ID@=",
			releaseId);
	releaseDetailListDs.setParameter("dir", "ASC");
	releaseDetailListDs.setParameter("sort", "DOMICILE_CODE");
	releaseDetailListDs.load();
};

function resetQ(){
	document.getElementById("queryForm").reset();
	document.getElementById("domicileName").value=organName;
	document.getElementById("domicileCode").value=organArea;
}
function query(){
	releaseDetailListDs.setParameter("NAME", document.getElementById("familyName").value);
	releaseDetailListDs.setParameter("ID_CARD", document.getElementById("familyCardNo").value);
	var domicileCode = document.getElementById("domicileCode").value;
	if (domicileCode) {
		domicileCode=organArea;
	}
	//不考虑省市
	if(domicileCode.indexOf('00000')>-1){
		releaseDetailListDs.setParameter("DOMICILE_CODE@like",domicileCode.substring(0, 6));
	} else if(domicileCode.indexOf('000')>-1){
		releaseDetailListDs.setParameter("DOMICILE_CODE@like",domicileCode.substring(0, 9));
	}else{
		releaseDetailListDs.setParameter("DOMICILE_CODE",domicileCode);
	}
	releaseDetailListDs.setParameter("RELEASE_ID",releaseId);
	releaseDetailListDs.setParameter("dir", "ASC");
	releaseDetailListDs.setParameter("sort", "DOMICILE_CODE");
	releaseDetailListDs.load();
	noReclick(releaseDetailListDs,"queryBtn");
}
function getParam(ElementId) {
	var value = document.getElementById(ElementId).value;
	if (value == "")
		value = undefined;
	return value;
}

function exportDetail() {
	var dataset = L5.DatasetMgr.lookup("releaseDetailListDs");
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
	var filename=releaseDate+assitanceTypeText+"发放明细";
	var class_path = "com.inspur.cams.drel.funds.release.cmd.SamReleaseCSVCommand";
	var gridObj = L5.getCmp("editGridPanel");
	L5.grid2excel(dataset, gridObj, filename, class_path);
}
function insert() {
	var width = screen.width - 200;
	var height = 400;
	var url = "samReleaseDetailAdd.jsp?assistanceType=" + assistanceType
			+ "&releaseId=" + releaseId 
			+ "&domicileCode=" + domicileCode
			+ "&releaseDate=" + releaseDate
			+ "&hrefFlg=" + (new Date()).getTime();
	var win = window.showModalDialog(url, window,
			"scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:"
					+ height + "px;resizable:1");

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
			var command = new L5.Command("com.inspur.cams.drel.funds.release.cmd.SamReleaseSummaryCmd");
			command.setParameter("delIds", delIds);
			command.setParameter("releaseId", releaseId);
			command.execute("delDetail");
			if (!command.error) {
				releaseDetailListDs.reload();
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
	var editGrid = L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录修改!");
		return false;
	}
	releaseDetailDs.add(selected[0]);
	L5.getCmp("releaseDetailWin").show();
}
function saveReleaseDetail() {
	var baseMon=document.getElementById("baseMon").value;
	if(baseMon==""){
		L5.Msg.alert('提示',"请输入保障金!");
		return;
	}
	if(baseMon.match(/(^[0-9]{1,14}(\.[0-9]{1,2}){0,1}$)/)==null){
		L5.Msg.alert('提示',"保障金格式不正确!");
		return;
	}
	var classMon=document.getElementById("classMon").value;
	if(classMon==""){
		L5.Msg.alert('提示',"请输入分类施保金!");
		return;
	}
	if(classMon.match(/(^[0-9]{1,14}(\.[0-9]{1,2}){0,1}$)/)==null){
		L5.Msg.alert('提示',"分类施保金格式不正确!");
		return;
	}
	var command = new L5.Command("com.inspur.cams.drel.application.special.cmd.SamSpecialAssPlanCmd");
	var record = releaseDetailDs.getCurrent();
	record.set("releaseMonSum",record.get("baseMon")*1+record.get("classMon"));
	command.setParameter("releaseDetailRecord", record);
	command.execute("updateReleaseDetail");
	if (!command.error) {
		releaseDetailListDs.reload();
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