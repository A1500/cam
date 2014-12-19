<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>城市民主监督情况填报</title>
<next:ScriptManager/>
</head>
<body>
<model:datasets>
	<model:dataset id="superviseDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcSuperviseReportQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcSuperviseReport"/>
	</model:dataset>
	<model:dataset id="superviseInfoDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcSuperviseInfoQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcSuperviseInfo"/>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true" autoLoad="true">
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
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="superviseDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>填报情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel">填报单位：</td>
			<td class="FieldInput" colspan="3"><label field="organName"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">填报日期：</td>
			<td class="FieldInput" style="width:36%"><label field="reportDate" dataset="reportWorkDataSet"/></td>
			<td class="FieldLabel" style="width:16%">上报日期：</td>
			<td class="FieldInput" style="width:30%"><label field="submitDate"/></td>
		</tr>
	</table>
</fieldset>
</form>
<form id="form2" method="post" dataset="superviseInfoDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>民主监督情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%" colspan="2">居务是否公开：</td>
			<td class="FieldInput" style="width:18%" ><label field ="ifPublish" dataset="YorN"></label></td>
			<td class="FieldLabel" style="width:18%">政务是否公开：</td>
			<td class="FieldInput" style="width:18%" ><label field ="ifAudit" dataset="YorN"></label></td>
			<td class="FieldLabel" style="width:18%">财务是否公开：</td>
			<td class="FieldInput" style="width:18%"><label field ="ifDiscuss" dataset="YorN"></label></td>
		</tr>
		<tr>
			<td class="FieldLabel" rowspan="2">公开形式</td>
			<td class="FieldLabel">是否有公开栏：</td>
			<td class="FieldInput"><label field ="formPlacard" dataset="YorN"></label> </td>
			<td class="FieldLabel">是否有触摸屏：</td>
			<td class="FieldInput"><label field ="formMeeting" dataset="YorN"></label> </td>
			<td class="FieldLabel">是否有计算机网络：</td>
			<td class="FieldInput"><label field ="formWeb" dataset="YorN"> </label> </td>
		</tr>
		<tr>
			<td class="FieldLabel">是否有明白纸：</td>
			<td class="FieldInput"><label field ="formPaper" dataset="YorN"></label> </td>
			<td class="FieldLabel">其他：</td>
			<td class="FieldInput" colspan="3"><label field ="formOther" dataset="YorN" ></label></td>
		</tr>
		<tr>
			<td class="FieldLabel" colspan="2">居委会成员接受评议次数：</td>
			<td class="FieldInput"><label field="partCyc"/ renderer="cRender" ></td>
			<td class="FieldLabel">居委会聘用人员受评人数：</td>
			<td class="FieldInput"><label field="govCyc" renderer="cRender" /></td>
			<td class="FieldLabel">连续两次被评议为不称职人数：</td>
			<td class="FieldInput"><label field="affairCyc" renderer="rRender" /></td>
		</tr>
		<tr>
			<td class="FieldLabel" colspan="2">居务监督委员会人数：</td>
			<td class="FieldInput"><label field="financeCyc" renderer="rRender" /></td>
			<td class="FieldLabel">居务监督委员会经居民会议推选产生人数：</td>
			<td class="FieldInput"><label field="meetingPeopleNum" renderer="rRender" /></td>
			<td class="FieldLabel">居务监督委员会经居民会代表会议产生人数：</td>
			<td class="FieldInput"><label field="sovietPeopleNum" renderer="rRender" /></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>
<script language="javascript">
function init(){
	var superviseDataSet=L5.DatasetMgr.lookup("superviseDataSet");
	var superviseInfoDataSet=L5.DatasetMgr.lookup("superviseInfoDataSet");
	superviseDataSet.setParameter("RECORD_ID@=",'<%=request.getParameter("recordId")%>');
	superviseInfoDataSet.setParameter("RECORD_ID@=",'<%=request.getParameter("recordId")%>');
	superviseDataSet.load();
	superviseInfoDataSet.load();
}
function returnBack(){
	history.go(-1);
}
function cRender(val){
	if(val!=""){
		return val+" 次";
	}
}
function rRender(val){
	if(val!=""){
		return val+" 人";
	}
}
</script>