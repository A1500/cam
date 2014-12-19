<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>城市社区服务列表</title>
<next:ScriptManager/>
<script type="text/javascript" src="cdcServiceInfoList.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
<jsp:include page="../util/cdcReportNotice.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="serviceReportDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcServiceReportQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcServiceReport"/>
	</model:dataset>
	
	<model:dataset id="queryDs" cmd="com.inspur.cams.cdc.base.cmd.CdcServiceReportQueryCmd" pageSize="-1">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcServiceReport"/>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R07'/>
			<model:param name="organType" value='C'/>
		</model:params>
	</model:dataset>
	<model:dataset id="insertDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R07'/>
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
					<td class="FieldInput" style="width:12%"><select id="reportDate"  ><option dataset="reportWorkDataSet"/></select></td>
					<td class="FieldLabel" style="width:10%">填报状态：</td>
					<td class="FieldInput" style="width:12%"><select id="status" field="status"><option dataset="statusDataSet"/></select></td>
					<td class="FieldInput" style="width:37%"><button onclick="query()">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;<button type="reset">重置</button></td>
				</tr>
			</table>
		</form>
	</fieldset>
	</next:Html>
</next:Panel>
<next:EditGridPanel id="grid" dataset="serviceReportDataSet" width="99%" stripeRows="true" height="99.9%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"/>
		<next:ToolBarItem id="sum1" iconCls="add" text="汇总" handler="sumInsert"/>
		<next:ToolBarItem id="sum2" iconCls="undo" text="重新汇总" handler="sumRedo"/>
		<next:ToolBarItem id="sum3" iconCls="detail" text="明细" handler="sumDetail"/>
		<next:ToolBarItem id="detail1" iconCls="add" text="填报" handler="insert"/>
		<next:ToolBarItem id="detail2" iconCls="edit" text="修改" handler="update"/>
		<next:ToolBarItem id="detail3" iconCls="detail" text="明细" handler="detail"/>
		<next:ToolBarItem id="export" iconCls="export" text="导出Excel" handler="exportExcel"/>
		<next:ToolBarItem iconCls="upload" text="上报" handler="report"/>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn/>
		<next:RadioBoxColumn/>
		<next:Column field="organName" header="单位名称"  sortable="false" renderer="statusListRender"/>
		<next:Column field="communityNum" header="社区数量" hidden="true" sortable="false" align="right"/>
		<next:Column field="communityNum" header="开展服务社区数"  sortable="false" align="right"/>
		<next:Column field="onceNum" header="一站式服务大厅数" sortable="false" align="right"/>
		<next:Column field="publicNum" header="服务项目数" sortable="false" align="right"/>
		<next:Column field="publicLocaleNum" header="现场办理项目数"  sortable="false" align="right"/>
		<next:Column field="publicSupplyNum" header="全程代理项目数" sortable="false" align="right"/>
		<next:Column field="publicOtherNum" header="其他项目数" sortable="false" align="right"/>
		<next:Column field="publicMorgNum" header="主管单位总数" sortable="false" align="right"/>
		<next:Column field="publicPeopleNum" header="服务人员数"  sortable="false" align="right"/>
		<next:Column field="publicDayNum" header="全天项目数"  sortable="false" align="right"/>
		<next:Column field="publicNotdayNum" header="非全天项目数"  sortable="false" align="right"/>
		<next:Column field="facilitateNum" header="项目数" sortable="false" align="right"/>
		<next:Column field="facilitateMorgNum" header="主管单位数" sortable="false" align="right"/>
		<next:Column field="facilitatePeopleNum" header="服务人员"  sortable="false" align="right"/>
		<next:Column field="facilitateArea" header="服务场所总面积" sortable="false" align="right"/>
		<next:Column field="facilitateArea" header="服务场所平均面积"  sortable="false" align="right"/>
		<next:Column field="facilitateDayNum" header="24小时服务项目数" sortable="false" align="right"/>
		<next:Column field="voluntNum" header="总数"  sortable="false" align="right"/>
		<next:Column field="voluntNum" header="平均个数"  sortable="false" align="right"/>
		<next:Column field="voluntYearNum" header="当年成立数量" sortable="false" align="right"/>
		<next:Column field="voluntChildNum" header="针对儿童个数" sortable="false" align="right"/>
		<next:Column field="voluntOldNum" header="针对老年人个数"  sortable="false" align="right"/>
		<next:Column field="voluntHandiNum" header="针对残疾人个数" sortable="false" align="right"/>
		<next:Column field="voluntDiffNum" header="针对困难群众个数"  sortable="false" align="right"/>
		<next:Column field="voluntOtherNum" header="针对其他个数"  sortable="false" align="right"/>
		<next:Column field="volunteerNum" header="总人数"  sortable="false" align="right"/>
		<next:Column field="volunteerNum" header="平均人数"  sortable="false" align="right"/>
		<next:Column field="regNum" header="注册人数"  sortable="false" align="right"/>
		<next:Column field="regNum" header="平均注册人数"  sortable="false" align="right"/>
		<next:Column field="reportDate" header="填报日期" editable="false" sortable="true" align="center"><next:ComboBox dataset="reportWorkDataSet"/></next:Column>
		<next:Column field="status" header="填报状态"  editable="false" sortable="true" align="center"><next:ComboBox dataset="statusDataSet"/></next:Column>
		<next:Column field="submitDate" header="上报日期"  sortable="true" align="center"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="serviceReportDataSet"/>
	</next:BottomBar>
	<next:ExtendConfig>
	   		plugins:new L5.ux.grid.ColumnHeaderGroup({
        		rows: [
        			  [{header:'公共服务',start:4,colspan:10},{header:'便民利民服务',start:14,colspan:6},{header:'志愿者服务',start:20,colspan:12}]
        			  ,[{header:'服务方式',start:7,colspan:3},{header:'服务时间',start:12,colspan:2},{header:'志愿者组织活动',start:20,colspan:8},{header:'志愿者组织人数',start:28,colspan:4}]
        			  ]
    		})
	</next:ExtendConfig>
</next:EditGridPanel>
</body>
</html>