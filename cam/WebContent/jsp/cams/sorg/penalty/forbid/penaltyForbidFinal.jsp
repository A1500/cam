<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.inspur.cams.sorg.util.SomIdHelp"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>取缔非法社会组织出具处罚决定书</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="penaltyForbid.js"></script>
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
	var applyType="303,306";
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
	<model:dataset id="somRestrictPeopleDetailDS" cmd="com.inspur.cams.sorg.restrict.cmd.SomRestrictPeopleDetailQueryCmd" global="true" method="queryPeople">
		<model:record fromBean="com.inspur.cams.sorg.restrict.data.SomRestrictPeopleDetail">
			<model:field name="name" type="string" rule="require|length{72}" />
			<model:field name="idCard" type="string" rule="require|length{18}" />			
		</model:record>
	</model:dataset>
	<model:dataset id="winRestrictPeopleDetailDS" cmd="com.inspur.cams.sorg.restrict.cmd.SomRestrictPeopleDetailQueryCmd" global="true" method="queryPeople">
		<model:record fromBean="com.inspur.cams.sorg.restrict.data.SomRestrictPeopleDetail">
		</model:record>
	</model:dataset>
	<model:dataset id="somPeopleDataSet"cmd="com.inspur.cams.sorg.base.cmd.SomPeopleQueryCmd">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeople">
			<model:field name="name" type="string" rule="require|length{72}" />
			<model:field name="idCard" type="string" rule="require|length{18}" />			
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
		<next:ToolBarItem symbol="取缔非法社会组织"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="save" />		
		<next:ToolBarItem iconCls="select" text="提交" handler="submit" />
		<next:ToolBarItem iconCls="return" text="返回" handler="goBack"></next:ToolBarItem>
	</next:TopBar>
	<next:TabPanel width="100%" height="100%"id="tab">
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
			<next:Panel title="案件调查终结报告" width="100%" height="100%" autoScroll="true">
				<next:Html>
					<fieldset>
						<form method="post" dataset="somPenaltyDataSet" onsubmit="return false" class="L5form">
							<table width="100%">
								<tr>
									<td class="FieldLabel" width="20%"><label>案号：</label></td>
									<td class="FieldInput" width="30%"><label field="caseCode" /></td>
									<td class="FieldLabel" width="20%"><label>调查人：</label></td>
									<td class="FieldInput" width="30%"><label field="invPerson" /></td>
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
									<td class="FieldLabel" width="20%"><label>调查开始时间：</label></td>
									<td class="FieldInput" width="30%">
										<label field="invStartDate" format="Y-m-d" style="width:100"/>
									</td>
									<td class="FieldLabel" width="20%"><label>调查结束时间：</label></td>
									<td class="FieldInput" width="30%">
										<label field="invEndDate" format="Y-m-d" style="width:100"/>
									</td>
								</tr>								
								<tr>
									<td class="FieldLabel"><label>案由及调查经过：</label></td>
									<td class="FieldInput" colspan="3"><textarea rows="5" field="invProcess" name='"案由及调查经过"' style="width:93%" readonly></textarea></td>									
								</tr>							
								<tr>
									<td class="FieldLabel"><label>违法事实：</label></td>
									<td class="FieldInput" colspan="3"><textarea rows="5" field="invInfact" name='"违法事实"' style="width:93%" readonly></textarea></td>									
								</tr>							
								<tr>
									<td class="FieldLabel"><label>案件性质：</label></td>
									<td class="FieldInput" colspan="3"><textarea rows="5" field="invCaseNature" name='"案件性质"' style="width:93%" readonly></textarea></td>									
								</tr>						
								<tr>
									<td class="FieldLabel"><label>处罚依据：</label></td>
									<td class="FieldInput" colspan="3"><textarea rows="5" field="invProof" name='"处罚依据"' style="width:93%" readonly></textarea></td>									
								</tr>						
								<tr>
									<td class="FieldLabel"><label>处罚建议：</label></td>
									<td class="FieldInput" colspan="3"><textarea rows="5" field="invPunSuggestions" name='"处罚建议"' style="width:93%" readonly></textarea></td>									
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
									<td class="FieldInput" width="30%"><label field="invAcceptOpinionId" dataset="opinionSelect"/></td>
									<td class="FieldLabel" width="20%"><label>承办登记人</label></td>
									<td class="FieldInput" width="30%"><label field="invAcceptPeopleName" /></td>
								</tr>
								<tr>
									<td class="FieldLabel" width="20%"><label>承办人：</label></td>
									<td class="FieldInput" width="30%"><label field="invAcceptDealPeople" /></td>
									<td class="FieldLabel" width="20%"><label>承办时间：</label></td>
									<td class="FieldInput" width="30%"><label field="invAcceptTime" /></td>
								</tr>
								<tr>
									<td class="FieldLabel"><label>承办人补充意见：</label></td>
									<td class="FieldInput" colspan="3"><textarea rows="3" field="invAcceptOpinion" style="width:93%" readonly></textarea></td>
								</tr>
							</table>
						</form>
					</fieldset>
				</next:Html>
			</next:Panel>
			<next:Panel title="取缔决定审批表" width="100%" height="100%" autoScroll="true">
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
									<td class="FieldLabel" width="20%"><label>承办人：</label></td>
									<td class="FieldInput" width="30%"><label field="penaltyDealPeople" /></td>
									<td class="FieldLabel" width="20%"><label>承办时间：</label></td>
									<td class="FieldInput" width="30%"><label field="penaltyTime" /></td>
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
			<next:Panel title="结案审批表" width="100%" height="100%" autoScroll="true">
				<next:Html>
					<fieldset>
						<form method="post" dataset="somPenaltyDataSet" onsubmit="return false" class="L5form">
							<table width="100%">
								<tr>
									<td class="FieldLabel" width="20%"><label>案号：</label></td>
									<td class="FieldInput" width="30%"><label field="caseCode" name='"案号"' /></td>
									<td class="FieldLabel" width="20%"><label>案件名称：</label></td>
									<td class="FieldInput" width="30%"><label field="regName" name='"案件名称"' style="width:93%" /></td>
								<tr>
									<td class="FieldLabel"><label>立案时间：</label></td>
									<td class="FieldInput"><label field="regDate" /></td>
									<td class="FieldLabel"><label>案件来源：</label></td>
									<td class="FieldInput"><label field="caseSource" dataset="caseSourceSelect"/></td>		
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
									<td class="FieldLabel"><label>结案理由：</label></td>
									<td class="FieldInput" colspan="3"><textarea rows="5" field="caseFinalReason" name='"结案理由"' style="width:93%"></textarea><span style="color:red">*</span></td>									
								</tr>								
							</table>
						</form>
					</fieldset>
				</next:Html>
			</next:Panel>
			<next:Panel title="直接责任人有关信息" width="100%">
				<next:EditGridPanel id="restrictPeopleGrid" dataset="somRestrictPeopleDetailDS" width="100%" stripeRows="true" height="100%">
					<next:TopBar>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem iconCls="add" text="增加" handler="addRestrictPeopleDetail"></next:ToolBarItem>
						<next:ToolBarItem iconCls="edit" text="修改" handler="updateRestrictPeopleDetail"></next:ToolBarItem>
						<next:ToolBarItem iconCls="delete" text="删除" handler="delRestrictPeopleDetail"></next:ToolBarItem>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="内码" field="peopleId" width="15%" editable="true" hidden="true"><next:TextField/></next:Column>
						<next:Column header="内码" field="id" width="15%" editable="true" hidden="true"><next:TextField/></next:Column>
						<next:Column header="身份证号" field="idCard" width="18%" editable="false"><next:TextField/></next:Column>
						<next:Column header="姓名" field="name" width="10%" editable="false"><next:TextField/></next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="somRestrictPeopleDetailDS" />
					</next:BottomBar>
				</next:EditGridPanel>
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
<next:Window id="restrictWin" closeAction="hide" title="直接责任人信息录入" width="600"  autoScroll="true" modal="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="确定" iconCls="detail" handler="forRestrictWin"></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="return" handler="closeRestrictWin"></next:ToolBarItem>	
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" dataset="winRestrictPeopleDetailDS" class="L5form">
			<table width="100%">
				<tr>
					<td class="FieldLabel" width="20%"><label>身份证号：</label></td>
					<td class="FieldInput" width="30%"><input id='idCard_restrict'field="idCard" name='"身份证号"' style="width:100%"onblur='validIdCard()'/></td>									
					<td class="FieldLabel" width="20%"><label>姓名：</label></td>
					<td class="FieldInput" width="30%"><input id='name_restrict'field="name" name='"姓名"' style="width:100%"/></td>
				</tr>
			</table>
		</form>
	</next:Html>
</next:Window>
<jsp:include page="../../comm/upload/uploadWindow.jsp" flush="true"/>
</body>
</html>