function init() {
	if (method==null||method==""){
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
		}
	else if (method=="INSERT"){
		ds.newRecord();
	}
	else if (method=="UPDATE"){
		ds.baseParams["ID@="]=idField;
		ds.load();
		ds.on('load',backBeforeAssMsg);
	}
	else{
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
	}
	L5.QuickTips.init(); 
}
//人员姓名
var name;
//家庭Id
var familyId;
var peopleId;
//根据人员身份证号加载人员医前救助信息
function loadBeforeAssMsg(){
	if(getParam("idCard")){
		var BaseinfoPeopleDataSet=L5.DatasetMgr.lookup("BaseinfoPeopleDataSet");
		BaseinfoPeopleDataSet.baseParams["ID_CARD"]=getParam("idCard");
		BaseinfoPeopleDataSet.baseParams["DOMICILE_CODE@like@String"]=organCode.substring(0,6);
		BaseinfoPeopleDataSet.load();
		BaseinfoPeopleDataSet.on('load',setPeoInfo);
	}
}
//回填人员信息
function setPeoInfo(BaseinfoPeopleDataSet){
	if(BaseinfoPeopleDataSet.getCount()==0){
		L5.Msg.alert('提示',"未找到此人相关信息!");
		document.getElementById("name").innerHTML="";
		document.getElementById("idCard").value="";
		return;
	}
	name=BaseinfoPeopleDataSet.get("name");
	familyId=BaseinfoPeopleDataSet.get("familyId");
	peopleId=BaseinfoPeopleDataSet.get("peopleId");
	document.getElementById("name").innerHTML=name;
}
//记录当前修改信息的家庭人员相关信息
function backBeforeAssMsg(ds){
	document.getElementById("idCard").disabled=true;	
	var record=ds.getCurrent();
	if(record){
		name=record.get("name");
		familyId=record.get("familyId");
		peopleId=record.get("peopleId");
	}
}
function save(){
    var records = ds.getAllChangedRecords();
	if(records==""&&method=="UPDATE"){
		L5.Msg.alert('提示','请填写修改信息，不修改请点击返回!');
		return false;
	}
	if(!name){
		L5.Msg.alert('提示','未找到此人相关信息!');
		return false;
	}
	//校验
	var valid = ds.isValidate();
	if(valid != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+valid);
		return false;
	}	
	records[0].set("name",name); 
	records[0].set("familyId",familyId); 
	records[0].set("peopleId",peopleId); 
	records[0].set("assitanceOrgCode",organCode);
	
	//校验是否已经对此人给予医前救助
	beforeCheckDS.setParameter("NAME",name);
	beforeCheckDS.setParameter("ID_CARD",getParam("idCard"));
	beforeCheckDS.setParameter("PEOPLE_ID",peopleId);
	beforeCheckDS.setParameter("FAMILY_ID",familyId);
	beforeCheckDS.setParameter("STATUS",'1');
	beforeCheckDS.setParameter("ID@<>",records[0].get("id"));
	beforeCheckDS.load();
	beforeCheckDS.on('load',function(){
		if(beforeCheckDS.getCount()>0){
			L5.Msg.alert('提示',"已经给予此人医前救助!");
			document.getElementById("name").innerHTML="";
			document.getElementById("idCard").value="";
			document.getElementById("idCard").focus();
			return;
		}
		var command=new L5.Command("com.inspur.cams.drel.mbalance.cmd.SamMedicalBeforeCmd");
		command.setParameter("records",records);
		if (method=="INSERT"){
			command.execute("insert");	
		}else{
			command.execute("update");
		}
		if (!command.error) {
			L5.Msg.alert('提示',"保存成功!");
			back();
		}else{
			L5.Msg.alert('提示',"保存时出现错误！"+command.error);
		}
	});
	
}
//返回
 function back()
 {	 	var url='jsp/cams/drel/mbalance/samMBeforeList.jsp';
		var text = '一站结算_医前救助';
		L5.forward(url,text);	 
 }
//金额小数点位数处理
function checkAssMon(value){
	if(value){
		document.getElementById("assitanceMon").value=changeTwoDecimal(value);
	}
}


