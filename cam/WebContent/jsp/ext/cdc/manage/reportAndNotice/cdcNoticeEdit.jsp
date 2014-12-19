<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<script type="text/javascript">
</script>
<title>通知通告信息</title>
<next:ScriptManager/>
<script type="text/javascript">
	var noticeId='<%=request.getParameter("noticeId")%>';
	var method='<%=request.getParameter("method")%>';
</script>
<script type="text/javascript" src="cdcNoticeEdit.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="cdcNoticeDataset" cmd="com.inspur.cams.cdc.base.cmd.CdcNoticeInfoQueryCmd" method="query" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcNoticeInfo"/>
	</model:dataset>
	<model:dataset id="targetToDataSet" enumName="CDC.NOTICE.TAREGARTTO" autoLoad="false" global="true"/>
	
</model:datasets>
<next:Panel width="99%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="save" text="保存" handler="save"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="cdcNoticeDataset" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>填报单位</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:15%">发布单位：</td>
			<td class="FieldInput" ><label field="organName"/></td>
		</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>填报内容</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width: 10%">主题：</td>
			<td class="FieldInput" style="width: 30%"><input style="width: 80%"  type="text" id="name" field="name"/><font color="red">*</font>
			</td>
			<td class="FieldLabel" style="width: 10%">下发至:</td>
			<td class="FieldInput" style="width: 30%"> <select id = "targetTo" field="targetTo">
				<option dataset = "targetToDataSet"></option> </select> 
				<font color="red">*</font>
			</td>
		</tr>
		<tr>
			<td class="FieldLabel">内容:</td>
			<td class="FieldInput" colspan="3"><textarea id="content"  field="content" style="width: 90%" rows="10" cols="100"></textarea>
			</td>
		</tr>
			<tr>
			
		</tr>
		<tr>
			<td class="FieldLabel">附件：</td>
			<td class="FieldInput" colspan="3"><input id="idFile" name="file" type="file" style="width:30%"/></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>