<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<%@page import="com.inspur.cams.comm.util.DicUtil"%>
<%@page import="com.inspur.cams.drel.comm.SamConfig"%>
<html>
<%
	String applyId = request.getParameter("applyId");
%>
<head>
<title>城市低保复查信息页面</title>
<next:ScriptManager />
<script type="text/javascript">
	var applyId = '<%=applyId%>';
</script>

<script type="text/javascript" src="samApplyDetail.js"></script>

</head>
<body>
<model:datasets>
	<!-- 业务信息 -->
	<model:dataset id="applyDataSet" cmd="com.inspur.cams.drel.sam.cmd.SamApplyInfoQueryCmd" global="true"  >
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamApplyInfo">
		</model:record>
		<model:params>
			<model:param name="APPLY_ID" value='<%= applyId%>'></model:param>			
		</model:params>
	</model:dataset>
	<!-- 复查结果 -->
   	<model:dataset id="opinionDataSet" enumName="SAM.RECHECK.RESULT" autoLoad="true" global="true"></model:dataset>
	
</model:datasets>
<next:Panel  height="100%" autoScroll="true" id="tab">
		<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="undo" text="关闭" handler="returnBack"/>
			</next:TopBar>
	<next:Html>
<form id="form1" method="post" dataset="applyDataSet" onsubmit="return false" class="L5form">
<fieldset>
	<legend>复查信息</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:10%">户主：</td>
			<td class="FieldInput" style="width:20%"><label field="familyName"/></td>
			<td class="FieldLabel" style="width:10%">身份证号码：</td>
			<td class="FieldInput" style="width:20%"><label field="familyCardNo"/></td>
			<td class="FieldLabel" style="width:10%">申请日期</td>
			<td class="FieldInput" style="width:20%"><label field="applyDate"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:10%">审批意见：</td>
			<td class="FieldInput" style="width:20%"><label field="auditRemarks"/></td>
			<td class="FieldLabel" style="width:10%">审批结果：</td>
			<td class="FieldInput" style="width:20%"><label field="auditOpinionId" dataset="opinionDataSet"/></td>
			<td class="FieldLabel" style="width:10%">审批日期</td>
			<td class="FieldInput" style="width:20%"><label field="auditDate"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:10%">复查转变更原因：</td>
			<td class="FieldInput" style="width:20%" colspan="5"><label field="toChangeReason"/></td>
			
		</tr>
		<tr>
			<td class="FieldLabel" style="width: 10%">经办人</td>
			<td class="FieldInput" style="width: 10%"><label
				field="auditAgent"></label></td>
			<td class="FieldLabel" style="width: 10%">低保局负责人</td>
			<td class="FieldInput" style="width: 10%"><label
				field=" auditLowPrincipal"></label></td>
			<td class="FieldLabel" style="width: 10%">民政局负责人</td>
			<td class="FieldInput" style="width: 10%"><label
				field="auditPrincipal"></label></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>

</body>
</html>
