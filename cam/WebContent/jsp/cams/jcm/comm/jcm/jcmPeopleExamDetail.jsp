<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>人员培训信息（多条记录过程）明细</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="jcmPeopleExam.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var peopleExamId='<%=request.getParameter("peopleExamId")%>';
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="jcmPeopleExamDataSet" cmd="com.inspur.cams.jcm.cmd.JcmPeopleExamQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.jcm.data.JcmPeopleExam"/>
	</model:dataset>
</model:datasets>
<next:Panel width="100%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="jcmPeopleExamDataSet" onsubmit="return false" class="L5form">
<fieldset>
	<legend>人员培训信息（多条记录过程）</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">培训主键：</td>
			<td class="FieldInput" style="width:36%"><label field="peopleExamId"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">人员主键：</td>
			<td class="FieldInput" style="width:36%"><label field="peopleId"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">培训年度：</td>
			<td class="FieldInput" style="width:36%"><label field="examYear"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">培训内容：</td>
			<td class="FieldInput" style="width:36%"><label field="examContent"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">培训时间：</td>
			<td class="FieldInput" style="width:36%"><label field="examTime"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">培训地点：</td>
			<td class="FieldInput" style="width:36%"><label field="examPlace"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">是否考试：</td>
			<td class="FieldInput" style="width:36%"><label field="isExam"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">考试结果：</td>
			<td class="FieldInput" style="width:36%"><label field="examRuslut"/></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>