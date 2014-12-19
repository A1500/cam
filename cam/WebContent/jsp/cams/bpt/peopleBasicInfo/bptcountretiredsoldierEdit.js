function init() {	
	/*document.getElementById("conscriptDate").disabled=true;//入伍时间
	document.getElementById("decruitmentDate").disabled=true;//退役时间
	document.getElementById("retiredNo").disabled=true;//退役证件号
	document.getElementById("forcesName").disabled=true;//服役部队名称(番号)
	document.getElementById("forcesNo").disabled=true;//服役部队代号
	document.getElementById("soldierStartDate").disabled=true;//服义务兵(开始时间)
	document.getElementById("soldierEndDate").disabled=true;//服义务兵(结束时间)
	document.getElementById("soldierYears").disabled=true;//所服义务兵役折算年限
*/
	 RetiredSoldierDataSet.setParameter("peopleId",peopleId);
     RetiredSoldierDataSet.load();
     
     
     if(document.getElementById("isOtherBptobject").value!='1'){
	  document.getElementById("objectType").style.display='none';
     }
     if(document.getElementById("isOtherBptobject").value=='1'){
	  document.getElementById("objectType").style.display='';
     }
     
     RetiredSoldierDataSet.on("load",func_init);
     
}

function func_init(){
    var rd =RetiredSoldierDataSet.getCurrent();
    if(rd.get("disabilityCivil")=="true"){
       document.getElementById("disabilityCivil").checked=true;
    }
    if(rd.get("disabilitySoldier")=="true"){
       document.getElementById("disabilitySoldier").checked=true;
    }
    if(rd.get("disabilityPolice")=="true"){
       document.getElementById("disabilityPolice").checked=true;
    }
    if(rd.get("disabilityMigrant")=="true"){
       document.getElementById("disabilityMigrant").checked=true;
    }
    if(rd.get("dependMartyrs")=="true"){
       document.getElementById("dependMartyrs").checked=true;
    }
    
    if(rd.get("dependDied")=="true"){
       document.getElementById("dependDied").checked=true;
    }
   
    if(rd.get("dependPublic")=="true"){
       document.getElementById("dependPublic").checked=true;
    }
    if(rd.get("demobilizedSoldier")=="true"){
       document.getElementById("demobilizedSoldier").checked=true;
    }
    if(rd.get("demobilizedIllnessPeople")=="true"){
       document.getElementById("demobilizedIllnessPeople").checked=true;
    }
    if(rd.get("warPeople")=="true"){
       document.getElementById("warPeople").checked=true;
    }
    if(rd.get("testedPeople")=="true"){
       document.getElementById("testedPeople").checked=true;
    }
    
}
function saveClick(){
     // 60周岁以上农村籍退役士兵信息修改
	var RetiredSoldierDataSet = L5.DatasetMgr.lookup("RetiredSoldierDataSet");
	var retiredSoldierRecord=RetiredSoldierDataSet.getCurrent();
		retiredSoldierRecord.set("peopleId",peopleId);
	var isValidate = RetiredSoldierDataSet.isValidate();
	if(isValidate != true){
		L5.Msg.alert("提示",isValidate);
		return false;
	}
	
	var conscriptDate = retiredSoldierRecord.get("conscriptDate");
	if(conscriptDate!=''&&!validateDateFormat(conscriptDate)){
		L5.Msg.alert("提示", "入伍时间格式不正确！");
		return false;
	}
	var decruitmentDate = retiredSoldierRecord.get("decruitmentDate");
	if(decruitmentDate!=''&&!validateDateFormat(decruitmentDate)){
		L5.Msg.alert("提示", "退役时间格式不正确！");
		return false;
	}

	var soldierStartDate = retiredSoldierRecord.get("soldierStartDate");
	if(soldierStartDate!=''&&!validateDateFormat(soldierStartDate)){
		L5.Msg.alert("提示", "服义务兵开始时间格式不正确！");
		return false;
	}
	
	var soldierEndDate = retiredSoldierRecord.get("soldierEndDate");
	if(soldierEndDate!=''&&!validateDateFormat(soldierEndDate)){
		L5.Msg.alert("提示", "服义务兵结束时间格式不正确！");
		return false;
	}
	if(document.getElementById("isOtherBptobject").value=='1'){
	  retiredSoldierRecord.set("disabilityCivil",document.getElementById("disabilityCivil").checked);
	  retiredSoldierRecord.set("disabilityPolice",document.getElementById("disabilityPolice").checked);
	  retiredSoldierRecord.set("disabilityMigrant",document.getElementById("disabilityMigrant").checked);
	  retiredSoldierRecord.set("disabilitySoldier",document.getElementById("disabilitySoldier").checked);
	  retiredSoldierRecord.set("dependMartyrs",document.getElementById("dependMartyrs").checked);
	  retiredSoldierRecord.set("dependDied",document.getElementById("dependDied").checked);
	  retiredSoldierRecord.set("dependPublic",document.getElementById("dependPublic").checked);
	  retiredSoldierRecord.set("demobilizedSoldier",document.getElementById("demobilizedSoldier").checked);
	  retiredSoldierRecord.set("demobilizedIllnessPeople",document.getElementById("demobilizedIllnessPeople").checked);
	  retiredSoldierRecord.set("warPeople",document.getElementById("warPeople").checked);
	  retiredSoldierRecord.set("testedPeople",document.getElementById("testedPeople").checked);
	  func_init();
	}
	if(document.getElementById("isOtherBptobject").value=='0'){
	  retiredSoldierRecord.set("disabilityCivil","false");
	  retiredSoldierRecord.set("disabilityPolice","false");
	  retiredSoldierRecord.set("disabilityMigrant","false");
	  retiredSoldierRecord.set("disabilitySoldier","false");
	  retiredSoldierRecord.set("dependMartyrs","false");
	  retiredSoldierRecord.set("dependDied","false");
	  retiredSoldierRecord.set("dependPublic","false");
	  retiredSoldierRecord.set("demobilizedSoldier","false");
	  retiredSoldierRecord.set("demobilizedIllnessPeople","false");
	  retiredSoldierRecord.set("warPeople","false");
	  retiredSoldierRecord.set("testedPeople","false");
	}
	retiredSoldierRecord.set("soldierYears",document.getElementById("soldierYears").value);
	var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptCountRetiredSoldierCommand");
	command.setParameter("RetiredSoldierRecord", retiredSoldierRecord);
	command.execute("update");
	if (!command.error) {
		L5.Msg.alert('提示','保存成功！');
		func_init();
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
function func_show(){
  if(document.getElementById("isOtherBptobject").value!='1'){
	  document.getElementById("objectType").style.display='none';
  }
  if(document.getElementById("isOtherBptobject").value=='1'){
	  document.getElementById("objectType").style.display='';
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
           if(end.getMonth()-start.getMonth()>=6){
              document.getElementById("soldierYears").value=1;
           }else{
              document.getElementById("soldierYears").value=0.5;
           }
       }else{
                 var year = end.getYear()-start.getYear();
                 var month = end.getMonth()-start.getMonth();
                 var intMonths = year*12+(month);
                 if(intMonths>=6){
                    document.getElementById("soldierYears").value=1;
                 }else{
                    document.getElementById("soldierYears").value = "0."+intMonths;
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
     if(endDate>startDate){
        var start = new Date(startDate.replace('-','/'));
        var end   = new Date(endDate.replace('-','/'));
    
        if(end.getYear()==start.getYear()){
           if(end.getMonth()-start.getMonth()>=6){
              document.getElementById("soldierYears").value=1;
           }else{
              document.getElementById("soldierYears").value=0.5;
           }
       }else{
           if(end.getYear()-start.getYear()>=1&&end.getMonth()>=start.getMonth()){
                 var year = end.getYear()-start.getYear();
                 var month = end.getMonth()-start.getMonth();
                 var intYears = (year*12+(month))/12;
                 var intMonths = parseFloat((year*12+(month))%12);
                 document.getElementById("soldierYears").value = (intYears+"."+intMonths).substr(0,3); 
             
           }else{
                 var year = end.getYear()-start.getYear();
                 var month = end.getMonth()-start.getMonth();
                 var intMonths = year*12+(month);
                 if(intMonths>=6){
                    document.getElementById("soldierYears").value=1;
                 }else{
                    document.getElementById("soldierYears").value = "0."+intMonths;
                 }
           }
      } 
    }else{
        L5.Msg.alert('提示','服义务兵(结束时间)大于服义务兵(开始时间)！');
		return false;
    }
  }
}

 //关闭
function func_Close(){
	window.close();
}