<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>

<html>
	<head>
		<title>通用帮助定义</title>
		<next:ScriptManager></next:ScriptManager>
		<%
			String subjectQueryDefUniqueId=request.getParameter("subjectQueryDefUniqueId");//查询字段定义唯一id
			String procDefUniqueId=request.getParameter("procDefUniqueId");//流程定义唯一id
		%>
	</head>
	<body>
		<model:datasets>
			<model:dataset id="commonHelpDataSet" 
				cmd="org.loushang.workflow.processdefinition.tasklist.procsubjectdef.cmd.ProcSubjectDefQueryCmd"
				 autoLoad="false" method="queryCommonHelp">
				<model:record 
					fromBean="org.loushang.workflow.processdefinition.tasklist.procsubjectdef.data.ProcSubjectQueryCommonHelpDef">
				</model:record>
			</model:dataset>
		</model:datasets>
		<next:Panel>
			<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="save" text="保存" handler="save"/>
				<next:ToolBarItem iconCls="undo" text="返回" handler="backToProcSubjectQuery"/>
 			</next:TopBar>
 			<next:Html>
 				<form id="commonHelpForm" method="post" dataset="commonHelpDataSet"
					onsubmit="return false" class="L5form">
 					<table border="1" width="100%">
 						<input type="hidden" id="id" field="id" value=""/>
 						<input type="hidden" id="subjectQueryDefUniqueId" field="subjectQueryDefUniqueId" value="<%=subjectQueryDefUniqueId %>"/>
 						<input type="hidden" id="procDefUniqueId" field="procDefUniqueId" value="<%=procDefUniqueId %>"/>
 						<tr>
 							<td class="FieldLabel">弹出框URL</td>
 							<td class="FieldInput">
 								<input type="text" id="dialogUrl" name="弹出框URL" field="dialogUrl" class="TextEditor"/>
 							</td>
 						</tr>
 						<tr>
 							<td class="FieldLabel">弹出框宽度</td>
 							<td class="FieldInput">
 								<input type="text" id="dialogWidth" name="弹出框宽度" field="dialogWidth" class="TextEditor"/>
 							</td>
 						</tr>
 						<tr>
 							<td class="FieldLabel">弹出框高度</td>
 							<td class="FieldInput">
 								<input type="text" id="dialogHeight" name="弹出框高度" field="dialogHeight" class="TextEditor"/>
 							</td>
 						</tr>
 						<tr>
 							<td class="FieldLabel">查询条件</td>
 							<td class="FieldInput">
 								<select id="conditionUseWay" name="查询条件" field="conditionUseWay" >
 									<option value="0">使用返回值</option>
 									<option value="1">使用返回显示值</option>
 								</select>
 							</td>
 						</tr>
 						<tr>
 							<td class="FieldLabel">帮助框返回值下标</td>
 							<td class="FieldInput">
 								<input type="text" id="keyReturnIndex" name="帮助框返回值下标" field="keyReturnIndex" class="TextEditor"/>
 							</td>
 						</tr>
 						<tr>
 							<td class="FieldLabel">帮助框返回显示值下标</td>
 							<td class="FieldInput">
 								<input type="text" id="aliasReturnIndex" name="帮助框返回显示值下标" field="aliasReturnIndex" class="TextEditor"/>
 							</td>
 						</tr>
 					</table>
 				</form>
 			</next:Html>
		</next:Panel>
	</body>
	
	<script language="javascript">
		function init(){
		  var commonHelpDataSet = L5.DatasetMgr.lookup("commonHelpDataSet");
		  var subjectQueryDefUniqueId='<%=subjectQueryDefUniqueId%>';//查询字段定义唯一id
		  var procDefUniqueId='<%=procDefUniqueId%>';//流程定义唯一id
		  
		  commonHelpDataSet.setParameter("subjectQueryDefUniqueId",subjectQueryDefUniqueId);
		  commonHelpDataSet.setParameter("procDefUniqueId",procDefUniqueId);
		  commonHelpDataSet.load();
		  //L5.QuickTips.init(); 
		}
		
		//保存通用帮助定义
		function save(){
			var commonHelpDataSet = L5.DatasetMgr.lookup("commonHelpDataSet");
			var valid  = commonHelpDataSet.isValidate();
			if(valid!=true){
				var str=valid.replace("dialogUrl","弹出框URL").replace("dialogWidth","弹出框宽度").replace("dialogHeight","弹出框高度").replace("conditionUseWay","查询条件");
				L5.Msg.alert("提示",str);
				return false;
			}
			var record = commonHelpDataSet.getCurrent();
			//var url = record.get("dialogUrl");
			//var basePath = '';
			//url = basePath + url;
			//record.set("dialogUrl",url);
			//alert(url);
			var command = new L5.Command(
						"org.loushang.workflow.processdefinition.tasklist.procsubjectdef.cmd.ProcSubjectDefCmd");
			command.setParameter("record",record);
			command.execute("saveProcSubjectQueryCommonHelpDef");
			if (!command.error) {
				commonHelpDataSet.commitChanges();
				commonHelpDataSet.reload();
				L5.Msg.alert("提示", "数据保存成功!");
			} else {
				L5.Msg.alert(command.error);
			}
		}
		
		//返回到流程定义层次任务标题查询条件定义
		function backToProcSubjectQuery(){
			var url = "";
			window.history.go(-1);
		}
	
	
	</script>
</html>