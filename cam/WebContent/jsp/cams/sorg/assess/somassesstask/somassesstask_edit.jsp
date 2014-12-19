
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
	<head>
		<title>社会组织评估任务配置编辑</title>
		<next:ScriptManager/>
		<script>
			var idField='<%=request.getParameter("dataBean")%>';
			var method='<%=request.getParameter("method")%>';
		</script>
		<script type="text/javascript" src="somassesstask_edit.js"></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.sorg.assess.assesstask.cmd.SomAssessTaskQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.assess.assesstask.data.SomAssessTask"></model:record>
	</model:dataset>
	<model:dataset id="sorgTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SORG_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="assessTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='som_assess_type'></model:param>
			<model:param name="value" value='TYPE'></model:param>
			<model:param name="text" value='TYPE_DESC'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>
<next:ViewPort>
<next:AnchorLayout>
<next:Panel  title="社会组织评估任务配置编辑" width="100%" >
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="save"  text="保存" handler="save"/>
		<next:ToolBarItem iconCls="undo"  text="返回" handler="back"/>
	</next:TopBar>
	<next:Html>
		<form id="editForm"   dataset="ds" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="100%" >
		
	   		<tr>
				<td class="FieldLabel" style="width:17%">社会组织登记证号</td>
				<td class="FieldInput" style="width:17%"><input type="text" name="sorgCode" field="sorgCode"  style="width:98%"/> </td>
				<td class="FieldLabel" style="width:17%">社会组织类型</td>
				<td class="FieldInput" style="width:17%">
				<select id="sorgType" field="sorgType" blank="false">
					<option dataset="sorgTypeSelect"></option>
				</select>
				</td>
			</tr>
	   		<tr>
				<td class="FieldLabel" >社会组织名称</td>
				<td class="FieldInput" colspan="3"><input type="text" name="sorgName" field="sorgName"  style="width:98%"/> </td>
			</tr>
	   		<tr>
				<td class="FieldLabel">任务状态:</td>
				<td class="FieldInput">
				<select id="ifEnd" field="ifEnd" name='任务状态' style="width:55%">
					<option value ="1">启用</option>
					<option value ="0">结束</option>
				</select> 
				</td>	
				<td class="FieldLabel">评估类型:</td>
				<td class="FieldInput">
				<select id="assessType" field="assessType" blank="false">
					<option dataset="assessTypeSelect"></option>
				</select>
				</td>	
			</tr>
						
		</table>
		</form>
   </next:Html>
</next:Panel>
</next:AnchorLayout>
</next:ViewPort>
</body>
</html>
