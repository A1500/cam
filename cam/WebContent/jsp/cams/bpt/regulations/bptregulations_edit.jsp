<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>文件明细编辑</title>
<next:ScriptManager />
<script type="text/javascript" src="bptregulations_edit.js"></script>
<script type="text/javascript" src="../comm/bptComm.js"></script>
<script type="text/javascript" src="kindeditor.js"></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var newid ='<%=IdHelp.getUUID32()%>';
	var id='<%=request.getParameter("id")%>';
	var username = '<%=GetBspInfo.getBspInfo(request).getUserName()%>';
	var orgname ='<%=BspUtil.getCorpOrgan().getOrganName()%>';
	
	KE.init({
				id : 'content',
				imageUploadJson : 'upload_json.jsp',
				fileManagerJson : 'jsp/file_manager_json.jsp',
				resizeMode : 0,
				allowFileManager : true
			});
	
</script>
<style text="text/css">
.ML5form table,.ML5form td {
	border-color: #999;
}

.ML5form table {
	border-width: 0 0 1px 1px;
	border-spacing: 0;
	border-collapse: collapse;
}

.ML5form td {
	margin: 0;
	border-width: 1px 1px 0 0;
}
</style>
</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.bpt.regulations.cmd.BptRegulationsQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.bpt.regulations.data.BptRegulations"> </model:record>
	</model:dataset>
	<model:dataset id="UploadFileDataset" cmd="com.inspur.cams.bpt.regulations.cmd.BptRegulationsAttachmentQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.bpt.regulations.data.BptRegulationsAttachment"> </model:record>
	</model:dataset>
	<model:dataset id="FileLevelDataset" enumName="REGULATION.CODE"
		autoLoad="true" global="true"></model:dataset>
	<model:dataset id="FileStateDataset" enumName="FLAG.CODE"
		autoLoad="true" global="true"></model:dataset>
<!-- 类别 -->
	<model:dataset id="TypeDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='BPT_REGULATIONS_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>

<next:Panel title="文件明细" collapsible="false" autoScroll="true"
	width="100%" height="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem symbol="-"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="save"/>
		<next:ToolBarItem symbol="-"></next:ToolBarItem>
		<next:ToolBarItem iconCls="undo" text="返回" handler="back"/>
	</next:TopBar>
	<next:Html>
		<form id="editForm" dataset="ds" onsubmit="return false"
			style="padding: 5px;" class="ML5form" width="98%">
		<table border="1" width="99%">
			<tr>
				<td class="FieldLabel"
					style="width: 15%; border-style: solid; height: 30px; padding: 4px;">文件编号</td>
				<td class="FieldInput"
					style="width: 15%; border-style: solid; height: 30px; padding: 4px;"><input
					type="text" field="fileNum" class="TextEditor" /></td>
				<td class="FieldLabel"
					style="width: 15%; border-style: solid; height: 30px; padding: 4px;">级别</td>
				<td class="FieldInput"
					style="width: 15%; border-style: solid; height: 30px; padding: 4px;"><select
					field="fileLevel" name="级别" id="fileLevel">
					<option dataset="FileLevelDataset"></option>
				</select></td>
					<td class="FieldLabel"
					style="width: 15%; border-style: solid; height: 30px; padding: 4px;">类别</td>
				<td class="FieldInput"
					style="width: 15%; border-style: solid; height: 30px; padding: 4px;"><select
					field="type" name="类别" id="type">
					<option dataset="TypeDataset"></option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel"
					style="width: 15%; border-style: solid; height: 30px; padding: 4px;"
					colspan="1">文件标题</td>
				<td class="FieldInput" 
					style="width: 15%; border-style: solid; height: 30px; padding: 4px;" colspan="5"><input
					type="text" class="TextEditor" field="regulationsTitle"
					style="width: 70%" /></td>
			</tr>

			<tr align="left">
				<td class="FieldLabel"
					style="width: 15%; border-style: solid; height: 30px; padding: 4px;"
					colspan="6">
				<fieldset style="overflow: visible;" class="GroupBox"><legend
					class="GroupBoxTitle">文件内容 </legend> <textarea id="content"
					name="content" style="width: 99%; height: 300px;" field="content"></textarea></fieldset>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel"
					style="width: 15%; border-style: solid; height: 30px; padding: 4px;">发布时间</td>
				<td class="FieldInput"
					style="width: 15%; border-style: solid; height: 30px; padding: 4px;"><input
					type="text" field="releaseDate" format="Y-m-d"
					style="width: 100px;" maxlength="10"  onpropertychange="changeDateStyle(this)"/><img
					src="../../../../skins/images/default/rl.gif" align="middle"
					onclick="getTimes(this);"></td>
				<td class="FieldLabel"
					style="width: 15%; border-style: solid; height: 30px; padding: 4px;">文件状态</td>
				<td class="FieldInput"
					style="width: 15%; border-style: solid; height: 30px; padding: 4px;" colspan="3"><select
					field="flag">
					<option dataset="FileStateDataset"></option>
				</select></td>
			</tr>
			<tr id="attach">
				<td class="FieldLabel"
					style=" border-style: solid; height: 30px; padding: 4px;">附件</td>
				<td colspan="4" class="FieldLabel"
					style="padding: 0 0 0 0;">
					<table border="0" style="width: 100%;">
						<tr style="width: 100%;">
							<td style="width: 100%;">
								<table id="table1" style="width: 100%;" border="0"></table>
							</td>
						</tr>
						<tr>
							<td class="FieldInput"
									style="width:100%;border-style: solid; height: 30px; padding: 4px;"><input
									type=button value="添加" onclick="add_row()" style="CURSOR: hand"><span
									id="span"></span>
									<table id="table2">
									</table>
							</td>
						</tr>
					</table>
				<td>
			</tr>
			<tr>
				<td class="FieldLabel"
					style="width: 15%; border-style: solid; height: 30px; padding: 4px;">备注</td>
				<td class="FieldInput" colspan="5"
					style="width: 15%; border-style: solid; height: 30px; padding: 4px;"><textarea
					style="width: 70%" rows="3" field="remarks" /></td>
			</tr>
		</table>
		</form>
	</next:Html>
</next:Panel>
</body>
</html>
