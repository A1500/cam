var ifsave = false;
function init() {
		
		if (method==null||method==""){
			L5.Msg.alert('提示',"未知的页面命令!");
			back();
		}
		else if(method=="INSERT"){
			BaseinfoPeopleDataSet.newRecord({peopleId: document.forms[0].peopleId.value,familyId: document.forms[0].familyId.value});
			BptPeopleDisabilityDataSet.newRecord({peopleId: document.forms[0].peopleId.value});
			BaseinfoFamilyDataSet.newRecord({familyId: document.forms[0].familyId.value});
			BptPeopleDisabilityDataSet.set("disabilityStateCode",1);
			BptPeopleDisabilityDataSet.set("supportPattern",1);
			return;
		}
		L5.QuickTips.init(); 
}
function func_BankName(){
  BptPeopleDisabilityDataSet.set("accountName",BaseinfoPeopleDataSet.get("name"));
  
}

function func_SaveClick(){
 
    var img=document.getElementById("photoTemp").value;

    
    var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyIntoprovinceCommand");
	
	//人员信息验证
	var BaseinfoPeopleRecord=BaseinfoPeopleDataSet.getCurrent();
	//类别信息
	var BptPeopleDisabilityRecord=BptPeopleDisabilityDataSet.getCurrent();
	
	var peopleIdOld = BaseinfoPeopleRecord.get("peopleId");
	var familyIdOld = BaseinfoPeopleRecord.get("familyId");
	if(peopleIdOld != null && peopleIdOld != "") {
		BaseinfoPeopleRecord.set("peopleId",peopleIdOld);
		BptPeopleDisabilityRecord.set("peopleId",peopleIdOld);
	} else {
		BaseinfoPeopleRecord.set("peopleId",peopleId);
		BptPeopleDisabilityRecord.set("peopleId",peopleId);
	}
	if(familyIdOld != null && familyIdOld != "") {
		BaseinfoPeopleRecord.set("familyId",familyIdOld);
	} else {
		BaseinfoPeopleRecord.set("familyId",familyId);
	}
	
	BaseinfoPeopleRecord.set('photoTemp',img);
		//校验伤残等级
	var disabilityLevelCode = BptPeopleDisabilityRecord.get("disabilityLevelCode");
	if(disabilityLevelCode==''){
		 L5.Msg.alert('提示','伤残等级不能为空！');
		 return false;
	}
	//校验伤残性质
	var disabilityCaseCode = BptPeopleDisabilityRecord.get("disabilityCaseCode");
	if(disabilityCaseCode==''){
		 L5.Msg.alert('提示','伤残性质不能为空！');
		 return false;
	}
	
	BptPeopleDisabilityDataSet.set("viabilityCode",BptPeopleDisabilityRecord.get("viabilityCode"));
	 
	BaseinfoPeopleRecord.set("disabilityFlag","1");
	BaseinfoPeopleRecord.set("disabilityStateCode","1");
	BaseinfoPeopleRecord.set("disabilityLevelCode",BptPeopleDisabilityRecord.get("disabilityLevelCode"));
	BaseinfoPeopleRecord.set("disabilityCaseCode",BptPeopleDisabilityRecord.get("disabilityCaseCode"));
	BaseinfoPeopleRecord.set("disabilityNo",BptPeopleDisabilityRecord.get("oldPaperNo"));
	
	BptPeopleDisabilityRecord.set("serviceType","15");
	
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
	
	//if(phoneticCode == null || phoneticCode == "" ) {
	//	L5.Msg.alert("提示","姓名拼音码不能为空!");
	//	return false;
	//}
	getCrjCnStrSpell('namebase','phoneticCode','m');
		var phoneticCode=document.getElementById("phoneticCode").value;
		BaseinfoPeopleRecord.set('phoneticCode',phoneticCode);
	
	//校验属地行政规划
	var domicileCode = BaseinfoPeopleRecord.get("domicileCode");
	if(domicileCode==''){
		 L5.Msg.alert('提示','属地行政规划不能为空！');
		 return false;
	}
	//医疗保障方式规划
	var safeguardType = BaseinfoPeopleRecord.get("safeguardType");
	if(safeguardType==''){
		 L5.Msg.alert('提示','医疗保障方式不能为空！');
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
	//伤残信息验证
	var isValidate = BptPeopleDisabilityDataSet.isValidate();
	if(isValidate != true){
		L5.Msg.alert("提示",isValidate);
		return false;
	}
	//入伍时间和退伍时间
	var disabilityTypeCode = BptPeopleDisabilityRecord.get("disabilityTypeCode");
	if(disabilityTypeCode=='11'){
	  var conscriptDate  = BptPeopleDisabilityRecord.get("conscriptDate");
	  var veteransDate = BptPeopleDisabilityRecord.get("veteransDate");
	   if(conscriptDate==''||veteransDate==''){
	      L5.Msg.alert('提示','入伍(参加工作时间)或退伍时间不能为空！');
	      return false;
	   }
	}
	var conscriptDate  = BptPeopleDisabilityRecord.get("conscriptDate");
	if(conscriptDate!=''&&!validateDateFormat(conscriptDate)){
		 L5.Msg.alert('提示','入伍(参加工作)时间格式不正确！');
	      return false;
	}
	
	
	var veteransDate = BptPeopleDisabilityRecord.get("veteransDate");
	if(veteransDate!=''&&!validateDateFormat(veteransDate)){
		 L5.Msg.alert('提示','退伍时间格式不正确！');
	      return false;
	}
	
	var retiredDate = BptPeopleDisabilityRecord.get("retiredDate");
	if(retiredDate!=''&&!validateDateFormat(retiredDate)){
		 L5.Msg.alert('提示','离退休时间格式不正确！');
	      return false;
	}
	
	var allowanceMonth = BptPeopleDisabilityRecord.get("allowanceMonth");
	if(allowanceMonth!=''&&!validateDateFormat(allowanceMonth+'-01')){
		 L5.Msg.alert('提示','抚恤金已发至月份格式不正确！');
	      return false;
	}
	var idCard = BaseinfoPeopleDataSet.get("idCard");
	if(!writeAble(idCard,"1",true)){
		L5.Msg.alert('提示', '该人员已经是伤残人员！');
		return false;
	}
	command.setParameter("BaseinfoPeopleRecord", BaseinfoPeopleRecord);
	command.setParameter("BptCategoryRecord", BptPeopleDisabilityRecord);
	command.setParameter("flag",document.getElementById("flag").value);
	command.execute("insertIngoingProvince");
	if (!command.error) {
		BaseinfoPeopleDataSet.getCurrent().state = L5.model.Record.STATE_MODIFIED;
		var applyId = command.getReturn("applyId");
		peopleId = command.getReturn("peopleId");
		familyId =command.getReturn("familyId");
		/*var url="intoProviUpdateManage.jsp?applyId="  + applyId+"&peopleId="+peopleId+"&familyId="+familyId;
		var width = screen.width-100;
		var height = screen.height-120;
		var returnValue = window.showModalDialog (url,window,"scroll:no;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
		*/
		window.returnValue=applyId+";"+peopleId+";"+familyId+";15";
		window.close();
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}

function func_Close(){	
	window.close();
}

function func_Level(){
  if(document.getElementById("disabilityLevelCode").value<='04'&&document.getElementById("disabilityLevelCode").value !=''){
     BptPeopleDisabilityDataSet.set("viabilityCode",0);
	 BptPeopleDisabilityDataSet.set("viabilityCode",2);
  }if(document.getElementById("disabilityLevelCode").value>'04'){
     document.getElementById("viabilityCode").value='';
  }if(document.getElementById("disabilityLevelCode").value ==''){
     document.getElementById("viabilityCode").value='';
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

function getCodeAndName(){
		var revalue=window.showModalDialog(L5.webPath+"/jsp/cams/comm/diccity/dicPubCant.jsp?organCode=CN&organName=中国","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
		if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
			 BptPeopleDisabilityDataSet.getCurrent().set("ingoingCode",list[0]);
			 BptPeopleDisabilityDataSet.getCurrent().set("ingoingAddress",list[1]);
		}
}
function KoreaWar(k){

	if(k.value==3){
		document.getElementById("k1").style.display='';
		document.getElementById("k2").style.display='';
	}else{
		document.getElementById("k1").style.display='none';
		document.getElementById("k2").style.display='none';
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