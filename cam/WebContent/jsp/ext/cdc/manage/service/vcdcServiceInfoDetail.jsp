<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>农村社区服务明细</title>
<next:ScriptManager/>
</head>
<body>
<model:datasets>
	<model:dataset id="serviceReportDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcServiceReportQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcServiceReport"/>
	</model:dataset>
	<model:dataset id="serviceInfoDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcServiceInfoQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcServiceInfo"/>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" autoLoad="true" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R07'/>
			<model:param name="organType" value='N'/>
		</model:params>
	</model:dataset>
	<model:dataset id="serviceTypeDataSet" enumName="CDC.SERVICE.TYPE" autoLoad="true" global="true"/>
	<model:dataset id="serviceModeDataSet" enumName="CDC.SERVICE.MODE" autoLoad="true" global="true"/>
	<model:dataset id="serviceContentDataSet" enumName="CDC.SERVICE.CONTENT" autoLoad="true" global="true"/>
	<model:dataset id="YorN" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel width="99%">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="serviceReportDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>填报情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:31%">填报单位：</td>
			<td class="FieldInput" style="width:22%"><label field="organName"/></td>
			<td class="FieldLabel" style="width:24%">社区数量：</td>
			<td class="FieldInput" style="width:31%"><label id="communityNum" field="communityNum"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">填报日期：</td>
			<td class="FieldInput"><label field="reportDate" dataset="reportWorkDataSet"/></td>
			<td class="FieldLabel">上报日期：</td>
			<td class="FieldInput"><label field="submitDate"/></td>
		</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>社区服务状况</legend>
	<table width="100%">
			<tr>
			<td class="FieldLabel" style="text-align:center;width:6%" rowspan="5">公共服务</td>
			<td class="FieldLabel" style="width:10%" colspan="2">开展服务社区数：</td>
			<td class="FieldInput" style="width:14%"><label field="serviceNum" renderer="gRender"/></td>
			<td class="FieldLabel" style="width:6%" rowspan="3">服务方式：</td>
			<td class="FieldLabel" style="width:10%">现场办理项目数：</td>
			<td class="FieldInput" style="width:15%"><label field="publicLocaleNum" renderer="gRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" colspan="2">一站式服务大厅数：</td>
			<td class="FieldInput"><label field="onceNum" renderer="gRender"/></td>
			<td class="FieldLabel">全程代理项目数：</td>
			<td class="FieldInput"><label field="publicSupplyNum" renderer="gRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" colspan="2">服务项目数：</td>
			<td class="FieldInput"><label field="publicNum" renderer="gRender"/></td>
			<td class="FieldLabel">其他项目数：</td>
			<td class="FieldInput"><label field="publicOtherNum" renderer="gRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" colspan="2">主管单位总数：</td>
			<td class="FieldInput"><label field="publicMorgNum" renderer="gRender"/></td>
			<td class="FieldLabel" style="width:6%" rowspan="2">服务时间：</td>
			<td class="FieldLabel">全天项目数：</td>
			<td class="FieldInput"><label field="publicDayNum" renderer="gRender"/></td>
		</tr>
			<tr>
			<td class="FieldLabel" colspan="2">服务人员数：</td>
			<td class="FieldInput"><label field="publicPeopleNum" renderer="pRender"/></td>
			<td class="FieldLabel">非全天项目数：</td>
			<td class="FieldInput"><label field="publicNotdayNum" renderer="gRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="text-align:center;width:6%" rowspan="3">便民利民服务</td>
			<td class="FieldLabel" style="width:13%" colspan="2">项目数：</td>
			<td class="FieldInput" style="width:14%"><label field="facilitateNum" renderer="gRender"/></td>
			<td class="FieldLabel" style="width:10%" colspan="2">服务场所总面积：</td>
			<td class="FieldInput" style="width:15%"><label field="facilitateArea" renderer="aRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:13%" colspan="2">主管单位数：</td>
			<td class="FieldInput" style="width:14%"><label field="facilitateMorgNum" renderer="gRender"/></td>
			<td class="FieldLabel" style="width:10%" colspan="2">24小时服务项目数：</td>
			<td class="FieldInput" style="width:15%"><label field="facilitateDayNum" renderer="gRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:13%" colspan="2">服务人员：</td>
			<td class="FieldInput" style="width:14%" colspan="4"><label field="facilitatePeopleNum" renderer="pRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="text-align:center;width:6%" rowspan="5">志愿者服务</td>
			<td class="FieldLabel" style="width:7%" rowspan="4">志愿者组织：</td>
			<td class="FieldLabel" style="width:7%">总数：</td>
			<td class="FieldInput" style="width:14%"><label field="voluntNum" renderer="gRender"/></td>
			<td class="FieldLabel" style="width:10%" colspan="2">当年成立数量：</td>
			<td class="FieldInput" style="width:15%"><label field="voluntYearNum" renderer="gRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:7%">针对儿童个数：</td>
			<td class="FieldInput" style="width:14%"><label field="voluntChildNum" renderer="gRender"/></td>
			<td class="FieldLabel" style="width:10%"colspan="2">针对残疾人个数：</td>
			<td class="FieldInput" style="width:15%"><label field="voluntHandiNum" renderer="gRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:7%">针对老年人个数：</td>
			<td class="FieldInput" style="width:14%"><label field="voluntOldNum" renderer="gRender"/></td>
			<td class="FieldLabel" style="width:10%" colspan="2">针对困难群众个数：</td>
			<td class="FieldInput" style="width:15%"><label field="voluntDiffNum" renderer="gRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:7%">针对其他个数：</td>
			<td class="FieldInput" colspan="4"><label field="voluntOtherNum" renderer="gRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:6%" >志愿者：</td>
			<td class="FieldLabel" style="width:7%">总人数：</td>
			<td class="FieldInput" style="width:14%"><label field="volunteerNum" renderer="pRender"/></td>
			<td class="FieldLabel" style="width:10%" colspan="2">注册人数：</td>
			<td class="FieldInput" style="width:15%"><label field="regNum" renderer="pRender"/></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
<next:EditGridPanel id="grid" dataset="serviceInfoDataSet" width="99%" stripeRows="true" height="300" hasSum="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"/>
	</next:TopBar>
	<next:Columns>
		<next:RadioBoxColumn/>
		<next:Column field="serviceName" header="名称" width="10%" sortable="false"/>
		<next:Column field="serviceType" header="服务类型" width="8%" sortable="false"><next:ComboBox dataset="serviceTypeDataSet"/></next:Column>
		<next:Column field="morgName" header="主管单位" width="10%" editable="false" sortable="false" />
		<next:Column field="serviceAdds" header="服务地点" width="10%" sortable="false"/>
		<next:Column field="peopleNum" header="人数" width="20%" sortable="false"/>
		<next:Column field="foundDate" header="成立时间" width="10%" sortable="false"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="serviceInfoDataSet"/>
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>
<script language="javascript">
function init(){
	var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
	reportWorkDataSet.load();
	var ds=L5.DatasetMgr.lookup("serviceReportDataSet");
	ds.setParameter("RECORD_ID@=",'<%=request.getParameter("recordId")%>');
	var serviceInfoDataSet=L5.DatasetMgr.lookup("serviceInfoDataSet");
	serviceInfoDataSet.setParameter("RECORD_ID@=",'<%=request.getParameter("recordId")%>');
	ds.load();
	serviceInfoDataSet.load();
}
function returnBack(){
	history.go(-1);
}
function gRender(val){
	return val+" 个";
}
function aRender(val){
	return val+" ㎡";
}
function pRender(val){
	if(val!=""){
		return val+" 人";
	}
}
</script>