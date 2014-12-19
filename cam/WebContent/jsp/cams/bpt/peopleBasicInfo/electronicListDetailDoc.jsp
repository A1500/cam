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
			var applyId='<%=request.getParameter("applyId")%>';
			var ywName='<%=request.getParameter("ywName")%>';
			var organCode = '<%=BspUtil.getOrganCode()%>';
			var serviceType = '<%=request.getParameter("serviceType")%>';
			var service = '<%=request.getParameter("service")%>';
		</script>
<script type="text/javascript" src="electronicListDetailDoc.js"></script>
</head>
<body>
<model:datasets>
	<!-- 业务处理人员档案信息 -->
	<model:dataset id="dsPro"
		cmd="com.inspur.cams.bpt.manage.cmd.BptElectronicQueryCommand"
		method="queryProElectronicInfo" global="true" pageSize="30">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptElectronic"></model:record>
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
	<!-- 伤残审批信息 -->
	<model:dataset id="DisabilityApproveDataset" cmd="com.inspur.cams.bpt.manage.cmd.BptApplyDisabilityQueryCommand" method="queryAdjustDisability" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptApplyDisability"></model:record>
	</model:dataset>
</model:datasets>
<next:Panel height="100%" width="100%">

	<next:TabPanel id="panelall">
		<next:Tabs>
			<next:Panel width="100%" id="bptElectronicListAll" autoScroll="true"
				title="档案信息" height="100%">
				<next:Html>
				<next:Panel width="100%" id="bptElectronicList" autoScroll="true"
					title="档案详细信息" height="100">
					<next:Html>
						<form id="editForm" dataset="dsPro" onsubmit="return false"
							style="padding: 5px;" class="L5form">
						<table border="1" width="98%">
							<tr>
								<td class="FieldLabel" nowrap="nowrap" width="10%">目录号：</td>
								<td class="FieldInput" width="20%"><label type="text"
									id=contentNumName name="contentNumName"
									field="CONTENT_NUM_NAME" /></td>

								<td class="FieldLabel" nowrap="nowrap" width="10%">档案柜：</td>
								<td class="FieldInput" width="20%"><label type="text"
									id="fileCabinetName" field="FILE_CABINET_NAME"
									readonly="readonly"></td>

								<td class="FieldLabel" nowrap="nowrap" width="10%">层数：</td>
								<td class="FieldInput" width="20%"><label type="text"
									name="layerNum" id="layerNum" field="LAYER_NUM"
									readonly="readonly" /></td>
							</tr>
							<tr>
								<td class="FieldLabel" nowrap="nowrap" width="10%">盒：</td>
								<td class="FieldInput" width="20%"><label type="text"
									name="boxNum" id="boxNum" field="BOX_NUM" readonly="readonly" /></td>

								<td class="FieldLabel" nowrap="nowrap" width="10%">年度：</td>
								<td class="FieldInput" width="20%"><label type="text"
									id="contentYear" name="contentYear" field="CONTENT_YEAR"
									readonly="readonly" /></td>
								<td class="FieldLabel" nowrap="nowrap">室卷编号：</td>
								<td class="FieldInput"><label name="ARCHIVE_NO" id="ARCHIVE_NO" field="ARCHIVE_NO"/></td>
							</tr>
							<input type="hidden" name="contentNumId" id="contentNumId" field="contentNumId" />
						</table>
						</form>
					</next:Html>
				</next:Panel>
				
				<next:EditGridPanel id="editGridPanel" name="uploadfile"
					width="100%" notSelectFirstRow="true"
					autoExpandColumn="catalogName" stripeRows="true" height="100%"
					dataset="ds" title="电子扫描">	
						<next:TopBar>
									<next:ToolBarItem symbol="->"></next:ToolBarItem>
									<next:ToolBarItem symbol="-"></next:ToolBarItem>
									 <next:ToolBarItem iconCls="detail"  text="查看所有电子文档" handler="checkElectronic" />
						</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn width="50" header="编号" />
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column id="catalogCode" header="附件类别代码" field="catalogCode"
							width="120" hidden="true">
						</next:Column>
						<next:Column id="serviceTypeElectronic" header="业务类型"
							field="serviceType" width="220" dataset="dsService">
						</next:Column>
						<next:Column id="catalogName" header="档案目录" field="catalogName"
							width="260">
						</next:Column>
						<next:Column id="fileName" header="电子文档" renderer="fileNameFormat" field="fileName"  
							width="260">
						</next:Column>
						<next:Column id="fileOper" header="责任者" field="fileOper"
							width="100">
						</next:Column>
						<next:Column id="fileTime" header="日期" field="fileTime" width="80">
						</next:Column>
						<next:Column id="fileNumber" header="页数" field="fileNumber"
							width="80">
						</next:Column>
						<next:Column id="filePath" header="" field="filePath"
							hidden="true">
						</next:Column>
						<next:Column id="electronicId" header="" field="electronicId"
							hidden="true">
						</next:Column>
						<next:Column id="fileId" header="" field="fileId" hidden="true">
						</next:Column>
					</next:Columns>
				</next:EditGridPanel>
				</next:Html>
			</next:Panel>

			<next:Panel title="电子文书" width="100%" height="100%"
				id="peopleInfoTabPanel" name="peopleInfoTabPanel">
				<next:Html>
					<iframe id="iframesrc"
						src="../flow/disability/assessdisability/print/ass_disability_apptable.jsp?peopleId=<%=request.getParameter("peopleId")%>&applyId=<%=request.getParameter("applyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0"
						scrolling="no" allowtransparency="yes" width="100%" height="100%">
					</iframe>
				</next:Html>
			</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>
</body>

</html>
