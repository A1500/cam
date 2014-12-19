var ifQuery = false;
  
function init() {
	if(method=='INSERT'){
		ds.newRecord();
	}else if(method=='UPDATE'){
		ds.setParameter("perjuryId",perjuryId);	
		ds.load();
	}
	
	//L5.DatasetMgr.lookup("ds").load();	
	//L5.QuickTips.init();
};


function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}

function save() {
	var records = ds.getAllChangedRecords();
	if(records.length<1){
		L5.Msg.alert('提示','没有需要保存的数据!');
		return false;
	}
	var isValidate = ds.isValidate();
	if(isValidate != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+isValidate);
		return false;
	}
	
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptPerjuryCommand");
	command.setParameter("records", records);
	command.execute("save");
	if (!command.error) {
		ds.commitChanges();
		L5.Msg.alert('提示',"保存成功!");
		window.close();
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
function reset() {
	ds.rejectChanges();
}
function forHelp(o,f) {
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
		o.value = list[4];
		o.nextSibling.value = list[0];
		if(f){
			ds.getCurrent().set("domicileCode",list[0]);
		}
		//o.nextSibling.focus();
	}
}

function checkDoublePerson(o){
	if(!checkIDCard(o)){
	    L5.Msg.alert("提示", "身份证格式不正确!");
	    return false;
	}
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptPerjuryCommand");
	command.setParameter("idCard", o.value);
	command.execute("checkDoublePerson");
	var flag = command.getReturn("flag");//0;没有重复 ,1:有重复
	if ("1"==flag) {
		document.forms[0].reset();
		L5.Msg.alert('提示',"黑名单内已经存在此人员!");
	}else if("0"==flag){
		
	}
}

