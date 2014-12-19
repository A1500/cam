<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<link rel="stylesheet"  type="text/css" href="skin.css">
<html>
<head>
	<title>成员排序</title>
	<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="ordersub.js"></script>
<script type="text/javascript">
 var struId='<%=request.getParameter("struId")%>';
</script>
</head>
<body >

<next:Panel>
<next:TopBar>
	<next:ToolBarItem symbol="->"></next:ToolBarItem>
	<next:ToolBarItem id="saveButoon" iconCls="yes" text="确定" handler="confirmValue()"></next:ToolBarItem>
	<next:ToolBarItem id="closeButoon" iconCls="no" text="关闭" handler="closew()"></next:ToolBarItem>
</next:TopBar>
<next:Html>
<form id="subOrderForm"  method="post"   onsubmit="return false"  class="L5form">
				 <div align="left">成员排序</div>
				 <div align="left">
				 <select name="subStruSel"  id="subStruSelId"  size="20"   style="height: 370px;width:320px;"></select>
				</div>
				<div align="left">
					<button name="turnSelUp" onclick="turnToSelUp()">向上</button>
					&nbsp;
					<button name="turnSelDown" onclick="turnToSelDown()">向下</button>
					&nbsp;
					<button name="turnSelTop" onclick="turnToSelTop()">顶端</button>
					&nbsp;
					<button name="turnSelBottom" onclick="turnToSelBottom()">底端</button>
			  </div>


</form>
</next:Html>
</next:Panel>
</body>
</html>
<script type="text/javascript">


</script>
