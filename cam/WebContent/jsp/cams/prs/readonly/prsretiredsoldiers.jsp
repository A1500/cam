<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<script type="text/javascript">
</script>
<html>
<head>
<title>退役士兵信息</title>
<next:ScriptManager />
<script>
	var idField='<%=request.getParameter("dataBean")%>';
</script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'>
</script>
<script type="text/javascript" src="prsretiredsoldiers.js"></script>
</head>
<body>
<model:datasets>
	<!-- 退役士兵基本信息 -->
	<model:dataset id="retiredSoldierDataset"
		cmd="com.inspur.cams.prs.prsretiredsoldiers.cmd.PrsRetiredSoldiersQueryCommand" method="querySoldierById">
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
	<!-- 安置理由 -->
	<model:dataset id="PlaceReasonDataset" enumName="PLACEMENREASON.CODE" autoLoad="true"
		global="true">
	</model:dataset>
	<!-- 健康状况 -->
	<model:dataset id="HealthDataset" enumName="HEALTH.CODE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 士官级别 -->
	<model:dataset id="SergeancyLevelDataset"
		enumName="SERGEANCYLEVEL.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 户籍类别 -->
	<model:dataset id="DomicileDataset" enumName="DOMICILE.CODE"
		autoLoad="true" global="true"></model:dataset>

	<!-- 退役士兵类型 -->
	<model:dataset id="RetiredSoldierTypeDataset"
		enumName="RETIREDSOLDIERTYPE.CODE" autoLoad="true" global="true">
	</model:dataset>
	<!--入伍形式 -->
	<model:dataset id="EnlistTypeDataset" enumName="ENLISTTYPE.CODE"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 档案来源 -->
	<model:dataset id="FileResourcesDataset" enumName="FILESRESOURCE.CODE"
		autoLoad="true" global="true"></model:dataset>
		<!-- 是否伤残 -->
	<model:dataset id="DisabilityFlagDataset" enumName="COMM.YESORNO"
		autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:ViewPort>
	<next:AnchorLayout>
		<next:Panel>
			<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem symbol="-"></next:ToolBarItem>
				<next:ToolBarItem text="打印个人信息" iconCls="print"  handler = "print" />
				<next:ToolBarItem symbol="-"></next:ToolBarItem>
				<next:ToolBarItem iconCls="undo" text="返回" handler="back" />

			</next:TopBar>
			<next:Html>
				<fieldset>
				<form id="retiredSoldierForm" method="post"
					dataset="retiredSoldierDataset" onsubmit="return false"
					style="padding: 5px;" class="L5form">
				<table border="0" width="98%">
					<tr>
						<td  class="FieldLabel" style="width: 15%" nowrap="nowrap">退役士兵类型：</td>
						<td class="FieldInput" style="width: 15%"><label id="retiredSoldierType"
							name="retiredSoldierType" field="retiredSoldierType"
							dataset="RetiredSoldierTypeDataset" /></td>
						<td  class="FieldLabel" style="width: 15%" nowrap="nowrap">退伍证号：</td>
						<td class="FieldInput" style="width: 15%"><label id="veteransCertificateNo"
							name="veteransCertificateNo" field="veteransCertificateNo" /> <font
							color="red">*</font></td>
						<td  class="FieldLabel" style="width: 15%" nowrap="nowrap">士官级别：</td>
						<td class="FieldInput" style="width: 15%"><label id="sergeantLevel" dataset="SergeancyLevelDataset"
							name="sergeantLevel" field="sergeantLevel" /></td>
					</tr>
					<tr>
					<td  class="FieldLabel" style="width: 15%">身份证号：</td>
						<td class="FieldInput" style="width: 15%"><label id="idcardNo" name="idcardNo"
							field="idcardNo" /></td>
						<td  class="FieldLabel" style="width: 15%" nowrap>姓名：</td>
						<td class="FieldInput" style="width: 15%"><label id="name" name="name"
							field="name" /></td>
						<td  class="FieldLabel" style="width: 15%">性别：</td>
						<td class="FieldInput" style="width: 15%"><label id="sex" name="sex" field="sex"
							dataset="SexDataset" /></td>

					</tr>
					<tr>
						<td  class="FieldLabel" style="width: 15%">民族：</td>
						<td class="FieldInput" style="width: 15%"><label id="naton" name="naton"
							field="naton" dataset="NationDataset" /></td>
						<td  class="FieldLabel" style="width: 15%" nowrap="nowrap">户口性质：</td>
						<td class="FieldInput" style="width: 15%"><label id="hukouType" name="hukouType"
							field="hukouType" dataset="DomicileDataset" /></td>
						<td  class="FieldLabel" style="width: 15%">出生日期：</td>
						<td class="FieldInput" style="width: 15%"><label id="birthday" name="birthday"
							field="birthday" format="Y-m-d" /></td>
					</tr>
					<tr>
						<td  class="FieldLabel" style="width: 15%">入伍方式：</td>
						<td class="FieldInput" style="width: 15%"><label id="enlistType"
							name="enlistType" field="enlistType" dataset="EnlistTypeDataset" /></td>
						<td  class="FieldLabel" style="width: 15%">入伍地：</td>
						<td class="FieldInput" style="width: 15%"><label id="enlistPlace"
							name="enlistPlace" field="enlistPlace"  /></td>
						<td  class="FieldLabel" style="width: 15%">入伍时间：</td>
						<td class="FieldInput" style="width: 15%"><label id="enlistTime"
							name="enlistTime" field="enlistTime" format="Y-m-d" /></td>
					</tr>
					<tr>
						<td  class="FieldLabel" style="width: 15%">军区大单位：</td>
						<td class="FieldInput" style="width: 15%"><label id="servedMilitaryRegion"
							name="servedMilitaryRegion" field="servedMilitaryRegion"
							dataset="MilitaryRegionCodeDataset" /></td>
							<td  class="FieldLabel" style="width: 15%">部队单位：</td>
						<td class="FieldInput" style="width: 15%"><label id="servedArmy"
							name="servedArmy" field="servedArmy" /></td>
						<td  class="FieldLabel" style="width: 15%">退役时间：</td>
						<td class="FieldInput" style="width: 15%"><label id="retiredTime"
							name="retiredTime" field="retiredTime" format="Y-m-d" /><font
							color="red">*</font></td>
					</tr>
					<tr>
						<td  class="FieldLabel" style="width: 15%" nowrap="nowrap">档案来源：</td>
						<td class="FieldInput" style="width: 15%"><label id="filesSource"
							name="filesSource" field="filesSource"
							dataset="FileResourcesDataset" /></td>
						<td  class="FieldLabel" style="width: 15%" nowrap="nowrap">接收档案时间：</td>
						<td class="FieldInput" style="width: 15%"><label id="filesReceiveTime"
							name="filesReceiveTime" field="filesReceiveTime" format="Y-m-d" /><font
							color="red">*</font></td>
						<td class="FieldLabel" style="width: 15%">服役年限：</td>
						<td class="FieldInput" style="width: 15%"><label id="servicedTimeTrs" readonly="readonly"
							field="servicedTimeTrs" name="servicedTimeTrs" title="自动计算"/>
						<class="FieldInput" ><input type="hidden" id="servicedTime" 
							field="servicedTime" name="servicedTime" title="服役年限"/></td>
					</tr>
					<tr>
						<td  class="FieldLabel" style="width: 15%">联系方式：</td>
						<td class="FieldInput" style="width: 15%"><label id="tel" name="tel" field="tel" /><font
							color="red">*</font></td>
							<td  class="FieldLabel" style="width: 15%">落户派出所：</td>
						<td class="FieldInput" style="width: 15%"><label id="hukouLocation"
							name="hukouLocation" field="hukouLocation" /></td>
							<td  class="FieldLabel" style="width: 15%">健康状况：</td>
						<td class="FieldInput" style="width: 15%"><label id="healthCondition"
							name="healthCondition" field="healthCondition"
							dataset="HealthDataset" /></td>
					</tr>
					<tr>
						<td  class="FieldLabel" style="width: 15%">文化程度：</td>
						<td class="FieldInput" style="width: 15%"><label id="coutralLevel"
							name="coutralLevel" field="coutralLevel"
							dataset="EducationDataset" /></td>
						<td  class="FieldLabel" style="width: 15%">专业特长：</td>
						<td class="FieldInput" style="width: 15%"><label field="specialty" name="specialty"
							field="specialty" /></td>
						<td  class="FieldLabel" style="width: 15%">是否伤残：</td>
						<td class="FieldInput" style="width: 15%"><label id="disabilityFlag" name="disabilityFlag"
							field="disabilityFlag" dataset="DisabilityFlagDataset" /></td>
					</tr>
					<tr>
					<td  class="FieldLabel" style="width: 15%" nowrap="nowrap">安置地：</td>
						<td class="FieldInput" style="width: 15%"><label id="wherePlacemen"
							name="wherePlacemen" field="domicileName" /></td>

						<td  class="FieldLabel" style="width: 15%">家庭住址：</td>
						<td class="FieldInput" style="width: 15%" colspan="3"><label id="address"
							name="address" field="address" style="width: 84%" /><font
							color="red">*</font></td>
					</tr>
					<tr>
						<td  class="FieldLabel" style="width: 15%">父亲姓名：</td>
						<td class="FieldInput" style="width: 15%"><label id="fatherName"
							name="fatherName" field="fatherName" /></td>
						<td  class="FieldLabel" style="width: 15%">工作单位：</td>
						<td class="FieldInput" style="width: 15%"><label id="fatherWorkunit"
							name="fatherWorkunit" field="fatherWorkunit" /></td>
						<td  class="FieldLabel" style="width: 15%" nowrap="nowrap">联系电话：</td>
						<td class="FieldInput" style="width: 15%"><label id="fatherTel" name="fatherTel"
							field="fatherTel" /></td>
					</tr>
					<tr>
						<td  class="FieldLabel" style="width: 15%">母亲姓名：</td>
						<td class="FieldInput" style="width: 15%"><label name="matherName"
							field="matherName" id="matherName" /></td>
						<td  class="FieldLabel" style="width: 15%">工作单位：</td>
						<td class="FieldInput" style="width: 15%"><label name="matherWorkunit"
							field="matherWorkunit" id="matherWorkunit" /></td>
						<td  class="FieldLabel" style="width: 15%" nowrap="nowrap">联系电话：</td>
						<td class="FieldInput" style="width: 15%"><label name="matherTel"
							field="matherTel" id="matherTel" /></td>
					</tr>
					<tr>
						<td  class="FieldLabel" style="width: 15%">配偶姓名：</td>
						<td class="FieldInput" style="width: 15%"><label name="spouseName"
							field="spouseName" id="spouseName" /></td>

						<td  class="FieldLabel" style="width: 15%">工作单位：</td>
						<td class="FieldInput" style="width: 15%"><label name="spouseWorkunit"
							field="spouseWorkunit" id="spouseWorkunit" /></td>
						<td  class="FieldLabel" style="width: 15%" nowrap="nowrap">联系电话：</td>
						<td class="FieldInput" style="width: 15%"><label name="spouseTel"
							field="spouseTel" id="spouseTel" /></td>
					</tr>
					<tr>
							<td class="FieldLabel">配偶户口所在地：</td>
							<td class="FieldInput"><label type="text" field="spouseLocation" style="width:135"
								id="spouseLocation" name="配偶户口所在地" /></td>
							<td class="FieldLabel">安置理由：</td>
							<td class="FieldInput"><label  id = "placemenRenson" style="width:135" field="placemenRenson" name="安置理由" dataset="PlaceReasonDataset" /></td>
						<%--	<td class="FieldLabel" colspan="2"></td>
							<td class="FieldInput"><label type="text" field="transFile"
								id="transFile" name="移交材料" /></td> 
							</tr>
							<tr>--%>
							<td class="FieldLabel">是否退档：</td>
						<td class="FieldInput"><label  id = "flag" field="flag" name="是否退档" dataset="ApprovalDataset"></td>
					</tr>
					<tr>
						<td class="FieldLabel">报到时间：</td>
						<td class="FieldInput" colspan="5"><label field="arriveTime"  id="arriveTime" 
							format="Y-m-d" name="arriveTime" title="报到时间" /></td>
					</tr>
					<tr>
						<td  class="FieldLabel"  >备注(基本信息)：</td>
						<td class="FieldInput" style="width: 15%" colspan="5"><label field="content"
							style="height: 40;" title="备注(基本信息)"></td>
					</tr>
					<input type="hidden" name="soldiersId" id="soldiersId"
						field="soldiersId" />
				</table>
				</form>
				</fieldset>
			</next:Html>
		</next:Panel>
	</next:AnchorLayout>
</next:ViewPort>
</body>
</html>
