<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.web.cmd.CommandContext"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>通用帮助定义</title>
<next:ScriptManager></next:ScriptManager>
<%
	//流程类型id
	String procTypeId = request.getParameter("procTypeId");
	//查询字段定义唯一id
	String subjectQueryDefUniqueId = request
			.getParameter("subjectQueryDefUniqueId");
%>
</head>
<body>
<model:datasets>
	<model:dataset id="commonHelpDataSet"
		cmd="org.loushang.workflow.processdefinition.tasklist.proctypesubjectdef.cmd.ProcTypeSubjectDefQueryCmd"
		autoLoad="false" method="queryProceTyepSubjectQueryCommonHelpDef">
		<model:record
			fromBean="org.loushang.workflow.processdefinition.tasklist.proctypesubjectdef.data.ProcTypeSubjectQueryCommonHelpDef"></model:record>
	</model:dataset>
</model:datasets>
<next:Panel>
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem symbol="通用帮助定义"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="save" />
		<next:ToolBarItem iconCls="undo" text="回退" handler="back" />
	</next:TopBar>
	<next:Html>
		<form id="commonHelpForm" method="post" dataset="commonHelpDataSet"
			onsubmit="return false" class="L5form">
		<table width="100%" border="1">
			<tr>
				<input type="hidden" id="id" name="id" field="id" value="" />
			</tr>
			<tr>
				<input type="hidden" id="procType" field="procType" name="procType" value="<%=procTypeId%>" />
			</tr>
			<tr>
				<input type="hidden" id="subjectQueryDefUniqueId"
					field="subjectQueryDefUniqueId" name="subjectQueryDefUniqueId"
					value="<%=subjectQueryDefUniqueId%>" />
			</tr>
			<tr>
				<td class="FieldLabel" width="20%">弹出框URL:</td>
				<td class="FieldInput" width="80%"><input id="dialogUrl" type="text"
					name="url" field="dialogUrl" title="弹出框URL" size="40" /><font color="red">*</font></td>
			</tr>
			<tr>
				<td class="FieldLabel" width="20%">弹出框的宽度:</td>
				<td class="FieldInput" width="80%"><input id="dialogWidth" type="text"
					name="width" field="dialogWidth" title="弹出框的宽度" size="40" /><font color="red">*</font></td>
			</tr>
			<tr>
				<td class="FieldLabel" width="20%">弹出框的高度:</td>
				<td class="FieldInput" width="80%"><input id="dialogHeight" type="text"
					name="high" field="dialogHeight" title="弹出框的高度" size="40" /><font color="red">*</font></td>
			</tr>
			<tr>
				<td class="FieldLabel" width="20%">查询条件:</td>
				<td class="FieldInput" width="80%"><select type="text"
					name="condition_use_way" field="conditionUseWay" " title="查询条件" >
					<option value="0">使用返回值</option>
					<option value="1">使用返回显示值</option>
				</select><font color="red">*</font></td>
			</tr>
			<tr>
				<td class="FieldLabel" width="20%">帮助框返回值下标:</td>
				<td class="FieldInput" width="80%"><input type="text"
					name="high" field="keyReturnIndex" title="帮助框返回值下标" size="40" /></td>
			</tr>
			<tr>
				<td class="FieldLabel" width="20%">帮助框返回显示值下标:</td>
				<td class="FieldInput" width="80%"><input type="text"
					name="high" field="aliasReturnIndex" title="帮助框返回显示值下标" size="40" /></td>
			</tr>
		</table>
		</form>
	</next:Html>
</next:Panel>

</body>
<script language="javascript">
function init(){
	var commonHelpDataSet = L5.DatasetMgr.lookup("commonHelpDataSet");
	var procTypeId='<%=procTypeId%>';
	var subjectQueryDefUniqueId='<%=subjectQueryDefUniqueId%>';
	commonHelpDataSet.setParameter("PROCESS_TYPE",procTypeId);
	commonHelpDataSet.setParameter("SUBJECT_QUERY_DEF_UNIQUE_ID",subjectQueryDefUniqueId);
	commonHelpDataSet.load();
	  L5.QuickTips.init();
}


function save(){
	var dialogUrl = document.getElementById("dialogUrl").value;
	var dialogWidth = document.getElementById("dialogWidth").value;
	var dialogHeight = document.getElementById("dialogHeight").value;
	if(dialogUrl==""||dialogUrl==undefined){
		alert("弹出框URL不能为空！");
		return;
	}else if(dialogWidth==""||dialogWidth==undefined){
		alert("弹出框宽度不能为空！");
		return;
	}else if(dialogHeight==""||dialogHeight==undefined){
		alert("弹出框高度不能为空！");
		return;
	}
	var commonHelpDataSet=L5.DatasetMgr.lookup("commonHelpDataSet");
	var records = commonHelpDataSet.getCurrent();
	records.set("subjectQueryDefUniqueId","<%=subjectQueryDefUniqueId%>");
	records.set("procType","<%=procTypeId%>");
	if (records) {
		var command = new L5.Command("org.loushang.workflow.processdefinition.tasklist.proctypesubjectdef.cmd.ProcTypeSubjectDefCmd");
        command.setParameter("records", records);
        command.execute("saveProcTyepSubjectQueryCommonHelpDef");
        if (!command.error) {
        	commonHelpDataSet.commitChanges();
        	commonHelpDataSet.reload();
	        L5.Msg.alert("提示", "数据保存成功!");
	        } else {
		        L5.Msg.alert(command.error);
		        }
        }else{
            alert("提示","没有可保存信息");
        }
}


function back(){
	window.history.go(-1);
	
}
</script>
</html>