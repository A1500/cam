var ifQuery = false;
var deptCode = "";

/*
 * 从数据库dic_city中查询organName
 */
function queryOrganName() {
	if (!ifQuery) {
		if (organCode != null && organCode != "") {
			var command = new L5.Command("com.inspur.cams.comm.diccity.cmd.DicCityCommand");
			command.setParameter("ID", regionCode);
			command.execute("findOrganName");
			var fullName = command.getReturn("organName");
			if (fullName != null && fullName != "") {
				organName = fullName;
			}
			ifQuery = true;
		}
	}
}

/**
 * 根据deptCode是事务处还是登记处隐藏或者显示单元格
 * 
 * @param {}
 *            deptCode
 */
function showOrhide(deptCode) {
	if (deptCode.substring(4) == "0001") { // 省级事务处
		document.getElementById("showInfo").style.display = "none";
		document.getElementById("people_dhInfo").style.display = "";
	} else {
		document.getElementById("showInfo").style.display = "";
		document.getElementById("people_dhInfo").style.display = "none";
	}
}

function init() {

	//增加市本级校验 2012年3月7日 开始
	var infocommand = new L5.Command("com.inspur.cams.comm.informUtil.InformSessionCmd");
		infocommand.execute("getUserInfo");
		var userLoginName ="";
		var organCode ="";
		var organName ="";
		if (!infocommand.error) {
			var info = infocommand.getReturn("userInfo");
			  userLoginName =info.userLoginName;//通过登录账号查找对应的婚姻登记处。
			  organCode =info.cantCode;//通过登录账号查找对应的婚姻登记处。
			  organName =info.userDepOrganName;
			}
	var mrmBasePersonCommand = new L5.Command("com.inspur.cams.marry.base.cmd.MrmBasePersonCommand");
		mrmBasePersonCommand.setParameter("loginId",userLoginName);
		mrmBasePersonCommand.execute("getDeptId");
		if (!mrmBasePersonCommand.error) {
			 deptId = mrmBasePersonCommand.getReturn("deptId");
			 deptName= mrmBasePersonCommand.getReturn("deptName");
			}
		
	    if(organCode.substring(2,12) != "0000000000"){
				if(deptId=="" || deptId==null){
					//ds.newRecord();
					return false;
				}
			}
			
	if (method == null || method == "") {
		L5.Msg.alert('提示', "未知的页面命令!");
		back();
	} else if (method == "INSERT") {
		ds.newRecord({"foreign":"0"});
	} else if (method == "UPDATE") {
		ds.baseParams["ORGAN_ID@="] = idField;
		ds.on("load", function() {
					var records = ds.getAllRecords();
					resourceDs.baseParams["DEPT_ID@="] = records[0]
							.get("deptCode");
							
					deptCode = records[0].get("deptCode");
					resourceDs.load();
					areaDs.baseParams["DEPT_ID@="] = records[0].get("deptCode");
					areaDs.load();
				})
		ds.load();

		showOrhide(dept_code);
	} else {
		L5.Msg.alert('提示', "未知的页面命令!");
		back();
	}

	var allPanel = L5.getCmp("allPanel");
	var areaGridPanel = L5.getCmp("areaGridPanel");
	var resourceGridPanel = L5.getCmp("resourceGridPanel");
	var areaPanel = L5.getCmp("areaPanel");
	var resourcePanel = L5.getCmp("resourcePanel");
/*	if (organCode.substring(2) != "0000000000"
			&& organCode.substring(4) != "00000000"
			&& organCode.substring(6) == "000000" ) { // 县级用户
			*/
		if (deptId!=null && deptId!="" && (deptId.substring(4)!="0001" || deptId.substring(4,10)=="0099" )) {
		document.getElementById("deptCode").disabled = true;
		document.getElementById("name").disabled = true;
		allPanel.remove(areaGridPanel);
		allPanel.remove(resourceGridPanel);
	} else {
		allPanel.remove(areaPanel);
		allPanel.remove(resourcePanel);
	}
	L5.QuickTips.init();
}

function initTargetRef() {
	new L5.ux.ItemSelector({
				field : "forAreaCode",
				applyTo : "favordiv",
				id : "targetRefId",
				name : "targetRef_name",
				dataFields : ["value", "text"],
				fromDataset : organTypeDsNew,
				toDataset : cityDs,
				valueField : "value",
				displayField : "text",
				msWidth : 206,
				msHeight : 195,
				drawUpIcon : false,
				drawDownIcon : false,
				drawTopIcon : false,
				drawBotIcon : false
			});
}

function save1() {
	var records = ds.getAllChangedRecords();
	if (records.length < 1) {
		L5.Msg.alert('提示', '没有需要保存的数据!');
		return false;
	}
	var isValidate = ds.isValidate();
	if (isValidate != true) {
		L5.Msg.alert('提示', "校验未通过,不能保存!" + isValidate);
		return false;
	}

	var command = new L5.Command("com.inspur.cams.marry.base.cmd.MrmResourcesInfoCommand");
	command.setParameter("records", records);
	command.execute("save");
	if (!command.error) {
		ds.commitChanges();
		L5.Msg.alert('提示', "数据保存成功!");
	} else {
		L5.Msg.alert('提示', "保存时出现错误！" + command.error);
	}
}

function insertAll() {
	var command = new L5.Command("com.inspur.cams.marry.base.cmd.MrmRegisOrganInfoCommand");
	command.execute("insertAll");
	if (!command.error) {
		ds.commitChanges();
		L5.Msg.alert('提示', "数据保存成功!");
	} else {
		L5.Msg.alert('提示', "保存时出现错误！" + command.error);
	}
}
function save() {
	var ds = L5.DatasetMgr.lookup("ds");
	var resourceDs = L5.DatasetMgr.lookup("resourceDs");
	var areaDs = L5.DatasetMgr.lookup("areaDs");
	var record = ds.getCurrent();
	var resourceRecords = resourceDs.getAllChangedRecords();
	var areaRecords = areaDs.getAllChangedRecords();

	if (record.get("deptCode") == "") {
		alert("登记机关代码不能为空！");
		return false;
	}

	if (record.get("name") == "") {
		alert("名称不能为空！");
		return false;
	}
	if (record.get("deptCode").length > 200) {
		alert("部门代码长度不能大于200！");
		return false;
	}
	
	if (record.get("deptAddress").length > 100) {
		alert("地址长度不能大于100！");
		return false;
	}
	if (record.get("deptAddress") == '') {
		alert("地址不能为空！");
		return false;
	}
	if (record.get("deptPost").length > 100) {
		alert("邮编长度不能大于100！");
		return false;
	}
	if (record.get("deptPost") == '') {
		alert("邮编不能为空！");
		return false;
	}
	if (record.get("deptTel").length > 100) {
		alert("服务电话长度不能大于100！");
		return false;
	}
	if (record.get("deptTel") == '') {
		alert("服务电话不能为空！");
		return false;
	}
	if (record.get("deptFax").length > 100) {
		alert("传真电话长度不能大于100！");
		return false;
	}
	if (record.get("regionCode").length > 50) {
		alert("所属行政区代码长度不能大于50！");
		return false;
	}
	if (record.get("regionName").length > 50) {
		alert("所属行政区长度不能大于50！");
		return false;
	}
	if (record.get("deptOrgan").length > 25) {
		alert("所属民政局长度不能大于25！");
		return false;
	}
	if (record.get("abolishDate").length > 19) {
		alert("撤销时间长度不能大于19！");
		return false;
	}
	if (record.get("abolishReason").length > 250) {
		alert("撤销原因长度不能大于250！");
		return false;
	}
	if (record.get("abolishYwgs").length > 4) {
		alert("撤销后业务归属长度不能大于4！");
		return false;
	}
	if (record.get("homeUrl").length > 250) {
		alert("部门外网URL长度不能大于250！");
		return false;
	}
	if (record.get("modifyId") == '') {
		alert("负责人不能为空！");
		return false;
	}
	if (record.get("complainTel") == '') {
		alert("负责人手机不能为空！");
		return false;
	}
	if (record.get("types") == '') {
		alert("编制性质不能为空！");
		return false;
	}
	if (record.get("lastYearBudget") == '') {
		alert("上年度工作经费不能为空！");
		return false;
	}
	if (record.get("thisYearBudget") == '') {
		alert("本年度工作经费不能为空！");
		return false;
	}
	if (record.get("sslevel") == '') {
		alert("级别不能为空！");
		return false;
	}
	if (record.get("deptNumSj") == '') {
		alert("实有人数不能为空！");
		return false;
	}
	if (document.getElementById('validFlag').value == '') {
		alert("机构状态不能为空！");
		return false;
	}

	
	if (deptCode.substring(4) != "0001") { 
		if (record.get("jzname") == '') {
			alert("分管局长姓名不能为空！");
			return false;
		}
		if (record.get("jzdh") == '') {
		alert("分管局长电话不能为空！");
			return false;
		}
		if (record.get("jzsj") == '') {
			alert("分管局长手机不能为空！");
			return false;
		}
	}
	
	//if (record.get("remark").length > 500) {
	//	alert("备注长度不能大于500！");
	//}
	/*
	 * var valid =ds.isValidate(true); if(valid !== true){
	 * L5.Msg.alert("提示","校验未通过，不能保存！"+valid); return false; }
	 * 
	 * 
	 * 
	 * var isValidate = areaDs.isValidate(); if(isValidate != true){
	 * L5.Msg.alert('提示',"校验未通过,不能保存!"+isValidate); return false; } var
	 * isValidate = resourceDs.isValidate(); if(isValidate != true){
	 * L5.Msg.alert('提示',"校验未通过,不能保存!"+isValidate); return false; }
	 */
	var command = new L5.Command("com.inspur.cams.marry.base.cmd.MrmRegisOrganInfoCommand");
	record.set("creatDate", document.getElementById("creatDate").value);
	record.set("abolishDate", document.getElementById("abolishDate").value);

	command.setParameter("record", record);
	command.setParameter("resourceRecords", resourceRecords);
	command.setParameter("areaRecords", areaRecords);

	
	if (method == "INSERT") {
		command.setParameter("DEPT_CODE@=", record.get("deptCode"));
		command.execute("getDept");
		if (command.getReturn("result") == true) {
			L5.Msg.alert("提示", "已存在该登录机关代码");
			return false;
		}
		command.execute("insert");
	} else if (method == "UPDATE") {
		if(deptCode != record.get("deptCode")) { //登录机关代码改变
			command.setParameter("DEPT_CODE@=", record.get("deptCode"));
			command.execute("getDept");
			if (command.getReturn("result") == true) {
				L5.Msg.alert("提示", "已存在该登录机关代码");
				return false;
			}
		}
		command.execute("update");
	}
	if (!command.error) {
		/*
		 * var parentWin = window.parent.window; var tree =
		 * parentWin.L5.getCmp("usertree");
		 */
		if (method == "INSERT") {
			/*
			 * var regionCode=record.get("regionCode"); var parId="";
			 * if(regionCode!="" && regionCode!=null && regionCode.length==12){
			 * parId=regionCode.substring(0,4)+"00000000"; } var node =
			 * tree.getNodeByRecordId(parId, "cityRecord");
			 * ds.getCurrent().set("organId", command.getReturn("organId")) var
			 * rec = new
			 * parentWin.L5.tree.TreeRecord.recordTypes["organRecord"](ds.getCurrent().data,command.getReturn("organId"));
			 * 
			 * node.record.insert(rec);
			 */
			L5.Msg.alert("提示", "保存成功!--此登记机关默认登录用户名：" + record.get("deptCode")
							+ "001" + ",密码：1");
		} else if (method == "UPDATE") {
			/*
			 * var node = tree.getNodeByRecordId(ds.getCurrent().get("organId"),
			 * "organRecord"); node.record.set("name",
			 * ds.getCurrent().get("name")); node.record.commit();
			 */
			L5.Msg.alert("提示", "修改成功!");
		}

		// var
		// url="jsp/cams/marry/dept/mrmregisorganinfo_edit.jsp?method=UPDATE&organId="+command.getReturn("organId")+"&regionCode="+regionCode+"&regionName="+encodeURIComponent(encodeURIComponent(regionName));
		// L5.forward(url);
	} else {
		L5.Msg.alert('提示', "保存错误！" + command.error);
	}
}
// function back()
// { // var url='jsp/cams/marry/dept/mrmregisorganinfo_list.jsp';
// var text = '登记机关信息表';
// L5.forward(url,text);
// }

/**
 * 省内迁移选择迁入民政局窗口
 */
function func_Ingoing() {
	// var organName=document.getElementById("");
	queryOrganName();

	var revalue = window
			.showModalDialog(
					L5.webPath
							+ "/jsp/cams/comm/diccity/dicCityCountyRadio.jsp?organCode="
							+ regionCode + "&organName=" + encodeURIComponent(encodeURIComponent(organName)), "",
					"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		ds.getCurrent().set("regionCode", list[0]);
		ds.getCurrent().set("regionName", list[1]);
		ds.getCurrent().set("deptCode", list[0].substring(0, 6) + "01");
		ds.getCurrent().set("deptOrgan", list[1] + "民政局");
		ds.getCurrent().set("name", list[1] + "民政局婚姻登记处");
	}
}

function resourceInsert() {
	var Grid = L5.getCmp('resourceGridPanel');
	Grid.stopEditing();
	resourceDs.newRecord();

}

function resourceDel() {
	var editGrid = L5.getCmp('resourceGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length < 1) {
		L5.Msg.alert('提示', "请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?', function(state) {
		if (state == "yes") {
			var delIds = [];
			for (var i = 0; i < selected.length; i++) {
				delIds[i] = selected[i].get("resourceId");
			}
			var command = new L5.Command("com.inspur.cams.marry.base.cmd.MrmResourcesInfoCommand");
			command.setParameter("delIds", delIds);
			command.execute("delete");
			if (!command.error) {
				for (var i = 0; i < selected.length; i++) {
					resourceDs.remove(selected[i]);
				}
				resourceDs.commitChanges();
			} else {
				L5.Msg.alert('提示', "保存时出现错误！" + command.error);
			}
		} else {
			return false;
		}
	});

}
function resourceReset() {
	resourceDs.rejectChanges();
}

function areaInsert() {
	var Grid = L5.getCmp('areaGridPanel');
	Grid.stopEditing();
	areaDs.newRecord();

}

function areaDel() {
	var editGrid = L5.getCmp('areaGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length < 1) {
		L5.Msg.alert('提示', "请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?', function(state) {
		if (state == "yes") {
			var delIds = [];
			for (var i = 0; i < selected.length; i++) {
				delIds[i] = selected[i].get("functionId");
			}
			var command = new L5.Command("com.inspur.cams.marry.base.cmd.MrmRegisAreaCommand");
			alert(delIds.length);
			command.setParameter("delIds", delIds);
			command.execute("delete");
			if (!command.error) {
				for (var i = 0; i < selected.length; i++) {
					areaDs.remove(selected[i]);
				}
				areaDs.commitChanges();
			} else {
				L5.Msg.alert('提示', "保存时出现错误！" + command.error);
			}
		} else {
			return false;
		}
	});

}
function areaReset() {
	areaDs.rejectChanges();
}

function getTimes(item) {
	LoushangDate(item.previousSibling);
}

function countRender(value) {
	if (value == undefined)
		value = 0;
	return "记录数:" + value;
}
function arRender(value) {
	if (value == undefined)
		value = 0;
	return "总面积:" + value;
}
function wiRender(value) {
	if (value == undefined)
		value = 0;
	return "窗口:" + value;
}
function chRender(value) {
	if (value == undefined)
		value = 0;
	return "座椅:" + value;
}
function coRender(value) {
	if (value == undefined)
		value = 0;
	return "计算机:" + value;
}
function prRender(value) {
	if (value == undefined)
		value = 0;
	return "打印机:" + value;
}
function caRender(value) {
	if (value == undefined)
		value = 0;
	return "读卡器:" + value;
}

function returnBack() {
	window.history.go(-1);
}
