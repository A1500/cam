<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<script>
		var orgCode  ='<%=BspUtil.getOrganCode()%>';
		var idField='<%=request.getParameter("idField")%>';
</script>
<html>
<head>
<title>退役士兵信息</title>
<next:ScriptManager />
<script type="text/javascript" src="prsretiredsoldiers_edit.js"></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'>

</script>
</head>
<body>
<model:datasets>

	<!-- 退役士兵基本信息 -->
	<model:dataset id="retiredSoldierDataset"
		cmd="com.inspur.cams.prs.prsretiredsoldiers.cmd.PrsRetiredSoldiersQueryCommand" method="querySoldiers">
		<model:record
			fromBean="com.inspur.cams.prs.prsretiredsoldiers.dao.PrsRetiredSoldiers">
			<model:field name="domicileName" type="string" />
			<model:field name="enlistPlaceName" type="string" />
		</model:record>
	</model:dataset>
	
		<!-- 行政区划 -->
	<model:dataset id="OrgNameDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="false">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CITY'></model:param>
			<model:param name="value" value='ID'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
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
	<!-- 档案来源 -->
	<model:dataset id="FileResourcesDataset" enumName="FILESRESOURCE.CODE"
		autoLoad="true" global="true"></model:dataset>

</model:datasets>

<next:Panel autoHeight="true" bodyStyle="width:100%">

	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="save"></next:ToolBarItem>
		<next:ToolBarItem symbol="-"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="审核通过并添加其他信息" handler="approval" />
		<next:ToolBarItem symbol="-"></next:ToolBarItem>
		<next:ToolBarItem iconCls="undo" text="返回" handler="back" />
	</next:TopBar>

	<next:TabPanel>
		<next:Tabs>
			<next:Panel title="退役士兵基本信息" autoHeight="true" width="100%"
				autoScroll="true" id="peopleTabPanel">
				<next:Html>
					<fieldset>
					<form id="retiredSoldierForm" method="post"
						dataset="retiredSoldierDataset" onsubmit="return false"
						style="padding: 5px;" class="L5form">
					<table border="0" width="98%">
						<tr>
							<td class="FieldLabel" nowrap="nowrap">退役士兵类型：</td>
							<td class="FieldInput"><select id="retiredSoldierType"
								field="retiredSoldierType" name="退役士兵类型">
								<option dataset="RetiredSoldierTypeDataset"></option>
							</select><font color="red">*</font></td>
							<td class="FieldLabel" nowrap="nowrap">退伍证号：</td>
							<td class="FieldInput"><input type="text"
								field="veteransCertificateNo" name="退伍证号" /><font color="red">*</font></td>
							<td class="FieldLabel" nowrap="nowrap">士官级别：</td>
							<td class="FieldInput"><select id="sergeantLevel"
								name="士官级别" field="sergeantLevel">
								<option dataset="SergeancyLevelDataset"></option>
							</select><font color="red">*</font></td>
						</tr>
						<tr>
							<td class="FieldLabel" nowrap>姓名：</td>
							<td class="FieldInput"><input type="text" field="name"
								name="姓名" /><font color="red">*</font></td>
							<td class="FieldLabel">性别：</td>
							<td class="FieldInput"><select field="sex" name="性别">
								<option dataset="SexDataset"></option>
							</select><font color="red">*</font></td>
							<td class="FieldLabel">身份证号：</td>
							<td class="FieldInput"><input type="text" field="idcardNo" style="width: 90%" onchange="func_QueryIdCard()" id= "idcardNo"
								size="18" name="身份证号" /><font color="red">*</font></td>
						</tr>
						<tr>
							<td class="FieldLabel">民族：</td>
							<td class="FieldInput"><select field="naton" name="民族">
								<option dataset="NationDataset"></option>
							</select><font color="red">*</font></td>
							<td class="FieldLabel" nowrap="nowrap">户口性质：</td>
							<td class="FieldInput"><select id="hukouType"
								field="hukouType" name="户口性质">
								<option dataset="DomicileDataset"></option>
							</select><font color="red">*</font></td>

							<td class="FieldLabel">出生日期：</td>
							<td class="FieldInput"><input type="text" field="birthday"style="width: 90%" id="birthday"
								format="Y-m-d" onclick="LoushangDate(this)" name="出生日期" /></td>
						</tr>
						<tr>
							<td class="FieldLabel">入伍时间：</td>
							<td class="FieldInput"><input type="text" field="enlistTime"
								format="Y-m-d" onclick="LoushangDate(this)" name="入伍时间" /><font
								color="red">*</font></td>
							<td class="FieldLabel">入伍地：</td>
							<td class="FieldInput"><input type="text" field ="enlistPlaceName" id  ="enlistPlaceName" onclick="func_ForDomicileSelect()" name="入伍地" /><font color="red">*</font>
								<input type="hidden" id = "enlistPlace"	field="enlistPlace" />
								</td>
							<td class="FieldLabel">入伍前身份：</td>
							<td class="FieldInput"><select id="enlistType" style="width: 90%"
								field="enlistType" name="入伍形势">
								<option dataset="EnlistTypeDataset"></option>
							</select></td>
						</tr>
						<tr>
							<td class="FieldLabel">军区大单位：</td>
							<td class="FieldInput"><select id="servedMilitaryRegion"
								field="servedMilitaryRegion" name="军区大单位">
								<option dataset="MilitaryRegionCodeDataset"></option>
							</select><font color="red">*</font></td>
							<td class="FieldLabel">部队单位：</td>
							<td class="FieldInput"><input type="text" field="servedArmy"
								name="服役部队" /><font color="red">*</font></td>
							<td class="FieldLabel">退伍时间：</td>
							<td class="FieldInput"><input type="text" id="retiredTime" style="width: 90%"
								field="retiredTime" format="Y-m-d" onclick="LoushangDate(this);"
								name="退伍时间：" /><font color="red">*</font></td>
						</tr>
						<tr>
							<td class="FieldLabel" nowrap="nowrap">档案来源：</td>
							<td class="FieldInput"><select field="filesSource"
								name="档案来源">
								<option dataset="FileResourcesDataset"></option>
							</select><font color="red">*</font></td>
							<td class="FieldLabel" nowrap="nowrap">接收档案时间：</td>
							<td class="FieldInput"><input type="text"
								field="filesReceiveTime" format="Y-m-d"
								onclick="LoushangDate(this)" name="接收档案时间" /><font color="red">*</font></td>
							<td class="FieldLabel">服役年限：</td>
							<td class="FieldInput"><input type="text" id="servicedTime" style="width: 90%"
								field="servicedTime" readonly="readonly"
								onclick="getServicedTime()" name="服役年限" /></td>
						</tr>
						<tr>
							<td class="FieldLabel" nowrap="nowrap">安置地：</td>
							<td class="FieldInput"><input type="text" id="domicileName"
								field="domicileName" onclick="forHelp()" readonly="readonly" />
							<input type="hidden" id="domicileCode" field="wherePlacemen"
								name="安置地" /></td>
							<td class="FieldLabel">落户派出所：</td>
							<td class="FieldInput"><input type="text"
								field="hukouLocation" name="落户派出所" /></td>
							<td class="FieldLabel">健康状况：</td>
							<td class="FieldInput"><select field="healthCondition" style="width: 90%"
								name="健康状况"> 
								<option dataset="HealthDataset"></option>
							</select></td>
						</tr>
						<tr>
							<td class="FieldLabel">文化程度：</td>
							<td class="FieldInput"><select name="coutralLevel"
								field="coutralLevel">
								<option dataset="EducationDataset"></option>
							</select></td>
							<td class="FieldLabel">专业特长：</td>
							<td class="FieldInput"><input type="text" field="specialty"
								name="专业特长"></td>
							<td class="FieldLabel">是否伤残：</td>
							<td class="FieldInput"><select name="是否伤残" style="width: 90%"
								field="disabilityFlag">
								<option dataset="DisabilityFlagDataset"></option>
							</select></td>
						</tr>
						<tr>
							<td class="FieldLabel">联系电话：</td>
							<td class="FieldInput"><input type="text" field="tel" 
								id="tel" name="联系方式" /><font color="red">*</font></td>
							<td class="FieldLabel">家庭住址：</td>
							<td class="FieldInput" colspan="3"><input type="text"
								field="address" name="家庭住址" style="width: 95%" /><font
								color="red">*</font></td>
						</tr>
						<tr>
							<td class="FieldLabel">父亲姓名：</td>
							<td class="FieldInput"><input type="text" field="fatherName"
								id="fatherName" name="父亲姓名" /></td>
							<td class="FieldLabel">工作单位：</td>
							<td class="FieldInput"><input type="text"
								field="fatherWorkunit" id="fatherWorkunit" name="工作单位" /></td>
							<td class="FieldLabel" nowrap="nowrap">联系电话：</td>
							<td class="FieldInput"><input type="text" field="fatherTel" 
								id="fatherTel" name="联系电话"  style="width: 90%"/></td>
						</tr>
						<tr>
							<td class="FieldLabel">母亲姓名：</td>
							<td class="FieldInput"><input type="text" field="matherName"
								id="matherName" name="母亲姓名" /></td>

							<td class="FieldLabel">工作单位：</td>
							<td class="FieldInput"><input type="text"
								field="matherWorkunit" id="matherWorkunit" name="工作单位" /></td>

							<td class="FieldLabel" nowrap="nowrap">联系电话：</td>
							<td class="FieldInput"><input type="text" field="matherTel" style="width: 90%"
								id="matherTel" name="联系电话" /></td>
						</tr>
						<tr>
							<td class="FieldLabel">配偶姓名：</td>
							<td class="FieldInput"><input type="text" field="spouseName"
								id="spouseName" name="配偶姓名" /></td>

							<td class="FieldLabel">工作单位：</td>
							<td class="FieldInput"><input type="text"
								field="spouseWorkunit" id="spouseWorkunit" name="工作单位" /></td>

							<td class="FieldLabel" nowrap="nowrap">联系电话：</td>
							<td class="FieldInput"><input type="text" field="spouseTel" style="width: 90%"
								id="spouseTel" name="联系电话" /></td>
						</tr>
						<tr>
							<td class="FieldLabel">备注(基本信息)：</td>
							<td class="FieldInput" colspan="5"><textarea field="content"
								rows="3" style="width: 90%" name="备注(基本信息)"></textarea></td>
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
								<td class="FieldLabel">职位</td>
								<td class="FieldInput"><select id="position"
									name="position" field="position" title="职务">
									<option dataset="PositionDataset"></option></td>
								<td class="FieldLabel">处分情况</td>
								<td class="FieldInput"><select id="punishmentCases"
									name="punishmentCases" field="punishmentCases" title="处分情况">
									<option dataset="PunishmentCasesDataset"></option></td>
							</tr>
							<tr>
								<td class="FieldLabel">伤残性质</td>
								<td class="FieldInput"><select id="disabilityProperties"
									name="disabilityProperties" field="disabilityProperties"
									title="伤残性质">
									<option dataset="DisabilityCaseDataset"></option>
									</select></td>

								<td class="FieldLabel">伤残等级</td>
								<td class="FieldInput"><select id="injuringGrade"
									name="injuringGrade" field="injuringGrade" title="伤残等级">
									<option dataset="DisabilityLevelDataset"></option></td>
							</tr>
							<tr>
								<td class="FieldLabel">伤病残退役士兵接收方式</td>
								<td class="FieldInput"><select id="receivingMode"
									name="receivingMode" field="receivingMode" title="伤病残退役士兵接收方式">
									<option dataset="ReceivingModeDataset"></option>
									</select></td>
								<td class="FieldLabel"></td>
								<td></td>
								<!--ARMY_ID -->
								<input type="hidden" name="armyId" id="armyId" field="armyId" />
							</tr>
						</table>
						</form>
						</fieldset>
					</next:Html>
				</next:Panel>
				<next:EditGridPanel id="awardGridPanel" title="立功授奖情况" height="300"
					name="prsawardsmeritoriousGrid" width="100%" stripeRows="true"
					dataset="prsawardsmeritoriousDataset">
					<next:TopBar>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem symbol="-"></next:ToolBarItem>
						<next:ToolBarItem iconCls="add" text="增加" handler="insert" />
						<next:ToolBarItem iconCls="remove" text="删除" handler="del" />
						<next:ToolBarItem iconCls="undo" text="取消" handler="reset" />
					</next:TopBar>
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
				</next:EditGridPanel>
			</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>
</body>
</html>