var ifsave = false;
function init() {
		 if (method=="INSERT"){
		    var dsWar=L5.DatasetMgr.lookup("dsWar");
	        dsWar.newRecord({peopleId: document.forms[0].peopleId.value});
		    
			BaseinfoPeopleDataSet.newRecord({peopleId:document.forms[0].peopleId.value,familyId: document.forms[0].familyId.value});
			
			var BaseinfoFamilyDataSet=L5.DatasetMgr.lookup("BaseinfoFamilyDataSet");
			dsWar.set("supportPattern",1);
			var typeInfo =L5.getCmp("typeInfo");
			typeInfo.on("activate",func_BankName);
			return;
		}
		
}
function func_BankName(){
  dsWar.set("accountName",BaseinfoPeopleDataSet.get("name"));
  dsWar.set("warStateCode",1);
}
 
function saveClick(){
	var img=document.getElementById("photoTemp").value;

	
    var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyIntoprovinceCommand");
	//人员信息验证
	var BaseinfoPeopleRecord=BaseinfoPeopleDataSet.getCurrent();
		BaseinfoPeopleRecord.set('photoTemp',img);
		BaseinfoPeopleRecord.set("warFlag","1");
	//类别信息
	var BptPeopleWarRecord=dsWar.getCurrent();
		
		var peopleIdOld = BaseinfoPeopleRecord.get("peopleId");
		var familyIdOld = BaseinfoPeopleRecord.get("familyId");
		if(peopleIdOld != null && peopleIdOld != "") {
			BaseinfoPeopleRecord.set("peopleId",peopleIdOld);
			BptPeopleWarRecord.set("peopleId",peopleIdOld);
		} else {
			BaseinfoPeopleRecord.set("peopleId",peopleId);
			BptPeopleWarRecord.set("peopleId",peopleId);
		}
		if(familyIdOld != null && familyIdOld != "") {
			BaseinfoPeopleRecord.set("familyId",familyIdOld);
		} else {
			BaseinfoPeopleRecord.set("familyId",familyId);
		}
		
		BaseinfoPeopleRecord.set("warStateCode",BptPeopleWarRecord.get("warStateCode"));
		BaseinfoPeopleRecord.set("warNo",BptPeopleWarRecord.get("warNo"));
		BptPeopleWarRecord.set("serviceType","52");
		//var allowanceMonth = BptPeopleWarRecord.get("allowanceMonth")+"-12";
		//BptPeopleWarRecord.set("allowanceMonth",allowanceMonth);
	var idCard = document.getElementById("idCard");
   if(!checkIDCard(idCard)){
	    L5.Msg.alert("提示", "身份证格式不正确!");
	    return false;
   }
	
	var isValidate = BaseinfoPeopleDataSet.isValidate();
	if(isValidate != true){
		L5.Msg.alert("提示",isValidate);
		return false;
	}
	
		
	if(BaseinfoPeopleDataSet.get("safeguardType") == ''){
		L5.Msg.alert("提示","医疗保障方式不能为空");
		return false;
	}
	if(BaseinfoPeopleDataSet.get("domicileType") == ''){
		L5.Msg.alert("提示","户籍类别不能为空");
		return false;
	}
	//校验属地行政规划
	var domicileCode = BaseinfoPeopleRecord.get("domicileCode");
	if(domicileCode==''){
		 L5.Msg.alert('提示','属地行政规划不能为空！');
		 return false;
	}
	var bank = BptPeopleWarRecord.get("workAbilityCode");
	if(bank == ''){
		L5.Msg.alert('提示','劳动能力不能为空！');
		return false;
	}
	var bank = BptPeopleWarRecord.get("insanityFlag");
	if(bank == ''){
		L5.Msg.alert('提示','是否精神病不能为空！');
		return false;
	}
	var bank = BptPeopleWarRecord.get("oldLonelyFlag");
	if(bank == ''){
		L5.Msg.alert('提示','是否孤老不能为空！');
		return false;
	}
	var isDsValidate = dsWar.isValidate();
	if(isDsValidate != true){
		L5.Msg.alert("提示",isDsValidate);
		return false;
	}
	//校验开户银行
	/*var bank = BptPeopleWarRecord.get("bank");
	if(bank == ''){
		L5.Msg.alert('提示','开户银行不能为空！');
		return false;
	}*/
	//校验开户名称
	//var accountName = BptPeopleWarRecord.get("accountName");
	//if(accountName == ''){
		//L5.Msg.alert('提示','开户名称不能为空！');
		//return false;
	//}
	//if(phoneticCode == null || phoneticCode == "" ) {
	//	L5.Msg.alert("提示","姓名拼音码不能为空!");
	//	return false;
	//}
	getCrjCnStrSpell('namebase','phoneticCode','m');
		var phoneticCode=document.getElementById("phoneticCode").value;
			BaseinfoPeopleRecord.set('phoneticCode',phoneticCode);
	//校验银行账号
	//var accountCode = BptPeopleWarRecord.get("accountCode");
	//if(accountCode == ''){
		//L5.Msg.alert('提示','银行账号不能为空！');
		//return false;
	//}
	//校验由何地迁入
	var accountCode = BptPeopleWarRecord.get("ingoingAddress");
	if(accountCode == ''){
		L5.Msg.alert('提示','由何地迁入不能为空！');
		return false;
	}
	//校验抚恤金已发至月份
	var allowanceMonth = BptPeopleWarRecord.get("allowanceMonth");
	if(allowanceMonth == ''){
		L5.Msg.alert('提示','抚恤金已发至月份不能为空！');
		return false;
	}
	if(allowanceMonth!=''&&!validateDateFormat(allowanceMonth+'-01')){
		L5.Msg.alert("提示","抚恤金已发至月份格式不正确！");
		return false;
	}
	//校验迁入原因
	var accountCode = BptPeopleWarRecord.get("ingoingReason");
	if(accountCode == ''){
		L5.Msg.alert('提示','迁入原因不能为空！');
		return false;
	}
	//校验批准日期
	/*var approveDate = BptPeopleWarRecord.get("approvalDate");
	if(approveDate==''){
	   L5.Msg.alert('提示','批准日期不能为空！');
	   return false;
	}
	
	if(approveDate!=''&&!validateDateFormat(approveDate)){
		L5.Msg.alert("提示","批准日期格式不正确！");
		return false;
	}*/
	//入伍时间和退伍时间
	var conscriptDate  = BptPeopleWarRecord.get("conscriptcDate");
	if(conscriptDate!=''&&!validateDateFormat(conscriptDate)){
		L5.Msg.alert("提示","入伍(参加工作)时间格式不正确!！");
		return false;
	}
	var veteransDate = BptPeopleWarRecord.get("decruitmentDate");
	
	if(veteransDate!=''&&!validateDateFormat(veteransDate)){
		L5.Msg.alert("提示","退伍时间格式不正确！");
		return false;
	}
	var retiredDate = BptPeopleWarRecord.get("retiredDate");
	
	if(retiredDate!=''&&!validateDateFormat(retiredDate)){
		L5.Msg.alert("提示","离退休时间格式不正确！");
		return false;
	}
	var disabilityTypeCode = BptPeopleWarRecord.get("disabilityTypeCode");
	if(disabilityTypeCode=='11'){
	  var conscriptDate  = BptPeopleWarRecord.get("conscriptDate");
	  var veteransDate = BptPeopleWarRecord.get("veteransDate");
	   if(conscriptDate==''||veteransDate==''){
	      L5.Msg.alert('提示','入伍(参加工作)时间或退伍时间不能为空！');
	      return false;
	   }
	}
	var idCard = BaseinfoPeopleDataSet.get("idCard");
	if(!writeAble(idCard,"51",true)){
		L5.Msg.alert('提示', '该人员已经是参战人员！');
		return false;
	}
	command.setParameter("flag",document.getElementById("flag").value);
	command.setParameter("BaseinfoPeopleRecord", BaseinfoPeopleRecord);
	command.setParameter("BptCategoryRecord", BptPeopleWarRecord);
	command.execute("insertWarIngoingProvince");
	if (!command.error) {
		BaseinfoPeopleDataSet.getCurrent().state = L5.model.Record.STATE_MODIFIED;
		 
		var applyId = command.getReturn("applyId");
		peopleId = command.getReturn("peopleId");
		familyId =command.getReturn("familyId");
		/*var url="intoProviUpdate.jsp?applyId="  + applyId+"&peopleId="+peopleId+"&familyId="+familyId;
		var width = screen.width-100;
		var height = screen.height-120;
		var returnValue = window.showModalDialog (url,window,"scroll:no;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
		*/
		window.returnValue=applyId+";"+peopleId+";"+familyId+";52";
		window.close();
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}

//关闭
function func_Close(){
	window.close();
}
/*
function submit() {
	var records = BptPeopleWarDataSet.getAllChangedRecords();
	if(records.length<1){
		L5.Msg.alert('提示','没有需要保存的数据！');
		return false;
	}
	var command = new L5.Command("com.inspur.cams.bpt.disability.cmd.BptPeopleDisabilityCommand");
	command.setParameter("bptpeopledisabilityRecords", records);
	command.execute("save");
	if (!command.error) {
		BptPeopleWarDataSet.commitChanges();
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
function undo() {
	BptPeopleWarDataSet.rejectChanges();
}
*/
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

function getCodeAndName(){
		var revalue=window.showModalDialog(L5.webPath+"/jsp/cams/comm/diccity/dicPubCant.jsp?organCode=CN&organName=中国","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
		if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
			 dsWar.getCurrent().set("ingoingCode",list[0]);
			 dsWar.getCurrent().set("ingoingAddress",list[1]);
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