<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<script type="text/javascript">
</script>
<html>
<head>
<title>复原干部信息</title>
<next:ScriptManager />
<script>
	var idField='<%=request.getParameter("idField")%>';
</script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'>
</script>
<script type="text/javascript" src="retiredcadres.js"></script>
</head>
<body>
<model:datasets>
	<!-- 退役士兵基本信息 -->
	<model:dataset id="retiredSoldierDataset"
		cmd="com.inspur.cams.prs.prsretiredsoldiers.cmd.PrsRetiredSoldiersQueryCommand"
		method="querySoldierById">
		<model:record
			fromBean="com.inspur.cams.prs.prsretiredsoldiers.dao.PrsRetiredSoldiers">
			<model:field name="domicileName" type="string" />
			<model:field name="enlistPlaceName" type="string" />
		</model:record>
	</model:dataset>
	<!-- 性别 -->
	<model:dataset id="SexDataset" enumName="COMM.SEX" autoLoad="true"
		global="true"></model:dataset>
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
	<!-- 是否退档 -->
		<model:dataset id="ApprovalDataset" enumName="APPROVALSTATE.CODE" autoLoad="true"
		global="true"></model:dataset>
	<!--军区代码  -->
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
	<!-- 文化程度 -->
	<model:dataset id="EducationDataset" enumName="EDUCATION.CODE"
		autoLoad="true" global="true"></model:dataset>

	<!-- 健康状况 -->
	<model:dataset id="HealthDataset" enumName="HEALTH.CODE"
		autoLoad="true" global="true"></model:dataset>

	<!-- 户籍类别 -->
	<model:dataset id="DomicileDataset" enumName="DOMICILE.CODE"
		autoLoad="true" global="true"></model:dataset>

	<!-- 退役士兵类型 -->
	<model:dataset id="RetiredSoldierTypeDataset"
		enumName="RETIREDSOLDIERTYPE.CODE" autoLoad="true" global="true">
	</model:dataset>

	<!-- 档案来源 -->
	<model:dataset id="FileResourcesDataset" enumName="FILESRESOURCE.CODE"
		autoLoad="true" global="true"></model:dataset>

	<!--入伍形式 -->
	<model:dataset id="EnlistTypeDataset" enumName="ENLISTTYPE.CODE"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 职级 -->
	<model:dataset id="JobTitle" enumName="RETIREDCADRELEVEL.CODE"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 技术等级 -->
	<model:dataset id="SkillLevelDataset" enumName="SKILLLEVEL.CODE"
		autoLoad="true" global="true">
	</model:dataset>
</model:datasets>
<next:ViewPort>
	<next:AnchorLayout>
		<next:Panel title="复原干部基本信息">
			<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem symbol="-"></next:ToolBarItem>
				<next:ToolBarItem text="打印个人信息" iconCls="print"  handler = "print" />
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="undo" text="返回" handler="back" />
			</next:TopBar>
			<next:Html>
				<form id="retiredSoldierForm" method="post"
					dataset="retiredSoldierDataset" onsubmit="return false"
					style="padding: 5px;" class="L5form">
				<table border="0" width="98%">

					<tr>
						<td class="FieldLabel" nowrap>姓名：</td>
						<td class="FieldInput"><label name="name" field="name"
							title="姓名"><font color="red">*</font></td>
						<td class="FieldLabel">身份证号：</td>
						<td class="FieldInput"><label field="idcardNo" /></td>
						<td class="FieldLabel">性别：</td>
						<td class="FieldInput"><label field="sex"
							dataset="SexDataset"></td>
					</tr>
					<tr>
						<td class="FieldLabel">民族：</td>
						<td class="FieldInput"><label name="nation" field="naton"
							dataset="NationDataset" title="民族" /></td>
						<td class="FieldLabel" nowrap="nowrap">户口性质：</td>
						<td class="FieldInput"><label id="hukouType" name="hukouType"
							field="hukouType" dataset="DomicileDataset" /></td>
						<td class="FieldLabel">入伍时间：</td>
						<td class="FieldInput"><label field="enlistTime" format=Y-m-d /><font
							color="red">*</font></td>
					</tr>
					<tr>
					    <td class="FieldLabel">出生日期：</td>
						<td class="FieldInput"><label name="birthday"
							field="birthday" format="Y-m-d" /></td>						
						<td class="FieldLabel">入伍地：</td>
						<td class="FieldInput" colspan="1"><label name="enlistPlace"
							field="enlistPlace" title="入伍地" /></td>
						<td class="FieldLabel">退役时间：</td>
						<td class="FieldInput"><label field="retiredTime"
							title="退役时间：" /><font color="red">*</font></td>
					</tr>
					<tr>
						<td class="FieldLabel">军区大单位：</td>
						<td class="FieldInput"><label id="servedMilitaryRegion"
							name="servedMilitaryRegion" field="servedMilitaryRegion"
							dataset="MilitaryRegionCodeDataset" /></td>
							<td class="FieldLabel">部队单位：</td>
						<td class="FieldInput"><label name="servedArmy"
							field="servedArmy" title="部队单位" /></td>
						<td class="FieldLabel">服役年限：</td>
						<td class="FieldInput"><label id="servicedTimeTrs" readonly="readonly"
							field="servicedTimeTrs" name="servicedTimeTrs" title="自动计算"/>
						<class="FieldInput"><input type="hidden" id="servicedTime" readonly="readonly"
							field="servicedTime" name="servicedTime" title="服役年限"/></td>
						
					</tr>
						<tr>
						<td class="FieldLabel" nowrap="nowrap">职别：</td>
						<td class="FieldInput" style="width: 15%"><label
							id="jobtitle" field="jobtitle" dataset="JobTitle" /></td>
						<td class="FieldLabel">技术等级：</td>
						<td class="FieldInput"><label field="technologyLevel"
							dataset="SkillLevelDataset" /></td>
						<td class="FieldLabel" nowrap="nowrap">文化程度：</td>
						<td class="FieldInput"><label name="coutralLevel"
							field="coutralLevel" dataset="EducationDataset" /></td>
					</tr>
					<tr>	
						<td class="FieldLabel">计划年度：</td>
						<td class="FieldInput"><label  id = "planYear" field="planYear" name="计划年度"></td>
						<td class="FieldLabel">是否退档：</td>
						<td class="FieldInput" colspan="1"><label  id = "flag" field="flag" name="是否退档" dataset="ApprovalDataset"></td>
						<td class="FieldLabel">报到时间：</td>
						<td class="FieldInput" colspan="1"><label field="arriveTime"  id="arriveTime" 
							format="Y-m-d" maxlength="10" name="报到时间" title="报到时间"/></td>
					</tr>
					<tr>
						<td class="FieldLabel" nowrap="nowrap">档案来源：</td>
						<td class="FieldInput"><label dataset="FileResourcesDataset"
							field="filesSource" title="档案来源" /></td>

						<td class="FieldLabel">收档时间：</td>
						<td class="FieldInput"><label field="filesReceiveTime"></td>
						<td class="FieldLabel" nowrap="nowrap">档案去向：</td>
						<td class="FieldInput"><label name="filesWhereabouts"
							field="filesWhereabouts" /></td>
					</tr>
					<tr>
						<td class="FieldLabel" nowrap="nowrap">安置地：</td>
						<td class="FieldInput"><label name="wherePlacemen"
							field="domicileName" title="安置地" /></td>
						<td class="FieldLabel">落户派出所：</td>
						<td class="FieldInput" colspan="3"><label
							name="hukouLocation" field="hukouLocation" title="落户派出所" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">联系电话：</td>
						<td class="FieldInput"><label name="tel" field="tel" id="tel"
							title="联系方式" /><font color="red">*</font></td>
						<td class="FieldLabel">家庭住址：</td>
						<td class="FieldInput" colspan="3"><label name="address"
							field="address" style="width: 83%" title="家庭住址" /><font
							color="red">*</font></td>
					</tr>
					<tr>
						<td class="FieldLabel">父亲姓名：</td>
						<td class="FieldInput"><label name="fatherName"
							field="fatherName" id="fatherName" title="父亲姓名" /></td>
						<td class="FieldLabel">工作单位：</td>
						<td class="FieldInput"><label name="fatherWorkunit"
							field="fatherWorkunit" id="fatherWorkunit" title="工作单位" /></td>
						<td class="FieldLabel" nowrap="nowrap">联系电话：</td>
						<td class="FieldInput"><label name="fatherTel"
							field="fatherTel" id="fatherTel" title="联系电话" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">母亲姓名：</td>
						<td class="FieldInput"><label name="matherName"
							field="matherName" id="matherName" title="母亲姓名" /></td>

						<td class="FieldLabel">工作单位：</td>
						<td class="FieldInput"><label name="matherWorkunit"
							field="matherWorkunit" id="matherWorkunit" title="工作单位" /></td>

						<td class="FieldLabel" nowrap="nowrap">联系电话：</td>
						<td class="FieldInput"><label name="matherTel"
							field="matherTel" id="matherTel" title="联系电话" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">配偶姓名：</td>
						<td class="FieldInput"><label name="spouseName"
							field="spouseName" id="spouseName" title="配偶姓名" /></td>

						<td class="FieldLabel">工作单位：</td>
						<td class="FieldInput"><label name="spouseWorkunit"
							field="spouseWorkunit" id="spouseWorkunit" title="工作单位" /></td>

						<td class="FieldLabel" nowrap="nowrap">联系电话：</td>
						<td class="FieldInput"><label name="spouseTel"
							field="spouseTel" id="spouseTel" title="联系电话" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">备注(基本信息)：</td>
						<td class="FieldInput" colspan="5" style="height: 20;"><label
							name="CONTENT" field="content" title="备注(基本信息)"
							style="height: 40;" /></td>
					</tr>
				</table>
				</form>
			</next:Html>
		</next:Panel>
	</next:AnchorLayout>
</next:ViewPort>
</body>
</html>
