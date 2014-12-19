<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>人员基础信息编辑</title>
<next:ScriptManager></next:ScriptManager>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
<script type="text/javascript" src="cdcBaseinfoFamilyHeadEdit.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var databeanId='<%=request.getParameter("databeanId")%>';
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="cdcBaseinfoPeopleDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcBaseinfoPeopleQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcBaseinfoPeople"/>
	</model:dataset>
	<model:dataset id="YorN" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 性别 -->
	<model:dataset id="sexDataSet" enumName="COMM.SEX" autoLoad="true" global="true"/>
	<!-- 政治面貌 -->
	<model:dataset id="politicalDataSet" enumName="CDC.POLITICAL" autoLoad="true" global="true"/>
	<!-- 文化程度 -->
	<model:dataset id="educationDataSet" enumName="CDC.EDUCATION" autoLoad="true" global="true"/>
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
</model:datasets>
<next:Panel width="100%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="save" id = "saveAdd" text="保存并添加家庭成员" handler="saveAndAdd"/>
	<next:ToolBarItem iconCls="save" id = "save" text="保存" handler="save"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="cdcBaseinfoPeopleDataSet" onsubmit="return false" class="L5form">
<fieldset>
	<legend>户主信息</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:10%">姓名：</td>
			<td class="FieldInput" style="width:20%"><input type="text" name="姓名" id="name" field="name" maxlength="50" style="width:80%"/></td>
			<td class="FieldLabel" style="width:10%">性别：</td>
			<td class="FieldInput" style="width:20%"><select name="性别" id="sex" field="sex" onchange="sexChenges()" style="width:80%" ><option dataset="sexDataSet"></option></select></td>
			<td class="FieldLabel" style="width:10%">身份证件号码：</td>
			<td class="FieldInput" style="width:20%"><input type="text" name="身份证件号码" id="idCard" field="idCard" maxlength="18" style="width:80%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:10%">出生日期：</td>
			<td class="FieldInput" style="width:20%"><input type="text" name="出生日期" id="birthday" field="birthday" onclick="LoushangDate(this)" format="Y-m-d"  maxlength="10" style="width:80%"/></td>
			<td class="FieldLabel" style="width:10%">民族：</td>
			<td class="FieldInput" style="width:20%"><select name="民族" id="nation" field="nation" style="width:80%"><option dataset = "NationDataset"></option> </select></td>
			<td class="FieldLabel" style="width:10%">文化程度：</td>
			<td class="FieldInput" style="width:20%"><select name="文化程度" id="eduCode" field="eduCode" style="width:80%"><option dataset = "educationDataSet"></option> </select></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:10%">政治面貌：</td>
			<td class="FieldInput" style="width:20%"><select name="政治面貌" id="politicalCode" field="politicalCode" style="width:80%"><option dataset = "politicalDataSet"></option> </select></td>
			<td class="FieldLabel" style="width:10%">联系电话：</td>
			<td class="FieldInput" style="width:20%"><input type="text" name="联系电话" id="tel" field="tel" maxlength="50" style="width:80%"/></td>
			<td class="FieldLabel" style="width:10%">工作单位：</td>
			<td class="FieldInput" style="width:20%"><input type="text" name="工作单位" id="workUnit" field="workUnit" maxlength="50" style="width:80%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:10%">居住社区：</td>
			<td class="FieldInput" style="width:20%"><input type="text" name="居住社区" disabled="disabled" id="domicileName" field="domicileName" maxlength="200" style="width:80%"/></td>
			<td class="FieldLabel" style="width:10%">家庭住址：</td>
			<td class="FieldInput" style="width:20%"><input type="text" name="住址" id="address" field="address" maxlength="200" style="width:80%"/></td>
			<td class="FieldLabel" style="width:10%">邮政编码：</td>
			<td class="FieldInput" style="width:20%"><input type="text" name="邮政编码" id="postCode" field="postCode" maxlength="6" style="width:80%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:10%">贫困类型：</td>
			<td class="FieldInput" style="width:20%"><select name="贫困人员" id="povertyType" field="povertyType" style="width:80%"> <option value="">请选择...</option> <option value="1">低保家庭</option><option value="2">五保家庭</option> </select></td>
			<td class="FieldLabel" style="width:10%">是否农民工：</td>
			<td class="FieldInput" style="width:20%"><select name="是否农民工" id="peasantFlag" field="peasantFlag" onchange="peasantFlagChenges()" style="width:80%"><option dataset = "YorN"></option> </select></td>
			<td class="FieldLabel" style="width:10%">是否有子女上学问题：</td>
			<td class="FieldInput" style="width:20%" ><select name="是否有子女上学问题" id="childrenEducation" field="childrenEducation" style="width:80%"><option dataset = "YorN"></option> </select></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:10%">是否失业：</td>
			<td class="FieldInput" style="width:20%"><select name="失业标志" id="unemployedFlag" field="unemployedFlag" style="width:80%"><option dataset = "YorN"></option> </select></td>
			<td class="FieldLabel" style="width:10%">是否妇女：</td>
			<td class="FieldInput" style="width:20%" colspan="3"><select name="妇女标识" id="womanFlag" field="womanFlag" style="width:31%"><option dataset = "YorN"></option> </select></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:10%">优抚类别：</td>
			<td class="FieldInput" style="width:20%" colspan="5">
				<fieldset> <input type="radio" name="ss" id="yf1"/>烈士遗属 &nbsp;&nbsp;&nbsp; <input type="radio" name="ss" id="yf2"/>因公牺牲军人遗属&nbsp;&nbsp;&nbsp;
				<input type="radio" name="ss" id="yf3"/>病故军人遗属&nbsp;&nbsp;&nbsp; <input type="radio" name="ss"/>取消选择</fieldset> 
				<fieldset><input type="radio" name="sh" id="yf4"/>在乡退伍红军老战士&nbsp;&nbsp;&nbsp;<input type="radio" name="sh" id="yf5"/>西路红军老战士&nbsp;&nbsp;&nbsp;
				<input type="radio" name="sh" id="yf6"/>红军失散人员 &nbsp;&nbsp;&nbsp;<input type="radio" name="sh"/>取消选择</fieldset>
				<fieldset><input type="radio" name="sc" id="yf7"/>残疾军人&nbsp;&nbsp;&nbsp;<input type="radio" name="sc"/>取消选择</fieldset>
				<fieldset><input type="radio" name="fy" id="yf8"/>复员军人&nbsp;&nbsp;&nbsp;
				<input type="radio" name="fy" id="yf9"/>带病回乡退伍军人&nbsp;&nbsp;&nbsp; <input type="radio" name="fy"/>取消选择</fieldset></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:10%">残疾类别：</td>
			<td class="FieldInput" style="width:20%" colspan="5">
				<input type="checkbox" id="cj1"/>视力残疾<input type="checkbox" id="cj2"/>听力残疾
				<input type="checkbox" id="cj3"/>言语残疾<input type="checkbox" id="cj4"/>智力残疾
				<input type="checkbox" id="cj5"/>肢体残疾<input type="checkbox" id="cj6"/>精神病患者 
			</td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:10%">备注：</td>
			<td class="FieldInput" style="width:20%" colspan="5"><textarea rows="3" name="备注" id="note" field="note" style="width:95%"></textarea> </td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>