function init() {

	if (method == null || method == "") {
		L5.Msg.alert('提示', "未知的页面命令!");
		back();
	} else if (method == "INSERT") {
		BptMartyrBuildingsDataSet.newRecord();
		var legalDataSet = L5.DatasetMgr
				.lookup("BptMartyrBuildingsLegalDataSet");
		legalDataSet.newRecord({
					mbuildingId : document.forms[0].mbuildingId.value
				});
		return;
	} else if (method == "UPDATE") {
		
		document.getElementById("mbuildingId").readOnly = true;
		BptMartyrBuildingsDataSet.baseParams["MBUILDING_ID@="] = idField;
		BptMartyrBuildingsDataSet.on("load", getValue);
		BptMartyrBuildingsDataSet.load();
		
		//var BptMartyrBuildingsLegalDataSet = L5.DatasetMgr
			//	.lookup("BptMartyrBuildingsLegalDataSet");
		BptMartyrBuildingsLegalDataSet.baseParams["MBUILDING_ID@="] = idField;
		BptMartyrBuildingsLegalDataSet.load();

	}
	function getValue() {
		// 如果起先数据为空，则直接调用增加方法
		if (BptMartyrBuildingsDataSet.getCount() == 0) {
			BptMartyrBuildingsDataSet.newRecord();
			return;
		}

		BptMartyrBuildingsLegalDataSet.baseParams["MBUILDING_ID@="] = idField;
		BptMartyrBuildingsLegalDataSet.load();

	}
}

function Evt_butPrev_click(e) {
	var dataset = L5.DatasetMgr.lookup("BptMartyrBuildingsDataSet");
	if (dataset.movePrev()) {

		BptMartyrBuildingsLegalDataSet.baseParams["MBUILDING_ID@="] = document.forms[0].mbuildingId.value;
		BptMartyrBuildingsLegalDataSet.load();
		if (e)
			e.stopEvent();
		return true;
	}
	return false;
}

function Evt_butNext_click(e) {
	var dataset = L5.DatasetMgr.lookup("BptMartyrBuildingsDataSet");
	if (dataset.moveNext()) {

		BptMartyrBuildingsLegalDataSet.baseParams["MBUILDING_ID@="] = document.forms[0].mbuildingId.value;
		BptMartyrBuildingsLegalDataSet.load();
		if (e)
			e.stopEvent();
		return true;
	}
	return false;

}
function addBptMartyrBuildingsLegal() {
	BptMartyrBuildingsLegalDataSet.newRecord({
				mbuildingId : document.forms[0].mbuildingId.value

			});

}

function removeBptMartyrBuildingsLegal() {
	var editGrid = L5.getCmp('BptMartyrBuildingsLegalEditGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length < 1) {
		L5.Msg.alert('提示', "请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?', function(state) {
		if (state == "yes") {
			var command = new L5.Command("com.inspur.cams.bpt.bptinstitution.cmd.BptMartyrBuildingsLegalCommand");
			for (var i = 0; i < selected.length; i++) {
				var delId = selected[i].get("legalId");
				command.setParameter("delId", delId);
				command.execute("delete");
				BptMartyrBuildingsLegalDataSet.remove(selected[i]);
			}

		} else {
			return false;
		}
	});
}

function insertClick(e) {
	document.getElementById("mbuildingId").readOnly = false;
	var dataset = L5.DatasetMgr.lookup("BptMartyrBuildingsDataSet");
	// 如果某必填数据为"",不再继续增加
	if (dataset.getCount() > 0
			&& document.forms[0].mbuildingId.value.trim() == "") {
		return;
	}
	dataset.newRecord();
	dataset.moveTo(dataset.getCount() - 1);

	BptMartyrBuildingsLegalDataSet.baseParams["LEGAL_ID@="] = "-";
	BptMartyrBuildingsLegalDataSet.load();

}
function deleteClick(e) {
	L5.MessageBox.confirm('确定', '你确定要删除吗？', function(sta) {
		if (sta == "yes") {
			var BptMartyrBuildingsDataSet = L5.DatasetMgr
					.lookup("BptMartyrBuildingsDataSet");
			var BptMartyrBuildingsRecord = BptMartyrBuildingsDataSet
					.getCurrent();
			var command = new L5.Command("com.inspur.cams.bpt.bptinstitution.cmd.BptMartyrBuildingsCommand");
			var delIds = [];
			delIds[0] = BptMartyrBuildingsRecord.get("mbuildingId");
			command.setParameter("delIds", delIds);
			command.execute("delete");
			if (!command.error) {
				BptMartyrBuildingsDataSet.remove(BptMartyrBuildingsRecord);
				if (!Evt_butNext_click()) {
					Evt_butPrev_click();
				}
				L5.Msg.alert('提示', '删除成功！');
				var url = 'jsp/cams/bpt/institution/martyrbuildings/bptmartyrbuildings_list.jsp';
				var text = "用户表";
				L5.forward(url, text);
			} else {
				L5.Msg.alert('提示', "保存时出现错误！" + command.error);
			}
		} else
			return;
	});

}
function saveClick() {
	var BptMartyrBuildingsDataSet = L5.DatasetMgr
			.lookup("BptMartyrBuildingsDataSet");
	var BptMartyrBuildingsRecord = BptMartyrBuildingsDataSet.getCurrent();
	
	var unitFullname =BptMartyrBuildingsRecord.get("unitFullname");	
    if(unitFullname==null||unitFullname=="")
    {
    	L5.Msg.alert("提示", "单位全称不能为空!");
    	return false;
    }
    var registerProperty =BptMartyrBuildingsRecord.get("registerProperty");	
    if(registerProperty==null||registerProperty=="")
    {
    	L5.Msg.alert("提示", "注册资产不能为空!");
    	return false;
    }
    var floorArea =BptMartyrBuildingsRecord.get("floorArea");
     if(floorArea==null||floorArea=="")
    {
    	L5.Msg.alert("提示", "占地面积不能为空!");
    	return false;
    }
    var immobilisations =BptMartyrBuildingsRecord.get("immobilisations");	
    if(immobilisations==null||immobilisations=="")
    {
    	L5.Msg.alert("提示", "固定资产原值不能为空!");
    	return false;
    }
	var creationDate = BptMartyrBuildingsRecord.get("creationDate");
	if (creationDate != '' && !validateDateFormat(creationDate)) {
		L5.Msg.alert("提示", "建立日期格式不正确！");
		return false;
	}
	var noticeDate = BptMartyrBuildingsRecord.get("noticeDate");
	if (noticeDate != '' && !validateDateFormat(noticeDate)) {
		L5.Msg.alert("提示", "批准时间格式不正确！");
		return false;
	}
	var isValidate = BptMartyrBuildingsDataSet.isValidate();
	if (isValidate != true) {
		L5.Msg.alert("提示", isValidate);
		return false;
	}
	var command = new L5.Command("com.inspur.cams.bpt.bptinstitution.cmd.BptMartyrBuildingsCommand");

	var BptMartyrBuildingsLegalRecords = BptMartyrBuildingsLegalDataSet.getAllChangedRecords();
	if(BptMartyrBuildingsLegalRecords.length>0){
		var birthday = BptMartyrBuildingsLegalRecords[0].get("birthday");
		if (birthday != '' && !validateDateFormat(birthday)) {
			L5.Msg.alert("提示", "出生日期格式不正确！");
			return false;
		}
		var name = BptMartyrBuildingsLegalRecords[0].get("name");
	    if(name==null||name=="")
	    {
	    	L5.Msg.alert("提示", "法人代表姓名不能为空!");
	    	return false;
	    }
	    var sex = BptMartyrBuildingsLegalRecords[0].get("sex");
	    if(sex==null||sex=="")
	    {
	    	L5.Msg.alert("提示", "法人代表性别不能为空!");
	    	return false;
	    }
		var idCard = BptMartyrBuildingsLegalRecords[0].get("idCord");
	    if(idCard==null||idCard=="")
	    {
	    	L5.Msg.alert("提示", "法人代表身份证不能为空!");
	    	return false;
	    }
		if(!checkIDCard1(idCard)){  
		    L5.Msg.alert("提示", "法人代表身份证格式不正确!");
		    return false;
		}
		var nation = BptMartyrBuildingsLegalRecords[0].get("nation");
		if(nation==null||nation=="")
		{
			L5.Msg.alert("提示", "法人代表民族不能为空!");
			return false;
		}
	}
	var isLValidate = BptMartyrBuildingsLegalDataSet.isValidate();
	if(isValidate != true){
		L5.Msg.alert("提示",isValidate);
		return false;
	}
	command.setParameter("BptMartyrBuildingsLegalRecords",
			BptMartyrBuildingsLegalRecords);

	command.setParameter("BptMartyrBuildingsRecord", BptMartyrBuildingsRecord);
	command.execute("save");
	if (!command.error) {

		BptMartyrBuildingsLegalDataSet.commitChanges();

		BptMartyrBuildingsDataSet.getCurrent().state = L5.model.Record.STATE_MODIFIED;
		L5.Msg.alert('提示', '保存成功！');
		var url = 'jsp/cams/bpt/institution/martyrbuildings/bptmartyrbuildings_list.jsp';
		var text = "用户表";
		L5.forward(url, text);
	} else {
		L5.Msg.alert('提示', "保存时出现错误！" + command.error);
	}
}

function returnClick() {
	var url = 'jsp/cams/bpt/institution/martyrbuildings/bptmartyrbuildings_list.jsp';
	var text = '烈士纪念建筑物保护单位信息';
	L5.forward(url, text);
}

function submit() {
	var records = BptMartyrBuildingsLegalDataSet.getAllChangedRecords();
	if (records.length < 1) {
		L5.Msg.alert('提示', '没有需要保存的数据！');
		return false;
	}
	var command = new L5.Command("com.inspur.cams.bpt.bptinstitution.cmd.BptMartyrBuildingsLegalCommand");
	command.setParameter("bptmartyrbuildingslegalRecords", records);
	command.execute("save");
	if (!command.error) {
		BptMartyrBuildingsLegalDataSet.commitChanges();
	} else {
		L5.Msg.alert('提示', "保存时出现错误！" + command.error);
	}
}
function undo() {
	BptMartyrBuildingsLegalDataSet.rejectChanges();
}
//校验身份证号，并将15位身份证号转换为18位
function checkIDCard1(o){
	if(o=="") return true;
	if(o=="000000000000000000") return true;
	var val=o.toUpperCase();
	o=val;
	if(val.length==15){
		if(!is15IDCard(val)){
			return false;
		}else{
			var temp=val.substring(0,6)+"19"+val.substring(6,15);
			o=temp+getCheckBit(temp);
		}
	}else if(val.length==18){
		if(!is18IDCard(val)){
			return false;
		}
	}else{
		return false;
	}
	return true;
}
/**
 * 选择属地行政区划窗口
 */
function func_ForDomicileSelect1() {

	queryOrganName();
	var escapeorganName = escape(encodeURIComponent('山东省'));
	var revalue = window.showModalDialog(L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?organCode=370000000000&organName="+escapeorganName, "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		BptMartyrBuildingsDataSet.getCurrent().set("domicileCode", list[0]);
		BptMartyrBuildingsDataSet.getCurrent().set("domicileName", list[4]);
	}
}
function print() { // 跳转打印页面
	var url="../../../comm/print/jspcommonprint.jsp?";
	var text='';
	var width = 1024;
	var height = 768;
    window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
}