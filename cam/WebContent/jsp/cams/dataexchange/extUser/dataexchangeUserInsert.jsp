<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
	<head>
		<title>数据共享用户编辑</title>
		<next:ScriptManager/>
		<script>
			var idField='<%=request.getParameter("dataBean")%>';
			idField=decodeURIComponent(idField);
			var method='<%=request.getParameter("method")%>';
		</script>
		<script type="text/javascript" src="dataexchangeUserInsert.js"></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
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
<next:Panel  title="数据共享用户信息" autoScroll="true" width="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="save"  text="保存" handler="save"/>
		<next:ToolBarItem iconCls="undo"  text="返回" handler="back"/>
	</next:TopBar>
	<next:Html>
		<fieldset>
		<legend>用户基本信息</legend>
		<form id="editForm"   dataset="ds" onsubmit="return false" class="L5form">
		<table border="1"  width="100%" >
		
	   		<tr>
				<td  class="FieldLabel"  style="width:17%">用户登录名</td>
				<td class="FieldInput"><input type="text" name="userId" id="userId" field="userId" style="width:68%" onchange="this.value=this.value.toUpperCase();" title="用户登录名"/><font color="red">*</font><font id="userCheck" style="display:none" color="red">该用户名已经存在</font> </td>
				<td  class="FieldLabel" >用户名称</td>
				<td class="FieldInput"><input type="text" name="userName" field="userName" title="社会组织名称" style="width:70%" /><font color="red">*</font> </td>
			</tr>
			<tr>
				<td  class="FieldLabel" >密码</td>
				<td class="FieldInput" colspan="3"><input type="password" name="pwd" field="pwd"  title="密码"/><font color="red">*</font> </td>
	   			<!-- <td  class="FieldLabel" >数据权限类型</td>
				<td class="FieldInput">
					<select id="organType" field="organType" blank="false">
						<option value ="marry">婚姻</option>
						<option value ="funeral">殡葬</option>
					</select><font color="red">*</font> 
				</td>
				 -->
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
		</fieldset>
   </next:Html>
</next:Panel>
</body>
</html>
