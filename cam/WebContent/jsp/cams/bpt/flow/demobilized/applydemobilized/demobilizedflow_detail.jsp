<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="org.loushang.workflow.api.WfQuery" %>
<%@page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@page import="java.util.List" %>
<%@page import="java.util.Map" %>
<%@page import="com.inspur.cams.bpt.manage.cmd.BptBaseinfoPeopleQueryCommand" %>
<%@page import="java.util.HashMap" %>
<%
String peopleId = request.getParameter("peopleId");
String applyId = request.getParameter("applyId");
String familyId = request.getParameter("familyId");
String serviceType = request.getParameter("serviceType");
%>
<html>
	<head>
		<title>审批查看</title>
		<next:ScriptManager/>
		<script>
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
			var url;
			var url1;
			var first = true;

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
							var openletter = L5.getCmp("openletter");
							openletter.on("activate",setOpenPanel); // 设置决定书panel的隐藏
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
							var tabpanel = L5.getCmp("approveTabPanel");
							tabpanel.on("activate",setHide);
							tabpanel.on("activate",function(){
								var townReport = ds.get("townReport");
								var isReport = document.getElementById("isReport");
								var isReport2 = document.getElementById("isReport2");
								var applyc = document.getElementById("applyc");
								if(townReport == null||townReport == "") {
									isReport.style.display="none";
									isReport2.style.display="none";
									applyc.width="82%";
								} else  {
									isReport.style.display="";
									isReport2.style.display="";
									applyc.width="20%";
								}
							});
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
	function setDecisionPanel() { //设置决定书panel的隐藏
		var serviceType ='<%=serviceType%>';
		if(serviceType=="41"){      
			url1=L5.webPath+"/jsp/cams/bpt/flow/demobilized/applydemobilized/demoDecisionLetterDetail.jsp?peopleId=<%=request.getParameter("peopleId")%>&applyId=<%=applyId%>";
			}
		if(serviceType=="45"){
			url1=L5.webPath+"/jsp/cams/bpt/flow/demobilizedillness/applydemobilizedillness/demoIllnessDecisionLetterDetail.jsp?peopleId=<%=peopleId%>&applyId=<%=applyId%>";
			}
		document.getElementById("decisionTabPanel").src=url1;
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
		//发送流程
	function send(){
				if(!ifsave) {
					L5.Msg.alert("提示","请先保存审批信息!");
					return false;
					}
				//	if(validateNotNull()){
					  if(checkProcessState("send")){
					   var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.DemobilizedflowCommand");
					   //执行发送流程方法
					   command.setParameter("assignmentId",assignmentId);
					   command.setParameter("serviceType",'<%=serviceType%>');
					   command.setParameter("peopleId",'<%=peopleId%>');
					    command.setParameter("condition",'0');
					   command.execute("send");
					   if(!command.error){
						   alert("成功发送到下一环节!");		  
						   //跳转到已办任务页面
						   var url = "jsp/workflow/tasklist/queryyiban.jsp";
						   L5.forward(url,"已办任务页面");
					   }else{
					      alert(command.error);
					  }
					 }
				//	}
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
	var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.DemobilizedflowCommand");
	 command.setParameter("assignmentId",assignmentId);
	   //执行发送流程方法
	   command.execute("back");
	   if(!command.error){
		   alert("成功回退流程!");		  
		   //跳转到已办任务页面
		   var url = "jsp/workflow/tasklist/queryyiban.jsp";
		   L5.forward(url,"已办任务页面");
	   }else{
	      alert(command.error);
	   }
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
			var value=document.getElementById("<%=fieldId%>").value;
			if(value==null||value==""){
				alert("<%=fieldName%>"+"不能为空!");
				return false;
				}
			<%			
		}		
	}
	%>	
	return true;
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
function save(){
var ds = L5.DatasetMgr.lookup("ds");
	var records = ds.getAllChangedRecords();
	if(records.length<1){
		L5.Msg.alert('提示','没有需要保存的数据!');
		return false;
	}
	//校验
	var valid = ds.isValidate();
	if(valid != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+valid);
		return false;
	}	
	
	var interDate = document.getElementById("interDate").value;
	if(interDate!=''&&!validateDateFormat(interDate)){
		L5.Msg.alert("提示","录入时间格式不正确！");
		return false;
	}
var changeDate = document.getElementById("changeDate").value;
	if(changeDate!=''&&!validateDateFormat(changeDate)){
		L5.Msg.alert("提示","修改日期格式不正确！");
		return false;
	}
	
	var birthday = document.getElementById("birthday").value;
	if(birthday!=''&&!validateDateFormat(birthday)){
		L5.Msg.alert("提示","出生日期格式不正确！");
		return false;
	}
var armyDate = document.getElementById("armyDate").value;
	if(armyDate!=''&&!validateDateFormat(armyDate)){
		L5.Msg.alert("提示","入伍日期格式不正确！");
		return false;
	}
var demobilize = document.getElementById("demobilize").value;
	if(demobilize!=''&&!validateDateFormat(demobilize)){
		L5.Msg.alert("提示","复员日期格式不正确！");
		return false;
	}
    var records = ds.getAllChangedRecords();
	var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.DemobilizedflowCommand"); 
	command.setParameter("records",records);
	command.execute("save");	
	if (!command.error) {
	ifsave = true;
		L5.Msg.alert('提示',"保存成功!");
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}

	
				//修改退回流程中人员基本信息
		 function updateInfo(){
		 
		 var urlPath="";
		 <%
		 if(serviceType.equals("45")){
		 %>
			urlPath="../../../jsp/cams/bpt/flow/demobilizedillness/applydemobilizedillness/demobilizedIllnessUpdateManage.jsp?method=UPDATE&peopleId=<%=peopleId%>&familyId=<%=familyId%>&applyId="+applyIds;
		<%}
		 if(serviceType.equals("41")){
		 %>
			urlPath="../../../jsp/cams/bpt/flow/demobilized/applydemobilized/demobilizedUpdateManage.jsp?method=UPDATE&peopleId=<%=peopleId%>&familyId=<%=familyId%>&applyId="+applyId;
		<%}%>
			var width = screen.width-100;
		    var height = screen.height-140;
			var win = window.showModalDialog (urlPath,window,"scroll:no;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
		 	
		 	
		 }	
		 //不予认定并结束流程
	function sendOver(){
		var ds = L5.DatasetMgr.lookup("ds");
		var records = ds.getAllChangedRecords();
			if(records.length>0){
			L5.Msg.alert('提示','请先保存!');
			return false;
	}
	//if(!ifsave) {
	//				L5.Msg.alert("提示","请先保存审批信息!");
	//				return false;
	//				}
				//	if(validateNotNull()){
	//判断是否填写公示书
	   	  var commandifHave=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptDecisionLetterCommand");
	   	  commandifHave.setParameter("applyId",'<%=applyId%>');
	   	  commandifHave.execute("ifHave");
	   	  var ifhave = commandifHave.getReturn("ifhave");
	   	  if(!ifhave){
	   	  	alert("请先填写不予评定决定书");
	   	  	var typePanel = L5.getCmp("decisionLetterTabPanel");
	   	  	typePanel.load();
	 		return false;
	  }
					  if(checkProcessState("send")){
					   var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.DemobilizedflowCommand");
					   //执行发送流程方法
					   command.setParameter("assignmentId",assignmentId);
					   command.setParameter("serviceType",'<%=serviceType%>');
					   command.setParameter("peopleId",'<%=peopleId%>');
					   command.setParameter("condition",'1');
					   command.execute("send");
					   if(!command.error){
						   alert("成功发送到下一环节!");		  
						   //跳转到已办任务页面
						   var url = "jsp/workflow/tasklist/queryyiban.jsp";
						   L5.forward(url,"已办任务页面");
					   }else{
					      alert(command.error);
					  }
					 }
				//	}
				}
		</script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.bpt.manage.cmd.DemobilizedflowQueryCommand" method="query2">
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
			<next:Panel id="typeTabPanel" title="类别信息" width="100%" height="100%" >
				<next:Html>
					<iframe id="typeFrame"
						src=""
						frameborder="no" border="0" marginwidth="0" marginheight="0"
						scrolling="no" allowtransparency="yes" width="100%" height="100%">
					</iframe>
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
		<next:Panel title="电子档案" width="100%" height="100%" id="uploadTabPanel">
				<next:Html>
				  <iframe id="upload" src="../../../jsp/cams/bpt/comm/uploadfileDetail.jsp?peopleId=<%=peopleId%>&serviceType=<%=request.getParameter("serviceType")%>&applyId=<%=applyId%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
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
				  <iframe id="decisionTabPanel" src=""
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
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
		<next:Panel  title="优抚人员申请审批" height="100%" width="100%" id="approveTabPanel" autoScroll="true" >

	<next:Html>
		<form id="editForm"   dataset="ds" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="100%" >
			<div>
			<table  style="display:none">
			<tr>
				<td  class="FieldLabel" >录入时间</td>
				<td class="FieldInput"><label name="interDate" id="interDate" field="interDate"/></td>
				<td  class="FieldLabel" >修改人</td>
				<td class="FieldInput"><label name="changeId" field="changeId"/> </td>
				<td  class="FieldLabel" >修改日期</td>
				<td class="FieldInput"><label name="changeDate" id="changeDate" field="changeDate"/></td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >申请ID</td>
				<td  class="FieldInput"><label name="applyId" field="applyId"/></td>
				<td  class="FieldLabel" >录入人ID</td>
				<td  class="FieldInput"><label name="interId" field="interId"/></td>
				<td  class="FieldLabel" >人员ID</td>
				<td class="FieldInput"><label name="peopleId" field="peopleId"  /> </td>
			</tr>
			<tr>
				<td  class="FieldLabel" >姓名</td>
				<td class="FieldInput"><label name="name" field="name"  /> </td>
				<td  class="FieldLabel" >性别</td>
				<td class="FieldInput"><label name="sex" field="sex"  /> </td>	
				
				<td  class="FieldLabel" >出生日期</td>
				<td class="FieldInput"><label name="birthday" id="birthday" field="birthday"/></td>	
			</tr>
	   		<tr>
	   			<td  class="FieldLabel" >证件类型</td>
				<td class="FieldInput"><label name="documentsType" field="documentsType"  /> </td>
				
				<td  class="FieldLabel" >身份证号码</td>
				<td class="FieldInput"><label name="idCard" field="idCard"  /> </td>
			
				<td  class="FieldLabel" >户籍地址</td>
				<td class="FieldInput"><label name="household" field="household"  /> </td>
			</tr>
				<tr>
	   			<td  class="FieldLabel" >原部队代号</td>
				<td class="FieldInput"><label name="designation" field="designation"  /> </td>
				
				<td  class="FieldLabel" >原部队职务</td>
				<td class="FieldInput"><label name="position" field="position"  /> </td>
			
				<td  class="FieldLabel" >复员证字号</td>
				<td class="FieldInput"><label name="demobilizeId" field="demobilizeId"  /> </td>
			</tr>	
	   		<tr>
				<td  class="FieldLabel" >优抚对象类别</td>
				<td class="FieldInput"><label name="objectType" field="objectType"  /> </td>
			
				<td  class="FieldLabel" >优抚对象状态标志</td>
				<td class="FieldInput"><label name="objectMark" field="objectMark"  /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >入伍日期</td>
				<td  class="FieldInput"><label name="armyDate" id="armyDate" field="armyDate"></td>
				<td  class="FieldLabel" >复员日期</td>
				<td  class="FieldInput"><label name="demobilize" id="demobilize" field="demobilize" /> </td>
			</tr>
			</table>
	   	</div>
	   	<br/>
			<div id="counties">
			<table border="1"  width="99%" >	
	   		<tr>
				<td  class="FieldLabel" style="width:15%;">乡镇审批</td>
				<td class="FieldInput" colspan="3"><label name="townViews" field="townViews"></label> </td>
			</tr>
	   		<tr>
	   		<td  class="FieldLabel" >负责人</td>
				<td class="FieldInput"><label name="trialName" field="trialName"  readonly="true"/> </td>
				<td  class="FieldLabel" >审批日期</td>
				<td class="FieldInput"><label name="trialDate" field="trialDate"   readonly="true"/> </td>
			</tr>
			<tr>
				<td  class="FieldLabel" >县级审批</td>
				<td class="FieldInput" colspan="3">
					<table width="100%">
						<tr>
							<td class="FieldLabel" >审批意见：</td>
							<td class="FieldInput" width="82%" id="applyc" >
								<label name="townFlag" id="townFlag" field="townFlag" dataset="ApplyContent"></label>
							</td>
							<td width="17%" id="isReport"  class="FieldLabel" style="display:none">是否上报：</td>
							<td class="FieldInput" id="isReport2" style="display:none">
								<label name="townReport" id="townReport" field="townReport"  dataset="ReportFlagEnum"></label>
							</td>
						</tr>
						<tr>
							<td colspan="4"><label validateName="县区复审意见" name="countiesViews" field="countiesViews"></label></td>
						</tr>
					</table>
				 </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >负责人</td>
				<td class="FieldInput"><label name="reviewView" field="reviewView"/></td>
				<td  class="FieldLabel" >审批日期</td>
				<td class="FieldInput"><label name="reviewDate" field="reviewDate"/></td>
			</tr>
			</table>
			</div>
			<br/>
			<div id="city">
				<table border="1"  width="99%" >
			   		<tr>
						<td  class="FieldLabel"  style="width:15%;">市级审批</td>
						<td class="FieldInput" colspan="3">
						<table width="100%">
								<tr>
									<td class="FieldLabel" >审批意见：</td>
									<td class="FieldInput" width="82%" id="applyc" >
									    <label name="cityFlag" id="cityFlag" field="cityFlag" dataset="ApplyContent"></label>
									</td>
								</tr>
								<tr>
									<td colspan="4"><label name="citiesViews" field="citiesViews"></label></td>
								</tr>
							</table>
						 </td>
					</tr>
					<tr>
						<td  class="FieldLabel" >负责人</td>
						<td class="FieldInput"><label name="approvalName" field="approvalName"/></td>
						<td  class="FieldLabel" >审批日期</td>
						<td class="FieldInput"><label name="approvalDate" field="approvalDate"/></td>
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
<script>
//设置环节域的隐藏
function setHide(approveTabPanel){
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
		<% if("1".equals(isHidden)){
			%>
			var target=document.getElementById("<%=fieldId%>");
			if(target){
				target.style.display="none";
				}
						
		<%}else{
			//不隐藏时，如果是只读
			if("1".equals(isReadOnly)){
				//设置为只读
				%>
				
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
				}		
					/*var txts = target.getElementsByTagName("img");
					for(var i=0;i<txts.length;i++)
					{				  	
						txts[i].disabled=true;												
					}	*/
				
			<%}
		}
	}
	%>	
}
		

</script>
</body>
</html>
