<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.inspur.cams.comm.util.StrUtil,org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next" %>
<%@ taglib uri="/tags/next-model" prefix="model" %>
<html>
<head>
<title>基金会信息修改</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="somFundUpdate.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
<script type="text/javascript">
	var sorgId = '<%=StrUtil.n2b(request.getParameter("sorgId"))%>';
</script>
</head>
<body>
<%--定义dataset--%>
<model:datasets>
	<%--基本信息--%>
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.manage.cmd.SomFundOrganQueryCmd" method="queryMain">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan">
		<%--基金会基本信息验证 --%>
			<model:field name="sorgCode" type="string" rule="require|length{20}" />
			<model:field name="cnName" type="string" rule="require|length{100}" />
			<%--<model:field name="organCode" type="string" rule="require" />组织机构代码--%>
			<model:field name="sorgKind" type="string" rule="require" />
			<model:field name="sorgPost" type="string" rule="require" />
			<model:field name="sorgPhone" type="string" rule="require|length{30}" />
			<model:field name="sorgAdds" type="string" rule="length{200}" />
			<model:field name="sorgEmail" type="string" rule="email|length{100}" />
			<model:field name="purpose" type="string" rule="require|length{1000}" />
			<model:field name="business" type="string" rule="require|length{1000}" />
			<%--<model:field name="busScope" type="string" rule="require" />所属行（事）业--%>
			<model:field name="borgName" type="string" rule="require|length{100}" />
			<model:field name="currency" type="string" rule="require|length{50}" />
			<model:field name="fundingPeople" type="string" rule="length{500}" />
			<model:field name="regMon" type="string" rule="require" />
			<model:field name="appReason" type="string" rule="require|length{500}" />
			<model:field name="checkCapitalOrgan" type="string" rule="require|length{100}" />
			<model:field name="moneySource" type="string" rule="require|length{500}" />
			<model:field name="residence" type="string" rule="require|length{100}" />
			<model:field name="resideSource" type="string" rule="require" />
			<model:field name="housingOrgan" type="string" rule="require|length{100}" />
			<model:field name="housingArea" type="string" rule="require" />
			<model:field name="leasePeriod" type="string" rule="length{100}" />
			<model:field name="regPeople" type="string" rule="length{72}" />
			<model:field name="regDate" type="string" rule="require" />
			<model:field name="buildDate" type="string" rule="require" />
		</model:record>
	</model:dataset>
	<%--法定代表人--%>
	<model:dataset id="somDeputyPeopleDataSet" cmd="com.inspur.cams.sorg.manage.cmd.SomFundPeopleQueryCmd" method="queryPeopleByParam">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeople">
			<%--基金会法定代表人信息验证  --%>
			<model:field name="cardType" type="string" rule="require" />
			<model:field name="idCard" type="string" rule="require|length{18}" />
			<model:field name="name" type="string" rule="require|length{72}" />
			<model:field name="aliasName" type="string" rule="length{72}" />
			<model:field name="sex" type="string" rule="require" />
			<model:field name="birthday" type="string" rule="require" />
			<model:field name="politics" type="string" rule="require" />
			<model:field name="nation" type="string" rule="require" />
			<model:field name="folk" type="string" rule="length{2}" />
			<model:field name="phone" type="string" rule="require|length{30}" />
			<model:field name="adds" type="string" rule="length{100}" />
			<model:field name="populace" type="string" rule="length{100}" />
			<model:field name="ifRetire" type="string" rule="require" />
			<model:field name="workName" type="string" rule="length{100}" />
			<model:field name="workDuties" type="string" rule="length{50}" />
			<model:field name="ifFulltime" type="string" rule="require" />
			<model:field name="ifPartyLeader" type="string" rule="require" />
			<model:field name="resume" type="string" rule="require|length{1000}" />
			<model:field name="memberNote" type="string" rule="length{200}" />
		</model:record>
	</model:dataset>
	<%--所有符合身份证号的人员列表--%>
	<model:dataset id="winPeopleDataSet" cmd="com.inspur.cams.sorg.manage.cmd.SomFundPeopleQueryCmd" method="queryPeopleByIdCard" pageSize="4">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeople"></model:record>
	</model:dataset>
	<%--所有符合身份证号的人员所在社会组织信息--%>
	<model:dataset id="winMemberDataSet" cmd="com.inspur.cams.sorg.manage.cmd.SomFundPeopleQueryCmd" method="queryMemberByPeopleId" pageSize="6">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomMember"></model:record>
	</model:dataset>

	<model:dataset id="peopleTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_PEOPLE_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="peopleStatusSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_PEOPLE_STATUS'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="politicsSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_POLITICAL'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="sorgKindSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_FUND_KIND'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="resideSourceSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_RESIDE_SOURCE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="busScopeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BUS_SCOPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="sorgDutiesSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_DUTY'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="cardTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CARD_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="ifFulltimeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_IF_FULLTIME'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="folkSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="businessOrganSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_BUSINESS_ORGAN'></model:param>
			<model:param name="value" value='BORG_CODE'></model:param>
			<model:param name="text" value='BORG_NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="sexSelect" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="nationSelect" enumName="SORG.NATION" autoLoad="true" global="true"></model:dataset>
</model:datasets>

<%--定义界面--%>
<next:Panel width="100%" height="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="基金会信息修改"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="更新" handler="updateAll"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="返回" handler="back"></next:ToolBarItem>
	</next:TopBar>

	<next:TabPanel id="tab" width="100%" height="100%"  activeTab="1" >
		<next:Tabs>
			<next:Panel title="基金会法人登记" width="100%" autoScroll="true">
				<next:Html>
					<form method="post" dataset="somOrganDataSet" onsubmit="return false" class="L5form">
					<table width="100%">
						<tr>
							<td class="FieldLabel"><label>登记证号：</label></td>
							<td class="FieldInput" colspan="5"><input type="text" id="sorgCode" name='"登记证号"' field="sorgCode" onchange="sorgCodeUK()" style="width:98%"/><span style="color:red">*</span></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>基金会名称：</label></td>
							<td class="FieldInput" colspan="5"><input type="text" id="cnName" name='"基金会名称"' field="cnName" onchange="cnNameUK()" style="width:98%"/><span style="color:red">*</span></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>组织机构代码：</label></td>
							<td class="FieldInput" colspan="3"><input type="text" id="organCode" name='"组织机构代码"' field="organCode" onchange="organCodeUK()" style="width:97%"/></td>
							<td class="FieldLabel"><label>基金会类型：</label></td>
							<td class="FieldInput">
								<select field="sorgKind" id="sorgKind" name='"基金会类型"' style="width:90%" onchange="changeSorgKind()">
									<option dataset="sorgKindSelect"></option>
								</select><span style="color:red">*</span>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>募捐地域：</label></td>
							<td class="FieldInput" colspan="5"><input type="text" id="actArea" style="width:98%;display:none" /></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>住所：</label></td>
							<td class="FieldInput" colspan="5"><input type="text" name='"住所"' field="residence" style="width:98%"/><span style="color:red">*</span></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width:17%"><label>住所来源：</label></td>
							<td class="FieldInput" style="width:17%">
								<select field="resideSource" id="resideSource" name='"住所来源"' style="width:90%" onchange="changeResideSource()">
									<option dataset="resideSourceSelect"></option>
								</select><span style="color:red">*</span>
							</td>
							<td class="FieldLabel" style="width:17%"><label>基金会邮编：</label></td>
							<td class="FieldInput" style="width:17%"><input type="text" id="sorgPost" name='"基金会邮编"' field="sorgPost" style="width:90%"/><span style="color:red">*</span></td>
							<td class="FieldLabel" style="width:15%"><label>基金会传真：</label></td>
							<td class="FieldInput" style="width:17%"><input type="text" id="sorgFax" field="sorgFax" style="width:90%"/></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>租（借）期限：</label></td>
							<td class="FieldInput" colspan="5"><input type="text" id="leasePeriod" style="width:98%;display:none"/></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>基金会电话：</label></td>
							<td class="FieldInput" colspan="5"><input type="text" id="sorgPhone" name='"基金会电话"' field="sorgPhone" style="width:59%"/><span style="color:red">*说明：多个电话，中间用英文分号隔开</span></td>
						</tr>

						<tr>
							<td class="FieldLabel"><label>宗旨：</label></td>
							<td class="FieldInput" colspan="5"><textarea name='"宗旨"' field="purpose" rows="10" style="width:98%"></textarea><span style="color:red">*</span></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>业务范围：</label></td>
							<td class="FieldInput" colspan="5"><textarea name='"业务范围"' field="business" rows="10" style="width:98%"></textarea><span style="color:red">*</span></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>业务主管单位：</label></td>
							<td class="FieldInput" colspan="3">
								<select name='"业务主管单位"' field="borgName" style="width:97%">
									<option dataset="businessOrganSelect"></option>
								</select><span style="color:red">*</span>
							</td>
							<td class="FieldLabel"><label>主管单位审查日期：</label></td>
							<td class="FieldInput"><input type="text" field="borgCheckDate" format="Y-m-d" onclick="WdatePicker()" style="width:90%"/></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>币种：</label></td>
							<td class="FieldInput"><input type="text" name='"币种"' field="currency" style="width:90%"/><span style="color:red">*</span></td>
							<td class="FieldLabel"><label>原始基金数额：</label></td>
							<td class="FieldInput" colspan="3"><input type="text" id="regMon" name='"原始基金数额"' field="regMon" maxlength="10" style="width:30%"/>万元人民币<span style="color:red">*</span></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>捐资人：</label></td>
							<td class="FieldInput" colspan="5"><textarea name='"捐资人"' field="fundingPeople" style="width:98%"></textarea></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>申请理由：</label></td>
							<td class="FieldInput" colspan="5"><textarea rows="5" name='"申请理由"' field="appReason" style="width:98%"></textarea><span style="color:red">*</span></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>验资单位：</label></td>
							<td class="FieldInput" colspan="5"><input type="text" name='"验资单位"' field="checkCapitalOrgan" style="width:98%"><span style="color:red">*</span></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>经费来源：</label></td>
							<td class="FieldInput" colspan="5"><textarea rows="5" name='"经费来源"' field="moneySource" style="width:98%"></textarea><span style="color:red">*</span></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>住所产权单位：</label></td>
							<td class="FieldInput" colspan="3"><input type="text" name='"住所产权单位"' field="housingOrgan" style="width:97%"/><span style="color:red">*</span></td>
							<td class="FieldLabel"><label>用房面积：</label></td>
							<td class="FieldInput"><input type="text" id="housingArea" name='"用房面积"' field="housingArea" maxlength="10" style="width:65%"/>平方米<span style="color:red">*</span></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>登记人：</label></td>
							<td class="FieldInput"><input type="text" name='"登记人"' field="regPeople" style="width:90%"/></td>
							<td class="FieldLabel"><label>登记日期：</label></td>
							<td class="FieldInput"><input type="text" name='"登记日期"' field="regDate" format="Y-m-d" onclick="WdatePicker()" style="width:90%"/><span style="color:red">*</span></td>
							<td class="FieldLabel"><label>成立日期：</label></td>
							<td class="FieldInput"><input type="text" name='"成立日期"' field="buildDate" format="Y-m-d" onclick="WdatePicker()" style="width:90%"/><span style="color:red">*</span></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>所属行（事）业：</label></td>
							<td class="FieldInput" colspan="5">
								<select field="busScope" name='"所属行（事）业"' style="width:17.5%">
									<option dataset="busScopeSelect"></option>
								</select>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>基金会通信地址：</label></td>
							<td class="FieldInput" colspan="5"><input type="text" name='"基金会通信地址"' field="sorgAdds" style="width:98%"/></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>基金会网址：</label></td>
							<td class="FieldInput" colspan="3"><input type="text" id="sorgWeb" field="sorgWeb" style="width:97%"/></td>
							<td class="FieldLabel"><label>基金会电子邮箱：</label></td>
							<td class="FieldInput"><input type="text" name='"基金会电子邮箱"' field="sorgEmail" style="width:90%"/></td>
						</tr>
					</table>
					</form>
				</next:Html>
			</next:Panel>

			<next:Panel id="panel_legal" title="法定代表人登记"  width="100%" autoScroll="true">
				<next:Html>
					<form  method="post" dataset="somDeputyPeopleDataSet" onsubmit="return false" class="L5form">
					<table width="100%">
						<tr>
							<td class="FieldLabel" style="width:13%"><label>证件类型：</label></td>
							<td class="FieldInput" style="width:20%">
								<select id="cardType" name='"证件类型"' field="cardType" onchange="validateCardType()" style="width:90%"/>
									<option dataset="cardTypeSelect"></option>
								</select><span style="color:red">*</span>
							</td>
							<td class="FieldLabel" style="width:13%"><label>证件号码：</label></td>
							<td class="FieldInput" style="width:20%"><input type="text"   id="idCard" name='"证件号码"' field="idCard" onchange="validateIdcard()" style="width:90%"/><span style="color:red">*</span></td>
							<td class="FieldLabel" style="width:13%"><label>姓名：</label></td>
							<td class="FieldInput" style="width:20%"><input type="text" name='"姓名"' field="name" style="width:90%"/><span style="color:red">*</span></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>曾用名：</label></td>
							<td class="FieldInput"><input type="text" name='"曾用名"' field="aliasName" style="width:90%"/></td>
							<td class="FieldLabel"><label>性别：</label></td>
							<td class="FieldInput">
							<select field="sex" name='"性别"' style="width:90%">
								<option dataset="sexSelect"></option>
							</select><span style="color:red">*</span>
							</td>
							<td class="FieldLabel"><label>出生年月：</label></td>
							<td class="FieldInput"><input type="text" id="birthday" name='"出生年月"'  field="birthday" format="Y-m-d" onclick="WdatePicker()" style="width:90%" onblur="showAge()"/><span style="color:red">*</span></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>政治面貌：</label></td>
							<td class="FieldInput">
								<select field="politics" name='"政治面貌"' style="width:90%">
									<option dataset="politicsSelect"></option>
								</select><span style="color:red">*</span>
							</td>
							<td class="FieldLabel"><label>是否离退休：</label></td>
							<td class="FieldInput">
								<select field="ifRetire" name='"是否离退休"' style="width:90%">
									<option dataset="comm_yesorno"></option>
								</select><span style="color:red">*</span>
							</td>
							<td class="FieldLabel"><label>年龄：</label></td>
							<td class="FieldInput"><label id="age" style="width:90%"></label></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>国籍：</label></td>
							<td class="FieldInput">
								<select field="nation" name='"国籍"' style="width:90%">
									<option dataset="nationSelect"></option>
								</select><span style="color:red">*</span>
							</td>
							<td class="FieldLabel"><label>民族：</label></td>
							<td class="FieldInput">
								<select name='"民族"'  field="folk" style="width:90%">
									<option dataset="folkSelect"></option>
								</select>
							</td>
							<td class="FieldLabel"><label>是否连任法定代表人：</label></td>
							<td class="FieldInput">
								<select field="ifRedo" name='"是否连任法定代表人"' style="width:90%">
									<option dataset="comm_yesorno"></option>
								</select>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>本人电话：</label></td>
							<td class="FieldInput" colspan="5"><input type="text" id="phone" name='"本人电话"'  field="phone" style="width:59%"/></br><span style="color:red">*说明：多个电话，中间用英文分号隔开，第一个电话必须为公开电话</span></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>家庭住址：</label></td>
							<td class="FieldInput" colspan="5"><input type="text" name='"家庭住址"'  field="adds" style="width:97.7%"/></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>户口所在地：</label></td>
							<td class="FieldInput" colspan="5"><input type="text" name='"户口所在地"'  field="populace" style="width:97.7%"/></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>工作单位：</label></td>
							<td class="FieldInput" colspan="5"><input type="text" name='"工作单位"' field="workName" style="width:97.7%"/></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>工作职务：</label></td>
							<td class="FieldInput"><input type="text" name='"工作职务"'  field="workDuties" style="width:90%"/></td>
							<td class="FieldLabel"><label>专/兼职：</label></td>
							<td class="FieldInput">
								<select field="ifFulltime" name='"专/兼职"' style="width:90%">
									<option dataset="ifFulltimeSelect"></option>
								</select><span style="color:red">*</span>
							</td>
							<td class="FieldLabel"><label>基金会职务：</label></td>
							<td class="FieldInput"><label style="width:90%">理事长</label></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>是否党政机关领导干部：</label></td>
							<td class="FieldInput">
								<select field="ifPartyLeader" id="ifPartyLeader_update" name='"是否党政机关领导干部"' onchange="valid_ifPartyLeader_update()" style="width:90%">
									<option dataset="comm_yesorno"></option>
								</select><span style="color:red">*</span>
							</td>
							<td class="FieldLabel"><label>批准文号：</label></td>
							<td class="FieldInput"><input type="text" id="promiseCode_update" style="width:90%;display:none"/></td>
							<td class="FieldLabel"><label>批准机关：</label></td>
							<td class="FieldInput"><input type="text" id="promiseOrgan_update" style="width:90%;display:none"/></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>本人简历：</label></td>
							<td class="FieldInput" colspan="5"><textarea  rows="10" name='"本人简历"' field="resume" style="width:97.7%"></textarea><span style="color:red">*</span></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>备注：</label></td>
							<td class="FieldInput" colspan="5"><textarea rows="2" name='"备注"' field="memberNote" style="width:97.7%"></textarea></td>
						</tr>
					</table>
					</form>
				</next:Html>
			</next:Panel>
			<next:Panel title="电子档案上传" width="100%" >
				<next:Html>
				  <iframe id="uploadInfo" src="../upload/somUploadComm.jsp?sorgId=<%=request.getParameter("sorgId") %>&applyType=201"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
			</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>
<next:Window id="win_peopleValidate" title="人员身份验证"  resizable="false" width="500" height="403" closeAction="hide">
		<next:EditGridPanel id="grid_2" width="486" stripeRows="true" height="170" dataset="winPeopleDataSet">
			<next:TopBar>
				<next:ToolBarItem symbol="人员列表"></next:ToolBarItem>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="edit" text="回填信息" handler="fill"></next:ToolBarItem>
				<next:ToolBarItem iconCls="delete" text="关闭窗口" handler="close"></next:ToolBarItem>
			</next:TopBar>

			<next:Columns>
				<next:RowNumberColumn />
				<next:RadioBoxColumn></next:RadioBoxColumn>
				<next:Column header="姓名"    field="name" width="150" sortable="true" editable="false"><next:TextField /></next:Column>
				<next:Column header="出生年月" field="birthday" width="142" sortable="true" editable="false"><next:DateField format="Y-m-d" /></next:Column>
				<next:Column header="性别" 	  field="sex"      width="142" sortable="true" editable="false" dataset="sexSelect" ><next:TextField /></next:Column>
			</next:Columns>
			<next:BottomBar>
				<next:PagingToolBar dataset="winPeopleDataSet" />
			</next:BottomBar>
		</next:EditGridPanel>
		<next:EditGridPanel id="grid_3" width="486" stripeRows="true" height="202" dataset="winMemberDataSet">
			<next:TopBar>
				<next:ToolBarItem symbol="所在社会组织信息"></next:ToolBarItem>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
			</next:TopBar>

			<next:Columns>
				<next:RowNumberColumn />
				<next:Column header="组织名称" field="sorgName" width="165" sortable="false" editable="false"><next:TextField /></next:Column>
				<next:Column header="职务" field="sorgDuties" width="120" dataset="sorgDutiesSelect" sortable="false" editable="false"><next:TextField /></next:Column>
				<next:Column header="状态" field="ifValid" width="80" dataset="peopleStatusSelect" sortable="false" editable="false"><next:TextField /></next:Column>
				<next:Column header="类型" field="peopleType" width="90" dataset="peopleTypeSelect" sortable="false" editable="false"><next:TextField /></next:Column>
			</next:Columns>
			<next:BottomBar>
				<next:PagingToolBar dataset="winMemberDataSet" />
			</next:BottomBar>
		</next:EditGridPanel>
</next:Window>
</body>
</html>