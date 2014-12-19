function init() {
	if (method==null||method==""){
		L5.Msg.alert('提示',"未知的页面命令!");
		}
	else if (method=="INSERT"){
		prsPlacementDataset.newRecord();
	}
	else if (method=="UPDATE"){
		prsPlacementDataset.baseParams["SOLDIERS_ID"]=idField;
		prsPlacementDataset.load();
	}
	else{
		L5.Msg.alert('提示',"未知的页面命令!");
	}
}
function Evt_butsave_click() {
	var prsPlacementDataset=L5.DatasetMgr.lookup("prsPlacementDataset");
	var prsPlacementRecord = prsPlacementDataset.getCurrent();
	if(method=="INSERT"){
		prsPlacementDataset.set("placementId",placementId);
	}
    var isValidate = prsPlacementDataset.isValidate(true);
    if(isValidate !== true){
    	L5.Msg.alert("提示","校验未通过,不能保存!"+isValidate);
        return false;
    }
    var employmentType = prsPlacementRecord.get("employmentType");
    if(employmentType == "") {
    	L5.Msg.alert('提示','安置方式不能为空！');
		 return false;
    }
    var resettlement = document.getElementById("resettlement").style.display;
    if(resettlement != "none") {
    	var situation = document.getElementById("resettlementSituation").value;
    	if(situation == "") {
    		L5.Msg.alert('提示','安置方式不能为空！');
   		 	return false;
    	}
    }
    
    var grantGrant = prsPlacementRecord.get("grantGrant");
	if(!isFloat(grantGrant)&&(grantGrant!="")){
		 L5.Msg.alert('提示','发放金额格式不正确！');
		 return false;
	}
	var archivesPerformanceScores = prsPlacementRecord.get("archivesPerformanceScores");
	if(!isFloat(archivesPerformanceScores)&&(archivesPerformanceScores!="")){
		 L5.Msg.alert('提示','档案考核成绩格式不正确！');
		 return false;
	}
	var culturalStudiesTestScores = prsPlacementRecord.get("culturalStudiesTestScores");
	if(!isFloat(culturalStudiesTestScores)&&(culturalStudiesTestScores!="")){
		 L5.Msg.alert('提示','文化考试成绩格式不正确！');
		 return false;
	}
	var totalScore = prsPlacementRecord.get("totalScore");
	if(!isFloat(totalScore)&&(totalScore!="")){
		 L5.Msg.alert('提示','总成绩格式不正确！');
		 return false;
	}
	var ranking = prsPlacementRecord.get("ranking");
	if(!_isNum(ranking)&&(ranking!="")){
		 L5.Msg.alert('提示','名次格式不正确！');
		 return false;
	}
	var employmentTime = document.getElementById("employmentTime").value;
	if(employmentTime == "") {
		 L5.Msg.alert("提示", "就业时间不能为空!");
		 return false;
	}
	if(employmentTime!=""){
		if(!checkBirthday(employmentTime)){
		    L5.Msg.alert("提示", "就业时间格式或者内容不正确!");
		    return false;
		}
	}
	var employmentCompany = prsPlacementRecord.get("employmentCompany");
	if(employmentCompany == "") {
		L5.Msg.alert("提示", "就业单位不能为空!");
	    return false;
	}
 	if(prsPlacementRecord.get("employmentType")=="1"||prsPlacementRecord.get("resettlementSituation")=="30"){
		var applicationDate = document.getElementById("applicationDate").value;
		if(applicationDate!=""){
			if(!checkBirthday(applicationDate)){
			    L5.Msg.alert("提示", "申请时间格式或者内容不正确!");
			    return false;
			}
		}
		var transactDate = document.getElementById("transactDate").value;
		if(transactDate!=""){
			if(!checkBirthday(transactDate)){
			    L5.Msg.alert("提示", "发放时间格式或者内容不正确!");
			    return false;
			}
		}
	}
	var command = new L5.Command("com.inspur.cams.prs.prssoldiersplacement.cmd.PrsSoldiersPlacementCommand");
	command.setParameter("records", prsPlacementRecord);
	if(method=="INSERT"){
	}else if(method =="UPDATE"){
		command.execute("update");
	}
	if (!command.error) {
		prsPlacementDataset.commitChanges();
		L5.Msg.alert("提示","保存成功！");
		var soldiercommand=new L5.Command("com.inspur.cams.prs.prsretiredsoldiers.cmd.PrsRetiredSoldiersCommand"); 
		soldiercommand.setParameter("soldierId",prsPlacementRecord.get("soldierId"));
		soldiercommand.execute("updatePlacementFlag");
	}else{
		L5.Msg.alert("错误",command.error);
	}
}

function fun_Type(){
	var prsPlacementDataset=L5.DatasetMgr.lookup("prsPlacementDataset");
	var prsPlacementRecord = prsPlacementDataset.getCurrent();
	if((document.getElementById("employmentType").value=="1")){
		document.getElementById("applicationDate").disabled=false;
		document.getElementById("applicationDateimg").disabled=false;
		document.getElementById("grantGrant").disabled=false;
		document.getElementById("transactDate").disabled=false;
		document.getElementById("transactDateimg").disabled=false;
	}else if((document.getElementById("employmentType").value=="0")){
		if((document.getElementById("resettlementSituation").value=="30")){
			document.getElementById("applicationDate").disabled=false;
			document.getElementById("grantGrant").disabled=false;
			document.getElementById("transactDate").disabled=false;
		}else{
			document.getElementById("applicationDateimg").disabled=true;
			document.getElementById("applicationDate").disabled=true;
			document.getElementById("grantGrant").disabled=true;
			document.getElementById("transactDate").disabled=true;
			document.getElementById("transactDateimg").disabled=true;
			prsPlacementRecord.set("transactDate","");
			prsPlacementRecord.set("applicationDate","");
			prsPlacementRecord.set("grantGrant","");
		}
		if((document.getElementById("resettlementSituation").value=="20")){
			document.getElementById("archivesPerformanceScores").disabled=false;
			document.getElementById("culturalStudiesTestScores").disabled=false;
			document.getElementById("totalScore").disabled=false;
			document.getElementById("ranking").disabled=false;
		}else{
			document.getElementById("archivesPerformanceScores").disabled=true;
			document.getElementById("culturalStudiesTestScores").disabled=true;
			document.getElementById("totalScore").disabled=true;
			document.getElementById("ranking").disabled=true;
			
			prsPlacementRecord.set("archivesPerformanceScores","");
			prsPlacementRecord.set("culturalStudiesTestScores","");
			prsPlacementRecord.set("totalScore","");
			prsPlacementRecord.set("ranking","");
		}
	}
}
function employmentTypeChanges(){
	var employmentType = document.getElementById("employmentType").value;
	var prsPlacementDataset=L5.DatasetMgr.lookup("prsPlacementDataset");
	var prsPlacementRecord = prsPlacementDataset.getCurrent();
	if(employmentType =="0"){
		document.getElementById("applicationDate").disabled=true;
		document.getElementById("applicationDateimg").disabled=true;
		document.getElementById("grantGrant").disabled=true;
		document.getElementById("transactDate").disabled=true;
		document.getElementById("transactDateimg").disabled=true;
		document.getElementById("resettlement").style.display ="";
		document.getElementById("zmzyj").style.display ="";
		document.getElementById("jjbzj").style.display ="none";
		document.getElementById("archivesPerformanceScores").disabled=false;
		document.getElementById("culturalStudiesTestScores").disabled=false;
		document.getElementById("totalScore").disabled=false;
		document.getElementById("ranking").disabled=false;
	}else{
		document.getElementById("applicationDate").disabled=false;
		document.getElementById("applicationDateimg").disabled=false;
		document.getElementById("grantGrant").disabled=false;
		document.getElementById("transactDate").disabled=false;
		document.getElementById("transactDateimg").disabled=false;
		prsPlacementRecord.set("resettlementSituation","");
		document.getElementById("resettlement").style.display ="none";
		document.getElementById("zmzyj").style.display ="none";
		document.getElementById("jjbzj").style.display ="";
		document.getElementById("archivesPerformanceScores").disabled=true;
		document.getElementById("culturalStudiesTestScores").disabled=true;
		document.getElementById("totalScore").disabled=true;
		document.getElementById("ranking").disabled=true;
		prsPlacementRecord.set("archivesPerformanceScores","");
		prsPlacementRecord.set("culturalStudiesTestScores","");
		prsPlacementRecord.set("totalScore","");
		prsPlacementRecord.set("ranking","");
	}
}
 function back()
 {	
 	history.go(-1);
 }
function print(){
	var url='../print/reguIdenti_apptable.jsp?soldierId='+idField+'&type=02';
	window.showModalDialog(url,window);
}
function formatFloat(obj){
	var value = obj.value;
	if(value!=""){
		if(isFloat(value)||_isNum(value)){
			obj.value =formatNum(value)
		}else{
			L5.Msg.alert("提示",obj.name+"格式不正确！",function(){
				obj.value="";
				obj.focus();
			});
			return false ;
		}
	}
}
function checkRank(obj){
	var value = obj.value;
	if(value!=""){
		if(!_isNum(value)){
			L5.Msg.alert("提示",obj.name+"格式不正确！",function(){
				obj.value="";
				obj.focus();
			});
			return false ;
		}
	}
}