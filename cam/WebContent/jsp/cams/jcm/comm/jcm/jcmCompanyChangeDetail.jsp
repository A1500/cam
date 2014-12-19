<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>单位信息调整(多条记录过程)明细</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="jcmCompanyChange.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var companyChangeId='<%=request.getParameter("companyChangeId")%>';
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="jcmCompanyChangeDataSet" cmd="com.inspur.cams.jcm.cmd.JcmCompanyChangeQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.jcm.data.JcmCompanyChange"/>
	</model:dataset>
</model:datasets>
<next:Panel width="100%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="jcmCompanyChangeDataSet" onsubmit="return false" class="L5form">
<fieldset>
	<legend>单位信息调整(多条记录过程)</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">变更ID：</td>
			<td class="FieldInput" style="width:36%"><label field="companyChangeId"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">单位主键：</td>
			<td class="FieldInput" style="width:36%"><label field="companyId"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">时间：</td>
			<td class="FieldInput" style="width:36%"><label field="companyChangeTime"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">内容：</td>
			<td class="FieldInput" style="width:36%"><label field="companyChangeContext"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">文号：</td>
			<td class="FieldInput" style="width:36%"><label field="companyChangeNum"/></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>