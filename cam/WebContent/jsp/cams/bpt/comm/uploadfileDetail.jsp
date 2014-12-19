<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%
	response.setHeader("Expires", "Sat, 6 May 1995 12:00:00 GMT");  
	response.setHeader("Cache-Control", "no-store,no-cache,must-revalidate");  
	response.addHeader("Cache-Control", "post-check=0, pre-check=0");  
	response.setHeader("Pragma", "no-cache");  
%>
<% 
String applyId=request.getParameter("applyId")==null?"":(String)request.getParameter("applyId");
%>
<html>
	<head>
		<next:ScriptManager/>
		<script type="text/javascript" src="uploadfileDetail.js"></script>
		<script>
			var peopleId='<%=request.getParameter("peopleId")%>';
			var serviceType='<%=request.getParameter("serviceType")%>';
			var organCode = '<%=BspUtil.getOrganCode()%>';
			var applyId='<%=applyId %>';
			//alert(applyId);
		</script>
	</head>
<body >
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.bpt.manage.cmd.BptElectronicQueryCommand" method="querySelectedContent" global="true" pageSize="30" >
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptElectronic"></model:record>
	</model:dataset>
	<!-- 目录号 -->
	<model:dataset id="ContentNumMaintainDataset" cmd="com.inspur.cams.bpt.manage.cmd.BptContentNumMaintainQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptContentNumMaintain"></model:record>
	</model:dataset>
	<!-- 电子档案 -->
	<model:dataset id="bptElectronic" cmd="com.inspur.cams.bpt.bptelectronicfile.cmd.BptElectronicListQueryCommand" global="true" pageSize="30" >
		<model:record fromBean="com.inspur.cams.bpt.bptelectronicfile.dao.BptElectronicList">
			<model:field name="ARCHIVE_NO" type="string"/>
		</model:record>
	</model:dataset>
	<!-- 上传文件保存 -->
	<model:dataset id="uploadds" cmd="com.inspur.cams.bpt.bptelectronicfile.cmd.BptUploadfileQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.bpt.bptelectronicfile.dao.BptUploadfile">
		<model:field name="peopleId" type="string" />
		<model:field name="catalogCode" type="string" />
		<model:field name="catalogName" type="string" />
		<model:field name="serviceType" type="string" />
		<model:field name="electronicId" type="string" />
		<model:field name="fileSave" type="string" />
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
<next:Panel  width="100%" id="bptElectronic" autoScroll="true" title="纸质档案存放信息" height="130">
				<next:Html>
					<form id="editForm" dataset="bptElectronic" onsubmit="return false" style="padding: 5px;" class="L5form">
					<table border="1" width="98%">
						<tr>
							<td class="FieldLabel" nowrap="nowrap" style="width:12.5%">目录号：</td>
							<td class="FieldInput" style="width:12.5%"><label id=contentNumName name="contentNumName" field="contentNumName"/></td>
							<td class="FieldLabel" nowrap="nowrap" style="width:12.5%">档案柜：</td>
							<td class="FieldInput" style="width:12.5%"><label id="fileCabinetName" field="fileCabinetName"/></td>
							<td class="FieldLabel" nowrap="nowrap" style="width:12.5%">层数：</td>
							<td class="FieldInput" style="width:12.5%"><label name="layerNum" id="layerNum" field="layerNum"/></td>
							<td class="FieldLabel" nowrap="nowrap" style="width:12.5%">盒：</td>
							<td class="FieldInput" style="width:12.5%"><label name="boxNum" id="boxNum" field="boxNum"/></td>
						</tr>
						<tr>
							<td class="FieldLabel" nowrap="nowrap">年度：</td>
							<td class="FieldInput"><label id="contentYear" name="contentYear" field="contentYear"/></td>
							<td class="FieldLabel" nowrap="nowrap">编制日期：</td>
							<td class="FieldInput"><label name="plaitDate" id="plaitDate" field="plaitDate"/></td>
							<td class="FieldLabel" nowrap="nowrap">室卷编号：</td>
						    <td class="FieldInput" colspan="3"><label name="ARCHIVE_NO" id="ARCHIVE_NO" field="ARCHIVE_NO"/></td>
						</tr>
							<input type="hidden" name="contentNumId" id="contentNumId" field="contentNumId"/>
					</table>
					</form>
				</next:Html>
			</next:Panel>
<next:EditGridPanel id="editGridPanel" name="uploadfile" width="100%" notSelectFirstRow="true" autoExpandColumn="catalogName" stripeRows="true" height="100%" dataset="ds" title="附件信息">
	<next:TopBar>
			<next:ToolBarItem symbol="->" ></next:ToolBarItem>
	        <next:ToolBarItem symbol="-" ></next:ToolBarItem>
	        <next:ToolBarItem iconCls="detail" text="查看历史电子档案" handler="detail"/>
	        <next:ToolBarItem symbol="-" ></next:ToolBarItem>
	        <next:ToolBarItem iconCls="detail"  text="查看当前电子档案" handler="checkElectronic"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="50" header="编号"/>
	    <next:RadioBoxColumn></next:RadioBoxColumn>
	    <next:Column id="catalogCode" header="附件类别代码" field="catalogCode" width="120" hidden="true" >
		</next:Column>
		<%-- 
		<next:Column id="serviceType" header="业务类型" field="serviceType" width="220" dataset="dsService">
		</next:Column>
		--%>
		<next:Column id="catalogName" header="档案目录" field="catalogName" width="300" >
		</next:Column>
		<next:Column id="fileName" header="电子文档" field="fileName" width="260" renderer="lookDetail">
		</next:Column>
		<next:Column id="fileOper" header="责任者" field="fileOper" width="100">
		</next:Column>
		<next:Column id="fileTime" header="日期" field="fileTime" width="80">
		</next:Column>
		<next:Column id="fileNumber" header="页数" field="fileNumber" width="80">
		</next:Column>
		<next:Column id="filePath" header="" field="filePath"  hidden="true" >
		</next:Column>
		<next:Column id="electronicId" header="" field="electronicId" hidden="true" >
		</next:Column>
		<next:Column id="fileId" header="" field="fileId"  hidden="true" >
		</next:Column>
	</next:Columns>
</next:EditGridPanel>
</body>

</html>
