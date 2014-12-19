var  orgName ;
function init() {	
	var retiredSoldierDataset=L5.DatasetMgr.lookup("retiredSoldierDataset");
	retiredSoldierDataset.baseParams["SOLDIERS_ID@="]=idField;
	retiredSoldierDataset.load();
	var prssoldiersArmyDataset=L5.DatasetMgr.lookup("prssoldiersArmyDataset");
	prssoldiersArmyDataset.baseParams["SOLDIERS_ID@="]=idField;
	prssoldiersArmyDataset.load();
	var prsawardsmeritoriousDataset=L5.DatasetMgr.lookup("prsawardsmeritoriousDataset");
	prsawardsmeritoriousDataset.baseParams["SOLDIERS_ID@="]=idField;
	prsawardsmeritoriousDataset.load();
	var OrgNameDataset = L5.DatasetMgr.lookup("OrgNameDataset");
	OrgNameDataset.setParameter("filterSql","id='"+orgCode+"'");
	OrgNameDataset.load();
	OrgNameDataset.on("load",function() {
	orgName = OrgNameDataset.get("text");
});
}
function approval(){
	
	var retiredSoldierDataset=L5.DatasetMgr.lookup("retiredSoldierDataset");
	var recordSoldier = retiredSoldierDataset.getCurrent();
	recordSoldier.set("flag",1);
	
	var prssoldiersArmyDataset=L5.DatasetMgr.lookup("prssoldiersArmyDataset");
	var recordArmy = prssoldiersArmyDataset.getCurrent();
	
	var prsawardsmeritoriousDataset = L5.DatasetMgr.lookup("prsawardsmeritoriousDataset");
	
	var isValidate = prsawardsmeritoriousDataset.isValidate();
	if(isValidate != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+isValidate);
		return false;
	}
	
	
	var isValidate = retiredSoldierDataset.isValidate(true);
    if(isValidate !== true){
    	L5.Msg.alert("提示","校验未通过,不能保存!"+isValidate);
        return false;
    }
    
     isValidate = prssoldiersArmyDataset.isValidate(true);
    if(isValidate !== true){
    	L5.Msg.alert("提示","校验未通过,不能保存!"+isValidate);
        return false;
    }
    
    var awardRecords = prsawardsmeritoriousDataset.getAllRecords();
    var command= new L5.Command("com.inspur.cams.prs.prsretiredsoldiers.cmd.PrsRetiredSoldiersCommand");
	command.setParameter("recordSoldier", recordSoldier);
	command.setParameter("recordArmy", recordArmy);
	command.setParameter("records", awardRecords);
    command.execute("updateBaseInfo");
    if (!command.error) {
    	var data = new L5.Map();
    	data.put("method","UPDATE");
    	data.put("idField",idField);
    	var url='jsp/cams/prs/prsretiredsoldiers/prsretiredsoldiers_detail.jsp';
		var text = '退役士兵修改';
		L5.forward(url,text,data);
	}else{
		L5.Msg.alert("错误","保存失败");
	}
	
}

function save(){

	var retiredSoldierDataset=L5.DatasetMgr.lookup("retiredSoldierDataset");
	var recordSoldier = retiredSoldierDataset.getCurrent();
	recordSoldier.set("flag",0);
	
	var prssoldiersArmyDataset=L5.DatasetMgr.lookup("prssoldiersArmyDataset");
	var recordArmy = prssoldiersArmyDataset.getCurrent();
	
	var prsawardsmeritoriousDataset = L5.DatasetMgr.lookup("prsawardsmeritoriousDataset");
	
	var isValidate = prsawardsmeritoriousDataset.isValidate();
	if(isValidate != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+isValidate);
		return false;
	}
	
	
	var isValidate = retiredSoldierDataset.isValidate(true);
    if(isValidate !== true){
    	L5.Msg.alert("提示","校验未通过,不能保存!"+isValidate);
        return false;
    }
    
     isValidate = prssoldiersArmyDataset.isValidate(true);
    if(isValidate !== true){
    	L5.Msg.alert("提示","校验未通过,不能保存!"+isValidate);
        return false;
    }
    var idCard = document.getElementById("idcardNo");
    if(!checkIDCard(idCard)){
	    L5.Msg.alert("提示", "身份证格式不正确!");
	    return false;
	}
    
 	var awardRecords = prsawardsmeritoriousDataset.getAllRecords();
    var command= new L5.Command("com.inspur.cams.prs.prsretiredsoldiers.cmd.PrsRetiredSoldiersCommand");
	command.setParameter("recordSoldier", recordSoldier);
	command.setParameter("recordArmy", recordArmy);
	command.setParameter("records", awardRecords);
    command.execute("updateBaseInfo");
   
    if (!command.error) {
    	history.go(-1);
	}else{
		L5.Msg.alert("错误","保存失败");
	}
	
}

function del() {
	var editGrid=L5.getCmp('awardGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
		if(state=="yes"){
			for(var i=0;i<selected.length;i++){
			    prsawardsmeritoriousDataset.remove(selected[i]);
			}
			prsawardsmeritoriousDataset.commitChanges();
		}
	});
}
function reset() {
	prsawardsmeritoriousDataset.rejectChanges();
}

function insert() {
	var record = prsawardsmeritoriousDataset.getCurrent();
	if(record==null){
		prsawardsmeritoriousDataset.newRecord();
		record = prsawardsmeritoriousDataset.getCurrent();
	}else{
		var times =record.get("awardsNumber");
		if(isNaN(times)||times==''){
			L5.Msg.alert('提示',"获奖次数格式不正确,不能保存! ");
	
		}else{
			prsawardsmeritoriousDataset.newRecord();	
			var Grid = L5.getCmp('awardGridPanel');
			Grid.stopEditing();
		}
	}
	
}

function getServicedTime(){
	var retiredSoldierDataset=L5.DatasetMgr.lookup("retiredSoldierDataset");
	var recordSoldier = retiredSoldierDataset.getCurrent();
	var timeStart = recordSoldier.get("enlistTime").split("-")[0];
	var timeEnd =recordSoldier.get("retiredTime"). split("-")[0];
	var servicedtime = timeEnd - timeStart+1;
	recordSoldier.set("servicedTime",servicedtime);
	document.getElementById("servicedTime").value=servicedtime;
}

function back()
 {	
 	history.go(-1);
 }
 
 function forHelp() {
	// var struId='<%=struId%>';
	var revalue=window.showModalDialog(L5.webPath+"/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=0&level=2&organCode="+orgCode+"&organName="+orgName,"","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("domicileCode").value = list[0];
		document.getElementById("domicileName").value = list[1];
		var retiredSoldierDataset = L5.DatasetMgr
				.lookup("retiredSoldierDataset");
		var recordSoldier = retiredSoldierDataset.getCurrent();
		if(list[0].substring(6)=="999000"){
      		recordSoldier.set("wherePlacemen", list[0].substring(0,6)+"000000");
      		recordSoldier.set("domicileName", list[4]);
    	}else{
      		recordSoldier.set("wherePlacemen", list[0]);
      		recordSoldier.set("domicileName", list[4]);
    	}
	}
 }

  function func_ForDomicileSelect() {
	var retiredSoldierDataset = L5.DatasetMgr.lookup("retiredSoldierDataset");
	var recordSoldier = retiredSoldierDataset.getCurrent();
	var revalue=window.showModalDialog(L5.webPath+"/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=0&level=2&organCode=370000000000&organName=山东省","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		recordSoldier.set("enlistPlace",list[0]);
		recordSoldier.set("enlistPlaceName",list[1]);
	}
}

function func_QueryIdCard(){
	var retiredSoldierDataset = L5.DatasetMgr.lookup("retiredSoldierDataset");
	var idCard = document.getElementById("idcardNo");
	var idCardValue = idCard.value;
	 if(idCardValue==null||idCardValue=="")
    {
    	return;
    }
	if(!checkIDCard(idCard)){
	    L5.Msg.alert("提示", "身份证格式不正确!");
	    return false;
	}
	 var birthdayValue; 
   if(15==idCardValue.length){ //15位身份证号码 
       birthdayValue = idCardValue.charAt(6)+idCardValue.charAt(7); 
       if(parseInt(birthdayValue)<10){ 
           birthdayValue = '20'+birthdayValue; 
       }else { 
           birthdayValue = '19'+birthdayValue; 
       } 
           birthdayValue=birthdayValue+'-'+idCardValue.charAt(8)+idCardValue.charAt(9)+'-'+idCardValue.charAt(10)+idCardValue.charAt(11);
           retiredSoldierDataset.getCurrent().set("birthday",birthdayValue);
    } 
   if(18==idCardValue.length){ //18位身份证号码 
           birthdayValue=idCardValue.charAt(6)+idCardValue.charAt(7)+idCardValue.charAt(8)+idCardValue.charAt(9)+'-'+idCardValue.charAt(10)+idCardValue.charAt(11)+'-'+idCardValue.charAt(12)+idCardValue.charAt(13);
           retiredSoldierDataset.getCurrent().set("birthday",birthdayValue);
   } 
}