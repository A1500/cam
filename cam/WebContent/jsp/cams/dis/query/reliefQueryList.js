function init() {
	
}
//查看救助明细
function cardInfo(){
	var gdGrid = L5.getCmp("dcGrid");
	var selected = gdGrid.getSelectionModel().getSelections();
	if(selected.length!=1) {
		L5.Msg.alert('提示',"请选中一行!");
		return false;
	}
	var reliefType = selected[0].get("reliefType");
	if(reliefType=="DC"){
		url = "../relief/dc/dcDetail.jsp?method=detail&batchId=" + selected[0].get("batchId")
		+ "&batchDetailId=" + selected[0].get("batchDetailId")
		+ "&infoId=" + selected[0].get("infoId")+"&reliefType="+reliefType;
	}else if(reliefType=="GD"){
		url = "../relief/gd/gdDetail.jsp?method=detail&batchId=" + selected[0].get("batchId")
		+ "&batchDetailId=" + selected[0].get("batchDetailId")
		+ "&infoId=" + selected[0].get("infoId")+"&reliefType="+reliefType;
	}else if(reliefType=="SW"){
		url = "../relief/sw/swDetail.jsp?method=detail&batchId=" + selected[0].get("batchId")
		+ "&batchDetailId=" + selected[0].get("batchDetailId")
		+ "&infoId=" + selected[0].get("infoId")+"&reliefType="+reliefType;
	}else if(reliefType=="CJ"){
		url = "../relief/cj/cjDetail.jsp?method=detail&batchId=" + selected[0].get("batchId")
		+ "&batchDetailId=" + selected[0].get("batchDetailId")
		+ "&infoId=" + selected[0].get("infoId")+"&reliefType="+reliefType;
	}else if(reliefType=="YJ"){
		url = "../relief/yj/yjDetail.jsp?method=detail&batchId=" + selected[0].get("batchId")
		+ "&batchDetailId=" + selected[0].get("batchDetailId")
		+ "&infoId=" + selected[0].get("infoId")+"&reliefType="+reliefType;
	}
	
	var width = 1024;
	var height = 768;
	var reValue = window.showModalDialog(url, window,
			"scroll:yes;status:no;dialogWidth:" + width + "px;dialogHeight:"
					+ height + "px;resizable:1");
}

window.onbeforeunload = function() {
	try{
		var parent = window.dialogArguments;
		var reliefDoleds = parent.reliefDoleds;
		reliefDoleds.reload();
	}catch(e){}
}
function query() {
	var reliefType = getParam("reliefType");
	if(reliefType==""||reliefType==undefined){
		L5.Msg.alert("提示","请至少选择灾害类型！");
		return;
	}
	infoDs.setParameter("NAME@rlike", getParam("qName"));
	infoDs.setParameter("ID_CARD@rlike", getParam("qIdCard"));
	infoDs.setParameter("FAMILY_REGISTER", getParam("qFamilyRegister"));
	infoDs.setParameter("FAMILY_TYPE", getParam("qFamilyType"));
	infoDs.setParameter("RELIEF_TYPE", reliefType);
	
	var qFamilyNumStart = getParam("qFamilyNumStart");
	var qFamilyNumEnd = getParam("qFamilyNumEnd");
	if (_isNum(qFamilyNumStart) && _isNum(qFamilyNumEnd)) {
		infoDs.setParameter("FAMILY_NUM@between", qFamilyNumStart + "~"
						+ qFamilyNumEnd);
	} else if (_isNum(qFamilyNumStart)) {
		infoDs.setParameter("FAMILY_NUM@between", qFamilyNumStart + "~9999");
	} else if (_isNum(qFamilyNumEnd)) {
		infoDs.setParameter("FAMILY_NUM@between", "0~" + qFamilyNumEnd);
	}

	var qApprovalTimesStart = getParam("qApprovalTimesStart");
	var qApprovalTimesEnd = getParam("qApprovalTimesEnd");
	if (_isNum(qApprovalTimesStart) && _isNum(qApprovalTimesEnd)) {
		infoDs.setParameter("APPROVAL_TIMES@between", qApprovalTimesStart + "~"
						+ qApprovalTimesEnd);
	} else if (_isNum(qApprovalTimesStart)) {
		infoDs.setParameter("APPROVAL_TIMES@between", qApprovalTimesStart
						+ "~9999");
	} else if (_isNum(qApprovalTimesEnd)) {
		infoDs.setParameter("APPROVAL_TIMES@between", "0~" + qApprovalTimesEnd);
	}
	var areaCode = getParam("qAcceptAreaCode");
	if(areaCode!=""&&areaCode!=undefined){
		if(areaCode == "000000000000"){
		}else if(areaCode.substring(2,12)=="0000000000"){	
			var organCode1=areaCode.substring(0,2);
			infoDs.setParameter("ACCEPT_AREA_CODE@rlike",organCode1);		
		}else if(areaCode.substring(4,12)=="00000000"){	
			 var organCode1=areaCode.substring(0,4);
			 infoDs.setParameter("ACCEPT_AREA_CODE@rlike",organCode1);
		}else if(areaCode.substring(6,12)=="000000"){
			var  organCode1=areaCode.substring(0,6);
			infoDs.setParameter("ACCEPT_AREA_CODE@rlike",organCode1);
		}else if(areaCode.substring(9,12)=="000"){
			var  organCode1=areaCode.substring(0,9);
			infoDs.setParameter("ACCEPT_AREA_CODE@rlike",organCode1);
		}
	}else{
		if(organCode == "000000000000"){
		}else if(organCode.substring(2,12)=="0000000000"){	
			var organCode1=organCode.substring(0,2);
			infoDs.setParameter("ACCEPT_AREA_CODE@rlike",organCode1);		
		}else if(organCode.substring(4,12)=="00000000"){	
			 var organCode1=organCode.substring(0,4);
			 infoDs.setParameter("ACCEPT_AREA_CODE@rlike",organCode1);
		}else if(organCode.substring(6,12)=="000000"){
			var  organCode1=organCode.substring(0,6);
			infoDs.setParameter("ACCEPT_AREA_CODE@rlike",organCode1);
		}else if(organCode.substring(9,12)=="000"){
			var  organCode1=organCode.substring(0,9);
			infoDs.setParameter("ACCEPT_AREA_CODE@rlike",organCode1);
		}
	}
	
	infoDs.load();
}
// 隐藏银行信息
function hideYh(at) {
	if (at == "0") {
		var gdGrid = L5.getCmp("dcGrid");
		gdGrid.getColumnModel().setHidden(4, true);
		gdGrid.getColumnModel().setHidden(5, true);
	}
}

// 选择住址行政区划窗口
function forOrganSelect() {
	var revalue = window.showModalDialog(L5.webPath
					+ "/jsp/cams/dis/comm/dicCity.jsp?organCode=" + organCode
					+ "&organName=" + escape(encodeURIComponent(organName))
					+ "&radioType=radiobox&level=4&radioMaxlevel=0", "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("qAcceptAreaCode").value = list[0];
		document.getElementById("qAcceptAreaName").value = list[4];
	}
}
function forExcel() {

}

function countNum1(value) {
	num1 = value;
	return value;
}
function countNum2(value) {
	num2 = value;
	return value;
}

// 渲染资金用途
function upAllocationPurposeRenderer(value, cellmeta, record, rowindex,
		colindex, dataset) {
	var str = " ";
	for (var i = 0; i < disAllocationPurposeDs.getCount(); i++) {
		if (value.indexOf(disAllocationPurposeDs.getAt(i).get("value")) != -1) {
			str += disAllocationPurposeDs.getAt(i).get("text") + ",";
		}
	}
	return str.substring(0, str.length - 1);
}
//渲染备注
function noteRenderer(value, cellmeta, record, rowindex, colindex,
		dataset) {
	if(record.get("ifCarry")=="1")
		return "【已结转】"+value;
	return value;
}