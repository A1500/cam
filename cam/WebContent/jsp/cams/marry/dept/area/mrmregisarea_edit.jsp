
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
	<head>
		<title>登记机关场所</title>
		<next:ScriptManager/>
		<script>
			var idField='<%=request.getParameter("dataBean")%>';
			var method='<%=request.getParameter("method")%>';
		</script>
		<script type="text/javascript" src="mrmregisarea_edit.js"></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="areaNameDs" enumName="MRM.AREA.NAME" autoLoad="true" pageSize="-1"></model:dataset>
	<model:dataset id="ds" cmd="com.inspur.cams.marry.base.cmd.MrmRegisAreaQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmRegisArea"></model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
<next:AnchorLayout>
<next:Panel  title="登记机关场所">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="save"  text="保存" handler="insert"/>
		<next:ToolBarItem iconCls="undo"  text="返回" handler="back"/>
	</next:TopBar>
	<next:Html>
		<form id="editForm"   dataset="ds" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="100%" >
		
	   		<tr>
				<td  class="FieldLabel" >登记机关代码</td>
				<td class="FieldInput">
				<input type="text" name="deptId" field="deptId"  disabled="disabled"/>
				<td  class="FieldLabel" >登记机关名称</td>
				<td class="FieldInput">
			    <input type="text" name="deptName" field="deptName"  disabled="disabled"/></td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >机关场所名称</td>
				<td class="FieldInput">
				<select name="functionName" field="functionName"  >
					<option dataset="areaNameDs"></option>
				</select>
				 <font color="red">*</font> </td>
			
				<td  class="FieldLabel" >面积(平方米)</td>
				<td class="FieldInput"><input type="text" name="functionArea" field="functionArea"  /> <font color="red">*</font> </td>
			</tr>
						
		</table>
		</form>
   </next:Html>
</next:Panel>
</next:AnchorLayout>
</next:ViewPort>
</body>
</html>
