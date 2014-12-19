function init() {
	if (method == null || method == "") {
		L5.Msg.alert('提示', "未知的页面命令!");
		back();
	} else if (method == "INSERT") {
		if(idField!=null&&idField!=""&&year!=null&&year!="") {
			document.getElementById("hospitalId").readOnly = true;
			BptHospitalDataSet.baseParams["HOSPITAL_ID@="] = idField;
			BptHospitalDataSet.on("load", getValue);
			BptHospitalDataSet.load();
			var BptHospitalLegalDataSet = L5.DatasetMgr.lookup("BptHospitalLegalDataSet");
			
		} else{
			BptHospitalDataSet.newRecord({
				hospitalId : idField
			});
			var legalDataSet = L5.DatasetMgr.lookup("BptHospitalLegalDataSet");
			legalDataSet.newRecord({
				hospitalDetailId : idField+document.forms[0].years.value
			});
		return;}
	} else if (method == "UPDATE") {
		document.getElementById("hospitalId").readOnly = true;
		BptHospitalDataSet.baseParams["HOSPITAL_ID@="] = idField;
		BptHospitalDataSet.baseParams["years"] = years;
		BptHospitalDataSet.baseParams["HOSPITAL_ID"] = idField;
		BptHospitalDataSet.on("load", getValue);
		BptHospitalDataSet.load();

		var BptHospitalLegalDataSet = L5.DatasetMgr
				.lookup("BptHospitalLegalDataSet");

	}
	function getValue() {
		// 如果起先数据为空，则直接调用增加方法
		if (BptHospitalDataSet.getCount() == 0) {
			BptHospitalDataSet.newRecord();
			BptHospitalLegalDataSet.newRecord();
			return;
		}
		if(method == "INSERT"){
			var hospitalId = BptHospitalDataSet.get("hospitalId");
			var years = BptHospitalDataSet.get("years");
			var unitFullname = BptHospitalDataSet.get("unitFullname");
			var domicileName = BptHospitalDataSet.get("domicileName");
			var domicileCode = BptHospitalDataSet.get("domicileCode");
			var administrativelevel = BptHospitalDataSet.get("administrativelevel");
			var unitsnature = BptHospitalDataSet.get("unitsnature");
			var personSection = BptHospitalDataSet.get("personSection");
			var creationDate = BptHospitalDataSet.get("creationDate");
			var registerProperty = BptHospitalDataSet.get("registerProperty");
			var immobilisations = BptHospitalDataSet.get("immobilisations");
			var floorArea = BptHospitalDataSet.get("floorArea");
			var businessArea = BptHospitalDataSet.get("businessArea");
			var telContact = BptHospitalDataSet.get("telContact");
			var postcode = BptHospitalDataSet.get("postcode");
			var mailingAddress = BptHospitalDataSet.get("mailingAddress");
			var unitIntroduce = BptHospitalDataSet.get("unitIntroduce");
			BptHospitalDataSet.removeAll();
			BptHospitalDataSet.newRecord();
			BptHospitalDataSet.set("hospitalId",hospitalId);
			BptHospitalDataSet.set("unitFullname",unitFullname);
			BptHospitalDataSet.set("years",years);
			BptHospitalDataSet.set("domicileName",domicileName);
			BptHospitalDataSet.set("domicileCode",domicileCode);
			BptHospitalDataSet.set("administrativelevel",administrativelevel);
			BptHospitalDataSet.set("unitsnature",unitsnature);
			BptHospitalDataSet.set("personSection",personSection);
			BptHospitalDataSet.set("creationDate",creationDate);
			BptHospitalDataSet.set("registerProperty",registerProperty);
			BptHospitalDataSet.set("immobilisations",immobilisations);
			BptHospitalDataSet.set("floorArea",floorArea);
			BptHospitalDataSet.set("businessArea",businessArea);
			BptHospitalDataSet.set("telContact",telContact);
			BptHospitalDataSet.set("postcode",postcode);
			BptHospitalDataSet.set("mailingAddress",mailingAddress);
			BptHospitalDataSet.set("unitIntroduce",unitIntroduce);
		}

		BptHospitalLegalDataSet.baseParams["HOSPITAL_DETAIL_ID@="] = idField+year;
		BptHospitalLegalDataSet.load();
	}
	L5.QuickTips.init();
}

function Evt_butPrev_click(e) {
	var dataset = L5.DatasetMgr.lookup("BptHospitalDataSet");
	if (dataset.movePrev()) {

		BptHospitalLegalDataSet.baseParams["HOSPITAL_ID@="] = document.forms[0].hospitalId.value;
		BptHospitalLegalDataSet.load();
		if (e)
			e.stopEvent();
		return true;
	}
	return false;
}

function Evt_butNext_click(e) {
	var dataset = L5.DatasetMgr.lookup("BptHospitalDataSet");
	if (dataset.moveNext()) {

		BptHospitalLegalDataSet.baseParams["HOSPITAL_ID@="] = document.forms[0].hospitalId.value;
		BptHospitalLegalDataSet.load();
		if (e)
			e.stopEvent();
		return true;
	}
	return false;

}
/**
 * 选择属地行政区划窗口
 */
function func_ForDomicileSelect1() {

	queryOrganName();
	var escapeorganName = escape(encodeURIComponent('山东省'));
	var revalue = window.showModalDialog(L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?organCode=370000000000&organName="+escapeorganName, "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	
	/*window.showModalDialog(
			L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?organCode="
					+ organCode + "&organName="
					+ escape(encodeURIComponent(organName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
			*/
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		BptHospitalDataSet.getCurrent().set("domicileCode", list[0]);
		BptHospitalDataSet.getCurrent().set("domicileName", list[4]);
	}
}
/**
 * 选择职称窗口
 */
function func_ForCareerSelect() {

	var revalue = window.showModalDialog(
			L5.webPath + "/jsp/cams/bpt/comm/dicBptCareer.jsp", "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		BptHospitalLegalDataSet.getCurrent().set("majorJob", list[0]);
		BptHospitalLegalDataSet.getCurrent().set("majorJobName", list[1]);
	}
}
function addBptHospitalLegal() {
	BptHospitalLegalDataSet.newRecord({
				hospitalId : document.forms[0].hospitalId.value

			});

}

function removeBptHospitalLegal() {
	var editGrid = L5.getCmp('BptHospitalLegalEditGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length < 1) {
		L5.Msg.alert('提示', "请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?', function(state) {
		if (state == "yes") {
			var command = new L5.Command("com.inspur.cams.bpt.bptinstitution.cmd.BptHospitalLegalCommand");
			for (var i = 0; i < selected.length; i++) {
				var delId = selected[i].get("legalId");
				command.setParameter("delId", delId);
				command.execute("delete");
				BptHospitalLegalDataSet.remove(selected[i]);
			}

		} else {
			return false;
		}
	});
}

function insertClick(e) {
	document.getElementById("hospitalId").readOnly = false;
	var dataset = L5.DatasetMgr.lookup("BptHospitalDataSet");
	// 如果某必填数据为"",不再继续增加
	if (dataset.getCount() > 0
			&& document.forms[0].hospitalId.value.trim() == "") {
		return;
	}
	dataset.newRecord();
	dataset.moveTo(dataset.getCount() - 1);

	BptHospitalLegalDataSet.baseParams["LEGAL_ID@="] = "-";
	BptHospitalLegalDataSet.load();

}
function deleteClick(e) {
	L5.MessageBox.confirm('确定', '你确定要删除吗？', function(sta) {
		if (sta == "yes") {
			var BptHospitalDataSet = L5.DatasetMgr.lookup("BptHospitalDataSet");
			var BptHospitalRecord = BptHospitalDataSet.getCurrent();
			var command = new L5.Command("com.inspur.cams.bpt.bptinstitution.cmd.BptHospitalCommand");
			var delIds = [];
			delIds[0] = BptHospitalRecord.get("hospitalId");
			command.setParameter("delIds", delIds);
			command.execute("delete");
			if (!command.error) {
				BptHospitalDataSet.remove(BptHospitalRecord);
				if (!Evt_butNext_click()) {
					Evt_butPrev_click();
				}
				L5.Msg.alert('提示', '删除成功！');
				var url = 'jsp/cams/bpt/institution/hospital/bpthospital_list.jsp';
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
	var BptHospitalDataSet = L5.DatasetMgr.lookup("BptHospitalDataSet");
	var BptHospitalRecord = BptHospitalDataSet.getCurrent();
	var BptHospitalLegalDataSet = L5.DatasetMgr.lookup("BptHospitalLegalDataSet");
	var BptHospitalLegalRecord = BptHospitalLegalDataSet.getCurrent();
	if(BptHospitalRecord.get("id")==null||BptHospitalRecord.get("id")=="") {
		alert("请在增加新年度信息页面中添加！");
		return false ;
	}
	var unitFullname =BptHospitalRecord.get("unitFullname");	
    if(unitFullname==null||unitFullname=="")
    {
    	L5.Msg.alert("提示", "单位全称不能为空!");
    	return false;
    }
    var registerProperty =BptHospitalRecord.get("registerProperty");	
    if(registerProperty==null||registerProperty=="")
    {
    	L5.Msg.alert("提示", "注册资本不能为空!");
    	return false;
    }
    var floorArea =BptHospitalRecord.get("floorArea");
     if(floorArea==null||floorArea=="")
    {
    	L5.Msg.alert("提示", "占地面积不能为空!");
    	return false;
    }
    var immobilisations =BptHospitalRecord.get("immobilisations");	
    if(immobilisations==null||immobilisations=="")
    {
    	L5.Msg.alert("提示", "固定资产原值不能为空!");
    	return false;
    }
    var sex =BptHospitalLegalRecord.get("sex");	
    if(sex==null||sex=="")
    {
    	L5.Msg.alert("提示", "性别不能为空!");
    	return false;
    }
    var nation =BptHospitalLegalRecord.get("nation");	
    if(nation==null||nation=="")
    {
    	L5.Msg.alert("提示", "民族不能为空!");
    	return false;
    }
	var idCard =BptHospitalLegalRecord.get("idCard");	
    if(idCard==null||idCard=="")
    {
    	L5.Msg.alert("提示", "身份证不能为空!");
    	return false;
    }
	if(!checkIDCard1(idCard)){
	    L5.Msg.alert("提示", "身份证格式不正确!");
	    return false;
	}
	var isValidate = BptHospitalDataSet.isValidate();
	if (isValidate != true) {
		L5.Msg.alert("提示", isValidate);
		return false;
	}
	var creationDate = BptHospitalRecord.get("creationDate");
	if (creationDate != '' && !validateDateFormat(creationDate)) {
		L5.Msg.alert("提示", "建立日期格式不正确！");
		return false;
	}

	var command = new L5.Command("com.inspur.cams.bpt.bptinstitution.cmd.BptHospitalCommand");

	var BptHospitalLegalRecords = BptHospitalLegalDataSet
			.getAllChangedRecords();
	var isLValidate = BptHospitalLegalDataSet.isValidate();
	if (isLValidate != true) {
		L5.Msg.alert("提示", isLValidate);
		return false;
	}
	var birthday = BptHospitalLegalRecord.get("birthday");
	if (birthday != '' && !validateDateFormat(birthday)) {
		L5.Msg.alert("提示", "出生日期格式不正确！");
		return false;
	}
	command.setParameter("BptHospitalLegalRecords", BptHospitalLegalRecords);
	command.setParameter("BptHospitalRecord", BptHospitalRecord);
	command.execute("save");

	if (!command.error) {
		BptHospitalLegalDataSet.commitChanges();

		BptHospitalDataSet.getCurrent().state = L5.model.Record.STATE_MODIFIED;
		L5.Msg.alert('提示', '保存成功！');
		window.returnValue="1";
		window.close();
	} else {
		L5.Msg.alert('提示', "保存时出现错误！" + command.error);
	}
}
function saveInsertClick() {

	var BptHospitalDataSet = L5.DatasetMgr.lookup("BptHospitalDataSet");
	var BptHospitalRecord = BptHospitalDataSet.getCurrent();
	var BptHospitalLegalDataSet = L5.DatasetMgr.lookup("BptHospitalLegalDataSet");
	var BptHospitalLegalRecord = BptHospitalLegalDataSet.getCurrent();
	var immobilisations =BptHospitalRecord.get("immobilisations");	
	
	var command = new L5.Command("com.inspur.cams.bpt.bptinstitution.cmd.BptHospitalCommand");
	command.setParameter("years", BptHospitalRecord.get("years"));
	command.setParameter("hospital_id", BptHospitalRecord.get("hospitalId"));
	command.execute("isYearHave");
	var flag = command.getReturn("year");
	if(flag=='1') {
		L5.Msg.alert("提示", "该年度数据已存在!");
		return;
	}
    if(immobilisations==null||immobilisations=="")
    {
    	L5.Msg.alert("提示", "固定资产原值不能为空!");
    	return false;
    }
	var idCard =BptHospitalLegalRecord.get("idCard");	
    if(idCard==null||idCard=="")
    {
    	L5.Msg.alert("提示", "法人代表身份证不能为空!");
    	return false;
    }
	if(!checkIDCard1(idCard)){
	    L5.Msg.alert("提示", "法人代表身份证格式不正确!");
	    return false;
	}
	var isValidate = BptHospitalDataSet.isValidate();
	if (isValidate != true) {
		L5.Msg.alert("提示", isValidate);
		return false;
	}
	var creationDate = BptHospitalRecord.get("creationDate");
	if (creationDate != '' && !validateDateFormat(creationDate)) {
		L5.Msg.alert("提示", "建立日期格式不正确！");
		return false;
	}

	

	//var BptHospitalLegalRecords = BptHospitalLegalDataSet.getAllChangedRecords();
	var isLValidate = BptHospitalLegalDataSet.isValidate();
	if (isLValidate != true) {
		L5.Msg.alert("提示", isLValidate);
		return false;
	}
	var birthday = BptHospitalLegalRecord.get("birthday");
	if (birthday != '' && !validateDateFormat(birthday)) {
		L5.Msg.alert("提示", "出生日期格式不正确！");
		return false;
	}
	command.setParameter("BptHospitalLegalRecord", BptHospitalLegalRecord);
	command.setParameter("BptHospitalRecord", BptHospitalRecord);
	command.execute("insertYear");

	if (!command.error) {
		BptHospitalLegalDataSet.commitChanges();

		BptHospitalDataSet.getCurrent().state = L5.model.Record.STATE_MODIFIED;
		L5.Msg.alert('提示', '保存成功！');
		window.returnValue="1";
		window.close();
	} else {
		L5.Msg.alert('提示', "保存时出现错误！" + command.error);
	}
}

function submit() {
	var records = BptHospitalLegalDataSet.getAllChangedRecords();
	if (records.length < 1) {
		L5.Msg.alert('提示', '没有需要保存的数据！');
		return false;
	}
	var command = new L5.Command("com.inspur.cams.bpt.bptinstitution.cmd.BptHospitalLegalCommand");
	command.setParameter("bpthospitallegalRecords", records);
	command.execute("save");
	if (!command.error) {
		BptHospitalLegalDataSet.commitChanges();
	} else {
		L5.Msg.alert('提示', "保存时出现错误！" + command.error);
	}
}
function undo() {
	BptHospitalLegalDataSet.rejectChanges();
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
//查询
function queryDetail(){
	if(document.getElementById("years").value!=null&&document.getElementById("years").value!="") {
		BptHospitalDataSet.setParameter("years",document.getElementById("years").value);
		var hospitalId = document.getElementById("hospitalId").value;
		BptHospitalDataSet.setParameter("HOSPITAL_ID",hospitalId);
		BptHospitalDataSet.load();	
	}
}
//插入新的年度
function insertDetail() {
	var editGrid=L5.getCmp('editGridPanel');
	var data = new L5.Map();
	data.put("dataBean",document.getElementById("hospitalId").value);
	data.put("method","INSERT");
	var url='jsp/cams/bpt/institution/hospital/bpthospital_insertnewyear.jsp';
	var text = '增加优抚医院信息';
	L5.forward(url,text,data);

}