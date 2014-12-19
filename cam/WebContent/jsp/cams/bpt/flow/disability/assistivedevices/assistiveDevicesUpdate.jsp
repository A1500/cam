<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%
	response.setHeader("Expires", "Sat, 6 May 1995 12:00:00 GMT");  
	response.setHeader("Cache-Control", "no-store,no-cache,must-revalidate");  
	response.addHeader("Cache-Control", "post-check=0, pre-check=0");  
	response.setHeader("Pragma", "no-cache");  
%>
<html>
	<head>
		<title>优抚_申请_伤残辅助器械编辑</title>
		<next:ScriptManager/>
		<script>
     		var peopleId='<%=request.getParameter("peopleId")%>' ;
     		var applyId='<%=request.getParameter("applyId")%>' ;
     		var currentUserName = '<%= GetBspInfo.getBspInfo().getUserName()%>';
     		var organId='<%=BspUtil.getCorpOrgan().getOrganCode()%>';
     		var organType = '<%=BspUtil.getOrganType()%>';
		</script>
		<script type="text/javascript" src="<%=SkinUtils.getJS(request, "camsCheck.js")%>"></script>
		<script type="text/javascript" src="assistiveDevicesUpdate.js"></script>
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
	<model:dataset id="DevicesDataset" cmd="com.inspur.cams.bpt.manage.cmd.BptAssistiveDevicesMaintenaQueryCommand" global="true" > 
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptAssistiveDevicesMaintena">
			<model:field name="num" type="string"/>
		</model:record>
	</model:dataset>
</model:datasets>
<next:Panel autoHeight="true"   bodyStyle="width:100%" width="100%">
	<next:TabPanel>
		<next:Tabs>
		<next:Panel title="基本信息" width="100%" height="100%" id="peopleInfoTabPanel">
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
		<next:Panel title="家庭成员信息" width="100%" height="100%"
				id="memberTabPanel">
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
		<next:Panel width="100%" height="100%" autoScroll="true" title="伤残器械申请">
			<next:TopBar>
				<next:ToolBarItem symbol="->" ></next:ToolBarItem>
				<next:ToolBarItem iconCls="print"  text="生成" handler="print"/>
				<next:ToolBarItem symbol="-" ></next:ToolBarItem>
				<next:ToolBarItem iconCls="save"  text="保存" handler="update"/>
				<next:ToolBarItem symbol="-" ></next:ToolBarItem>
				<next:ToolBarItem iconCls="disable"  text="关闭" handler="fun_close"/>
				<next:ToolBarItem symbol="-" ></next:ToolBarItem>
			</next:TopBar>
			<next:Html>
				<form id="editForm" dataset="AssistiveDevicesDataset" onsubmit="return false" style="padding: 5px;" class="L5form">
				<table border="1"  width="99%">
			   		<tr>
						<td  class="FieldLabel" style="width:15%">姓名</td>
						<td  class="FieldInput" style="width:15%"><label id="name" name="name" field="name"/></td>
						
						<td  class="FieldLabel" style="width:15%">性别</td>
						<td  class="FieldInput" style="width:15%"><label id="sex" name="sex" field="sex" dataset="SexDataset" /></td>
					
						<td  class="FieldLabel" style="width:15%">身份证件号码</td>
						<td  class="FieldInput" style="width:15%"><label id="idCard" name="idCard" field="idCard"/></td>
					</tr>
			   		<tr>
						<td  class="FieldLabel">优抚对象类别</td>
						<td  class="FieldInput"><label id="objectType" name="objectType" field="objectType" dataset="DisabilityTypeCodeEnum"/></td>
						<td  class="FieldLabel">伤残等级</td>
						<td  class="FieldInput"><label id="disabilityLevel" name="disabilityLevel" field="disabilityLevel" dataset="DisabilityLevelDataset"/></td>
						<td  class="FieldLabel">伤残属别</td>
						<td  class="FieldInput"><label id="disabilityGenus" name="disabilityGenus" field="disabilityGenus" dataset="DisabilityGenusDataset"/></td>
					</tr>
			   		<tr> 
						<td  class="FieldLabel" nowrap="nowrap">伤残证书编号</td>
						<td  class="FieldInput" colspan="5"><label id="disabilityNo" name="disabilityNo" field="disabilityNo"/></td>
					</tr>
					<tr>
						<td  class="FieldLabel" >伤残情形</td>
						<td  class="FieldInput" colspan="5">
							<textarea id="disabilityCase" name="disabilityCase" field="disabilityCase" style="width:90%" rows="3" title="伤残情形"></textarea>
							<font color="red">*</font></td>
					</tr>
			   		<tr>
						<td  class="FieldLabel">住址</td>
						<td  class="FieldInput" colspan="2"><input type="text" id="address" name="address" style="width:90%" field="address" title="住址"/><font color="red">*</font></td>
						<td  class="FieldLabel">电话</td>
						<td  class="FieldInput" colspan="2"><input type="text" id="telMobile" name="telMobile" field="telMobile"/> </td>
					</tr>
			   		<tr>
						<td  class="FieldLabel">申请器械</td>
						<td  class="FieldInput" colspan="3">
								<input type="text" id="apparatusName" readOnly="true" field="apparatusName" style="width:80%" />
									<font color="red">*</font>
									<img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>" style="cursor:hand" onclick="selectDevices()"/>
								<input type="hidden" id="applyApparatusId" name="applyApparatusId" field="applyApparatusId">
						</td>
						
						<td  class="FieldLabel">配置类别</td>
						<td  class="FieldInput" >
							<select id="configuration" name="configuration" field="configuration" >
								<option value="0">初次配置</option>
								<option value="1">维修</option>
								<option value="2">更换</option>
							</select>
						</td>
					</tr>
			   		<tr>
						<td  class="FieldLabel">申请理由</td>
						<td  class="FieldInput" colspan="5"><textarea id="applyCausa" name="applyCausa" field="applyCausa" style="width:90%" rows="3" ></textarea></td>
					</tr>
			   		<tr>
						<td  class="FieldLabel">备注</td>
						<td  class="FieldInput" colspan="5"><textarea id="note" name="note" field="note" style="width:90%" rows="3" ></textarea></td>
					</tr>
					<input type="hidden" id="docpath" value="jsp/cams/bpt/flow/disability/assistivedevices/print/assistiveDvicesPrint.doc"/>
					<input type="hidden" id="applyId" name="printQuery" queryData="queryData" value="<%=request.getParameter("applyId")%>"/>
					<input type="hidden" id="organId" name="printQuery" queryData="queryData" value="<%=BspUtil.getCorpOrgan().getOrganCode()%>"/>
					<input type="hidden" id="peopleId" name="printQuery" queryData="queryData" value="<%=request.getParameter("peopleId")%>"/>
					<input type="hidden" id="method" name="queryData" queryData="queryData" value="queryAssisDevices"/>
					<input type="hidden" id="scaconfPath" value="assDisdislityApp/assDisdislityAppPrintDao"/>
				</table>
				</form>
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
		
		<next:Panel width="100%" height="100%" id="townapp" autoScroll="true" title="县级审核">
			<next:TopBar>
				<next:ToolBarItem symbol="->" ></next:ToolBarItem>
				<next:ToolBarItem symbol="-" ></next:ToolBarItem>
				<next:ToolBarItem iconCls="save" text="保存" handler="updateTownExamInfor"/>
				<next:ToolBarItem symbol="-" ></next:ToolBarItem>
				<next:ToolBarItem iconCls="view" id="submitButton" text="提交" handler="createAndSend"/>
				<next:ToolBarItem symbol="-" ></next:ToolBarItem>
				<next:ToolBarItem iconCls="disable" text="关闭" handler="fun_close"/>
				<next:ToolBarItem symbol="-"></next:ToolBarItem>
			</next:TopBar>
			<next:Html>
				<form id="editForm" dataset="AssistiveDevicesPrDataset" onsubmit="return false" style="padding: 5px;" class="L5form">
				<table border="1" width="99%">
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
					   					<td class="FieldLabel" nowrap="nowrap" style="width:22%;text-align: left">意见</td>
					   					<td class="FieldInput">
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
				</form>
		   </next:Html>
		</next:Panel>
		
		
		</next:Tabs>
	</next:TabPanel>
</next:Panel>
</body>
</html>
