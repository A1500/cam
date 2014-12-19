<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>分数合计及年检报告</title>
<next:ScriptManager />
<script>
		var idField='<%=request.getParameter("dataBean")%>';
		var checkNum='<%=request.getParameter("checkNum")%>';
</script>
<script type="text/javascript" src="annualreport_score.js"></script>
</head>
<body>

<model:datasets>
	<model:dataset id="ds"
		cmd="com.inspur.cams.fis.ep.base.cmd.CemeInspectionQueryCmd"
		method="queryAudit" global="true">
		<model:record
			fromBean="com.inspur.cams.fis.ep.base.data.FisCemeCheckAudit"></model:record>
	</model:dataset>
	<model:dataset id="inspectionDataSet"
		enumName="FIS.CEME.RESULT" autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:ViewPort>
	<next:AnchorLayout>
		<!-- 分数合计及年检报告 -->
		<next:Panel height="100%" width="100%" autoScroll="true"
			id="statisticalScore">
			<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="return" text="返回" handler="back" />
			</next:TopBar>
			<next:Html>
				<form id="editForm" method="post" dataset="ds"
					onsubmit="return false" class="L5form">
				<fieldset><legend>分数合计</legend>
				<table width="100%" align="center">
					<tr>
						<td class="FieldLabel" width="21%">总得分</td>
						<td class="FieldInput" ><label field="totalScore" /></td>
					</tr>
				</table>
				</fieldset>
				<fieldset id="first"><legend>检查记录</legend>
				<div >
				<table width="100%">
					<tr>
						<td class="FieldLabel" rowspan="2" width="100px">检查</td>
						
						<td class="FieldLabel" width="30%">检查时间</td>
						<td class="FieldInput"><label field="firstTime"  /></td>
					</tr>
					<tr>
						<td class="FieldLabel" width="30%">检查意见</td>
						<td class="FieldInput" colspan="3"><textarea  style="width: 80%" rows="20" disabled="disabled" field="firstOpinion" > </textarea>
						</td>
					</tr>
				</table>
				</div>
				</fieldset>
				<fieldset id="second"><legend>年检记录</legend>
				<div >
				<table width="100%">
					<tr>
						<td class="FieldLabel" rowspan="2"  width="100px">年
						检</td>
						<td class="FieldLabel" width="10%">年检时间</td>
						<td class="FieldInput"><label field="secondTime"  width="30%"/></td>
						<td class="FieldLabel" width="10%">年检结果</td>
						<td class="FieldInput"><label	field="secondResult"  dataset="inspectionDataSet"></td>
					</tr>
					<tr>
						<td class="FieldLabel"  width="100px">年检报告</td>
						<td class="FieldInput" colspan="3"><textarea rows="20" disabled="disabled"
							style="width: 97%" name="年检报告" field="annuareport"></textarea></td>
					</tr>
				</table>
				</div>
				</fieldset>
				</form>
			</next:Html>
		</next:Panel>
	</next:AnchorLayout>
</next:ViewPort>
</body>
</html>

