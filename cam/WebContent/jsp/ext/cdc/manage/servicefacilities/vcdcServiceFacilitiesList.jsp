<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>农村社区服务设施</title>
<next:ScriptManager/>
<script type="text/javascript" src="vcdcServiceFacilitiesList.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
<jsp:include page="../util/cdcReportNotice.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="sFacilitiesDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcServiceFacilitiesQueryCmd" method="queryList" pageSize="20" >
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R21'/>
			<model:param name="organType" value='N'/>
		</model:params>
	</model:dataset>
	<model:dataset id="insertDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R21'/>
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
	<!-- 是否 -->
	<model:dataset id="YNDataSet" enumName="COMM.YESORNO" global="true" autoLoad="true"  />
	<!-- 建设状态 -->
	<model:dataset id="offconstatusDataSet" enumName="CDC.OFF_CON_STATUS" global="true" autoLoad="true"  />
	<!-- 建设性质 -->
	<model:dataset id="offconkindDataSet" enumName="CDC.OFF_CON_KIND" global="true" autoLoad="true"  />
	<!-- 建设模式 -->
	<model:dataset id="sercontypeDataSet" enumName="CDC.SER_CON_TYPE" global="true" autoLoad="true"  />
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
<next:EditGridPanel id="grid" dataset="sFacilitiesDataSet" width="100%" stripeRows="true" height="99.9%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"/>
		<next:ToolBarItem id="sum1" iconCls="add" text="汇总" handler="sumInsert"/>
		<next:ToolBarItem id="sum2" iconCls="undo" text="重新汇总" handler="sumRedo"/>
		<next:ToolBarItem id="sum3" iconCls="detail" text="汇总明细" handler="sumDetail"/>
		<next:ToolBarItem id="detail1" iconCls="add" text="填报" handler="insert"/>
		<next:ToolBarItem id="detail2" iconCls="edit" text="修改" handler="update"/>
		<next:ToolBarItem id="detail3" iconCls="detail" text="明细" handler="detail"/>
		<next:ToolBarItem iconCls="upload" text="上报" handler="report"/>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn/>
		<next:RadioBoxColumn/>
		<next:Column id="organName" header="填报单位名称" field="ORGAN_NAME" width="90"  renderer="statusListRender">
		</next:Column>
	
		<next:Column id="offConStatus" header="建设状态" field="OFF_CON_STATUS" width="90" dataset="offconstatusDataSet" >
		</next:Column>
	
		<next:Column id="offConKind" header="建设性质" field="OFF_CON_KIND" width="90" dataset="offconkindDataSet" >
		</next:Column>
	
		<next:Column id="offYear" header="使用年份" field="OFF_YEAR" width="90" >
		</next:Column>
	
		<next:Column id="offConArea" header="建筑面积(㎡)" field="OFF_CON_AREA" width="90" >
		</next:Column>
	
		<next:Column id="offHouseArea" header="房间面积(㎡)" field="OFF_HOUSE_AREA" width="90" >
		</next:Column>
	
		<next:Column id="offComputeNum" header="电脑数量" field="OFF_COMPUTE_NUM" width="90" >
		</next:Column>
	
		<next:Column id="serConType" header="建设模式" field="SER_CON_TYPE" width="90" dataset="sercontypeDataSet" >
		</next:Column>
	
		<next:Column id="serConStatus" header="建设状态" field="SER_CON_STATUS" width="90" dataset="offconstatusDataSet" >
		</next:Column>
	
		<next:Column id="serPlace" header="所在地" field="SER_PLACE" width="90" >
		</next:Column>
	
		<next:Column id="serVillageNum" header="覆盖自然村个数" field="SER_VILLAGE_NUM" width="90" >
		</next:Column>
	
		<next:Column id="serTotleArea" header="覆盖面积(㎡)" field="SER_TOTLE_AREA" width="90" >
		</next:Column>
	
		<next:Column id="serConArea" header="建筑面积(㎡)" field="SER_CON_AREA" width="90" >
		</next:Column>
	
		<next:Column id="serConKind" header="建设性质" field="SER_CON_KIND" width="90" dataset="offconkindDataSet" >
		</next:Column>
	
		<next:Column id="serConFlag" header="是否有标识" field="SER_CON_FLAG" width="90" dataset="YNDataSet">
		</next:Column>
	
		<next:Column id="serLen" header="服务半径" field="SER_LEN" width="90" >
		</next:Column>
	
		<next:Column id="reportDate" header="填报日期" field="REPORT_DATE" width="90" align="center" editable="false" sortable="true" ><next:ComboBox dataset="reportWorkDataSet"/></next:Column>
	
		<next:Column id="status" header="上报状态" field="STATUS" width="90" align="center" editable="false" sortable="true"><next:ComboBox dataset="statusDataSet"/></next:Column>
	
		<next:Column id="submitDate" header="上报日期" field="SUBMIT_DATE" sortable="true" width="100" align="center" />
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="sFacilitiesDataSet"/>
	</next:BottomBar>
	<next:ExtendConfig>
	   		plugins:new L5.ux.grid.ColumnHeaderGroup({
        		rows: [
        			  [{header:'',start:0,colspan:3},{header:'办公场所基本情况',start:3,colspan:6},{header:'社区服务设施建设情况',start:9,colspan:9},{header:'',start:18,colspan:3}]
    		]})
	</next:ExtendConfig>
</next:EditGridPanel>
</body>
</html>