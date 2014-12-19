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
<html>
	<head>
		<next:ScriptManager/>
		<script type="text/javascript" src="uploadfile.js"></script>
		<script>
			var peopleId=<%=request.getParameter("peopleId")%>;
			var serviceType=<%=request.getParameter("serviceType")%>;
			var organCode = '<%=BspUtil.getOrganCode()%>';
			var layerNum;
		</script>
	</head>
<body >
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.bpt.bptelectronicfile.cmd.VbptElectronicQueryCommand" global="true" pageSize="30" >
		<model:record fromBean="com.inspur.cams.bpt.bptelectronicfile.dao.VbptElectronic"></model:record>
	</model:dataset>
	<model:dataset id="bptElectronic" cmd="com.inspur.cams.bpt.bptelectronicfile.cmd.BptElectronicListQueryCommand" global="true" pageSize="30" >
		<model:record fromBean="com.inspur.cams.bpt.bptelectronicfile.dao.BptElectronicList"></model:record>
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
	<!-- 档案柜名称 --> 
	<model:dataset id="FileCabinetDataset" cmd="com.inspur.cams.bpt.dicm.cmd.DmQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.bpt.dicm.data.DmBean"></model:record>
		<model:params>
			<model:param name="tableName" value='BPT_FILE_CABINET_MAINTAIN'></model:param>
			<model:param name="valueField" value='FILE_CABINET_CODE'></model:param>
			<model:param name="textField" value='FILE_CABINET_NAME'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>
<next:Panel  width="100%" id="bptElectronic" autoScroll="true" title="纸质档案存放信息" height="130">
				<next:TopBar>
					<next:ToolBarItem symbol="->" ></next:ToolBarItem>
					<next:ToolBarItem iconCls="save" text="保存" handler="savefile" />
				</next:TopBar>
				<next:Html>
					<form id="editForm" dataset="bptElectronic"
						onsubmit="return false" style="padding: 5px;" class="L5form">
					<table border="1" width="98%">
						<tr>
							<td class="FieldLabel" nowrap="nowrap">档案编号：</td>
							<td class="FieldInput"><input type="text" id=electronicNo name="electronicNo" field="electronicNo" readonly="readonly"/></td>

							<td class="FieldLabel" nowrap="nowrap">档案柜名称：</td>
							<td class="FieldInput">
									<select name="fileCabinetCode" field="fileCabinetCode" onchange="getLayer()">
											<option dataset="FileCabinetDataset"></option>
									</select>
							</td>
							
							<td class="FieldLabel" nowrap="nowrap">层数：</td>
							<td class="FieldInput"><input type="text" name="layerNum" id="layerNum" field="layerNum" title="层数" onblur="getFileCabinet()"/></td>
							
							<td class="FieldLabel" nowrap="nowrap">盒：</td>
							<td class="FieldInput"><input type="text" name="ctnNo" id="ctnNo" field="ctnNo" title="箱号" onblur="getFileCabinet()"/></td>

							
						</tr>
						
						<tr>
							<td class="FieldLabel" nowrap="nowrap">年度：</td>
							<td class="FieldInput"><input type="text" id=elecYear name="elecYear" field="elecYear" /></td>
							<td class="FieldLabel" nowrap="nowrap">编制日期：</td>
							<td class="FieldInput" colspan="5"><input type="text" name="electronicDate" id="electronicDate"
								field="electronicDate" format="Y-m-d" style="width: 100px;" maxlength="10"  onpropertychange="changeDateStyle(this)" /><img  src="../../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ></td>
						</tr>
					</table>
					</form>
				</next:Html>
			</next:Panel>
<next:EditGridPanel id="editGridPanel" name="uploadfile" width="100%" notSelectFirstRow="true" autoExpandColumn="catalogName" stripeRows="true" height="100%" dataset="ds" title="附件信息">
	<next:TopBar>
			<next:ToolBarItem symbol="->" ></next:ToolBarItem>
	        <next:ToolBarItem symbol="-" ></next:ToolBarItem>
	         <next:ToolBarItem iconCls="save"  text="保存" handler="saveELE"/>
	        <next:ToolBarItem iconCls="upload"  text="电子扫描" handler="uploadfile"/>
			<next:ToolBarItem iconCls="undo"  text="返回" handler="back"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="50" header="编号"/>
	    <next:RadioBoxColumn></next:RadioBoxColumn>
	    <next:Column id="catalogCode" header="附件类别代码" field="catalogCode" width="120" hidden="true" >
		</next:Column>
		<next:Column id="catalogName" header="档案目录" field="catalogName" width="300" >
		</next:Column>
		<next:Column id="fileName" header="电子文档" field="fileName" width="260" renderer="lookDetail">
		</next:Column>
		<next:Column id="fileOper" header="负责人" field="fileOper" width="100">
		<next:TextField  />
		</next:Column>
		<next:Column id="fileTime" header="上传日期" field="fileTime" width="80">
		<next:DateField allowBlank="false" format="Y-m-d"/>
		</next:Column>
		<next:Column id="fileNumber" header="页数" field="fileNumber" width="80">
		<next:TextField  />
		</next:Column>
		<next:Column id="filePath" header="" field="filePath"  hidden="true" >
		</next:Column>
		<next:Column id="electronicId" header="" field="electronicId" hidden="true" >
		</next:Column>
		<next:Column id="fileId" header="" field="fileId"  hidden="true" >
		</next:Column>
	</next:Columns>
</next:EditGridPanel>
<!--上传附件页面 -->
<next:Window id="updateWin" closeAction="hide" title="上传附件" height="300" width="500">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="yes" text="上传" handler="click_save"></next:ToolBarItem>
		<next:ToolBarItem xtype="tbseparator"/>
	</next:TopBar>
	<next:Html>
		<form id="form_content"   dataset="uploadds" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="100%" >
					<tr>
						<td class="FieldLabel" nowrap="nowrap" >附件描述</td>
						<td class="FieldInput" colspan="3"><textarea
								id="fileMess" name="fileMess"  cols="70%" rows="3" ></textarea></td>
					</tr>
					<tr>
						<td class="FieldLabel" nowrap="nowrap" >档案存放位置</td>
						<td class="FieldInput" ><textarea
								id="fileSave" name="fileSave"  cols="70%"></textarea></td>
					</tr>
					<tr><td class="FieldLabel" nowrap="nowrap">附件上传：</td>
					<td colspan="5" class="FieldInput">
					<input   type=button   value="添加"   onclick="add_row()" style="CURSOR: hand">
         		    &nbsp;<span id="span"></span>
         		    <table id="table2">	</table>
           			</td>
           			</tr>
		</table>
		</form>
   </next:Html>
</next:Window>
</body>

</html>
