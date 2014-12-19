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
	var url = L5.webPath+"/jsp/cams/bpt/flow/disability/veteransshift/veteransShiftUpdate.jsp?peopleId="+peopleId+"&familyId="+familyId+"&applyId="+applyId+"&commitFlag=0";
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
		if(serviceType!="14"){
			allPanel.remove(introductTabPanel);
		}
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
			DisabilityApproveDataset.reload();
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
						//DisabilityApproveDataset.set("provinceCheckDisNature",disabilityCaseCode);
						DisabilityApproveDataset.set("provinceCheckDisNature",DisabilityApproveDataset.get("cityAduitDisabilityNature"));
					}else {
						DisabilityApproveDataset.set("provinceCheckDisNature",DisabilityApproveDataset.get("provinceCheckDisNature"));
					}	
					var provinceCheckDisLevel = DisabilityApproveDataset.get("provinceCheckDisLevel");
					if(provinceCheckDisLevel == "" || provinceCheckDisLevel == null) {
						//DisabilityApproveDataset.set("provinceCheckDisLevel",disabilityLevelCode);
						DisabilityApproveDataset.set("provinceCheckDisLevel",DisabilityApproveDataset.get("cityAduitDisabilityLevel"));
					}else {
						DisabilityApproveDataset.set("provinceCheckDisLevel",DisabilityApproveDataset.get("provinceCheckDisLevel"));
					}		
				}
				/*//省厅审核
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
						DisabilityApproveDataset.set("provinceAduitDisabilityNatu",disabilityCaseCode);
					}	
					var provinceAduitDisabilityLeve = DisabilityApproveDataset.get("provinceAduitDisabilityLeve");
					if(provinceAduitDisabilityLeve == "" || provinceAduitDisabilityLeve == null) {
						DisabilityApproveDataset.set("provinceAduitDisabilityLeve",disabilityLevelCode);
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
						DisabilityApproveDataset.set("provinceVerifyDisabilityNat",disabilityCaseCode);
					}	
					var provinceLevel = DisabilityApproveDataset.get("provinceLevel");
					if(provinceLevel == "" || provinceLevel == null) {
						DisabilityApproveDataset.set("provinceLevel",disabilityLevelCode);
					}	
				}*/
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
			   //L5.forward(url,"已办任务页面");
		   }else{
		      alert(command.error);
		  }
		  }
	 }
	}
}


function end() { //不予认定并结束
	var DisabilityApproveRecord=DisabilityApproveDataset.getCurrent();
   /* var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptDecisionLetterCommand");
	command.setParameter("applyId",applyId);
	command.execute("ifHave");
	var flag = command.getReturn("ifhave");
	if(!flag) {
		L5.Msg.alert("提示","请填写不予评定决定11111书");
		return false;
	}*/
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
		   //var url = "jsp/workflow/tasklist/queryyiban.jsp";
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
		}	
	}else if(applyFlagValue == '2') {
		pass.style.display="none";
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
			if(reportCode != "null") {
				var reportValue = record.get(reportCode);
				if(reportValue == null || reportValue == "") {
					L5.Msg.alert("提示","是否上报不能为空");
					return false;
				}
				ifReport = reportValue;
			} else {
				ifReport = 0; // 省级
			}	
		}
	} 
	return true;
}


function print() {
	var content;
	var flag ;
	var path ;
	var changeContent;
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyDisabilityCommand");
	command.setParameter("applyId",applyId);
	command.execute("chkSaveOfBudty");
	var saveFlag = command.getReturn("saveFlag");
	if(saveFlag=='0'){
		L5.Msg.alert('提示！','未保存，请先保存！');
		return false;
	}else{
		var DisabilityApproveDataset = L5.DatasetMgr.lookup("DisabilityApproveDataset");
		var newDisabilityNo = command.getReturn("newDisabilityNo"); 
		var idCard = command.getReturn("idCard");
		var domicileName = command.getReturn("domicileName");
		var disLevel = DisabilityApproveDataset.get("provinceCheckDisLevel");
		if(disLevel=='01'){
			disLevel = '一级';
		}else if(disLevel=='02'){
			disLevel = '二级';
		}else if(disLevel=='03'){
			disLevel = '三级';
		}else if(disLevel=='04'){
			disLevel = '四级';
		}else if(disLevel=='05'){
			disLevel = '五级';
		}else if(disLevel=='06'){
			disLevel = '六级';
		}else if(disLevel=='07'){
			disLevel = '七级';
		}else if(disLevel=='08'){
			disLevel = '八级';
		}else if(disLevel=='09'){
			disLevel = '九级';
		}else if(disLevel=='10'){
			disLevel = '十级';
		}
		var disCase = DisabilityApproveDataset.get("provinceCheckDisNature");
		if(disCase=='1'){
			disCase = '因战';
		}else if(disCase=='2'){
			disCase = '因公';
		}else if(disCase=='3'){
			disCase = '因病';
		}
		content = "身份证号码为：\\n"+idCard+"\\n"+"户籍地为："+domicileName+"\\n"+"伤残等级为："+disLevel+"\\n"+
			      "伤残性质为："+disCase+"\\n"+"编号为："+newDisabilityNo;
	}
	var getValue = window.showModalDialog('../../../jsp/cams/bpt/flow/disability/selectLeftOrRightPrint.jsp?changeContent='+escape(encodeURIComponent(content)), 'newwindow','dialogWidth=450px;dialogHeight=360px','location:no');
	if(getValue!=""&&getValue!=undefined){
		var list = getValue.split(";");
		flag = list[1];
		changeContent = decodeURI(list[2]);
		if(flag == "0") { //左边栏
			path = "jsp/cams/bpt/flow/disability/exchacertidisa/print/disleft.doc";
			change(path,changeContent);
		} else  if(flag == "1") { //右边栏
			path = "jsp/cams/bpt/flow/disability/exchacertidisa/print/disright.doc";
			change(path,changeContent);
		} else if (flag == "3") {
			print1();
		}
	}
}
function change(path,changeContent) {
	var date=new Date();
	var year=""+date.getFullYear();
	var month=date.getMonth()+1;
	if(month<10)
		{month="0"+month;}
	document.getElementById("docPath").value = path;
	document.getElementById("printYear").value = year;
	document.getElementById("printMonth").value = month;
	document.getElementById("changeContent").value = changeContent ;
	var url=L5.webPath+"/jsp/cams/comm/print/print_noDataSet.jsp";
	var width = 1024;
	var height = 768;
    window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
}
function print1() {
	var docpath = "jsp/cams/bpt/peopleBasicInfo/table/disabilityJR_apptable.doc";
	document.getElementById("objectType").value = '11';
	document.getElementById("docpath").value = docpath;
	document.getElementById("peopleId").value = peopleId;
	document.getElementById("ntkoPrintapplyId").value = applyId
	document.getElementById("bptQueryPathServiceType").value='11';
	var url=L5.webPath+"/jsp/cams/comm/print/jspcommonprint.jsp";
	var width = 1024;
	var height = 768;
    window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	window.close();
}
