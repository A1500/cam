	
function init() {
		
		if (method==null||method==""){
			L5.Msg.alert('提示',"未知的页面命令!");
			back();
			}
		else if (method=="INSERT"){
			if(idField!=null&&idField!=""&&year!=null&&year!="") {
				document.getElementById("gloriousId").readOnly=true;
				BptGloriousInstituteDataSet.baseParams["GLORIOUS_ID@="]=idField;
				BptGloriousInstituteDataSet.on("load",getValue);
				BptGloriousInstituteDataSet.load();
			} else {
			BptGloriousInstituteDataSet.newRecord();
			var bptGloriousLegalDataSet = L5.DatasetMgr.lookup("BptGloriousLegalDataSet");
			bptGloriousLegalDataSet.newRecord({gloriousDetailId : document.forms[0].gloriousId.value+document.forms[0].years.value});
			return;
			}
		}else if (method=="UPDATE"){
			document.getElementById("gloriousId").readOnly=true;
			BptGloriousInstituteDataSet.baseParams["GLORIOUS_ID@="]=idField;
			BptGloriousInstituteDataSet.baseParams["years"]=years;
			BptGloriousInstituteDataSet.baseParams["GLORIOUS_ID"]=idField;
			BptGloriousInstituteDataSet.on("load",getValue);
			BptGloriousInstituteDataSet.load();
			var BptGloriousLegalDataSet=L5.DatasetMgr.lookup("BptGloriousLegalDataSet");
			
		}
		function getValue() {
			//如果起先数据为空，则直接调用增加方法
			if(BptGloriousInstituteDataSet.getCount()==0){
				BptGloriousInstituteDataSet.newRecord();
				return;
			}
			if(method == "INSERT"){
				var gloriousId = BptGloriousInstituteDataSet.get("gloriousId");
				var years = BptGloriousInstituteDataSet.get("years");
				var unitFullname = BptGloriousInstituteDataSet.get("unitFullname");
				var domicileName = BptGloriousInstituteDataSet.get("domicileName");
				var domicileCode = BptGloriousInstituteDataSet.get("domicileCode");
				var administrativelevel = BptGloriousInstituteDataSet.get("administrativelevel");
				var unitsnature = BptGloriousInstituteDataSet.get("unitsnature");
				var personSection = BptGloriousInstituteDataSet.get("personSection");
				var creationDate = BptGloriousInstituteDataSet.get("creationDate");
				var registerProperty = BptGloriousInstituteDataSet.get("registerProperty");
				var immobilisations = BptGloriousInstituteDataSet.get("immobilisations");
				var floorArea = BptGloriousInstituteDataSet.get("floorArea");
				var businessArea = BptGloriousInstituteDataSet.get("businessArea");
				var telContact = BptGloriousInstituteDataSet.get("telContact");
				var postcode = BptGloriousInstituteDataSet.get("postcode");
				var mailingAddress = BptGloriousInstituteDataSet.get("mailingAddress");
				var unitIntroduce = BptGloriousInstituteDataSet.get("unitIntroduce");
				BptGloriousInstituteDataSet.removeAll();
				BptGloriousInstituteDataSet.newRecord();
				BptGloriousInstituteDataSet.set("gloriousId",gloriousId);
				BptGloriousInstituteDataSet.set("unitFullname",unitFullname);
				BptGloriousInstituteDataSet.set("years",years);
				BptGloriousInstituteDataSet.set("domicileName",domicileName);
				BptGloriousInstituteDataSet.set("domicileCode",domicileCode);
				BptGloriousInstituteDataSet.set("administrativelevel",administrativelevel);
				BptGloriousInstituteDataSet.set("unitsnature",unitsnature);
				BptGloriousInstituteDataSet.set("personSection",personSection);
				BptGloriousInstituteDataSet.set("creationDate",creationDate);
				BptGloriousInstituteDataSet.set("registerProperty",registerProperty);
				BptGloriousInstituteDataSet.set("immobilisations",immobilisations);
				BptGloriousInstituteDataSet.set("floorArea",floorArea);
				BptGloriousInstituteDataSet.set("businessArea",businessArea);
				BptGloriousInstituteDataSet.set("telContact",telContact);
				BptGloriousInstituteDataSet.set("postcode",postcode);
				BptGloriousInstituteDataSet.set("mailingAddress",mailingAddress);
				BptGloriousInstituteDataSet.set("unitIntroduce",unitIntroduce);
			}
			var bptGloriousLegalDataSet=L5.DatasetMgr.lookup("BptGloriousLegalDataSet");
				bptGloriousLegalDataSet.baseParams["GLORIOUS_DETAIL_ID@="] = idField+year;
				bptGloriousLegalDataSet.load();
			
		}
}


/**
 * 选择属地行政区划窗口
 */
function func_ForDomicileSelect1() {

	queryOrganName();
	var escapeorganName = escape(encodeURIComponent('山东省'));
	var revalue = window.showModalDialog(
			L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?organCode=370000000000&organName="+escapeorganName, "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
			/*
			
			L5.webPath + "/jsp/cams/comm/diccity/dicCityCounty.jsp?organCode="
					+ organCode + "&organName="
					+ escape(encodeURIComponent(organName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
			*/
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		BptGloriousInstituteDataSet.getCurrent().set("domicileCode", list[0]);
		BptGloriousInstituteDataSet.getCurrent().set("domicileName", list[4]);
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
		BptGloriousLegalDataSet.getCurrent().set("majorJob", list[0]);
		BptGloriousLegalDataSet.getCurrent().set("majorJobName", list[1]);
	}
}
function Evt_butPrev_click(e) {
	var dataset = L5.DatasetMgr.lookup("BptGloriousInstituteDataSet");
	if(dataset.movePrev()){
				
	  	BptGloriousLegalDataSet.baseParams["GLORIOUS_ID@="] = document.forms[0].gloriousId.value;
		BptGloriousLegalDataSet.load();
		if(e)e.stopEvent();
		return true;
	}
	return false;
}

function Evt_butNext_click(e) {
	var dataset = L5.DatasetMgr.lookup("BptGloriousInstituteDataSet");
	if(dataset.moveNext()){
	
		BptGloriousLegalDataSet.baseParams["GLORIOUS_ID@="] = document.forms[0].gloriousId.value;
		BptGloriousLegalDataSet.load();
		if(e)e.stopEvent();
		return true;
	}
	return false;

}
function addBptGloriousLegal() {
	BptGloriousLegalDataSet.newRecord({
		gloriousId : document.forms[0].gloriousId.value

	});

}

function removeBptGloriousLegal() {
	var editGrid=L5.getCmp('BptGloriousLegalEditGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
		if(state=="yes"){
			var command=new L5.Command("com.inspur.cams.bpt.bptinstitution.cmd.BptGloriousLegalCommand");
			for(var i=0;i<selected.length;i++){
				var delId=selected[i].get("legalId");				
				command.setParameter("delId", delId);
				command.execute("delete");
				BptGloriousLegalDataSet.remove(selected[i]);
			}
			
		}else{
			return false;
		}
	});
}

function insertClick(e){
	document.getElementById("gloriousId").readOnly=false;
	var dataset = L5.DatasetMgr.lookup("BptGloriousInstituteDataSet");
	//如果某必填数据为"",不再继续增加
	if(dataset.getCount()>0 && document.forms[0].gloriousId.value.trim()==""){
		return;
	}
	dataset.newRecord();
	dataset.moveTo(dataset.getCount()-1);
	
	BptGloriousLegalDataSet.baseParams["LEGAL_ID@="]="-" ;
	BptGloriousLegalDataSet.load();

}
function deleteClick(e){
	L5.MessageBox.confirm('确定', '你确定要删除吗？',function(sta){
		if(sta=="yes"){
			var BptGloriousInstituteDataSet = L5.DatasetMgr.lookup("BptGloriousInstituteDataSet");
			var BptGloriousInstituteRecord=BptGloriousInstituteDataSet.getCurrent();
			var command = new L5.Command("com.inspur.cams.bpt.bptinstitution.cmd.BptGloriousInstituteCommand");
			var  delIds=[];
			delIds[0]= BptGloriousInstituteRecord.get("gloriousId");
			command.setParameter("delIds",delIds);
			command.execute("delete");
			if (!command.error) {
				BptGloriousInstituteDataSet.remove(BptGloriousInstituteRecord);
				if(!Evt_butNext_click()){
					Evt_butPrev_click();
				}
				L5.Msg.alert('提示','删除成功！');
				var url='jsp/cams/bpt/institution/gloriousInstitute/bptgloriousinstitute_list.jsp';
				var text="用户表";
				L5.forward(url,text);
			}else{
				L5.Msg.alert('提示',"保存时出现错误！"+command.error);
			}
		}
		else
			return;
	}
	);

}
function saveClick(){
	var BptGloriousInstituteDataSet = L5.DatasetMgr.lookup("BptGloriousInstituteDataSet");
	var BptGloriousInstituteRecord=BptGloriousInstituteDataSet.getCurrent();
	var BptGloriousLegalDataSet = L5.DatasetMgr.lookup("BptGloriousLegalDataSet");
	var BptGloriousLegalRecord=BptGloriousLegalDataSet.getCurrent();
	
	var command = new L5.Command("com.inspur.cams.bpt.bptinstitution.cmd.BptGloriousInstituteCommand");
	command.setParameter("years", BptGloriousInstituteRecord.get("years"));
	command.setParameter("glorious_id", BptGloriousInstituteRecord.get("gloriousId"));
	command.execute("isYearHave");
	var flag = command.getReturn("year");
	if (!command.error) {
		if(flag=='1') {
			L5.Msg.alert("提示", "该年度数据已存在!");
			return;
		}
	}else{
		L5.Msg.alert('提示',"查询年度时出现错误！"+command.error);
	}
var unitFullname =BptGloriousInstituteRecord.get("unitFullname");	
    if(unitFullname==null||unitFullname=="")
    {
    	L5.Msg.alert("提示", "单位全称不能为空!");
    	return false;
    }
     var domicileCode =BptGloriousInstituteRecord.get("domicileCode");	
    if(domicileCode==null||domicileCode=="")
    {
    	L5.Msg.alert("提示", "行政区划不能为空!");
    	return false;
    }
    var registerProperty =BptGloriousInstituteRecord.get("registerProperty");	
    if(registerProperty==null||registerProperty=="")
    {
    	L5.Msg.alert("提示", "注册资本不能为空!");
    	return false;
    }
    var floorArea =BptGloriousInstituteRecord.get("floorArea");
     if(floorArea==null||floorArea=="")
    {
    	L5.Msg.alert("提示", "占地面积不能为空!");
    	return false;
    }
    var immobilisations =BptGloriousInstituteRecord.get("immobilisations");	
    if(immobilisations==null||immobilisations=="")
    {
    	L5.Msg.alert("提示", "固定资产原值不能为空!");
    	return false;
    }
    var sex =BptGloriousLegalDataSet.get("sex");	
    if(sex==null||sex=="")
    {
    	L5.Msg.alert("提示", "性别不能为空!");
    	return false;
    }
    var nation =BptGloriousLegalDataSet.get("nation");	
    if(nation==null||nation=="")
    {
    	L5.Msg.alert("提示", "民族不能为空!");
    	return false;
    }
	var isValidate = BptGloriousLegalDataSet.isValidate();
	var idCard = BptGloriousLegalRecord.get("idCard");
    if(idCard==null||idCard=="")
    {
    	L5.Msg.alert("提示", "身份证格式不能为空!");
    	return false;
    }
	if(!checkIDCard1(idCard)){
	    L5.Msg.alert("提示", "身份证格式不正确!");
	    return false;
	}
	if(isValidate != true){
		L5.Msg.alert("提示",isValidate);
		return false;
	}
	var creationDate = document.getElementById("creationDate").value;
	if(creationDate!=''&&!validateDateFormat(creationDate)){
		L5.Msg.alert("提示", "建立日期格式不正确！");
		return false;
	}
	

		
		//var BptGloriousLegalRecords = BptGloriousLegalDataSet.getAllChangedRecords();
		var isLegalValidate = BptGloriousLegalDataSet.isValidate();
		if(isLegalValidate != true){//判断光荣院法人代表中是否为空
			L5.Msg.alert("提示",isLegalValidate);
			return false;
		}
		var birthday = BptGloriousLegalRecord.get("birthday");
		if(birthday!=''&&!validateDateFormat(birthday)){
		L5.Msg.alert("提示", "出生日期格式不正确！");
		return false;
	}
		command.setParameter("BptGloriousLegalRecord", BptGloriousLegalRecord);
	
	command.setParameter("BptGloriousInstituteRecord", BptGloriousInstituteRecord);
	command.execute("insertYear");
	if (!command.error) {
	
		BptGloriousLegalDataSet.commitChanges();
	
		BptGloriousInstituteDataSet.getCurrent().state = L5.model.Record.STATE_MODIFIED;
		L5.Msg.alert('提示','保存成功！',function(){
			window.returnValue='1';
			window.close();
		});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
	
}

function returnClick(){	
	var url='jsp/cams/bpt/institution/gloriousInstitute/bptgloriousinstitute_list.jsp';
	var text='光荣院信息';
	L5.forward(url,text);	
}

function submit() {
	var records = BptGloriousLegalDataSet.getAllChangedRecords();
	if(records.length<1){
		L5.Msg.alert('提示','没有需要保存的数据！');
		return false;
	}
	
	var command = new L5.Command("com.inspur.cams.bpt.bptinstitution.cmd.BptGloriousLegalCommand");
	command.setParameter("bptgloriouslegalRecords", records);
	command.execute("save");
	if (!command.error) {
		BptGloriousLegalDataSet.commitChanges();
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
function undo() {
	BptGloriousLegalDataSet.rejectChanges();
}
function sum() {
	var placeFunds=parseFloat("0");
  	if(document.getElementById("provinceFunds").value!="") {
		var provinceFunds = parseFloat(document.getElementById("provinceFunds").value);
		placeFunds+=provinceFunds;
	}
	
	if(document.getElementById("cityFunds").value!="") {
		var cityFunds = parseFloat(document.getElementById("cityFunds").value);
		placeFunds+=cityFunds;
	}
	if(document.getElementById("countyFunds").value!="") {
		var countyFunds = parseFloat(document.getElementById("countyFunds").value);
		placeFunds+=countyFunds;
	}
	if(document.getElementById("otherFunds").value!="") {
		var otherFunds = parseFloat(document.getElementById("otherFunds").value);
		placeFunds+=otherFunds;
	}
	document.getElementById("placeFunds").value = placeFunds;
	var BptGloriousInstituteDataSet = L5.DatasetMgr.lookup("BptGloriousInstituteDataSet");
		BptGloriousInstituteDataSet.set("placeFunds",placeFunds)

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
		BptGloriousInstituteDataSet.setParameter("years",document.getElementById("years").value);
		var gloriousId = document.getElementById("gloriousId").value;
		BptGloriousInstituteDataSet.setParameter("GLORIOUS_ID",gloriousId);
		BptGloriousInstituteDataSet.load();	
		
	}
}
