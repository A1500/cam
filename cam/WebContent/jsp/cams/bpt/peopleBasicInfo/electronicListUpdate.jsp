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
			var objectType = '<%=request.getParameter("objectType")%>';
			var objectState = <%=request.getParameter("objectState")%>;
		</script>
<script type="text/javascript" src="electronicListUpdate.js"></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request, "ISPrint.js") %>"></script>
<script type="text/javascript" src="../comm/bptComm.js"></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request, "cams.js") %>"></script>
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
		method="queryBaseInforSelectedContents" global="true" pageSize="30">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptElectronic"></model:record>
	</model:dataset>
	<model:dataset id="printds"
		cmd="com.inspur.cams.bpt.manage.cmd.BptElectronicQueryCommand"
		method="queryBaseInforSelectedContents" global="true" pageSize="30">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptElectronic"></model:record>
	</model:dataset>
	<model:dataset id="dsProInfo"
		cmd="com.inspur.cams.bpt.manage.cmd.BptElectronicQueryCommand"
		method="queryProElectronicInfo" global="true" pageSize="30">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptElectronic">
			<model:field name="CONTENT_NUM_NAME" type="string"/>
			<model:field name="FILE_CABINET_NAME" type="string"/>
			<model:field name="LAYER_NUM" type="string"/>
			<model:field name="BOX_NUM" type="string"/>
			<model:field name="CONTENT_YEAR" type="string"/>
			<model:field name="PLAIT_DATE" type="string"/>
			<model:field name="contentNumId" type="string"/>
			<model:field name="ARCHIVE_NO" type="string"/>
		</model:record>
	</model:dataset>
	<model:dataset id="dsProPrint"
		cmd="com.inspur.cams.bpt.manage.cmd.BptElectronicQueryCommand"
		method="queryProcessElectronicPrint" global="true" pageSize="30">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptElectronic">
			<model:field name="CONTENT_NUM_NAME" type="string"/>
			<model:field name="BOX_HAVE" type="string"/>
			<model:field name="CONTENT_YEAR" type="string"/>
			<model:field name="ARCHIVAL_FONDS_NAME" type="string"/>
			<model:field name="SERVICE_TYPE" type="string"/>
			<model:field name="PLAIT_DATE" type="string"/>
		</model:record>
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
		width="100%" height="30%" stripeRows="true" dataset="dsPro"
		title="档案信息">
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="disable" text="关闭" handler="func_Close" />
		</next:TopBar>
		<next:Columns onRowSelect="selectService">
			<next:RowNumberColumn header="序号" width="45" />
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column id="ywname" header="数据来源" field="YW_NAME" width="230">
				<next:TextField allowBlank="false" />
			</next:Column>
			<next:Column id="serviceType" header="业务类型" field="SERVICE_TYPE"
				width="330" dataset="dsService">
				<next:TextField allowBlank="false" />
			</next:Column>
			<next:TextField />
		</next:Columns>
	</next:GridPanel>
	<next:Panel width="100%" id="bptElectronicList" autoScroll="true"
		title="档案详细信息" height="130">
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="save" text="保存" handler="savefile" />
			<%-- <next:ToolBarItem iconCls="detail" text="打印" handler="printFront" />--%>
		</next:TopBar>
		<next:Html>
			<form id="editForm" dataset="dsProInfo" onsubmit="return false"
				style="padding: 1px;" class="L5form">
			<table border="1" width="99%">
				<tr>
					<td class="FieldLabel" width="10%">目录号：</td>
					<td class="FieldInput" width="20%"><input type="text" id=contentNumName
						name="contentNumName" field="CONTENT_NUM_NAME" readonly="readonly" /><img
						src="<%=SkinUtils.getImage(request,"l5/help.gif")%>"
						style="cursor: hand" onclick="getContent()" /></td>
					<td class="FieldLabel" width="10%">档案柜：</td>
					<td class="FieldInput" width="20%"><label id="fileCabinetName" field="FILE_CABINET_NAME" /></td>
					<td class="FieldLabel" width="10%">层数：</td>
					<td class="FieldInput" width="20"><label id="layerNum" field="LAYER_NUM"/></td>
				</tr>
				<tr>
					<td class="FieldLabel" nowrap="nowrap">盒：</td>
					<td class="FieldInput"><label name="boxNum" id="boxNum" field="BOX_NUM"/></td>
					<td class="FieldLabel" nowrap="nowrap">年度：</td>
					<td class="FieldInput"><label id="contentYear" name="contentYear" field="CONTENT_YEAR"/></td>
					<%-- <td class="FieldLabel" nowrap="nowrap">编制日期：</td>
					<td class="FieldInput"><label name="plaitDate" id="plaitDate" field="PLAIT_DATE"/></td>--%>
					<td class="FieldLabel" nowrap="nowrap">室卷编号：</td>
					<td class="FieldInput"><label name="ARCHIVE_NO" id="ARCHIVE_NO" field="ARCHIVE_NO"/></td>
				</tr>
				<input type="hidden" name="contentNumId" id="contentNumId" field="contentNumId" />
			</table>
			</form>
		</next:Html>
	</next:Panel>

	<next:EditGridPanel id="editGridPanel" name="uploadfile" width="100%"
		notSelectFirstRow="true" autoExpandColumn="catalogName"
		stripeRows="true" height="100%" dataset="ds" title="电子扫描">
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem symbol="-"></next:ToolBarItem>
			 <next:ToolBarItem iconCls="detail"  text="查看所有电子文档" handler="checkElectronic"/>
			<next:ToolBarItem iconCls="import" text="选择目录"
				handler="selectContent" />
			<next:ToolBarItem iconCls="save" text="保存" handler="saveELE" />
			<next:ToolBarItem iconCls="upload" text="电子扫描" handler="uploadfile" />
			<next:ToolBarItem iconCls="detail" text="打印" handler="printBill" />
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn width="50" header="编号" />
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column id="catalogCode" header="附件类别代码" field="catalogCode"
				width="120" hidden="true">
			</next:Column>
			<next:Column id="serviceTypeElectronic" header="业务类型" field="serviceType"
				width="220" dataset="dsService">
			</next:Column>
			<next:Column id="catalogName" header="档案目录" field="catalogName"
				width="260">
			</next:Column>
			<next:Column id="fileName" header="电子文档" field="fileName" renderer="fileNameFormat" width="260">
			</next:Column>
			<next:Column id="fileOper" header="责任者" field="fileOper" width="100">
				<next:TextField />
			</next:Column>
			<next:Column id="fileTime" header="日期" field="fileTime" width="80">
				<next:DateField allowBlank="false" format="Y-m-d" />
			</next:Column>
			<next:Column id="fileNumber" header="页数" field="fileNumber"
				width="80">
				<next:TextField />
			</next:Column>
			<next:Column id="filePath" header="" field="filePath" hidden="true">
			</next:Column>
			<next:Column id="electronicId" header="" field="electronicId"
				hidden="true">
			</next:Column>
			<next:Column id="fileId" header="" field="fileId" hidden="true">
			</next:Column>
		</next:Columns>
	</next:EditGridPanel>
</next:Panel>
</body>

</html>
