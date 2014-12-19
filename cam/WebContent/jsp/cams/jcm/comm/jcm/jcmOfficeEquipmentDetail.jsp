<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>办公设备信息明细</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="jcmOfficeEquipment.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var officeId='<%=request.getParameter("officeId")%>';
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="jcmOfficeEquipmentDataSet" cmd="com.inspur.cams.jcm.cmd.JcmOfficeEquipmentQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.jcm.data.JcmOfficeEquipment"/>
	</model:dataset>
</model:datasets>
<next:Panel width="100%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="jcmOfficeEquipmentDataSet" onsubmit="return false" class="L5form">
<fieldset>
	<legend>办公设备信息</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">主键：</td>
			<td class="FieldInput" style="width:36%"><label field="officeId"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">单位主键：</td>
			<td class="FieldInput" style="width:36%"><label field="companyId"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">设备类型：</td>
			<td class="FieldInput" style="width:36%"><label field="deviceType"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">设备个数：</td>
			<td class="FieldInput" style="width:36%"><label field="deviceNum"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">购买年份：</td>
			<td class="FieldInput" style="width:36%"><label field="buyYear"/></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>