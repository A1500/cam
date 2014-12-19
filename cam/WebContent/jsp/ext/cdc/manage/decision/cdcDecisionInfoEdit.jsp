<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>城市民主决策情况填报</title>
<next:ScriptManager/>
<script type="text/javascript" src="cdcDecisionInfoEdit.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var recordId='<%=request.getParameter("recordId")%>';
</script>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="decisionDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcDecisionReportQueryCmd" >
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcDecisionReport">
		</model:record>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R13'/>
			<model:param name="organType" value='C'/>
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
<form id="form1" method="post" dataset="decisionDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
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
<fieldset id="cdcFieldset">
<legend>民主决策情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">居民会议次数：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name = "居民会议次数"  id="meetingNum" field="meetingShouldNum" maxlength="30" onchange="forcheck(this)"/>&nbsp;次<font color="red">*</font></td>
			<td class="FieldLabel" style="width:16%">居民会议参加人数：</td>
			<td class="FieldInput" style="width:30%"><input type="text" name = "居民会议参加人数"  id="meetingPeopleNum" field="meetingRealNum" maxlength="30" onchange="forcheck(this)"/>&nbsp;人<font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">居民代表会议次数：</td>
			<td class="FieldInput" style="width:36%"><input type="text" name = "居民代表会议次数"  id="sovietNum" field="meetingAgreeNum" maxlength="30" onchange="forcheck(this)"/>&nbsp;次<font color="red">*</font></td>
			<td class="FieldLabel" style="width:16%">居民代表会议参加人数：</td>
			<td class="FieldInput" style="width:30%"><input type="text" name = "居民代表会议参加人数"  id="sovietPeopleNum" field="meetingUnagreeNum" maxlength="30" onchange="forcheck(this)"/>&nbsp;人<font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:30%;text-align:center;" colspan="4"><font color="red">*</font>填报内容为当前情况<font color="red">*</font></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>