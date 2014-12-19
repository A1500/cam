<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="com.inspur.cams.comm.util.IdHelp"%>
<html>
<head>
<title>复原干部信息</title>
<next:ScriptManager />
<script>
	var idField='<%=request.getParameter("idField")%>';
	var method='<%=request.getParameter("method")%>';
	var soldierID  = '<%=IdHelp.getUUID32()%>';
	var orgCode  ='<%=BspUtil.getOrganCode()%>';
	 var organName= decodeURIComponent('<%=request.getParameter("organName")%>');
</script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'>
</script>
<script type="text/javascript" src="../prsComm.js"></script>
<script type="text/javascript" src="retiredcadres_edit.js"></script>
</head>
<body>
<model:datasets>
	<!-- 退役士兵基本信息 -->
	<model:dataset id="retiredSoldierDataset"
		cmd="com.inspur.cams.prs.prsretiredsoldiers.cmd.PrsRetiredSoldiersQueryCommand"
		method="querySoldierById">
		<model:record
			fromBean="com.inspur.cams.prs.prsretiredsoldiers.dao.PrsRetiredSoldiers">
			<model:field name="birthday" mapping="birthday" rule="require" type="string" />
			<model:field name="naton" mapping="naton" rule="require" type="string" />
			<model:field name="servedMilitaryRegion" mapping="servedMilitaryRegion" rule="require" type="string" />
			<model:field name="servedArmy" mapping="servedArmy" rule="require" type="string" />
			<model:field name="hukouType" mapping="hukouType" rule="require" type="string" />
			<model:field name="tel" mapping="tel" rule="require" type="string" />
			<model:field name="address" mapping="address" rule="require" type="string" />
			<model:field name="hukouLocation" mapping="hukouLocation" rule="require" type="string" />
			<model:field name="fatherTel" mapping="fatherTel" rule="number" type="string" />
			<model:field name="matherTel" mapping="matherTel" rule="number" type="string" />
			<model:field name="filesSource" mapping="filesSource" rule="require" type="string" />
			<model:field name="domicileName" type="string" />
			<model:field name="enlistPlaceName" type="string" />
		</model:record>
	</model:dataset>
	<!-- 性别 -->
	<model:dataset id="SexDataset" enumName="COMM.SEX" autoLoad="true"
		global="true"></model:dataset>
<!-- 是否退档 -->
		<model:dataset id="ApprovalDataset" enumName="APPROVALSTATE.CODE" autoLoad="true"
		global="true"></model:dataset>
	<!-- 档案来源 -->
	<model:dataset id="FileResourcesDataset" enumName="FILESRESOURCE.CODE"
		autoLoad="true" global="true"></model:dataset>
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

	
		<next:Panel autoHeight="true" bodyStyle="width:100%">
			<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="save" text="保存" handler="save" />
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
						<td class="FieldLabel" nowrap="nowrap">姓名：</td>
						<td class="FieldInput"><input type="text" field="name" onblur="nameNew()" id="name"
							 name="姓名" /><font color="red">*</font></td>
						<td class="FieldLabel">身份证号：</td>
						<td class="FieldInput"><input type="text" name="身份证号" id ="idcardNo" size="18"
							field="idcardNo" title="身份证号" onchange="func_QueryIdCard()" style="width:135"/></td>
						<td class="FieldLabel">性别：</td>
						<td class="FieldInput"><select name="性别" field="sex"
							title="性别">
							<option dataset="SexDataset"></option>
						</select><font color="red">*</font></td>
					</tr>
					<tr>
						<td class="FieldLabel">民族：</td>
						<td class="FieldInput"><select name="民族" field="naton"
							title="民族">
							<option dataset="NationDataset"></option>
						</select><font color="red">*</font></td>
						<td class="FieldLabel" nowrap="nowrap">户口性质：</td>
						<td class="FieldInput"><select id="hukouType" name="户口性质" style="width:135"
							field="hukouType" title="户口性质">
							<option dataset="DomicileDataset"></option>
						</select><font color="red">*</font></td>
						<td class="FieldLabel">入伍时间：</td>
						<td class="FieldInput"><input type="text" name="入伍时间" id="enlistTime" onblur="serveTime()"
							field="enlistTime" format="Y-m-d" maxlength="10"onpropertychange="changeDateStyle(this)"
							title="入伍时间" /><img  src="../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ><font color="red">*</font></td>
					</tr>

					<tr>
					    <td class="FieldLabel">出生日期：</td>
						<td class="FieldInput"><input type="text" name="出生日期" id="birthday"
							field="birthday" format="Y-m-d" maxlength="10"onpropertychange="changeDateStyle(this)"
							title="出生日期" /><img  src="../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ><font color="red">*</font></td>						
						<td class="FieldLabel">入伍地：</td>
						<td class="FieldInput" colspan="1">
							<input type="text" field ="enlistPlace" id  ="enlistPlace" style="width: 135"  name="入伍地" /><font color="red">*</font>
						<td class="FieldLabel">退役时间：</td>
						<td class="FieldInput"><input type="text" name="退役时间" id="retiredTime" onblur="serveTime()"
							field="retiredTime" format="Y-m-d" maxlength="10"onpropertychange="changeDateStyle(this)"
							title="退役时间" /><img  src="../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ><font color="red">*</font></td>
					</tr>
					<tr>
						<td class="FieldLabel">军区大单位：</td>
						<td class="FieldInput"><select id="servedMilitaryRegion"
							name="军区大单位" field="servedMilitaryRegion" title="军区大单位">
							<option dataset="MilitaryRegionCodeDataset"></option>
						</select><font color="red">*</font></td>
						<td class="FieldLabel">服役部队：</td>
						<td class="FieldInput"><input type="text" name="服役部队" style="width:135"
							field="servedArmy" title="服役部队" /><font color="red">*</font></td>
						<td class="FieldLabel">服役年限：</td>
						<td class="FieldInput"><input type="text" id="servicedTimeTrs" readonly="readonly"
							field="servicedTimeTrs" name="servicedTimeTrs" title="自动计算"/>
						<class="FieldInput"><input type="hidden" id="servicedTime" readonly="readonly"
							field="servicedTime" name="servicedTime" title="服役年限"/></td>	
					</tr>
					<tr>
						<td class="FieldLabel" nowrap="nowrap">职别：</td>
						<td class="FieldInput"><select id="jobtitle" name="职别"
							field="jobtitle">
							<option dataset="JobTitle"></option>
						</select></td>
						<td class="FieldLabel">技术等级：</td>
						<td class="FieldInput"><select id="technologyLevel" style="width:135"
							name="技术等级" field="technologyLevel" title="技术等级">
							<option dataset="SkillLevelDataset"></option>
						</select></td>
						<td class="FieldLabel">文化程度：</td>
						<td class="FieldInput"><select name="文化程度"
							field="coutralLevel">
							<option dataset="EducationDataset"></option>
						</select></td>
					</tr>
					<tr>
						<td class="FieldLabel">计划年度：</td>
						<td class="FieldInput"><input id="planYear" type="text" name="计划年度"
							field="planYear" /><font color="red">*</font></td>
						<td class="FieldLabel">是否退档：</td>
						<td class="FieldInput" colspan="1"><select id="flag" style="width:135"
							field="flag" name="是否退档">
							<option dataset="ApprovalDataset"></option>
						</select></td>
						<td class="FieldLabel">报到时间：</td>
						<td class="FieldInput"><input type="text" field="arriveTime"  id="arriveTime"
							format="Y-m-d" maxlength="10"onpropertychange="changeDateStyle(this)" name="报到时间" title="报到时间"/><img  src="../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" >
							</td>
					</tr>
					<tr>
						<td class="FieldLabel" nowrap="nowrap">档案来源：</td>
						<td class="FieldInput"><select field="filesSource"
							name="档案来源">
							<option dataset="FileResourcesDataset"></option>
						</select><font color="red">*</font></td>
						<td class="FieldLabel">收档时间：</td>
						<td class="FieldInput"><input type="text" name="收档时间" style="width:135" id="filesReceiveTime"
							field="filesReceiveTime" format="Y-m-d" maxlength="10"onpropertychange="changeDateStyle(this)"
							title="收档时间"><img  src="../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ></td>
						<td class="FieldLabel" nowrap="nowrap">档案去向：</td>
						<td class="FieldInput"><input type="text" name="档案去向"
							field="filesWhereabouts" /></td>
					</tr>
					<tr>
						<td class="FieldLabel" nowrap="nowrap">安置地：</td>
						<td class="FieldInput"><input type="text" id="domicileName"
							field="domicileName" onclick="forHelp()" readonly="readonly" />
						<input type="hidden" id="domicileCode" field="wherePlacemen"
							name="安置地" /><font color="red">*</font></td>
						<td class="FieldLabel">落户派出所：</td>
						<td class="FieldInput" colspan="3"><input type="text"
							name="落户派出所" field="hukouLocation" style="width: 83%"
							title="落户派出所" /><font color="red">*</font></td>
					</tr>
					<tr>
						<td class="FieldLabel">联系电话：</td>
						<td class="FieldInput"><input type="text" name="联系电话"
							field="tel" id="tel" title="联系电话" /><font color="red">*</font></td>
						<td class="FieldLabel">家庭住址：</td>
						<td class="FieldInput" colspan="3"><input type="text"
							name="家庭住址" field="address" style="width: 83%" title="家庭住址" /><font
							color="red">*</font></td>
					</tr>
					<tr>
						<td class="FieldLabel">父亲姓名：</td>
						<td class="FieldInput"><input type="text" name="父亲姓名"
							field="fatherName" id="fatherName" title="父亲姓名" /></td>
						<td class="FieldLabel">工作单位：</td>
						<td class="FieldInput"><input type="text" name="工作单位" style="width:135"
							field="fatherWorkunit" id="fatherWorkunit" title="工作单位" /></td>
						<td class="FieldLabel" nowrap="nowrap">联系电话：</td>
						<td class="FieldInput"><input type="text" name="联系电话"
							field="fatherTel" id="fatherTel" title="联系电话" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">母亲姓名：</td>
						<td class="FieldInput"><input type="text" name="母亲姓名"
							field="matherName" id="matherName" title="母亲姓名" /></td>

						<td class="FieldLabel">工作单位：</td>
						<td class="FieldInput"><input type="text" name="工作单位" style="width:135"
							field="matherWorkunit" id="matherWorkunit" title="工作单位" /></td>
						<td class="FieldLabel" nowrap="nowrap">联系电话：</td>
						<td class="FieldInput"><input type="text" name="联系电话"
							field="matherTel" id="matherTel" title="联系电话" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">配偶姓名：</td>
						<td class="FieldInput"><input type="text" name="配偶姓名"
							field="spouseName" id="spouseName" title="配偶姓名" /></td>
						<td class="FieldLabel">工作单位：</td>
						<td class="FieldInput"><input type="text" name="工作单位" style="width:135"
							field="spouseWorkunit" id="spouseWorkunit" title="工作单位" /></td>
						<td class="FieldLabel" nowrap="nowrap">联系电话：</td>
						<td class="FieldInput"><input type="text" name="联系电话"
							field="spouseTel" id="spouseTel" title="联系电话" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">备注(基本信息)：</td>
						<td class="FieldInput" colspan="5"><textarea name="备注(基本信息)"
							field="content" rows="3" style="width: 90%" title="备注(基本信息)"></textarea></td>
					</tr>
					<input type="hidden" name="soldiersId" id="soldiersId"
						field="soldiersId" />
				</table>
				</form>
				</fieldset>
			</next:Html>
		</next:Panel>
	
</body>
</html>
