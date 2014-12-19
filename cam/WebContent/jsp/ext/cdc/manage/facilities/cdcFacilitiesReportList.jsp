<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>城市社区基础设施列表</title>
<next:ScriptManager/>
<script type="text/javascript" src="cdcFacilitiesReportList.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript">
	var userStatus = "CdcFacilitiesReportList.jsp";
</script>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
<jsp:include page="../util/cdcReportNotice.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="fReportDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcFacilitiesReportQueryCmd" method="queryList" pageSize="20">
	</model:dataset>
	<model:dataset id="queryDs" cmd="com.inspur.cams.cdc.base.cmd.CdcFacilitiesReportQueryCmd" pageSize="-1">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcFacilitiesReport"/>
		<model:params>
			<model:param name="REPORT_TYPE" value='C'/>
		</model:params>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R06'/>
			<model:param name="organType" value='C'/>
		</model:params>
	</model:dataset>
	<model:dataset id="insertDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R06'/>
			<model:param name="organType" value='C'/>
		</model:params>
	</model:dataset>
	<!-- 行政区划 -->
	<model:dataset id="OrgCodeDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="false">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='COM_EXT_USER'></model:param>
			<model:param name="value" value='USER_ID'></model:param>
			<model:param name="text" value='AREA_CODE'></model:param>
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
<next:EditGridPanel id="grid" dataset="fReportDataSet" width="100%" stripeRows="true" height="99.9%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"/>
		<next:ToolBarItem id="sum1" iconCls="add" text="汇总" handler="sumInsert"/>
		<next:ToolBarItem id="sum2" iconCls="undo" text="重新汇总" handler="sumRedo"/>
		<next:ToolBarItem id="sum3" iconCls="detail" text="汇总明细" handler="sumDetail"/>
		<next:ToolBarItem id="detail1" iconCls="add" text="填报" handler="insert"/>
		<next:ToolBarItem id="detail2" iconCls="edit" text="修改" handler="update"/>
		<next:ToolBarItem id="detail3" iconCls="detail" text="明细" handler="detail"/>
		<next:ToolBarItem id="export" iconCls="export" text="导出Excel" handler="exportExcel"/>
		<next:ToolBarItem iconCls="upload" id = "report" text="上报" handler="report"/>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn/>
		<next:RadioBoxColumn/>
		<next:Column id="ORGANNAME" header="单位名称" field="ORGANNAME" width="90" renderer="statusListRender" />
		<next:Column id="offNum" header="数量(个)" field="OFFNUM" width="90" />
		<next:Column id="offArea" header="建筑面积(m2)" field="OFFAREA" width="90" />
		<next:Column id="offYear" header="投入使用年份(年)" field="OFFYEAR" width="110" />
	
		<next:Column id="serviceNum" header="个数(个)" field="SERVICENUM" width="90" />
		<next:Column id="serviceArea" header="面积(m2)" field="SERVICEAREA" width="90" />
		<next:Column id="serviceYear" header="投入使用年份(年)" field="SERVICEYEAR" width="110" />
		
		<next:Column id="policeNum" header="个数(个)" field="POLICENUM" width="90" />
		<next:Column id="policeArea" header="面积(m2)" field="POLICEAREA" width="90" />
		<next:Column id="policeYear" header="投入使用年份(年)" field="POLICEYEAR" width="110" />
	
		<next:Column id="clinicNum" header="个数(个)" field="CLINICNUM" width="90" />
		<next:Column id="clinicArea" header="面积(m2)" field="CLINICAREA" width="90" />
		<next:Column id="clinicYear" header="投入使用年份(年)" field="CLINICYEAR" width="110" />
	
		<next:Column id="libNum" header="个数(个)" field="LIBNUM" width="90" />
		<next:Column id="libArea" header="面积(m2)" field="LIBAREA" width="90" />
		<next:Column id="libYear" header="投入使用年份(年)" field="LIBYEAR" width="110" />
	
		<next:Column id="actionNum" header="个数(个)" field="ACTIONNUM" width="90" />
		<next:Column id="actionArea" header="面积(m2)" field="ACTIONAREA" width="90" />
		<next:Column id="actionYear" header="投入使用年份(年)" field="ACTIONYEAR" width="110" />
	
		<next:Column id="handNum" header="个数(个)" field="HANDNUM" width="90" />
		<next:Column id="handArea" header="面积(m2)" field="HANDAREA" width="90" />
		<next:Column id="handYear" header="投入使用年份(年)" field="HANDYEAR" width="110" />
		
		<next:Column id="offMon" header="投入资金(万元)" field="OFFMON" width="90" />
		<next:Column id="offFinanceMon" header="财政拨款(万元)" field="OFFFINACEMON" width="90" />
		<next:Column id="offSelfMon" header="自筹(万元)" field="OFFSELFMON" width="90" />
		<next:Column id="offEndowMon" header="社会捐助(万元)" field="OFFEMDOWNUM" width="90" />
		<next:Column id="offOtherMon" header="其他(万元)" field="OFFOTHERMON" width="90" />
		
		<next:Column id="outNum" header="数量(个)" field="OUTNUM" width="90" />
		<next:Column id="outArea" header="面积(m2)" field="OUTAREA" width="90" />
		<next:Column id="outYear" header="投入使用年份(年)" field="OUTYEAR" width="110" />
		<next:Column id="outMon" header="投入资金(万元)" field="OUTMON" width="90" />
		<next:Column id="outFinanceMon" header="财政拨款(万元)" field="OUTFINANCEMON" width="90" />
		<next:Column id="outSelfMon" header="自筹(万元)" field="OUTSELFMON" width="90" />
		<next:Column id="outEnbowMon" header="社会捐助(万元)" field="OUTENBOWMON" width="90" />
		<next:Column id="outOtherMon" header="其他(万元)" field="OUTOTHERMON" width="90" />
		<next:Column id="REPORTDATE" header="填报日期" field="REPORTDATE" width="90" sortable="true" align="center" ><next:ComboBox dataset="reportWorkDataSet"/></next:Column>
		<next:Column id="STATUS" header="上报状态" field="STATUS" width="90" sortable="true" align="center" ><next:ComboBox dataset="statusDataSet"/></next:Column>
		<next:Column id="SUBMITDATE" header="上报日期" field="SUBMITDATE" sortable="true" width="90" align="center" />
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="fReportDataSet"/>
	</next:BottomBar>
		<next:ExtendConfig>
	   		plugins:new L5.ux.grid.ColumnHeaderGroup({
        		rows: [
        			  [{header:'社区工作用房',start:3,colspan:3},{header:'社区服务设施用房',start:6,colspan:18},
        			  {header:'社区工作用房、社区服务设施用房投入资金',start:24,colspan:5},{header:'社区室外活动场地',start:29,colspan:8},{header:'',start:37,colspan:3}],
        			  [{header:'社区服务大厅',start:6,colspan:3},{header:'社区警务室',start:9,colspan:3},{header:'社区卫生室',start:12,colspan:3},
        			  {header:'社区图书室',start:15,colspan:3},{header:'社区文娱活动室',start:18,colspan:3},{header:'残疾人活动室',start:21,colspan:3},
        			  {header:'',start:24,colspan:1},{header:'资金来源',start:25,colspan:4},{header:'资金来源',start:33,colspan:4},{header:'',start:37,colspan:3}]
    		]})
	</next:ExtendConfig>
</next:EditGridPanel>
</body>
</html>