
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
	<head>
		<title>登记机关功能区面积表明细</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="mrmregisarea_detail.js"></script>
		<script type="text/javascript">
			var idField='<%=request.getParameter("dataBean")%>';
		</script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.marry.base.cmd.MrmRegisAreaQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmRegisArea"></model:record>
	</model:dataset>
</model:datasets>

<next:Panel  title="登记机关功能区面积表">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
	    <next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="undo"  text="返回" handler="back"/>
	</next:TopBar>
	<next:Html>
		<form id="editForm"   dataset="ds" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="100%" >
		
	   		<tr>
				<td  class="FieldLabel" >资源ID</td>
				<td class="FieldInput"><label field="functionId" /> </td>
			
				<td  class="FieldLabel" >登记机关ID</td>
				<td class="FieldInput"><label field="organId" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >资源名称</td>
				<td class="FieldInput"><label field="functionName" /> </td>
			
				<td  class="FieldLabel" >数量</td>
				<td class="FieldInput"><label field="functionArea" /> </td>
			</tr>			
		</table>
		</form>
   </next:Html>
</next:Panel>
</body>
</html>
