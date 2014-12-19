<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>文件明细</title>
<next:ScriptManager />
<script type="text/javascript" src="bptregulations_detail.js"></script>
<script type="text/javascript" src="kindeditor.js"></script>
<script type="text/javascript">
	var id='<%=request.getParameter("id")%>';
	KE.init({
				id : 'content',
				imageUploadJson : 'upload_json.jsp',
				fileManagerJson : 'jsp/file_manager_json.jsp',
				resizeMode : 0,
				allowFileManager : true,
				afterCreate : function(id) {
					KE.toolbar.disable(id, []);
					KE.readonly(id);
					KE.g[id].newTextarea.disabled = true;
				}
				
			});
</script>
<style text="text/css">
.ML5form table,.ML5form td
{
    border-color: #999;
}

.ML5form table
{
    border-width: 0 0 1px 1px;
    border-spacing: 0;
    border-collapse: collapse;
}

.ML5form td
{
    margin: 0;
    border-width: 1px 1px 0 0;
}
</style>
</head>
<body>
<model:datasets>
	<model:dataset id="ds"
		cmd="com.inspur.cams.bpt.regulations.cmd.BptRegulationsQueryCommand"
		global="true">
		<model:record
			fromBean="com.inspur.cams.bpt.regulations.data.BptRegulations"></model:record>
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
<next:Panel title="文件明细">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem symbol="-"></next:ToolBarItem>
		<next:ToolBarItem iconCls="undo" text="返回" handler="back" />
	</next:TopBar>
	<next:Html>
		<form id="editForm" dataset="ds" onsubmit="return false"
			style="padding: 5px; width: 99%" class="ML5form" >
		<table border="1" width="100%">
			<tr>
				<td class="FieldLabel" style="width: 15%;border-style: solid;height:30px;padding: 4px;">文件编号</td>
				<td class="FieldInput" style="width: 15%;border-style: solid;height:30px;padding: 4px;"><label field="fileNum" /></td>
				<td class="FieldLabel" style="width: 15%;border-style: solid;height:30px;padding: 4px;">级别</td>
				<td class="FieldInput" style="width: 15%;border-style: solid;height:30px;padding: 4px;"><label field="fileLevel"
					dataset="FileLevelDataset" /></td>
				<td class="FieldLabel" style="width: 15%;border-style: solid;height:30px;padding: 4px;">类别</td>
				<td class="FieldInput" style="width: 15%;border-style: solid;height:30px;padding: 4px;"><label field="type"
					dataset="TypeDataset" /></td>
			</tr>
			<tr>
				<td class="FieldLabel"style="width: 15%;border-style: solid;height:30px;padding: 4px;" colspan="1">文件标题</td>
				<td class="FieldInput" style="width: 15%;border-style: solid;height:30px;padding: 4px;" colspan="5"><label
					field="regulationsTitle" /></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%;border-style: solid;height:30px;padding: 4px;" colspan="6"><textarea id="content" 
					style="width: 99%;height:300px;" readonly="readonly" ></textarea></td>
			<tr>
			<tr>
				<td class="FieldLabel"style="width: 15%;border-style: solid;height:30px;padding: 4px;">发布时间</td>
				<td class="FieldInput" style="width: 15%;border-style: solid;height:30px;padding: 4px;"><label field="releaseDate" /></td>
				<td class="FieldLabel" style="width: 15%;border-style: solid;height:30px;padding: 4px;">文件状态</td>
				<td class="FieldInput" style="width: 15%;border-style: solid;height:30px;padding: 4px;" colspan="3"><label field ="flag" dataset="FileStateDataset"> </td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%;border-style: solid;height:30px;padding: 4px;">录入单位</td>
				<td class="FieldInput" style="width: 15%;border-style: solid;height:30px;padding: 4px;"><label field="releaseCompany" /></td>

				<td class="FieldLabel" style="width: 15%;border-style: solid;height:30px;padding: 4px;">录入人员</td>
				<td class="FieldInput" style="width: 15%;border-style: solid;height:30px;padding: 4px;"colspan="3"><label field="releasePeople" /></td>

			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%;border-style: solid;height:30px;padding: 4px;">备注</td>
				<td class="FieldInput" style="width: 15%;border-style: solid;height:30px;padding: 4px;" colspan="5"><label field="remarks" /></td>
			</tr>
			<tr>
						<td class="FieldLabel" style="width: 15%;border-style: solid;height:30px;padding: 4px;">附件</td>
						<td style="width: 15%;border-style: solid;height:30px;padding: 4px;" colspan="5" >
							<div id="fileName"></div>
	           			</td>
           	</tr>
		</table>
		</form>
	</next:Html>

</next:Panel>
</body>
</html>
