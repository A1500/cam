<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>退役士兵培训信息表编辑</title>
<next:ScriptManager />
<script>
			var idField='<%=request.getParameter("dataBean")%>';
		</script>
<script type="text/javascript" src="prssoldierstrain.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="prssoldierstrainDataset"
		cmd="com.inspur.cams.prs.prssoldierstrain.cmd.PrsSoldiersTrainQueryCommand"
		global="true">
		<model:record
			fromBean="com.inspur.cams.prs.prssoldierstrain.dao.PrsSoldiersTrain"></model:record>
	</model:dataset>

	<!-- 是否自愿参加 -->
	<model:dataset id="WhetherVoluntaryFlagEnum" enumName="COMM.YESORNO"
		autoLoad="true" global="true"></model:dataset>

	<!-- 培训类型 -->
	<model:dataset id="TrainingType" enumName="TRAINING.TYPE"
		autoLoad="true" global="true"></model:dataset>

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
				<next:ToolBarItem symbol="-" ></next:ToolBarItem>
				<next:ToolBarItem iconCls="print"  text="打印培训信息" handler="print"/>
				<next:ToolBarItem symbol="-" ></next:ToolBarItem>
				<next:ToolBarItem iconCls="undo" text="返回" handler="back" />
			</next:TopBar>
			<next:Html>
				<form id="editForm" dataset="prssoldierstrainDataset"
					onsubmit="return false" style="padding: 5px;" class="L5form">
				<table border="1" width="98%">
					<tr>
						<td class="FieldLabel" style="width: 15%">培训类型：</td>
						<td class="FieldInput" style="width: 15%"><label
							id="trainingType" name="trainingType" field="TRAINING_TYPE"
							dataset="TrainingType" /></td>
						<td class="FieldLabel" style="width: 15%">是否自愿参加：</td>
						<td class="FieldInput" style="width: 15%"><label
							id="whetherVoluntary" name="whetherVoluntary"
							field="WHETHER_VOLUNTARY" dataset="WhetherVoluntaryFlagEnum" /></td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width: 15%">培训机构：</td>
						<td class="FieldInput" colspan="3" style="width: 78%"><label
							id="trainingInstitutions" name="trainingInstitutions"
							field="TRAINING_INSTITUTIONS" /></td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width: 15%">培训开始时间：</td>
						<td class="FieldInput" style="width: 15%"><label
							id="trainingStartTime" name="trainingStartTime"
							field="TRAINING_START_TIME" format="Y-m-d" /></td>

						<td class="FieldLabel" style="width: 15%">培训结束时间：</td>
						<td class="FieldInput" style="width: 15%"><label
							id="trainingEndTime" name="trainingEndTime"
							field="TRAINING_END_TIME" format="Y-m-d" /></td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width: 15%">培训专业：</td>
						<td class="FieldInput" style="width: 15%"><label
							id="trainingMajor" name="trainingMajor" field="TRAINING_MAJOR" /></td>

						<td class="FieldLabel" style="width: 15%">培训技能等级：</td>
						<td class="FieldInput" style="width: 15%"><label
							id="trainingSkillLevel" name="trainingSkillLevel"
							field="TRAINING_SKILL_LEVEL" /></td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width: 15%">备注：</td>
						<td class="FieldInput" colspan="5" ><label
							id="remarks" style="height:40;" field="REMARKS" /></td>
					</tr>
					<tr>
						<!--培训信息ID -->
						<input type="hidden" name="trainId" id="trainId" field="TRAIN_ID" />

					</tr>

				</table>

				</form>
			</next:Html>
		</next:Panel>
	</next:AnchorLayout>
</next:ViewPort>
</body>
</html>
