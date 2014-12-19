<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils" %>
<next:ScriptManager ></next:ScriptManager>
<html>
<head>
<title>选择文件路径</title>

<script type="text/javascript" src="selectexport.js"></script>
</head>
<body>
<next:Panel  anchor="100% 100%" border="false">
<next:TopBar>
	<next:ToolBarItem symbol="->"></next:ToolBarItem>
	<next:ToolBarItem id="saveButoon" iconCls="yes" text="确定" handler="confirmValue()"></next:ToolBarItem>
	<next:ToolBarItem id="closeButoon" iconCls="no" text="关闭" handler="closew()"></next:ToolBarItem>
</next:TopBar>
<next:Html>
<form method="post" onsubmit="return false" style="padding: 5px;" class="L5form">
	<table >
		<tr>
			<td  class="FieldLabel" >请选择文件路径</td>
			<td class="FieldInput" >
			<input style="width: 200;" type="text" id="path" name="path"  disabled="disabled"/>
			<img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>"  style="cursor:hand" onclick="browseFolder(path)" />
			</td>
		</tr>
		<tr>
		<td  class="FieldInput" colspan="2">
			<font color="red">
			<br>
			说明：
			<br>
			<br>如果选择文件路径无法显示，请做如下设置
			<br>1.设置可信任站点（例如本地的可以为：http://localhost）
   			<br>2.其次：可信任站点安全级别自定义设置中：设置下面的选项 
			<br>"对没有标记为安全的ActiveX控件进行初始化和脚本运行"----"启用"
			</font>
		</td>
		</tr>
	</table>
</form>
</next:Html>
</next:Panel>
</body>
</html>