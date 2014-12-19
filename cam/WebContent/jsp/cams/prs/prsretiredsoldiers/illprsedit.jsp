<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<script type="text/javascript">
</script>
<html>
<head>
<title>伤病残退役士兵信息</title>
<next:ScriptManager />
<script>
	var idField='<%=request.getParameter("dataBean")%>';
	var method='<%=request.getParameter("method")%>';
	var struId = '<%=BspUtil.getStruId()%>';
   	var organCode = '<%=BspUtil.getOrganCode()%>';
   	var orgCode  ='<%=BspUtil.getOrganCode()%>';
   	var type='<%=request.getParameter("type")%>';
   	var organName= decodeURIComponent('<%=request.getParameter("organName")%>');
</script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'>
</script>
<script type="text/javascript" src="../prsComm.js"></script>
<script type="text/javascript" src="illprsedit.js"></script>
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
	<model:dataset id="FileResourcesDataset" enumName="FILESRESOURCE.CODE"
		autoLoad="true" global="true"></model:dataset>
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

	<!-- 士官级别 -->
	<model:dataset id="SergeancyLevelDataset"
		enumName="SERGEANCYLEVEL.CODE" autoLoad="true" global="true"></model:dataset>

	<!-- 退役士兵类型 -->
	<model:dataset id="RetiredSoldierTypeDataset"
		enumName="RETIREDSOLDIERTYPE.CODE" autoLoad="true" global="true">
	</model:dataset>
	<!--入伍形式 -->
	<model:dataset id="EnlistTypeDataset" enumName="ENLISTTYPE.CODE"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 是否伤残 -->
	<model:dataset id="DisabilityFlagDataset" enumName="COMM.YESORNO"
		autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:ViewPort>
	<next:AnchorLayout>
		<next:Panel >
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
								<td class="FieldLabel" nowrap="nowrap">退役士兵类型：</td>
							<td class="FieldInput"  ><select id="retiredSoldierType" style="width:135"
								field="retiredSoldierType" name="退役士兵类型">
								<option value="4" >伤病残退役士兵</option>
							</select><font color="red">*</font></td>
							<td class="FieldLabel" nowrap="nowrap">退伍证号：</td>
							<td class="FieldInput"><input type="text" style="width:135"
								field="veteransCertificateNo" name="退伍证号" /></td>
							<td class="FieldLabel" nowrap="nowrap">士官级别：</td>
							<td class="FieldInput"><select id="sergeantLevel"
								name="士官级别" field="sergeantLevel">
								<option dataset="SergeancyLevelDataset"></option>
							</select></td>
						</tr>
						<tr>
						<td class="FieldLabel">身份证号：</td>
							<td class="FieldInput"><input type="text" field="idcardNo" id ="idcardNo"  style="width:135"
								name="身份证号"  size="18" onchange="func_QueryIdCard()"/></td>
							<td class="FieldLabel" nowrap>姓名：</td>
							<td class="FieldInput"><input type="text" field="name" style="width:135" id="name"
								name="姓名" onblur="nameNew()"/><font color="red">*</font></td>
							<td class="FieldLabel">性别：</td>
							<td class="FieldInput"><select field="sex" name="性别">
								<option dataset="SexDataset"></option>
							</select><font color="red">*</font></td>

						</tr>
						<tr>
							<td class="FieldLabel">民族：</td>
							<td class="FieldInput"><select field="naton" name="民族" style="width:135">
								<option dataset="NationDataset"></option>
							</select><font color="red">*</font></td>
							<td class="FieldLabel" nowrap="nowrap">户口性质：</td>
							<td class="FieldInput"><select id="hukouType" style="width:135"
								field="hukouType" name="户口性质">
								<option dataset="DomicileDataset"></option>
							</select><font color="red">*</font></td>
							<td class="FieldLabel">出生日期：</td>
							<td class="FieldInput"><input type="text" field="birthday" id="birthday"
								format="Y-m-d" maxlength="10"onpropertychange="changeDateStyle(this)" name="出生日期" /><img  src="../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ></td>
						</tr>
						<tr>
							<td class="FieldLabel">入伍方式：</td>
							<td class="FieldInput"><select id="enlistType" style="width:135"
								field="enlistType" name="入伍方式">
								<option dataset="EnlistTypeDataset"></option>
								</select></td>
							<td class="FieldLabel">入伍地：</td>
							<td class="FieldInput"><input type="text" field ="enlistPlace" id  ="enlistPlace" style="width:135"  name="入伍地" /><font color="red">*</font>
								</td>
							<td class="FieldLabel">入伍时间：</td>
							<td class="FieldInput"><input type="text" field="enlistTime" id="enlistTime" onblur="serveTime()"
								format="Y-m-d" maxlength="10"onpropertychange="changeDateStyle(this)" name="入伍时间" /><img  src="../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ><font
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
							<td class="FieldInput"><input type="text" id="retiredTime"
								field="retiredTime" format="Y-m-d" maxlength="10"onpropertychange="changeDateStyle(this)" onblur="serveTime()"
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
								maxlength="10"onpropertychange="changeDateStyle(this)" name="接收档案时间" /><img  src="../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ></td>
							<td class="FieldLabel">服役年限：</td>
							<td class="FieldInput"><input type="text" id="servicedTimeTrs" readonly="readonly"
								field="servicedTimeTrs" name="servicedTimeTrs" title="自动计算"/>
							<class="FieldInput"><input type="hidden" id="servicedTime" readonly="readonly"
								field="servicedTime" name="servicedTime" title="服役年限"/></td>
						</tr>
						<tr>
							<td class="FieldLabel">计划年度：</td>
						<td class="FieldInput"><input type="text" name="计划年度"id="planYear" style="width:135"
							field="planYear" /><font color="red">*</font></td>
							<td class="FieldLabel">是否接收：</td>
							<td class="FieldInput"><select field="ifReceive" style="width:135" onchange="ifReceiveChanges()"
								id="ifReceive" name="是否接收" ><option dataset ="DisabilityFlagDataset"></option>
								</select></td>
							<td class="FieldLabel">
							<div id="receiveTimeL" style="display: block;">接收时间：</div><div id="noReceiveReasonL" style="display: none;">不接收原因：</div>
							</td>
							<td class="FieldInput"><div id="receiveTimeDiv" style="display: block;"><input type="text" format="Y-m-d" maxlength="10"
							onpropertychange="changeDateStyle(this)" id="receiveTime" field="receiveTime" name="接收时间" /><img  src="../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ></div>
							<div id="noReceiveReason" style="display: none;"><input type="text" field="noReceiveReason" 
								name="不接收原因" ></div>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel">联系电话：</td>
							<td class="FieldInput"><input type="text" field="tel" style="width:135"
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
							<td class="FieldInput"><select name="coutralLevel" style="width:135"
								field="coutralLevel">
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
							<td class="FieldInput"><select name="是否伤残" id ="disabilityFlag"
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
							<td class="FieldInput" colspan="1"><input type="text" style="width:135"
								field="address" name="家庭住址" style="width: 135" /><font
								color="red">*</font></td>
							<td class="FieldLabel">报到时间：</td>
							<td class="FieldInput"><input type="text" field="arriveTime"  id="arriveTime"
								format="Y-m-d" maxlength="10"onpropertychange="changeDateStyle(this)" name="报到时间" title="报到时间"/><img  src="../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" >
								</td>
						</tr>
						<tr>
							<td class="FieldLabel">父亲姓名：</td>
							<td class="FieldInput"><input type="text" field="fatherName" style="width:135"
								id="fatherName" name="父亲姓名" /></td>
							<td class="FieldLabel">工作单位：</td>
							<td class="FieldInput"><input type="text" style="width:135"
								field="fatherWorkunit" id="fatherWorkunit" name="工作单位" /></td>
							<td class="FieldLabel" nowrap="nowrap">联系电话：</td>
							<td class="FieldInput"><input type="text" field="fatherTel"
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
							<td class="FieldInput"><input type="text" field="matherTel"
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
							<td class="FieldInput"><input type="text" field="spouseTel"
								id="spouseTel" name="联系电话" /></td>
						</tr>
						<tr>
							<td class="FieldLabel">备注(基本信息)：</td>
							<td class="FieldInput" colspan="5"><textarea field="content"
								rows="3" style="width: 91%" name="备注(基本信息)"></textarea></td>
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
