<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>查看通知明细</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="viewinform.js"></script>
<script>
	var queryid='<%=request.getParameter("queryid")%>';
	var page='<%=request.getParameter("page")%>';
</script>
</head>
<style type="text/css">
	.labelClass{
		width: 300px;
		white-space:nowrap;
	}
	.inputClass{
		background:#F6F9FF;
		border:0px;
		white-space:nowrap;
	}
</style>
<body>
<model:datasets>
	<model:dataset id="type" enumName="Inform.Type" global="true"></model:dataset>
	<model:dataset id="organ" cmd="com.inspur.cams.comm.informUtil.InformPubOrganQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.comm.informUtil.InformPubOrganDao">
		    <model:field name="value" mapping="organCode"/>
			<model:field name="text" mapping="shortName"/>
		</model:record>
	</model:dataset>
</model:datasets>
<next:Panel title="查看通知" collapsible="false">
	<next:TopBar>
	<next:ToolBarItem symbol="->" ></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form id="form1" method="post" onsubmit="return false" class="L5form">
		<table id="table1">
			<tr>
				<td class="FieldLabel">标&nbsp;&nbsp;题：</td>
				<td><input type="text" id="title" size="170" class="inputClass"
					readonly="readonly"></td>
			</tr>
			<tr>
				<td class="FieldLabel">类&nbsp;&nbsp;型：</td>
				<td><input type="text" id="informtype" size="170" class="inputClass"
					readonly="readonly"></td>
			</tr>
			<tr>
				<td class="FieldLabel">发送单位：</td>
				<td><input type="text" id="sendman" size="170" class="inputClass"
					readonly="readonly"></td>
			</tr>
			<tr>
				<td class="FieldLabel">发送人：</td>
				<td><input type="text" id="sendmanid" size="170" class="inputClass"
					readonly="readonly"></td>
			</tr>

			<tr>
				<td class="FieldLabel">内&nbsp;&nbsp;容：</td>
				<td>

					<div id="content" style="WIDTH: 800px; HEIGHT: 200px;  OVERFLOW: scroll;">

                </div>

				</td>
			</tr>
			<tr>
				<td class="FieldLabel">接收部门：</td>
				<td><textarea id="receiveman" name="receiveman" rows="3"
					cols="170" class="inputClass" readonly="readonly" ></textarea></td>
			</tr>
			<tr>
				<td class="FieldLabel">附&nbsp;&nbsp;&nbsp;件：</td>
				<td>
				<div id="filename"></div>
				</td>
			</tr>
		</table>
		</form>
	</next:Html>
</next:Panel>
</body>
</html>