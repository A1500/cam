
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="com.inspur.cams.comm.util.IdHelp"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>

<html>
<head>
<title>退役士兵部队信息表编辑</title>
<next:ScriptManager />
<script>
			var armyId  = '<%=IdHelp.getUUID32()%>';
			var idField='<%=request.getParameter("dataBean")%>';
			var method='<%=request.getParameter("method")%>';
			var type='<%=request.getParameter("type")%>';
</script>
<script type="text/javascript" src="prssoldiersarmy_edit.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="prssoldiersArmyDataset"
		cmd="com.inspur.cams.prs.prssoldiersarmy.cmd.PrsSoldiersArmyQueryCommand"
		global="true">
		<model:record
			fromBean="com.inspur.cams.prs.prssoldiersarmy.dao.PrsSoldiersArmy">
			<model:field name="armyId" mapping="ARMY_ID" type="string"/>
			<model:field name="soldiersId" mapping="SOLDIERS_ID" type="string"/>
			<model:field name="position" mapping="POSITION" type="string"/>
			<model:field name="awardsMeritoriousCases" mapping="AWARDS_MERITORIOUS_CASES" type="string"/>
			<model:field name="punishmentCases" mapping="PUNISHMENT_CASES" type="string"/>
			<model:field name="disabilityProperties" mapping="DISABILITY_PROPERTIES" type="string"/>
			<model:field name="injuringGrade" mapping="INJURING_GRADE" type="string"/>
			<model:field name="mentalGrade" mapping="MENTAL_GRADE" type="string"/>
			<model:field name="receivingMode" mapping="RECEIVING_MODE" type="string"/>
		</model:record>
	</model:dataset>
	<!-- 是否 -->
	<model:dataset id="yesON" enumName="COMM.YESORNO" autoLoad="true"
		global="true">
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
	<!-- 伤残等级 -->
	<model:dataset id="DisabilityLevelDataset" enumName="ILLLEVEL.CODE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 伤病残退役士兵接收方式 -->
	<model:dataset id="ReceivingModeDataset" enumName="RECEIVING.CASE"
		autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:ViewPort>
	<next:AnchorLayout>
		<next:Panel >
			<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="save" text="保存" handler="save" />
			</next:TopBar>
			<next:Html>
				<form id="editForm" dataset="prssoldiersArmyDataset"
					onsubmit="return false" style="padding: 5px;" class="L5form">
				<table border="1" width="98%">
					<tr>
						<td class="FieldLabel">职位：</td>
						<td class="FieldInput"><select id="position" name="position"
							field="position" title="职务">
							<option dataset="PositionDataset"></option></td>
						<td class="FieldLabel">处分情况：</td>
						<td class="FieldInput"><select id="punishmentCases"
							name="punishmentCases" field="punishmentCases" title="处分情况">
							<option dataset="PunishmentCasesDataset"></option></td>
					</tr>
					<tr>
						<td class="FieldLabel">残疾性质：</td>
						<td class="FieldInput"><select id="disabilityProperties"
							name="disabilityProperties" field="disabilityProperties"
							title="伤残性质">
							<option value="">请选择...</option>
							<option value="1">因战</option>
							<option value="2">因公</option>
							</select>	
						</td>
						<td class="FieldLabel">残疾等级：</td>
						<td class="FieldInput"><select id="injuringGrade"
							name="injuringGrade" field="injuringGrade" title="伤残等级">
							<option value="">请选择...</option>
							<option value="5">五级</option>
							<option value="6">六级</option>
							<option value="7">七级</option>
							<option value="8">八级</option>
							</select>	
						</td>
						<input type="hidden" name="armyId" id="armyId" field="armyId" />
					</tr>
				</table>
				</form>
			</next:Html>
		</next:Panel>
		<next:Panel title="立功受奖情况" style="padding: 5px;">
			<next:Html>
				<iframe id="instanceDisability"
					src="../prsawardsmeritorious/prsawardsmeritorious.jsp?dataBean=<%=request.getParameter("dataBean")%>&method=<%=request.getParameter("method")%>"
					frameborder="no" border="0" marginwidth="0" marginheight="0"
					scrolling="no" allowtransparency="yes" width="100%" height="300">
				</iframe>
			</next:Html>
		</next:Panel>
	</next:AnchorLayout>
</next:ViewPort>
</body>
</html>
