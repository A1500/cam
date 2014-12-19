<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<script>
	var idField='<%=request.getParameter("idField")%>';
</script>
<script type="text/javascript">
</script>
<html>
<head>
<title>退役士兵信息</title>
<next:ScriptManager />
<script type="text/javascript" src="prsretiredsoldiers_detail.js">
</script>
</head>
<body>
<model:datasets>

	<!-- 退役士兵基本信息 -->
	<model:dataset id="retiredSoldierDataset"
		cmd="com.inspur.cams.prs.prsretiredsoldiers.cmd.PrsRetiredSoldiersQueryCommand"
		method="querySoldiers">
		<model:record
			fromBean="com.inspur.cams.prs.prsretiredsoldiers.dao.PrsRetiredSoldiers">
			<model:field name="domicileName" type="string" />
			<model:field name="enlistPlaceName" type="string" />
		</model:record>
	</model:dataset>
	<!-- 就业形式 -->
	<model:dataset id="EmploymentType" enumName="EMPLOYMENT.TYPE"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 安置形式 -->
	<model:dataset id="PlacementType" enumName="PLACEMENT.TYPE"
		autoLoad="true" global="true">
	</model:dataset>

	<!-- 性别 -->
	<model:dataset id="SexDataset" enumName="COMM.SEX" autoLoad="true"
		global="true">
	</model:dataset>
	<!-- 民族 -->
	<model:dataset id="NationDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 军区代码 -->
	<model:dataset id="MilitaryRegionCodeDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_MILITARY_REGION_CODE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>

	<!-- 是否自愿参加 -->
	<model:dataset id="WhetherVoluntaryFlagEnum" enumName="COMM.YESORNO"
		autoLoad="true" global="true">
	</model:dataset>

	<!-- 培训类型 -->
	<model:dataset id="TrainingType" enumName="TRAINING.TYPE"
		autoLoad="true" global="true">
	</model:dataset>

	<!-- 文化程度 -->
	<model:dataset id="EducationDataset" enumName="EDUCATION.CODE"
		autoLoad="true" global="true">
	</model:dataset>

	<!-- 健康状况 -->
	<model:dataset id="HealthDataset" enumName="HEALTH.CODE"
		autoLoad="true" global="true">
	</model:dataset>

	<!-- 档案来源 -->
	<model:dataset id="FileResourcesDataset" enumName="FILESRESOURCE.CODE"
		autoLoad="true" global="true"></model:dataset>

	<!-- 士官级别 -->
	<model:dataset id="SergeancyLevelDataset"
		enumName="SERGEANCYLEVEL.CODE" autoLoad="true" global="true"></model:dataset>

	<!-- 户籍类别 -->
	<model:dataset id="DomicileDataset" enumName="DOMICILE.CODE"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 士兵部队信息 -->
	<model:dataset id="prssoldiersArmyDataset"
		cmd="com.inspur.cams.prs.prssoldiersarmy.cmd.PrsSoldiersArmyQueryCommand"
		global="true">
		<model:record
			fromBean="com.inspur.cams.prs.prssoldiersarmy.dao.PrsSoldiersArmy"></model:record>
	</model:dataset>
	<!-- 职位 -->
	<model:dataset id="PositionDataset" enumName="POSITION.CASE"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 处分情况 -->
	<model:dataset id="PunishmentCasesDataset" enumName="PUNISHMENT.CASE"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 伤残性质 -->
	<model:dataset id="DisabilityCaseDataset" enumName="DISABLE.CASE.CODE"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 伤残等级 -->
	<model:dataset id="DisabilityLevelDataset" enumName="LEVEL.CODE"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 伤病残退役士兵接收方式 -->
	<model:dataset id="ReceivingModeDataset" enumName="RECEIVING.CASE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 立功授奖情况 -->
	<model:dataset id="prsawardsmeritoriousDataset"
		cmd="com.inspur.cams.prs.prsawardsmeritorious.cmd.PrsAwardsMeritoriousQueryCommand"
		global="true">
		<model:record
			fromBean="com.inspur.cams.prs.prsawardsmeritorious.dao.PrsAwardsMeritorious"></model:record>
	</model:dataset>
	<!-- 立功授奖种类 -->
	<model:dataset id="AwardsTypeDataset" enumName="AWARDS.CODE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 立功受奖名称 -->
	<model:dataset id="AwardsNameDataset" enumName="AWARDS.CASE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 退役士兵类型 -->
	<model:dataset id="RetiredSoldierTypeDataset"
		enumName="RETIREDSOLDIERTYPE.CODE" autoLoad="true" global="true">
	</model:dataset>
	<!--入伍形式 -->
	<model:dataset id="EnlistTypeDataset" enumName="ENLISTTYPE.CODE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 是否伤残 -->
	<model:dataset id="DisabilityFlagDataset" enumName="COMM.YESORNO"
		autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:Panel autoHeight="true" bodyStyle="width:100%">

	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="undo" text="返回" handler="back" />
	</next:TopBar>

	<next:TabPanel>
		<next:Tabs>
			<next:Panel title="待审核士兵基本信息" autoHeight="true" width="100%"
				autoScroll="true" id="peopleTabPanel">
				<next:Html>
					<fieldset>
					<form id="retiredSoldierForm" method="post"
						dataset="retiredSoldierDataset" onsubmit="return false"
						style="padding: 5px;" class="L5form">
					<table border="0" width="98%">
						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap="nowrap">退役士兵类型：</td>
							<td class="FieldInput" style="width: 15%"><label
								id="retiredSoldierType" name="retiredSoldierType"
								field="retiredSoldierType" dataset="RetiredSoldierTypeDataset" />
							<font color="red">*</font></td>
							<td class="FieldLabel" style="width: 15%" nowrap="nowrap">退伍证号：</td>
							<td class="FieldInput" style="width: 15%"><label
								id="veteransCertificateNo" name="veteransCertificateNo"
								field="veteransCertificateNo" /> <font color="red">*</font></td>
							<td class="FieldLabel" style="width: 15%" nowrap="nowrap">士官级别：</td>
							<td class="FieldInput" style="width: 15%"><label
								id="sergeantLevel" name="sergeantLevel" field="sergeantLevel" /><font
								color="red">*</font></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap>姓名：</td>
							<td class="FieldInput" style="width: 15%"><label id="name"
								name="name" field="name" /><font color="red">*</font></td>
							<td class="FieldLabel" style="width: 15%">性别：</td>
							<td class="FieldInput" style="width: 15%"><label id="sex"
								name="sex" field="sex" dataset="SexDataset" /><font color="red">*</font></td>
							<td class="FieldLabel" style="width: 15%">身份证号：</td>
							<td class="FieldInput" style="width: 15%"><label
								id="idcardNo" name="idcardNo" field="idcardNo" /></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 15%">民族：</td>
							<td class="FieldInput" style="width: 15%"><label id="naton"
								name="naton" field="naton" dataset="NationDataset" /><font
								color="red">*</font></td>
							<td class="FieldLabel" style="width: 15%" nowrap="nowrap">户口性质：</td>
							<td class="FieldInput" style="width: 15%"><label
								id="hukouType" name="hukouType" field="hukouType"
								dataset="DomicileDataset" /> <font color="red">*</font></td>
							<td class="FieldLabel" style="width: 15%">出生日期：</td>
							<td class="FieldInput" style="width: 15%"><label
								id="birthday" name="birthday" field="birthday" format="Y-m-d" /></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 15%">入伍时间：</td>
							<td class="FieldInput" style="width: 15%"><label
								id="enlistTime" name="enlistTime" field="enlistTime"
								format="Y-m-d" /><font color="red">*</font></td>
							<td class="FieldLabel" style="width: 15%">入伍地：</td>
							<td class="FieldInput" style="width: 15%"><label
								id="enlistPlace" name="enlistPlace" field="enlistPlaceName"
								format="Y-m-d" /><font color="red">*</font></td>
							<td class="FieldLabel" style="width: 15%">入伍前身份：</td>
							<td class="FieldInput" style="width: 15%"><label
								id="enlistType" name="enlistType" field="enlistType"
								dataset="EnlistTypeDataset" /></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 15%">军区大单位：</td>
							<td class="FieldInput" style="width: 15%"><label
								id="servedMilitaryRegion" name="servedMilitaryRegion"
								field="servedMilitaryRegion" dataset="MilitaryRegionCodeDataset" /><font
								color="red">*</font></td>
							<td class="FieldLabel" style="width: 15%">部队单位：</td>
							<td class="FieldInput" style="width: 15%"><label
								id="servedArmy" name="servedArmy" field="servedArmy" /><font
								color="red">*</font></td>
							<td class="FieldLabel" style="width: 15%">退伍时间：</td>
							<td class="FieldInput" style="width: 15%"><label
								id="retiredTime" name="retiredTime" field="retiredTime"
								format="Y-m-d" /><font color="red">*</font></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap="nowrap">档案来源：</td>
							<td class="FieldInput" style="width: 15%"><label
								id="filesSource" name="filesSource" field="filesSource"
								dataset="FileResourcesDataset" /><font color="red">*</font></td>
							<td class="FieldLabel" style="width: 15%" nowrap="nowrap">接收档案时间：</td>
							<td class="FieldInput" style="width: 15%"><label
								id="filesReceiveTime" name="filesReceiveTime"
								field="filesReceiveTime" format="Y-m-d" /><font color="red">*</font></td>
							<td class="FieldLabel" style="width: 15%">服役年限：</td>
							<td class="FieldInput" style="width: 15%"><label
								id="servicedTime" name="servicedTime" field="servicedTime" /></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap="nowrap">安置地：</td>
							<td class="FieldInput" style="width: 15%"><label
								id="wherePlacemen" name="wherePlacemen" field="domicileName" /></td>
							<td class="FieldLabel" style="width: 15%">落户派出所：</td>
							<td class="FieldInput" style="width: 15%"><label
								id="hukouLocation" name="hukouLocation" field="hukouLocation" /></td>
							<td class="FieldLabel" style="width: 15%">健康状况：</td>
							<td class="FieldInput" style="width: 15%"><label
								id="healthCondition" name="healthCondition"
								field="healthCondition" dataset="HealthDataset" /></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 15%">文化程度：</td>
							<td class="FieldInput" style="width: 15%"><label
								id="coutralLevel" name="coutralLevel" field="coutralLevel"
								dataset="EducationDataset" /></td>
							<td class="FieldLabel" style="width: 15%">专业特长：</td>
							<td class="FieldInput" style="width: 15%"><label
								id="specialty" name="specialty" field="specialty" /></td>
							<td class="FieldLabel" style="width: 15%">是否伤残：</td>
							<td class="FieldInput" style="width: 15%"><label
								id="disabilityFlag" name="disabilityFlag" field="disabilityFlag"
								dataset="DisabilityFlagDataset" /></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 15%">联系电话：</td>
							<td class="FieldInput" style="width: 15%"><label id="tel"
								name="tel" field="tel" /><font color="red">*</font></td>
							<td class="FieldLabel" style="width: 15%">家庭住址：</td>
							<td class="FieldInput" style="width: 15%" colspan="3"><label
								id="address" name="address" field="address" style="width: 83%" /><font
								color="red">*</font></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 15%">父亲姓名：</td>
							<td class="FieldInput" style="width: 15%"><label
								id="fatherName" name="fatherName" field="fatherName" /></td>
							<td class="FieldLabel" style="width: 15%">工作单位：</td>
							<td class="FieldInput" style="width: 15%"><label
								id="fatherWorkunit" name="fatherWorkunit" field="fatherWorkunit" /></td>
							<td class="FieldLabel" style="width: 15%" nowrap="nowrap">联系电话：</td>
							<td class="FieldInput" style="width: 15%"><label
								id="fatherTel" name="fatherTel" field="fatherTel" /></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 15%">母亲姓名：</td>
							<td class="FieldInput" style="width: 15%"><label
								name="matherName" field="matherName" id="matherName" /></td>
							<td class="FieldLabel" style="width: 15%">工作单位：</td>
							<td class="FieldInput" style="width: 15%"><label
								name="matherWorkunit" field="matherWorkunit" id="matherWorkunit" /></td>
							<td class="FieldLabel" style="width: 15%" nowrap="nowrap">联系电话：</td>
							<td class="FieldInput" style="width: 15%"><label
								name="matherTel" field="matherTel" id="matherTel" /></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 15%">配偶姓名：</td>
							<td class="FieldInput" style="width: 15%"><label
								name="spouseName" field="spouseName" id="spouseName" /></td>

							<td class="FieldLabel" style="width: 15%">工作单位：</td>
							<td class="FieldInput" style="width: 15%"><label
								name="spouseWorkunit" field="spouseWorkunit" id="spouseWorkunit" /></td>
							<td class="FieldLabel" style="width: 15%" nowrap="nowrap">联系电话：</td>
							<td class="FieldInput" style="width: 15%"><label
								name="spouseTel" field="spouseTel" id="spouseTel" /></td>
						</tr>
						<tr>
							<td class="FieldLabel">备注(基本信息)：</td>
							<td class="FieldInput" style="width: 15%" colspan="5"><label
								field="content" style="height: 40;" title="备注(基本信息)"></td>
						</tr>
						<input type="hidden" name="soldiersId" id="soldiersId"
							field="soldiersId" />
					</table>
					</form>
					</fieldset>
				</next:Html>
			</next:Panel>
			<next:Panel id="armyInfo" title="退役士兵部队信息表" autoHeight="true"
				width="98%">
				<next:Panel>
					<next:Html>
						<fieldset>
						<form id="armyInfoForm" dataset="prssoldiersArmyDataset"
							onsubmit="return false" style="padding: 5px;" class="L5form">
						<table border="1" width="98%">
							<tr>
								<td class="FieldLabel" style="width: 15%">职位</td>
								<td class="FieldInput" style="width: 15%"><label
									id="position" name="position" field="position"
									dataset="PositionDataset" /></td>
								<td class="FieldLabel" style="width: 15%">处分情况</td>
								<td class="FieldInput" style="width: 15%"><label
									id="punishmentCases" name="punishmentCases"
									field="punishmentCases" dataset="PunishmentCasesDataset" /></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width: 15%">伤残性质</td>
								<td class="FieldInput" style="width: 15%"><label
									id="disabilityProperties" name="disabilityProperties"
									field="disabilityProperties" dataset="DisabilityCaseDataset" /></td>

								<td class="FieldLabel" style="width: 15%">伤残等级</td>
								<td class="FieldInput" style="width: 15%"><label
									id="injuringGrade" name="injuringGrade" field="injuringGrade"
									dataset="DisabilityLevelDataset" /></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width: 15%">伤病残退役士兵接收方式</td>
								<td class="FieldInput" style="width: 15%"><label
									id="receivingMode" name="receivingMode" field="receivingMode"
									dataset="ReceivingModeDataset" /></td>
								<td class="FieldLabel"><lable id="dd" text="" /></td>
								<td></td>
								<!--ARMY_ID -->
								<input type="hidden" name="armyId" id="armyId" field="armyId" />
							</tr>
						</table>
						</form>
						</fieldset>
					</next:Html>
				</next:Panel>
				<next:GridPanel id="awardGridPanel" title="立功授奖情况" height="300"
					name="prsawardsmeritoriousGrid" width="100%" stripeRows="true"
					dataset="prsawardsmeritoriousDataset">
					<next:Columns>
						<next:RowNumberColumn width="30" />
						<next:CheckBoxColumn></next:CheckBoxColumn>
						<next:Column id="awardsType" header="立功授奖种类" field="awardsType"
							width="95">
							<next:ComboBox dataset="AwardsTypeDataset"
								id="awardsTypeComboBox" />
						</next:Column>

						<next:Column id="awardsName" header="立功授奖名称" field="awardsName"
							width="200">
							<next:ComboBox dataset="AwardsNameDataset"
								id="awardsNameComboBox" />
						</next:Column>
						<next:Column id="awardsNumber" header="立功授奖次数"
							field="awardsNumber" width="95">
							<next:TextField />
						</next:Column>
						<next:Column id="awardsTime" header="立功授奖时间" field="awardsTime"
							width="100">
							<next:DateField allowBlank="false" format="Y-m-d" />
						</next:Column>
					</next:Columns>
				</next:GridPanel>
			</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>
</body>
</html>