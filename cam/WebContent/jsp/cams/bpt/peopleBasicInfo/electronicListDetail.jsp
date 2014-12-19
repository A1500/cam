<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>档案管理列表</title>
<next:ScriptManager />
<script language="javascript">
			var peopleId='<%=request.getParameter("peopleId")%>';
			var organCode = '<%=BspUtil.getOrganCode()%>';
			var serviceType = '<%=request.getParameter("serviceType")%>';
		</script>
<script type="text/javascript" src="electronicListDetail.js"></script>
</head>
<body>
<model:datasets>
	<!-- 业务处理人员档案信息 -->
	<model:dataset id="dsPro"
		cmd="com.inspur.cams.bpt.manage.cmd.BptElectronicQueryCommand"
		method="queryProElectronic" global="true" pageSize="30">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptElectronic">
			<model:field name="YW_NAME" type="string"/>
		</model:record>
	</model:dataset>

	<model:dataset id="ds"
		cmd="com.inspur.cams.bpt.manage.cmd.BptElectronicQueryCommand"
		method="querySelectedContent" global="true" pageSize="30">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptElectronic"></model:record>
	</model:dataset>
	<!-- 业务类型 -->
	<model:dataset id="dsService"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BPT_SERVICE_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>
<next:Panel height="100%" width="100%">
	<next:GridPanel id="editGridPanelPro" name="baseinfopeopleGrid"
		width="100%" height="100%" stripeRows="true" dataset="dsPro"
		title="档案信息" >	
		<next:Columns>
			<next:RowNumberColumn header="序号" width="45" />
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column id="ywname" header="数据来源" field="YW_NAME" width="230">
				<next:TextField allowBlank="false" />
			</next:Column>
			<next:Column id="applyId" header="applyId" field="APPLY_ID" width="230" hidden="true">
				<next:TextField allowBlank="false" />
			</next:Column>
			<next:Column id="serviceType" header="业务类型" field="SERVICE_TYPE"
				width="330" dataset="dsService">
				<next:TextField allowBlank="false" />
			</next:Column>
			<next:TextField />
		</next:Columns>
	</next:GridPanel>
</next:Panel>
</body>

</html>
