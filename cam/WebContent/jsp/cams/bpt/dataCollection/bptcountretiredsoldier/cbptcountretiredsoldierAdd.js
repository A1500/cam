
function init() {
	if (method==null||method==""){
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
		}
	else if (method=="INSERT"){
	    //document.forms[1].objectType.style.display='none';
		BaseinfoPeopleDataSet.newRecord({peopleId : document.forms[0].peopleId.value,familyId : document.forms[0].familyId.value});
		var BaseinfoFamilyDataSet = L5.DatasetMgr.lookup("BaseinfoFamilyDataSet");
		BaseinfoFamilyDataSet.newRecord({familyId : document.forms[0].familyId.value});
		var RetiredSoldierDataSet = L5.DatasetMgr.lookup("RetiredSoldierDataSet");
		RetiredSoldierDataSet.newRecord({peopleId : document.forms[0].peopleId.value});
		var typeInfo =L5.getCmp("typeInfo");
		typeInfo.on("activate",func_BankName);
		return;
	}
	else if (method=="UPDATE"){
		ds.baseParams["PEOPLE_ID@="]=idField;
		ds.load();
	}
	else{
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
	}
	L5.QuickTips.init(); 
}
function func_BankName(){
  RetiredSoldierDataSet.set("accountName",BaseinfoPeopleDataSet.get("name"));
}

function func_show(){
  if(document.forms[1].isOtherBptobject.value!='1'){
	  document.getElementById("objectType").style.display='none';
  }
  if(document.forms[1].isOtherBptobject.value=='1'){
	  document.getElementById("objectType").style.display='';
  }
}
function save(){
	var img = document.getElementById("photoTemp").value;
    var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptCountRetiredSoldierCommand");
    // 人员信息验证
	var BaseinfoPeopleDataSet = L5.DatasetMgr.lookup("BaseinfoPeopleDataSet");
	var BaseinfoPeopleRecord = BaseinfoPeopleDataSet.getCurrent();
	BaseinfoPeopleRecord.set('photoTemp', img);
	// 类别信息验证
	var RetiredSoldierDataSet = L5.DatasetMgr.lookup("RetiredSoldierDataSet");
	var RetiredSoldierRecord = RetiredSoldierDataSet.getCurrent();
    //新增人员信息
	if(BaseinfoPeopleRecord.get("peopleId")==""&&BaseinfoPeopleRecord.get("familyId")==""){
	   BaseinfoPeopleRecord.set("peopleId",peopleId);
	   BaseinfoPeopleRecord.set("familyId",familyId);
	   RetiredSoldierRecord.set("peopleId",peopleId);
	}else{//修改人员信息
	   RetiredSoldierRecord.set("peopleId",BaseinfoPeopleRecord.get("peopleId"));
	}
	
    var isValidate = BaseinfoPeopleDataSet.isValidate();
	if (isValidate != true) {
		L5.Msg.alert("提示", isValidate);
		return false;
	}
	
	getCrjCnStrSpell('namebase','phoneticCode','m'); 
	var phoneticCode = document.getElementById("phoneticCode").value;
	BaseinfoPeopleRecord.set('phoneticCode', phoneticCode);
	var idCard = document.getElementById("idCard");
	if(!checkIDCard(idCard)){
	    L5.Msg.alert("提示", "身份证格式不正确!");
		return false;
	}
	
	// 校验户口薄(行政区划)
	var domicileCode = BaseinfoPeopleRecord.get("domicileCode");
	if (domicileCode == '') {
		L5.Msg.alert('提示', '户口薄(行政区划)不能为空！');
		return false;
	}
	
	// 校验实际居住(行政区划)
	var apanageCode = BaseinfoPeopleRecord.get("apanageCode");
	if (apanageCode == '') {
		L5.Msg.alert('提示', '实际居住(行政区划)不能为空！');
		return false;
	}
	
	var domicileType = document.getElementById("domicileType").value;
	if (domicileType == '') {
		L5.Msg.alert('提示', '户籍类别不能为空!');
		return false;
	}
	
	if(document.getElementById("safeguardType").value==""){
	    L5.Msg.alert("提示", "请选择医疗保障方式!");
		return false;
	}
	/*if(document.getElementById("penSionCode").value==""){
	    L5.Msg.alert("提示", "请选择养老保障方式!");
		return false;
	}*/
	if(L5.getDom("conscriptDate")==null||L5.getDom("conscriptDate")=="")
	{
		 L5.Msg.alert('提示','请录入类别信息后再保存！');
		 return false;
	}
	
	var isValidate = RetiredSoldierDataSet.isValidate();
	if (isValidate != true) {
		L5.Msg.alert("提示", isValidate);
		return false;
	}
	if(document.forms[1].isOtherBptobject.value=='1'){
	  RetiredSoldierRecord.set("disabilityCivil",document.getElementById("disabilityCivil").checked);
	  RetiredSoldierRecord.set("disabilityPolice",document.getElementById("disabilityPolice").checked);
	  RetiredSoldierRecord.set("disabilityMigrant",document.getElementById("disabilityMigrant").checked);
	  RetiredSoldierRecord.set("disabilitySoldier",document.getElementById("disabilitySoldier").checked);
	  RetiredSoldierRecord.set("dependMartyrs",document.getElementById("dependMartyrs").checked);
	  RetiredSoldierRecord.set("dependDied",document.getElementById("dependDied").checked);
	  RetiredSoldierRecord.set("dependPublic",document.getElementById("dependPublic").checked);
	  RetiredSoldierRecord.set("demobilizedSoldier",document.getElementById("demobilizedSoldier").checked);
	  RetiredSoldierRecord.set("demobilizedIllnessPeople",document.getElementById("demobilizedIllnessPeople").checked);
	  RetiredSoldierRecord.set("warPeople",document.getElementById("warPeople").checked);
	  RetiredSoldierRecord.set("testedPeople",document.getElementById("testedPeople").checked);
	}
	
	var conscriptDate = RetiredSoldierRecord.get("conscriptDate");
	if(conscriptDate!=''&&!validateDateFormat(conscriptDate)){
		L5.Msg.alert("提示", "入伍时间格式不正确！");
		return false;
	}
	var decruitmentDate = RetiredSoldierRecord.get("decruitmentDate");
	if(decruitmentDate!=''&&!validateDateFormat(decruitmentDate)){
		L5.Msg.alert("提示", "退役时间格式不正确！");
		return false;
	}

	var soldierStartDate = RetiredSoldierRecord.get("soldierStartDate");
	if(soldierStartDate!=''&&!validateDateFormat(soldierStartDate)){
		L5.Msg.alert("提示", "服义务兵开始时间格式不正确！");
		return false;
	}
	// 批准日期
	var approvalDate = RetiredSoldierRecord.get("approvalDate");
	if (approvalDate=='') {
		L5.Msg.alert('提示', '批准日期不能为空！');
		return false;
	}
	if(approvalDate!=''&&!validateDateFormat(approvalDate)){
		L5.Msg.alert("提示", "批准日期格式不正确！");
		return false;
	}
	var soldierEndDate = RetiredSoldierRecord.get("soldierEndDate");
	if(soldierEndDate!=''&&!validateDateFormat(soldierEndDate)){
		L5.Msg.alert("提示", "服义务兵结束时间格式不正确！");
		return false;
	}
	
	var idCard = BaseinfoPeopleDataSet.get("idCard");
	if(!writeAble(idCard,"81",false)){
		L5.Msg.alert('提示', '该人员已经是60周岁退役士兵人员！');
		return false;
	}
	
	RetiredSoldierRecord.set("soldierYears",document.getElementById("soldierYears").value);
    BaseinfoPeopleRecord.set("retiredStateCode",RetiredSoldierRecord.get("retiredStateCode"));
   BaseinfoPeopleRecord.set("retiredNo",RetiredSoldierRecord.get("pretiredNo"));
    command.setParameter("flag",document.forms[0].flag.value);
	command.setParameter("BaseinfoPeopleRecord", BaseinfoPeopleRecord);
	command.setParameter("RetiredSoldierRecord", RetiredSoldierRecord);
	command.execute("insertForCollection");
    
    if (!command.error) {
    	var peopleId1 = command.getReturn("peopleId");
		var familyId1 = command.getReturn("familyId");
	    window.returnValue = peopleId1+";"+familyId1;
		window.close();
	} else {
		L5.Msg.alert('提示', "保存时出现错误！" + command.error);
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

function func_StartDate(){
   var startDate = document.getElementById("soldierStartDate").value;
   var endDate = document.getElementById("soldierEndDate").value;
   if(endDate !=''){
      if(startDate>endDate){
         L5.Msg.alert('提示', "服义务兵(开始时间)要晚于服义务兵(结束时间)！");
         return false;
      }else{
	        var start = new Date(startDate.replace('-','/'));
	        var end   = new Date(endDate.replace('-','/'));
	        if(end.getYear()==start.getYear()){
	             RetiredSoldierDataSet.set("soldierYears",1);
	        }else{
		         var year = end.getYear()-start.getYear();
		         var month = end.getMonth()-start.getMonth();
		         if(Number(month)>0){
		         	RetiredSoldierDataSet.set("soldierYears",Number(year)+1);
		         }else{
		         	RetiredSoldierDataSet.set("soldierYears",year);
		         }
	        } 
     }
   }else{
     L5.Msg.alert('提示', "服义务兵(结束时间)不能为空！");
     return false;
   }
}

function func_EndDate(){
  var startDate = document.getElementById("soldierStartDate").value;
  var endDate = document.getElementById("soldierEndDate").value;
  if(startDate!=''&&endDate!=''){
     if(endDate<startDate){
        document.getElementById("soldierYears").value='';
        document.getElementById("soldierEndDate").value='';
        L5.Msg.alert('提示','服义务兵(结束时间)大于服义务兵(开始时间)！');
		return false;
     }
     	var start = new Date(startDate.replace('-','/'));
	    var end   = new Date(endDate.replace('-','/'));
     	if(end.getYear()==start.getYear()){
           RetiredSoldierDataSet.set("soldierYears",1);
        }else{
            var year = end.getYear()-start.getYear();
            var month = end.getMonth()-start.getMonth();
            if(Number(month)>0){
                RetiredSoldierDataSet.set("soldierYears",Number(year)+1);
            }else{
                RetiredSoldierDataSet.set("soldierYears",year);
            }
        } 
    }else{
        L5.Msg.alert('提示','服义务兵(结束时间)大于服义务兵(开始时间)！');
		return false;
    }
}


function back(){	
  	history.go(-1);	 
 }
  //关闭
function func_Close(){
	window.close();
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
 



