<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.inspur.cams.sorg.util.SomIdHelp"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>社会组织行政处罚调查取证</title>
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
	var applyType="303";
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
		<next:ToolBarItem symbol="社会组织行政处罚"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="save" />		
		<next:ToolBarItem iconCls="select" text="提交" handler="submit" />
		<next:ToolBarItem iconCls="return" text="返回" handler="goBack"></next:ToolBarItem>
	</next:TopBar>
	<next:TabPanel id="tab"  width="100%" height="100%">	
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
									<td class="FieldInput" width="30%">
										<select id="caseSource" field="caseSource" name='"案件来源"' onchange="loadCaseSource()" style="width:80%" disabled>
											<option dataset="caseSourceSelect"></option>
										</select>
									</td>
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
								<tr id="caseSourceCheck1" style="display:none">
									<td class="FieldLabel"><label>监督检查人1姓名：</label></td>
									<td class="FieldInput"><label id="c_providerName" field="providerName" /></td>									
									<td class="FieldLabel"><label>监督检查人1单位：</label></td>
									<td class="FieldInput"><label id="c_providerOrgan" field="providerOrgan" /></td>
								</tr>
								<tr id="caseSourceCheck2" style="display:none">
									<td class="FieldLabel"><label>监督检查人2姓名：</label></td>
									<td class="FieldInput"><label id="c_providerNameOther" field="providerNameOther" /></td>									
									<td class="FieldLabel"><label>监督检查人2单位：</label></td>
									<td class="FieldInput"><label id="c_providerOrganOther" field="providerOrganOther" /></td>
								</tr>								
								<tr id="caseSourceReport1" style="display:none">
									<td class="FieldLabel"><label>投诉举报人姓名：</label></td>
									<td class="FieldInput"><label id="r_providerName" field="providerName" /></td>									
									<td class="FieldLabel"><label>举报投诉方式：</label></td>
									<td class="FieldInput"><label id="r_providerWay" field="providerWay" /></td>
								</tr>
								<tr id="caseSourceReport2" style="display:none">
									<td class="FieldLabel"><label>投诉举报人单位：</label></td>
									<td class="FieldInput"><label id="r_providerOrgan" field="providerOrgan" /></td>
									<td class="FieldLabel"><label>投诉举报人电话：</label></td>
									<td class="FieldInput"><label id="r_providerPhone" field="providerPhone" /></td>									
								</tr>
								<tr id="caseSourceReport3" style="display:none">
									<td class="FieldLabel"><label>投诉举报人住址：</label></td>
									<td class="FieldInput"><label id="r_providerAdd" field="providerAdd" /></td>
									<td class="FieldLabel"><label>投诉举报人邮编：</label></td>
									<td class="FieldInput"><label id="r_providerPost" field="providerPost" /></td>									
								</tr>								
								<tr id="caseSourceMove1" style="display:none">
									<td class="FieldLabel"><label>移送交办单位名称：</label></td>
									<td class="FieldInput"><label id="m_providerOrgan" field="providerOrgan" /></td>									
									<td class="FieldLabel"><label>移送、交办方式：</label></td>
									<td class="FieldInput"><label id="m_providerWay" field="providerWay" /></td>
								</tr>
								<tr id="caseSourceMove2" style="display:none">
									<td class="FieldLabel"><label>移送交办单位联系人：</label></td>
									<td class="FieldInput"><label id="m_providerName" field="providerName" /></td>
									<td class="FieldLabel"><label>移送交办单位电话：</label></td>
									<td class="FieldInput"><label id="m_providerPhone" field="providerPhone" /></td>									
								</tr>
								<tr id="caseSourceMove3" style="display:none">
									<td class="FieldLabel"><label>移送交办单位住址：</label></td>
									<td class="FieldInput"><label id="m_providerAdd" field="providerAdd" /></td>
									<td class="FieldLabel"><label>移送交办单位邮编：</label></td>
									<td class="FieldInput"><label id="m_providerPost" field="providerPost" /></td>									
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
									<td class="FieldLabel"><label>立案时间：</label></td>
									<td class="FieldInput"><label field="regDate" name='"立案时间"' /></td>									
									<td class="FieldLabel"></td>
									<td class="FieldInput"></td>
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
			<next:Panel title="法律要件" >
				<next:EditGridPanel id="uploadGrid" width="100%" stripeRows="true" height="100%" dataset="somElectronicDataSet">
					<next:GroupingView forceFit="true"></next:GroupingView>
					<next:TopBar>
						<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem iconCls="add" text="增加上传附件" handler="uploadFile"></next:ToolBarItem>
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