<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>特殊困难帮扶单位信息表编辑</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="specialpoorSupportUnit.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var supportUnitCode='<%=request.getParameter("supportUnitCode")%>';
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="specialpoorSupportUnitDataSet" cmd="com.inspur.cams.drel.special.cmd.SpecialpoorSupportUnitQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.drel.special.data.SpecialpoorSupportUnit"/>
	</model:dataset>
</model:datasets>
<next:Panel width="100%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="save" text="保存" handler="save"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="specialpoorSupportUnitDataSet" onsubmit="return false" class="L5form">
<fieldset>
	<legend>特殊困难帮扶单位信息表</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">帮扶单位代码：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="帮扶单位代码" id="supportUnitCode" field="supportUnitCode" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">帮扶单位名称：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="帮扶单位名称" id="supportUnitName" field="supportUnitName" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">单位类型代码：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="单位类型代码" id="supportUnitTypeCode" field="supportUnitTypeCode" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">单位类型名称：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="单位类型名称" id="supportUnitTypeName" field="supportUnitTypeName" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">顺序号：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="顺序号" id="supportUnitSn" field="supportUnitSn" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">帮扶区县代码：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="帮扶区县代码" id="supportCountyCode" field="supportCountyCode" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">帮扶区县名称：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="帮扶区县名称" id="supportCountyName" field="supportCountyName" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">帮扶镇级代码：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="帮扶镇级代码" id="supportTownCode" field="supportTownCode" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">帮扶镇级名称：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="帮扶镇级名称" id="supportTownName" field="supportTownName" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">帮扶村代码：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="帮扶村代码" id="supportVillageCode" field="supportVillageCode" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">帮扶村名称：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="帮扶村名称" id="supportVillageName" field="supportVillageName" maxlength="50" style="width:90%"/></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>