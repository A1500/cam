<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<script>
		var idField='<%=request.getParameter("dataBean")%>';
</script>
<html>
<head>
<next:ScriptManager />
<script type="text/javascript" src="prssoldiersplacement.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="prsPlacementDataset"
		cmd="com.inspur.cams.prs.prssoldiersplacement.cmd.PrsSoldiersPlacementQueryCommand"
		global="true">
	</model:dataset>
	<!-- 就业形式 -->
	<model:dataset id="EmploymentType" enumName="EMPLOYMENT.TYPE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 安置形式 -->
	<model:dataset id="PlacementType" enumName="PLACEMENT.TYPE"
		autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:ViewPort>
	<next:AnchorLayout>
		<next:Panel>
			<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem symbol="-"></next:ToolBarItem>
				<next:ToolBarItem iconCls="print" text="打印安置信息" handler="print"></next:ToolBarItem>
				<next:ToolBarItem symbol="-"></next:ToolBarItem>
				<next:ToolBarItem iconCls="undo" text="返回" handler="back" />
			</next:TopBar>
			<next:Html>
				<fieldset>
				<form id="PrsSoldiersPlacementForm" method="post"
					dataset="prsPlacementDataset" onsubmit="return false"
					style="padding: 5px;" class="L5form">
				<table border="1" width="98%">
					<tr>
						<td class="FieldLabel" style="width: 10%" colspan="2">安置方式：</td>
						<td class="FieldInput" style="width: 30%">
						<label id="employmentType"
							field="EMPLOYMENT_TYPE" dataset="EmploymentType"></label>&nbsp;&nbsp;&nbsp;
						<label id="resettlementSituation" field="RESETTLEMENT_SITUATION"
							dataset="PlacementType" ></label>
						</td>
						<td class="FieldLabel" style="width: 10%">就业时间：</td>
						<td class="FieldInput" style="width: 30%"><label field="EMPLOYMENT_TIME" id="EMPLOYMENT_TIME" /></td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width: 10%" colspan="2">档案考核成绩：</td>
						<td class="FieldInput" style="width: 30%"><label field="ARCHIVES_PERFORMANCE_SCORES" id="archivesPerformanceScores" /></td>

						<td class="FieldLabel" style="width: 10%">文化考试成绩：</td>
						<td class="FieldInput" style="width: 30%"><label field="CULTURAL_STUDIES_TEST_SCORES" id="culturalStudiesTestScores" /></td>
					</tr>
					<tr>
						<td class="FieldLabel" colspan="2">总成绩：</td>
						<td class="FieldInput"><label name="总成绩" id ="totalScore" field="TOTAL_SCORE" /></td>

						<td class="FieldLabel">名次：</td>
						<td class="FieldInput"><label name="名次" id="ranking" field="RANKING" /></td>
					</tr>
					<tr>
						<td class="FieldLabel" colspan="2">就业单位：</td>
						<td class="FieldInput" colspan="3"><label
							style="width: 74%"  field="EMPLOYMENT_COMPANY" /></td>
					</tr>
					<tr>
						<td class="FieldLabel" colspan="2">就业指导描述：</td>
						<td class="FieldInput" colspan="3"><textarea disabled="disabled"
							name="EmpGuidDESC" field="EMPLOYMENT_GUIDANCE_DESCRIBE"
							style="width: 74%" title="就业指导描述"></textarea></td>
					</tr>
					<tr>
						<td class="FieldLabel" nowrap="nowrap" rowspan="2">
							<div id ="zmzyj" style="display: block;">自谋职业金</div>
							<div id ="jjbzj" style="display: none;">经济补助金</div>
						</td>
						<td class="FieldLabel" nowrap="nowrap" rowspan="2" >发放金额（元）：</td>
						<td class="FieldInput" rowspan="2"><label name="发放金额"
							field="GRANT_GRANT" id="grantGrant" title="发放金额" /></td>
							<td class="FieldLabel" nowrap="nowrap" >申请时间：</td>
						<td class="FieldInput"><label name="申请时间"
							field="APPLICATION_DATE" id="applicationDate" /></td>
						
					</tr>
					<tr>
						<td class="FieldLabel" nowrap="nowrap">发放时间：</td>
						<td class="FieldInput"><label name="发放时间"
							field="GRANT_DATE" id="transactDate"/></td>
					</tr>
					<tr>
						<td class="FieldLabel" colspan="2">备注：</td>
						<td class="FieldInput" colspan="3"><textarea name="CONTENT" disabled="disabled"
							field="CONTENT" style="width: 74%" title="备注"></textarea></td>
					</tr>
				</table>
				</form>
				</fieldset>
			</next:Html>
		</next:Panel>
	</next:AnchorLayout>
</next:ViewPort>
</body>
</html>
