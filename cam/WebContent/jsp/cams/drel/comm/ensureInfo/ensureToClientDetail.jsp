<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>核查业务反馈明细</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="ensureToClient.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var applyId='<%=request.getParameter("applyId")%>';
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="ensureToClientDataSet" cmd="com.inspur.cams.drel.ensureInfo.cmd.EnsureToClientQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.drel.ensureInfo.data.EnsureToClient"/>
	</model:dataset>
</model:datasets>
<next:Panel width="100%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="return" text="关闭" handler="closeWin"/>
	<next:ToolBarItem iconCls="detail" text="查看历史信息" handler="showHistory"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="ensureToClientDataSet" onsubmit="return false" class="L5form">
<fieldset>
	<legend>当前核查业务反馈信息</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">接收单位：</td>
			<td class="FieldInput" style="width:36%"><label field="acceptUnit"/></td>
			<td class="FieldLabel" style="width:18%">所属行政区划名称：</td>
			<td class="FieldInput" style="width:36%"><label field="areaName"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">户主姓名：</td>
			<td class="FieldInput" style="width:36%"><label field="familyName"/></td>
			<td class="FieldLabel" style="width:18%">户主身份证号：</td>
			<td class="FieldInput" style="width:36%"><label field="familyIdCard"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">核查单位：</td>
			<td class="FieldInput" style="width:36%"><label field="ensureUnit"/></td>
			<td class="FieldLabel" style="width:18%">核查收入：</td>
			<td class="FieldInput" style="width:36%"><label field="ensureIncome"/></td>
			
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">核查支出：</td>
			<td class="FieldInput" style="width:36%"><label field="ensureExpend"/></td>
			<td class="FieldLabel" style="width:18%">核查财产：</td>
			<td class="FieldInput" style="width:36%"><label field="ensureProperty"/></td>
			
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">反馈时间：</td>
			<td class="FieldInput" style="width:36%" colspan="3"><label field="feedbackTime"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">反馈结果：</td>
			<td class="FieldInput" style="width:36%" colspan="3"><label field="feedbackResult"/></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>