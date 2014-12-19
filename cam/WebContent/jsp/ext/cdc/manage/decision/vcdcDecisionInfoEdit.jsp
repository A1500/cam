<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>农村民主决策情况填报</title>
<next:ScriptManager/>
<script type="text/javascript" src="vcdcDecisionInfoEdit.js"></script>
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
			<model:field name="meetingRealPer" type="string"/>
			<model:field name="meetingAgreePer" type="string"/>
			<model:field name="meetingUnagreePer" type="string"/>
			<model:field name="meetingGiveupPer" type="string"/>
			<model:field name="sovietRealPer" type="string"/>
			<model:field name="sovietAgreePer" type="string"/>
			<model:field name="sovietUnagreePer" type="string"/>
			<model:field name="sovietGiveupPer" type="string"/>
			<model:field name="sovietFemalePer" type="string"/>
			<model:field name="refRealPer" type="string"/>
			<model:field name="refAgreePer" type="string"/>
			<model:field name="refUnagreePer" type="string"/>
			<model:field name="refGiveupPer" type="string"/>
		</model:record>
	</model:dataset>
	<model:dataset id="infoDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcDecisionInfoQueryCmd" >
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcDecisionInfo"/>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R13'/>
			<model:param name="organType" value='N'/>
		</model:params>
	</model:dataset>
	<model:dataset id="meetingTypeDs" enumName="CDC.MEETING.TYPE" autoLoad="true" global="true"/>
</model:datasets>
<next:Panel width="100%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
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
<next:EditGridPanel id="grid" dataset="infoDataSet" width="100%" stripeRows="true" height="300">
	<next:TopBar>
		<next:ToolBarItem symbol="->"/>
		<next:ToolBarItem iconCls="add" text="增加村民会议" handler="insertCm"></next:ToolBarItem>
		<next:ToolBarItem iconCls="add" text="增加村民代表会议" handler="insertCmdb"></next:ToolBarItem>
		<next:ToolBarItem iconCls="add" text="增加村务公决" handler="insertCwgj"></next:ToolBarItem>
		<next:ToolBarItem iconCls="edit" text="修改" handler="update"></next:ToolBarItem>
		<next:ToolBarItem iconCls="delete" text="删除" handler="del"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="meetingType" header="类型" dataset ="meetingTypeDs" width="100" sortable="false"/>
		<next:Column field="meetingContent" header="主题内容" width="200" sortable="false"/>
		<next:Column field="shouldNum" header="应到人数" width="90" sortable="false"/>
		<next:Column field="realNum" header="实到人数" width="90" sortable="false"/>
		<next:Column field="agreeNum" header="同意人数" width="90" sortable="false"/>
		<next:Column field="unagreeNum" header="不同意人数" width="90" sortable="false"/>
		<next:Column field="giveupNum" header="弃权人数" width="90" sortable="false"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="infoDataSet"/>
	</next:BottomBar>
</next:EditGridPanel>
<fieldset id="cdcFieldset">
<legend>民主决策情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:12%">村民会议次数：</td>
			<td class="FieldInput" style="width:16%"><label id="meetingNum" field="meetingNum" renderer="cRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:12%">村民代表会议次数：</td>
			<td class="FieldInput" style="width:16%"><label id="meetingNum" field="sovietNum" renderer="cRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:12%">村民公决次数：</td>
			<td class="FieldInput" style="width:16%"><label id="meetingNum" field="refNum" renderer="cRender"/></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>

<next:Window id="cmWin" title="村民会议" resizable="false" width="700" height="250" modal="true" closable="false" autoScroll="true">
<next:Panel>
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="save" text="确定" handler="confirm"/>
	<next:ToolBarItem iconCls="delete" text="关闭" handler="closeCmWin"/>
</next:TopBar>
<next:Html>
<form id="form2" method="post" dataset="infoDataSet" onsubmit="return false" class="L5form">
	<fieldset id="cdcFieldset">
		<legend></legend>
		<table width="100%">
		<tr>
			<td class="FieldLabel">类型：</td>
			<td class="FieldInput" colspan="5"><label field="meetingType" dataset="meetingTypeDs"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">会议内容：</td>
			<td class="FieldInput" colspan="5"><input type="text" name="主题内容" id="meetingContent" field="meetingContent" style="width:90%"/><font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel">应到村民（户代表）人数：</td>
			<td class="FieldInput"><input type="text" name="应到村民（户代表）人数" id="shouldNum" field="shouldNum" onchange="forcheck(this)" maxlength="10" style="width:80%"/><font color="red">*</font></td>
			<td class="FieldLabel">实到村民（户代表）人数：</td>
			<td class="FieldInput"><input type="text" name="实到村民（户代表）人数" id="realNum" field="realNum" onchange="forcheck(this)" maxlength="10" style="width:80%"/><font color="red">*</font></td>
			<td class="FieldLabel"></td>
			<td class="FieldInput"></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">同意人数：</td>
			<td class="FieldInput" style="width:16%"><input type="text" name="同意人数" id="agreeNum" field="agreeNum" onchange="forcheck(this)" maxlength="10" style="width:80%"/><font color="red">*</font></td>
			<td class="FieldLabel" style="width:18%">不同意人数：</td>
			<td class="FieldInput" style="width:16%"><input type="text" name="不同意人数" id="unagreeNum" field="unagreeNum" onchange="forcheck(this)" maxlength="10" style="width:80%"/><font color="red">*</font></td>
			<td class="FieldLabel" style="width:18%">弃权人数：</td>
			<td class="FieldInput" style="width:16%"><input type="text" name="弃权人数" id="giveupNum" field="giveupNum" onchange="forcheck(this)" maxlength="10" style="width:80%"/><font color="red">*</font></td>
		</tr>
	</table>
	</fieldset>
</form>
</next:Html>
</next:Panel>
</next:Window>

<next:Window id="cmdbWin" title="村民代表会议" resizable="false" width="700" height="250" modal="true" closable="false" autoScroll="true">
<next:Panel>
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="save" text="确定" handler="confirm"/>
	<next:ToolBarItem iconCls="delete" text="关闭" handler="closeCmdbWin"/>
</next:TopBar>
<next:Html>
<form id="form2" method="post" dataset="infoDataSet" onsubmit="return false" class="L5form">
	<fieldset id="cdcFieldset">
		<legend></legend>
		<table width="100%">
		<tr>
			<td class="FieldLabel">类型：</td>
			<td class="FieldInput" colspan="5"><label field="meetingType" dataset="meetingTypeDs"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">会议内容：</td>
			<td class="FieldInput" colspan="5"><input type="text" name="会议内容" id="meetingContent" field="meetingContent" style="width:90%"/><font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel">应到村民代表组成人员人数：</td>
			<td class="FieldInput"><input type="text" name="应到村民代表组成人员人数" id="shouldNum" field="shouldNum" onchange="forcheck(this)" maxlength="10" style="width:80%"/><font color="red">*</font></td>
			<td class="FieldLabel">实到村民代表组成人员人数：</td>
			<td class="FieldInput"><input type="text" name="实到村民代表组成人员人数" id="realNum" field="realNum" onchange="forcheck(this)" maxlength="10" style="width:80%"/><font color="red">*</font></td>
			<td class="FieldLabel">妇女参加人数：</td>
			<td class="FieldInput"><input type="text" name="妇女参加人数" id="femaleNum" field="femaleNum" onchange="forcheck(this)" maxlength="10" style="width:80%"/><font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">同意人数：</td>
			<td class="FieldInput" style="width:16%"><input type="text" name="同意人数" id="agreeNum" field="agreeNum" onchange="forcheck(this)" maxlength="10" style="width:80%"/><font color="red">*</font></td>
			<td class="FieldLabel" style="width:18%">不同意人数：</td>
			<td class="FieldInput" style="width:16%"><input type="text" name="不同意人数" id="unagreeNum" field="unagreeNum" onchange="forcheck(this)" maxlength="10" style="width:80%"/><font color="red">*</font></td>
			<td class="FieldLabel" style="width:18%">弃权人数：</td>
			<td class="FieldInput" style="width:16%"><input type="text" name="弃权人数" id="giveupNum" field="giveupNum" onchange="forcheck(this)" maxlength="10" style="width:80%"/><font color="red">*</font></td>
		</tr>
	</table>
	</fieldset>
</form>
</next:Html>
</next:Panel>
</next:Window>

<next:Window id="cwgjWin" title="村务公决" resizable="false" width="700" height="250" modal="true" closable="false" autoScroll="true">
<next:Panel>
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="save" text="确定" handler="confirm"/>
	<next:ToolBarItem iconCls="delete" text="关闭" handler="closeCwgjWin"/>
</next:TopBar>
<next:Html>
<form id="form2" method="post" dataset="infoDataSet" onsubmit="return false" class="L5form">
	<fieldset id="cdcFieldset">
		<legend></legend>
		<table width="100%">
		<tr>
			<td class="FieldLabel">类型：</td>
			<td class="FieldInput" colspan="5"><label field="meetingType" dataset="meetingTypeDs"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">公决的内容：</td>
			<td class="FieldInput" colspan="3"><input type="text" name="公决的内容" id="meetingContent" field="meetingContent" style="width:90%"/><font color="red">*</font></td>
			<td class="FieldLabel">时间：</td>
			<td class="FieldInput"><input type="text" name="时间" id="meetingDate" field="meetingDate" onclick="LoushangDate(this)" format="Y-m-d" style="width:80%"/><font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel">实际户数：</td>
			<td class="FieldInput"><input type="text" name="实际户数" id="shouldNum" field="shouldNum" onchange="forcheck(this)" maxlength="10" style="width:80%"/><font color="red">*</font></td>
			<td class="FieldLabel">参加表决的户数：</td>
			<td class="FieldInput"><input type="text" name="参加表决的户数" id="realNum" field="realNum" onchange="forcheck(this)" maxlength="10" style="width:80%"/><font color="red">*</font></td>
			<td class="FieldLabel"></td>
			<td class="FieldInput"></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">同意户数：</td>
			<td class="FieldInput" style="width:16%"><input type="text" name="同意户数" id="agreeNum" field="agreeNum" onchange="forcheck(this)" maxlength="10" style="width:80%"/><font color="red">*</font></td>
			<td class="FieldLabel" style="width:18%">不同意户数：</td>
			<td class="FieldInput" style="width:16%"><input type="text" name="不同意户数" id="unagreeNum" field="unagreeNum" onchange="forcheck(this)" maxlength="10" style="width:80%"/><font color="red">*</font></td>
			<td class="FieldLabel" style="width:18%">弃权户数：</td>
			<td class="FieldInput" style="width:16%"><input type="text" name="弃权户数" id="giveupNum" field="giveupNum" onchange="forcheck(this)" maxlength="10" style="width:80%"/><font color="red">*</font></td>
		</tr>
	</table>
	</fieldset>
</form>
</next:Html>
</next:Panel>
</next:Window>