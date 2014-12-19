
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
	<head>
		<title>社会组织评估类型配置</title>
		<next:ScriptManager/>
		<script>
			var idField='<%=request.getParameter("dataBean")%>';
			var method='<%=request.getParameter("method")%>';
		</script>
		<script type="text/javascript" src="somassesstype_edit.js"></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.sorg.assess.assesstype.cmd.SomAssessTypeQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.assess.assesstype.dao.SomAssessType"></model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
<next:AnchorLayout>
<next:Panel  title="社会组织评估类型配置">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="save"  text="保存" handler="save"/>
		<next:ToolBarItem iconCls="undo"  text="返回" handler="back"/>
	</next:TopBar>
	<next:Html>
		<form id="editForm"   dataset="ds" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="100%" >
		
	   		<tr>
			
				<td class="FieldLabel" style="width:17%">评估类型代码</td>
				<td class="FieldInput" style="width:17%"><input type="text" name="type" field="type"   style="width:90%" maxlength="3"/> </td>
				<td class="FieldLabel" style="width:17%">评估类型名称</td>
				<td class="FieldInput" style="width:17%"><input type="text" name="typeDesc" field="typeDesc"   style="width:90%" maxlength="50"/> </td>
			</tr>
	   		<tr>
	   			<td  class="FieldLabel" >社会组织类型</td>
				<td class="FieldInput">
					<select id="sorgType" field="sorgType" name='社会团体类型' style="width:90%">
						<option value ="S">社会团体</option>
						<option value ="M">民办非企业</option>
						<option value ="J">基金会</option>
					</select> 
				</td>
				<td  class="FieldLabel" >评估类型状态</td>
				<td class="FieldInput">
					<select id="status" field="status" name='评估类型状态' style="width:90%">
						<option value ="0">待使用</option>
						<option value ="1">使用中</option>
						<option value ="2">停止使用</option>
					</select> 
				</tr>				
		</table>
		</form>
   </next:Html>
</next:Panel>
</next:AnchorLayout>
</next:ViewPort>
</body>
</html>
