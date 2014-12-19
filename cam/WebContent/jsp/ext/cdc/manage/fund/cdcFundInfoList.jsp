<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>城市社区经费列表</title>
<next:ScriptManager/>
<script type="text/javascript" src="cdcFundInfoList.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
<jsp:include page="../util/cdcReportNotice.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="fundDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcFundInfoQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcFundInfo"/>
	</model:dataset>
	
	<model:dataset id="queryDs" cmd="com.inspur.cams.cdc.base.cmd.CdcFundInfoQueryCmd" pageSize="-1">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcFundInfo"/>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R05'/>
			<model:param name="organType" value='C'/>
		</model:params>
	</model:dataset>
	<model:dataset id="insertDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R05'/>
			<model:param name="organType" value='C'/>
		</model:params>
	</model:dataset>
	<model:dataset id="OrgCodeDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="false">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='COM_EXT_USER'></model:param>
			<model:param name="value" value='USER_ID'></model:param>
			<model:param name="text" value='AREA_CODE'></model:param>>
		</model:params>
	</model:dataset>
	<model:dataset id="statusDataSet" enumName="CDC.STATUS" autoLoad="true" global="true"/>
</model:datasets>
<next:Panel width="100%" border="0">
	<next:Html>
	<fieldset style="overflow:visible;" class="GroupBox">
	<legend class="GroupBoxTitle">查询条件</legend>
		<form class="L5form">
			<table border="1" width="100%">
				<tr>
					<td class="FieldLabel" style="width:10%">填报日期：</td>
					<td class="FieldInput" style="width:12%"><select id="reportDate" ><option dataset="reportWorkDataSet"/></select></td>
					<td class="FieldLabel" style="width:10%">填报状态：</td>
					<td class="FieldInput" style="width:12%"><select id="status" field="status"><option dataset="statusDataSet"/></select></td>
					<td class="FieldInput" style="width:37%"><button onclick="query()">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;<button type="reset">重置</button></td>
				</tr>
			</table>
		</form>
	</fieldset>
	</next:Html>
</next:Panel>
<next:EditGridPanel id="grid" dataset="fundDataSet" width="100%" stripeRows="true" height="99.9%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"/>
		<next:ToolBarItem id="sum1" iconCls="add" text="汇总" handler="sumInsert"/>
		<next:ToolBarItem id="sum2" iconCls="undo" text="重新汇总" handler="sumRedo"/>
		<next:ToolBarItem id="sum3" iconCls="detail" text="汇总明细" handler="sumDetail"/>
		<next:ToolBarItem id="detail1" iconCls="add" text="填报" handler="insert"/>
		<next:ToolBarItem id="detail2" iconCls="edit" text="修改" handler="update"/>
		<next:ToolBarItem id="detail3" iconCls="detail" text="明细" handler="detail"/>
		<next:ToolBarItem id="export" iconCls="export" text="导出Excel" handler="exportExcel"/>
		<next:ToolBarItem iconCls="upload" text="上报" handler="report"/>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn/>
		<next:RadioBoxColumn/>
		<next:Column id="organName" header="单位名称" field="organName" width="90"  renderer="statusListRender" />
		
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
	
		<next:Column id="useOtherMon" header="其他金额(万元)" field="useOtherMon" width="90" />
		
		<next:Column field="reportDate" header="填报日期" editable="false" sortable="true" align="center"><next:ComboBox dataset="reportWorkDataSet"/></next:Column>
		<next:Column field="status" header="填报状态"  editable="false" sortable="true" align="center"><next:ComboBox dataset="statusDataSet"/></next:Column>
		<next:Column field="submitDate" header="上报日期"  sortable="true" align="center"/>
	
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="fundDataSet"/>
	</next:BottomBar>
		<next:ExtendConfig>
	   		plugins:new L5.ux.grid.ColumnHeaderGroup({
        		rows: [
        			  [{header:'',start:0,colspan:3},{header:'社区年度办公经费(单位 万元)',start:3,colspan:5},{header:'社区年度专项经费(单位 万元)',start:8,colspan:9}],
        			  [{header:'',start:0,colspan:3},{header:'',start:3,colspan:1},{header:'来源',start:4,colspan:4},{header:'',start:8,colspan:1},{header:'来源',start:9,colspan:4},{header:'用途',start:13,colspan:4}]
    		]})
	</next:ExtendConfig>
</next:EditGridPanel>
</body>
</html>