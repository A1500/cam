<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<script type="text/javascript">
</script>
<title>农村民主选举选举准备情况</title>
<next:ScriptManager/>
<script type="text/javascript">
	var reportTime='<%=request.getParameter("reportTime")%>';
	var recordId='<%=request.getParameter("recordId")%>';
	var organ_Code='<%=request.getParameter("organ_Code")%>';
</script>
<script type="text/javascript" src="cdcElectionPrepareEdit.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<jsp:include page="../../util/cdcOrgan.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="electionPrepareDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcElectionPrepareQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcElectionPrepare"/>
	</model:dataset>
	<model:dataset id="electionPrepare2DataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcElectionPrepareQueryCmd" pageSize="1">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcElectionPrepare"/>
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
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R11'/>
			<model:param name="organType" value='N'/>
		</model:params>
	</model:dataset>
	<model:dataset id="YorN" enumName="COMM.YESORNO" autoLoad="true" global="true" />
	<model:dataset id="statusDataSet" enumName="CDC.STATUS" autoLoad="true" global="true"/>
	<!-- 性别 -->
	<model:dataset id="sexDataSet" enumName="COMM.SEX" autoLoad="true" global="true"/>
	<model:dataset id="ecAuditDs" enumName="CDC.ELECTION_ECONOMY_AUDIT" autoLoad="true" global="true"/>
	<model:dataset id="electionMannerDs" enumName="CDC.ELECTION_MANNER" autoLoad="true" global="true"/>
</model:datasets>
<next:Panel width="99%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="save" text="保存" handler="save"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="electionPrepareDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>选举准备情况</legend>
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
<legend>干部包村情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">村名：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name="村名" id="villageName" field="villageName" maxlength="100"/><font color="red">*</font></td>
			<td class="FieldLabel" style="width:18%">干部姓名：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name="干部姓名" id="name" field="name" maxlength="30"/><font color="red">*</font></td>
			<td class="FieldLabel" style="width:18%">性别：</td>
			<td class="FieldInput" style="width:14%"><select name="性别" id="sex" field ="sex"><option dataset="sexDataSet"></option></select><font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel">县市区领导干部联系点村名：</td>
			<td class="FieldInput" colspan="5"><input type="text" name="县市区领导干部联系点村名" id="linkVillageName" field="linkVillageName" maxlength="100"/><font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">县市区领导姓名：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name="县市区领导姓名" id="leaderName" field="leaderName" maxlength="30"/><font color="red">*</font></td>
			<td class="FieldLabel" style="width:18%">县市区领导性别：</td>
			<td class="FieldInput" style="width:14%"><select name="县市区领导性别" id="leaderSex" field ="leaderSex"><option dataset="sexDataSet"></option></select><font color="red">*</font></td>
			<td class="FieldLabel" style="width:18%">县市区领导职务：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name="县市区领导职务" id="leaderDuty" field="leaderDuty" maxlength="30"/><font color="red">*</font></td>
		</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>试点村情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">是否为试点村：</td>
			<td class="FieldInput" colspan="5"><select name="是否为试点村" id="ifTest" field ="ifTest"><option dataset="YorN"></option></select><font color="red">*</font></td>
		</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>离任经济责任审计情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">离任经济责任审计情况：</td>
			<td class="FieldInput" colspan="5"><select name="离任经济责任审计情况" id="economyAudit" field ="economyAudit"><option dataset="ecAuditDs"></option></select><font color="red">*</font></td>
		</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>难点村情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel">是否难点村：</td>
			<td class="FieldInput" colspan="5"><select name="是否难点村" id="ifDiff" field ="ifDiff" onchange="ifDiffChange()"><option dataset="YorN"></option></select><font color="red">*</font></td>
		</tr>
		<tr id="ifDiffDiv" style="display:none">
			<td class="FieldLabel">难点原因：</td>
			<td class="FieldInput" colspan="5">
				<input type="checkbox" id="n0">未换届选举
				<input type="checkbox" id="n1">班子不健全
				<input type="checkbox" id="n2">班子软弱涣散
				<input type="checkbox" id="n3">干群关系紧张
				<input type="checkbox" id="n4">村务不公开管理混乱
				<input type="checkbox" id="n5">经济薄弱无人干
				<input type="checkbox" id="n6">经济发达竞争激烈
				<input type="checkbox" id="n7">干部驾驭能力差
				<input type="checkbox" id="n8">遗留问题未解决
				<input type="checkbox" id="n9">拆迁合并改制
				<input type="checkbox" id="n10">干部作风简单霸道
				<input type="checkbox" id="n11">群体上访不断
				<input type="checkbox" id="n12">宗族派性严重
				<input type="checkbox" id="n13">其他
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">换届时间：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name="换届时间" id="changeDate" field="changeDate" onclick="LoushangDate(this)" format="Y-m-d" style="width:90%"/><font color="red">*</font></td>
			<td class="FieldLabel" style="width:18%">责任人：</td>
			<td class="FieldInput" colspan="3"><input type="text" name="责任人" id="peopleName" field="peopleName" maxlength="30"/><font color="red">*</font></td>
		</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>村民选举委员会基本情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel">村民选举委员会产生方式：</td>
			<td class="FieldInput" colspan="5"><select name="村民选举委员会产生方式" id="electionManner" field ="electionManner" onchange="getManner()"><option dataset="electionMannerDs"></option></select><font color="red">*</font></td>
		</tr>
		<tr id="cm" style="display:none">
			<td class="FieldLabel">村民（户代表）总数：</td>
			<td class="FieldInput"><input type="text" name="村民（户代表）总数" id="villagerNum" field="villagerNum" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人<font color="red">*</font></td>
			<td class="FieldLabel">参加推选的村民（户代表）数：</td>
			<td class="FieldInput" colspan="3"><input type="text" name="参加推选的村民（户代表）数" id="joinVillagerNum" field="joinVillagerNum" onchange="forcheck(this)" maxlength="30"/>&nbsp;人<font color="red">*</font></td>
		</tr>
		<tr id="cmdb" style="display:none">
			<td class="FieldLabel">代表会议组成人员总数：</td>
			<td class="FieldInput"><input type="text" name="代表会议组成人员总数" id="sovietNum" field="sovietNum" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人<font color="red">*</font></td>
			<td class="FieldLabel">参加推选的村民代表人数：</td>
			<td class="FieldInput" colspan="3"><input type="text" name="参加推选的村民代表人数" id="joinSovietNum" field="joinSovietNum" onchange="forcheck(this)" maxlength="30"/>&nbsp;人<font color="red">*</font></td>
		</tr>
		<tr id="cmxz" style="display:none">
			<td class="FieldLabel">本小组总人（户）数：</td>
			<td class="FieldInput"><input type="text" name="本小组总人（户）数" id="groupNum" field="groupNum" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人（户）<font color="red">*</font></td>
			<td class="FieldLabel">参加推选的村民(户代表）人数：</td>
			<td class="FieldInput" colspan="3"><input type="text" name="参加推选的村民(户代表）人数" id="joinGroupNum" field="joinGroupNum" onchange="forcheck(this)" maxlength="30"/>&nbsp;人（户）<font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">村民选举委员会职数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name="村民选举委员会职数" id="eleComNum" field="eleComNum" title="村民选举委员会职数必须为5人、7人或者9人！" onchange="forcheck(this)" maxlength="1" style="width:80%"/>&nbsp;人<font color="red">*</font></td>
			<td class="FieldLabel" style="width:18%">党员人数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name="党员人数" id="eleComPartyNum" field="eleComPartyNum" onchange="forcheck(this)" maxlength="1" style="width:80%"/>&nbsp;人<font color="red">*</font></td>
			<td class="FieldLabel" style="width:18%">妇女成员人数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name="妇女成员人数" id="eleComFemaleNum" field="eleComFemaleNum" onchange="forcheck(this)" maxlength="1" style="width:80%"/>&nbsp;人<font color="red">*</font></td>
		</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>选民资格讨论</legend>
	<table width="100%">
	<tr>
		<td class="FieldLabel" style="width:20%">是否召开村民会议或村民代表会议，对村委会职数及大学生村官、在本村居住一年以上、国家企事业离退休干部是否具有选民资格进行讨论</td>
		<td class="FieldInput" style="width:24%"><select name="是否讨论" id="ifDiscuss" field ="ifDiscuss"><option dataset="YorN"></option></select></td>
	</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>登记参加选举的村民情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel">张榜公布登记参加选举的村民总数：</td>
			<td class="FieldInput" colspan="5"><input type="text" name="张榜公布登记参加选举的村民总数" id="elePeopleNum" field="elePeopleNum" onchange="forcheck(this)" maxlength="30"/>&nbsp;人<font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">党员人数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name="党员人数" id="elePartyNum" field="elePartyNum" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人<font color="red">*</font></td>
			<td class="FieldLabel" style="width:18%">女性人数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name="女性人数" id="eleFemaleNum" field="eleFemaleNum" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人<font color="red">*</font></td>
			<td class="FieldLabel" style="width:18%">少数民族人数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name="少数民族人数" id="eleFolkNum" field="eleFolkNum" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人<font color="red">*</font></td>
		</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>村民委员会组成人员职数</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">村民委员会组成人员职数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name="村民委员会组成人员职数" title="村民委员会组成人员职数必须为3～7人！" id="comPositionNum" field="comPositionNum" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人<font color="red">*</font></td>
			<td class="FieldLabel" style="width:18%">副主任职数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name="副主任职数" title ="村民委员会组成人员职数包含主任职数、副主任职数、委员职数" id="comDeputyNum" field="comDeputyNum" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人<font color="red">*</font></td>
			<td class="FieldLabel" style="width:18%">委员职数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name="委员职数" title ="村民委员会组成人员职数包含主任职数、副主任职数、委员职数" id="comMbNum" field="comMbNum" onchange="forcheck(this)" maxlength="30" style="width:80%"/>&nbsp;人<font color="red">*</font></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
<next:BottomBar >
		<next:ToolBarItem symbol="->"/>
		<next:ToolBarItem iconCls="save" text="保存" handler="save"></next:ToolBarItem>
	</next:BottomBar>
</next:Panel>
</body>
</html>