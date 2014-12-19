<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="gbk"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<script type="text/javascript">
	var struId = '<%=BspUtil.getStruId()%>';
</script>
<html>
<head>
<title>社会组织人员查询</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="somPeopleQuery.js"></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request,"cams.js") %>"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
</head>
<body>
<model:datasets>
	<!-- 性别 -->
	<model:dataset id="sex" enumName="COMM.SEX"  autoLoad="true" global="true"></model:dataset>
	<!-- 国籍 -->
	<model:dataset id="nation" enumName="SORG.NATION"  autoLoad="true" global="true"></model:dataset>
	<!-- 政治面貌 -->
	<model:dataset id="politics" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_POLITICAL'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 学历 -->
	<model:dataset id="education" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_EDUCATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 是否离退休 -->
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 是否专兼职 -->
	<model:dataset id="ifFulltime" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_IF_FULLTIME'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 社会组织种类 -->
	<model:dataset id="sorgType" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SORG_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 社会组织类型 -->
	<model:dataset id="sorgKind" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_GROUP_KIND'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 社会组织职务 -->
	<model:dataset id="sorgDuties" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_DUTY'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 民族 -->
	<model:dataset id="folkSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="leaderLevelDataSet" enumName="SOM.LEADER_LEVEL" autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:Panel width="100%" height="100%" autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem"/>
		<next:ToolBarItem symbol="社会组织人员综合查询"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="进行查询" iconCls="edit" handler="forQuery"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form class="L5form">
			<fieldset>
				<legend>人员基本信息查询条件</legend>
				<table width="100%">
					<tr>
						<td class="FieldLabel" style="width:9%"><label>姓名：</label></td>
						<td class="FieldInput" style="width:15%"><input type="text" id="name" style="width:80%"/></td>
						<td class="FieldLabel" style="width:9%"><label>身份证件号码：</label></td>
						<td class="FieldInput" style="width:15%"><input type="text" id="idCard" style="width:80%"/></td>
						<td class="FieldLabel" style="width:9%"></td>
						<td class="FieldInput" style="width:15%"></td>
					</tr>
					<tr>
						<td class="FieldLabel" ><label>性别：</label></td>
						<td class="FieldInput" ><select id="sex" style="width:80%"><option dataset="sex"></option></select></td>
						<td class="FieldLabel" ><label>出生日期：</label></td>
						<td class="FieldInput" >
							<input type="text" id="birthdayQ" format="Y-m-d" style="width:70" onclick="WdatePicker()" /> -----
							<input type="text" id="birthdayZ" format="Y-m-d" onclick="WdatePicker()" style="width:70" />
						</td>
						<td class="FieldLabel" ><label>民族：</label></td>
						<td class="FieldInput" ><select id="folk" style="width:80%"><option dataset="folkSelect"></option></select></td>
					</tr>
					<tr>
						<td class="FieldLabel" ><label>国籍：</label></td>
						<td class="FieldInput" ><select id="nation" style="width:80%"><option dataset="nation"></option></select></td>
						<td class="FieldLabel" ><label>政治面貌：</label></td>
						<td class="FieldInput" ><select id="politics" style="width:80%"><option dataset="politics"></option></select></td>
						<td class="FieldLabel" ><label>学历：</label></td>
						<td class="FieldInput" ><select id="education" style="width:80%"><option dataset="education"></option></select></td>
					</tr>
					<tr>
						<td class="FieldLabel" ><label>户口所在地：</label></td>
						<td class="FieldInput" ><input type="text" id="populace" style="width:80%"/></td>
						<td class="FieldLabel" ><label>是否离退休：</label></td>
						<td class="FieldInput" ><select id="ifRetire" style="width:80%"><option dataset="comm_yesorno"></option></select></td>
						<td class="FieldLabel" ><label>是否专兼职：</label></td>
						<td class="FieldInput" ><select id="ifFulltime" style="width:80%"><option dataset="ifFulltime"></option></select></td>
					</tr>
					<tr>
						<td class="FieldLabel" ><label>工作单位：</label></td>
						<td class="FieldInput" ><input type="text" id="workName" style="width:80%"/></td>
						<td class="FieldLabel" ><label>工作单位电话：</label></td>
						<td class="FieldInput" ><input type="text" id="workPhone" style="width:80%"/></td>
						<td class="FieldLabel" ><label>工作单位职务：</label></td>
						<td class="FieldInput" ><input type="text" id="workDuties" style="width:80%"/></td>
					</tr>
					<tr>
						<td class="FieldLabel" ><label>家庭住址：</label></td>
						<td class="FieldInput" ><input type="text" id="adds" style="width:80%"/></td>
						<td class="FieldLabel" ><label>家庭住址邮编：</label></td>
						<td class="FieldInput" ><input type="text" id="postCode" style="width:80%"/></td>
						<td class="FieldLabel" ><label>电话：</label></td>
						<td class="FieldInput" ><input type="text" id="phone" style="width:80%"/></td>
					</tr>
					<tr>
						<td class="FieldLabel">是否党政机关领导干部：</td>
						<td class="FieldInput">
							<select id="ifPartyLeader"  name='"是否党政机关领导干部"' style="width:80%">
								<option dataset="comm_yesorno"></option>
							</select>
						</td>
						<td class="FieldLabel">党政机关领导干部职级：</td>
						<td class="FieldInput">
							<select id="partyLeaderLevel" name='"党政机关领导干部职级"'  style="width:80%">
								<option dataset="leaderLevelDataSet"></option>
							</select>
						</td>
						<td class="FieldLabel">批准机关：</td>
						<td class="FieldInput"><input type="text" id="promiseOrgan" style="width:80%"/></td>
					</tr>
				</table>
			</fieldset>
			<fieldset>
				<legend>人员关系信息查询条件</legend>
				<table width="100%">
					<tr>
						<td class="FieldLabel" style="width:9%"><label>所在社会组织名称：</label></td>
						<td class="FieldInput" style="width:15%"><input type="text" id="cnName" style="width:80%"/></td>
						<td class="FieldLabel" style="width:9%"><label>所在社会组织种类：</label></td>
						<td class="FieldInput" style="width:15%"><select id="sorgType" style="width:80%"><option dataset="sorgType"></option></select></td>
						<td class="FieldLabel" style="width:9%"><label>所在社会组织类型：</label></td>
						<td class="FieldInput" style="width:15%"><select id="sorgKind" style="width:80%"><option dataset="sorgKind"></option></select></td>
					</tr>
					<tr><td class="FieldLabel" ><label>是否在任：</label></td>
						<td class="FieldInput" ><select id="ifServe" style="width:80%"><option dataset="comm_yesorno"></option></select></td>
						<td class="FieldLabel" ><label>担任社会组织职务：</label></td>
						<td class="FieldInput" ><select id="sorgDuties" style="width:80%"><option dataset="sorgDuties"></option></select></td>
						<td class="FieldLabel" ><label>登记管理机关：</label></td>
						<td class="FieldInput" >
						<input type="hidden" id="morgCode" />
						<input type="text" id="morgName" class="TextEditor" title="登记管理机关" onclick="forHelp()" /></td>
					</tr>
				</table>
			</fieldset>
		</form>
	</next:Html>
</next:Panel>

</body>
</html>