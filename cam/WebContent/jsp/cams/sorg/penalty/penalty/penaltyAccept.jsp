<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>社会组织行政处罚受理登记</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="penaltyAccept.js"></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request,"bpm/bpm.js")%>"></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request,"cams.js") %>"></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request,"camsCheck.js") %>"></script>
<script type="text/javascript">
	var processId = '<%=request.getParameter("processId")%>';
	var actDefUniqueId='<%=request.getParameter("actDefUniqueId")%>';
	var assignmentId='<%=request.getParameter("assignmentId")%>';
	var method="<%=request.getParameter("method") %>";	
	//如果是根据年检结果直接转过来的
	if(method=="checkForPenalty"||method=="penaltyNoPass"){
		var sorgName=decodeURIComponent('<%=request.getParameter("sorgName")%>');
		var sorgType='<%=request.getParameter("sorgType")%>';
		var sorgCode=decodeURIComponent('<%=request.getParameter("sorgCode")%>');
		var caseBrief=decodeURIComponent('<%=request.getParameter("statusDesc")%>');
		var currentUserName = '<%= BspUtil.getEmpOrgan().getOrganName()%>';
		var currentOrganName = '<%= BspUtil.getOrganName()%>';
		var checkTaskCode = '<%=request.getParameter("checkTaskCode")%>';
	}
	
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="somPenaltyDataSet" cmd="com.inspur.cams.sorg.penalty.base.cmd.SomPenaltyQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.penalty.base.data.SomPenalty">	
			<model:field name="sorgName" type="string" rule="require" />
			<model:field name="sorgType" type="string" rule="require" />
			<model:field name="sorgCode" type="string" rule="require" />
			<model:field name="caseSource" type="string" rule="require" />		
			<model:field name="caseBrief" type="string" rule="require" />		
		</model:record>
	</model:dataset>	
	<model:dataset id="somPenaltyApplyDataSet" cmd="com.inspur.cams.sorg.penalty.base.cmd.SomPenaltyApplyQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.penalty.base.data.SomPenaltyApply">
			<model:field name="regDealPeople" type="string" rule="require" />
			<model:field name="curOpinionId" type="string" rule="require" />			
		</model:record>
	</model:dataset>
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" method="queryMain">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan">
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
		<next:ToolBarItem symbol="社会组织行政处罚"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="saveAccept" />		
		<next:ToolBarItem iconCls="select" text="提交" handler="submitAccept" />
		<next:ToolBarItem iconCls="return" text="返回" handler="goBack"></next:ToolBarItem>
	</next:TopBar>
	<next:TabPanel id="tab" width="100%" height="100%">	
		<next:Tabs>
			<next:Panel title="案件受理登记表" width="100%" height="100%" autoScroll="true">
				<next:Html>
					<fieldset>
						<form method="post" dataset="somPenaltyDataSet" onsubmit="return false" class="L5form">
							<table width="100%">
								<tr>
									<td class="FieldLabel" width="20%"><label>社会组织名称：</label></td>
									<td class="FieldInput" width="30%"><input id="sorgName" field="sorgName" name='"社会组织名称"' onchange="loadSorgByName()"  style="width:93%"/><span style="color:red">*</span></td>
									<td class="FieldLabel" width="20%"><label>社会组织类型：</label></td>
									<td class="FieldInput" width="30%">
										<select id="sorgType" field="sorgType" name='"社会组织类型"' style="width:80%" onchange="loadSorg()">
											<option dataset="sorgTypeSelect"></option>
										</select><span style="color:red">*</span>
									</td>
									</tr>
								<tr>
									<td class="FieldLabel" width="20%"><label>社会组织登记证号：</label></td>
									<td class="FieldInput" width="30%"><input id="sorgCode" field="sorgCode" name='"社会组织登记证号"' onchange="loadSorg()" style="width:80%"/><span style="color:red">*</span></td>
									<td class="FieldLabel" width="20%"><label>案件来源：</label></td>
									<td class="FieldInput" width="30%">
										<select id="caseSource" field="caseSource" name='"案件来源"' onblur="loadCaseSource()" style="width:80%">
											<option dataset="caseSourceSelect"></option>
										</select><span style="color:red">*</span>
									</td>
								</tr>								
								<tr id="caseSourceCheck1" style="display:none">
									<td class="FieldLabel"><label>监督检查人1姓名：</label></td>
									<td class="FieldInput"><input id="c_providerName" field="providerName" name='"监督检查人1姓名"' style="width:80%"/></td>									
									<td class="FieldLabel"><label>监督检查人1单位：</label></td>
									<td class="FieldInput"><input id="c_providerOrgan" field="providerOrgan" name='"监督检查人1单位"' style="width:80%"/></td>
								</tr>
								<tr id="caseSourceCheck2" style="display:none">
									<td class="FieldLabel"><label>监督检查人2姓名：</label></td>
									<td class="FieldInput"><input id="c_providerNameOther" field="providerNameOther" name='"监督检查人2姓名"' style="width:80%"/></td>									
									<td class="FieldLabel"><label>监督检查人2单位：</label></td>
									<td class="FieldInput"><input id="c_providerOrganOther" field="providerOrganOther" name='"监督检查人2单位"' style="width:80%"/></td>
								</tr>								
								<tr id="caseSourceReport1" style="display:none">
									<td class="FieldLabel"><label>投诉举报人姓名：</label></td>
									<td class="FieldInput"><input id="r_providerName" field="providerName" name='"投诉举报人姓名"' style="width:80%"/></td>									
									<td class="FieldLabel"><label>举报投诉方式：</label></td>
									<td class="FieldInput"><input id="r_providerWay" field="providerWay" name='"举报投诉方式"' style="width:80%"/></td>
								</tr>
								<tr id="caseSourceReport2" style="display:none">
									<td class="FieldLabel"><label>投诉举报人单位：</label></td>
									<td class="FieldInput"><input id="r_providerOrgan" field="providerOrgan" name='"投诉举报人单位"' style="width:80%"/></td>
									<td class="FieldLabel"><label>投诉举报人电话：</label></td>
									<td class="FieldInput"><input id="r_providerPhone" field="providerPhone" name='"投诉举报人电话"' style="width:80%"/></td>									
								</tr>
								<tr id="caseSourceReport3" style="display:none">
									<td class="FieldLabel"><label>投诉举报人住址：</label></td>
									<td class="FieldInput"><input id="r_providerAdd" field="providerAdd" name='"投诉举报人住址"' style="width:80%"/></td>
									<td class="FieldLabel"><label>投诉举报人邮编：</label></td>
									<td class="FieldInput"><input id="r_providerPost" field="providerPost" name='"投诉举报人邮编"' style="width:80%"/></td>									
								</tr>								
								<tr id="caseSourceMove1" style="display:none">
									<td class="FieldLabel"><label>移送交办单位名称：</label></td>
									<td class="FieldInput"><input id="m_providerOrgan" field="providerOrgan" name='"移送交办单位名称"' style="width:80%"/></td>									
									<td class="FieldLabel"><label>移送、交办方式：</label></td>
									<td class="FieldInput"><input id="m_providerWay" field="providerWay" name='"移送、交办方式"' style="width:80%"/></td>
								</tr>
								<tr id="caseSourceMove2" style="display:none">
									<td class="FieldLabel"><label>移送交办单位联系人：</label></td>
									<td class="FieldInput"><input id="m_providerName" field="providerName" name='"移送交办单位联系人"' style="width:80%"/></td>
									<td class="FieldLabel"><label>移送交办单位电话：</label></td>
									<td class="FieldInput"><input id="m_providerPhone" field="providerPhone" name='"移送交办单位电话"' style="width:80%"/></td>									
								</tr>
								<tr id="caseSourceMove3" style="display:none">
									<td class="FieldLabel"><label>移送交办单位住址：</label></td>
									<td class="FieldInput"><input id="m_providerAdd" field="providerAdd" name='"移送交办单位住址"' style="width:80%"/></td>
									<td class="FieldLabel"><label>移送交办单位邮编：</label></td>
									<td class="FieldInput"><input id="m_providerPost" field="providerPost" name='"移送交办单位邮编"' style="width:80%"/></td>									
								</tr>
								<tr>
									<td class="FieldLabel"><label>案件简要情况：</label></td>
									<td class="FieldInput" colspan="3"><textarea rows="5" field="caseBrief" name='"案件简要情况"' style="width:93%"></textarea><span style="color:red">*</span></td>
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
								<td class="FieldLabel" width="13%"><label>处理意见：</label></td>
								<td class="FieldInput">
									<select field="curOpinionId" name='"处理意见"' style="width:150px" default="0">
										<option dataset="opinionSelect"></option>
									</select><span style="color:red">*</span>
								</td>									
							</tr>
							<tr>
								<td class="FieldLabel"><label>承办人：</label></td>
								<td class="FieldInput"><input field="acceptDealPeople" name='"承办人"' style="width:40%"/><span style="color:red">（承办人为多个，请使用“,”分割）*</span></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>处理补充意见：</label></td>
								<td class="FieldInput">
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