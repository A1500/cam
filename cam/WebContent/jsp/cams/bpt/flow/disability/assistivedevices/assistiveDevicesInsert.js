var peopleId;
var familyId;
var devRecord;
function init(){
 	var AssistiveDevicesDataset = L5.DatasetMgr.lookup("AssistiveDevicesDataset");
 	AssistiveDevicesDataset.newRecord();
	L5.QuickTips.init();
}

function save(){
	
	
	var AssistiveDevicesDataset = L5.DatasetMgr.lookup("AssistiveDevicesDataset");
	var AssistiveDevicesRecord=AssistiveDevicesDataset.getCurrent();
	var isValidate = AssistiveDevicesDataset.isValidate();
	if(isValidate != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+isValidate);
		return false;
	}
	var applyApparatusId = document.getElementById("applyApparatusId").value;
	if(applyApparatusId==''){
		L5.Msg.alert('提示',"申请器械不能为空!");
		return false;
	}
	
	
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyAssistiveDevicesCommand");
	command.setParameter("record", AssistiveDevicesRecord);
	command.setParameter("records", devRecord);
	command.execute("insert");
	var applyId = command.getReturn("applyId");
	if (!command.error) {
		AssistiveDevicesDataset.commitChanges();
		window.returnValue = peopleId + ";" + familyId+";"+applyId;
		window.close();
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
	
	
}

/*function updatePeopleDevices(applyId){
	
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyAssistiveDevicesCommand");
	command.setParameter("records", devRecord);
	command.setParameter("applyId", applyId);
	command.execute("updatePeopleDevices");
	if (!command.error) {
		
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}*/

//选择器械
function selectDevices(){
	var applyApparatusId = document.getElementById("applyApparatusId").value;
	var url = "devicesSelect.jsp?applyApparatusId="+applyApparatusId;
	revalue = window.showModalDialog(url,"","dialogHeight:400px;dialogWidth:388px;resizable:no;scroll:no;");
	if (revalue!=undefined&&revalue.idAndName != "" && revalue.idAndName != undefined) {
		var list = revalue.idAndName.split(";");
		AssistiveDevicesDataset.getCurrent().set("applyApparatusId", list[0]);
		AssistiveDevicesDataset.getCurrent().set("apparatusName", list[1]);
		DevicesDataset.removeAll();
		for(var i=0;i<revalue.record.length;i++){ 
			
			DevicesDataset.newRecord({"applyApparatusId":revalue.record[i].data.applyApparatusId,"unit":revalue.record[i].data.unit,
				"apparatusName":revalue.record[i].data.apparatusName,"num":revalue.record[i].data.num});
	    } 
		devRecord =DevicesDataset.getAllRecords();
		
	}
	if(revalue==";;;;;;;"){
		devRecord="";
		
		AssistiveDevicesDataset.getCurrent().set("applyApparatusId", "");
		AssistiveDevicesDataset.getCurrent().set("apparatusName", "");
	}
}


 function back(){	 	
	window.close();
 }


//创建并发起流程
function createAndSend(){
	if(validateNotNull()){
	   if(checkProcessState("createAndSend")){
	   		var AssistiveDevicesDataset = L5.DatasetMgr.lookup("AssistiveDevicesDataset");
			var AssistiveDevicesRecord=AssistiveDevicesDataset.getCurrent();
	      var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyAssistiveDevicesCommand");
	      command.setParameter("record", AssistiveDevicesRecord);
	      command.execute("createAndSend");
	      if(!command.error){
		   alert("流程发起并发送成功!");
		   //跳转到已办任务页面
		   var url = "jsp/workflow/tasklist/queryyiban.jsp";
		   L5.forward(url,"已办任务页面");
	     }else{
	      alert(command.error);
	     }
	   }
	}
}

//选择人员信息 并带出相关信息
function selectPeople(){
	var width = screen.width-100;
	var height = screen.height-140;
	var revalue =  window.showModalDialog("selectPerson.jsp","","dialogHeight:"+height+"px;dialogWidth:"+width+"px;resizable:no;scroll:yes;");
	if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
		peopleId = list[0];
		familyId = list[8];
		document.getElementById("name").value = list[1];
		document.getElementById("sex").value = list[2];
		document.getElementById("idCard").value = list[3];
		document.getElementById("objectType").value = list[4];
		document.getElementById("disabilityLevel").value = list[5];
		document.getElementById("disabilityGenus").value = list[6];
		document.getElementById("disabilityNo").value = list[7];
		
		AssistiveDevicesDataset.getCurrent().set("peopleId",list[0]);
		AssistiveDevicesDataset.getCurrent().set("name",list[1]);
		AssistiveDevicesDataset.getCurrent().set("sex",list[2]);
		AssistiveDevicesDataset.getCurrent().set("idCard",list[3]);
		AssistiveDevicesDataset.getCurrent().set("objectType",list[4]);
		AssistiveDevicesDataset.getCurrent().set("disabilityLevel",list[5]);
		AssistiveDevicesDataset.getCurrent().set("disabilityGenus",list[6]);
		AssistiveDevicesDataset.getCurrent().set("disabilityNo",list[7]);
		if(list[9]!='undefined'&&list[9]!=''){
			document.getElementById("disabilityCase").value = list[9];
			AssistiveDevicesDataset.getCurrent().set("disabilityCase",list[9]);
		}
		if(list[10]!='undefined'&&list[10]!=''){
			document.getElementById("address").value = list[10];
			AssistiveDevicesDataset.getCurrent().set("address",list[10]);
		}
		if(list[11]!='undefined'&&list[11]!=''){
			document.getElementById("telMobile").value = list[11];
			AssistiveDevicesDataset.getCurrent().set("telMobile",list[11]);
		}
	}
}
