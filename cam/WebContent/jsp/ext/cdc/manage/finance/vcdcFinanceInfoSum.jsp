<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>农村经济基本情况汇总</title>
<next:ScriptManager/>
<script type="text/javascript" src="vcdcFinanceInfoSum.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var recordId='<%=request.getParameter("recordId")%>';
</script>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
<jsp:include page="../util/cdcSum.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="sumDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcFinanceInfoQueryCmd" pageSize="10">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcFinanceInfo"/>
	</model:dataset>
	<model:dataset id="detailDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcFinanceInfoQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcFinanceInfo"/>
	</model:dataset>
	<model:dataset id="cityDataSet" cmd="com.inspur.cams.comm.extuser.cmd.ComExtUserQueryCmd" method="getNongCunUser" pageSize="200">
		<model:record fromBean="com.inspur.cams.comm.extuser.data.ComExtUser"/>
			<model:params>
			<model:param name="type" value='C'/>
		</model:params>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R19'/>
			<model:param name="organType" value='N'/>
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
					<td class="FieldLabel" >填报单位：</td>
					<td class="FieldInput" ><label field="organName"/></td>
					<td class="FieldLabel" >汇总年度：</td>
					<td class="FieldInput" ><input type="text" field="yearly" id="sumyearly" maxlength="30" /> <font color="red">*</font></td>
					<td class="FieldLabel" >填报日期：</td>
					<td class="FieldInput" ><select id="reportDate" field="reportDate" onchange="getData()"><option dataset="reportWorkDataSet"/></select><font color="red">*</font></td>
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
		<next:RadioBoxColumn/>
		<next:Column field="organName" header="单位名称" width="15%" sortable="false" renderer="statusRender"/>
		<next:Column field="yearly" header="年度" width="10%" sortable="false" align="right"/>
		<next:Column field="gdpMon" header="生产总值" width="10%" sortable="false" align="right"/>
		<next:Column field="agricultureMon" header="农业产值" width="10%" sortable="false" align="right"/>
		<next:Column field="personMon" header="人均纯收入" width="10%" sortable="false" align="right"/>
		<next:Column field="financeMon" header="财政收入" width="10%" sortable="false" align="right"/>
		<next:Column field="reportDate" header="填报日期" width="10%" editable="false" sortable="true" align="center"><next:ComboBox dataset="reportWorkDataSet"/></next:Column>
		<next:Column field="status" header="填报状态" width="10%" editable="false" sortable="false" align="center"><next:ComboBox dataset="statusDataSet"/></next:Column>
		<next:Column field="submitDate" header="上报日期" width="10%" sortable="false" align="center"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="detailDataSet"/>
	</next:BottomBar>
</next:EditGridPanel>

<next:Window id="detailWin" title="明细" resizable="false" width="800" height="300" modal="true" closeAction="hide" autoScroll="true">
	<next:Panel height="260">
		<next:Html>
			<form id="form1" method="post" dataset="detailDataSet" onsubmit="return false" class="L5form">
			<fieldset id="cdcFieldset">
			<legend>填报情况</legend>
				<table width="100%">
					<tr>
						<td class="FieldLabel">填报单位：</td>
						<td class="FieldInput" colspan="3"><label field="organName"/></td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width:18%">填报日期：</td>
						<td class="FieldInput" style="width:35%"><label field="reportDate" dataset="reportWorkDataSet"/></td>
						<td class="FieldLabel" style="width:15%">上报日期：</td>
						<td class="FieldInput" style="width:30%"><label field="submitDate"/></td>
					</tr>
				</table>
			</fieldset>
			<fieldset id="cdcFieldset">
			<legend>经济基本情况</legend>
				<table width="100%">
					<tr>
						<td class="FieldLabel" style="width:18%">年度：</td>
						<td class="FieldInput" style="width:36%"><label id="yearly" field="yearly"  /></td>
						<td class="FieldLabel" style="width:16%"></td>
						<td class="FieldInput" style="width:30%"></td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width:18%">生产总值：</td>
						<td class="FieldInput" style="width:36%"><label id="gdpMon" field="gdpMon"  renderer="reRender" /></td>
						<td class="FieldLabel" style="width:16%">农业产值：</td>
						<td class="FieldInput" style="width:36%"><label id="agricultureMon" field="agricultureMon" renderer="reRender"  /></td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width:18%">人均收入：</td>
						<td class="FieldInput" style="width:36%"><label id="personMon" field="personMon"  renderer="peRender" /></td>
						<td class="FieldLabel" style="width:16%">财政收入：</td>
						<td class="FieldInput" style="width:36%"><label id="financeMon" field="financeMon" renderer="reRender"  /></td>
					</tr>
				</table>
			</fieldset>
			</form>
		</next:Html>
	</next:Panel>
</next:Window>
</body>
</html>