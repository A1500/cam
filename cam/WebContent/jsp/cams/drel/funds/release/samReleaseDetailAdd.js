function init() {
	var releaseSummaryDs = L5.DatasetMgr.lookup("releaseSummaryDs");
	releaseSummaryDs.setParameter("RELEASE_ID", releaseId);
	releaseSummaryDs.load(true);
	if (releaseSummaryDs.getCurrent()) {
		document.getElementById("domicileName").value = releaseSummaryDs.get("releaseAreaName");
		document.getElementById("domicileCode").value = releaseSummaryDs.get("releaseAreaCode");
		document.getElementById("assistanceBegin").value = releaseSummaryDs.get("releaseDate");
	} else {
		document.getElementById("assistanceBegin").value = getCurYM();
		document.getElementById("domicileName").value = organName;
		document.getElementById("assistanceType").value = assistanceType;
		document.getElementById("assistanceType").disabled = true;
		document.getElementById("domicileCode").value = organArea;
	}
}

function query() {
	var baseinfoFamilyDS = L5.DatasetMgr.lookup("baseinfoFamilyDS");
	baseinfoFamilyDS.setParameter("cardNo",document.getElementById("cardNo").value);
	baseinfoFamilyDS.setParameter("familyName", document.getElementById("familyName").value);
	baseinfoFamilyDS.setParameter("familyCardNo", document.getElementById("familyCardNo").value);
	baseinfoFamilyDS.setParameter("sAssitancePeopleNum", document.getElementById("sAssitancePeopleNum").value);
	baseinfoFamilyDS.setParameter("eAssitancePeopleNum", document.getElementById("eAssitancePeopleNum").value);
	baseinfoFamilyDS.setParameter("assistanceType", assistanceType);
	baseinfoFamilyDS.setParameter("assistanceBegin", document.getElementById("assistanceBegin").value);
	baseinfoFamilyDS.setParameter("queryDate", document.getElementById("assistanceBegin").value);
	if( assistanceType == '03'){
		baseinfoFamilyDS.setParameter("supportWay","04");//分散供养
	}
	
	var domicileCode = document.getElementById("domicileCode").value;
	if (domicileCode) {
		baseinfoFamilyDS.setParameter("domicileCode", domicileCode);
	} else {
		baseinfoFamilyDS.setParameter("domicileCode", organArea);
	}
		baseinfoFamilyDS.setParameter("releaseId", releaseId);
	baseinfoFamilyDS.load();
	baseinfoFamilyDS.on("load", function() {
				var qrToolbar = L5.getCmp("qrToolbar");
				if (baseinfoFamilyDS.getCount() > 0)
					qrToolbar.setText("低保家庭查询信息("
							+ baseinfoFamilyDS.getTotalCount() + "条)");
				else
					qrToolbar.setText("低保家庭查询信息");
			});
	noReclick(baseinfoFamilyDS,"queryBtn");
}
// 重置
function resetQuery() {
	document.getElementById("assistanceBegin").value = releaseDate;
	document.getElementById("domicileName").value = organName;
	document.getElementById("domicileCode").value = organArea;
	document.getElementById("cardNo").value = "";
	document.getElementById("familyName").value = "";
	document.getElementById("familyCardNo").value = "";
	document.getElementById("sAssitancePeopleNum").value = "";
	document.getElementById("eAssitancePeopleNum").value = "";
}

function add() {
	L5.Msg.wait("正在生成名册","正在生成名册，请等待...");
	setTimeout('',50);
	var editGrid = L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length < 1) {
		L5.Msg.alert('提示', "请选择记录!");
		return false;
	}
	var familyIds = "";
	for (i = 0; i < selected.length; i++) {
		familyIds = familyIds + "," + selected[i].get("FAMILY_ID")
	}
	// 将选择的人维护到明细表中
	var command = new L5.Command("com.inspur.cams.drel.funds.release.cmd.SamReleaseSummaryCmd");
	command.setParameter("familyIds", familyIds);
	command.setParameter("releaseId", releaseId);
	command.setParameter("assistanceType", assistanceType);
	command.setParameter("releaseDate", releaseDate);
	command.execute("insertReleaseDetail");
	if (!command.error) {
		closeWin();
	} else {
		L5.Msg.alert('提示', "保存时出现错误！" + command.error);
	}
}
// 获得当前日期 2011-05
function getCurYM() {
	var date = new Date();
	var year = "" + date.getFullYear();
	var month = date.getMonth() + 1;
	if (month < 10) {
		month = "0" + month;
	}
	return year + "-" + month;
}

function closeWin() {
	var parent = window.dialogArguments;
	var win = L5.getCmp("adjustWin");
	parent.releaseDetailListDs.reload();
	window.close();
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