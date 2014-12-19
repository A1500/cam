//列表显示dataset
var dataset;
//win窗口dataset
var winDataset;
//当前command
var command;
var method;
function init(){
	//得到当前路径
	var parths=document.location.pathname.split("/");
	currentJsp=parths[parths.length-1];
	//根据当前路径中的jsp文件名判断使用哪个Command和dataset
	if(currentJsp=="esureyHouseList.jsp"){
		dataset=houseDataset;
		command=new L5.Command("com.inspur.cams.drel.esurey.cmd.SamEsureyHouseCmd");
		winDataset=houseAddDataset;
		dataset.setParameter("people_Id",peopleId);
		dataset.setParameter("type",2);
		dataset.setParameter("feedback_Id",feedbackId);
		dataset.load();
	}else if(currentJsp=="esureyCarList.jsp"){
		dataset=carDataset;
		command=new L5.Command("com.inspur.cams.drel.esurey.cmd.SamEsureyCarCmd");
		winDataset=carAddDataset;
		dataset.setParameter("people_Id",peopleId);
		dataset.setParameter("type",2);
		dataset.setParameter("feedback_Id",feedbackId);
		dataset.load();
	}else if(currentJsp=="esureyBusinessList.jsp"){
		dataset=businessDataset;
		command=new L5.Command("com.inspur.cams.drel.esurey.cmd.SamEsureyBusinessCmd");
		winDataset=businessAddDataset;
		dataset.setParameter("people_Id",peopleId);
		dataset.setParameter("type",2);
		dataset.setParameter("feedback_Id",feedbackId);
		dataset.load();
	}else if(currentJsp=="esureyInsuranceList.jsp"){
		dataset=insuranceDataset;
		command=new L5.Command("com.inspur.cams.drel.esurey.cmd.SamEsureyInsuranceCmd");
		winDataset=insuranceAddDataset;
		dataset.setParameter("people_Id",peopleId);
		dataset.setParameter("type",2);
		dataset.setParameter("feedback_Id",feedbackId);
		dataset.load();
	}
}
function addMsg(){
	method="INSERT";
	if(win==undefined){
			var win=L5.getCmp("socialWin");
		}
		win=L5.getCmp("socialWin");
		win.show();
		if(currentJsp=="esureyHouseList.jsp"){
			winDataset.newRecord({
				owerIdCard:idCard,
				houseOwer:owerName
			});
		}else if(currentJsp=="esureyCarList.jsp"){
			winDataset.newRecord({
				owner:owerName
			});
		}else{
			winDataset.newRecord();
		}
		

}
//保存方法
function Evt_butsave_onclick(){
	var record=winDataset.getCurrent();
	record.set("type",2);
	record.set("peopleId",peopleId);
	record.set("feedbackId",feedbackId);
	//var command=new L5.Command("com.inspur.cams.drel.esurey.cmd.SamEsureySocialCmd");
	command.setParameter("record",record);
	command.error=undefined;
	if (method=="INSERT"){
		command.execute("insert");	
	}else{
		command.execute("update");
	}
	if (!command.error) {
		L5.Msg.alert('提示',"保存成功!");
		Evt_butreturn_onclick();
		dataset.setParameter("type",2);
		dataset.setParameter("people_Id",peopleId);
		dataset.setParameter("feedback_Id",feedbackId);
		dataset.load();
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
		command.error=undefined;
	}
}

//填写核对信息前校验提交状态方法
function checkCheckFlg(feedbackId){
	CheckFlagDataset.setParameter("feedback_Id",feedbackId);
	CheckFlagDataset.load();
	CheckFlagDataset.on('load',checkFLG);
	var records=winDataset.getAllChangedRecords();
}
function checkFLG(CheckFlagDataset){
	if(CheckFlagDataset.get("checkFlg")==1){
		L5.Msg.alert('提示',"核对信息已提交");
		return;
	}else{
		//显示社保信息录入窗口
		if(win==undefined){
			var win=L5.getCmp("socialWin");
		}
		win=L5.getCmp("socialWin");
		win.show();
		dataset.newRecord();
	}
}
//关闭社保信息录入窗口
function Evt_butreturn_onclick(){
	if(win==undefined){
		var win=L5.getCmp("socialWin");
	}
	win=L5.getCmp("socialWin");
	win.hide();
}
//根据组件的ID得到组件的value
function getParam(ElementId){
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
//提交方法
function Evt_butcheckin_onclick(){
	//if(dataset.getAllRecords().length=0){
	//	L5.Msg.alert('提示',"信息未录入，请先录入!");
	//	return;
	//}else{
	var estateRecord;
	if(currentJsp=="esureyHouseList.jsp"){
		estateRecord=estateDataset.newRecord();
		estateRecord.set("type",2);
		estateRecord.set("surveyId",surveyId);
		estateRecord.set("feedbackId",feedbackId);
		estateRecord.set("familyId",familyId);
		estateRecord.set("peopleId",peopleId);
		estateRecord.set("item",5);
		var houseRecords=dataset.getAllRecords();
		var num=0;
		for(n=0;n<houseRecords.length;n++){
			num=num+houseRecords[n].get("regValue")*1;
		}
		estateRecord.set("num",num);
		
	}else if(currentJsp=="esureyCarList.jsp"){
		estateRecord=estateDataset.newRecord();
		estateRecord.set("type",2);
		estateRecord.set("surveyId",surveyId);
		estateRecord.set("feedbackId",feedbackId);
		estateRecord.set("familyId",familyId);
		estateRecord.set("peopleId",peopleId);
		estateRecord.set("item",7);
		var carRecords=dataset.getAllRecords();
		var num=0;
		for(n=0;n<carRecords.length;n++){
			num=num+carRecords[n].get("regValue")*1;
		}
		estateRecord.set("num",num);
	}
	updateFeedback(feedbackId,estateRecord);
	//}
}
//更新提交标志
function updateFeedback(feedbackId,estateRecord){
	var command=new L5.Command("com.inspur.cams.drel.esurey.cmd.SamEsureyFeedbackCmd");
	command.setParameter("feedbackId",feedbackId);
	command.setParameter("checkId",checkId);
	command.setParameter("checkPeople",checkPeople);
	command.setParameter("checkOrg",checkOrg);
	command.setParameter("estateRecord",estateRecord);
	command.execute("updateCheckFlg");	
	if (!command.error) {
		L5.Msg.alert('提示',"提交成功!");
		var url='jsp/ext/esurey/manage/'+frontJsp;
		L5.forward(url);
	}else{
		L5.Msg.alert('提示',"提交时出现错误！"+command.error);
		command.error=undefined;
	}
}
//修改
function Evt_modify_onclick(){
	method="UPDATE"
	var editGrid=L5.getCmp('editGridPanel');
	selected = editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	if(win==undefined){
		var win=L5.getCmp("socialWin");
	}
	win=L5.getCmp("socialWin");
	win.show();
	winDataset.setParameter("id",selected[0].get("id"));
	winDataset.load();
}
//删除方法
function Evt_butremove_onclick(){
	var editGrid=L5.getCmp('editGridPanel');
	selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
				if(state=="yes"){
					var  delIds=[];
					for(var i=0;i<selected.length;i++){
						delIds[i]=selected[i].get("id");
					}
					command.setParameter("delIds", delIds);
					command.execute("delete");
					if (!command.error) {
						L5.Msg.alert('提示',"删除成功！");
						dataset.setParameter("people_Id",peopleId);
						dataset.setParameter("type",2);
						dataset.setParameter("feedback_Id",feedbackId);
						dataset.load();
					}else{
						L5.Msg.alert('提示',"保存时出现错误！"+command.error);
						command.error=undefined;
					}
				}else{
					return false;
				}
			});
}
//返回
function Evt_return_onclick(){
	var url='jsp/ext/esurey/manage/'+frontJsp;
	L5.forward(url);
}
//检验身份证号码和唯一性
function check_IdCard(){
	if(_$("owerIdCardIn") != ""){
		if(checkIDCard($("owerIdCardIn")) == true){
		//困难家庭的唯一性
		
		
		}else{
			L5.Msg.alert("提示","校验未通过："+"身份证号不合法");
			$("owerIdCardIn").value="";
			$("owerIdCardIn").focus();
			return;
		}
	}
}

//金额数字校验并处理
function  checkMoney(ElementId){
	var value=document.getElementById(ElementId).value;
	if(value){
		if(!_isNum(value)){
			L5.Msg.alert('提示',"请输入数字");
			document.getElementById(ElementId).value="";
			return;
		}
		document.getElementById(ElementId).value=formatNum(value);
	}
}