<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>农村社区经费情况汇总</title>
<next:ScriptManager/>
<script type="text/javascript" src="vcdcFundInfoSum.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var fundId='<%=request.getParameter("fundId")%>';
</script>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
<jsp:include page="../util/cdcSum.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="sumDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcFundInfoQueryCmd" pageSize="10">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcFundInfo"/>
	</model:dataset>
	<model:dataset id="fundDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcFundInfoQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcFundInfo"/>
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
			<model:param name="reportType" value='R05'/>
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
<next:EditGridPanel id="grid" dataset="fundDataSet" width="100%" stripeRows="true" height="99.9%" hasSum="true">
	<next:TopBar>
		<next:ToolBarItem iconCls="return" text="返回上级" handler="getUp"/>
		<next:ToolBarItem symbol="->"/>
		<next:ToolBarItem iconCls="detail" text="明细" handler="detail"/>
		<next:ToolBarItem id="auditButton" iconCls="delete" text="驳回" handler="audit"/>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn/>
		<next:RadioBoxColumn/>
		<next:Column id="organName" header="单位名称" field="organName" width="90"  renderer="statusRender" />
		
		<next:Column id="offMon" header="金额(万元)" field="offMon" width="90" />
	
		<next:Column id="offFinanceMon" header="财政拨款金额(万元)" field="offFinanceMon" width="120" />
	
		<next:Column id="offSelfMon" header="自筹金额(万元)" field="offSelfMon" width="90" />
	
		<next:Column id="offEnbowMon" header="社会捐助金额(万元)" field="offEnbowMon" width="120" />
	
		<next:Column id="offOtherMon" header="其他金额(万元)" field="offOtherMon" width="90" />
	
		<next:Column id="sepMon" header="金额(万元)" field="sepMon" width="90" />
	
		<next:Column id="sepFinanceMon" header="财政拨款金额(万元)" field="sepFinanceMon" width="120" />
	
		<next:Column id="sepSelfMon" header="自筹金额(万元)" field="sepSelfMon" width="90" />
	
		<next:Column id="sepEnbowMon" header="社会捐助金额(万元)" field="sepEnbowMon" width="120" />
	
		<next:Column id="sepOtherMon" header="其他金额(万元)" field="sepOtherMon" width="90" />
	
		<next:Column id="useBuildMon" header="基础设施建设金额(万元)" field="useBuildMon" width="140" />
	
		<next:Column id="useActionMon" header="各项活动金额(万元)" field="useActionMon" width="120" />
	
		<next:Column id="useServiceMon" header="购买服务金额(万元)" field="useServiceMon" width="120" />
	
		<next:Column id="useOtherMon" header="其他金额(万元)" field="useOtherMon" width="110" />
	
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="fundDataSet"/>
	</next:BottomBar>
	<next:ExtendConfig>
	   		plugins:new L5.ux.grid.ColumnHeaderGroup({
        		rows: [
        			  [{header:'',start:0,colspan:3},{header:'社区年度办公经费',start:3,colspan:5},{header:'社区年度专项经费',start:8,colspan:9}],
        			  [{header:'',start:0,colspan:3},{header:'',start:3,colspan:1},{header:'来源',start:4,colspan:4},{header:'',start:8,colspan:1},{header:'来源',start:9,colspan:4},{header:'用途',start:13,colspan:4}]
    		]})
	</next:ExtendConfig>
</next:EditGridPanel>

<next:Window id="detailWin" title="明细" resizable="false" width="800" height="420" modal="true" closeAction="hide" autoScroll="true">
	<next:Panel height="380">
		<next:Html>
			<form id="form1" method="post" dataset="fundDataSet" onsubmit="return false" class="L5form">
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
			<legend>社区经费情况</legend>
			<table border="1"  width="100%" >
	   		<tr>
	   			<td  class="FieldLabel" rowspan="3" width="20%" >社区年度办公经费</td>
				<td  class="FieldLabel" width="20%">办公经费金额</td>
				<td class="FieldInput"  colspan="3" ><label name="offMon" field="offMon" renderer="mRender"  /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >办公经费财政拨款金额</td>
				<td class="FieldInput"><label name="offFinanceMon" field="offFinanceMon" renderer="mRender" /> </td>
			
				<td  class="FieldLabel" width="20%">办公经费自筹金额</td>
				<td class="FieldInput" width="20%"><label name="offSelfMon" field="offSelfMon" renderer="mRender"  /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >办公经费社会捐助金额</td>
				<td class="FieldInput"><label name="offEnbowMon" field="offEnbowMon" renderer="mRender" /> </td>
			
				<td  class="FieldLabel" >办公经费其他金额</td>
				<td class="FieldInput"><label name="offOtherMon" field="offOtherMon" renderer="mRender" /> </td>
			</tr>
	   		<tr>
	   			<td  class="FieldLabel" rowspan="5" >社区年度专项经费</td>
				<td  class="FieldLabel" >专项经费金额</td>
				<td class="FieldInput" colspan="3"><label name="sepMon" field="sepMon" renderer="mRender" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >专项经费财政拨款金额</td>
				<td class="FieldInput"><label name="sepFinanceMon" field="sepFinanceMon" renderer="mRender" /> </td>
			
				<td  class="FieldLabel" >专项经费自筹金额</td>
				<td class="FieldInput"><label name="sepSelfMon" field="sepSelfMon" renderer="mRender" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >专项经费社会捐助金额</td>
				<td class="FieldInput"><label name="sepEnbowMon" field="sepEnbowMon" renderer="mRender" /> </td>
			
				<td  class="FieldLabel" >专项经费其他金额</td>
				<td class="FieldInput"><label name="sepOtherMon" field="sepOtherMon" renderer="mRender" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >用途基础设施建设金额</td>
				<td class="FieldInput"><label name="useBuildMon" field="useBuildMon" renderer="mRender" /> </td>
			
				<td  class="FieldLabel" >用途各项活动金额</td>
				<td class="FieldInput"><label name="useActionMon" field="useActionMon" renderer="mRender" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >用途购买服务金额</td>
				<td class="FieldInput"><label name="useServiceMon" field="useServiceMon" renderer="mRender" /> </td>
			
				<td  class="FieldLabel" >用途其他金额</td>
				<td class="FieldInput"><label name="useOtherMon" field="useOtherMon" renderer="mRender" /> </td>
			</tr>
	   		
		</table>
			</fieldset>
			</form>
		</next:Html>
	</next:Panel>
</next:Window>
<next:Window id="rejectWin" title="驳回原因" resizable="false" width="400" height="200" modal="true" closeAction="hide" autoScroll="true">
<next:Html>
<form id="form1" method="post" dataset="fundDataSet" onsubmit="return false" class="L5form">
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