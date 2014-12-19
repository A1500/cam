function init() {
	var ds=L5.DatasetMgr.lookup("ds")
	ds.setParameter("ASSITANCE_ORG_CODE",organCode);
	//ds.load();
	L5.QuickTips.init();
};

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){
	ds.setParameter("sam_medical_before.NAME@=",getParam("name"));		
	ds.setParameter("ASSITANCE_ORG_CODE",organCode);
	ds.setParameter("sam_medical_before.DISEASE@=",getParam("disease"));		
	ds.setParameter("sam_medical_before.AUDIT_DATE@=",getParam("auditDate"));		
	ds.setParameter("sam_medical_before.STATUS@=",getParam("status"));		
	ds.load();
}
var mathod;
var idField;
function insert() {
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	method="INSERT";
	showWin();
}

function update(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录修改!");
		return false;
	}
	if(selected[0].get("status")==0){
		L5.Msg.alert('提示',"不能修改已使用的医前救助!");
		return;
	}
	var data = new L5.Map();
	method="UPDATE";
	idField=selected[0].get('id');
	showWin();
}

function del(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	var usedName="";
	for(i=0;i<selected.length;i++){
		if(selected[i].get("status")==0){
			usedName=selected[i].get("name")+" ";
		}
	}
	if(usedName){
		L5.Msg.alert('提示',usedName+"的医前救助已使用，不能删除!");
		return;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
		if(state=="yes"){
			var  delIds=[];
			for(var i=0;i<selected.length;i++){
				delIds[i]=selected[i].get("id");
			}
			var command=new L5.Command("com.inspur.cams.drel.mbalance.cmd.SamMedicalBeforeCmd");
			command.setParameter("delIds", delIds);
			command.execute("delete");
			if (!command.error) {
				for(var i=0;i<selected.length;i++){
			    	ds.remove(selected[i]);
				}
				ds.commitChanges();
			}else{
				L5.Msg.alert('提示',"保存时出现错误！"+command.error);
			}
		}else{
			return false;
		}
	});
}



function showWin() {
	if (method==null||method==""){
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
		}
	else if (method=="INSERT"){
		beforDS.removeAll();
		beforDS.newRecord();
		var win=L5.getCmp("updateWin");
		win.show();
		document.getElementById("addidCard").disabled=false;	
	}
	else if (method=="UPDATE"){
		var win=L5.getCmp("updateWin");
		win.show();
		beforDS.baseParams["ID@="]=idField;
		beforDS.load();
		beforDS.on('load',backBeforeAssMsg);
	}
	else{
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
	}
}

//人员姓名
var name;
//家庭Id
var familyId;
var peopleId;
//根据人员身份证号加载人员医前救助信息
function loadBeforeAssMsg(){
	if(getParam("addidCard")){
		var BaseinfoPeopleDataSet=L5.DatasetMgr.lookup("BaseinfoPeopleDataSet");
		//BaseinfoPeopleDataSet.setParameter("id_Card",getParam("idCard"));
		BaseinfoPeopleDataSet.baseParams["ID_CARD"]=getParam("addidCard");
		BaseinfoPeopleDataSet.baseParams["DOMICILE_CODE@like@String"]=organCode.substring(0,6);
	//	BaseinfoPeopleDataSet.setParameter("DOMICILE_CODE",organCode);
		BaseinfoPeopleDataSet.load();
		BaseinfoPeopleDataSet.on('load',setPeoInfo);
	}
}
//回填人员信息
function setPeoInfo(BaseinfoPeopleDataSet){
	if(BaseinfoPeopleDataSet.getCount()==0){
		L5.Msg.alert('提示',"未找到此人相关信息!");
		document.getElementById("addname").innerHTML="";
		document.getElementById("addidCard").value="";
		document.getElementById("addidCard").focus();
		return;
	}
	name=BaseinfoPeopleDataSet.get("name");
	familyId=BaseinfoPeopleDataSet.get("familyId");
	peopleId=BaseinfoPeopleDataSet.get("peopleId");
	document.getElementById("addname").innerHTML=name;
}
//记录当前修改信息的家庭人员相关信息
function backBeforeAssMsg(beforDS){
	document.getElementById("addidCard").disabled=true;	
	var record=beforDS.getCurrent();
	if(record){
		name=record.get("name");
		familyId=record.get("familyId");
		peopleId=record.get("peopleId");
	}
}
function save(){
    var records = beforDS.getAllChangedRecords();
	if(records==""&&method=="UPDATE"){
		L5.Msg.alert('提示','请填写修改信息，不修改请点击返回!');
		return false;
	}
	if(!name){
		L5.Msg.alert('提示','未找到此人相关信息!');
		return false;
	}
	//校验
	var valid = beforDS.isValidate();
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
	beforeCheckDS.setParameter("ID_CARD",getParam("addidCard"));
	beforeCheckDS.setParameter("PEOPLE_ID",peopleId);
	beforeCheckDS.setParameter("FAMILY_ID",familyId);
	beforeCheckDS.setParameter("STATUS",'1');
	beforeCheckDS.setParameter("ID@<>",records[0].get("id"));
	beforeCheckDS.load();
	beforeCheckDS.on('load',function(){
		if(beforeCheckDS.getCount()>0){
			L5.Msg.alert('提示',"已经给予此人医前救助!");
			document.getElementById("addname").innerHTML="";
			document.getElementById("addidCard").value="";
			document.getElementById("addidCard").focus();
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
			var ds=L5.DatasetMgr.lookup("ds")
			ds.setParameter("ASSITANCE_ORG_CODE",organCode);
			ds.load();
		}else{
			L5.Msg.alert('提示',"保存时出现错误！"+command.error);
		}
	});
	
}
//返回
 function back(){
	var win=L5.getCmp("updateWin");
	win.hide();
 }
//金额小数点位数处理
function checkAssMony(value){
	if(value){
		document.getElementById("assitanceMony").value=changeTwoDecimal(value);
	}
}




