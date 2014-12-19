<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
	<title>历史电子档案信息</title>
		<next:ScriptManager/>
		<script language="javascript">
					var peopleId='<%=request.getParameter("peopleId")%>';
					var organCode = '<%=BspUtil.getOrganCode()%>';
					var serviceType='<%=request.getParameter("serviceType")%>';
		</script>
	<script type="text/javascript" src="uploadFileHistory.js"></script>
</head>
<body>
<model:datasets>
	<!-- 业务处理人员档案信息 -->
	<model:dataset id="dsPro" cmd="com.inspur.cams.bpt.manage.cmd.BptElectronicQueryCommand" method="queryProElectronic" global="true" pageSize="30">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptElectronic">
			<model:field name="YW_NAME" type="string"/>
		</model:record>
	</model:dataset>
	<!-- 查询选中的电子档案信息 -->
	<model:dataset id="ds" cmd="com.inspur.cams.bpt.manage.cmd.BptElectronicQueryCommand" method="queryBaseInforSelectedContents" global="true" pageSize="30">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptElectronic"></model:record>
	</model:dataset>
	<!-- 业务类型 -->
	<model:dataset id="dsService" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BPT_SERVICE_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>
<next:Panel height="100%" width="100%">
	<next:GridPanel id="editGridPanelPro" name="baseinfopeopleGrid" width="100%" height="40%" stripeRows="true" dataset="dsPro" title="档案信息">
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="disable" text="关闭" handler="func_Close" />
		</next:TopBar>
		<next:Columns onRowSelect="selectService">
			<next:RowNumberColumn header="序号" width="45" />
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column id="ywname" header="业务处理" field="YW_NAME" width="230">
				<next:TextField allowBlank="false" />
			</next:Column>
			<next:Column id="serviceType" header="业务类型" field="SERVICE_TYPE" width="330" dataset="dsService">
				<next:TextField allowBlank="false"/>
			</next:Column>
			<next:TextField />
		</next:Columns>
	</next:GridPanel>
	<next:GridPanel id="GridPanel" name="uploadfile" width="100%" autoScroll="true" notSelectFirstRow="true" autoExpandColumn="catalogName" stripeRows="true" height="100%" dataset="ds" title="纸质档案存放信息">
		<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="detail" text="查看全部电子档案" handler="viewAll" />
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn width="50" header="编号"/>
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column id="catalogCode" header="附件类别代码" field="catalogCode" width="120" hidden="true">
			</next:Column>
			<next:Column id="serviceTypeElectronic" header="业务类型" field="serviceType" width="220" dataset="dsService">
			</next:Column>
			<next:Column id="catalogName" header="档案目录" field="catalogName" width="260">
			</next:Column>
			<next:Column id="fileName" header="电子文档" field="fileName" renderer="fileNameFormat" width="260">
			</next:Column>
			<next:Column id="fileOper" header="责任者" field="fileOper" width="100">
			</next:Column>
			<next:Column id="fileTime" header="日期" field="fileTime" width="80">
			</next:Column>
			<next:Column id="fileNumber" header="页数" field="fileNumber" width="80">
			</next:Column>
			<next:Column id="filePath" header="" field="filePath" hidden="true">
			</next:Column>
			<next:Column id="electronicId" header="" field="electronicId" hidden="true">
			</next:Column>
			<next:Column id="fileId" header="" field="fileId" hidden="true">
			</next:Column>
		</next:Columns>
	</next:GridPanel>
</next:Panel>
</body>
</html>
