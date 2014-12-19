<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>社区社会组织汇总</title>
<next:ScriptManager/>
<script type="text/javascript" src="vcdcOrganInfoSum.js"></script>
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
	<model:dataset id="sumDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcOrganReportQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcOrganReport"/>
	</model:dataset>
	<model:dataset id="detailDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcOrganReportQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcOrganReport"/>
		<model:params>
			<model:param name="REPORT_TYPE" value='N'/>
			<model:param name="ORGAN_TYPE" value='1'/>
		</model:params>
	</model:dataset>
	<model:dataset id="cityDataSet" cmd="com.inspur.cams.comm.extuser.cmd.ComExtUserQueryCmd" method="getNongCunUser" pageSize="200">
		<model:record fromBean="com.inspur.cams.comm.extuser.data.ComExtUser"/>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R10'/>
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
		<next:RowNumberColumn width="45"/>
		<next:RadioBoxColumn/>
		<next:Column field="organName" header="单位名称" width="15%" sortable="false" renderer="statusRender"/>
		<next:Column field="communityNum" header="社区数量" width="8%" sortable="false" align="right" summaryType="sum"/>
		<next:Column field="organNum" header="社会组织总数" width="10%" sortable="false" align="right" summaryType="sum"/>
		<next:Column field="organNum" header="社会组织平均数" width="10%" sortable="false" align="right" renderer="avgRender"/>
		<next:Column field="morgNum" header="主管单位总数" width="10%" sortable="false" align="right" summaryType="sum"/>
		<next:Column field="kindOneNum" header="行业协会类个数" width="10%" sortable="false" align="right" summaryType="sum"/>
		<next:Column field="kindTwoNum" header="社会服务类个数" width="10%" sortable="false" align="right" summaryType="sum"/>
		<next:Column field="kindThreeNum" header="公益慈善类个数" width="10%" sortable="false" align="right" summaryType="sum"/>
		<next:Column field="kindFourNum" header="其他类个数" width="10%" sortable="false" align="right" summaryType="sum"/>
		<next:Column field="memberNum" header="成员总数" width="10%" sortable="false" align="right" summaryType="sum"/>
		<next:Column field="memberNum" header="成员平均数" width="10%" sortable="false" align="right" renderer="avgRender"/>
		<next:Column field="officialNum" header="办公场所数量" width="10%" sortable="false" align="right" summaryType="sum"/>
		<next:Column field="officialArea" header="办公场所总面积" width="10%" sortable="false" align="right" summaryType="sum"/>
		<next:Column field="officialArea" header="办公场所平均面积" width="10%" sortable="false" align="right" renderer="avgRender"/>
		<next:Column field="reportDate" header="填报日期" width="10%" editable="false" sortable="true" align="center"><next:ComboBox dataset="reportWorkDataSet"/></next:Column>
		<next:Column field="status" header="填报状态" width="10%" editable="false" sortable="false" align="center"><next:ComboBox dataset="statusDataSet"/></next:Column>
		<next:Column field="submitDate" header="上报日期" width="10%" sortable="false" align="center"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="detailDataSet"/>
	</next:BottomBar>
</next:EditGridPanel>

<next:Window id="detailWin" title="明细" resizable="false" width="800" height="267" modal="true" closeAction="hide" autoScroll="true">
<next:Panel>
<next:Html>
<form id="form2" method="post" dataset="detailDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>填报情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">填报单位：</td>
			<td class="FieldInput" style="width:27%"><label field="organName"/></td>
			<td class="FieldLabel" style="width:13%">社区数量：</td>
			<td class="FieldInput" style="width:42%"><label id="communityNum" field="communityNum"/></td>
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
<legend>社会组织状况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="text-align:center;width:10%" rowspan="4">社会组织<br>状况</td>
			<td class="FieldLabel" style="width:15%">社会组织总数：</td>
			<td class="FieldInput" style="width:15%"><label field="organNum" renderer="gRender"/></td>
			<td class="FieldLabel" style="width:15%">主管单位总数：</td>
			<td class="FieldInput" style="width:15%"><label field="morgNum" renderer="gRender"/></td>
			<td class="FieldLabel" style="width:15%">行业协会类个数：</td>
			<td class="FieldInput" style="width:15%"><label field="kindOneNum" renderer="gRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">社会服务类个数：</td>
			<td class="FieldInput"><label field="kindTwoNum" renderer="gRender"/></td>
			<td class="FieldLabel">公益慈善类个数：</td>
			<td class="FieldInput"><label field="kindThreeNum" renderer="gRender"/></td>
			<td class="FieldLabel">其他类个数：</td>
			<td class="FieldInput"><label field="kindFourNum" renderer="gRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">成员总数：</td>
			<td class="FieldInput"><label field="memberNum" renderer="pRender"/></td>
			<td class="FieldLabel">办公场所数量：</td>
			<td class="FieldInput"><label field="officialNum" renderer="gRender"/></td>
			<td class="FieldLabel">办公场所总面积：</td>
			<td class="FieldInput"><label field="officialArea" renderer="aRender"/></td>
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