
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
	<head>
		<title>SOM_ASSESS明细</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="somassess_detail.js"></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.sorg.assess.assess.cmd.SomAssessQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.assess.assess.dao.SomAssess"></model:record>
		<model:params>
			<model:param name="TASK_CODE" value='<%=request.getParameter("taskCode")%>'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>

<next:Panel  title="SOM_ASSESS">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
	    <next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="undo"  text="返回" handler="back"/>
	</next:TopBar>
	<next:Html>
		<form id="editForm"   dataset="ds" onsubmit="return false" style="" class="L5form">
		<table border="1"  width="100%" >
		
	   		<tr>
				<td  class="FieldLabel" style='width:20%'>业务编号</td>
				<td class="FieldInput"style='width:30%'><label field="taskCode" /> </td>
			
				<td  class="FieldLabel" style='width:20%'>任务编号</td>
				<td class="FieldInput"style='width:30%'><label field="taskId" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >评估类型</td>
				<td class="FieldInput"><label field="assessType" /> </td>
			
				<td  class="FieldLabel" >评估社会组织类型</td>
				<td class="FieldInput"><label field="sorgType" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >评估社会组织登记证号</td>
				<td class="FieldInput"><label field="sorgCode" /> </td>
			
				<td  class="FieldLabel" >社会组织名称</td>
				<td class="FieldInput"><label field="sorgName" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >总分数</td>
				<td class="FieldInput"><label field="score" /> </td>
			
				<td  class="FieldLabel" >评估人姓名</td>
				<td class="FieldInput"><label field="assessPersonName" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >登陆人姓名</td>
				<td class="FieldInput"><label field="loginName" /> </td>
			
				<td  class="FieldLabel" >登陆人组织机构代码</td>
				<td class="FieldInput"><label field="loginOrganId" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >登陆人所在行政区划</td>
				<td class="FieldInput"><label field="areaCode" /> </td>
			
				<td  class="FieldLabel" >评估时间</td>
				<td class="FieldInput"><label field="assessDate" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >备注</td>
				<td class="FieldInput"><label field="note" /> </td>
					</tr>			
		</table>
		</form>
   </next:Html>
</next:Panel>
</body>
</html>
