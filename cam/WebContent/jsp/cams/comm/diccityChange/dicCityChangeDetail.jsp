<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>行政区划变更明细</title>
<next:ScriptManager></next:ScriptManager>
<%
String organCode=BspUtil.getCorpOrgan().getOrganCode();
String organName=BspUtil.getCorpOrgan().getOrganName();
%>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var changeId='<%=request.getParameter("changeId")%>';
	var organCode='<%=organCode%>';
	var userName='<%=organName%>';
</script>
<script type="text/javascript" src="dicCityChange.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="dicCityChangeDataSet" cmd="com.inspur.cams.comm.diccityChange.cmd.DicCityChangeQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.comm.diccityChange.data.DicCityChange"/>
	</model:dataset>
	<!-- 变更类型 -->
	<model:dataset id="changeTypeDataset" enumName="COMM.CHANGE.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 代码级别 -->
	<model:dataset id="codeLeveDataset" enumName="COMM.CODE.LEVE" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel width="100%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="dicCityChangeDataSet" onsubmit="return false" class="L5form">
<fieldset>
	<legend>行政区划变更</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">变更类型：</td>
			<td class="FieldInput" style="width:36%" colspan="2"><label field="changeType" dataset="changeTypeDataset"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" rowspan="4" align="center" style="width:18%">变更前:</td>
			<td class="FieldLabel" style="width:10%">区划代码：</td>
			<td class="FieldInput" style="width:36%"><label field="preChangeCode"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:10%">区划名称：</td>
			<td class="FieldInput" style="width:36%"><label field="preChangeName"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:10%">上级区划代码：</td>
			<td class="FieldInput" style="width:36%"><label field="preUpsCode"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:10%">上级区划名称：</td>
			<td class="FieldInput" style="width:36%"><label field="preUpsName"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" rowspan="4" align="center" style="width:18%">变更后:</td>
			<td class="FieldLabel" style="width:10%">区划代码：</td>
			<td class="FieldInput" style="width:36%"><label field="postChangeCode"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:10%">区划名称：</td>
			<td class="FieldInput" style="width:36%"><label field="postChangeName"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:10%">上级区划代码：</td>
			<td class="FieldInput" style="width:36%"><label field="postUpsCode"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:10%">上级区划名称：</td>
			<td class="FieldInput" style="width:36%"><label field="postUpsName"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%" >类别：</td>
			<td class="FieldInput" style="width:36%" colspan="2"><label field="codeLeve" dataset="codeLeveDataset"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%" >请求日期：</td>
			<td class="FieldInput" style="width:36%" colspan="2"><label field="reqTime"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">序号：</td>
			<td class="FieldInput" style="width:36%" colspan="2"><label name="序号" id="serialNum" field="serialNum" style="width:90%" /></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">变更说明：</td>
			<td class="FieldInput" style="width:36%" colspan="2"><textarea  name="变更说明" id="remark" field="remark"  style="width:90%" disabled="disabled"></textarea></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>