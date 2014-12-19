<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>社会组织信息表编辑</title>
<next:ScriptManager></next:ScriptManager>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
<script type="text/javascript" src="cdcOrganInfoEdit.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var organId='<%=request.getParameter("organId")%>';
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="cdcOrganInfoDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcOrganInfoQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcOrganInfo"/>
	</model:dataset>
	<model:dataset id="organTypeDataSet" enumName="CDC.ORGAN_KIND" autoLoad="true" global="true"/>
</model:datasets>
<next:Panel width="100%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="save" text="保存" handler="save"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="cdcOrganInfoDataSet" onsubmit="return false" class="L5form">
<fieldset>
	<legend>社区社会组织信息</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:10%">社会组织名称：</td>
			<td class="FieldInput" style="width:20%"><input type="text" name="社会组织名称" id="corpName" field="corpName" maxlength="200" style="width:80%"/><font color="red">*</font></td>
			<td class="FieldLabel" style="width:10%">组织机构代码：</td>
			<td class="FieldInput" style="width:20%"><input type="text" name="组织机构代码" id="organizationCode" field="organizationCode" maxlength="50" style="width:80%"/></td>
			<td class="FieldLabel" style="width:10%">社会组织性质：</td>
			<td class="FieldInput" style="width:20%"><select name="社会组织性质" id="organKind" field="organKind" style="width:80%"><option dataset = "organTypeDataSet"></option> </select><font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:10%">负责人姓名：</td>
			<td class="FieldInput" style="width:20%"><input type="text" name="负责人姓名" id="legalPeople" field="legalPeople" maxlength="50" style="width:80%"/><font color="red">*</font></td>
			<td class="FieldLabel" style="width:10%">联系电话：</td>
			<td class="FieldInput" style="width:20%"><input type="text" name="电话" id="organPhone" field="organPhone" onblur="forcheck(this)" maxlength="50" style="width:80%"/><font color="red">*</font></td>
			<td class="FieldLabel" style="width:10%">邮政编码：</td>
			<td class="FieldInput" style="width:20%"><input type="text" name="邮政编码" id="postCode" field="postCode" maxlength="6" onblur="forcheck(this)" style="width:80%"/><font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel">成员人数：</td>
			<td class="FieldInput"><input type="text" name="成员人数" field="memberNum" id="memberNum" maxlength="3" onblur="forcheck(this)" style="width:80%"/><font color="red">*</font></td>
			<td class="FieldLabel">办公场所数量：</td>
			<td class="FieldInput"><input type="text" name="办公场所数量" field="officialNum" id="officialNum" onblur="forcheck(this)" maxlength="5" style="width:80%"/><font color="red">*</font></td>
			<td class="FieldLabel">办公场所面积(㎡)：</td>
			<td class="FieldInput"><input type="text" name="办公场所面积" field="floorArea" id="floorArea" onblur="fordecimalcheck(this)" maxlength="6" style="width:80%" /><font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:10%">业务范围：</td>
			<td class="FieldInput" style="width:20%" colspan="5"><input type="text" name="业务范围" id="businessScope" field="businessScope" maxlength="50" style="width:57%"/><font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:10%">地址：</td>
			<td class="FieldInput" style="width:20%" colspan="5"><input type="text" name="地址" id="organAdds" field="organAdds" maxlength="50" style="width:57%"/><font color="red">*</font></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>