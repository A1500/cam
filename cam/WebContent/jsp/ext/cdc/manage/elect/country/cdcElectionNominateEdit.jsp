<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<script type="text/javascript">
</script>
<title>农村民主选举提名方式信息</title>
<next:ScriptManager/>
<script type="text/javascript">
	var reportTime='<%=request.getParameter("reportTime")%>';
	var organ_Code='<%=request.getParameter("organ_Code")%>';
	var recordId='<%=request.getParameter("recordId")%>';
</script>
<script type="text/javascript" src="cdcElectionNominateEdit.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<jsp:include page="../../util/cdcOrgan.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="electionNominateDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcElectionNominateQueryCmd" pageSize="1">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcElectionNominate"/>
	</model:dataset>
	<model:dataset id="peopleDs" cmd="com.inspur.cams.cdc.base.cmd.CdcElectionMemberQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcElectionMember"/>
	</model:dataset>
	<model:dataset id="electionNominate2DataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcElectionNominateQueryCmd" pageSize="1">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcElectionNominate"/>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R11'/>
			<model:param name="organType" value='N'/>
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
	<model:dataset id="YorN" enumName="COMM.YESORNO" autoLoad="true" global="true" />
	<model:dataset id="sexDataSet" enumName="COMM.SEX" autoLoad="true" global="true"/>
	<model:dataset id="politicalDataSet" enumName="CDC.POLITICAL" autoLoad="true" global="true"/>
	<model:dataset id="educationDataSet" enumName="CDC.EDUCATION" autoLoad="true" global="true"/>
	<model:dataset id="statusDataSet" enumName="CDC.STATUS" autoLoad="true" global="true"/>
	<model:dataset id="candidateMannerDs" enumName="CDC.CANDIDATE_MANNER" autoLoad="true" global="true"/>
	<model:dataset id="nomMannerDs" enumName="CDC.NOM_MANNER" autoLoad="true" global="true"/>
	<model:dataset id="nomSourceDs" enumName="CDC.NOM_SOURCE" autoLoad="true" global="true"/>
</model:datasets>
<next:Panel width="99%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="save" text="保存" handler="save"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="electionNominateDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>候选人的产生</legend>
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
<legend>产生方式</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">产生方式：</td>
			<td class="FieldInput" colspan="5"><select name="产生方式" id="candidateManner" field="candidateManner" onchange="getManner()"><option dataset="candidateMannerDs"></option></select><font color="red">*</font></td>
		</tr>
		<tr id="tm" style="display:none">
			<td class="FieldLabel" style="width:18%">村民委员会候选人应选职数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name="村民委员会候选人应选职数" id="nomNum" field="nomNum" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人<font color="red">*</font></td>
			<td class="FieldLabel" style="width:18%">差额数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name="差额数" id="nomDiffNum" field="nomDiffNum" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人<font color="red">*</font></td>
			<td class="FieldLabel" style="width:18%">参加提名的登记参加选举的村民数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name="参加提名的登记参加选举的村民数" id="nomJoinNum" field="nomJoinNum" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人<font color="red">*</font></td>
		</tr>
		<tr id="tmyx1" style="display:none">
			<td class="FieldLabel" style="width:18%">村民委员会应选职数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name="村民委员会应选职数" id="prenomNum" field="prenomNum" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人<font color="red">*</font></td>
			<td class="FieldLabel" style="width:18%">参加村民委员会成员<br>候选人预选（提名）投票的村民数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name="参加村民委员会成员候选人预选（提名）投票的村民数" id="prenomJoinNum" field="prenomJoinNum" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人<font color="red">*</font></td>
			<td class="FieldLabel" style="width:18%">候选人确定人数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name="候选人确定人数" id="prenomCanNum" field="prenomCanNum" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人<font color="red">*</font></td>
		</tr>
		<tr id="tmyx2" style="display:none">
			<td class="FieldLabel">差额数：</td>
			<td class="FieldInput" colspan="5"><input type="text" name="差额数" id="prenomCanDiffNum" field="prenomCanDiffNum" onchange="forcheck(this)" maxlength="30"/>&nbsp;人<font color="red">*</font></td>
		</tr>
		<tr id="yx1" style="display:none">
			<td class="FieldLabel" style="width:18%">村民委员会应选职数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name="村民委员会应选职数" id="preNum" field="preNum" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人<font color="red">*</font></td>
			<td class="FieldLabel" style="width:18%">候选人数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name="候选人数" id="preCanNum" field="preCanNum" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人<font color="red">*</font></td>
			<td class="FieldLabel" style="width:18%">参加村民委员会成员<br>候选人预选投票的村民数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name="参加村民委员会成员候选人预选投票的村民数" id="preJoinNum" field="preJoinNum" onchange="forcheck(this)" maxlength="30"/>&nbsp;人<font color="red">*</font></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>

<next:EditGridPanel id="grid1" title="候选人信息" dataset="peopleDs" hidden="true"  width="100%" stripeRows="true" height="99.9%">
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
		<next:Column field="nomManner" header="提名形式" dataset="nomMannerDs" width="90" sortable="false"/>
		<next:Column field="nomNum" header="提名人数" width="90" sortable="false"/>
		<next:Column field="voteNum" header="得票数" width="90" sortable="false" hidden="true"/>
		<next:Column field="ifReduty" header="是否连选连任" dataset="YorN" width="90" sortable="false" hidden="true"/>
		<next:Column field="peopleSource" header="来源" dataset="nomSourceDs" width="90" sortable="false"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="peopleDs"/>
	</next:BottomBar>
</next:EditGridPanel>

<next:EditGridPanel id="grid2" title="候选人信息" dataset="peopleDs" hidden="true"  width="100%" stripeRows="true" height="99.9%">
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
		<next:Column field="voteNum" header="得票数" width="90" sortable="false"/>
		<next:Column field="ifReduty" header="是否连选连任" dataset="YorN" width="90" sortable="false"/>
		<next:Column field="peopleSource" header="来源" dataset="nomSourceDs" width="90" sortable="false"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="peopleDs"/>
	</next:BottomBar>
</next:EditGridPanel>

<next:EditGridPanel id="grid3" title="候选人信息" dataset="peopleDs" hidden="true" width="100%" stripeRows="true" height="99.9%">
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
		<next:Column field="voteNum" header="得票数" width="90" sortable="false"/>
		<next:Column field="peopleSource" header="来源" dataset="nomSourceDs" width="90" sortable="false"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="peopleDs"/>
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>

<next:Window id="hxWin" title="候选人信息" resizable="false" width="750" height="300" modal="true" closable="false" autoScroll="true">
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
		<tr id="tmWin" style="display:none">
			<td class="FieldLabel">提名形式：</td>
			<td class="FieldInput"><select name="提名形式" id="nomManner" field ="nomManner"><option dataset="nomMannerDs"></option></select><font color="red">*</font></td>
			<td class="FieldLabel">提名人数</td>
			<td class="FieldInput"><input type="text" name="提名人数" id="winnomNum" field="nomNum" onchange="forcheck(this)" maxlength="10" style="width:80%"/>&nbsp;人<font color="red">*</font></td>
		</tr>
		<tr id="tmyxWin" style="display:none">
			<td class="FieldLabel">得票数</td>
			<td class="FieldInput"><input type="text" name="得票数" id="voteNum" field="voteNum" onchange="forcheck(this)" maxlength="10" style="width:80%"/>&nbsp;票<font color="red">*</font></td>
			<td class="FieldLabel">是否连选连任：</td>
			<td class="FieldInput"><select name="是否连选连任" id="ifReduty" field ="ifReduty"><option dataset="YorN"></option></select><font color="red">*</font></td>
		</tr>
		<tr id="yxWin" style="display:none">
			<td class="FieldLabel">得票数</td>
			<td class="FieldInput" colspan="3"><input type="text" name="得票数" id="voteNum" field="voteNum" onchange="forcheck(this)" maxlength="10" style="width:80%"/>&nbsp;票<font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel">来源：</td>
			<td class="FieldInput" colspan="3"><select name="来源" id="peopleSource" field ="peopleSource"><option dataset="nomSourceDs"></option></select><font color="red">*</font></td>
		</tr>
	</table>
	</fieldset>
</form>
</next:Html>
</next:Panel>
</next:Window>
