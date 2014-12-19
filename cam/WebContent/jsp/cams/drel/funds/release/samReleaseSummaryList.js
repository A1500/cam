var organFlg = '02';
function init() {
	document.getElementById("releaseAreaName").value=organName;
	document.getElementById("releaseAreaCode").value=organArea;
	L5.QuickTips.init();
};

function getParam(ElementId) {
	var value = document.getElementById(ElementId).value;
	if (value == "")
		value = undefined;
	return value;
}
function query() {
	releaseSummaryListDs.setParameter("SAM_RELEASE_SUMMARY.ASSISTANCE_TYPE@=",
			assistanceType);
	releaseSummaryListDs.setParameter("SAM_RELEASE_SUMMARY.IS_SPECIAL@=", "0");
	releaseSummaryListDs.setParameter("SAM_RELEASE_SUMMARY.RELEASE_TYPE@=",
			"01");
	releaseSummaryListDs.setParameter("SAM_RELEASE_SUMMARY.RELEASE_WAY@=",
			getParam("releaseWay"));
	releaseSummaryListDs.setParameter(
			"SAM_RELEASE_SUMMARY.RELEASE_AREA_CODE@=",
			getParam("releaseAreaCode"));
	releaseSummaryListDs.setParameter("SAM_RELEASE_SUMMARY.RELEASE_DATE@=",
			getParam("releaseDate"));
	releaseSummaryListDs.setParameter("SAM_RELEASE_SUMMARY.REG_ID@=", organId);
	releaseSummaryListDs.setParameter("SAM_RELEASE_SUMMARY.REG_ID@=", organId);
	releaseSummaryListDs.setParameter("dir", "desc");
	releaseSummaryListDs.setParameter("sort", "release_Date");
	
	releaseSummaryListDs.load();
    noReclick(releaseSummaryListDs,"queryBtn");

}
function resetQ(){
	document.getElementById("queryForm").reset();
	document.getElementById("releaseAreaName").value=organName;
	document.getElementById("releaseAreaCode").value=organArea;
}
// 导出Excel
function exportSummaryRelease() {
	var dataset = L5.DatasetMgr.lookup("releaseSummaryExcelDs");
	if (releaseSummaryListDs.getCount() < 1) {
		L5.Msg.alert("提示", "没有要导出的信息！");
		return;
	}
	dataset.setParameter("SAM_RELEASE_SUMMARY.ASSISTANCE_TYPE@=",
			assistanceType);
	dataset.setParameter("SAM_RELEASE_SUMMARY.IS_SPECIAL@=", "0");
	dataset.setParameter("SAM_RELEASE_SUMMARY.RELEASE_WAY@=",
			getParam("releaseWay"));
	dataset.setParameter("SAM_RELEASE_SUMMARY.RELEASE_AREA_CODE@=",
			getParam("releaseAreaCode"));
	dataset.setParameter("SAM_RELEASE_SUMMARY.RELEASE_DATE@=",
			getParam("releaseDate"));
	dataset.setParameter("SAM_RELEASE_SUMMARY.REG_ID@=", organId);
	dataset.load();
	var pageSize = dataset.pageInfo.pageSize;
	var pageIndex = dataset.pageInfo.pageIndex;
	var startCursor = dataset.pageInfo.startCursor;
	L5.dataset2excel(dataset,
			"/jsp/cams/drel/funds/release/samReleaseSummaryExcel.jsp");
}
// 登记名册
function insert() {
	var releaseSummaryDs = L5.DatasetMgr.lookup("releaseSummaryDs");
	releaseSummaryDs.removeAll();
	releaseSummaryDs.newRecord({
				"releaseStatus" : "00",
				"regAreaCode" : organArea,
				"isSpecial" : "0",
				"releaseType" : "01",
				"releaseWay" : "01",
				"releaseAreaCode" : organArea,
				"releaseAreaName" : organName,
				"releaseDate":getCurDate().substring(0,7)
			});// 默认状态为名册生成中
	var win = L5.getCmp("releaseSummaryWin");
	win.show();
}
//等待显示
function waitMsg() {
	L5.Msg.wait("正在生成名册","正在生成名册，请等待...");
	setTimeout( save, 50);
}
// 保存名册
function save() {
	L5.Msg.wait("正在生成名册","正在生成名册，请等待...");
	setTimeout('',50);
	var valid = releaseSummaryDs.isValidate(true);
	if (valid != true) {
		L5.Msg.alert('提示', "校验未通过,不能保存!" + valid);
		return false;
	}
	releaseSummaryCheckDs.setParameter("RELEASE_DATE",releaseSummaryDs.get("releaseDate"));
	releaseSummaryCheckDs.setParameter("ASSISTANCE_TYPE",assistanceType);
	releaseSummaryCheckDs.setParameter("RELEASE_AREA_CODE",organArea);
	releaseSummaryCheckDs.setParameter("REG_AREA_CODE",organArea);
	releaseSummaryCheckDs.setParameter("IS_SPECIAL","0");
	releaseSummaryCheckDs.setParameter("RELEASE_TYPE","01");
	releaseSummaryCheckDs.load();
	releaseSummaryCheckDs.events['load']=true;
	releaseSummaryCheckDs.on('load',function(){
		if(releaseSummaryCheckDs.getCount()>0){
			L5.Msg.alert('提示', releaseSummaryDs.get("releaseDate")+"已登记，请勿重复登记!" );
			return false;
		}else{
			var releaseSummaryRecord = releaseSummaryDs.getCurrent();
			releaseSummaryRecord.set("assistanceType", assistanceType);
			var command = new L5.Command("com.inspur.cams.drel.funds.release.cmd.SamReleaseSummaryCmd");
			command.setParameter("SamReleaseSummaryRecord", releaseSummaryRecord);
			command.execute("save");
			if (!command.error) {
				L5.Msg.alert('提示', "名册已生成！");
				closeWin();
			} else {
				L5.Msg.alert('提示', "保存时出现错误！" + command.error);
			}
		
		}
		
	});
}
// 关闭增加窗口
function closeWin() {
	var win = L5.getCmp("releaseSummaryWin");
	win.setVisible(false);
	query();
}
// 查看明细
function detail(releaseId,releaseDate,assistanceType) {
	var width = screen.width - 200;
	var height = 492;
	var url = "samReleaseDetail.jsp?releaseId=" + releaseId+"&releaseDate="+releaseDate+"&assistanceType="+assistanceType;
	var win = window.showModalDialog(url, window,
			"scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:"
					+ height + "px;resizable:1");
}
// 维护名册
function editDetail() {
	var editGrid = L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录修改!");
		return false;
	}
	if ("02" == selected[0].get("releaseStatus")) {
		L5.Msg.alert('提示', "名册已确认，无法修改!");
		return false;
	}
	var width = screen.width - 200;
	var height = 492;
	var url = "samReleaseDetailEdit.jsp?releaseId="
			+ selected[0].get('releaseId') + "&domicileCode="
			+ selected[0].get('releaseAreaCode') + "&assistanceType="
			+ assistanceType + "&releaseDate=" + selected[0].get('releaseDate')
			+ "&hrefFlg=" + (new Date()).getTime();
	var win = window.showModalDialog(url, window,
			"scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:"
					+ height + "px;resizable:1");
}
// 驳回
function turnDown() {
	var editGrid = L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录修改!");
		return false;
	}
	if ('02' != selected[0].get("releaseStatus")) {
		L5.Msg.alert('提示', "请选择街道办事处确认的记录!");
		return false;
	}
	var command = new L5.Command("com.inspur.cams.drel.funds.release.cmd.SamReleaseSummaryCmd");
	command.setParameter("releaseId", selected[0].get("releaseId"));
	command.setParameter("releaseStatus", "04");
	command.execute("confirm");
	if (!command.error) {
		L5.Msg.alert('提示', "名册已驳回！");
		releaseSummaryListDs.reload();
	} else {
		L5.Msg.alert('提示', "确认时出现错误！" + command.error);
	}
}
// 确认
function confirm() {
	var editGrid = L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录!");
		return false;
	}
	if (organFlg == selected[0].get("releaseStatus")) {
		L5.Msg.alert('提示', "名册已确认，请不需要重复确认!");
		return false;
	}
	if (selected[0].get("releaseStatus") != "01") {
		L5.Msg.alert('提示', "请选择已生成名册的记录确认!");
		return false;
	}
	
	L5.MessageBox.confirm('确定', '名册确认后不能修改，确定要确认名册吗？', function(state) {
		if (state == "yes") {
			var command = new L5.Command("com.inspur.cams.drel.funds.release.cmd.SamReleaseSummaryCmd");
			command.setParameter("releaseId", selected[0].get("releaseId"));
			command.setParameter("releaseStatus", organFlg);
			command.execute("confirm");
			if (!command.error) {
				L5.Msg.alert('提示', "名册已确认！");
				releaseSummaryListDs.reload();
			} else {
				L5.Msg.alert('提示', "确认时出现错误！" + command.error);
			}
		} else {
			return false;
		}
	});
}
function detailRender(value, cellmeta, record, rowindex, colindex, dataset) {
	return '<a href="javascript:detail(\'' + record.get('releaseId')+'\',\''+ record.get('releaseDate')+'\',\''+ record.get('assistanceType') + '\')">'
			+ value + '</a>';
}
function del() {
	var editGrid = L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length < 1) {
		L5.Msg.alert('提示', "请选择要删除的记录!");
		return false;
	}
	
	for(var i =0 ;i< selected.length ; i++ ){
		if(organFlg == selected[i].get("releaseStatus") ) {
			L5.Msg.alert('提示', "第"+(i+1)+"个名册已确认，不能删除!");
			return false;
		}
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?', function(state) {
		if (state == "yes") {
			var delIds = [];
			for (var i = 0; i < selected.length; i++) {
				delIds[i] = selected[i].get("releaseId");
			}
			var command = new L5.Command("com.inspur.cams.drel.funds.release.cmd.SamReleaseSummaryCmd");
			command.setParameter("delIds", delIds);
			command.execute("delete");
			if (!command.error) {
				releaseSummaryListDs.reload();
			} else {
				L5.Msg.alert('提示', "删除时出现错误！" + command.error);
			}
		} else {
			return false;
		}
	});
}
function getReleaseTime(value, cellmeta, record, rowindex, colindex, dataset) {
	if (record.get('releaseEndDate') || record.get('releaseBeginDate')) {
		return record.get('releaseBeginDate') + '至'
				+ record.get('releaseEndDate');
	} else {
		return '';
	}
}
function areaSelect() {
	var revalue = window
			.showModalDialog(
					L5.webPath
							+ "/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=0&organCode="
							+ organArea + "&organName="
							+ escape(encodeURIComponent(organName)), "",
					"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("releaseAreaName").value = list[1];
		document.getElementById("releaseAreaCode").value = list[0];
	}
}
function releaseAreaSelect() {
	var revalue = window
			.showModalDialog(
					L5.webPath
							+ "/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=0&organCode="
							+ organArea + "&organName="
							+ escape(encodeURIComponent(organName)), "",
					"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		releaseSummaryDs.set("releaseAreaName", list[1]);
		releaseSummaryDs.set("releaseAreaCode", list[0]);
	}
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
		document.getElementById("releaseAreaCode").value = list[0];
		document.getElementById("releaseAreaName").value = list[1];
	}
}