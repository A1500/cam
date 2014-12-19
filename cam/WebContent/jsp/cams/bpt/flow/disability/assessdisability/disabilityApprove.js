var disabilityCaseCode
var disabilityLevelCode;
var currentDate = getCurDate();
var updateFlag = true;
var updateUrl = "../../../jsp/cams/bpt/comm/uploadfileDetail.jsp?peopleId="+peopleId +"&applyId="+applyId+"&serviceType=";
var record_disabilityCaseCode="";
var record_disabilityLevelCode="";
var applyFlag = ""; //审批意见
var ifReport = ""; //是否上报
var currentField = "TownVerify"; // 当前有效域

function updateInfo() { // 若流程为第一环节则可修改
	var width = screen.width-100;
    var height = screen.height-140;
    var url;
    if(serviceType=='11'){//评残
    	url = L5.webPath+"/jsp/cams/bpt/flow/disability/assessdisability/disabilityUpdateManage.jsp?peopleId="+peopleId+"&familyId="+familyId+"&applyId="+applyId;
    }else if(serviceType=='12'){//调残 	
    	url = L5.webPath+"/jsp/cams/bpt/flow/disability/adjustdisability/adjustDisabilityUpdate.jsp?peopleId="+peopleId+"&familyId="+familyId+"&applyId="+applyId;
    }
	var returnValue = window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	window.location.reload();
}

 
function setPanel() { //根据不同的业务类型显示不同的panel
	updateUrl +=serviceType;
	var allPanel = L5.getCmp("allPanel");
	var ass_dis_appTabPanel = L5.getCmp("ass_dis_appTabPanel");
	var introductTabPanel = L5.getCmp("introductTabPanel");
	var acceptTabPanel = L5.getCmp("acceptTabPanel");
	var open_dis_appTabPanel = L5.getCmp("open_dis_appTabPanel");
	var decisionLetterTabPanel = L5.getCmp("decisionLetterTabPanel");
	var exchaTable = L5.getCmp("exchaTable");
	var changeTable = L5.getCmp("changeTable");
	var intoTable = L5.getCmp("intoTable");
	
	if(serviceType=="11" || serviceType=="12"){ //伤残评残或调残
		allPanel.remove(exchaTable);
		allPanel.remove(changeTable);
		allPanel.remove(intoTable);
	}else {
		allPanel.remove(ass_dis_appTabPanel);
		allPanel.remove(introductTabPanel);
		allPanel.remove(acceptTabPanel);
		allPanel.remove(open_dis_appTabPanel);
		allPanel.remove(decisionLetterTabPanel);
		if(serviceType=="13"){
			  allPanel.remove(changeTable);
			  allPanel.remove(intoTable);
		}else if(serviceType=="14"){
			  allPanel.remove(exchaTable);
			  allPanel.remove(changeTable);
		}else if(serviceType=="18"){
			  allPanel.remove(exchaTable);
			  allPanel.remove(intoTable);
		}
	}	
}

function setFrameUrl() {
	if(updateFlag) {
		document.getElementById("upload").src=updateUrl;
		updateFlag = false;
	}
}   


function save(){
	var DisabilityApproveDataset = L5.DatasetMgr.lookup("DisabilityApproveDataset");
	var DisabilityApproveRecord=DisabilityApproveDataset.getCurrent();
		var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyDisabilityCommand");
		command.setParameter("record", DisabilityApproveRecord);
		if(record_disabilityCaseCode != "") {
	  		command.setParameter("disabilityCaseCode",record_disabilityCaseCode);
	   }
	   if(record_disabilityLevelCode != "") {
	  		command.setParameter("disabilityLevelCode",record_disabilityLevelCode);
	   }
		command.execute("update");
		if (!command.error) {
			DisabilityApproveDataset.commitChanges();
			L5.Msg.alert('提示',"数据保存成功!");
		}else{
			L5.Msg.alert('提示',"保存时出现错误！"+command.error);
		}
}

 
// 设置默认值
function sip(DisabilityApproveDataset,fieldId,isHidden,isReadOnly) {
		var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.WfProcessBusinessCommand");
		command.setParameter("applyId",applyId);
		command.execute("validateIfback");
		var ifback = command.getReturn("ifback");
				//市级审核
				if(fieldId=="CityVerify"&&isHidden=="0"&&isReadOnly=="0"){
					var cityAduitApproveDate = DisabilityApproveDataset.get("cityAduitApproveDate");
					if(ifback){
						DisabilityApproveDataset.set("cityAduitApproveDate",currentDate);
					}else if(cityAduitApproveDate == "" || cityAduitApproveDate == null) {
						DisabilityApproveDataset.set("cityAduitApproveDate",currentDate);
					}	
					
					var cityAduitIncharge = DisabilityApproveDataset.get("cityAduitIncharge");
					if(cityAduitIncharge == "" || cityAduitIncharge == null) {
						DisabilityApproveDataset.set("cityAduitIncharge",currentUserName);
					}
					var cityAduitDisabilityNature = DisabilityApproveDataset.get("cityAduitDisabilityNature");
					if(cityAduitDisabilityNature == "" || cityAduitDisabilityNature == null) {
						DisabilityApproveDataset.set("cityAduitDisabilityNature",DisabilityApproveDataset.get("townAduitDisabilityNature"));
					}
					var cityAduitDisabilityLevel = DisabilityApproveDataset.get("cityAduitDisabilityLevel");
					if(cityAduitDisabilityLevel == "" || cityAduitDisabilityLevel == null) {
						DisabilityApproveDataset.set("cityAduitDisabilityLevel",DisabilityApproveDataset.get("townAduitDisabilityLevel"));
					}	
				}
				//省级受理
				if(fieldId=="ProvinceAccept"&&isHidden=="0"&&isReadOnly=="0"){
					var provinceCheckDate = DisabilityApproveDataset.get("provinceCheckDate");
					if(ifback){
						DisabilityApproveDataset.set("provinceCheckDate",currentDate);
					}else if(provinceCheckDate == "" ||  provinceCheckDate == null ) {
						DisabilityApproveDataset.set("provinceCheckDate",currentDate);
					}
					var provinceCheckPeopleId = DisabilityApproveDataset.get("provinceCheckPeopleId");
					if(provinceCheckPeopleId == "" || provinceCheckPeopleId == null) {
						DisabilityApproveDataset.set("provinceCheckPeopleId",currentUserName);
					}	
					var provinceCheckDisNature = DisabilityApproveDataset.get("provinceCheckDisNature");
					if(provinceCheckDisNature == "" || provinceCheckDisNature == null) {
						DisabilityApproveDataset.set("provinceCheckDisNature",DisabilityApproveDataset.get("cityAduitDisabilityNature"));
					}	
					var provinceCheckDisLevel = DisabilityApproveDataset.get("provinceCheckDisLevel");
					if(provinceCheckDisLevel == "" || provinceCheckDisLevel == null) {
						DisabilityApproveDataset.set("provinceCheckDisLevel",DisabilityApproveDataset.get("cityAduitDisabilityLevel"));
					}	
					
				}
				//省厅审核
				if(fieldId=="ProvinceVerify"&&isHidden=="0"&&isReadOnly=="0"){
					var provinceAduitApproveDate = DisabilityApproveDataset.get("provinceAduitApproveDate");
					if(ifback){
						DisabilityApproveDataset.set("provinceAduitApproveDate",currentDate);
					}else if(provinceAduitApproveDate == "" || provinceAduitApproveDate == null) {
						DisabilityApproveDataset.set("provinceAduitApproveDate",currentDate);
					}	
					
					var provinceAduitIncharge = DisabilityApproveDataset.get("provinceAduitIncharge");
					if(provinceAduitIncharge == "" || provinceAduitIncharge == null) {
						DisabilityApproveDataset.set("provinceAduitIncharge",currentUserName);
					}	
					
					var provinceAduitDisabilityNatu = DisabilityApproveDataset.get("provinceAduitDisabilityNatu");
					if(provinceAduitDisabilityNatu == "" || provinceAduitDisabilityNatu == null) {
						DisabilityApproveDataset.set("provinceAduitDisabilityNatu",DisabilityApproveDataset.get("provinceCheckDisNature"));
					}	
					
					var provinceAduitDisabilityLeve = DisabilityApproveDataset.get("provinceAduitDisabilityLeve");
					if(provinceAduitDisabilityLeve == "" || provinceAduitDisabilityLeve == null) {
						DisabilityApproveDataset.set("provinceAduitDisabilityLeve",DisabilityApproveDataset.get("provinceCheckDisLevel"));
					}	
					
				}
				//省厅审批
				if(fieldId=="ProvinceApprove"&&isHidden=="0"&&isReadOnly=="0"){
					var provinceApproveDate = DisabilityApproveDataset.get("provinceApproveDate");
					if(provinceApproveDate == "" || provinceApproveDate == null) {
						DisabilityApproveDataset.set("provinceApproveDate",currentDate);
					}	
					
					var provinceIncharge = DisabilityApproveDataset.get("provinceIncharge");
					if(provinceIncharge == "" || provinceIncharge == null) {
						DisabilityApproveDataset.set("provinceIncharge",currentUserName);
					}	
					
					var provinceVerifyDisabilityNat = DisabilityApproveDataset.get("provinceVerifyDisabilityNat");
					if(provinceVerifyDisabilityNat == "" || provinceVerifyDisabilityNat == null) {
						DisabilityApproveDataset.set("provinceVerifyDisabilityNat",DisabilityApproveDataset.get("provinceAduitDisabilityNatu"));
					}	
					
					var provinceLevel = DisabilityApproveDataset.get("provinceLevel");
					if(provinceLevel == "" || provinceLevel == null) {
						DisabilityApproveDataset.set("provinceLevel",DisabilityApproveDataset.get("provinceAduitDisabilityLeve"));
					}	
				}
}

 

//发送流程
function send(){
	var DisabilityApproveRecord=DisabilityApproveDataset.getCurrent();
	if(validateNotNull(DisabilityApproveRecord,"")){
	  if(checkProcessState("send")){
	   if(currentField == "TownVerify") {
	   	  applyFlag = DisabilityApproveRecord.get("townFlag");
	   	  ifReport = DisabilityApproveRecord.get("townReport");
	   }
	   if(applyFlag == 1 && ifReport == 0) {
	   		end();
	   } else {
		   var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyDisabilityCommand");
		   //执行发送流程方法
		   command.setParameter("applyId",applyId);
		   command.setParameter("serviceType",DisabilityApproveDataset.get("serviceType"));
		   command.setParameter("peopleId",DisabilityApproveDataset.get("peopleId"));
		   command.setParameter("condition","pass");
		   command.setParameter("actDefName",actDefName);
		   command.setParameter("currentField",currentField);
		   command.setParameter("record", DisabilityApproveRecord);
		   /*
		   if(record_disabilityCaseCode != "") {
		  		command.setParameter("disabilityCaseCode",record_disabilityCaseCode);
		   }
		   if(record_disabilityLevelCode != "") {
		  		command.setParameter("disabilityLevelCode",record_disabilityLevelCode);
		   }
		   */
		   
		   command.execute("send");
		   if(!command.error){
			   alert("成功发送到下一环节!");	
			   window.close();
			   window.returnValue = "success";	
			   //跳转到已办任务页面
			   //var url = "jsp/cams/bpt/flow/queryyiban_bpt.jsp";
			   // L5.forward(url,"已办任务页面");
		   }else{
		      alert(command.error);
		  }
		  }
	 }
	}
}


function end() { //不予认定并结束
	var DisabilityApproveRecord=DisabilityApproveDataset.getCurrent();
    var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptDecisionLetterCommand");
	command.setParameter("applyId",applyId);
	command.execute("ifHave");
	var flag = command.getReturn("ifhave");
	if(!flag) {
		L5.Msg.alert("提示","请填写不予评定决定书");
		return false;
	}
	 var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyDisabilityCommand");
	   //执行发送流程方法
	   command.setParameter("serviceType",DisabilityApproveDataset.get("serviceType"));
	   command.setParameter("peopleId",DisabilityApproveDataset.get("peopleId"));
	   command.setParameter("condition","end");
	   command.setParameter("currentField",currentField); 
	   command.setParameter("applyId",applyId);
	   command.setParameter("actDefName",actDefName);
	   command.setParameter("record", DisabilityApproveRecord);
	   command.execute("send");
	   if(!command.error){
		   alert("成功发送到下一环节!");	
		   window.close();
		   window.returnValue = "success";	
		   //跳转到已办任务页面
		   //var url = "jsp/cams/bpt/flow/queryend_bpt.jsp";
		   //L5.forward(url,"已办任务页面");
	   }else{
	      alert(command.error);
	  }
}



//查看流转状态图
function showState(){
	 var url = L5.webPath+"/jsp/workflow/monitor/flowview.jsp?procDefUniqueId="
	      +procDefUniqueId+"&assignmentId="+assignmentId+"&isShowBackBtn=false";
	 showModalDialog(url, window,
	 	"scroll:yes;resizable:yes;dialogWidth:900px;dialogHeight:600px");	  	 
}
//回退流程
function back(){
	var DisabilityApproveRecord=DisabilityApproveDataset.getCurrent();
	if(validateNotNull(DisabilityApproveRecord,"back")){
	var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyDisabilityCommand");
	   //执行发送流程方法
	   command.setParameter("applyId",applyId);
	   command.setParameter("record", DisabilityApproveRecord);
	   command.setParameter("actDefName",actDefName);
	   command.setParameter("currentField",currentField); 
	   command.execute("back");
	   if(!command.error){
		   alert("成功回退流程!");	
		   window.close();
		   window.returnValue = "success";	
		   //跳转到已办任务页面
		   // var url = "jsp/cams/bpt/flow/queryyiban_bpt.jsp";
		   //L5.forward(url,"已办任务页面");
	   }else{
	      alert(command.error);
	   }
	} 
}


//检查流程状态
function checkProcessState(method){
	var urlDataString=document.URL.split("?")[1];
	var dataArr=urlDataString.split("&");
	var hasAssignmentId=false;
	for(i=0;i<dataArr.length;i++)
	{
		var data=dataArr[i].split("=");
		if(data[0]=="assignmentId")
		{
			if(method=="create"||method=="createAndSend")
			{
				alert("该流程已经创建！");
				return false;
			}
			hasAssignmentId=true;
		}
	}
	if(!hasAssignmentId)
	{
		if(method!="create"&&method!="createAndSend")
		{
			alert("该流程还没有创建！请先创建流程！");
			return false;
		}
	}
	return true;
}

//获得当前日期 
function getCurDate(){
	var date=new Date();
	var year=""+date.getFullYear();
	var month=date.getMonth()+1;
	if(month<10){month="0"+month;}
	var day = date.getDate();
	if(day<10){day = "0"+day;}
	return year+"-"+month+"-"+day;
}


// 控制div的隐藏与显示
function changeAppDiv(id) {
	var applyFlag =  document.getElementById(id+"Flag");
	var applyFlagValue = applyFlag.value;
	var pass =  document.getElementById(id+"Pass");
	var end =   document.getElementById(id+"End");
	if(applyFlagValue == null || applyFlagValue == "") {
		pass.style.display="none";
		if(end != null) {
			end.style.display="none";
		}
	} else if(applyFlagValue == '0') {
		pass.style.display="";
		if(end != null) {  
			end.style.display="none";
		}	
	} else if(applyFlagValue == '1') {
		pass.style.display="none";
		if(end != null) { 
			end.style.display="";
			var Report = DisabilityApproveDataset.get("cityReport");
			if(Report == null || Report == "" ) {
				DisabilityApproveDataset.set("cityReport","0");
			}
		}	
	} else if(applyFlagValue == '2') {
		pass.style.display="";
		if(end != null) {  
			end.style.display="none";
		}	
	}
}
//校验select（是否上报或者伤残性质、伤残等级）
function validateSelect(typeCode,value,record) {
	if(typeCode.indexOf(":") != -1) {
		var typeCodes = typeCode.split(":");
		var caseCode = typeCodes[0]; //伤残性质
		var levelCode = typeCodes[1]; //伤残等级
		var reportCode = typeCodes[2];// 是否上报
		if(value == 0) { // 同意审批
			var caseValue = record.get(caseCode);
			if(caseValue == null || caseValue == "") {
				L5.Msg.alert("提示","伤残性质不能为空");
				return false;
			} 
			var levelValue = record.get(levelCode);
			if(levelValue == null || levelValue == "") {
				L5.Msg.alert("提示","申报等级不能为空");
				return false;
			}
			
		} else if(value == 1) {
			if(reportCode != "null" && reportCode != "province_report") {
				var reportValue = record.get(reportCode);
				if(reportValue == null || reportValue == "") {
					L5.Msg.alert("提示","是否上报不能为空");
					return false;
				}
				ifReport = reportValue;
			} else if(reportCode == "null"){ //省级审批
				ifReport = 0; // 省级
			} else if(reportCode == "province_report") {//省级初审以及省级复审(若不予评定，则上报)
				ifReport = 1;
			}
		}
	} 
	return true;
}
