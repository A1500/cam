<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>�𻯼�¼��ѯ����明细</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="fisCremationExportBackup.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var recordId='<%=request.getParameter("recordId")%>';
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="fisCremationExportBackupDataSet" cmd="com.inspur.cams.fis.base.cmd.FisCremationExportBackupQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisCremationExportBackup"/>
	</model:dataset>
</model:datasets>
<next:Panel width="100%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="fisCremationExportBackupDataSet" onsubmit="return false" class="L5form">
<fieldset>
	<legend>�𻯼�¼��ѯ����</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">��¼����：</td>
			<td class="FieldInput" style="width:36%"><label field="recordId"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">������：</td>
			<td class="FieldInput" style="width:36%"><label field="exportName"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">���������：</td>
			<td class="FieldInput" style="width:36%"><label field="exportNum"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">����ʱ��：</td>
			<td class="FieldInput" style="width:36%"><label field="exportDate"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">��������：</td>
			<td class="FieldInput" style="width:36%"><label field="exportCondition"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">������λ����：</td>
			<td class="FieldInput" style="width:36%"><label field="exportOrgan"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">������λ���：</td>
			<td class="FieldInput" style="width:36%"><label field="exportOrganName"/></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>