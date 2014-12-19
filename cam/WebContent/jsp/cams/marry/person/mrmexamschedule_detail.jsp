
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
	<head>
		<title>登记员资格考试安排表编辑</title>
		<next:ScriptManager/>
		<script>
			var idField='<%=request.getParameter("dataBean")%>';
			var method='<%=request.getParameter("method")%>';
		</script>
		<script type="text/javascript" src="mrmexamschedule_edit.js"></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.marry.base.cmd.MrmExamScheduleQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmExamSchedule"></model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
<next:AnchorLayout>
<next:Panel  title="登记员资格考试安排表">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="undo"  text="返回" handler="back"/>
	</next:TopBar>
	<next:Html>
		<form id="editForm"   dataset="ds" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="100%" >
		
	   		<tr>
			
				<td  class="FieldLabel" style="width:25%">年度</td>
				<td class="FieldInput"><label type="text" name="ndYear" field="ndYear"  /><font color="red">*</font> </td>
			
				<td  class="FieldLabel" style="width:25%" >考试期次</td>
				<td class="FieldInput"><label type="text" name="ksqs" field="ksqs"  /><font color="red">*</font> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >考试时间</td>
				<td class="FieldInput"><label type="text" name="ksbeginTime" field="ksbeginTime"  onclick="LoushangDate(this)" format="Y-m-d" /><font color="red">*</font> </td>
			
			<td  class="FieldLabel" >计划安排人数</td>
				<td class="FieldInput"><label type="text" name="ksPeonum" field="ksPeonum"  /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >考试地点</td>
				<td class="FieldInput" colspan="3"><label type="text" name="ksAdd" field="ksAdd" style="width:90%" /> </td>
			</tr>
		</table>
		</form>
   </next:Html>
</next:Panel>
</next:AnchorLayout>
</next:ViewPort>
</body>
</html>
