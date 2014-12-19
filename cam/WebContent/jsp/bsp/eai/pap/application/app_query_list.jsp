<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ include file="/jsp/public/resources_jspdir.jsp"%>
<html>
<head>
<title>选择应用</title>
<next:ScriptManager />
<script type="text/javascript" src="app_query_list.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="ds" pageSize="10" pageAble="true" remotePage="false"
		cmd="org.loushang.bsp.eai.pap.application.cmd.AppQueryCommand" method="queryApp" global="true" >
		<model:record
			fromBean="org.loushang.bsp.eai.pap.application.data.App"></model:record>
	</model:dataset>
</model:datasets>

<next:EditGridPanel id="editGridPanel"  name="appGrid"  stripeRows="true" border="false" dataset="ds" anchor="100% 100%"
		collapsible="true" height="100%" width="100%" hideBorders="false" bodyBorder="true">
		<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
	   <next:ToolBarItem id="saveButoon" iconCls="yes" text="确定" handler="confirmValue()"></next:ToolBarItem>
	   <next:ToolBarItem id="closeButoon" iconCls="no" text="取消" handler="closew()"></next:ToolBarItem>
	   <next:ToolBarItem id="clearButoon" iconCls="no" text="清除" handler="clears()"></next:ToolBarItem>
	   </next:TopBar>
		<next:Columns >
		<next:RowNumberColumn width="30" />
		<next:RadioBoxColumn ></next:RadioBoxColumn>
		       <next:Column id="appCode"
					header='应用编码'
					field="appCode" hidden="true">
					<next:TextField   editable="false"/>
				</next:Column>
				<next:Column id="appName"
					header='应用名称'
					field="appName" width="300">
					<next:TextField   editable="false"/>
				</next:Column>
			</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="ds" />
	     </next:BottomBar>
		</next:EditGridPanel>
</body>
</html>
