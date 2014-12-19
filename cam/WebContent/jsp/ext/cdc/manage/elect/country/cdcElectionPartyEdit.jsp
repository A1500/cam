<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<script type="text/javascript">
</script>
<title>村党组织成员情况</title>
<next:ScriptManager/>
<script type="text/javascript">
	var reportTime='<%=request.getParameter("reportTime")%>';
	var recordId='<%=request.getParameter("recordId")%>';
	var organ_Code='<%=request.getParameter("organ_Code")%>';
</script>
<script type="text/javascript" src="cdcElectionPartyEdit.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<jsp:include page="../../util/cdcOrgan.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="partyDs" cmd="com.inspur.cams.cdc.base.cmd.CdcElectionPartyQueryCmd" pageSize="1">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcElectionParty"/>
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
	<model:dataset id="statusDataSet" enumName="CDC.STATUS" autoLoad="true" global="true"/>
	<model:dataset id="YorN" enumName="COMM.YESORNO" autoLoad="true" global="true" />
	<model:dataset id="sexDataSet" enumName="COMM.SEX" autoLoad="true" global="true"/>
	<model:dataset id="politicalDataSet" enumName="CDC.POLITICAL" autoLoad="true" global="true"/>
	<model:dataset id="educationDataSet" enumName="CDC.EDUCATION" autoLoad="true" global="true"/>
	<model:dataset id="dutyDs" enumName="CDC.DUTY.TYPE" autoLoad="true" global="true"/>
	<model:dataset id="partySourceDs" enumName="CDC.PARTY_SOURCE" autoLoad="true" global="true"/>
</model:datasets>
<next:Panel width="99%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="save" text="保存" handler="save"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="partyDs" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>村党组织成员情况</legend>
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
<legend>村党组织情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">本村中共党员人数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name="本村中共党员人数" id="partyNum" field="partyNum" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人<font color="red">*</font></td>
			<td class="FieldLabel" style="width:18%">其中妇女党员人数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name="其中妇女党员人数" id="femaleNum" field="femaleNum" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人<font color="red">*</font></td>
			<td class="FieldLabel" style="width:18%">其中少数民族党员人数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name="其中少数民族党员人数" id="folkNum" field="folkNum" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人<font color="red">*</font></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>

<next:EditGridPanel id="grid" title="党组织成员个人情况" dataset="peopleDs" width="100%" stripeRows="true" height="99.9%">
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
		<next:Column field="ifFirst" header="是否初次当选" dataset="YorN" width="90" sortable="false"/>
		<next:Column field="ifReduty" header="是否连选连任" dataset="YorN" width="90" sortable="false"/>
		<next:Column field="duty" header="兼任村委会职务" dataset="YorN" width="90" sortable="false"/>
		<next:Column field="peopleSource" header="党组织成员来源" dataset="partySourceDs" width="90" sortable="false"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="peopleDs"/>
	</next:BottomBar>
</next:EditGridPanel>

</body>
</html>

<next:Window id="hxWin" title="党组织成员个人情况" resizable="false" width="750" height="300" modal="true" closable="false" autoScroll="true">
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
			<td class="FieldLabel">是否初次当选：</td>
			<td class="FieldInput"><select name="是否初次当选" id="ifFirst" field ="ifFirst" onchange="firstChange(this);"><option dataset="YorN"></option></select><font color="red">*</font></td>
			<td class="FieldLabel">是否连选连任</td>
			<td class="FieldInput"><select name="是否连选连任" id="ifReduty" field ="ifReduty" onchange="redutyChange(this);"><option dataset="YorN"></option></select><font color="red">*</font></td>
		</tr>
		<tr><td class="FieldLabel">兼任村委会职务：</td>
			<td class="FieldInput"><select name="兼任村委会职务" id="duty" field ="duty"><option dataset="dutyDs"></option></select><font color="red">*</font></td>
			<td class="FieldLabel">党组织成员来源：</td>
			<td class="FieldInput"><select name="党组织成员来源" id="peopleSource" field ="peopleSource"><option dataset="partySourceDs"></option></select><font color="red">*</font></td>
		</tr>
	</table>
	</fieldset>
</form>
</next:Html>
</next:Panel>
</next:Window>
