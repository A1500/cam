<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>人员基础信息编辑</title>
<next:ScriptManager></next:ScriptManager>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
<script type="text/javascript" src="cdcBaseinfoFamilyUpdateEdit.js"></script>
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
	<model:dataset id="familyMemberDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcBaseinfoPeopleQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcBaseinfoPeople"/>
	</model:dataset>
	<model:dataset id="YorN" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 性别 -->
	<model:dataset id="sexDataSet" enumName="COMM.SEX" autoLoad="true" global="true"/>
	<!-- 政治面貌 -->
	<model:dataset id="politicalDataSet" enumName="CDC.POLITICAL" autoLoad="true" global="true"/>
	<!-- 文化程度 -->
	<model:dataset id="educationDataSet" enumName="CDC.EDUCATION" autoLoad="true" global="true"/>
	<!-- 与户主关系 -->
	<model:dataset id="relationshipDataSet" enumName="CDC.RELATIONSHIP.TYPE" autoLoad="true" global="true"/>
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
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="cdcBaseinfoPeopleDataSet" onsubmit="return false" class="L5form">
<fieldset>
	<legend>户主基本信息</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:10%">姓名：</td>
			<td class="FieldInput" style="width:20%"><label name="姓名" id="name" field="name" maxlength="50" /></td>
			<td class="FieldLabel" style="width:10%">性别：</td>
			<td class="FieldInput" style="width:20%"><label name="性别" id="sex" field="sex" dataset="sexDataSet"/></td>
			<td class="FieldLabel" style="width:10%">身份证件号码：</td>
			<td class="FieldInput" style="width:20%"><label name="身份证件号码" id="idCard" field="idCard" maxlength="18" /></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:10%">出生日期：</td>
			<td class="FieldInput" style="width:20%"><label name="出生日期" id="birthday" field="birthday" onclick="LoushangDate(this)" format="Y-m-d"  maxlength="10" /></td>
			<td class="FieldLabel" style="width:10%">联系电话：</td>
			<td class="FieldInput" style="width:20%"><label name="联系电话" id="tel" field="tel" maxlength="50" /></td>
			<td class="FieldLabel" style="width:10%">工作单位：</td>
			<td class="FieldInput" style="width:20%"><label name="工作单位" id="workUnit" field="workUnit" maxlength="50" /></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:10%">居住社区：</td>
			<td class="FieldInput" style="width:20%"><label name="居住社区" id="domicileName" field="domicileName" maxlength="200" /></td>
			<td class="FieldLabel" style="width:10%">家庭住址：</td>
			<td class="FieldInput" style="width:20%"><label name="住址" id="address" field="address" maxlength="200" /></td>
			<td class="FieldLabel" style="width:10%">邮政编码：</td>
			<td class="FieldInput" style="width:20%"><label name="邮政编码" id="postCode" field="postCode" maxlength="6" /></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
<next:EditGridPanel id="grid" dataset="familyMemberDataSet" width="100%" stripeRows="true" height="99.9%" autoExpandColumn="note">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="add" text="添加家庭成员信息" handler="addFamilyMember"></next:ToolBarItem>
		<next:ToolBarItem iconCls="edit" text="修改家庭成员信息" handler="updateFamilyMember"></next:ToolBarItem>
		<next:ToolBarItem iconCls="delete" text="删除家庭成员信息" handler="delFamilyMember"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="name" header="姓名" width="90" sortable="false"/>
		<next:Column field="idCard" header="身份证件号码" width="150" sortable="false"/>
		<next:Column field="sex" header="性别" width="60" dataset = "sexDataSet" sortable="false"/>
		<next:Column field="relationshipType" header="与户主关系" width="100" dataset="relationshipDataSet" sortable="false"/>
		<next:Column field="birthday" header="出生日期" width="90" sortable="false"/>
		<next:Column field="nation" header="民族" dataset ="NationDataset"  width="80" sortable="false"/>
		<next:Column field="eduCode" header="文化程度" width="90" dataset="educationDataSet" sortable="false"/>
		<next:Column field="politicalCode" header="政治面貌" width="90" dataset="politicalDataSet" sortable="false"/>
		<next:Column id="note" field="note" header="备注" width="100" sortable="false"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="familyMemberDataSet"/>
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>