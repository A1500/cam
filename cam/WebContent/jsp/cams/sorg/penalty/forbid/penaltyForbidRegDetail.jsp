<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>取缔非法社会组织立案</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="penaltyForbid.js"></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request,"bpm/bpm.js")%>"></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request,"cams.js") %>"></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request,"camsCheck.js") %>"></script>
<script type="text/javascript">
	var processId = '<%=request.getParameter("processId")%>';
	var actDefUniqueId='<%=request.getParameter("actDefUniqueId")%>';
	var assignmentId='<%=request.getParameter("assignmentId")%>';
	var act='<%=request.getParameter("act")%>';
	var method="<%=request.getParameter("method") %>";	
</script>
</head>
<body>

<model:datasets>
	<model:dataset id="somPenaltyDataSet" cmd="com.inspur.cams.sorg.penalty.base.cmd.SomPenaltyQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.penalty.base.data.SomPenalty">			
		</model:record>
	</model:dataset>	
	<model:dataset id="somPenaltyApplyDataSet" cmd="com.inspur.cams.sorg.penalty.base.cmd.SomPenaltyApplyQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.penalty.base.data.SomPenaltyApply">			
		</model:record>
	</model:dataset>
	<model:dataset id="sorgTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SORG_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>	
	<model:dataset id="opinionSelect" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>	
	<!-- 案件来源 -->
	<model:dataset id="caseSourceSelect" enumName="SOM.PENALTY.CASE_SOURCE" autoLoad="true" global="true"></model:dataset>		
</model:datasets>

<next:Panel width="100%" height="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="取缔非法社会组织"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<% 
			if("daiban".equals(request.getParameter("method"))){
		%>	
		<next:ToolBarItem iconCls="select" text="提交" handler="submit" />	
		<%
			}
		%>
		<next:ToolBarItem iconCls="return" text="返回" handler="goBack"></next:ToolBarItem>
	</next:TopBar>
	<next:TabPanel width="100%" height="100%" id='tab'>	
		<next:Tabs>					
			<next:Panel title="案件受理登记表" width="100%" height="100%" autoScroll="true">
				<next:Html>
					<fieldset>
						<form method="post" dataset="somPenaltyDataSet" onsubmit="return false" class="L5form">
							<table width="100%">
								<tr>
									<td class="FieldLabel" width="20%"><label>编号：</label></td>
									<td class="FieldInput" width="30%"><label field="caseCode"/></td>
									<td class="FieldLabel" width="20%"><label>案件来源：</label></td>
									<td class="FieldInput" width="30%"><label field="caseSource" dataset="caseSourceSelect" /></td>
								</tr>								
								<tr>
									<td class="FieldLabel" width="20%"><label>社会组织类型：</label></td>
									<td class="FieldInput" width="30%"><label field="sorgType" dataset="sorgTypeSelect" /></td>
									<td class="FieldLabel" width="20%"><label>社会组织登记证号：</label></td>
									<td class="FieldInput" width="30%"><label field="sorgCode" /></td>
								</tr>
								<tr>
									<td class="FieldLabel"><label>社会组织名称：</label></td>
									<td class="FieldInput" colspan="3"><label field="sorgName" /></td>
								</tr>
								<tr>
									<td class="FieldLabel"><label>案件简要情况：</label></td>
									<td class="FieldInput" colspan="3"><textarea rows="5" field="caseBrief" style="width:93%" readonly></textarea></td>
								</tr>
							</table>
						</form>
					</fieldset>							
					<fieldset>
						<legend>处理意见</legend>
						<form method="post" dataset="somPenaltyApplyDataSet" onsubmit="return false" class="L5form">
							<table width="100%">
								<tr>
									<td class="FieldLabel" width="20%"><label>承办人意见：</label></td>
									<td class="FieldInput" width="30%"><label field="acceptOpinionId" dataset="opinionSelect"/></td>
									<td class="FieldLabel" width="20%"><label>承办登记人：</label></td>
									<td class="FieldInput" width="30%"><label field="acceptPeopleName" /></td>
								</tr>
								<tr>
									<td class="FieldLabel" width="20%"><label>承办人：</label></td>
									<td class="FieldInput" width="30%"><label field="acceptDealPeople" /></td>
									<td class="FieldLabel" width="20%"><label>承办时间：</label></td>
									<td class="FieldInput" width="30%"><label field="acceptTime" /></td>
								</tr>
								<tr>
									<td class="FieldLabel"><label>承办人补充意见：</label></td>
									<td class="FieldInput" colspan="3"><textarea rows="3" field="acceptOpinion" style="width:93%" readonly></textarea></td>
								</tr>
							</table>
						</form>
					</fieldset>
				</next:Html>
			</next:Panel>				
			<next:Panel title="立案审批表" width="100%" height="100%" autoScroll="true">
				<next:Html>
					<fieldset>
						<form method="post" dataset="somPenaltyDataSet" onsubmit="return false" class="L5form">
							<table width="100%">
								<tr>
									<td class="FieldLabel" width="20%"><label>案号：</label></td>
									<td class="FieldInput" width="30%"><label field="caseCode" /></td>
									<td class="FieldLabel" width="20%"><label>案件来源：</label></td>
									<td class="FieldInput" width="30%"><label field="caseSource" dataset="caseSourceSelect"/></td>
								</tr>	
								<tr>
									<td class="FieldLabel"><label>案件名称：</label></td>
									<td class="FieldInput"><label field="regName" name='"案件名称"'  /></td>									
									<td class="FieldLabel"><label>立案时间：</label></td>
									<td class="FieldInput"><label field="regDate" name='"立案时间"' /></td>									
								</tr>			
								<tr>
									<td class="FieldLabel"><label>当事人名称：</label></td>
									<td class="FieldInput"><label field="partyName" /></td>									
									<td class="FieldLabel"><label>当事人住所：</label></td>
									<td class="FieldInput"><label field="partyAdd" /></td>
								</tr>
								<tr>
									<td class="FieldLabel"><label>当事人法定代表人（负责人）或发起人：</label></td>
									<td class="FieldInput"><label field="partyCharger" /></td>									
									<td class="FieldLabel"><label>当事人电话：</label></td>
									<td class="FieldInput"><label field="partyPhone" /></td>
								</tr>
								<tr>
									<td class="FieldLabel"><label>案情简介：</label></td>
									<td class="FieldInput" colspan="3"><textarea rows="5" field="caseDesc" name='"案情简介"' style="width:93%" readonly></textarea></td>
								</tr>
							</table>
						</form>
					</fieldset>						
					<fieldset>
						<legend>处理意见</legend>
						<form method="post" dataset="somPenaltyApplyDataSet" onsubmit="return false" class="L5form">
							<table width="100%">
								<tr>
									<td class="FieldLabel" width="20%"><label>承办人意见：</label></td>
									<td class="FieldInput" width="30%"><label field="regOpinionId" dataset="opinionSelect"/></td>
									<td class="FieldLabel" width="20%"><label>承办登记人</label></td>
									<td class="FieldInput" width="30%"><label field="regPeopleName" /></td>
								</tr>
								<tr>
									<td class="FieldLabel" width="20%"><label>承办人：</label></td>
									<td class="FieldInput" width="30%"><label field="regDealPeople" /></td>
									<td class="FieldLabel" width="20%"><label>承办时间：</label></td>
									<td class="FieldInput" width="30%"><label field="regTime" /></td>
								</tr>
								<tr>
									<td class="FieldLabel"><label>承办人补充意见：</label></td>
									<td class="FieldInput" colspan="3"><textarea rows="3" field="regOpinion" style="width:93%" readonly></textarea></td>
								</tr>
								<tr>
									<td class="FieldLabel" width="20%"><label>审核人意见：</label></td>
									<td class="FieldInput" width="30%" colspan="3"><label field="regCheckOpinionId" dataset="opinionSelect"/></td>
								</tr>
								<tr>
									<td class="FieldLabel" width="20%"><label>审核人：</label></td>
									<td class="FieldInput" width="30%"><label field="regCheckPeopleName" /></td>
									<td class="FieldLabel" width="20%"><label>审核时间：</label></td>
									<td class="FieldInput" width="30%"><label field="regCheckTime" /></td>
								</tr>
								<tr>
									<td class="FieldLabel"><label>审核人补充意见：</label></td>
									<td class="FieldInput" colspan="3"><textarea rows="3" field="regCheckOpinion" style="width:93%" readonly></textarea></td>
								</tr>
								<tr>
									<td class="FieldLabel" width="20%"><label>审批人意见：</label></td>
									<td class="FieldInput" width="30%" colspan="3"><label field="regAuditOpinionId" dataset="opinionSelect"/></td>
								</tr>
								<tr>
									<td class="FieldLabel" width="20%"><label>审批人：</label></td>
									<td class="FieldInput" width="30%"><label field="regAuditPeopleName" /></td>
									<td class="FieldLabel" width="20%"><label>审批时间：</label></td>
									<td class="FieldInput" width="30%"><label field="regAuditTime" /></td>
								</tr>
								<tr>
									<td class="FieldLabel"><label>审批人补充意见：</label></td>
									<td class="FieldInput" colspan="3"><textarea rows="3" field="regAuditOpinion" style="width:93%" readonly></textarea></td>
								</tr>
							</table>
						</form>
					</fieldset>
				</next:Html>
			</next:Panel>			
			<next:Panel title="请填写流程处理意见" width="100%">
				<next:Html>
					<form method="post" onsubmit="return false" class="L5form" dataset="somPenaltyApplyDataSet">
						<table width="100%">
							<tr>
								<td class="FieldLabel" style="width:13%"><label>处理意见：</label></td>
								<td class="FieldInput" colspan="5">
									<select field="curOpinionId" name='"处理意见"' style="width:150px" default="0">
										<option dataset="opinionSelect"></option>
									</select><span style="color:red">*</span>
								</td>									
							</tr>
							<tr>
								<td class="FieldLabel"><label>处理补充意见：</label></td>
								<td class="FieldInput" colspan="5">
									<textarea rows="10" name='"处理补充意见"' field="curOpinion" style="width:93%"></textarea>
								</td>
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