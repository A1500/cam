<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>

<html>
<head>
<title>退役士兵部队信息表编辑</title>
<next:ScriptManager />
<script>
			var idField='<%=request.getParameter("dataBean")%>';
		</script>
<script type="text/javascript" src="prssoldiersarmy.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="prssoldiersArmyDataset"
		cmd="com.inspur.cams.prs.prssoldiersarmy.cmd.PrsSoldiersArmyQueryCommand"
		global="true">
		<model:record
			fromBean="com.inspur.cams.prs.prssoldiersarmy.dao.PrsSoldiersArmy"></model:record>
	</model:dataset>
	<!-- 职位 -->
	<model:dataset id="PositionDataset" enumName="POSITION.CASE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 处分情况 -->
	<model:dataset id="PunishmentCasesDataset" enumName="PUNISHMENT.CASE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 伤残性质 -->
	<model:dataset id="DisabilityCaseDataset" enumName="DISABLE.CASE.CODE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 残疾等级 -->
	<model:dataset id="DisabilityLevelDataset" enumName="ILLLEVEL.CODE"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 是否 -->
	<model:dataset id="yesON" enumName="COMM.YESORNO" autoLoad="true"
		global="true">
	</model:dataset>
	<!-- 伤病残退役士兵接收方式 -->
	<model:dataset id="ReceivingModeDataset" enumName="RECEIVING.CASE"
		autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:ViewPort>
	<next:AnchorLayout>
		<next:Panel>
			<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="undo" text="返回" handler="back" />
			</next:TopBar>
			<next:Html>
				<fieldset>
				<form id="editForm" dataset="prssoldiersArmyDataset"
					onsubmit="return false" style="padding: 5px;" class="L5form">
				<table border="1" width="98%">
					<tr>
						<td class="FieldLabel" style="width: 15%">职位</td>
						<td class="FieldInput" style="width: 15%"><label
							id="position" name="POSITION" field="POSITION"
							dataset="PositionDataset" /></td>
						<td class="FieldLabel" style="width: 15%">处分情况</td>
						<td class="FieldInput" style="width: 15%"><label
							id="punishmentCases" name="punishmentCases"
							field="PUNISHMENT_CASES" dataset="PunishmentCasesDataset" /></td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width: 15%">残疾性质</td>
						<td class="FieldInput" style="width: 15%"><label
							id="disabilityProperties" name="disabilityProperties"
							field="DISABILITY_PROPERTIES" dataset="DisabilityCaseDataset" /></td>
						<td class="FieldLabel">是否精神病</td>
						<td class="FieldInput"><label id="mentalGrade"
									name="mentalGrade" field="MENTAL_GRADE" 
									dataset="yesON"/></td>
						
					</tr>
					<tr>
						<td class="FieldLabel" style="width: 15%">伤病残退役士兵供养方式</td>
						<td class="FieldInput" style="width: 15%"><label
							id="receivingMode" name="receivingMode" field="RECEIVING_MODE"
							dataset="ReceivingModeDataset" /></td>
							<td class="FieldLabel" style="width: 15%">残疾等级</td>
						<td class="FieldInput" style="width: 15%"><label
							id="injuringGrade" name="injuringGrade" field="INJURING_GRADE"
							dataset="DisabilityLevelDataset" /></td>
						<!--ARMY_ID -->
						<input type="hidden" name="armyId" id="armyId" field="ARMY_ID" />
					</tr>
				</table>
				</form>
				</fieldset>
			</next:Html>
		</next:Panel>
		<next:Panel title="立功受奖情况" style="padding: 5px;">
			<next:Html>
				<iframe id="instanceDisability"
					src="../readonly/prsawardsmeritorious.jsp?dataBean=<%=request.getParameter("dataBean")%>"
					frameborder="no" border="0" marginwidth="0" marginheight="0"
					scrolling="no" allowtransparency="yes" width="100%" height="300">
				</iframe>
			</next:Html>
		</next:Panel>
	</next:AnchorLayout>
</next:ViewPort>
</body>
</html>
