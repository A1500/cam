<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.workflow.api.WfQuery"%>
<%@page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%
String peopleId = request.getParameter("peopleId");
String applyId = request.getParameter("applyId");
String familyId = request.getParameter("familyId");
String serviceType = request.getParameter("serviceType");
%>
<html>
<head>
<title>审批</title>
<next:ScriptManager />
<script><!--
		var currentUserName = '<%= GetBspInfo.getBspInfo().getUserName()%>';
		var currentDate = getCurDate();
		var state;
		var applyId='<%=applyId%>';
			var ifsave = true;
			
			
			var idField='<%=request.getParameter("dataBean")%>';
			var method='<%=request.getParameter("method")%>';
			<%
						String primaryKey=request.getParameter("primaryKey");
					    if(primaryKey==null)
					    	primaryKey="";
					%>
					<%
						String assignmentId=(String)request.getParameter("assignmentId");
						String procDefUniqueId=(String)request.getParameter("procDefUniqueId");
						String actDefUniqueId=(String)request.getParameter("actDefUniqueId");
						//然调用接口
						WfQuery wfQuery = new WfQuery();
						List<Map> list = wfQuery.getActButtons(actDefUniqueId);
						List<Map> list1= wfQuery.getActFields(actDefUniqueId);
						
						Map actMap = wfQuery.getActivityDefInfoByActDefUniqueId(actDefUniqueId);
						String actDefName = (String)actMap.get("actDefName");
						//遍历list，如果该页面上某个域是需要隐藏的，则设置该域为不显示
						//如果域是只读的则显示为只读
						//如果是非空的，则在点击按钮时进行校验 ，若为空弹出提示框
						String fieldId,fieldName,isHidden,isReadOnly,isNotNull;
						//boolean isHidden,isReadOnly,isNotNull;
					%>
					var processId = '<%= (String)request.getParameter("processId")%>';
					var procDefUniqueId = '<%= (String)request.getParameter("procDefUniqueId")%>';
					var assignmentId="<%=assignmentId%>";
					var currentUserName = '<%= GetBspInfo.getBspInfo().getUserName()%>';
					var actDefName = '<%=actDefName%>';
					var serviceType = '<%=serviceType%>';
					var peopleId = '<%=peopleId%>';
					var familyId = '<%=familyId%>';
					var actDefName = '<%=actDefName%>';
			var url;
			var url1;
			var first = true;
			var currentField = "TownVerify"; // 当前有效域
function init() {
		var approveTabPanel = L5.getCmp("approveTabPanel");
	approveTabPanel.setTitle('<%=actDefName%>');
						var ds = L5.DatasetMgr.lookup("ds");
										 
							ds.setParameter("APPLY_ID",'<%=applyId%>');
							
							ds.load();
							var typePanel1 = L5.getCmp("typeTabPanel"); // 设置类别信息url
							typePanel1.on("activate",setPanel); // 设置类别信息panel的隐藏
							typePanel1.on("activate",funcFrameUrl);
							var decisionLetterTabPanel = L5.getCmp("decisionLetterTabPanel"); // 设置决定书信息url
							decisionLetterTabPanel.on("activate",setDecisionPanel); // 设置决定书panel的隐藏
							var tabpanel = L5.getCmp("approveTabPanel");
							tabpanel.on("activate",setHide);
							if('<%=serviceType%>'=="45"){
								var physicalPanel = L5.getCmp("physicalPanel");
								physicalPanel.on("activate",setExamePanel); // 设置体检书panel的隐藏
								var checkPanel = L5.getCmp("checkPanel");
								checkPanel.on("activate",setCheckPanel); // 设置送检表panel的隐藏
							}else{
								var physicalPanel = L5.getCmp("physicalPanel");
								var checkPanel = L5.getCmp("checkPanel");
								var flow1 = L5.getCmp("flow1");
								flow1.remove(physicalPanel);
								flow1.remove(checkPanel);
							}
							//设置审批表路径
							var demobilized_appTabPanel = L5.getCmp("demobilized_appTabPanel");
							demobilized_appTabPanel.on("activate",function(){
								var serviceType ='<%=serviceType%>';
								var openUrl;
								if(serviceType=="41"){      
									openUrl=L5.webPath+"/jsp/cams/bpt/flow/demobilized/applydemobilized/print/demobilizedApp_table.jsp?peopleId=<%=request.getParameter("peopleId")%>&applyId=<%=applyId%>";
									}
								if(serviceType=="45"){
									openUrl=L5.webPath+"/jsp/cams/bpt/flow/demobilizedillness/table/demobilized_apptable.jsp?peopleId=<%=peopleId%>&applyId=<%=applyId%>";
									}
								document.getElementById("apptable").src=openUrl;
							});
							var openletter = L5.getCmp("openletter");
							openletter.on("activate",setOpenPanel); // 设置决定书panel的隐藏
					}
	function funcFrameUrl() { //类别信息url跳转
					if(first) {
						document.getElementById("typeFrame").src=url;
						first = false;
					}	
				}
	function setOpenPanel() { //设置公示书url
		var serviceType ='<%=serviceType%>';
		var openUrl;
		if(serviceType=="41"){      
			openUrl=L5.webPath+"/jsp/cams/bpt/flow/demobilized/applydemobilized/openDemoDetail.jsp?peopleId=<%=request.getParameter("peopleId")%>&applyId=<%=applyId%>";
			}
		if(serviceType=="45"){
			openUrl=L5.webPath+"/jsp/cams/bpt/flow/demobilizedillness/applydemobilizedillness/openDemoIllDetail.jsp?peopleId=<%=peopleId%>&applyId=<%=applyId%>";
			}
		document.getElementById("openletter1").src=openUrl;
		}	
	function setDecisionPanel() { //设置决定书panel的隐藏
		var serviceType ='<%=serviceType%>';
		if(serviceType=="41"){    
			url1=L5.webPath+"/jsp/cams/bpt/flow/demobilized/applydemobilized/demoDecisionLetterUpdate.jsp?peopleId=<%=peopleId%>&applyId=<%=applyId%>";
			
			}
		if(serviceType=="45"){
			url1=L5.webPath+"/jsp/cams/bpt/flow/demobilizedillness/applydemobilizedillness/demoIllnessDecisionLetterUpdate.jsp?peopleId=<%=peopleId%>&applyId=<%=applyId%>";
			}
		document.getElementById("decisionTabPanel").src=url1;
		}	
	function setExamePanel() { //设置体检表url
		var serviceType ='<%=serviceType%>';
		var exameUrl;
		if(serviceType=="45"){
			exameUrl=L5.webPath+"/jsp/cams/bpt/flow/demobilizedillness/applydemobilizedillness/bptphysicalexamination/bptphysicalexamination_deatil.jsp?peopleId=<%=peopleId%>&applyId=<%=applyId%>";
			}
		document.getElementById("physical").src=exameUrl;
		}	
	function setCheckPanel() { //设置送检书url
		var serviceType ='<%=serviceType%>';
		var checkUrl;
		if(serviceType=="45"){
			checkUrl=L5.webPath+"/jsp/cams/bpt/flow/demobilizedillness/applydemobilizedillness/bptphysicalexamination/bptDemobilizedillCheck_deatil.jsp?peopleId=<%=peopleId%>&applyId=<%=applyId%>";
			}
		document.getElementById("check").src=checkUrl;
		}
	function setPanel() { //设置类别信息panel的隐藏
		var serviceType ='<%=serviceType%>';
		if(serviceType=="41"){    
			url=L5.webPath+"/jsp/cams/bpt/flow/demobilized/applydemobilized/demobilizedInfo.jsp?peopleId=<%=peopleId%>";
		}
		if(serviceType=="45"){
			url = L5.webPath + "/jsp/cams/bpt/flow/demobilizedillness/applydemobilizedillness/demobilizedIllnessInfo.jsp?peopleId=<%=peopleId%>";
		}
		}
		
//查看流转状态图
function showState(){    
	 var url = L5.webPath+"/jsp/workflow/monitor/flowview.jsp?procDefUniqueId="
	      +procDefUniqueId+"&assignmentId="+assignmentId+"&isShowBackBtn=false";
	 showModalDialog(url, window,
	 	"scroll:yes;resizable:yes;dialogWidth:900px;dialogHeight:600px");	  	 
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
		//校验非空的域是否为空
function validateNotNull(){
	<%
	for(int i=0;i<list1.size();i++){
		Map map1=(Map)list1.get(i);
		fieldId=(String)map1.get("fieldId");
		fieldName=(String)map1.get("fieldName");
		isNotNull=(String)map1.get("isNotNull");
		//如果限制为非空，未输入值点击按钮时弹出提示框
		if("1".equals(isNotNull)){
			%>
			var target=document.getElementById("<%=fieldId%>");
			currentField = "<%=fieldId%>";
			if(target){
				var inputs = target.getElementsByTagName("input");
				for(var i=0;i<inputs.length;i++) {
					 if(inputs[i].type=="text") {
					 	  var inputValue = inputs[i].value;
						  if(inputValue == null || inputValue == "") {
						  	  alert(inputs[i].getAttribute("validateName")+"不能为空!");
						  	  return false;
						  }
					 }
				}
				var selects = target.getElementsByTagName("select");
				for(var i=0;i<selects.length;i++) {	
					 	  var inputValue = selects[i].value;
						  if(inputValue == null || inputValue == "") {
						  	  alert(selects[i].getAttribute("validateName")+"不能为空!");
						  	  return false;
						  }
				}
			}
			<%			
		}		
	}
	%>	
	return true;
}
function save(){
	if(validateNotNull()){
			var ds = L5.DatasetMgr.lookup("ds");
		    var records = ds.getCurrent();
		    var trialDate = document.getElementById("trialDate").value;
	if(trialDate!=''&&!validateDateFormat(trialDate)){
		L5.Msg.alert("提示","初审日期格式不正确！");
		return false;
	}
	
	var reviewDate = document.getElementById("reviewDate").value;
	if(reviewDate!=''&&!validateDateFormat(reviewDate)){
		L5.Msg.alert("提示","复审日期格式不正确！");
		return false;
	}
	
	var approvalDate = document.getElementById("approvalDate").value;
	if(approvalDate!=''&&!validateDateFormat(approvalDate)){
		L5.Msg.alert("提示","审批日期格式不正确！");
		return false;
	}
			var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.DemobilizedflowCommand"); 
			command.setParameter("records",records);
			command.execute("save");	
			if (!command.error) {
				L5.Msg.alert('提示',"保存成功!");
			}else {
			L5.Msg.alert('提示',"保存失败!");
			}
		}		
		}
function myValidate(){
	if(validateNotNull()){
	    var trialDate = document.getElementById("trialDate").value;
		if(trialDate!=''&&!validateDateFormat(trialDate)){
			L5.Msg.alert("提示","初审日期格式不正确！");
			return false;
		}
		
		var reviewDate = document.getElementById("reviewDate").value;
		if(reviewDate!=''&&!validateDateFormat(reviewDate)){
			L5.Msg.alert("提示","复审日期格式不正确！");
			return false;
		}
		
		var approvalDate = document.getElementById("approvalDate").value;
		if(approvalDate!=''&&!validateDateFormat(approvalDate)){
			L5.Msg.alert("提示","审批日期格式不正确！");
			return false;
		}
	}		
}
	//修改退回流程中人员基本信息
	 function updateInfo(){
		 var urlPath="";
		 <%
		 if(serviceType.equals("45")){
		 %>
			urlPath="../../../jsp/cams/bpt/flow/demobilizedillness/applydemobilizedillness/demobilizedIllnessUpdateManage.jsp?method=UPDATE&peopleId=<%=peopleId%>&familyId=<%=familyId%>&applyId="+applyId;
		<%}
		 if(serviceType.equals("41")){
		 %>
			urlPath="../../../jsp/cams/bpt/flow/demobilized/applydemobilized/demobilizedUpdateManage.jsp?method=UPDATE&peopleId=<%=peopleId%>&familyId=<%=familyId%>&applyId="+applyId;
		<%}%>
			var width = screen.width-100;
		    var height = screen.height-140;
			var win = window.showModalDialog (urlPath,window,"scroll:no;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
		 	var das = L5.DatasetMgr.lookup("ds");
		 	das.reload();
		 	
		 }
		 
		 function validateDateFormat(date) {
	if (!((/^\d{4}-\d{2}-\d{2}$/).test(date))) {
		return false;
	}
	var r = date.match(/\d{1,4}/g);
	if (r == null) {
		return false;
	};
	var d = new Date(r[0], r[1] - 1, r[2]);
	return (d.getFullYear() == r[0] && (d.getMonth() + 1) == r[1] && d
			.getDate() == r[2]);
}

/* function getTimes(item) {
	LoushangDate(item.previousSibling);
} */
		 
		 	
		//不予认定并结束流程
		
		
		
	function sendOver(){
 	
		//判断是否填写公示书
	   	  var commandifHave=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptDecisionLetterCommand");
	   	  commandifHave.setParameter("applyId",'<%=applyId%>');
	   	  commandifHave.execute("ifHave");
	   	  var ifhave = commandifHave.getReturn("ifhave");
	   	  if(!ifhave){
	   	  	alert("请先填写不予评定决定书");
	   	  	var approveTabPanel = L5.getCmp("flow1"); // 设置决定书信息url
	   	  	approveTabPanel.setActiveTab("decisionLetterTabPanel");
	 		return false;
		  }
					  if(checkProcessState("send")){
					   var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.DemobilizedflowCommand");
					   //执行发送流程方法
					   var ds = L5.DatasetMgr.lookup("ds");
					   var records = ds.getCurrent();
						 command.setParameter("applyId",'<%=applyId%>');
						 command.setParameter("records",records);
					   command.setParameter("assignmentId",assignmentId);
					   command.setParameter("serviceType",'<%=serviceType%>');
					   command.setParameter("peopleId",'<%=peopleId%>');
					   command.setParameter("condition",'1');
					   command.setParameter("actDefName",actDefName);
		  				command.setParameter("currentField",currentField);
					   command.execute("send");
					   if(!command.error){
						   alert("不予认定并结束流程，成功!");		  
						   //跳转到已办任务页面
						   var url = "jsp/workflow/tasklist/queryyiban.jsp";
						   L5.forward(url,"已办任务页面");
					   }else{
					      alert("不予认定并结束流程，失败!"+command.error);
					  }
					 }
				//	}
				}
//发送流程
function send(){
	if(validateNotNull()){
		var ds = L5.DatasetMgr.lookup("ds");
		 if(checkProcessState("send")){
		 	var cityApplyFlag;
		 	if(currentField == "city") {
		  		cityApplyFlag = ds.getCurrent().get("cityFlag");
		 	}
		 	if(cityApplyFlag=="1") {
	  			sendOver();
	 		} else {
			   var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.DemobilizedflowCommand");
			   //执行发送流程方法
			   var records= ds.getCurrent();
				 command.setParameter("applyId",'<%=applyId%>');
				 command.setParameter("records",records);
			   command.setParameter("assignmentId",assignmentId);
			   command.setParameter("serviceType",'<%=serviceType%>');
			   command.setParameter("peopleId",'<%=peopleId%>');
			    command.setParameter("condition",'0');
			   command.setParameter("actDefName",actDefName);
			   command.setParameter("currentField",currentField);
			   command.execute("send");
			   if(!command.error){
			   	   window.close();
			   	   window.returnValue = "success";
				   //alert("成功发送到下一环节!");		  
				   //跳转到已办任务页面
				   //var url = "jsp/workflow/tasklist/queryyiban.jsp";
				   //L5.forward(url,"已办任务页面");
			   }else{
			      alert(command.error);
			   }
			 }
		}
	}
}
//回退流程
function back(){
		if(validateNotNull()){
			var ds = L5.DatasetMgr.lookup("ds");
			var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.DemobilizedflowCommand");
			command.setParameter("applyId",'<%=applyId%>');
			 command.setParameter("assignmentId",assignmentId);
			 var records = ds.getCurrent();
			 command.setParameter("records",records);
			 command.setParameter("actDefName",actDefName);
	   		command.setParameter("currentField",currentField); 
			   //执行发送流程方法
			   command.execute("back");
			   if(!command.error){
				   alert("成功回退流程!");	
				   window.close();
				   window.returnValue = "success";	  
				   //跳转到已办任务页面
				   // var url = "jsp/workflow/tasklist/queryyiban.jsp";
				   //L5.forward(url,"已办任务页面");
			   }else{
			      alert("流程退回失败！"+command.error);
			   }
		}	
		}
		//设置环节域的隐藏
function setHide(){
		var ds = L5.DatasetMgr.lookup("ds");
		var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.WfProcessBusinessCommand");
		command.setParameter("applyId",'<%=applyId%>');
		command.execute("validateIfback");
		var ifback = command.getReturn("ifback");
	<%
	//遍历list1
	for(int i=0;i<list1.size();i++){
		Map map1=(Map)list1.get(i);
		fieldId=(String)map1.get("fieldId");
	 
		isHidden=(String)map1.get("isHidden");
		isReadOnly=(String)map1.get("isReadOnly");
		 
		//如果需要隐藏，则设置隐藏域的style为none
	%>
				var fieldId = '<%=fieldId%>';
				var isHidden = '<%=isHidden%>';
				var isReadOnly = '<%=isReadOnly%>';
			 	var target=document.getElementById("<%=fieldId%>");
				if(target){
					target.style.display="";
				}	
			 
			 	sip(ds,fieldId,isHidden,isReadOnly);
				
			if(isHidden == "1") { // 判断是否为隐藏
				if(!ifback) { // 判断是否为退回操作
					var target=document.getElementById("<%=fieldId%>");
						if(target){
							target.style.display="none";
						}	
				} else {
					isReadOnly = "1";
				}				 		     
		} 
				if(isReadOnly == "1") {
				var target=document.getElementById("<%=fieldId%>");		
				if(target){
					var txts = target.getElementsByTagName("input");
					for(var i=0;i<txts.length;i++)
					{
					  	if(txts[i].type=="text"||txts[i].type=="textarea")
						{
						  txts[i].disabled=true;
						}
						
					}
					var txts = target.getElementsByTagName("textarea");
					for(var i=0;i<txts.length;i++)
					{				  	
						txts[i].disabled=true;												
					}
					var txts = target.getElementsByTagName("select");
					for(var i=0;i<txts.length;i++)
					{				  	
						txts[i].disabled=true;												
					}
					var txts = target.getElementsByTagName("img");
					for(var i=0;i<txts.length;i++)
					{				  	
						txts[i].disabled=true;												
					}
				}		
						
				 
			}
	<%	
	}
	%>	
}
// 设置默认值
function sip(ds,fieldId,isHidden,isReadOnly) {
		var ds = L5.DatasetMgr.lookup("ds");
		var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.WfProcessBusinessCommand");
		command.setParameter("applyId",'<%=applyId%>');
		command.execute("validateIfback");
		var ifback = command.getReturn("ifback");
				//县级审核
				if(fieldId=="counties"&&isHidden=="0"&&isReadOnly=="0"){
					var trialDate = ds.get("trialDate");
					if(ifback){
						ds.set("trialDate",currentDate);
					}else if(trialDate == "" || trialDate == null) {
						ds.set("trialDate",currentDate);
					}	
					
					var trialName = ds.get("trialName");
					if(trialName == "" || trialName == null) {
						ds.set("trialName",currentUserName);
					}
				
					var reviewDate = ds.get("reviewDate");
					if(ifback){
						ds.set("reviewDate",currentDate);
					}else if(reviewDate == "" || reviewDate == null) {
						ds.set("reviewDate",currentDate);
					}	
					
					var reviewView = ds.get("reviewView");
					if(reviewView == "" || reviewView == null) {
						ds.set("reviewView",currentUserName);
					}
					
				}
				//市级审核
				if(fieldId=="city"&&isHidden=="0"&&isReadOnly=="0"){
					var approvalDate = ds.get("approvalDate");
					 if(approvalDate == "" ||  approvalDate == null ) {
						ds.set("approvalDate",currentDate);
					}
					var approvalName = ds.get("approvalName");
					if(approvalName == "" || approvalName == null) {
						ds.set("approvalName",currentUserName);
					}	
				}
			
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
//手动输入时间格式 
function changeDateStyle(obj) {
	var temp = obj.value;
	if(temp!=""&&temp.length == 4) {
		obj.value = temp + '-';
	} else if (temp!=""&&temp.length==7) {
		obj.value = temp + '-';
	} 
}	
function changeDiv(value) {
		var isReport1 = document.getElementById("isReport1");
		var isReport2 = document.getElementById("isReport2");
		var applyc = document.getElementById("applyc");
		ds = L5.DatasetMgr.lookup("ds");
		if(value == null || value == "") {
			isReport1.style.display="none";
			isReport2.style.display="none";
			ds.set("townReport","");
			applyc.width="82%";
		} else if(value == 0) {
			isReport1.style.display="none";
			isReport2.style.display="none";
			ds.set("townReport","");
			applyc.width="82%";
		} else if(value == 1) {
			isReport1.style.display="";
			isReport2.style.display="";
			applyc.width="50";
			var townReport = ds.get("townReport");
			if(townReport==null||townReport=="") {
				ds.set("townReport","0");
			}
		} 
	}

function addBlackList(){
	
	L5.MessageBox.confirm('确定', '确定要将此人员添加到黑名单吗?',function(state){
		if(state=="yes"){
			var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptPerjuryCommand");
			command.setParameter("peopleId",peopleId);
			command.execute("checkDoublePerson");
			var flag = command.getReturn("flag");
			if ("1"==flag) {
				L5.Msg.alert('提示',"黑名单内已经存在此人员!");
				return ;
			}else if("0"==flag){
				var commandadd = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptPerjuryCommand");
				commandadd.setParameter("peopleId",peopleId);
				commandadd.setParameter("serviceType",serviceType);
				commandadd.execute("savefromflow");
				if (!commandadd.error) {
					L5.Msg.alert('提示',"保存成功!");
				}else{
					L5.Msg.alert('提示',"保存时出现错误！"+commandadd.error);
				}
			}
		}else{
			return false;
		}
	});
}
//判段此身份证号是否在黑名单
function checkDoublePerson(idCard){
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptPerjuryCommand");
	command.setParameter("idCard", idCard);
	command.execute("checkDoublePerson");
	var flag = command.getReturn("flag");//0;没有重复 ,1:有重复
	if ("1"==flag) {
		return true;
	}else if("0"==flag){
		return false;
	}
}


		--></script>

</head>
<body>
<model:datasets>
	<model:dataset id="ds"
		cmd="com.inspur.cams.bpt.manage.cmd.DemobilizedflowQueryCommand"
		method="query2">
		<model:record fromBean="com.inspur.cams.bpt.base.data.Demobilizedflow"></model:record>
	</model:dataset>
	<!-- 审批条件 -->
	<model:dataset id="ApplyContent" enumName="BPT.APPLY.CODE" autoLoad="true" global="true"></model:dataset>

	<!-- 上报标示 -->
	<model:dataset id="ReportFlagEnum" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel width="100%" height="100%" autoScroll="false" id="flow">
	<next:Tabs>
		<next:TabPanel id="flow1">
			<next:Panel title="基本信息" width="100%" height="100%">
				<next:Html>
					<iframe id="peopleInfo"
						src="../../../jsp/cams/bpt/comm/peopleDetail.jsp?peopleId=<%=peopleId%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0"
						scrolling="no" allowtransparency="yes" width="100%" height="100%">
					</iframe>
				</next:Html>
			</next:Panel>
			<next:Panel id="typeTabPanel" title="类别信息" width="100%" height="100%">
				<next:Html>
					<iframe id="typeFrame" src="" frameborder="no" border="0"
						marginwidth="0" marginheight="0" scrolling="no"
						allowtransparency="yes" width="100%" height="100%"> </iframe>
				</next:Html>
			</next:Panel>
			<next:Panel title="家庭成员信息" width="100%" height="100%">
				<next:Html>
					<iframe id="member"
						src="../../../jsp/cams/bpt/comm/memberListDetail.jsp?familyId=<%=familyId%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0"
						scrolling="no" allowtransparency="yes" width="100%" height="100%">
					</iframe>
				</next:Html>
			</next:Panel>
			<next:Panel title="住房信息" width="100%" height="100%">
				<next:Html>
					<iframe id="house"
						src="../../../jsp/cams/bpt/comm/houseDetail.jsp?familyId=<%=familyId%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0"
						scrolling="no" allowtransparency="yes" width="100%" height="100%">
					</iframe>
				</next:Html>
			</next:Panel>
			<next:Panel title="电子档案" width="100%" height="100%"
				id="uploadTabPanel">
				<next:Html>
					<iframe id="upload"
						src="../../../jsp/cams/bpt/comm/uploadfileDetail.jsp?peopleId=<%=peopleId%>&serviceType=<%=request.getParameter("serviceType")%>&applyId=<%=applyId%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0"
						scrolling="no" allowtransparency="yes" width="100%" height="100%">
					</iframe>
				</next:Html>
			</next:Panel>
			<next:Panel title="公示书" width="100%" height="100%"
				id="openletter">
				<next:Html>
				  <iframe id="openletter1" src=""
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
		<next:Panel title="审批表" width="100%" height="100%"
				id="demobilized_appTabPanel" >
				<next:Html>
				  <iframe  id="apptable" src=""
					 	frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%" >
	   				</iframe>
				</next:Html>
		</next:Panel>
			<next:Panel title="不予认定决定书" width="100%" height="100%"
				id="decisionLetterTabPanel">
				<next:Html>
					<iframe id="decisionTabPanel" src="" frameborder="no" border="0"
						marginwidth="0" marginheight="0" scrolling="no"
						allowtransparency="yes" width="100%" height="100%"> </iframe>
				</next:Html>
			</next:Panel>
			<next:Panel title="体检表" width="100%" height="100%"
				id="physicalPanel">
				<next:Html>
				  <iframe id="physical" src=""
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
			</next:Panel>
		<next:Panel title="病情送检表" width="100%" height="100%"
				id="checkPanel">
				<next:Html>
				  <iframe id="check" src=""
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
			</next:Panel>
			<next:Panel title="优抚人员申请审批" height="100%" width="100%"
				id="approveTabPanel" autoScroll="true">
				<next:TopBar>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
					<%
					    //从后台获取环节按钮权限，显示要显示按钮
					                        for (int i = 0; i < list.size(); i++) {
					                            Map map = (Map) list.get(i);
					                            String buttonName = (String) map.get("buttonName");
					                            String buttonFunName = (String) map.get("buttonFunName");
					%>
					<next:ToolBarItem iconCls="submit" text="<%=buttonName %>"
						handler="<%=buttonFunName %>" />
					<%
					    }
					%>
					<next:ToolBarItem iconCls="submit" text="添加到黑名单" handler="addBlackList" />
				</next:TopBar>
				<next:Html>
					<form id="editForm" dataset="ds" onsubmit="return false"
						style="padding: 5px;" class="L5form">
					<table border="1" width="100%">
						<div id="counties" >
						<table border="1" width="100%" >
							<tr>
								<td class="FieldLabel" width="157">乡镇审批</td>
								<td class="FieldInput" colspan="3"><textarea type="text" disabled="disabled"
									validateName="乡镇审批意见" name="townViews" field="townViews"
									style="width: 80%" rows="4" id="townViews"></textarea></td>
							</tr>
							<tr>
								<td class="FieldLabel">负责人</td>
								<td class="FieldInput"><input type="text"
									validateName="初审人" name="trialName" field="trialName" disabled="disabled"/></td>
								<td class="FieldLabel">审批日期</td>
								<td class="FieldInput"><input type="text"
									validateName="初审日期" name="trialDate" field="trialDate"  disabled="disabled"
									id="trialDate" format="Y-m-d" style="width: 100px;"
									maxlength="10" onpropertychange="changeDateStyle(this)"  /><img
									src="../../../skins/images/default/rl.gif"
									align="middle" onclick="getTimes(this);"></td>
							</tr>

							<tr>
								<td class="FieldLabel">县级审批</td>
								<td class="FieldInput" colspan="3">
									<table width="100%">
										<tr>
											<td class="FieldLabel" >审批意见：</td>
											<td class="FieldInput" width="82%" id="applyc" >
												<select  name="townFlag" id="townFlag" field="townFlag" onchange="changeDiv(this.value)" disabled="disabled">
													<option dataset="ApplyContent"></option>
												</select>
											</td>
											<td id="isReport1"  class="FieldLabel" style="display:none">是否上报：</td>
											<td class="FieldInput" id="isReport2" style="display:none">
												<select name="townReport" id="townReport" field="townReport" disabled="disabled">
													<option dataset="ReportFlagEnum"></option>
												</select>
											</td>
										</tr>
										<tr>
											<td colspan="4"><textarea type="text"
												validateName="县区复审意见" name="countiesViews"
												field="countiesViews" style="width: 80%" rows="4" disabled="disabled"></textarea></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td class="FieldLabel">负责人</td>
								<td class="FieldInput"><input type="text"
									validateName="复审人" name="reviewView" field="reviewView" disabled="disabled"/></td>

								<td class="FieldLabel">审批日期</td>
								<td class="FieldInput"><input type="text"
									validateName="复审日期" name="reviewDate" field="reviewDate" disabled="disabled"
									id="reviewDate" format="Y-m-d" style="width: 100px;"
									maxlength="10" onpropertychange="changeDateStyle(this)"  /><img
									src="../../../skins/images/default/rl.gif"
									align="middle" onclick="getTimes(this);"></td>
							</tr>
						</table>
						</div>
						</br>
						<div id="city">
						<table border="1" width="100%">
							<tr>
								<td class="FieldLabel" width="157">市级审批</td>
								<td class="FieldInput" colspan="3">
								<table width="100%">
										<tr>
											<td class="FieldLabel" >审批意见：</td>
											<td class="FieldInput" width="82%" id="applyc" >
												<select  name="cityFlag" id="cityFlag" validateName="市级审批意见" field="cityFlag" >
													<option dataset="ApplyContent"></option>
												</select>
											</td>
										</tr>
										<tr>
											<td colspan="4"><textarea type="text"
									validateName="市级审批意见" name="citiesViews" field="citiesViews"
									style="width: 80%" rows="4" id="citiesViews"></textarea></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td class="FieldLabel">负责人</td>
								<td class="FieldInput"><input type="text"
									validateName="市级负责人" name="approvalName" field="approvalName" />
								</td>
								<td class="FieldLabel">审批日期</td>
								<td class="FieldInput"><input type="text"
									validateName="审批日期" name="approvalDate" field="approvalDate"
									id="approvalDate" format="Y-m-d" style="width: 100px;"
									maxlength="10" onpropertychange="changeDateStyle(this)"  /><img
									src="../../../skins/images/default/rl.gif"
									align="middle" onclick="getTimes(this);"></td>
							</tr>
						</table>
						</div>

					</table>
					</form>
				</next:Html>

			</next:Panel>
			<next:Panel id="bptApplyHistory" width="100%" height="100%" autoScroll="false" title="审批历史记录">
				<next:Html>
				    <iframe id="history" src="../../../jsp/cams/bpt/flow/demobilized/applydemobilized/demoAppHistory.jsp?applyId=<%=applyId%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
			</next:Panel>
		</next:TabPanel>
	</next:Tabs>
</next:Panel>

</body>
</html>
