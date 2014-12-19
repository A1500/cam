
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
	<head>
		<title>资格考试报名编辑</title>
		<next:ScriptManager/>
		<script>
			var idField='<%=request.getParameter("dataBean")%>';
			var method='<%=request.getParameter("method")%>';
		</script>
		<script type="text/javascript" src="mrmexamapply_edit.js"></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.marry.base.cmd.MrmExamApplyQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.marry.base.dao.MrmExamApply"></model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
<next:AnchorLayout>
<next:Panel  title="资格考试报名">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="save"  text="保存" handler="save"/>
		<next:ToolBarItem iconCls="undo"  text="返回" handler="back"/>
	</next:TopBar>
	<next:Html>
		<form id="editForm"   dataset="ds" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="100%" >
		
	   		<tr>
				<td  class="FieldLabel" >考试报名id</td>
				<td class="FieldInput"><input type="text" name="ksbmId" field="ksbmId"  /><font color="red">*</font> </td>
			
				<td  class="FieldLabel" >考试安排id</td>
				<td class="FieldInput"><input type="text" name="examplanId" field="examplanId"  /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >人员id</td>
				<td class="FieldInput"><input type="text" name="personId" field="personId"  /> </td>
			
				<td  class="FieldLabel" >机关id</td>
				<td class="FieldInput"><input type="text" name="organId" field="organId"  /> </td>
			</tr>
						
		</table>
		</form>
   </next:Html>
</next:Panel>
</next:AnchorLayout>
</next:ViewPort>
</body>
</html>
