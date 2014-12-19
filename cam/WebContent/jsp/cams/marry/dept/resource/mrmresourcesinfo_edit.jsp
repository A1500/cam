
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
	<head>
		<title>资源信息表编辑</title>
		<next:ScriptManager/>
		<script>
			var idField='<%=request.getParameter("dataBean")%>';
			var method='<%=request.getParameter("method")%>';
		</script>
		<script type="text/javascript" src="mrmresourcesinfo_edit.js"></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.marry.base.cmd.MrmResourcesInfoQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmResourcesInfo"></model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
<next:AnchorLayout>
<next:Panel  title="资源信息表">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="save"  text="保存" handler="save"/>
		<next:ToolBarItem iconCls="undo"  text="返回" handler="back"/>
	</next:TopBar>
	<next:Html>
		<form id="editForm"   dataset="ds" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="100%" >
		
	   		<tr>
				<td  class="FieldLabel" >资源ID</td>
				<td class="FieldInput"><input type="text" name="resourceId" field="resourceId"  /><font color="red">*</font> </td>
			
				<td  class="FieldLabel" >登记机关ID</td>
				<td class="FieldInput"><input type="text" name="organId" field="organId"  /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >资源名称</td>
				<td class="FieldInput"><input type="text" name="resourceName" field="resourceName"  /><font color="red">*</font> </td>
			
				<td  class="FieldLabel" >数量</td>
				<td class="FieldInput"><input type="text" name="resourceNum" field="resourceNum"  /><font color="red">*</font> </td>
			</tr>
						
		</table>
		</form>
   </next:Html>
</next:Panel>
</next:AnchorLayout>
</next:ViewPort>
</body>
</html>
