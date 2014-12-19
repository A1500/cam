<%@ page language="java" contentType="text/html;charset=utf-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="org.loushang.workflow.util.bsp.WfStru"%>
<%@page import="org.loushang.workflow.util.bsp.BspUtil"%>
<%

%>
<html>
	<head>
		<next:ScriptManager></next:ScriptManager>
	</head>
	<%
	String subjectQueryDefUniqueId = request.getParameter("subjectQueryDefUniqueId");
	%>
<body>

<model:datasets>
	<model:dataset pageSize="15" id="sysCommonHelpDataset" cmd="org.loushang.workflow.processdefinition.tasklist.syssubjectdef.cmd.SysSubjectDefQueryCmd" autoLoad="false" method="querySysSubjectQueryCommonHelpDef">
		<model:record fromBean="org.loushang.workflow.processdefinition.tasklist.syssubjectdef.data.SysSubjectQueryCommonHelpDef"></model:record>
	</model:dataset>
</model:datasets>

<next:ViewPort>
		<next:Defaults>{collapsible:true,split:true,animFloat:true,autoHide:true,useSplitTips:true,bodyStyle:'padding:6px;'}</next:Defaults>
			<next:Panel title="通用帮助定义">
			<next:TopBar>
			<next:ToolBarItem symbol="->"/>
			<next:ToolBarItem iconCls="add" text="保存" handler="forSave" />
			<next:ToolBarItem iconCls="undo" text="返回" handler="forReturn" />
			</next:TopBar>
				<next:Html>			
					<div class="GroupBoxDiv" style="width: 100%;height: 100%;">	
						<form onsubmit="return false;" class="L5form" dataset="sysCommonHelpDataset" method="post">				
							<table  border="1" width="100%">
							<input type="hidden" id="id" field="id" value=""/>
							<input type="hidden" id="subjectQueryDefUniqueId" field="subjectQueryDefUniqueId" value="<%=subjectQueryDefUniqueId%>"/>
								<tr>
									<td class="FieldLabel">弹出框url：</td>
									<td class="FieldInput"><input type="text"  id="dialogUrl" field="dialogUrl" title="弹出框url" /></td>
									</tr>
									<tr>
									<td class="FieldLabel">弹出框宽度：</td>
									<td class="FieldInput"><input type="text"  id="dialogWidth" field="dialogWidth" title="弹出框宽度" /></td>
									</tr>
									<tr>
									<td class="FieldLabel">弹出框高度：</td>
									<td class="FieldInput"><input type="text"  id="dialogHeight" field="dialogHeight" title="弹出框高度" /></td>
									</tr>
									<tr>
									<td class="FieldLabel">帮助框返回值下标：</td>
									<td class="FieldInput"><input type="text"  id="keyReturnIndex" field="keyReturnIndex" title="帮助框返回值下标" /></td>
									</tr>
									<tr>
									<td class="FieldLabel">帮助框返回显示值下标：</td>
									<td class="FieldInput"><input type="text"  id="aliasReturnIndex" field="aliasReturnIndex" title="帮助框返回显示值下标" /></td>
									</tr>
									<tr>
									<td class="FieldLabel">查询条件：</td>
									<td class="FieldInput">
									<select type="text" value="0" id="conditionUseWay" field="conditionUseWay" title="查询条件" >
										<option value="0">使用返回值</option>
										<option value="1">使用返回显示值</option>
									</select>
								</tr>
							</table>
						</form>		
					</div>
				
				</next:Html>
			</next:Panel>			
</next:ViewPort>
</body>
<script language="javascript"  type="text/javascript" >
function init()
{
	var sysCommonHelpDataset = L5.DatasetMgr.lookup("sysCommonHelpDataset");
	sysCommonHelpDataset.setParameter("SUBJECT_QUERY_DEF_UNIQUE_ID","<%=subjectQueryDefUniqueId%>");
	sysCommonHelpDataset.load();
}
function forSave()
{
	var sysCommonHelpDataset = L5.DatasetMgr.lookup("sysCommonHelpDataset");
	var isValidate = sysCommonHelpDataset.isValidate();
	if (isValidate != true) {
		L5.Msg.alert("提示", "校验未通过,不能保存!" + isValidate);
		return;
	}
	
	var records = sysCommonHelpDataset.getCurrent();

	var command = new L5.Command(
			"org.loushang.workflow.processdefinition.tasklist.syssubjectdef.cmd.SysSubjectDefCmd");
	command.setParameter("records", records);
	command.execute("saveSysSubjectQueryCommonHelpDef");
	if (!command.error) {
		sysCommonHelpDataset.commitChanges();
		sysCommonHelpDataset.reload();
		L5.Msg.alert("提示", "数据保存成功!");
	} else {
		L5.Msg.alert(command.error);
	}
}

function forReturn()
{
	var url="jsp/workflow/tasklist/definition/syssubjectdef/syssubjectquerydef.jsp";
	L5.forward(url,"系统全局层次任务标题查询条件定义")
}
</script>
</html>