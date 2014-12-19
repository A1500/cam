<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>上报期数管理</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="camsReportWork.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var workId='<%=request.getParameter("workId")%>';
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.comm.brief.cmd.CamsReportWorkQueryCommand" pageSize="20">
		<model:record fromBean="com.inspur.cams.comm.brief.data.CamsReportWork"/>
	</model:dataset>
</model:datasets>
<next:Panel width="100%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="save" text="保存" handler="save"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="reportWorkDataSet" onsubmit="return false" class="L5form">
	<input type="hidden" id="workId" field="workId"/>
<fieldset>
	<legend>上报年度管理</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">上报期数描述：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name="上报年度描述" id="workDesc" field="workDesc" maxlength="50" style="width:40%"/><font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel">上报年份选择：</td>
			<td class="FieldInput"><input type="text" name="上报年度描述" id="workYear" field="workYear" maxlength="4" style="width:40%"/><font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel">上报季度选择：</td>
			<td class="FieldInput"><select id="workQuarter" field="workQuarter">
											<option value="">请选择...</option>
											<option value="1">一</option>
											<option value="2">二</option>
											<option value="3">三</option>
											<option value="4">四</option>
											<option value="5">全年</option>
								  </select><font color="red">*</font></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>