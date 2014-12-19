
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
	<head>
		<title>资格考试报名明细</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="mrmexamapply_detail.js"></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.marry.base.cmd.MrmExamApplyQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.marry.base.dao.MrmExamApply"></model:record>
		<model:params>
			<model:param name="KSBM_ID" value='<%=request.getParameter("ksbmId")%>'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>

<next:Panel  title="资格考试报名">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
	    <next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="undo"  text="返回" handler="back"/>
	</next:TopBar>
	<next:Html>
		<form id="editForm"   dataset="ds" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="100%" >
		
	   		<tr>
				<td  class="FieldLabel" >考试报名id</td>
				<td class="FieldInput"><label field="ksbmId" /> </td>
			
				<td  class="FieldLabel" >考试安排id</td>
				<td class="FieldInput"><label field="examplanId" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >人员id</td>
				<td class="FieldInput"><label field="personId" /> </td>
			
				<td  class="FieldLabel" >机关id</td>
				<td class="FieldInput"><label field="organId" /> </td>
			</tr>			
		</table>
		</form>
   </next:Html>
</next:Panel>
</body>
</html>
