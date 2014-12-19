function init() {
	if (method == null || method == "") {
		L5.Msg.alert('提示', "未知的页面命令!");
		back();
	} else if (method == "INSERT") {
		BaseinfoPeopleDataSet.newRecord({peopleId : document.forms[0].peopleId.value,familyId : document.forms[0].familyId.value});
		var BaseinfoFamilyDataSet = L5.DatasetMgr.lookup("BaseinfoFamilyDataSet");
		BaseinfoFamilyDataSet.newRecord({familyId : document.forms[0].familyId.value});
		var DemobilizedIllnessDataset = L5.DatasetMgr.lookup("DemobilizedIllnessDataset");
		DemobilizedIllnessDataset.newRecord({peopleId : document.forms[0].peopleId.value});
		DemobilizedIllnessDataset.set("demobilizedStateCode",1);
		DemobilizedIllnessDataset.set("supportPattern",1);
		var typeInfo =L5.getCmp("typeInfo");
		typeInfo.on("activate",func_BankName);
		return;
	} 
}
function func_BankName(){
  DemobilizedIllnessDataset.set("accountName",BaseinfoPeopleDataSet.get("name"));
}

function Evt_butPrev_click(e) {
	var dataset = L5.DatasetMgr.lookup("BaseinfoPeopleDataSet");
	if(dataset.movePrev()){
				
	  	BptPeopleDisabilityDataSet.baseParams["PEOPLE_ID@="] = document.forms[0].peopleId.value;
		BptPeopleDisabilityDataSet.load();
		if(e)e.stopEvent();
		return true;
	}
	return false;
}

function Evt_butNext_click(e) {
	var dataset = L5.DatasetMgr.lookup("BaseinfoPeopleDataSet");
	if(dataset.moveNext()){
	
		BptPeopleDisabilityDataSet.baseParams["PEOPLE_ID@="] = document.forms[0].peopleId.value;
		BptPeopleDisabilityDataSet.load();
		if(e)e.stopEvent();
		return true;
	}
	return false;

}

function removeBptPeopleDisability() {
	var editGrid=L5.getCmp('BptPeopleDisabilityEditGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
		if(state=="yes"){
			var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptPeopleDisabilityCommand");
			for(var i=0;i<selected.length;i++){
				var delId=selected[i].get("peopleId");				
				command.setParameter("delId", delId);
				command.execute("delete");
				BptPeopleDisabilityDataSet.remove(selected[i]);
			}
			
		}else{
			return false;
		}
	});
}

function insertClick(e){
	document.getElementById("peopleId").readOnly=false;
	var dataset = L5.DatasetMgr.lookup("BaseinfoPeopleDataSet");
	//如果某必填数据为"",不再继续增加
	if(dataset.getCount()>0 && document.forms[0].peopleId.value.trim()==""){
		return;
	}
	dataset.newRecord();
	dataset.moveTo(dataset.getCount()-1);
	
	BptPeopleDisabilityDataSet.baseParams["PEOPLE_ID@="]="-" ;
	BptPeopleDisabilityDataSet.load();

}
function deleteClick(e){
	L5.MessageBox.confirm('确定', '你确定要删除吗？',function(sta){
		if(sta=="yes"){
			var BaseinfoPeopleDataSet = L5.DatasetMgr.lookup("BaseinfoPeopleDataSet");
			var BaseinfoPeopleRecord=BaseinfoPeopleDataSet.getCurrent();
			var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptBaseinfoPeopleCommand");
			var  delIds=[];
			delIds[0]= BaseinfoPeopleRecord.get("peopleId");
			command.setParameter("delIds",delIds);
			command.execute("delete");
			if (!command.error) {
				BaseinfoPeopleDataSet.remove(BaseinfoPeopleRecord);
				if(!Evt_butNext_click()){
					Evt_butPrev_click();
				}
				L5.Msg.alert('提示','删除成功！');
				var url='jsp/bpt/disability/baseinfopeople_list.jsp';
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
	var img=document.getElementById("photoTemp").value;
    var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptPeopleDemobilizedIllnessCommand");
	//人员信息
	var BaseinfoPeopleDataSet = L5.DatasetMgr.lookup("BaseinfoPeopleDataSet");
	var BaseinfoPeopleRecord=BaseinfoPeopleDataSet.getCurrent();
	BaseinfoPeopleRecord.set('photoTemp',img);
	//类别信息
	var DemobilizedIllnessDataset = L5.DatasetMgr.lookup("DemobilizedIllnessDataset");
	var DemobilizedIllnessRecord=DemobilizedIllnessDataset.getCurrent();
	//新增人员信息
	if(BaseinfoPeopleRecord.get("peopleId")==""&&BaseinfoPeopleRecord.get("familyId")==""){
	   BaseinfoPeopleRecord.set("peopleId",peopleId);
	   BaseinfoPeopleRecord.set("familyId",familyId);
	   DemobilizedIllnessRecord.set("peopleId",peopleId);
	}else{//修改人员信息
	   DemobilizedIllnessRecord.set("peopleId",BaseinfoPeopleRecord.get("peopleId"));
	   peopleId = BaseinfoPeopleRecord.get("peopleId");
	   familyId = BaseinfoPeopleRecord.get("familyId");
	}
	
	var idCard = document.getElementById("idCard");
   if(!checkIDCard(idCard)){
	    L5.Msg.alert("提示", "身份证格式不正确!");
	    return false;
   }
   
    //校验属地行政规划
	var domicileCode = BaseinfoPeopleRecord.get("domicileCode");
	if(domicileCode==''){
		 L5.Msg.alert('提示','属地行政规划不能为空！');
		 return false;
	}
	//校验住址行政规划
	var apanageCode = BaseinfoPeopleRecord.get("apanageCode");
	if(apanageCode==''){
		 L5.Msg.alert('提示','地址行政规划不能为空！');
		 return false;
	}
	//校验户籍类别
	var domicileType = BaseinfoPeopleRecord.get("domicileType");
	if(domicileType==''){
		 L5.Msg.alert('提示','户籍类别不能为空！');
		 return false;
	}
	if(document.getElementById("safeguardType").value==""){
	    L5.Msg.alert("提示", "请选择医疗保障方式!");
		return false;
	}
	var isValidate = BaseinfoPeopleDataSet.isValidate();
	if (isValidate != true) {
		L5.Msg.alert("提示", isValidate);
		return false;
	}
	
	//if(phoneticCode == null || phoneticCode == "" ) {
	//	L5.Msg.alert("提示","姓名拼音码不能为空!");
	//	return false;
	//}
	getCrjCnStrSpell('namebase','phoneticCode','m');
		var phoneticCode=document.getElementById("phoneticCode").value;
			BaseinfoPeopleRecord.set('phoneticCode',phoneticCode);
			
	if(L5.getDom("insanityFlag")==null||L5.getDom("insanityFlag")=="")
	{
		 L5.Msg.alert('提示','请录入类别信息后再保存！');
		 return false;
	}
	// 带病回乡退伍军人信息验证
	DemobilizedIllnessRecord.set("peopleId",document.forms[0].peopleId.value);
	var isValidate = DemobilizedIllnessDataset.isValidate();
	if(isValidate != true){
		L5.Msg.alert("提示",isValidate);
		return false;
	}

	
	var approvalDate = DemobilizedIllnessRecord.get("approvalDate");
	if(approvalDate!=''&&!validateDateFormat(approvalDate)){
		L5.Msg.alert("提示","审批时间格式不正确！");
		return false;
	}
	
	var conscriptDate = DemobilizedIllnessRecord.get("conscriptDate");
	if(conscriptDate!=''&&!validateDateFormat(conscriptDate)){
		L5.Msg.alert("提示","入伍时间格式不正确！");
		return false;
	}
	
	var decruitmentDate = DemobilizedIllnessRecord.get("decruitmentDate");
	if(decruitmentDate!=''&&!validateDateFormat(decruitmentDate)){
		L5.Msg.alert("提示","退伍时间格式不正确！");
		return false;
	}
	
	var idCard = BaseinfoPeopleDataSet.get("idCard");
	if(!writeAble(idCard,"42",true)){
		L5.Msg.alert('提示', '该人员已经是带病回乡人员！');
		return false;
	}
	DemobilizedIllnessRecord.set("demobilizedStateCode",1);
	command.setParameter("flag",document.forms[0].flag.value);
	command.setParameter("BaseinfoPeopleRecord", BaseinfoPeopleRecord);
	command.setParameter("DemobilizedIllnessRecord", DemobilizedIllnessRecord);
	command.setParameter("ifApplyAdd","applyAdd");
	command.execute("insert");
	
	if (!command.error) {
 		
		//var data = new L5.Map();
	//	peopleId=BaseinfoPeopleRecord.get("peopleId");
	//	familyId=BaseinfoPeopleRecord.get("familyId");
	//	var url=L5.webPath+'/jsp/cams/bpt/flow/demobilizedillness/applydemobilizedillness/demobilizedIllnessUpdateManage.jsp?peopleId='+peopleId+'&familyId='+familyId;
	//	var text = "带病回乡退伍军人信息表";
		//window.returnValue = peopleId+";"+familyId;
	//	var width = screen.width-100;
	//   var height = screen.height-140;
		//var win = window.showModalDialog (url,window,"scroll:no;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
		var peopleId1 = command.getReturn("peopleId");
		var familyId1 = command.getReturn("familyId");
	   var applyId = command.getReturn("applyId");
	    window.returnValue = peopleId1+";"+familyId1+";"+applyId;
		window.close();
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}

//关闭
function func_Close(){
	window.close();
}

function submit() {
	var records = BptPeopleDisabilityDataSet.getAllChangedRecords();
	if(records.length<1){
		L5.Msg.alert('提示','没有需要保存的数据！');
		return false;
	}
	var command = new L5.Command("com.inspur.cams.bpt.disability.cmd.BptPeopleDisabilityCommand");
	command.setParameter("bptpeopledisabilityRecords", records);
	command.execute("save");
	if (!command.error) {
		BptPeopleDisabilityDataSet.commitChanges();
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
function undo() {
	BptPeopleDisabilityDataSet.rejectChanges();
}

function showBirthday() 
{ 
   var val=document.forms[0].idCard.value;
   var birthdayValue; 
   if(15==val.length){ //15位身份证号码 
       birthdayValue = val.charAt(6)+val.charAt(7); 
       if(parseInt(birthdayValue)<10){ 
           birthdayValue = '20'+birthdayValue; 
       }else { 
           birthdayValue = '19'+birthdayValue; 
       } 
           birthdayValue=birthdayValue+'-'+val.charAt(8)+val.charAt(9)+'-'+val.charAt(10)+val.charAt(11);
           BaseinfoPeopleDataSet.getCurrent().set("birthday",birthdayValue);
    } 
   if(18==val.length){ //18位身份证号码 
           birthdayValue=val.charAt(6)+val.charAt(7)+val.charAt(8)+val.charAt(9)+'-'+val.charAt(10)+val.charAt(11)+'-'+val.charAt(12)+val.charAt(13);
           BaseinfoPeopleDataSet.getCurrent().set("birthday",birthdayValue);
          
   } 
}
function func_Type(){
  if(document.getElementById("domicileType").value=='1'){
     document.getElementById("work").style.display='none';
     document.getElementById("workAddress").style.display='none';
     document.getElementById("employmentCode").disabled=true;
  }else{
     document.getElementById("work").style.display='';
     document.getElementById("workAddress").style.display='';
     document.getElementById("employmentCode").disabled=false;
  }
}

function func_Close(){
	window.close();
}
/**
 * 选择健康状况
 */
function func_HealthSelect() {

	var revalue = window.showModalDialog(
			L5.webPath + "/jsp/cams/comm/dichealth/dichealth.jsp", "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("healthStateName").value = list[1];
		DemobilizedIllnessDataset.set("healthStateCode", list[0]);
	}
}
function idcardlookup(){
	L5.getCmp("imgshow").show();
	//window.open (L5.webPath+'/jsp/cams/bpt/comm/idCardDetail.jsp?src=data:image/jpeg;base64,'+ pPrintPhotoBuffer,'身份证件',
	//'height=500,width=400,top=0,left=0,toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no, status=no');
}
function idcardclose(){
	var win = L5.getCmp("imgshow");
	win.hide();
}