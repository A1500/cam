<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="org.loushang.workflow.api.WfQuery" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<html>
	<head>
		<title>伤残辅助器械申请</title>
		<next:ScriptManager/>
				<script type="text/javascript" src="../../../jsp/cams/bpt/comm/bptComm.js"></script>
				<script type="text/javascript" src="<%=SkinUtils.getJS(request, "bpm/bpm.js")%>"></script>
				<script>
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
						List<Map> list1=wfQuery.getActFields(actDefUniqueId);
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
					var applyId = '<%= (String)request.getParameter("primaryKey")%>';
					var peopleId = '<%= (String)request.getParameter("peopleId")%>';
					var familyId = '<%= (String)request.getParameter("familyId")%>';
					var actDefName = '<%=actDefName%>';
				</script>
		</head>
<body>
<model:datasets>
	<!-- 伤残辅助器械审批 -->
	<model:dataset id="AssistiveDevicesPrDataset" cmd="com.inspur.cams.bpt.manage.cmd.BptApplyAssistiveDevicesPrQueryCommand" method="queryupdate" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptApplyAssistiveDevicesPr">
		</model:record>
	</model:dataset>
	<!-- 伤残辅助器械 -->
	<model:dataset id="AssistiveDevicesDataset" cmd="com.inspur.cams.bpt.manage.cmd.BptApplyAssistiveDevicesQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptApplyAssistiveDevices"></model:record>
	</model:dataset>
	<!-- 性别 -->
	<model:dataset id="SexDataset" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
	<!-- 伤残类别代码 -->
	<model:dataset id="DisabilityTypeCodeEnum" enumName="DISABILITY.TYPE.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 伤残等级 -->
	<model:dataset id="DisabilityLevelDataset" enumName="LEVEL.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 伤残属别 -->
	<model:dataset id="DisabilityGenusDataset" enumName="GENUS.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 是否同意 -->
	<model:dataset id="AgreeEnum" enumName="COMM.AGREEORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 上报标识-->
	<model:dataset id="ReportFlagEnum" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel width="100%" autoScroll="false">
  <next:Tabs>
	<next:TabPanel>
	<next:Panel title="基本信息" width="100%" height="100%" id="peopleInfoTabPanel">
				<next:Html>
				  <iframe id="peopleInfo" src="../../../jsp/cams/bpt/comm/peopleDetail.jsp?peopleId=<%=request.getParameter("peopleId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   			  </iframe>
				</next:Html>
		</next:Panel>
		<next:Panel title="类别信息" width="100%" height="100%"
				id="disabilityTypeTabPanel">
				<next:Html>
				  <iframe id="disabilityType" src="../../../jsp/cams/bpt/flow/disability/assessdisability/disabilityTypeDetail.jsp?peopleId=<%=request.getParameter("peopleId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
		<next:Panel title="家庭成员信息" width="100%" height="100%"
				id="memberTabPanel">
				<next:Html>
				  <iframe id="member" src="../../../jsp/cams/bpt/comm/memberListDetail.jsp?familyId=<%=request.getParameter("familyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>	
		<next:Panel title="住房信息" width="100%" height="100%"
				id="houseTabPanel">
				<next:Html>
				  <iframe id="house" src="../../../jsp/cams/bpt/comm/houseDetail.jsp?familyId=<%=request.getParameter("familyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
		<next:Panel id="assistiveApplyPrint"  width="100%" height="100%" autoScroll="false" title="伤残器械申请">
			<next:Html>
				<iframe id="assistiveApplyPr" src="../../../jsp/cams/bpt/flow/disability/assistivedevices/assistiveDevicesPrint.jsp?peopleId=<%=request.getParameter("peopleId")%>&applyId=<%=request.getParameter("primaryKey")%>"
					frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
   				</iframe>
		   </next:Html>
		</next:Panel>
		<next:Panel title="伤残器械更换审批表" width="100%" height="100%"
				id="changeTabPanel">
				<next:Html>
				  <iframe id="changeIframe" src="../../../jsp/cams/bpt/flow/disability/assistivedevices/assistiveDevicesChangePrint.jsp?peopleId=<%=request.getParameter("peopleId")%>&applyId=<%=request.getParameter("applyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
		<next:Panel title="辅助器具配置通知书" width="100%" height="100%"
				id="noticeTabPanel">
				<next:Html>
				  <iframe id="noticIframe" src="../../../jsp/cams/bpt/flow/disability/assistivedevices/assistiveDevicesNoticePrint.jsp?peopleId=<%=request.getParameter("peopleId")%>&applyId=<%=request.getParameter("applyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>	
	<next:Panel title="县级审核" autoScroll="true" width="100%"  height="100%" id="editPanel">
		<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<% 
			//从后台获取环节按钮权限，显示要显示按钮
			for(int i=0;i<list.size();i++){
				Map map=(Map)list.get(i);
				String buttonName=(String)map.get("buttonName");
				String buttonFunName=(String)map.get("buttonFunName");
				%>			 
				<next:ToolBarItem iconCls="submit" text="<%=buttonName %>" handler="<%=buttonFunName %>" />
				<%
			}
		%>
	</next:TopBar>
		<next:Html>
			<form id="editForm" dataset="AssistiveDevicesPrDataset" onsubmit="return false" style="padding: 5px;" class="L5form">
			<table border="0"  width="99%">
				<table></table>
				<div id="townCheck">
					<table border="0" width="98%">
				   		<tr>
				   			<td class="FieldLabel" rowspan="3" nowrap="nowrap" style="width:12.5%">县级审核</td>
							<td class="FieldLabel" style="width:12.5%">负责人</td>
							<td class="FieldInput" style="width:25%"><input type="text" id="checkIncharge" name="checkIncharge" field="checkIncharge"/><font color="red">*</font></td>
							<td class="FieldLabel" style="width:25%">审核时间</td>
							<td class="FieldInput" style="width:25%"><input type="text" id="checkApproveDate" name="checkApproveDate" field="checkApproveDate"/><font color="red">*</font></td>
						</tr>
				   		<tr>
							<td class="FieldLabel" nowrap="nowrap" rowspan="2">审核意见</td>
							<td colspan="3" style="background-color:#F5FAFA;padding: 0 0 0 0;width: 100%;height: 100%;border:0;">
									<table style="width: 100%;height: 100%;border:0;padding: 0 0 0 0;">
										<tr> 
						   					<td class="FieldLabel" style="width:25%;">意见</td>
						   					<td class="FieldInput" >
						   						<select name="checkAgreeFlag" id="checkAgreeFlag" field="checkAgreeFlag" onchange="changeDiv(this.value)">
													<option dataset="AgreeEnum"></option>
												</select>
						   					</td>
						   					<td id="report" style="background-color:#F5FAFA;padding: 0 0 0 0;width: 100%;height: 100%;border:0;display:none;">
						   						<table style="width: 100%;height: 100%;border:0;padding: 0 0 0 0;">
						   							<tr>
						   								<td class="FieldLabel" style="width:25%;">是否上报</td>
								   						<td class="FieldInput" style="width:25%;">
								   							<select id="reportFlag" name="reportFlag" field="reportFlag" >
																<option dataset="ReportFlagEnum"></option>
															</select>
														</td>
						   							</tr>
						   						</table>
						   					</td>
					   					</tr>
				   					</table>
							</td>
						</tr>
						<tr>
							<td class="FieldInput" colspan="3"><textarea id="checkAdvice" name="checkAdvice" field="checkAdvice" style="width:90%" rows="3" ></textarea></td>
						</tr>
					</table>
				</div>
				<br>
				<div id="cityCheck">
					<table border="0"  width="98%">
				   		<tr>
				   			<td class="FieldLabel" rowspan="3" style="width:12.5%">市级审核</td>
							<td class="FieldLabel" style="width:12.5%">负责人</td>
							<td class="FieldInput" style="width:25%"><input type="text" id="aduitIncharge" title="负责人" name="aduitIncharge" field="aduitIncharge"/></td>
							<td class="FieldLabel" style="width:25%">审核时间</td>
							<td class="FieldInput" style="width:25%"><input type="text" id="aduitApproveDate" title="审核时间" name="aduitApproveDate" field="aduitApproveDate"/></td>
						</tr>
						<tr>
							<td class="FieldLabel" nowrap="nowrap" rowspan="2">审核意见</td>
							<td colspan="3" style="background-color:#F5FAFA;padding: 0 0 0 0;width: 100%;height: 100%;border:0;">
									<table style="width: 100%;height: 100%;border:0;padding: 0 0 0 0;">
										<tr> 
						   					<td class="FieldLabel" style="width:21%;">意见</td>
						   					<td class="FieldInput" >
						   						<select name="aduitAgreeFlag" id="aduitAgreeFlag" field="aduitAgreeFlag" >
													<option dataset="AgreeEnum"></option>
												</select>
						   					</td>
						   					
					   					</tr>
				   					</table>
							</td>
						</tr>
						<tr>
							<td class="FieldInput" colspan="3"><textarea type="text" id="aduitAdvice" title="审核意见" name="aduitAdvice" field="aduitAdvice" style="width:90%" rows="3"></textarea></td>
						</tr>
					</table>
				</div>
				</table>
			</form>
	   </next:Html>
	</next:Panel>
	<next:Panel title="审批历史记录" width="100%" height="100%" id="approveHistoryTabPanel">
				<next:Html>
				  <iframe id="approveHistory" src="../../../jsp/cams/bpt/flow/disability/assistivedevices/assistiveDevicesAppHistory.jsp?applyId=<%= (String)request.getParameter("primaryKey")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
	</next:Panel>
  </next:TabPanel>
</next:Tabs>
</next:Panel>
</body>
<script>
function updateInfo() { // 若流程为第一环节则可修改
	var width = screen.width-100;
    var height = screen.height-140;
    var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.WfProcessBusinessCommand");
	if(processId=='null'){
		command.setParameter("assignmentId",assignmentId);
	}else{
		command.setParameter("PROCESS_ID",processId);
	}
	command.execute("queryBusinessType");
	var peopleId = command.getReturn("peopleId");
	var familyId = command.getReturn("familyId");
	var url = L5.webPath+"/jsp/cams/bpt/flow/disability/assistivedevices/assistiveDevicesUpdate.jsp?peopleId=" + peopleId + "&familyId=" + familyId +"&applyId="+applyId;
	var returnValue = window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	window.location.reload();
}
function init() {
	var editPanel = L5.getCmp("editPanel");
	editPanel.setTitle('<%=actDefName%>');
	var AssistiveDevicesPrDataset = L5.DatasetMgr.lookup("AssistiveDevicesPrDataset");
	AssistiveDevicesPrDataset.setParameter("APPLY_ID",applyId);
	AssistiveDevicesPrDataset.load();
	var AssistiveDevicesDataset = L5.DatasetMgr.lookup("AssistiveDevicesDataset");
	AssistiveDevicesDataset.setParameter("APPLY_ID",applyId);
	AssistiveDevicesDataset.load();
	var editPanel = L5.getCmp("editPanel");
	editPanel.on("activate",setHide);
	L5.getCmp("assistiveApplyPrint").on("activate",function(){
		var assistiveApplyPrSrc = document.getElementById("assistiveApplyPr").src;
		document.getElementById("assistiveApplyPr").src = assistiveApplyPrSrc;
 	});
	L5.getCmp("changeTabPanel").on("activate",funcnotice);
	L5.getCmp("noticeTabPanel").on("activate",funcchange);
}

function funcnotice(){  
		var src = document.getElementById("changeIframe").src;
		document.getElementById("changeIframe").src=src;
}
function funcchange(){  
	var src = document.getElementById("noticIframe").src;
	document.getElementById("noticIframe").src=src;
}

function save(){
	var AssistiveDevicesPrDataset = L5.DatasetMgr.lookup("AssistiveDevicesPrDataset");
	var AssistiveDevicesPrRecord=AssistiveDevicesPrDataset.getCurrent();
	
	if(actDefName == '县级审核'){
	     var checkIncharge = AssistiveDevicesPrRecord.get("checkIncharge");
	     var checkApproveDate = AssistiveDevicesPrRecord.get("checkApproveDate");
	     var agreeFlag = AssistiveDevicesPrRecord.get("agreeFlag");
	     var reportFlag = AssistiveDevicesPrRecord.get("reportFlag");
	     if(checkIncharge==""){
	     		L5.Msg.alert('提示','必须填写负责人!');
	     		return false;
	     }
	     if(checkApproveDate==""){
	     		L5.Msg.alert('提示','必须填写审核时间!');
	     		return false;
	     }
	     if(agreeFlag==''){
	     	L5.Msg.alert('提示','必须选择审核意见！');
	     	return false;
	     }
	     if(agreeFlag=='1'&&reportFlag==''){
	     	L5.Msg.alert('提示','必须选择是否上报！');
	     	return false;
	     }
	}else{
		var aduitIncharge = AssistiveDevicesPrRecord.get("reportFlag");
		var aduitApproveDate = AssistiveDevicesPrRecord.get("aduitApproveDate");
		if(aduitIncharge==''){
			L5.Msg.alert('提示','必须填写负责人!');
	     	return false;
		}
		if(aduitApproveDate==""){
	     		L5.Msg.alert('提示','必须填写审核时间!');
	     		return false;
	    }
	}
	var	command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyAssistiveDevicesPrCommand");
	command.setParameter("record", AssistiveDevicesPrRecord);
	command.execute("update");
	if (!command.error) {
		AssistiveDevicesPrDataset.commitChanges();
		ifsave = true;
		L5.Msg.alert('提示',"数据保存成功!");
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}

//设置环节域的隐藏
function setHide(){
	var currentDate = getCurDate();
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
		//县级审核
		if(fieldId == "townCheck"&&isHidden=="0"&&isReadOnly=="0"){
			AssistiveDevicesPrDataset.set("checkIncharge",currentUserName);
			AssistiveDevicesPrDataset.set("checkApproveDate",currentDate);
		}
		//市级审核
		if(fieldId == "cityCheck"&&isHidden=="0"&&isReadOnly=="0"){
			AssistiveDevicesPrDataset.set("aduitIncharge",currentUserName);
			AssistiveDevicesPrDataset.set("aduitApproveDate",currentDate);
		}
	<%
		if("1".equals(isHidden)){
			%>
			var target=document.getElementById("<%=fieldId%>");
			if(target){
				target.style.display="none";
			}
			<%				
		}else{
			//不隐藏时，如果是只读
			if("1".equals(isReadOnly)){
				//设置为只读
				%>
				var target=document.getElementById("<%=fieldId%>");		
				if(target){
					var txts = target.getElementsByTagName("input");
					for(var i=0;i<txts.length;i++)
					{
					  	if(txts[i].type=="text")
						{
						  txts[i].disabled=true;
						}
					}
					var txts1 = target.getElementsByTagName("textarea");
					for(var i=0;i<txts1.length;i++)
					{				  	
						txts1[i].disabled=true;												
					}
					var txts2 = target.getElementsByTagName("select");
					for(var i=0;i<txts2.length;i++)
					{				  	
						txts2[i].disabled=true;												
					}
				}		
				<%
			}
		}
	}
	%>	
}

//发送流程
function send(){
	save();
	if(validateNotNull()){
	  if(checkProcessState("send")){
	   var AssistiveDevicesPrDataset = L5.DatasetMgr.lookup("AssistiveDevicesPrDataset");
	   var AssistiveDevicesPrRecord=AssistiveDevicesPrDataset.getCurrent();
	   var condition;
		if(actDefName == '县级审核'){
		     
		     if(AssistiveDevicesPrRecord.get("checkAgreeFlag")=='0'){
		     	condition = "end";
		     }else if(AssistiveDevicesPrRecord.get("checkAgreeFlag")=='1'&&AssistiveDevicesPrRecord.get("reportFlag")=='0'){
		     	condition = "end";
		     }else{
		     	condition = "pass";
		     }
		}
		var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyAssistiveDevicesPrCommand");
	   	command.setParameter("currentField",currentField);
	   	command.setParameter("condition",condition);
	    command.setParameter("record",AssistiveDevicesPrRecord);
	    command.setParameter("actDefName",actDefName);
	   //执行发送流程方法
	   command.execute("send");
	   if(!command.error){
		   alert("成功发送到下一环节!");		
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
}

//查看流转状态图
function showState(){
	 var url = L5.webPath+"/jsp/workflow/monitor/flowview.jsp?procDefUniqueId="
	      +procDefUniqueId+"&assignmentId="+assignmentId+"&isShowBackBtn=false";
	 showModalDialog(url, window,
	 	"scroll:yes;resizable:yes;dialogWidth:900px;dialogHeight:600px");	  	 
}
//回退流程
function backByState(){
	if(validateNotNull()){
		save();
		var AssistiveDevicesPrDataset = L5.DatasetMgr.lookup("AssistiveDevicesPrDataset");
		var AssistiveDevicesPrRecord=AssistiveDevicesPrDataset.getCurrent();
		var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyAssistiveDevicesPrCommand");
		command.setParameter("record",AssistiveDevicesPrRecord);
		   //执行发送流程方法
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
				var inputs = target.getElementsByTagName("input"); // 验证input标签
				for(var i=0;i<inputs.length;i++) {
					 if(inputs[i].type=="text") {
					 	  var inputValue = inputs[i].value;
						  if(inputValue == null || inputValue == "") {
						  	  alert(inputs[i].title+"不能为空!");
						  	  return false;
						  }
						  if(inputs[i].title=="审核时间"){
						  	if(!validateDateFormat(inputs[i].value)){
						  		alert("时间格式错误!");
						  	  return false;
						  	}
						  }
					 }
				}
				var textareas = target.getElementsByTagName("textarea"); // 验证textarea标签
				for(var i=0;i<textareas.length;i++) {
					 if(textareas[i].type=="text") {
					 	  var textareaValue = textareas[i].value;
						  if(textareaValue == null || textareaValue == "") {
						  	  alert(textareas[i].title+"不能为空!");
						  	  return false;
						  }
					 }
				}
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

//根据值不同隐藏
function changeDiv(value){
	var report = document.getElementById("report");
	if(value==''){
		return;
	}else{
		if(value=='0'){
			report.style.display="none";
		}else{
			report.style.display="inline";
		}
	}
}
</script>
</html>
