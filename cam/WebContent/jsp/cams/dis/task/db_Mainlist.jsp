
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
	<head>
		<title>待办任务列表</title>
		<next:ScriptManager/>
		
		<script language="javascript">
		var organCode = '<%=BspUtil.getOrganCode()%>';
		var organType = '<%=BspUtil.getOrganType()%>';
		var organName = '<%=BspUtil.getOrganName()%>';
		function init() {
			query();
			L5.QuickTips.init();
			};
		function query(){
			
			batchDetailds.setParameter("organCode",organCode);		
			if(organType == 13){
				batchDetailds.setParameter("FILL_STATE@=",'2');	
				batchDetailds.load();
			}else if(organType == 14){
				batchDetailds.setParameter("FILL_STATE@=",'4');	
				batchDetailds.load();
			}
		}
		</script>
	</head>
<body>
<model:datasets>
	<model:dataset id="batchDetailds" cmd="com.inspur.cams.dis.base.cmd.DisReliefBatchDetailQueryCommand" method="queryBatchDetail" global="true">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisReliefBatchDetail">
		</model:record>
	</model:dataset>
	<model:dataset id="ReliefTypeDataset" enumName="DIS.ALLOCATION_PURPOSE" autoLoad="true"
		global="true"></model:dataset>
	
	<model:dataset id="fillstateDs" enumName="DIS.BATCHDETAIL_FILL_STATE" autoLoad="true"
		global="true">
	</model:dataset>
</model:datasets>

<next:GridPanel id="editGridPanel" name="disreliefinfoGrid" width="100%" stripeRows="true" clickToSelectedForChkSM="true" height="100%" dataset="batchDetailds" >
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>

		<next:Column header="批次名称" field="BATCH_NAME" width="90" >
			<next:TextField allowBlank="false"/>
		</next:Column>
	
		<next:Column header="填报单位" field="REQUIRED_ORGAN_NAME" width="90" >
			<next:TextField allowBlank="false"/>
		</next:Column>
		
		<next:Column header="填报状态" field="FILL_STATE" dataset="fillstateDs" width="90" >
			<next:TextField allowBlank="false"/>
		</next:Column>
		
		<next:Column header="救助类型" field="RELIEF_TYPE" dataset="ReliefTypeDataset" width="90" >
			<next:TextField allowBlank="false"/>
		</next:Column>
	
	
		<next:Column header="填报人" field="FILL_PEOPLE" width="90" >
			<next:TextField allowBlank="false"/>
		</next:Column>
	
		<next:Column header="填报时间" field="FILL_TIME" width="90" >
			<next:TextField allowBlank="false"/>
		</next:Column>
	
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="batchDetailds"/>
	</next:BottomBar>
</next:GridPanel>

</body>
</html>
