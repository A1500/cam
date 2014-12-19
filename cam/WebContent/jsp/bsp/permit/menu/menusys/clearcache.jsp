
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ include file="/jsp/public/resources_jspdir.jsp"%>
<html>
<head>
<title>清除菜单缓存</title>
<next:ScriptManager />
<script type="text/javascript">
	function clearCache(){
		var cmd = new L5.Command("org.loushang.bsp.permit.menu.cmd.MenuCacheCmd");
		var users = document.getElementById("userId").value;
		if(!users.trim()){
			L5.Msg.alert("提示","请输入用户名");
			return;
		}
		cmd.setParameter("userIds",users);
		cmd.execute();

		if(!cmd.error){
			L5.Msg.alert("提示","成功清除菜单缓存");
		}else{
			L5.Msg.alert("提示","操作失误");
		}
	}
</script>
</head>
<body style="width: 100%">
<next:Panel name="form" width="100%" autoHeight="true"
	collapsible="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" id="saveBtn" text='清除缓存'
			handler="clearCache" />
	</next:TopBar>
	<next:Html>
		<div>
		<form method="post" action="" class="L5form">
		<table border="0" width="100%">
			<tr>
				<td class="FieldLabel" width="30%">请输入用户名</td>
				<td colspan="2"><textarea rows="5" cols="80" id="userId"></textarea><br />
				<p class="FieldInput">
				1. 输入菜单缓存的所属用户名，多个用户名以 “;”分隔<br />
				2. 只输入*清除所有缓存	
				</p>
				</td>
			</tr>
		</table>
		</form>
		</div>
	</next:Html>
</next:Panel>
</body>
</html>