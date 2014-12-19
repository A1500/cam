var  orgName ;
function init() {
var OrgNameDataset = L5.DatasetMgr.lookup("OrgNameDataset");
OrgNameDataset.setParameter("filterSql","id='"+orgCode+"'");
OrgNameDataset.load();
OrgNameDataset.on("load",function() {
	orgName = OrgNameDataset.get("text");
});

	var retiredSoldierDataset = L5.DatasetMgr.lookup("retiredSoldierDataset");
	retiredSoldierDataset.newRecord();
	var recordSoldier = retiredSoldierDataset.getCurrent();
	recordSoldier.set("retiredSoldierType", type);
	recordSoldier.set("sex", "1");
	recordSoldier.set("naton", "01");
	recordSoldier.set("placemenRenson", "1");
	recordSoldier.set("transFile", "档案");
	recordSoldier.set("uploadFlag", "0");
	recordSoldier.set("disabilityFlag", "0");
	recordSoldier.set("trainingflag", "0");
	recordSoldier.set("emplacementflag", "0");
	recordSoldier.set("allotFlag", '0');
	var prssoldiersArmyDataset = L5.DatasetMgr.lookup("prssoldiersArmyDataset");
	prssoldiersArmyDataset.newRecord();
	var prsawardsmeritoriousDataset = L5.DatasetMgr.lookup("prsawardsmeritoriousDataset");
	prsawardsmeritoriousDataset.newRecord();
	var awardGrid = L5.getCmp('awardGridPanel')
	awardGrid.stopEditing();
	document.getElementById("flag").value = '1';
}

function save() {
	var retiredSoldierDataset = L5.DatasetMgr.lookup("retiredSoldierDataset");
	var recordSoldier = retiredSoldierDataset.getCurrent();
	var flag = document.getElementById("flag").value;
	if(flag =='2'){
		L5.MessageBox.confirm('确定', '确定要将选中的记录退档吗?', function(state) {
				if (state == "yes") {
					recordSoldier.set("flag", '2');
				}else{
					recordSoldier.set("flag", '1');
				}
				var prssoldiersArmyDataset = L5.DatasetMgr.lookup("prssoldiersArmyDataset");
				var recordArmy = prssoldiersArmyDataset.getCurrent();

				retiredSoldierDataset.set("soldiersId", soldierID);
				prssoldiersArmyDataset.set("armyId", armyId);
				prssoldiersArmyDataset.set("soldiersId", soldierID);

				var prsawardsmeritoriousDataset = L5.DatasetMgr.lookup("prsawardsmeritoriousDataset");

				var isValidate = retiredSoldierDataset.isValidate(true);
				if (isValidate !== true) {
					L5.Msg.alert("提示", "校验未通过,不能保存!" + isValidate);
					return false;
				}

				isValidate = prssoldiersArmyDataset.isValidate(true);
				if (isValidate !== true) {
					L5.Msg.alert("提示", "校验未通过,不能保存!" + isValidate);
					return false;
				}
				var isValidate = prsawardsmeritoriousDataset.isValidate();
				if (isValidate != true) {
					L5.Msg.alert('提示', "校验未通过,不能保存!" + isValidate);
					return false;
				}

				var awardRecords = prsawardsmeritoriousDataset.getAllChangedRecords();

				var command = new L5.Command("com.inspur.cams.prs.prsretiredsoldiers.cmd.PrsRetiredSoldiersCommand");
				command.setParameter("recordSoldier", recordSoldier);
				command.setParameter("recordArmy", recordArmy);
				command.setParameter("records", awardRecords);
				command.execute("saveBaseInfou");

				if (!command.error) {
					history.go(-1);
				} else {
					L5.Msg.alert("错误", "保存失败");
				}
			});
	}else{
		recordSoldier.set("flag", '1');
		recordSoldier.set("servicedTime",getServicedTime());
		var prssoldiersArmyDataset = L5.DatasetMgr.lookup("prssoldiersArmyDataset");
		var recordArmy = prssoldiersArmyDataset.getCurrent();

		retiredSoldierDataset.set("soldiersId", soldierID);
		prssoldiersArmyDataset.set("armyId", armyId);
		prssoldiersArmyDataset.set("soldiersId", soldierID);

		var prsawardsmeritoriousDataset = L5.DatasetMgr.lookup("prsawardsmeritoriousDataset");

		var isValidate = retiredSoldierDataset.isValidate(true);
		if (isValidate !== true) {
			L5.Msg.alert("提示", "校验未通过,不能保存!" + isValidate);
			return false;
		}

		isValidate = prssoldiersArmyDataset.isValidate(true);
		if (isValidate !== true) {
			L5.Msg.alert("提示", "校验未通过,不能保存!" + isValidate);
			return false;
		}
		var isValidate = prsawardsmeritoriousDataset.isValidate();
		if (isValidate != true) {
			L5.Msg.alert('提示', "校验未通过,不能保存!" + isValidate);
			return false;
		}

		var awardRecords = prsawardsmeritoriousDataset.getAllChangedRecords();
serveTime();
		var command = new L5.Command("com.inspur.cams.prs.prsretiredsoldiers.cmd.PrsRetiredSoldiersCommand");
		command.setParameter("recordSoldier", recordSoldier);
		command.setParameter("recordArmy", recordArmy);
		command.setParameter("records", awardRecords);
		command.execute("saveBaseInfou");

		if (!command.error) {
		L5.Msg.alert("提示","保存成功！",function(){
			var data = new L5.Map();
			data.put("method", "UPDATE");
			data.put("idField", soldierID);
			data.put("type",recordSoldier.get("retiredSoldierType"));
			var url = 'jsp/cams/prs/prsretiredsoldiers/prsretiredsoldiers_detail.jsp';
			var text = '退役士兵修改';
			L5.forward(url, text, data);
			});
		} else {
			L5.Msg.alert("错误", "保存失败");
		}
	}



}
function del() {
	var editGrid = L5.getCmp('awardGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length < 1) {
		L5.Msg.alert('提示', "请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?', function(state) {
				if (state == "yes") {
					for (var i = 0; i < selected.length; i++) {
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
	if (record == null) {
		prsawardsmeritoriousDataset.newRecord();
		record = prsawardsmeritoriousDataset.getCurrent();
	} else {
		var times = record.get("awardsNumber");
		if (isNaN(times) || times == '') {
			L5.Msg.alert('提示', "获奖次数格式不正确,不能保存! ");

		} else {
			prsawardsmeritoriousDataset.newRecord();
			var Grid = L5.getCmp('awardGridPanel');
			Grid.stopEditing();
		}
	}

}


function getServicedTime() {
	var retiredSoldierDataset = L5.DatasetMgr.lookup("retiredSoldierDataset");
	var recordSoldier = retiredSoldierDataset.getCurrent();
	var timeStart = recordSoldier.get("enlistTime").split("-")[0];
	var timeEnd = recordSoldier.get("retiredTime").split("-")[0];
	var servicedtime = timeEnd - timeStart;
	if(servicedtime<=0){
		servicedtime=1;
	}
	document.getElementById("servicedTime").value = servicedtime;
	return servicedtime;
}

function back() {
	history.go(-1);
}
function forHelp() {
	// var struId='<%=struId%>';
	var organName="山东省";
	var revalue=window.showModalDialog(L5.webPath+"/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=0&level=2&organCode="+orgCode+"&organName="+encodeURIComponent(encodeURIComponent(organName)),"","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");

	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		alert(list);
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

function func_sergeantLevel()
{
	var soldierType = document.getElementById("retiredSoldierType").value;
	if(soldierType =='0'){
		document.getElementById("sergeantLevel").disabled=true ;
		document.getElementById("sergeantLevel").value='';
	}else{
		document.getElementById("sergeantLevel").disabled=false ;
	}
}
function changeLevel(){
	var ifmental = document.getElementById("mentalGrade").value;
	var injuringGrade = document.getElementById("injuringGrade");
	if(ifmental =="1" ){
		injuringGrade.options.length = 0;
		var varItem = new Option("请选择... ","");      
        injuringGrade.options.add(varItem); 
		var varItem = new Option("一级","1");      
        injuringGrade.options.add(varItem); 
       	var varItem = new Option("二级","2");      
        injuringGrade.options.add(varItem);  
        var varItem = new Option("三级","3");   
        injuringGrade.options.add(varItem);  
        var varItem = new Option("四级","4");      
        injuringGrade.options.add(varItem);  
        var varItem = new Option("五级","5");      
        injuringGrade.options.add(varItem);  
       	var varItem = new Option("六级","6");      
        injuringGrade.options.add(varItem);      
	}else if(ifmental =="0"){
		injuringGrade.options.length = 0;
		var varItem = new Option("请选择... ","");      
        injuringGrade.options.add(varItem);
		var varItem = new Option("一级","1");      
        injuringGrade.options.add(varItem); 
       	var varItem = new Option("二级","2");      
        injuringGrade.options.add(varItem);  
        var varItem = new Option("三级","3");   
        injuringGrade.options.add(varItem);  
        var varItem = new Option("四级","4"); 
        injuringGrade.options.add(varItem);      
	}
}