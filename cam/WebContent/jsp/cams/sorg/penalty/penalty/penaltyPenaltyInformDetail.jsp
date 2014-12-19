<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.inspur.cams.sorg.util.SomIdHelp"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>社会组织行政处罚出具处罚决定书</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="penalty.js"></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request,"bpm/bpm.js")%>"></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request,"cams.js") %>"></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request,"camsCheck.js") %>"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js")%>'></script>
<script type="text/javascript">
	var processId = '<%=request.getParameter("processId")%>';
	var actDefUniqueId='<%=request.getParameter("actDefUniqueId")%>';
	var assignmentId='<%=request.getParameter("assignmentId")%>';
	var act="<%=request.getParameter("act") %>";	
	var method="<%=request.getParameter("method") %>";	
	var sorgId="";
	var applyType="303,304,305";
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
	<%--电子档案--%>
	<model:dataset id="somElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true" method="queryCatalog" isGroup="true" groupField="applyType" pageSize="50">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--电子档案上传窗口--%>
	<model:dataset id="winElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--下载窗口--%>
	<model:dataset id="downloadDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" method="queryElectronic">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>			
	<model:dataset id="cataLogCodeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value="SOM_CATALOG"></model:param>
			<model:param name="value" value="CATALOG_CODE"></model:param>
			<model:param name="text" value="CATALOG_NAME"></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="opinionSelect" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>		
	<!-- 案件来源 -->
	<model:dataset id="caseSourceSelect" enumName="SOM.PENALTY.CASE_SOURCE" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="penaltyInformTypeSelect" enumName="SOM.PENALTY.PENALTY_INFORM_TYPE" autoLoad="true" global="true"></model:dataset>		
</model:datasets>

<next:Panel width="100%" height="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="社会组织行政处罚"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="返回" handler="goBack"></next:ToolBarItem>
	</next:TopBar>
	<next:TabPanel  id="tab" width="100%" height="100%">	
		<next:Tabs>
			<next:Panel title="行政处罚决定审批表" width="100%" height="100%" autoScroll="true">
				<next:Html>
					<fieldset>
						<form method="post" dataset="somPenaltyDataSet" onsubmit="return false" class="L5form">
							<table width="100%">
								<tr>
									<td class="FieldLabel" width="20%"><label>案号：</label></td>
									<td class="FieldInput" width="30%"><label field="caseCode" name='"案号"' /></td>
									<td class="FieldLabel" width="20%"><label>案由：</label></td>
									<td class="FieldInput" width="30%"><label field="invInfact" name='"案由"' /></td>
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
									<td class="FieldLabel"><label>事先/听证告知书发出日期：</label></td>
									<td class="FieldInput"><label field="informDate" name='"事先/听证告知书发出日期"' /></td>									
									<td class="FieldLabel"><label>事先/听证告知书编号：</label></td>
									<td class="FieldInput"><label field="informNo" name='"事先/听证告知书编号"' ></td>									
								</tr>	
								<tr>
									<td class="FieldLabel"><label>事先/听证告知处罚的类型：</label></td>
									<td class="FieldInput"><label field="penaltyInformType" name='"事先/听证告知处罚的类型"' style="width:93%" dataset='penaltyInformTypeSelect'/></td>									
									<td class="FieldLabel"></td>
									<td class="FieldInput"></td>		
								</tr>								
								<tr>
									<td class="FieldLabel"><label>事先/听证告知处罚的内容：</label></td>
									<td class="FieldInput" colspan="3"><textarea rows="5" field="informContent" name='"事先/听证告知处罚的内容"' style="width:93%" readonly></textarea></td>									
								</tr>
								<tr>
									<td class="FieldLabel"><label>当事人陈述、申辩的意见和理由：</label></td>
									<td class="FieldInput" colspan="3"><textarea rows="5" field="avermentReason" name='"当事人陈述、申辩的意见和理由"' style="width:93%" readonly></textarea></td>
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
									<td class="FieldInput" width="30%"><label field="penaltyOpinionId" dataset="opinionSelect"/></td>
									<td class="FieldLabel" width="20%"><label>承办登记人</label></td>
									<td class="FieldInput" width="30%"><label field="penaltyPeopleName" /></td>
								</tr>
								<tr>
									<td class="FieldLabel"><label>承办人补充意见：</label></td>
									<td class="FieldInput" colspan="3"><textarea rows="3" field="penaltyOpinion" style="width:93%" readonly></textarea></td>
								</tr>
								<tr>
									<td class="FieldLabel" width="20%"><label>审核人意见：</label></td>
									<td class="FieldInput" width="30%" colspan="3"><label field="penaltyCheckOpinionId" dataset="opinionSelect"/></td>
								</tr>
								<tr>
									<td class="FieldLabel" width="20%"><label>审核人：</label></td>
									<td class="FieldInput" width="30%"><label field="penaltyCheckPeopleName" /></td>
									<td class="FieldLabel" width="20%"><label>审核时间：</label></td>
									<td class="FieldInput" width="30%"><label field="penaltyCheckTime" /></td>
								</tr>
								<tr>
									<td class="FieldLabel"><label>审核人补充意见：</label></td>
									<td class="FieldInput" colspan="3"><textarea rows="3" field="penaltyCheckOpinion" style="width:93%" readonly></textarea></td>
								</tr>
								<tr>
									<td class="FieldLabel" width="20%"><label>审批人意见：</label></td>
									<td class="FieldInput" width="30%" colspan="3"><label field="penaltyAuditOpinionId" dataset="opinionSelect"/></td>
								</tr>
								<tr>
									<td class="FieldLabel" width="20%"><label>审批人：</label></td>
									<td class="FieldInput" width="30%"><label field="penaltyAuditPeopleName" /></td>
									<td class="FieldLabel" width="20%"><label>审批时间：</label></td>
									<td class="FieldInput" width="30%"><label field="penaltyAuditTime" /></td>
								</tr>
								<tr>
									<td class="FieldLabel"><label>审批人补充意见：</label></td>
									<td class="FieldInput" colspan="3"><textarea rows="3" field="penaltyAuditOpinion" style="width:93%" readonly></textarea></td>
								</tr>
							</table>
						</form>
					</fieldset>
				</next:Html>
			</next:Panel>
			<next:Panel title="法律要件" >
				<next:EditGridPanel id="uploadGrid" width="100%" stripeRows="true" height="100%" dataset="somElectronicDataSet">
					<next:GroupingView forceFit="true"></next:GroupingView>
					<next:TopBar>
						<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
					</next:TopBar>			
					<next:Columns>
						<next:RowNumberColumn />
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="档案目录名"  field="catalogCode" width="280" editable="false" dataset="cataLogCodeSelect"><next:TextField /></next:Column>
						<next:Column header="附件名称"    field="fileName" width="200" editable="false"><next:TextField /></next:Column>
						<next:Column header="附件描述"    field="fileMess" width="200" editable="false"><next:TextField /></next:Column>
						<next:Column header="下载附件"    field="" width="80" editable="false" renderer="clickDownloadHref"><next:TextField /></next:Column>
						<next:Column header="业务类型"    field="applyType" hidden="true">
							<next:ExtendConfig>groupRenderer:grender,groupName:"法律要件目录"</next:ExtendConfig>
						</next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="somElectronicDataSet" />
					</next:BottomBar>
				</next:EditGridPanel>
			</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>
<jsp:include page="../../comm/upload/uploadWindow.jsp" flush="true"/>
</body>
</html>