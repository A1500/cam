<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<script type="text/javascript">
</script>
<title>村务监督委员会情况</title>
<next:ScriptManager/>
<script type="text/javascript">
	var reportTime='<%=request.getParameter("reportTime")%>';
	var recordId='<%=request.getParameter("recordId")%>';
	var organ_Code='<%=request.getParameter("organ_Code")%>';
</script>
<script type="text/javascript" src="cdcElectionSupEdit.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<jsp:include page="../../util/cdcOrgan.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="supDs" cmd="com.inspur.cams.cdc.base.cmd.CdcElectionSupQueryCmd" pageSize="1">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcElectionSup">
			<model:field name="recallPer" type="string"/>
			<model:field name="rePer" type="string"/>
			<model:field name="reSovietPer" type="string"/>
		</model:record>
	</model:dataset>
	<model:dataset id="peopleDs" cmd="com.inspur.cams.cdc.base.cmd.CdcElectionMemberQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcElectionMember"/>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R11'/>
			<model:param name="organType" value='N'/>
		</model:params>
	</model:dataset>
	<!-- 民族 -->
	<model:dataset id="NationDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="OrgNameDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="false">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='COM_EXT_USER'></model:param>
			<model:param name="value" value='USER_ID'></model:param>
			<model:param name="text" value='USER_NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="statusDataSet" enumName="CDC.STATUS" autoLoad="true" global="true"/>
	<model:dataset id="YorN" enumName="COMM.YESORNO" autoLoad="true" global="true" />
	<model:dataset id="sexDataSet" enumName="COMM.SEX" autoLoad="true" global="true"/>
	<model:dataset id="politicalDataSet" enumName="CDC.POLITICAL" autoLoad="true" global="true"/>
	<model:dataset id="educationDataSet" enumName="CDC.EDUCATION" autoLoad="true" global="true"/>
	<model:dataset id="dutyDs" enumName="CDC.DUTY.TYPE" autoLoad="true" global="true"/>
	<model:dataset id="supMannerDs" enumName="CDC.SUP_MANNER" autoLoad="true" global="true"/>
	<model:dataset id="reReasonDs" enumName="CDC.RE_REASON" autoLoad="true" global="true"/>
	<model:dataset id="reSituationDs" enumName="CDC.RE_SITUATION" autoLoad="true" global="true"/>
</model:datasets>
<next:Panel width="99%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="save" text="保存" handler="save"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="supDs" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>村务监督委员会情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel"  style="width:18%">填报单位：</td>
			<td class="FieldInput"  style="width:14%"><label field="organName"/></td>
			<td class="FieldLabel"  style="width:21%">填报日期：</td>
			<td class="FieldInput" ><label id="reportDate" field="reportDate" dataset="reportWorkDataSet"/></td>
		</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>村务监督委员会情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">村务监督委员会成员数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" title ="村务监督委员会成员数为3-5人!" name="村务监督委员会成员数" id="supMbNum" field="supMbNum" onchange="forcheck(this)"  maxlength="30" style="width:80%"/>&nbsp;人<font color="red">*</font></td>
			<td class="FieldLabel" style="width:18%">产生方式：</td>
			<td class="FieldInput" colspan="3"><select name="产生方式" id="supManner" field="supManner" onchange="getSupManner()"><option dataset="supMannerDs"></option></select><font color="red">*</font></td>
		</tr>
		<tr id="cm1" style="display:none">
			<td class="FieldLabel">登记参加选举的村民（户代表）总数：</td>
			<td class="FieldInput"><input type="text" name="登记参加选举的村民（户代表）总数" id="meetingNum" field="meetingNum" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人<font color="red">*</font></td>
			<td class="FieldLabel">实际参加推选人数：</td>
			<td class="FieldInput" colspan="3"><input type="text" name="实际参加推选人数" id="meetingActNum" field="meetingActNum" onchange="forcheck(this)" maxlength="30"/>&nbsp;人<font color="red">*</font></td>
		</tr>
		<tr id="cm2" style="display:none">
			<td class="FieldLabel" style="width:18%">同意人数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name="同意人数" id="meetingAgreeNum" field="meetingAgreeNum" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人<font color="red">*</font></td>
			<td class="FieldLabel" style="width:18%">不同意人数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name="不同意人数" id="meetingUnagreeNum" field="meetingUnagreeNum" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人<font color="red">*</font></td>
			<td class="FieldLabel" style="width:18%">弃权人数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name="弃权人数" id="meetingGiveupNum" field="meetingGiveupNum" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人<font color="red">*</font></td>
		</tr>
		<tr id="cmdb1" style="display:none">
			<td class="FieldLabel">村民代表会议组成人数：</td>
			<td class="FieldInput"><input type="text" name="村民代表会议组成人数" id="sovietNum" field="sovietNum" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人<font color="red">*</font></td>
			<td class="FieldLabel">实际参加推选人数：</td>
			<td class="FieldInput" colspan="3"><input type="text" name="实际参加推选人数" id="sovietActNum" field="sovietActNum" onchange="forcheck(this)" maxlength="30"/>&nbsp;人<font color="red">*</font></td>
		</tr>
		<tr id="cmdb2" style="display:none">
			<td class="FieldLabel" style="width:18%">同意人数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name="同意人数" id="sovietAgreeNum" field="sovietAgreeNum" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人<font color="red">*</font></td>
			<td class="FieldLabel" style="width:18%">不同意人数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name="不同意人数" id="sovietUnagreeNum" field="sovietUnagreeNum" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人<font color="red">*</font></td>
			<td class="FieldLabel" style="width:18%">弃权人数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name="弃权人数" id="sovietGiveupNum" field="sovietGiveupNum" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人<font color="red">*</font></td>
		</tr>
	</table>
</fieldset>

<fieldset id="cdcFieldset">
<legend>罢免村委会成员情况</legend>

<fieldset id="cdcFieldset">
<legend>村民代表或村民联名情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel">被罢免人职务：</td>
			<td class="FieldInput" colspan="5"><select name="被罢免人职务" id="recallDuty" field="recallDuty"><option dataset="dutyDs"></option></select></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">登记参加选举的村民总数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name="登记参加选举的村民总数" id="recallVoteNum" field="recallVoteNum" onchange="forcheck(this);getPer();" maxlength="30" style="width:80%"/>&nbsp;人</td>
			<td class="FieldLabel" style="width:18%">女性人数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name="女性人数" id="recallFemaleNum" field="recallFemaleNum" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人</td>
			<td class="FieldLabel" style="width:18%">少数民族人数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name="少数民族人数" id="recallFolkNum" field="recallFolkNum" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人</td>
		</tr>
		<tr>
			<td class="FieldLabel">委托投票人数：</td>
			<td class="FieldInput"><input type="text" name="委托投票人数" id="recallEntrustNum" field="recallEntrustNum" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人</td>
			<td class="FieldLabel">使用流动票箱投票人数：</td>
			<td class="FieldInput"><input type="text" name="使用流动票箱投票人数" id="recallFlowNum" field="recallFlowNum" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人</td>
			<td class="FieldLabel">代写选票人数：</td>
			<td class="FieldInput"><input type="text" name="代写选票人数" id="recallReplaceNum" field="recallReplaceNum" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人</td>
		</tr>
		<tr>
			<td class="FieldLabel">参加罢免大会投票的选民数：</td>
			<td class="FieldInput"><input type="text" name="参加罢免大会投票的选民数" id="recallNum" field="recallNum" onchange="forcheck(this);getPer();" maxlength="30" style="width:80%"/>&nbsp;人</td>
			<td class="FieldLabel">占登记参加选举的村民总数的百分比：</td>
			<td class="FieldInput" colspan="3"><label field="recallPer" renderer="pRender"/></td>
		</tr>
	</table>
</fieldset>

<fieldset id="cdcFieldset">
<legend>罢免表决情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">设立分会场数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name="设立分会场数" id="recallSubNum" field="recallSubNum" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;个</td>
			<td class="FieldLabel" style="width:18%">投票箱总数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name="投票箱总数" id="recallBoxNum" field="recallBoxNum" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;个</td>
			<td class="FieldLabel" style="width:18%">实际参加投票罢免会议的村民总数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name="实际参加投票罢免会议的村民总数" id="recallMeetingNum" field="recallMeetingNum" onchange="forcheck(this)" maxlength="30"/>&nbsp;人</td>
		</tr>
		<tr>
			<td class="FieldLabel">同意罢免村民数：</td>
			<td class="FieldInput"><input type="text" name="同意罢免村民数" id="recallAgreeNum" field="recallAgreeNum" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人</td>
			<td class="FieldLabel">不同意罢免村民数：</td>
			<td class="FieldInput"><input type="text" name="不同意罢免村民数" id="recallUnagreeNum" field="recallUnagreeNum" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人</td>
			<td class="FieldLabel">罢免是否成功：</td>
			<td class="FieldInput"><select name="罢免是否成功" id="recallSuccess" field="recallSuccess"><option dataset="YorN"></option></select></td>
		</tr>
	</table>
</fieldset>

<fieldset id="cdcFieldset">
<legend>补选情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel">补选原因：</td>
			<td class="FieldInput"><select name="补选原因" id="reReason" field="reReason"><option dataset="reReasonDs"></option></select></td>
			<td class="FieldLabel">补选方式：</td>
			<td class="FieldInput" colspan="3"><select name="补选方式" id="reSituation" field="reSituation" onchange="getResituation()"><option dataset="reSituationDs"></option></select></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">补选的村委会成员职务<br>（主任）职数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name="补选的村委会成员职务（主任）职数" id="reDirNum" field="reDirNum" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人</td>
			<td class="FieldLabel" style="width:18%">补选的村委会成员职务<br>（副主任）职数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name="补选的村委会成员职务（副主任）职数" id="reComNum" field="reComNum" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人</td>
			<td class="FieldLabel" style="width:18%">补选的村委会成员职务<br>（委员）职数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name="补选的村委会成员职务（委员）职数" id="reRedNum" field="reRedNum" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人</td>
		</tr>
		<tr id="recm1" style="display:none">
			<td class="FieldLabel" style="width:18%">登记参加选举的村民<br>总数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name="登记参加选举的村民总数" id="reMeetingNum" field="reMeetingNum" onchange="forcheck(this);getPer();" maxlength="30" style="width:80%"/>&nbsp;人</td>
			<td class="FieldLabel" style="width:18%">女性人数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name="女性人数" id="reMeetingFemaleNum" field="reMeetingFemaleNum" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人</td>
			<td class="FieldLabel" style="width:18%">少数民族人数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name="少数民族人数" id="reMeetingFolkNum" field="reMeetingFolkNum" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人</td>
		</tr>
		<tr id="recm2" style="display:none">
			<td class="FieldLabel" style="width:18%">委托投票人数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name="委托投票人数" id="reEntrustNum" field="reEntrustNum" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人</td>
			<td class="FieldLabel" style="width:18%">使用流动票箱投票人数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name="使用流动票箱投票人数" id="reFlowNum" field="reFlowNum" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人</td>
			<td class="FieldLabel" style="width:18%">代写选票人数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name="代写选票人数" id="reReplaceNum" field="reReplaceNum" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人</td>
		</tr>
		<tr id="recm3" style="display:none">
			<td class="FieldLabel">实际参加投票的<br>村民总数：</td>
			<td class="FieldInput"><input type="text" name="实际参加投票的村民总数" id="reActNum" field="reActNum" onchange="forcheck(this);getPer();" maxlength="30" style="width:80%"/>&nbsp;人</td>
			<td class="FieldLabel">占登记参加选举的村民<br>总数的百分比：</td>
			<td class="FieldInput" colspan="3"><label field="rePer" renderer="pRender"/></td>
		</tr>
		<tr id="recmdb1" style="display:none">
			<td class="FieldLabel" style="width:18%">村民代表总数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name="村民代表总数" id="reSovietNum" field="reSovietNum" onchange="forcheck(this);getPer();" maxlength="30" style="width:80%"/>&nbsp;人</td>
			<td class="FieldLabel" style="width:18%">女性人数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name="女性人数" id="reSovietFemaleNum" field="reSovietFemaleNum" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人</td>
			<td class="FieldLabel" style="width:18%">少数民族人数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name="少数民族人数" id="reSovietFolkNum" field="reSovietFolkNum" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人</td>
		</tr>
		<tr id="recmdb2" style="display:none">
			<td class="FieldLabel">参加村民代表会议<br>的村民代表人数：</td>
			<td class="FieldInput"><input type="text" name="参加村民代表会议的村民代表人数" id="reSovietJoinNum" field="reSovietJoinNum" onchange="forcheck(this);getPer();" maxlength="30" style="width:80%"/>&nbsp;人</td>
			<td class="FieldLabel">占村民代表会议组成<br>人员的百分比：</td>
			<td class="FieldInput" colspan="3"><label field="reSovietPer" renderer="pRender"/></td>
		</tr>
	</table>
</fieldset>
</fieldset>
</form>
</next:Html>
<next:BottomBar >
		<next:ToolBarItem symbol="->"/>
		<next:ToolBarItem iconCls="save" text="保存" handler="save"></next:ToolBarItem>
	</next:BottomBar>
</next:Panel>

<next:EditGridPanel id="grid" title="补选成员情况" dataset="peopleDs" width="99%" stripeRows="true" height="300">
	<next:TopBar>
		<next:ToolBarItem symbol="->"/>
		<next:ToolBarItem iconCls="add" text="增加" handler="insert"></next:ToolBarItem>
		<next:ToolBarItem iconCls="edit" text="修改" handler="update"></next:ToolBarItem>
		<next:ToolBarItem iconCls="delete" text="删除" handler="del"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="name" header="姓名" width="90" sortable="false"/>
		<next:Column field="sex" header="性别" dataset="sexDataSet" width="90" sortable="false"/>
		<next:Column field="age" header="年龄" width="90" sortable="false"/>
		<next:Column field="folk" header="民族" dataset="NationDataset" width="90" sortable="false"/>
		<next:Column field="political" header="政治面貌" dataset="politicalDataSet" width="90" sortable="false"/>
		<next:Column field="education" header="文化程度" dataset="educationDataSet" width="90" sortable="false"/>
		<next:Column field="duty" header="当选职务" dataset="dutyDs" width="90" sortable="false"/>
		<next:Column field="dutyVoteNum" header="当选票数" width="90" sortable="false"/>
		<next:Column field="age" header="总票数" width="90" sortable="false"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="peopleDs"/>
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>

<next:Window id="hxWin" title="补选成员情况" resizable="false" width="750" height="300" modal="true" closable="false" autoScroll="true">
<next:Panel>
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="save" text="确定" handler="confirm"/>
	<next:ToolBarItem iconCls="delete" text="关闭" handler="closeWin"/>
</next:TopBar>
<next:Html>
<form id="form2" method="post" dataset="peopleDs" onsubmit="return false" class="L5form">
	<fieldset id="cdcFieldset">
		<legend></legend>
		<table width="100%">
		<tr>
			<td class="FieldLabel">姓名：</td>
			<td class="FieldInput"><input type="text" name="姓名" id="name" field="name" style="width:80%"/><font color="red">*</font></td>
			<td class="FieldLabel">性别：</td>
			<td class="FieldInput"><select name="性别" id="sex" field ="sex"><option dataset="sexDataSet"></option></select><font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel">年龄：</td>
			<td class="FieldInput"><input type="text" name="年龄" id="age" field="age" onchange="forcheck(this)" maxlength="10" style="width:80%"/><font color="red">*</font></td>
			<td class="FieldLabel">民族：</td>
			<td class="FieldInput"><select name="民族" id="folk" field ="folk"><option dataset="NationDataset"></option></select><font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel">政治面貌：</td>
			<td class="FieldInput"><select name="政治面貌" id="political" field ="political"><option dataset="politicalDataSet"></option></select><font color="red">*</font></td>
			<td class="FieldLabel">文化程度</td>
			<td class="FieldInput"><select name="文化程度" id="education" field ="education"><option dataset="educationDataSet"></option></select><font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel">当选职务：</td>
			<td class="FieldInput" colspan="3"><select name="当选职务" id="duty" field ="duty"><option dataset="dutyDs"></option></select><font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel">当选票数：</td>
			<td class="FieldInput"><input type="text" name="当选票数" id="dutyVoteNum" field="dutyVoteNum" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;票<font color="red">*</font></td>
			<td class="FieldLabel">总票数</td>
			<td class="FieldInput"><input type="text" name="总票数" id="voteNum" field="voteNum" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;票<font color="red">*</font></td>
		</tr>
	</table>
	</fieldset>
</form>
</next:Html>
</next:Panel>
</next:Window>
