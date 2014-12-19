<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ page import="org.loushang.next.skin.SkinUtils" %>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<% String proDefId = (String)request.getSession().getAttribute("proDefId");
	String processId=	(String)request.getParameter("processId");
%>
<title></title>
		<next:ScriptManager/>
		<script type="text/javascript">
			var processId="<%=processId%>";
			var beforeInit = {proDefId:"<%=proDefId%>"};
			if(!beforeInit.proDefId){
				L5.Msg.alert("流程定义唯一id为空")
			}
		</script>
		<script type="text/javascript" src="activitystarthelper.js"></script>
</head>
<body>

 <model:datasets>
 	<model:dataset global="true" id="activityDefIdDst" cmd="org.loushang.workflow.manage.activity.cmd.ActivityManageQueryCmd" method="getAllActivityDef" pageSize="-1">
 		<model:record>
 			<model:field name="value" mapping="actDefId" type="string"/>
 			<model:field name="text" mapping="actDefName" type="string"/>
 		</model:record>
 	</model:dataset>
 </model:datasets>
<next:Panel title="选择要启动的环节和参与者" height="270" width="500">
	<next:TopBar >
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="确定" iconCls="save" handler="queding"></next:ToolBarItem>
		<next:ToolBarItem text="取消" iconCls="undo" handler="quxiao"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>

		<div align="center">
		<form  class="L5form">
		<table border="1" width="100%"><tr>
		<td class="FieldLabel">选择环节</td>
		<td class="FieldInput"><select id="actDefId" ><option dataset="activityDefIdDst"></option>
		</select></td>
		<td class="FieldLabel">选择参与者
			<!-- 
		<img src="../../../skins/image/liulan.gif" style="cursor:hand" alt="选择参与者" onclick="showOrgTree()"/></td>
			 -->
		</td>
		<td class="FieldInput"><input type="text" id="organs" readonly="readonly"></input></td>
		<td><img src="<%=SkinUtils.getImage(request,"l5/liulan.gif")%>" style="cursor:hand;" onclick="showOrgTree()" /></td>
		</tr></table>
		</form>
		</div>

	</next:Html>
</next:Panel>
</body>
</html>



