<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>城市民主监督情况填报</title>
<next:ScriptManager/>
<script type="text/javascript" src="cdcSuperviseInfoEdit.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var recordId='<%=request.getParameter("recordId")%>';
</script>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="superviseDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcSuperviseReportQueryCmd" >
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcSuperviseReport"/>
	</model:dataset>
	<model:dataset id="superviseInfoDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcSuperviseInfoQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcSuperviseInfo"/>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R15'/>
			<model:param name="organType" value='C'/>
		</model:params>
	</model:dataset>
	<model:dataset id="YorN" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="TimeDataset" enumName="PUBLISH.TIME" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel width="100%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="add" text="历史数据回填" id="backInsert" handler="forInsert"/>
	<next:ToolBarItem iconCls="save" text="保存" handler="save"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form2" method="post" dataset="superviseDataSet" onsubmit="return false" class="L5form">
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
</form>
<form id="form1" method="post" dataset="superviseInfoDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>民主监督情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" colspan="2">居务是否公开：</td>
			<td class="FieldInput"><select name = "居务是否公开"  id="ifPublish" field ="ifPublish"><option dataset="YorN"></option></select> <font color="red">*</font></td>
			<td class="FieldLabel">政务是否公开：</td>
			<td class="FieldInput" ><select name = "政务是否公开"  id="ifAudit" field ="ifAudit"><option dataset="YorN"></option></select> <font color="red">*</font></td>
			<td class="FieldLabel">财务是否公开：</td>
			<td class="FieldInput"><select name = "财务是否公开"  id="ifPublishFinance" field ="ifDiscuss"><option dataset="YorN"></option></select> <font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel" rowspan="2">公开形式</td>
			<td class="FieldLabel">是否有公开栏：</td>
			<td class="FieldInput"><select name = "是否有公开栏"  id="formPlacard" field ="formPlacard"><option dataset="YorN"></option></select> <font color="red">*</font></td>
			<td class="FieldLabel">是否有触摸屏：</td>
			<td class="FieldInput"><select name = "是否有触摸屏"  id="formMeeting" field ="formMeeting"><option dataset="YorN"></option></select> <font color="red">*</font></td>
			<td class="FieldLabel">是否有计算机网络：</td>
			<td class="FieldInput"><select name = "是否有计算机网络"  id="formWeb" field ="formWeb"><option dataset="YorN"></option></select> <font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel">是否有明白纸：</td>
			<td class="FieldInput"><select name = "是否有明白纸"  id="formPaper" field ="formPaper"><option dataset="YorN"></option></select> <font color="red">*</font></td>
			<td class="FieldLabel">其他：</td>
			<td class="FieldInput" colspan="3"><select name = "其他"  id="formOther" field ="formOther"><option dataset="YorN"></option></select> <font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel" colspan="2">居委会成员接受评议次数：</td>
			<td class="FieldInput"><input type="text" name = "居委会成员接受评议次数"  id="discussMemberNum" field="partCyc" onchange="forcheck(this)" maxlength="2" />&nbsp;次 <font color="red">*</font></td>
			<td class="FieldLabel">居委会聘用人员受评人数：</td>
			<td class="FieldInput"><input type="text" name = "居委会聘用人员受评人数"  id="discussEmployNum" field="govCyc" onchange="forcheck(this)" maxlength="2" />&nbsp;人 <font color="red">*</font></td>
			<td class="FieldLabel">连续两次被评议为不称职人数：</td>
			<td class="FieldInput"><input type="text" name = "连续两次被评议为不称职人数"  id="notCompetentNum" field="affairCyc" onchange="forcheck(this)" maxlength="2" />&nbsp;人 <font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel" colspan="2">居务监督委员会人数：</td>
			<td class="FieldInput"><input type="text" name = "居务监督委员会人数"  id="memberNum" field="financeCyc" maxlength="6" onchange="forcheck(this)" />&nbsp;人 <font color="red">*</font></td>
			<td class="FieldLabel">居务监督委员会经居民会议推选产生人数：</td>
			<td class="FieldInput"><input type="text" name = "居务监督委员会经居民会议推选产生人数"  id="meetingPeopleNum" field="meetingPeopleNum" onchange="forcheck(this)" maxlength="2" />&nbsp;人 <font color="red">*</font></td>
			<td class="FieldLabel">居务监督委员会经居民会代表会议产生人数：</td>
			<td class="FieldInput"><input type="text" name = "居务监督委员会经居民会代表会议产生人数"  id="sovietPeopleNum" field="sovietPeopleNum" onchange="forcheck(this)" maxlength="2" />&nbsp;人 <font color="red">*</font></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>