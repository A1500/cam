<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="com.inspur.cams.comm.util.IdHelp"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%
	response.setHeader("Expires", "Sat, 6 May 1995 12:00:00 GMT");
	response.setHeader("Cache-Control",
			"no-store,no-cache,must-revalidate");
	response.addHeader("Cache-Control", "post-check=0, pre-check=0");
	response.setHeader("Pragma", "no-cache");
%>
<script>
		var type='<%=request.getParameter("type")%>';
 		var soldierID  = '<%=IdHelp.getUUID32()%>';
		var armyId  = '<%=IdHelp.getUUID32()%>';
		var orgCode  ='<%=BspUtil.getOrganCode()%>';
		var organName= decodeURIComponent('<%=request.getParameter("organName")%>');
</script>

<html>
<head>
<title>退役士兵信息</title>
<next:ScriptManager />
<script type="text/javascript" src="prsretiredsoldiers_insert.js"></script>
<script type="text/javascript" src="../prsComm.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
</head>
<body>
<model:datasets>

	<!-- 退役士兵基本信息 -->
	<model:dataset id="retiredSoldierDataset"
		cmd="com.inspur.cams.prs.prsretiredsoldiers.cmd.PrsRetiredSoldiersQueryCommand"
		method="querySoldiers">
		<model:record
			fromBean="com.inspur.cams.prs.prsretiredsoldiers.dao.PrsRetiredSoldiers">
			<model:field name="birthday" mapping="birthday" rule="require" type="string" />
			<model:field name="naton" mapping="naton" rule="require" type="string" />
			<model:field name="servedMilitaryRegion" mapping="servedMilitaryRegion" rule="require" type="string" />
			<model:field name="servedArmy" mapping="servedArmy" rule="require" type="string" />
			<model:field name="hukouType" mapping="hukouType" rule="require" type="string" />
			<model:field name="tel" mapping="tel" rule="require" type="string" />
			<model:field name="address" mapping="address" rule="require" type="string" />
			<model:field name="fatherTel" mapping="fatherTel" rule="number" type="string" />
			<model:field name="matherTel" mapping="matherTel" rule="number" type="string" />
			<model:field name="filesSource" mapping="filesSource" rule="require" type="string" />
			<model:field name="domicileName" type="string" />
			<model:field name="enlistPlaceName" type="string" />
			<model:field name="servicedTimeTrs" mapping="servicedTimeTrs" type="string" />
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
	<!-- 安置理由 -->
	<model:dataset id="PlaceReasonDataset" enumName="PLACEMENREASON.CODE" autoLoad="true"
		global="true">
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
	<model:dataset id="DisabilityLevelDataset" enumName="ILLLEVEL.CODE"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 伤病残退役士兵接收方式 -->
	<model:dataset id="ReceivingModeDataset" enumName="RECEIVING.CASE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 立功受奖情况 -->
	<model:dataset id="prsawardsmeritoriousDataset"
		cmd="com.inspur.cams.prs.prsawardsmeritorious.cmd.PrsAwardsMeritoriousQueryCommand"
		global="true">
		<model:record  fromBean="com.inspur.cams.prs.prsawardsmeritorious.dao.PrsAwardsMeritorious" >
			<model:field name="awardsId" mapping="AWARDS_ID" type="string" />
			<model:field name="soldiersId" mapping="SOLDIERS_ID" type="string" />
			<model:field name="awardsType" mapping="AWARDS_TYPE" type="string" />
			<model:field name="awardsName" mapping="AWARDS_NAME" type="string" />
			<model:field name="awardsNumber" mapping="AWARDS_NUMBER" type="string" />
			<model:field name="awardsTime" mapping="AWARDS_TIME" type="string" />
			<model:field name="awardsNote" mapping="AWARDS_NOTE" type="string" />
		</model:record>
	</model:dataset>
	<!-- 是否 -->
	<model:dataset id="yesON" enumName="COMM.YESORNO" autoLoad="true"
		global="true">
	</model:dataset>
	<!-- 立功受奖种类 -->
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
		<!-- 是否退档 -->
	<model:dataset id="ApprovalDataset" enumName="APPROVALSTATE.CODE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 档案来源 -->
	<model:dataset id="FileResourcesDataset" enumName="FILESRESOURCE.CODE"
		autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel autoHeight="true" bodyStyle="width:100%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存信息" handler="save" />
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
							<td class="FieldInput"><select id="retiredSoldierType"  style="width:135" onchange="func_sergeantLevel()"
								field="retiredSoldierType" name="退役士兵类型">
								<option value="0" >退伍义务兵</option>
								<option value="1" >复员士官</option>
								<option value="3" >转业士官</option>
							</select><font color="red">*</font></td>
							<td class="FieldLabel" nowrap="nowrap">退伍证号：</td>
							<td class="FieldInput"><input type="text" style="width:135"
								field="veteransCertificateNo" name="退伍证号" /></td>
							<td class="FieldLabel" nowrap="nowrap">士官级别：</td>
							<td class="FieldInput"><select id="sergeantLevel"
								name="士官级别" field="sergeantLevel" >
								<option dataset="SergeancyLevelDataset"></option>
							</select></td>
						</tr>
						<tr>
							<td class="FieldLabel">身份证号：</td>
							<td class="FieldInput" ><input type="text" field="idcardNo" size="18" id="idcardNo" onchange="func_QueryIdCard()" style="width:135"
								name="身份证号" /></td>
							<td class="FieldLabel" nowrap="nowrap" >姓名：</td>
							<td class="FieldInput"><input type="text" field="name" style="width:135" id="name"
								name="姓名" onblur="nameNew()" /><font color="red">*</font></td>
							<td class="FieldLabel">性别：</td>
							<td class="FieldInput"><select field="sex" name="性别">
								<option dataset="SexDataset"></option>
							</select><font color="red">*</font></td>

						</tr>
						<tr>
							<td class="FieldLabel">民族：</td>
							<td class="FieldInput"><select id="nation"   field="naton" name="民族" style="width:135">
								<option dataset="NationDataset"></option>
							</select><font color="red">*</font></td>
							<td class="FieldLabel" nowrap="nowrap">户口性质：</td>
							<td class="FieldInput"><select id="hukouType" style="width:135"
								field="hukouType" name="户口性质">
								<option dataset="DomicileDataset"></option>
							</select><font color="red">*</font></td>

							<td class="FieldLabel">出生日期：</td>
							<td class="FieldInput"><input type="text" field="birthday" id="birthday"
								format="Y-m-d" maxlength="10"onpropertychange="changeDateStyle(this)" name="出生日期"/><img  src="../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ><font
								color="red">*</font></td>
						</tr>
						<tr>
							<td class="FieldLabel">入伍方式：</td>
							<td class="FieldInput"><select id="enlistType" style="width:135"
								field="enlistType" name="入伍方式" >
								<option dataset="EnlistTypeDataset"></option>
							</select></td>
							<td class="FieldLabel">入伍地：</td>
							<td class="FieldInput"><input type="text" field="enlistPlace" id="enlistPlace" style="width:135" name="入伍地" /><font color="red">*</font>
								</td>
							<td class="FieldLabel">入伍时间：</td>
							<td class="FieldInput"><input type="text" field="enlistTime"  id="enlistTime"
								format="Y-m-d" maxlength="10"onpropertychange="changeDateStyle(this)" name="入伍时间" onblur="serveTime()"/><img  src="../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ><font
								color="red">*</font></td>
						</tr>
						<tr>
							<td class="FieldLabel">军区大单位：</td>
							<td class="FieldInput"><select id="servedMilitaryRegion" style="width:135"
								field="servedMilitaryRegion" name="军区大单位">
								<option dataset="MilitaryRegionCodeDataset"></option>
							</select><font color="red">*</font></td>
							<td class="FieldLabel">部队单位：</td>
							<td class="FieldInput"><input type="text" field="servedArmy" style="width:135"
								name="部队单位" /><font color="red">*</font></td>
							<td class="FieldLabel">退役时间：</td>
							<td class="FieldInput"><input type="text" id="retiredTime" onblur="serveTime()"
								field="retiredTime" format="Y-m-d"  maxlength="10" onpropertychange="changeDateStyle(this)"
								name="退役时间：" /><img  src="../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ><font color="red">*</font></td>
						</tr>
						<tr>
							<td class="FieldLabel" nowrap="nowrap">档案来源：</td>
							<td class="FieldInput"><select field="filesSource" style="width:135"
								name="档案来源">
								<option dataset="FileResourcesDataset"></option>
							</select><font color="red">*</font></td>
							<td class="FieldLabel" nowrap="nowrap">接收档案时间：</td>
							<td class="FieldInput"><input type="text" id="filesReceiveTime"
								field="filesReceiveTime" format="Y-m-d" style="width:135"
								maxlength="10" onpropertychange="changeDateStyle(this)" name="接收档案时间" /><img  src="../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ></td>
							<td class="FieldLabel">服役年限：</td>
							<td class="FieldInput"><input type="text" id="servicedTimeTrs" readonly="readonly"
								field="servicedTimeTrs" name="servicedTimeTrs" title="自动计算"/>
							<class="FieldInput"><input type="hidden" id="servicedTime" readonly="readonly"
								field="servicedTime" name="servicedTime" title="服役年限"/></td>
						</tr>
						<tr>
							<td class="FieldLabel">联系电话：</td>
							<td class="FieldInput"><input type="text" field="tel" style="width:135" size="11"
								id="tel" name="联系电话" /><font color="red">*</font></td>
							<td class="FieldLabel">落户派出所：</td>
							<td class="FieldInput"><input type="text" style="width:135"
								field="hukouLocation" name="落户派出所" /></td>
							<td class="FieldLabel">健康状况：</td>
							<td class="FieldInput"><select field="healthCondition"
								name="健康状况">
								<option dataset="HealthDataset"></option>
							</select></td>
						</tr>
						<tr>
						<td class="FieldLabel">文化程度：</td>
						<td class="FieldInput"><select name="coutralLevel"
							style="width: 135" field="coutralLevel">
							<option dataset="EducationDataset"></option>
						</select></td>
						<td class="FieldLabel">专业特长：</td>
						<td class="FieldInput" nowrap="nowrap" style="">
						<!-- <select
							id="specialtySelect" style="width: 135" onchange="specChanges()">
							<option value="">请选择...</option>
							<option value="1">驾驶</option>
							<option value="2">厨师</option>
							<option value="3">技工</option>
							<option value="0">其他</option>
						</select> &nbsp;&nbsp;
						 -->
						<input type="text" field ="specialty" style="width: 135" id="specialtyInput" name="专业特长"></td>
						<td class="FieldLabel">是否伤残：</td>
						<td class="FieldInput"><select name="是否伤残"
							field="disabilityFlag">
							<option dataset="DisabilityFlagDataset"></option>
						</select></td>
					</tr>
						<tr>
							<td class="FieldLabel" nowrap="nowrap">安置地：</td>
							<td class="FieldInput"><input type="text" id="domicileName" style="width:135"
								field="domicileName" onclick="forHelp()" readonly="readonly" />
							<input type="hidden" id="domicileCode" field="wherePlacemen"
								name="安置地" /><font color="red">*</font></td>

							<td class="FieldLabel">家庭住址：</td>
							<td class="FieldInput" colspan="3"><input type="text"
								field="address" name="家庭住址" style="width: 84%" /><font
								color="red">*</font></td>
						</tr>
						<tr>
							<td class="FieldLabel">父亲姓名：</td>
							<td class="FieldInput"><input type="text" field="fatherName" style="width:135"
								id="fatherName" name="父亲姓名" /></td>
							<td class="FieldLabel">工作单位：</td>
							<td class="FieldInput"><input type="text" style="width:135"
								field="fatherWorkunit" id="fatherWorkunit" name="工作单位" /></td>
							<td class="FieldLabel" nowrap="nowrap">联系电话：</td>
							<td class="FieldInput"><input type="text" field="fatherTel"  size="11"
								id="fatherTel" name="联系电话" /></td>
						</tr>
						<tr>
							<td class="FieldLabel">母亲姓名：</td>
							<td class="FieldInput"><input type="text" field="matherName" style="width:135"
								id="matherName" name="母亲姓名" /></td>

							<td class="FieldLabel">工作单位：</td>
							<td class="FieldInput"><input type="text" style="width:135"
								field="matherWorkunit" id="matherWorkunit" name="工作单位" /></td>

							<td class="FieldLabel" nowrap="nowrap">联系电话：</td>
							<td class="FieldInput"><input type="text" field="matherTel"  size="11"
								id="matherTel" name="联系电话" /></td>
						</tr>
						<tr>
							<td class="FieldLabel">配偶姓名：</td>
							<td class="FieldInput"><input type="text" field="spouseName" style="width:135"
								id="spouseName" name="配偶姓名" /></td>

							<td class="FieldLabel">工作单位：</td>
							<td class="FieldInput"><input type="text" style="width:135"
								field="spouseWorkunit" id="spouseWorkunit" name="工作单位" /></td>

							<td class="FieldLabel" nowrap="nowrap">联系电话：</td>
							<td class="FieldInput"><input type="text" field="spouseTel"  size="11"
								id="spouseTel" name="联系电话" /></td>
						</tr>
						<tr>
							<td class="FieldLabel">配偶户口所在地：</td>
							<td class="FieldInput"><input type="text" field="spouseLocation" style="width:135"
								id="spouseLocation" name="配偶户口所在地" /></td>
							<td class="FieldLabel">安置理由：</td>
							<td class="FieldInput"><select  id = "placemenRenson" style="width:135" field="placemenRenson" name="安置理由" >
								<option dataset="PlaceReasonDataset" ></option></select>
								</td>
					<%--		<td class="FieldLabel">移交材料：</td>
							<td class="FieldInput"><input type="text" field="transFile"
								id="transFile" name="移交材料" /></td>
							</tr>
							<tr>--%>
							<td class="FieldLabel">是否退档：</td>
						<td class="FieldInput"><select field="flag" id ="flag" onchange="flagChanges()" name="是否退档" >
								<option dataset="ApprovalDataset"></option>
							</select></td>
						</tr>
											<tr>
						<td class="FieldLabel">退档时间：</td>
						<td class="FieldInput"><input type="text" 
							 format="Y-m-d" style="width: 135" id = "returnDate" field = "returnDate"
							maxlength="10" onpropertychange="changeDateStyle(this)"
							name="接收档案时间" /><img
							src="../../../../skins/images/default/rl.gif" align="middle" id="returnDateimg"
							onclick="getTimes(this);"></td>
						<td class="FieldLabel">退档方式：</td>
						<td class="FieldInput" colspan="1"><input type="text" id = "returnType" field ="returnType" style="width:135" /></td>
						<td class="FieldLabel">报到时间：</td>
						<td class="FieldInput"><input type="text" field="arriveTime"  id="arriveTime"
							format="Y-m-d" maxlength="10"onpropertychange="changeDateStyle(this)" name="报到时间" title="报到时间"/><img  src="../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" >
							</td>
					</tr>
						<tr>
							<td class="FieldLabel">备注(基本信息)：</td>
							<td class="FieldInput" colspan="5"><textarea field="content"
								rows="3" style="width: 85%" name="备注(基本信息)"></textarea></td>
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
								<td class="FieldLabel">职位：</td>
								<td class="FieldInput"><select id="position"
									name="position" field="position" title="职务">
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
								</select></td>
								<td class="FieldLabel">残疾等级：</td>
								<td class="FieldInput"><select id="injuringGrade"
									name="injuringGrade" field="injuringGrade" title="伤残等级">
									<option value="">请选择...</option>
									<option value="5">五级</option>
									<option value="6">六级</option>
									<option value="7">七级</option>
									<option value="8">八级</option>
								</select></td>
								<input type="hidden" name="armyId" id="armyId" field="armyId" />
							</tr>
						</table>
						</form>
						</fieldset>
					</next:Html>
				</next:Panel>
				
				<next:EditGridPanel id="awardGridPanel" name="立功受奖情况" height="300"
					name="prsawardsmeritoriousGrid" width="100%" stripeRows="true"
					dataset="prsawardsmeritoriousDataset">
					<next:TopBar>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem symbol="-"></next:ToolBarItem>
						<next:ToolBarItem iconCls="add" text="增加" handler="insertWin" />
						<next:ToolBarItem iconCls="remove" text="删除" handler="del" />
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn width="30" />
						<next:CheckBoxColumn></next:CheckBoxColumn>
						<next:Column id="awardsType" header="立功受奖种类" field="awardsType"
											width="95">
							<next:ComboBox dataset="AwardsTypeDataset"
												id="awardsTypeComboBox" />
						</next:Column>
				
						<next:Column id="awardsName" header="立功受奖名称" field="awardsName" width="200">
							<next:ComboBox dataset="AwardsNameDataset"id="awardsNameComboBox" />
						</next:Column>
						<next:Column id="awardsNumber" header="立功受奖次数" field="awardsNumber" width="95" renderer="changeAwardsNumber">
							<next:TextField />
						</next:Column>
						<next:Column id="awardsTime" header="立功受奖年份" field="awardsTime" width="100">
							<next:TextField />
						</next:Column>
						<next:Column id="awardsNote" header="立功受奖具体时间" field="awardsNote" width="450">
							<next:TextField />
						</next:Column>
						</next:Columns>
				</next:EditGridPanel>
			</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>
<next:Window id="awardWin" title="增加立功受奖" expandOnShow="false" closeAction="hide" resizable="false" width="500" height="300" closable="false">
	<next:Html>
		<fieldset>
			<form id="awardForm" method="post"
				dataset="prsawardsmeritoriousDataset" onsubmit="return false"
				style="padding: 5px;" class="L5form">
			<table border="0" width="98%">
				<tr>
					<td class="FieldLabel" >立功受奖种类</td>
					<td class="FieldInput" width="70%"><select id="awardsTypeWin" 
					 name="awardsType" field="awardsType" title="立功受奖种类" >
					 <option dataset="AwardsTypeDataset"></option>
					 </select><font color="red">*</font>
					 </td>
				</tr>
				<tr>
					<td class="FieldLabel">立功受奖名称</td>
					<td class="FieldInput"><select id="awardsNameWin"
					 name="awardsName" field="awardsName" title="立功受奖名称" >
					 <option dataset="AwardsNameDataset"></option>
					 </select>
					 <font color="red">*</font>
					 </td>
				</tr>
				<tr>
					<td class="FieldLabel">立功受奖次数</td>
					<td class="FieldInput"><input type="text" id="awardsNumberWin"
					 name="awardsNumber" field="awardsNumber" title="立功受奖次数" />
					 <font color="red">*</font>
					 </td>
				</tr>
				<tr>
					<td class="FieldLabel">立功受奖年份</td>
					<td class="FieldInput"><input type="text" id="awardsTimeWin"
					 name="awardsTime" field="awardsTime" title="立功受奖年份" 
					 maxlength="4" /></td>
				</tr>
				<tr>
					<td class="FieldLabel">立功受奖具体时间</td>
					<td class="FieldInput" ><textarea id="awardsNote" width="300" style="width:80%" id="awardsNoteWin"
					 name="awardsNote" field="awardsNote" title="立功受奖具体时间" rows="5" /></textarea></td> 
				</tr>
			</table>
		</fieldset>
	</next:Html>
	<next:Buttons>
		<next:ToolButton text="继续添加" handler="awardSubmit"></next:ToolButton>
		<next:ToolButton text="确定" handler="hide"></next:ToolButton>
		<next:ToolButton text="关闭" handler="close"></next:ToolButton>
	</next:Buttons>
</next:Window>
</body>
</html>