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
		<title>伤残辅助器械申请查看</title>
		<next:ScriptManager/>
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
						List<Map> list = new WfQuery().getActButtons(actDefUniqueId);
						List<Map> list1=new WfQuery().getActFields(actDefUniqueId);
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
		<next:Html>
			<form id="editForm" dataset="AssistiveDevicesPrDataset" onsubmit="return false" style="padding: 5px;" class="L5form">
			<table border="0"  width="99%">
				<table></table>
				<div id="townCheck">
					<table border="0" width="98%">
				   	<tr>
			   			<td class="FieldLabel" rowspan="3" nowrap="nowrap" style="width:12.5%">县级审核</td>
						<td class="FieldLabel" style="width:12.5%">负责人</td>
						<td class="FieldInput" style="width:25%"><label id="checkIncharge" name="checkIncharge" field="checkIncharge"/></td>
						<td class="FieldLabel" style="width:25%">审核时间</td>
						<td class="FieldInput" style="width:25%"><label id="checkApproveDate" name="checkApproveDate" field="checkApproveDate"/></td>
					</tr>
			   		<tr>
						<td class="FieldLabel" nowrap="nowrap" rowspan="2">审核意见</td>
						<td colspan="3" style="background-color:#F5FAFA;padding: 0 0 0 0;width: 100%;height: 100%;border:0;">
								<table style="width: 100%;height: 100%;border:0;padding: 0 0 0 0;">
									<tr> 
					   					<td class="FieldLabel" style="width:25%">意见</td>
					   					<td class="FieldInput" style="width:25%">
					   						<label name="agreeFlag" id="agreeFlag" field="agreeFlag" dataset="AgreeEnum" />
					   					</td>
					   					<td id="report" style="background-color:#F5FAFA;padding: 0 0 0 0;width: 100%;height: 100%;border:0;">
					   						<table style="width: 100%;height: 100%;border:0;padding: 0 0 0 0;">
					   							<tr>
					   								<td class="FieldLabel" style="width:25%;">是否上报</td>
							   						<td class="FieldInput" style="width:25%;">
							   							<label id="reportFlag" name="reportFlag" field="reportFlag" dataset="ReportFlagEnum" />
													</td>
					   							</tr>
					   						</table>
					   					</td>
				   					</tr>
			   					</table>
						</td>
					</tr>
					<tr>
						<td class="FieldInput" colspan="3"><label id="checkAdvice" name="checkAdvice" field="checkAdvice"></label></td>
					</tr>
					</table>
				</div>
				<br>
				<div id="cityCheck">
					<table border="0"  width="98%">
				   		<tr>
				   			<td class="FieldLabel" rowspan="3" style="width:12.5%">市级审核</td>
							<td class="FieldLabel" style="width:12.5%">负责人</td>
							<td class="FieldInput" style="width:25%"><label id="aduitIncharge" title="负责人" name="aduitIncharge" field="aduitIncharge"/></td>
							<td class="FieldLabel" style="width:25%">审核时间</td>
							<td class="FieldInput" style="width:25%"><label id="aduitApproveDate" title="审核时间" name="aduitApproveDate" field="aduitApproveDate"/></td>
						</tr>
						
						<tr>
							<td class="FieldLabel" nowrap="nowrap" rowspan="2">审核意见</td>
							<td colspan="3" style="background-color:#F5FAFA;padding: 0 0 0 0;width: 100%;height: 100%;border:0;">
									<table style="width: 100%;height: 100%;border:0;padding: 0 0 0 0;">
										<tr> 
						   					<td class="FieldLabel" style="width:25%;">意见</td>
						   					<td class="FieldInput" >
						   						<label id="aduitAgreeFlag" name="aduitAgreeFlag" field="aduitAgreeFlag" dataset="AgreeEnum" />
						   					</td>
						   					
					   					</tr>
				   					</table>
							</td>
						</tr>
						<tr>
							<td class="FieldInput" colspan="3"><label id="aduitAdvice" title="审核意见" name="aduitAdvice" field="aduitAdvice"></label></td>
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

//设置环节域的隐藏
function setHide(){
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
					var txts = target.getElementsByTagName("textarea");
					for(var i=0;i<txts.length;i++)
					{				  	
						txts[i].disabled=true;												
					}
				}		
				<%
			}
		}
	}
	%>	
}

</script>
</html>
