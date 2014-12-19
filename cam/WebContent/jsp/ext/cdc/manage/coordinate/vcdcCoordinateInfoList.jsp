<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>社区建设领导协调机制列表</title>
<next:ScriptManager/>
<script type="text/javascript" src="vcdcCoordinateInfoList.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
<jsp:include page="../util/cdcReportNotice.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="coordinateDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcCoordinateInfoQueryCmd"  method="queryList" pageSize="20" >
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcCoordinateInfo"/>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R17'/>
			<model:param name="organType" value='N'/>
		</model:params>
	</model:dataset>
	<model:dataset id="insertDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R17'/>
			<model:param name="organType" value='N'/>
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
	<model:dataset id="YorNDataSet" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
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
<next:EditGridPanel id="grid" dataset="coordinateDataSet" width="100%" stripeRows="true" height="99.9%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"/>
		<next:ToolBarItem id="detail1" iconCls="add" text="填报" handler="insert"/>
		<next:ToolBarItem id="detail2" iconCls="edit" text="修改" handler="update"/>
		<next:ToolBarItem id="sum3" iconCls="detail" text="明细" handler="detail"/>
		<next:ToolBarItem iconCls="upload" id="report" text="上报" handler="report"/>
		<next:ToolBarItem iconCls="delete" id="rejectButton" text="驳回" handler="audit"/>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn/>
		<next:RadioBoxColumn/>
		<next:Column field="ORGANNAME" header="单位名称" width="10%" sortable="false" renderer="statusListRender"/>
		<next:Column field="IFFOUND" header="是否成立领导协调机制" width="10%" sortable="true" align="right" dataset = "YorNDataSet"/>
		<next:Column field="NAME" header="名称" width="8%" sortable="false" align="right"/>
		<next:Column field="DUTY" header="职责" width="8%" sortable="false" align="right"/>
		<next:Column field="DEPARTMENT" header="牵头部门" width="8%" sortable="false" align="right"/>
		<next:Column field="LINKPEOPLE" header="联系人姓名" width="8%" editable="false" sortable="true" align="center" />
		<next:Column field="PHONE" header="联系人电话(座机)" width="8%" editable="false" sortable="true" align="center" />
		<next:Column field="POSITION" header="联系人职责" width="8%" editable="false" sortable="true" align="center" />
		<next:Column field="IFBUDGET" header="是否纳入财政预算" width="10%" editable="false" sortable="true" align="center" dataset = "YorNDataSet" />
		<next:Column field="CRITERION" header="财政预算标准" width="8%" editable="false" sortable="true" align="center" />
		<next:Column field="STATUS" header="填报状态" width="8%" editable="true" sortable="false" align="center" ><next:ComboBox dataset="statusDataSet"/></next:Column>
		<next:Column field="SUBMITDATE" header="上报日期" width="10%" sortable="true" align="center"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="coordinateDataSet"/>
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>