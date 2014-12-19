<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.extuser.util.ExtBspInfo"%>
<html>
<head>
<title>社区管理</title>
<next:ScriptManager/>
<%
	String organName = ExtBspInfo.getUserInfo(request).getUserName();
	String organId= ExtBspInfo.getUserInfo(request).getAreaCode();
	//String peopleArea= ExtBspInfo.getUserInfo(request).getAreaCode();
	String method = request.getParameter("method");
%>
<script type="text/javascript" src="villageCommunityEdit.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var organId='<%=organId.substring(0,9)+"000"%>';
	var userId='<%=request.getParameter("userId")%>';
	var organName='<%=organName%>';
	var type = '<%=request.getParameter("type")%>';
	var myDate = new Date();
	var mytime=myDate.toLocaleTimeString();
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.comm.extuser.cmd.ComExtUserQueryCmd">
		<model:record fromBean="com.inspur.cams.comm.extuser.data.ComExtUser"/>
	</model:dataset>
	<model:dataset id="cityDs" cmd="com.inspur.cams.comm.diccity.cmd.DicCityQueryCommand">
		<model:record fromBean="com.inspur.cams.comm.diccity.data.DicCity"/>
	</model:dataset>
</model:datasets>
<next:Panel width="100%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="save" text="保存" handler="save"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="ds" onsubmit="return false" class="L5form">
	<fieldset>
	<legend>社区管理</legend>
	<table width="100%">
		<tr>
			<% if(method.equals("insert")){ %>
			<td class="FieldLabel" style="width:18%">社区账号：</td>
			<td class="FieldInput" style="width:16%" ><input type="text"  id="userId"  disabled style="width:75px" />-<input type="text" id='endUserId' style="width:42px" maxLength="2"></input><font color="red">*</font></td>
			<%}else{ %>
			<td class="FieldLabel" style="width:18%">社区账号：</td>
			<td class="FieldInput" style="width:16%" ><input type="text"  id="userId"  disabled field="userId" /><font color="red">*</font></td>
			<%} %>
			<td class="FieldLabel" style="width:18%">社区名称：</td>
			<td class="FieldInput" style="width:16%" ><input type="text"  id="userName" field="userName" /><font color="red">*</font></td>
			<td class="FieldLabel" style="width:18%">密码：</td>
			<td class="FieldInput" style="width:16%" ><input type="password" id="pwd" field="pwd" /><font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">地址：</td>
			<td class="FieldInput" style="width:16%" ><input type="text" id="adds" field="adds" /></td>
			<td class="FieldLabel" style="width:18%">电话：</td>
			<td class="FieldInput" style="width:16%" ><input type="text" id="phone" field="phone" /></td>
			<td class="FieldLabel" style="width:18%">邮箱：</td>
			<td class="FieldInput" style="width:16%" ><input type="text" id="email" field="email" /></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">区划代码：</td>
			<td class="FieldInput" style="width:16%" ><label type="text"  id="areaCode" field="areaCode" /></td>
			<td class="FieldLabel" style="width:18%">上级单位名称：</td>
			<td class="FieldInput" style="width:16%" ><label type="text"  id="organName" field="organName" /></td>
			<td class="FieldLabel" style="width:18%">上级单位ID：</td>
			<td class="FieldInput" style="width:16%"><label type="text"  id="organId" field="organId" /></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">备注：</td>
			<td class="FieldLabel" colspan="5"><textArea  style="width:100%"  field="note"></textArea></td>
		</tr>
		<% if(method.equals("insert")){ %>
		<tr>
			<td class="FieldInput" colspan="6"><label style="height:180px"><font size="3" color="red">注意:社区账号的建立,应遵循以下规则:<br>1.社区账号为12位的数字,字母组合,前9位数字与上级单位ID一致(默认已填写,不需要修改)
			<br>2.新增农村社区第10位为a(默认已填写,不需要修改)<br>3.后两位数字根据数字排序依次填写,不足两位的左边一位补0，如01、02等<br>4.社区账号不能重复</font></label></td>
		</tr>
		<%} %>
	</table>
	</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>