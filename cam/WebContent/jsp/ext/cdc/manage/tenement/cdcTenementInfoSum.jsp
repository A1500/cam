<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>城市社区服务汇总</title>
<next:ScriptManager/>
<script type="text/javascript" src="cdcTenementInfoSum.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var recordId='<%=request.getParameter("recordId")%>';
	function gRender(val){
		if(val!="")
		return val+" 个";
	}
</script>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
<jsp:include page="../util/cdcSum.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="sumDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcTenementInfoQueryCmd" method="query" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcTenementInfo"/>
	</model:dataset>
	<model:dataset id="detailDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcTenementInfoQueryCmd" method="query" pageSize="200">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcTenementInfo"/>
	</model:dataset>
	<model:dataset id="cityDataSet" cmd="com.inspur.cams.comm.extuser.cmd.ComExtUserQueryCmd" method="getChengShiUser" pageSize="200">
		<model:record fromBean="com.inspur.cams.comm.extuser.data.ComExtUser"/>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R23'/>
			<model:param name="organType" value='C'/>
		</model:params>
	</model:dataset>
	<model:dataset id="statusDataSet" enumName="CDC.STATUS" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel width="100%" border="0">
<next:TopBar>
	<next:ToolBarItem symbol="->"></next:ToolBarItem>
	<next:ToolBarItem id="sumButton" iconCls="save" text="汇总" handler="save"></next:ToolBarItem>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"></next:ToolBarItem>
</next:TopBar>
<next:Html>
	<fieldset style="overflow:visible;" class="GroupBox">
	<legend class="GroupBoxTitle">汇总情况</legend>
		<form id="form1" method="post" dataset="sumDataSet" onsubmit="return false" class="L5form">
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width:18%">填报单位：</td>
					<td class="FieldInput" style="width:36%"><label field="organName"/></td>
					<td class="FieldLabel" style="width:16%">填报日期：</td>
					<td class="FieldInput" style="width:30%"><select id="reportDate" field="reportDate" onchange="getData()"><option dataset="reportWorkDataSet"/></select><font color="red">*</font></td>
				</tr>
			</table>
		</form>
	</fieldset>
</next:Html>
</next:Panel>
<next:EditGridPanel id="grid" dataset="detailDataSet" width="100%" stripeRows="true" height="99.9%" hasSum="true">
	<next:TopBar>
		<next:ToolBarItem iconCls="return" text="返回上级" handler="getUp"/>
		<next:ToolBarItem symbol="->"/>
		<next:ToolBarItem iconCls="detail" text="明细" handler="detail"/>
		<next:ToolBarItem id="auditButton" iconCls="delete" text="驳回" handler="audit"/>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn />
		<next:RadioBoxColumn />
		<next:Column field="organName" header="单位名称"  sortable="false" renderer="statusRender"/>
		<next:Column field="tenementNum" header="物业服务企业个数" sortable="false" align="right"/>
		<next:Column field="proprietorCommitteeNum" header="业主委员会个数"  sortable="false" align="right"/>
		<next:Column field="reportDate" header="填报日期" editable="false" sortable="true" align="center"><next:ComboBox dataset="reportWorkDataSet"/></next:Column>
		<next:Column field="status" header="填报状态"  editable="false" sortable="false" align="center"><next:ComboBox dataset="statusDataSet"/></next:Column>
		<next:Column field="submitDate" header="上报日期"  sortable="false" align="center"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="detailDataSet"/>
	</next:BottomBar>
</next:EditGridPanel>

<next:Window id="detailWin" title="明细" resizable="false" width="800" height="250" modal="true" closeAction="hide" autoScroll="true">
<next:Panel>
<next:Html>
<form id="form2" method="post" dataset="detailDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>填报情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">填报单位：</td>
			<td class="FieldInput" style="width:36%"><label field="organName"/></td>
			<td class="FieldLabel" style="width:16%">填报日期：</td>
			<td class="FieldInput" style="width:36%"><label field="reportDate" dataset="reportWorkDataSet"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">上报日期：</td>
			<td class="FieldInput" colspan="3"><label field="submitDate"/></td>
		</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>物业信息</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">物业服务企业个数:</td>
			<td class="FieldInput" style="width:36%"><label field="tenementNum" renderer="gRender"/><font color="red">*</font></td>
			<td class="FieldLabel" style="width:16%">业主委员会个数:</td>
			<td class="FieldInput" style="width:36%"><label field="proprietorCommitteeNum" renderer="gRender"/><font color="red">*</font></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</next:Window>
<next:Window id="rejectWin" title="驳回原因" resizable="false" width="400" height="200" modal="true" closeAction="hide" autoScroll="true">
<next:Html>
<form id="form1" method="post" dataset="detailDataSet" onsubmit="return false" class="L5form">
	<fieldset>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:30%">驳回原因：</td>
			<td class="FieldInput" style="width:70%" ><textArea style="height:110;width:100%" id="reason"></textArea></td>
		</tr>
	</table>
	</fieldset>
</form>
</next:Html>
<next:Buttons>
		<next:ToolButton text="确定" handler="confirmReject"></next:ToolButton>
		<next:ToolButton text="取消" handler="closeWin"></next:ToolButton>
</next:Buttons>
</next:Window>
</body>
</html>