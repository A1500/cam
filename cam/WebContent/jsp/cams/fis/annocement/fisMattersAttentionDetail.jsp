<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>查看通知明细</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src="fisMattersAttentionDetail.js"></script>
<script>
	var attentionId='<%=request.getParameter("attentionId")%>';
	var method='<%=request.getParameter("method")%>';
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
    <model:dataset id="type" enumName="Inform.Type" autoLoad="true" global="false"></model:dataset>
	<model:dataset id="attentionType" enumName="FIS.MATTERS.ATTENTION.TYPE" autoLoad="true" global="false"></model:dataset>
	<model:dataset id="fisMattersAttention" cmd="com.inspur.cams.fis.base.cmd.FisMattersAttentionQueryCmd" global="true" autoLoad="true" pageSize="20">
	    <model:record fromBean="com.inspur.cams.fis.base.data.FisMattersAttention"></model:record>
	</model:dataset>
</model:datasets>
<next:Panel title="查看通知" collapsible="false">
	<next:TopBar>
	<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="undo" text="返回" handler="click_back"></next:ToolBarItem>
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
				<td class="FieldLabel">紧急程度：</td>
				<td><input type="text" id="emergencyDegree" size="170" class="inputClass"
					readonly="readonly"></td>
			</tr>
			<tr>
				<td class="FieldLabel">面向单位：</td>
				<td><input type="text" id="sendmanid" size="170" class="inputClass"
					readonly="readonly"></td>
			</tr>
            <tr>
                <td class="FieldLabel">通知时间：</td>
                <td><input type ="text" id="attentionTime" size="170" class="inpuutClass" readonly="readonly"></input></td>
            </tr>
			<tr>
				<td class="FieldLabel">内&nbsp;&nbsp;容：</td>
				<td>

					<div id="content" style="WIDTH: 800px; HEIGHT: 200px;  OVERFLOW: scroll;">

                </div>

				</td>
			</tr>

		</table>
		</form>
	</next:Html>
</next:Panel>
</body>
</html>