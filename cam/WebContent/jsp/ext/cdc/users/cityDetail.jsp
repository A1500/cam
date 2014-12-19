<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.extuser.util.ExtBspInfo"%>
<html>
<head>
<title>农村社区管理</title>
<next:ScriptManager/>
<%
	String organName = ExtBspInfo.getUserInfo(request).getUserName();
	String organId= ExtBspInfo.getUserInfo(request).getUserId();
	//String peopleArea= ExtBspInfo.getUserInfo(request).getAreaCode();
%>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var organId='<%=organId%>';
	var userId='<%=request.getParameter("userId")%>';
	var organName='<%=organName%>';
	var type = '<%=request.getParameter("type")%>';
	var myDate = new Date();
	var mytime=myDate.toLocaleTimeString();
	function init(){
		var ds=L5.DatasetMgr.lookup("ds");
		ds.setParameter("USER_ID@=",userId);
		ds.load();
	}
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.comm.extuser.cmd.ComExtUserQueryCmd">
		<model:record fromBean="com.inspur.cams.comm.extuser.data.ComExtUser"/>
	</model:dataset>
</model:datasets>
<next:Panel width="100%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="ds" onsubmit="return false" class="L5form">
	<fieldset>
	<legend>城市社区</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:25%">社区账号：</td>
			<td class="FieldInput" style="width:25%" ><label type="text"  id="userId" field="userId" maxLength="12" /></td>
			<td class="FieldLabel" style="width:25%">社区名称：</td>
			<td class="FieldInput" style="width:25%" ><label type="text"  id="userName" field="userName" /></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:25%">区划代码：</td>
			<td class="FieldInput" style="width:25%" ><label type="text"  id="areaCode" field="areaCode" maxLength="12" /></td>
			<td class="FieldLabel" style="width:25%">区划名称：</td>
			<td class="FieldInput" style="width:25%" ><label type="text"  id="areaName" field="areaName" /></td>
		</tr>
	</table>
	</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>