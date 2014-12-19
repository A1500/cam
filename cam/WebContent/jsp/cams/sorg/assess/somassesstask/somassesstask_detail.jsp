
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
	<head>
		<title>社会组织评估任务配置明细</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="somassesstask_detail.js"></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.sorg.assess.assesstask.cmd.SomAssessTaskQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.assess.assesstask.data.SomAssessTask"></model:record>
		<model:params>
			<model:param name="TASK_ID" value='<%=request.getParameter("taskId")%>'></model:param>
		</model:params>
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
			<model:param name="dic" value='SOM_ASSESS_TYPE'></model:param>
			<model:param name="value" value='TYPE'></model:param>
			<model:param name="text" value='TYPE_DESC'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>

<next:Panel  title="社会组织评估任务配置明细" width="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
	    <next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="undo"  text="返回" handler="back"/>
	</next:TopBar>
	<next:Html>
		<form id="editForm"   dataset="ds" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="100%" >
		
	   		<tr>
				<td  class="FieldLabel">社会组织登记证号</td>
				<td class="FieldInput"><label field="sorgCode" /> </td>
			
				<td  class="FieldLabel">社会组织类型</td>
				<td class="FieldInput"><label field="sorgType"  dataSet="sorgTypeSelect"/> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel">社会组织名称</td>
				<td class="FieldInput" colspan="3"><label field="sorgName" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel">登记单位</td>
				<td class="FieldInput"><label field="organName" /> </td>
				<td  class="FieldLabel">登记单位区划</td>
				<td class="FieldInput"><label field="organAreaCode" /> </td>
			</tr>
	   		<tr>
	   			<td  class="FieldLabel">评估类型</td>
				<td class="FieldInput"><label field="assessType" dataSet="assessTypeSelect"/> </td>
				<td  class="FieldLabel">任务状态</td>
				<td class="FieldInput"><label field="ifEnd" /> </td>
			</tr>	
			<tr>
				<td  class="FieldLabel">启用时间</td>
				<td class="FieldInput"><label field="startDate" /> </td>
				<td  class="FieldLabel"></td>
				<td class="FieldInput"></td>
			</tr>		
		</table>
		</form>
   </next:Html>
</next:Panel>
</body>
</html>
