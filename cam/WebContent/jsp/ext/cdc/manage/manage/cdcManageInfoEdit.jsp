<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>城市民主管理情况填报</title>
<next:ScriptManager/>
<script type="text/javascript" src="cdcManageInfoEdit.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var recordId='<%=request.getParameter("recordId")%>';
</script>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="manageReportDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcManageReportQueryCmd" >
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcManageReport"/>
	</model:dataset>
	<model:dataset id="manageDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcManageInfoQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcManageInfo"/>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R14'/>
			<model:param name="organType" value='C'/>
		</model:params>
	</model:dataset>
	<model:dataset id="YorN" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel width="100%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="add" text="历史数据回填" id="backInsert" handler="forInsert"/>
	<next:ToolBarItem iconCls="save" text="保存" handler="save"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form2" method="post" dataset="manageReportDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>填报情况</legend>
	<table width="100%">
		<tr>
			<tr>
			<td class="FieldLabel" style="width:18%">填报单位：</td>
			<td class="FieldInput" style="width:36%"><label field="organName"/></td>
			<td class="FieldLabel" style="width:16%">填报日期：</td>
			<td class="FieldInput" style="width:30%"><select id="reportDate" field="reportDate"><option dataset="reportWorkDataSet"/></select><font color="red">*</font></td>
		</tr>
	</table>
</fieldset>
</form>
<form id="form1" method="post" dataset="manageDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldsets">
<legend>民主管理情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">是否建立居民自治章程：</td>
			<td class="FieldInput" style="width:18%"><select id ="ifRule" field ="ifRule"><option dataset = "YorN"></option> </select><font color="red">*</font> </td>
			<td class="FieldLabel" style="width:16%">是否建立居民公约：</td>
			<td class="FieldInput" colspan="3"><select id ="ifPact" field ="ifPact"><option dataset = "YorN"></option> </select><font color="red">*</font> </td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>