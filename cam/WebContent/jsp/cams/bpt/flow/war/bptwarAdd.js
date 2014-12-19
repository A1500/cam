function init() {
	    var dsWar=L5.DatasetMgr.lookup("dsWar");
        dsWar.newRecord({peopleId: document.forms[0].peopleId.value});
	    
		BaseinfoPeopleDataSet.newRecord({peopleId:document.forms[0].peopleId.value,familyId: document.forms[0].familyId.value});
		
		var BaseinfoFamilyDataSet=L5.DatasetMgr.lookup("BaseinfoFamilyDataSet");
		dsWar.set("supportPattern",1);
		var typeInfo =L5.getCmp("typeInfo");
		typeInfo.on("activate",func_BankName);
		return;
}
function func_BankName(){
  dsWar.set("accountName",BaseinfoPeopleDataSet.get("name"));
  dsWar.set("warStateCode",1);
}
 
function saveClick(){
	var img=document.getElementById("photoTemp").value;
	
	
    var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptPeopleWarCommand");
	//人员信息验证
	var BaseinfoPeopleDataSet = L5.DatasetMgr.lookup("BaseinfoPeopleDataSet");
	var BaseinfoPeopleRecord=BaseinfoPeopleDataSet.getCurrent();
	
	BaseinfoPeopleRecord.set('photoTemp',img);

	
	//参战信息
	var dsWar=L5.DatasetMgr.lookup("dsWar");
	var warEntity=dsWar.getCurrent();
	//新增人员信息
	if(BaseinfoPeopleRecord.get("peopleId")==""&&BaseinfoPeopleRecord.get("familyId")==""){
	   BaseinfoPeopleRecord.set("peopleId",peopleId);
	   BaseinfoPeopleRecord.set("familyId",familyId);
	   warEntity.set("peopleId",peopleId);
	   warEntity.set("applyId",applyId);
	}else{//修改人员信息
	   warEntity.set("peopleId",BaseinfoPeopleRecord.get("peopleId"));
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
	
	var isValidate = BaseinfoPeopleDataSet.isValidate();
	

	if(BaseinfoPeopleDataSet.get("safeguardType") == ''){
		L5.Msg.alert("提示","医疗保障方式不能为空");
		return false;
	}
	if(BaseinfoPeopleDataSet.get("domicileType") == ''){
		L5.Msg.alert("提示","户籍类别不能为空");
		return false;
	}
	if(isValidate != true){
		L5.Msg.alert("提示",isValidate);
		return false;
	}
	if(warEntity.get("healthStateCode") == ''){
		L5.Msg.alert("提示","健康状况不能为空！");
		return false;
	}
	var typeinfo = document.getElementById("typeInfo");
	if(typeinfo == null || typeinfo == "") {
		L5.Msg.alert("提示","请填写类别信息");
		return false;
	}
	
	var isDsValidate = dsWar.isValidate();
	if(isDsValidate != true){
		L5.Msg.alert("提示",isDsValidate);
		return false;
	}
	
	var conscriptcDate = warEntity.get("conscriptcDate");
	if(conscriptcDate!=''&&!validateDateFormat(conscriptcDate)){
		L5.Msg.alert("提示","入伍（参加工作）时间格式不正确！");
		return false;
	}
	
	var decruitmentDate = warEntity.get("decruitmentDate");
	if(decruitmentDate!=''&&!validateDateFormat(decruitmentDate)){
		L5.Msg.alert("提示","退伍时间格式不正确！");
		return false;
	}
	
	var retiredDate = warEntity.get("retiredDate");
	if(retiredDate!=''&&!validateDateFormat(retiredDate)){
		L5.Msg.alert("提示","离退休时间格式不正确！");
		return false;
	}
		//if(phoneticCode == null || phoneticCode == "" ) {
	//	L5.Msg.alert("提示","姓名拼音码不能为空!");
	//	return false;
	//}
	getCrjCnStrSpell('namebase','phoneticCode','m');
	var phoneticCode=document.getElementById("phoneticCode").value;
		BaseinfoPeopleRecord.set('phoneticCode',phoneticCode);
		
	var idCard = BaseinfoPeopleDataSet.get("idCard");
	if(!writeAble(idCard,"51",true)){
		L5.Msg.alert('提示', '该人员已经是参战人员！');
		return false;
	}
		
	command.setParameter("flag",document.forms[0].flag.value);
	command.setParameter("BaseinfoPeopleRecord", BaseinfoPeopleRecord);
    command.setParameter("warEntity",warEntity);
    command.setParameter("ifApplyAdd","applyAdd");
    command.setParameter("applyId",applyId);
	command.execute("insert");
	
	if (!command.error) {
		BaseinfoPeopleDataSet.getCurrent().state = L5.model.Record.STATE_MODIFIED;
 		window.returnValue = command.getReturn("peopleId")+";"+command.getReturn("familyId")+";"+command.getReturn("applyId");
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
function func_blur(){
  if(dsWar.get("forcesNo")!=''){
     document.getElementById("forcesNo").disabled=true;
  }
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
		dsWar.set("healthStateCode", list[0]);
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