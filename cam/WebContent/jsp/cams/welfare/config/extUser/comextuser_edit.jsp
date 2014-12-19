<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
	<head>
		<title>外网用户信息编辑</title>
		<next:ScriptManager/>
		<script>
			var organArea='<%=BspUtil.getCorpOrgan().getOrganCode()%>';
			var organName='<%=BspUtil.getCorpOrgan().getOrganName()%>';
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
</model:datasets>
<next:ViewPort>
<next:AnchorLayout>
<next:Panel  title="外网用户信息">
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
				<td class="FieldInput" colspan="3"><input type="text" id = "userId"name="userId" title="用户名" field="userId" onblur="this.value=this.value.toUpperCase()" title="用户名"/><font color="red">建议使用福利企业民称首字母作为用户名</font> </td>
			</tr>
			<tr>
				<td  class="FieldLabel" >企业名称</td>
				<td class="FieldInput" colspan="3"><input type="text"  name="userName" field="userName" title="企业名称" style="width:90%" /><font color="red">*</font> </td>
			</tr>
			<tr>
				<td  class="FieldLabel" >密码</td>
				<td class="FieldInput"><input type="password" name="pwd" field="pwd"  title="密码"/><font color="red">*</font> </td>
	   			<td  class="FieldLabel" >企业类型</td>
				<td class="FieldInput">
					<select id="organType" field="organType" blank="false" title="企业类型">
						<option value ="">请选择...</option>
						<option value ="FL">福利企业</option>
						<option value ="JZ">假矫企业</option>
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
		</table>
		</form>
   </next:Html>
</next:Panel>
</next:AnchorLayout>
</next:ViewPort>
</body>
</html>
