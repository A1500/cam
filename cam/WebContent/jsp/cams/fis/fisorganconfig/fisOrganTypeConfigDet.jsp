<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>馆墓一体配置明细</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src="fisOrganTypeConfig.js"></script>
<script>
	var configIdDet='<%=request.getParameter("configIdDet")%>';
	var method='<%=request.getParameter("method")%>';
</script>
</head>
<style type="text/css">
	.labelClass{
		width: 100%;
		white-space:nowrap;
	}
	.inputClass{
		background:#F6F9FF;
		border:3px;
		white-space:nowrap;
	}
</style>
<body>
<model:datasets>
	<model:dataset id="fisOrganTypeConfig" cmd="com.inspur.cams.fis.base.cmd.FisOrganTypeConfigQueryCmd"  global="true" autoLoad="true" pageSize="10">
	    <model:record fromBean="com.inspur.cams.fis.base.data.FisOrganTypeConfig"></model:record>
	</model:dataset>
</model:datasets>

<next:Panel title="查看明细" collapsible="false">
	<next:TopBar>
	<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="undo" text="返回" handler="click_back"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form id="form1" method="post" onsubmit="return false" class="L5form">
		<table id="table1">
			<tr>
				<td class="FieldLabel">殡仪馆编号：</td>
				<td><input type="text" id="funeralOrgan" size="170" class="inputClass"
					readonly="readonly"></td>
				<td class="FieldLabel">殡仪馆名称：</td>
				<td><input type="text" id="funeralOrganName" size="170" class="inputClass"
					readonly="readonly"></td>
			</tr>
			<tr>
				<td class="FieldLabel">公墓编号：</td>
				<td><input type="text" id="cemeteryOrgan" size="170" class="inputClass"
					readonly="readonly"></td>
				<td class="FieldLabel">公墓名称：</td>
				<td><input type="text" id="cemeteryOrganName" size="170" class="inputClass"
					readonly="readonly"></td>
			</tr>
            <tr>
                <td class="FieldLabel">配置时间：</td>
                <td><input type ="text" id="configTime" size="170" class="inputClass" readonly="readonly"></input></td>
                <td class="FieldLabel"></td>
				<td><label></label></td>
            </tr>

		</table>
		</form>
	</next:Html>
</next:Panel>
</body>
</html>