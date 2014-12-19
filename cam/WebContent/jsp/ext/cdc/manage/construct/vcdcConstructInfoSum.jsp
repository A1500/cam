<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>农村社区规划汇总</title>
<next:ScriptManager/>
<script type="text/javascript" src="vcdcConstructInfoSum.js"></script>
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
	<model:dataset id="sumDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcConstructReportQueryCmd" pageSize="10">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcConstructReport"/>
	</model:dataset>
	<model:dataset id="detailDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcConstructReportQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcConstructReport"/>
		<model:params>
			<model:param name="REPORT_TYPE" value='N'/>
		</model:params>
	</model:dataset>
	<model:dataset id="cityDataSet" cmd="com.inspur.cams.comm.extuser.cmd.ComExtUserQueryCmd" method="getNongCunUser" pageSize="200">
		<model:record fromBean="com.inspur.cams.comm.extuser.data.ComExtUser"/>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R22'/>
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
		<next:RadioBoxColumn/>
		<next:Column field="organName" header="单位名称" width="15%" sortable="false" renderer="statusRender"/>
		<next:Column field="communityNum" header="社区数" width="10%" sortable="false" align="right" summaryType="sum"/>
		<next:Column field="planArea" header="规划集中居住面积(㎡)" width="13%" sortable="false" align="right" summaryType="sum"/>
		<next:Column field="alreadyArea" header="已建成集中居住区面积(㎡)" width="15%" sortable="false" align="right" summaryType="sum"/>
		<next:Column field="populateNum" header="规划入住户数(户)" width="15%" sortable="false" align="right" summaryType="sum"/>
		<next:Column field="reportDate" header="填报日期" width="10%" editable="false" sortable="false" align="center"><next:ComboBox dataset="reportWorkDataSet"/></next:Column>
		<next:Column field="status" header="填报状态" width="10%" sortable="false" editable="false" align="center"><next:ComboBox dataset="statusDataSet"/></next:Column>
		<next:Column field="submitDate" header="上报日期" width="10%" sortable="false" align="center"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="detailDataSet"/>
	</next:BottomBar>
</next:EditGridPanel>

<next:Window id="detailWin" title="明细" resizable="false" width="800" height="400" modal="true" closeAction="hide" autoScroll="true">
	<next:Panel height="480">
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
			<legend>社区规划情况</legend>
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width:18%" rowspan="6">建设规划：</td>
					<td class="FieldLabel" style="width:12%" colspan="2">社区数：</td>
					<td class="FieldInput" style="width:12%"><label field = "communityNum" renderer="gRender" /></td>
					<td class="FieldLabel" style="width:12%">集中居住社区数：</td>
					<td class="FieldInput" style="width:12%"><label field = "collectNum" renderer="gRender" /></td>
					<td class="FieldLabel" style="width:12%">规划集中居住区面积：</td>
					<td class="FieldInput" style="width:12%"><label  field="planArea" renderer="aRender" /></td>
				</tr>
				<tr>
				<td class="FieldLabel" colspan="2" >已建成集中居住区面积：</td>
					<td class="FieldInput" ><label field="alreadyArea" renderer="aRender"  /></td>
					<td class="FieldLabel" >计划入住户数：</td>
					<td class="FieldInput" ><label  field="populateNum" renderer="hRender" /></td>
					<td class="FieldLabel" >已入住户数：</td>
					<td class="FieldInput" ><label field="alreadyPopulateNum" renderer="hRender" /></td>
				</tr>
				<tr>
					<td class="FieldLabel"  colspan="2">计划入住人数：</td>
					<td class="FieldInput" ><label  field="peopleNum" renderer="pRender" /></td>
					<td class="FieldLabel" >已入住人数：</td>
					<td class="FieldInput" colspan="3" ><label field="alreadyPeopleNum" renderer="pRender"  /></td>
				</tr>
				<tr>
					<td class="FieldLabel"  colspan="2">投入资金：</td>
					<td class="FieldInput" colspan="5"><label  field="investMon" renderer="mRender"  /></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width:9%" rowspan="2">资金来源：</td>
					<td class="FieldLabel"  >财政投入：</td>
					<td class="FieldInput" ><label  field="investFinanceMon" renderer="mRender" /></td>
					<td class="FieldLabel" >开发商：</td>
					<td class="FieldInput" ><label  field="investDeveloperMon" renderer="mRender" /></td>
					<td class="FieldLabel" >银行贷款：</td>
					<td class="FieldInput" ><label field="investBankMon" renderer="mRender" /></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width:9%" >居民垫付：</td>
					<td class="FieldInput" ><label  field="investResiderMon" renderer="mRender" /></td>
					<td class="FieldLabel" >其他：</td>
					<td class="FieldInput" colspan="3" ><label  field="investOtherMon" renderer="mRender" /></td>
				</tr>
				<tr>
					<td class="FieldLabel"  rowspan="3">服务中心建设规划：</td>
					<td class="FieldLabel" colspan="2">投入资金：</td>
					<td class="FieldInput" ><label  field="serviceMon" renderer="mRender" /></td>
					<td class="FieldLabel"  >建筑面积：</td>
					<td class="FieldInput" ><label  field="serviceArea" renderer="aRender" /></td>
					<td class="FieldLabel" >服务中心在中心村数：</td>
					<td class="FieldInput" ><label  field = "serviceCollectNum" renderer="gRender" /></td>
				</tr>
				<tr>
					<td class="FieldLabel"  rowspan="2">资金来源：</td>
					<td class="FieldLabel"  >财政投入：</td>
					<td class="FieldInput" ><label  field="serviceFinanceMon" renderer="mRender" /></td>
					<td class="FieldLabel" >自筹：</td>
					<td class="FieldInput"  colspan="3"><label  field="serviceSelfMon" renderer="mRender" /></td>
				</tr>
				<tr>
					<td class="FieldLabel"  >社会捐赠：</td>
					<td class="FieldInput" ><label  field="serviceEndowMon" renderer="mRender" /></td>
					<td class="FieldLabel" >其他：</td>
					<td class="FieldInput"  colspan="3"><label  field="serviceOtherMon" renderer="mRender" /></td>
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