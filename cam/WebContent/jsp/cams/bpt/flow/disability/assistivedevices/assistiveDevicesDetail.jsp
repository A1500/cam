<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<script type="text/javascript">
	var peopleId = '<%=request.getParameter("peopleId")%>';
	var applyId='<%=request.getParameter("applyId")%>' ;
</script>
<html>
	<head>
		<title>优抚_申请_伤残辅助器械编辑查看</title>
		<next:ScriptManager/>
	</head>
<body>
<model:datasets>
	<model:dataset id="AssistiveDevicesDataset" cmd="com.inspur.cams.bpt.manage.cmd.BptApplyAssistiveDevicesQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptApplyAssistiveDevices"></model:record>
	</model:dataset>
	<model:dataset id="AssistiveDevicesPrDataset" cmd="com.inspur.cams.bpt.manage.cmd.BptApplyAssistiveDevicesPrQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptApplyAssistiveDevicesPr">
		</model:record>
	</model:dataset>
	<!-- 性别 -->
	<model:dataset id="SexDataset" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
	
	<!-- 伤残类别代码 -->
	<model:dataset id="DisabilityTypeCodeEnum" enumName="DISABILITY.TYPE.CODE" autoLoad="true" global="true"></model:dataset>
	
	<!-- 伤残等级 -->
	<model:dataset id="DisabilityLevelDataset" enumName="LEVEL.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 伤残属别 -->
	<model:dataset id="DisabilityGenusDataset" enumName="GENUS.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 伤残器械 -->
	<model:dataset id="DevicesMaintenaDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='BPT_ASSISTIVE_DEVICES_MAINTENA'></model:param>
			<model:param name="value" value='APPLY_APPARATUS_ID'></model:param>
			<model:param name="text" value='APPARATUS_NAME'></model:param>
		</model:params>
	</model:dataset> 
	<!-- 是否同意 -->
	<model:dataset id="AgreeEnum" enumName="COMM.AGREEORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 上报标识-->
	<model:dataset id="ReportFlagEnum" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel autoHeight="true" bodyStyle="width:100%" width="100%">
	<next:TabPanel>
		<next:Tabs>
		
		<next:Panel title="基本信息" width="100%" height="100%"
				id="peopleInfoTabPanel">
				<next:Html>
				  <iframe id="peopleInfo" src="../../../comm/peopleDetail.jsp?peopleId=<%=request.getParameter("peopleId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
		
		<next:Panel title="类别信息" width="100%" height="100%"
				id="disabilityTypeTabPanel">
				<next:Html>
				  <iframe id="disabilityType" src="../assessdisability/disabilityTypeDetail.jsp?peopleId=<%=request.getParameter("peopleId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
		<next:Panel title="家庭成员信息" width="100%" height="100%" id="memberTabPanel">
				<next:Html>
				  <iframe id="member" src="../../../comm/memberListDetail.jsp?familyId=<%=request.getParameter("familyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
		<next:Panel title="住房信息" width="100%" height="100%"
				id="houseTabPanel">
				<next:Html>
				  <iframe id="house" src="../../../comm/houseDetail.jsp?familyId=<%=request.getParameter("familyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
			<next:Panel id="assistiveApplyPrint"  width="100%" height="100%" autoScroll="false" title="伤残器械申请">
				<next:Html>
					<iframe id="assistiveApplyPr" src="assistiveDevicesPrint.jsp?peopleId=<%=request.getParameter("peopleId")%>&applyId=<%=request.getParameter("applyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
			   </next:Html>
			</next:Panel>
			<next:Panel title="伤残器械更换审批表" width="100%" height="100%"
				id="changeTabPanel">
				<next:Html>
				  <iframe id="changeIframe" src="assistiveDevicesChangePrint.jsp?peopleId=<%=request.getParameter("peopleId")%>&applyId=<%=request.getParameter("applyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
		<next:Panel title="辅助器具配置通知书" width="100%" height="100%"
				id="noticeTabPanel">
				<next:Html>
				  <iframe id="noticIframe" src="assistiveDevicesNoticePrint.jsp?peopleId=<%=request.getParameter("peopleId")%>&applyId=<%=request.getParameter("applyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
			<next:Panel width="100%" height="100%" autoScroll="true" title="县级审核">
			<next:Html>
				<form id="editForm" dataset="AssistiveDevicesPrDataset" onsubmit="return false" style="padding: 5px;" class="L5form">
				<table border="1"  width="99%">
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
							   							<label id="reportFlag" name="reportFlag" field="reportFlag" dataset="AgreeEnum" />
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
				</form>
		   </next:Html>
		</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>

</body>
	<script type="text/javascript">
		function init(){
			var AssistiveDevicesDataset = L5.DatasetMgr.lookup("AssistiveDevicesDataset");
			AssistiveDevicesDataset.setParameter("APPLY_ID",applyId);
	 		AssistiveDevicesDataset.load();
	 		var AssistiveDevicesPrDataset = L5.DatasetMgr.lookup("AssistiveDevicesPrDataset");
 			AssistiveDevicesPrDataset.setParameter("APPLY_ID",applyId);
 			AssistiveDevicesPrDataset.load();
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
	</script>
</html>
