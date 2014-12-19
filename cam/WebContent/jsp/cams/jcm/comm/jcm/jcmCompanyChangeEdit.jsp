<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>单位信息调整(多条记录过程)编辑</title>
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
	<next:ToolBarItem iconCls="save" text="保存" handler="save"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="jcmCompanyChangeDataSet" onsubmit="return false" class="L5form">
<fieldset>
	<legend>单位信息调整(多条记录过程)</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">变更ID：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="变更ID" id="companyChangeId" field="companyChangeId" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">单位主键：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="单位主键" id="companyId" field="companyId" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">时间：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="时间" id="companyChangeTime" field="companyChangeTime" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">内容：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="内容" id="companyChangeContext" field="companyChangeContext" maxlength="50" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">文号：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="文号" id="companyChangeNum" field="companyChangeNum" maxlength="50" style="width:90%"/></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>