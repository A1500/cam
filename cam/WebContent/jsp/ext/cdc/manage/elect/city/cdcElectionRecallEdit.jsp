<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<script type="text/javascript">
</script>
<title>城市民主居委会成员罢免情况信息</title>
<next:ScriptManager/>
<script type="text/javascript">
	var reportTime='<%=request.getParameter("reportTime")%>';
	var recordId='<%=request.getParameter("recordId")%>';
</script>
<script type="text/javascript" src="cdcElectionRecallEdit.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<jsp:include page="../../util/cdcOrgan.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="electionVoteDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcElectionVoteQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcElectionVote"/>
	</model:dataset>
	<model:dataset id="electionVote2DataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcElectionVoteQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcElectionVote"/>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R11'/>
			<model:param name="organType" value='C'/>
		</model:params>
	</model:dataset>
	<model:dataset id="YorN" enumName="COMM.YESORNO" autoLoad="true" global="true" />
	<model:dataset id="statusDataSet" enumName="CDC.STATUS" autoLoad="true" global="true"/>
</model:datasets>
<next:Panel width="99%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="add" text="历史数据回填" id="backInsert" handler="forInsert"/>
	<next:ToolBarItem iconCls="save" text="保存" handler="save"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="electionVoteDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>填报情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">填报单位：</td>
			<td class="FieldInput" style="width:27%"><label field="organName"/></td>
			<td class="FieldLabel" style="width:13%">填报日期：</td>
			<td class="FieldInput" style="width:42%"><label id="reportDate" field="reportDate" dataset="reportWorkDataSet"/></td>
		</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>居委会成员罢免情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">罢免主任人数：</td>
			<td class="FieldInput" style="width:18%"><input type="text" name = "罢免主任人数" onchange="forcheck(this)" id="dismissHeadNum" field ="dismissHeadNum"   maxlength="30" onchange="forcheck(this)"/>&nbsp;人 <font color="red">*</font></td>
			<td class="FieldLabel" style="width:16%">罢免副主任主任人数：</td>
			<td class="FieldInput" style="width:16%"><input type="text" name = "罢免副主任主任人数" onchange="forcheck(this)" id="dismissSheadNum" field ="dismissSheadNum"   maxlength="30" onchange="forcheck(this)"/>&nbsp;人 <font color="red">*</font></td>
		</tr>
		<tr>	
			<td class="FieldLabel" style="width:16%">罢免委员人数：</td>
			<td class="FieldInput" colspan="3" style="width:16%"><input type="text" name = "罢免委员人数" onchange="forcheck(this)" id="dismissMemberNum" field ="dismissMemberNum"   maxlength="30" onchange="forcheck(this)"/>&nbsp;人 <font color="red">*</font></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>