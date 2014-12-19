
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
	<head>
		<title>社会组织外网用户编辑</title>
		<next:ScriptManager/>
		<script>
			var idField='<%=request.getParameter("dataBean")%>';
			idField=decodeURIComponent(idField);
			var method='<%=request.getParameter("method")%>';
		</script>
		<script type="text/javascript" src="comextuser_edit.js"></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.comm.extuser.cmd.ComExtUserQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.comm.extuser.data.ComExtUser">
			<model:field name="userId" type="string" rule="require|length{500}" />
			<model:field name="pwd" type="string" rule="require|length{30}" />
			<model:field name="userName" type="string" rule="require|length{500}" />
			<model:field name="organType" type="string" rule="require" />
		</model:record>
	</model:dataset>
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="som_lastYearCheckResult" enumName="SOM.LAST_YEAR_CHECK_RESULT" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:ViewPort>
<next:AnchorLayout>
<next:Panel  title="社会组织外网用户信息">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="save"  text="保存" handler="save"/>
		<next:ToolBarItem iconCls="undo"  text="返回" handler="back"/>
	</next:TopBar>
	<next:Html>
		<form id="editForm"   dataset="ds" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="100%" >
		
	   		<tr>
				<td  class="FieldLabel" >用户名</td>
				<td class="FieldInput" colspan="3"><input type="text" name="userId" field="userId" style="width:90%" onblur="this.value=this.value.toUpperCase()" title="用户名"/><font color="red">*</font> </td>
			</tr>
			<tr>
				<td  class="FieldLabel" >社会组织名称</td>
				<td class="FieldInput" colspan="3"><input type="text" name="userName" field="userName" title="社会组织名称" style="width:90%" /><font color="red">*</font> </td>
			</tr>
			<tr>
				<td  class="FieldLabel" >密码</td>
				<td class="FieldInput"><input type="password" name="pwd" field="pwd"  title="密码"/><font color="red">*</font> </td>
	   			<td  class="FieldLabel" >社会组织类型</td>
				<td class="FieldInput">
					<select id="organType" field="organType" blank="false">
						<option value ="ST">社会团体</option>
						<option value ="MF">民办非企业</option>
						<option value ="JJ">基金会</option>
					</select><font color="red">*</font> 
				</td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >是否启用</td>
				<td class="FieldInput">
				<select field="accountStatus" id="accountStatus" name='"是否启用"' style="width:90%">
					<option dataset="comm_yesorno"></option>
				</select>
				</td>
				<td  class="FieldLabel" >住址</td>
				<td class="FieldInput"><input type="text" name="adds" field="adds"  /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >联系电话</td>
				<td class="FieldInput"><input type="text" name="phone" field="phone"  /> </td>
			
				<td  class="FieldLabel" >电子邮件</td>
				<td class="FieldInput"><input type="text" name="email" field="email"  /> </td>
			</tr>
			<tr>
				<td  class="FieldLabel" >上一年的年检结果</td>
				<td class="FieldInput">
					<select name="lastYearCheckResult" field="note" >
						<option dataset="som_lastYearCheckResult"></option>
					</select> 
				</td>
				<td  class="FieldLabel" ></td>
				<td class="FieldInput"></td>
			</tr>		
		</table>
		</form>
   </next:Html>
</next:Panel>
</next:AnchorLayout>
</next:ViewPort>
</body>
</html>
