<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<script type="text/javascript">
</script>
<title>城市民主选举两委成员情况</title>
<next:ScriptManager/>
<script type="text/javascript">
	var reportTime='<%=request.getParameter("reportTime")%>';
	var recordId='<%=request.getParameter("recordId")%>';
</script>
<script type="text/javascript" src="cdcElectionCommitteeEdit.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<jsp:include page="../../util/cdcOrgan.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="electionCommitteeDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcElectionCommitteeQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcElectionCommittee"/>
	</model:dataset>
	<model:dataset id="electionCommittee2DataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcElectionCommitteeQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcElectionCommittee"/>
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
<form id="form1" method="post" dataset="electionCommitteeDataSet" onsubmit="return false" class="L5form">
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
<legend>当选两委成员</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:13%">总人数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name = "总人数" onchange="forcheck(this)" id="cadreNum" field="cadreNum" maxlength="30" /></td>
			<td class="FieldLabel" style="width:13%">妇女人数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name = "妇女人数" onchange="forcheck(this)" id="cadreFemaleNum" field="cadreFemaleNum" maxlength="30" /></td>
			<td class="FieldLabel" style="width:13%">党员人数：</td>
			<td class="FieldInput" style="width:15%"><input type="text" name = "党员人数" onchange="forcheck(this)" id="cadrePartyNum" field="cadrePartyNum" maxlength="30" /></td>
		</tr>
		<tr>
			<td class="FieldLabel">连选连任人数：</td>
			<td class="FieldInput"><input type="text" name = "连选连任人数" onchange="forcheck(this)" id="cadreSequenceNum" field="cadreSequenceNum" maxlength="30" /></td>
			<td class="FieldLabel">新当选人数：</td>
			<td class="FieldInput" colspan="3"><input type="text" name = "新当选人数" onchange="forcheck(this)" id="cadreNewNum" field="cadreNewNum" maxlength="30" /></td>
		</tr>
		<tr>
			<td class="FieldLabel">30岁以下人数：</td>
			<td class="FieldInput"><input type="text" name = "30岁以下人数" onchange="forcheck(this)" id="cadreThirtyNum" field="cadreThirtyNum" maxlength="30" /></td>
			<td class="FieldLabel">30~60岁以下人数：</td>
			<td class="FieldInput"><input type="text" name = "60岁以下人数" onchange="forcheck(this)" id="cadreUsixtyNum" field="cadreUsixtyNum" maxlength="30" /></td>
			<td class="FieldLabel">60岁以上人数：</td>
			<td class="FieldInput"><input type="text" name = "60岁以上人数" onchange="forcheck(this)" id="cadreSixtyNum" field="cadreSixtyNum" maxlength="30" /></td>
		</tr>
		<tr>
			<td class="FieldLabel">大专及以上人数：</td>
			<td class="FieldInput"><input type="text" name = "大专及以上人数" onchange="forcheck(this)" id="cadreCollegeNum" field="cadreCollegeNum" maxlength="30" /></td>
			<td class="FieldLabel">高中及以下人数：</td>
			<td class="FieldInput" colspan="3"><input type="text" name = "高中及以下人数" onchange="forcheck(this)" id="cadreHightNum" field="cadreHightNum" maxlength="30" /></td>
			
		</tr>
	</table>
</fieldset>
<fieldset name = ""  id="cdcFieldset">
<legend>两委成员情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:20%" colspan="2">两委交叉任职人数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name = "两委交叉任职人数" onchange="forcheck(this)" id="cadreAcrossNum" field="cadreAcrossNum" maxlength="30" /></td>
			<td class="FieldLabel" >是否主任书记一人兼：</td>
			<td class="FieldInput" colspan="3"><select name = ""  id="ifSideline" field="ifSideline"> <option dataset="YorN"></option>  </select></td>
		</tr>
		<tr>
			<td class="FieldLabel" rowspan="3">来  源：</td>
			<td class="FieldLabel">居民人数：</td>
			<td class="FieldInput"><input type="text" name = "居民人数" onchange="forcheck(this)" id="cadreResideNum" field="cadreResideNum" maxlength="30" /></td>
			<td class="FieldLabel">经济组织负责人数：</td>
			<td class="FieldInput"><input type="text" name = "经济组织负责人数" onchange="forcheck(this)" id="cadreEconomyNum" field="cadreEconomyNum" maxlength="30" /></td>
			<td class="FieldLabel">产业协会负责人数：</td>
			<td class="FieldInput"><input type="text" name = "产业协会负责人数" onchange="forcheck(this)" id="cadreUnionNum" field="cadreUnionNum" maxlength="30" /></td>
		</tr>
			<tr>
			<td class="FieldLabel">返乡人数：</td>
			<td class="FieldInput"><input type="text" name = "返乡人数" onchange="forcheck(this)" id="cadreBackNum" field="cadreBackNum" maxlength="30" /></td>
			<td class="FieldLabel">机关下派人数：</td>
			<td class="FieldInput"><input type="text" name = "机关下派人数" onchange="forcheck(this)" id="cadreDispatchNum" field="cadreDispatchNum" maxlength="30" /></td>
			<td class="FieldLabel">高校毕业生人数：</td>
			<td class="FieldInput"><input type="text" name = "高校毕业生人数" onchange="forcheck(this)" id="cadreGradNum" field="cadreGradNum" maxlength="30" /></td>
		</tr>
			<tr>
			<td class="FieldLabel">大学生居官人数：</td>
			<td class="FieldInput"><input type="text" name = "大学生居官人数" onchange="forcheck(this)" id="cadreStudentNum" field="cadreRetireNum" maxlength="30" /></td>
			<td class="FieldLabel">离岗退休人数：</td>
			<td class="FieldInput" colspan="3"><input type="text" name = "离岗退休人数" onchange="forcheck(this)" id="cadreRetireNum" field="cadreRetireNum" maxlength="30" /></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>