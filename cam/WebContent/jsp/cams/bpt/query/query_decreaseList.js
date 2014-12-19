var ifQuery= false;
function init() {
	L5.getCmp("baseGridPanel").show();
	sipTime('');
	sipQuery(query_type);
	ifquery();
	L5.QuickTips.init();

};

/**
 * 页面初始化，赋值查询条件
 * @param {} type
 */
function sipQuery(type) {
	if(type.indexOf("=") != -1) {
		if(type.indexOf(",") != -1) {
			var types = type.split(",");
			for(var i=0;i<types.length;i++) {
				sipElement(types[i]); 
			}
		} else {
			sipElement(type);
		}
	}
 }
 
 /**
  * 为页面中元素赋值
  * @param {} keyValue
  */
function sipElement(keyValue) {
	var keyValues = keyValue.split("=");
	var obj = document.getElementById(keyValues[0]);
	if(obj != null && obj != "") {
		var type = obj.nodeName.toLowerCase();
		if(type == "input") {
			obj.value = keyValues[1];
		} else if(type == "select") {
			var options = obj.options;
			for(var i=0;i<options.length;i++) {
				if(options[i].value == keyValues[1]) {
					options[i].selected = true;
					break;
				}
			}
		}
	}
}

/**
 * 时间查询条件赋值以及初始化
 * @param {} id
 */
function sipTime(id) {
	var selects = document.getElementById(id+"timeType");
	for(var i=0;i<selects.length;i++) {
		if(selects[i].value == query_timeType) {
			selects[i].selected = true;
			break;
		}
	}
	document.getElementById(id+"cxsj_qs").value=query_startTime;
	document.getElementById(id+"cxsj_zs").value=query_endTime;
	document.getElementById(id+"cxsj_z").value=query_endTime;
	
	showTime(id);
}

/**
 * 
 * @param {} ds
 */
function sipQueryTime(ds,id) {
	var type = document.getElementById(id+"timeType").value;
	var cxsj_q;
	var cxsj_z;
	if(type=='1'){
		cxsj_q = document.getElementById(id+"cxsj_qs").value;
		cxsj_z = document.getElementById(id+"cxsj_zs").value;
		if (cxsj_q == '') {
			L5.Msg.alert('提示', '查询起始时间不能为空！');
			return false;
		}
		if(cxsj_q!=''&&!validateDateFormat(cxsj_q)){
			L5.Msg.alert("提示","查询起始时间格式不正确！");
			return false;
		}
		if (cxsj_z == '') {
			L5.Msg.alert('提示', '查询结束时间不能为空！');
			return false;
		}
		if(cxsj_z!=''&&!validateDateFormat(cxsj_z)){
			L5.Msg.alert("提示","查询结束时间格式不正确！");
			return false;
		}
	}else if(type=='2'){
		cxsj_q ="";
		cxsj_z = document.getElementById(id+"cxsj_z").value;
		if (cxsj_z == '') {
			L5.Msg.alert('提示', '审批截止时间不能为空！');
			return false;
		}
		if(cxsj_z!=''&&!validateDateFormat(cxsj_z)){
			L5.Msg.alert("提示","审批截止时间格式不正确！");
			return false;
		}
		
	}
	
	ds.setParameter("startTime", cxsj_q);
	ds.setParameter("endTime",cxsj_z);
	return ds;
}


/**
 * 是否自动查询
 */
function ifquery() {
	if (autoQuery != null && autoQuery == "true") {
		forHelpOT();
		document.getElementById("domicileCode").value = query_organCode;
		document.getElementById("domicileName").value = queryOrganName();
		
		var type = getParam("bptObjectType");// 获取节点ID
	    if (type == '6') {
			document.getElementById("testDomicileCode").value = query_organCode;
			document.getElementById("testDomicileName").value = queryOrganName();
			var selects = document.getElementById("testType");
			for(var i=0;i<selects.length;i++) {
				if(selects[i].value == query_type) {
					selects[i].selected = true;
					break;
				}
			}
			sipTime('test');
		} else if(type == 'B'){
			document.getElementById("offspringDomicileCode").value = query_organCode;
			document.getElementById("offspringDomicileName").value = queryOrganName();
			var selects = document.getElementById("offspringType");
			for(var i=0;i<selects.length;i++) {
				if(selects[i].value == query_type) {
					selects[i].selected = true;
					break;
				}
			}
		} else {
			document.getElementById("domicileCode").value = query_organCode;
			document.getElementById("domicileName").value = queryOrganName();
			sipTime('');
		}
		query();
	}
}

/**
 * 查询organName
 */
function queryOrganName() {
	if (query_organCode != null && query_organCode != "") {
		var command = new L5.Command("com.inspur.cams.comm.diccity.cmd.DicCityCommand");
		command.setParameter("ID", query_organCode);
		command.execute("findOrganName");
		var fullName = command.getReturn("organName");
		if (fullName != null && fullName != "") {
			return fullName;
		}
	}
}

function getParam(ElementId) {
	var obj = document.getElementById(ElementId);
	if(obj != null && obj != "") {
		return obj.value;
	} else {
		return "";
	}
}

function query() {
	var objectType = getParam("bptObjectType");// 获取节点ID

	if (objectType == '6') {// 参试
		if(getParam("testDomicileCode") == "" || getParam("testDomicileCode") == null) {
			dsBptObject
				.setParameter("organCode",organCode);
		} else {
			dsBptObject
				.setParameter("organCode",getParam("testDomicileCode"));
		}
		
		var testType = getParam("testType");
		if(testType != null && testType != "") {
			dsBptObject.setParameter("objectType", "6"+getParam("testType"));
		} else {
			dsBptObject.setParameter("serviceType", "61");
		}
		
		var returnValue = sipQueryTime(dsBptObject,'test');
		if(returnValue) {
			dsBptObject = returnValue;
			dsBptObject.load();
		}
		
	} else if(objectType == 'B'){
		if(getParam("offspringDomicileCode") == "" || getParam("offspringDomicileCode") == null) {
			dsBptObject
				.setParameter("organCode",organCode);
		} else {
			dsBptObject
				.setParameter("organCode",getParam("offspringDomicileCode"));
		}
		
		var offspringType = getParam("offspringType");
		if(offspringType != null && offspringType != "") {
			dsBptObject.setParameter("objectType", "B"+getParam("offspringType"));
		} else {
			dsBptObject.setParameter("serviceType", "B1");
		}
		
		var returnValue = sipQueryTime(dsBptObject,'offspring');
		if(returnValue) {
			dsBptObject = returnValue;
			dsBptObject.load();
		}
	} else { // 全部显示
		var o_code = getParam("domicileCode");
		if(o_code == "" || o_code == null) {
			dsBptObject.setParameter("organCode", organCode);
		} else {
			dsBptObject.setParameter("organCode", o_code);
		}
		
		if(objectType != "") {
			if(objectType.indexOf(",") == -1) {
				if(objectType.length == 1) {
					dsBptObject.setParameter("objectType",objectType);
				} else {
					dsBptObject.setParameter("serviceType",objectType);
				}
			} else {
				var objects = objectType.split(",");
				var ifOne = true;
				for(var i=0;i<objects.length;i++) {
					if(objects[i].length != 1) {
						ifOne = false;
						break;
					}
				}
				if(ifOne) {
					dsBptObject.setParameter("objectType",objectType);
				} else {
					objectType = ","+objectType+",";
					objectType = objectType.replace(",1,",",11,12,13,14,15,");
					objectType = objectType.replace(",2,",",21,22,23,");
					objectType = objectType.replace(",5,",",51,");
					objectType = objectType.replace(",6,",",61,");
					objectType = objectType.replace(",8,",",81,");
					objectType = objectType.replace(",B,",",B1,");
					objectType = objectType.substring(1,objectType.length-1);
					dsBptObject.setParameter("serviceType",objectType);
				}
			}
		}
		
		
		var returnValue = sipQueryTime(dsBptObject,'');
		if(returnValue) {
			dsBptObject = returnValue;
			dsBptObject.load();
		}
	}
	// excelLoad();
}

function reset() {
	document.getElementById("domicileCode").value = "";
	document.getElementById("domicileName").value = "";
	document.getElementById("name").value = "";
	document.getElementById("idCard").value = "";
	document.getElementById("nation").value = "";
	document.getElementById("marriageCode").value = "";
	document.getElementById("careerCode").value = "";
	document.getElementById("politicalCode").value = "";
	document.getElementById("domicileType").value = "";
	document.getElementById("personalStatsTag").value = "";
	document.getElementById("bptNo").value = "";
}


function detail() {
	var basicInfoGrid;
	var objectType = '';
	basicInfoGrid = L5.getCmp('baseGridPanel');
	var selected = basicInfoGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录查看!");
		return false;
	}
	var type = selected[0].get("SERVICE_TYPE");
	var start = type.substring(0,1);
	if(start == "1") {
		objectType = "11";
	} else if(start == "2") {
		objectType = "21";
	} else {
		objectType = type;
	}
	
	
	var peopleId = selected[0].get('PEOPLE_ID');
	var familyId = selected[0].get('FAMILY_ID');
	var username = selected[0].get('NAME');
	var idCard = selected[0].get('ID_CARD');
	var objectState = selected[0].get('OBJECT_STATE');
	if (objectType == '') {
		objectType = selected[0].get('OBJECT_TYPE');
	}
	var url = '../basicInfoView/basicInfoDetail.jsp?peopleId=' + peopleId
			+ '&familyId=' + familyId + '&username=' + username + '&idCard='
			+ idCard + '&objectState=' + objectState + '&objectType='
			+ objectType;
	var width = screen.width - 60;
	var height = 580;
	var win = window.showModalDialog(url, window,
			"scroll:yes;status:no;dialogWidth:" + width + "px;dialogHeight:"
					+ height + "px;resizable:0");
	if (win == null) {
		return;
	}
}

function forHelp() {
	if(!ifQuery) {
		if (organCode != null && organCode != "") {
			var command = new L5.Command("com.inspur.cams.comm.diccity.cmd.DicCityCommand");
			command.setParameter("ID", organCode);
			command.execute("findOrganName");
			var fullName = command.getReturn("organName");
			if (fullName != null && fullName != "") {
				organName = fullName;
			}
			ifQuery = true;
		}
	}
	var revalue = window.showModalDialog(L5.webPath
					+ "/jsp/cams/comm/diccity/dicCity.jsp?organCode="
					+ organCode + "&radioMaxlevel=0&organName="
					+ escape(encodeURIComponent(organName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	// var
	// revalue=window.showModalDialog(L5.webPath+"/jsp/cams/bpt/comm/getselect_code.jsp?rootId="+struId+"&showOrganType=1&organType=1&isExact=0&isCheckBox=0&isTree=1","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");

		// 获取优抚对象类别的值，然后判断是哪个查询页面,写入所属机构的值
		var type = getParam("bptObjectType");
		if (type == '6') {
			document.getElementById("testDomicileCode").value = list[0];
			document.getElementById("testDomicileName").value = list[4];
		} else {
			document.getElementById("domicileCode").value = list[0];
			document.getElementById("domicileName").value = list[4];
		}

	}
}

function forHelpOT() {
	var revalue;
	if (autoQuery != null && autoQuery == "true") {
		revalue = query_objectType + ";" + query_objectName;
		autoQuery = "false";
	} else {
		revalue = window.showModalDialog("../dicobjecttype/dicobjecttype.jsp");
	}
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		var listTypeId = list[0];
		if(listTypeId == "6") {
				document.getElementById("testObjectTypeName").value = list[1];
				document.getElementById("testObjectType").value = list[0];
				L5.getCmp("form").hide();
				L5.getCmp("testform").show();
				L5.getCmp("offspringform").hide();
				sipTime('test');
		}else if(listTypeId == "B"){
				document.getElementById("offspringObjectTypeName").value = list[1];
				document.getElementById("offspringObjectType").value = list[0];
				L5.getCmp("form").hide();
				L5.getCmp("testform").hide();
				L5.getCmp("offspringform").show();
				sipTime('offspring');
		} else {
				document.getElementById("objectType").value = list[0];
				document.getElementById("objectTypeName").value = list[1];
				L5.getCmp("form").show();
				L5.getCmp("testform").hide();
				sipTime('');
		}
		document.getElementById("bptObjectType").value = list[0];
	}
}
 
 

function showTime(id) {
	var type = document.getElementById(id+"timeType").value;
	if (type == '1') {
		document.getElementById(id+"times").style.display = "";
		document.getElementById(id+"time").style.display = "none";
	} else {
		document.getElementById(id+"times").style.display = "none";
		document.getElementById(id+"time").style.display = "";
	}
}


/**
 * 导出excel
 */
function excel_export() {
	var dsBptObject = L5.DatasetMgr.lookup("dsBptObject");
	if(dsBptObject.getCount() == 0 ){
		L5.Msg.alert("提示","没有导出的数据");
		return false;
	}
	L5.dataset2excel(dsBptObject,"/jsp/cams/bpt/query/excel_export/increaseOrDecreaseExcel.jsp?type=decrease");
}