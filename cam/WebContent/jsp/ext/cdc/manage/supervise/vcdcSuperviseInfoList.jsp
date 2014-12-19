<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>农村民主监督列表</title>
<next:ScriptManager/>
<script type="text/javascript" src="vcdcSuperviseInfoList.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
<jsp:include page="../util/cdcReportNotice.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="superviseDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcSuperviseReportQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcSuperviseReport"/>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R15'/>
			<model:param name="organType" value='N'/>
		</model:params>
	</model:dataset>
	<model:dataset id="insertDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R15'/>
			<model:param name="organType" value='N'/>
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
<next:EditGridPanel id="grid" dataset="superviseDataSet" width="100%" stripeRows="true" height="99.9%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"/>
		<next:ToolBarItem id="sum1" iconCls="add" text="汇总" handler="sumInsert"/>
		<next:ToolBarItem id="sum2" iconCls="undo" text="重新汇总" handler="sumRedo"/>
		<next:ToolBarItem id="sum3" iconCls="detail" text="明细" handler="sumDetail"/>
		<next:ToolBarItem id="detail1" iconCls="add" text="填报" handler="insert"/>
		<next:ToolBarItem id="detail2" iconCls="edit" text="修改" handler="update"/>
		<next:ToolBarItem id="detail3" iconCls="detail" text="明细" handler="detail"/>
		<next:ToolBarItem iconCls="upload" text="上报" handler="report"/>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn/>
		<next:RadioBoxColumn/>
		<next:Column field="organName" header="单位名称" width="15%" sortable="false" renderer="statusListRender"/>
		<next:Column field="publishNum" header="经村委会提出<br>公开方案个数" width="10%" sortable="false" align="center"/>
		<next:Column field="noPublishNum" header="未经村委会提出<br>公开方案个数" width="10%" sortable="false" align="center"/>
		<next:Column field="auditNum" header="经村务监督委员会<br>审查、补充、完善个数" width="10%" sortable="false" align="center"/>
		<next:Column field="noAuditNum" header="未经村务监督委员会<br>审查、补充、完善个数" width="10%" sortable="false" align="center"/>
		<next:Column field="discussNum" header="经村党组织和村委会<br>联席会议讨论确定个数" width="10%" editable="false" sortable="true" align="center"/>
		<next:Column field="noDiscussNum" header="未经村党组织和村委会<br>联席会议讨论确定个数" width="10%" editable="false" sortable="false" align="center"/>
		<next:Column field="partYear" header="年度" width="10%" sortable="false" align="center"/>
		<next:Column field="partSeason" header="季度" width="10%" sortable="false" align="center"/>
		<next:Column field="partMonth" header="月度" width="10%" sortable="false" align="center"/>
		<next:Column field="partImm" header="即时" width="10%" sortable="false" align="center"/>
		<next:Column field="govYear" header="年度" width="10%" sortable="false" align="center"/>
		<next:Column field="govSeason" header="季度" width="10%" sortable="false" align="center"/>
		<next:Column field="govMonth" header="月度" width="10%" sortable="false" align="center"/>
		<next:Column field="govImm" header="即时" width="10%" sortable="false" align="center"/>
		<next:Column field="affairYear" header="年度" width="10%" sortable="false" align="center"/>
		<next:Column field="affairSeason" header="季度" width="10%" sortable="false" align="center"/>
		<next:Column field="affairMonth" header="月度" width="10%" sortable="false" align="center"/>
		<next:Column field="affairImm" header="即时" width="10%" sortable="false" align="center"/>
		<next:Column field="financeYear" header="年度" width="10%" sortable="false" align="center"/>
		<next:Column field="financeSeason" header="季度" width="10%" sortable="false" align="center"/>
		<next:Column field="financeMonth" header="月度" width="10%" sortable="false" align="center"/>
		<next:Column field="financeImm" header="即时" width="10%" sortable="false" align="center"/>
		<next:Column field="placardNum" header="公开栏" width="15%" sortable="false" align="center"/>
		<next:Column field="webNum" header="网络" width="15%" sortable="false" align="center"/>
		<next:Column field="meetingNum" header="民主听证会" width="15%" sortable="false" align="center"/>
		<next:Column field="paperNum" header="明白纸" width="10%" sortable="false" align="center"/>
		<next:Column field="otherNum" header="其他" width="15%" sortable="false" align="center"/>
		<next:Column field="mbNum" header="被评议人数" width="15%" sortable="false" align="center"/>
		<next:Column field="mbExcellentNum" header="优秀人数" width="15%" sortable="false" align="center"/>
		<next:Column field="mbCompetentNum" header="称职人数" width="15%" sortable="false" align="center"/>
		<next:Column field="mbUncompetentNum" header="不称职人数" width="15%" sortable="false" align="center"/>
		<next:Column field="emNum" header="被评议人数" width="15%" sortable="false" align="center"/>
		<next:Column field="emExcellentNum" header="优秀人数" width="15%" sortable="false" align="center"/>
		<next:Column field="emCompetentNum" header="称职人数" width="15%" sortable="false" align="center"/>
		<next:Column field="emUncompetentNum" header="不称职人数" width="15%" sortable="false" align="center"/>
		<next:Column field="reportDate" header="填报日期" width="10%" editable="false" sortable="true" align="center"><next:ComboBox dataset="reportWorkDataSet"/></next:Column>
		<next:Column field="status" header="填报状态" width="10%" editable="false" sortable="true" align="center"><next:ComboBox dataset="statusDataSet"/></next:Column>
		<next:Column field="submitDate" header="上报日期" width="10%" sortable="true" align="center"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="superviseDataSet"/>
	</next:BottomBar>
	<next:ExtendConfig>
	   		plugins:new L5.ux.grid.ColumnHeaderGroup({
        		rows: [
        			  [{header:'',start:2,colspan:1},{header:'村务公开程序',start:3,colspan:6},{header:'公开内容',start:9,colspan:16},{header:'公开形式',start:25,colspan:5},{header:'民主评议',start:30,colspan:8},{header:'',start:38,colspan:3}],
        			  [{header:'',start:2,colspan:1},{header:'',start:3,colspan:6},{header:'党务公开',start:9,colspan:4},{header:'政务公开',start:13,colspan:4},{header:'事务公开',start:17,colspan:4},{header:'财务公开',start:21,colspan:4},{header:'',start:25,colspan:5},{header:'村民委员会成员',start:30,colspan:4},{header:'由村集体承担误工补贴人员',start:34,colspan:4},{header:'',start:38,colspan:3}]
        			  ]
    		})
	</next:ExtendConfig>
</next:EditGridPanel>
</body>
</html>