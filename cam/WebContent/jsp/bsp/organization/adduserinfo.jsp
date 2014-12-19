<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils" %>
<%@ include file="/jsp/public/resources_jspdir.jsp"%>
<link rel="stylesheet"  type="text/css" href="skin.css">
<html>
<head>
<title>用户信息增加</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript">

 	var struId='<%=request.getParameter("struId")%>';
	var organName='<%=request.getParameter("organName")%>';
	var RES_PROMOT='<%=res.get("MSG.PROMOT")%>';
</script>
<script type="text/javascript" src="adduserinfo.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="dsUser" global="true">
		<model:record fromBean="org.loushang.bsp.permit.pap.user.data.UserView"></model:record>
	</model:dataset>
	<model:dataset id="isSys" enumName="USER.IS_SYS"  autoLoad="true" global="true"></model:dataset>
</model:datasets>
	 <next:Panel id="userInfoPanel" title="用户信息增加" >
		 		<next:TopBar>
		 		    <next:ToolBarItem symbol="->"></next:ToolBarItem>
		 			<next:ToolBarItem iconCls="save" text="保存" handler="save"></next:ToolBarItem>
		 			<next:ToolBarItem iconCls="no" text="关闭" handler="saveBack"></next:ToolBarItem>
		 		</next:TopBar>
				<next:Html >
		 	 <div id="user_info" dataset="dsUser">
		 	      <form class="L5form"  class="L5form">
					 <table style="width:100%">
						<tr>
							<td class="FieldLabel" style="width:10%">登录用户名</td>
							<td class="FieldInput" style="width:35%">
								<input type="text" id="userId" field="userId" /><font color="red">*</font>
							</td>
						</tr>
						<tr>
						  <td class="FieldLabel" style="width:10%">用户名称</td>
							<td class="FieldInput" style="width:35%">
								<input type="text" id="userName" field="userName" /><font color="red">*</font>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width:10%">密码</td>
							<td class="FieldInput" style="width:35%">
								<input type="password" id="passWord" field="passWord" onchange="ValidatePwd(this)" /><font id="passWordHint" color="red">*</font>
							</td>
						</tr>
						<tr>
						 <td class="FieldLabel" style="width:10%">确认密码</td>
							<td class="FieldInput" style="width:35%">
								<input type="password" id="passWord2" field="passWord" onchange="ValidatePwdConfirm(this)" /><font id="passWord2Hint" color="red">*</font>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width:10%">员工</td>
							<td class="FieldInput" style="width:35%">
								<input type="text" id="employeeName" field="employeeName" readonly="readonly">
							</td>
						</tr>
						<tr>
						  <td class="FieldLabel" style="width:10%">是否系统管理员</td>
							<td class="FieldInput" style="width:35%">
								<select id="isSys" name="isSys" field="isSys" ><option dataset="isSys"></option></select>
						 </td>
						</tr>
					</table>
		 	      </form>
		 	 </div>
			</next:Html>
		 </next:Panel>

</body>
</html>
<script>

</script>


