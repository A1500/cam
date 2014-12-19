<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>农村社区建设规划填报</title>
<next:ScriptManager/>
<script type="text/javascript" src="vcdcPlanInfoEdit.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var recordId='<%=request.getParameter("recordId")%>';
	var userStatus = "vcdcPlanInfoEdit.jsp";
</script>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="planDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcPlanInfoQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcPlanInfo"/>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R18'/>
			<model:param name="organType" value='N'/>
		</model:params>
	</model:dataset>
	<!-- 行政区划 -->
	<model:dataset id="OrgCodeDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="false">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='COM_EXT_USER'></model:param>
			<model:param name="value" value='USER_ID'></model:param>
			<model:param name="text" value='AREA_CODE'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>
<next:Panel width="100%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="add" text="历史数据回填" id="backInsert" handler="forInsert"/>
	<next:ToolBarItem iconCls="save" text="保存" handler="save"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="planDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset1">
<legend>填报情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">填报单位：</td>
			<td class="FieldInput" style="width:36%"><label field="organName"/></td>
			<td class="FieldLabel" style="width:16%">填报日期：</td>
			<td class="FieldInput" style="width:30%"><select id="reportDate" field="reportDate"><option dataset="reportWorkDataSet"/></select><font color="red">*</font></td>
		</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset2">
<legend>社区建设规划情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">规划社区数量：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name = "规划社区数量"  id="planNum" field="planNum" maxlength="30" /></td>
			<td class="FieldLabel" style="width:16%">规划建设完成社区数量：</td>
			<td class="FieldInput" style="width:30%"><input type="text" name = "规划建设完成社区数量"  id="completeNum" field="completeNum" maxlength="30" /></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">本年度建设完成社区数量：</td>
			<td class="FieldInput" style="width:36%" colspan="3"><input type="text" name = "本年度建设完成社区数量"  id="yearCompleteNum" field="yearCompleteNum" maxlength="30" /></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:16%">附件</td>
			<td class="FieldInput" style="width:30%" colspan="3"><input  id="idFile" name="file" type="file"  style="width:60%"/> </td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>