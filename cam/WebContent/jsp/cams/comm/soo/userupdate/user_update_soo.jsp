<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>GridPanel</title>

<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="user_update_soo.js"></script>
<%
	String userName = GetBspInfo.getBspInfo().getUserId();
%>
<script type="text/javascript">
	var userName = '<%=userName%>';
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="sooDs" cmd="com.inspur.cams.comm.soo.cmd.PubCamsSooQueryCommand" global="true" pageSize="50">
		<model:record fromBean="com.inspur.cams.comm.soo.data.PubCamsSoo"></model:record>
	</model:dataset>
	<!-- 单点登陆类别-->
	<model:dataset id="typeds"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true" >
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CAMS_SOO_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset> 
</model:datasets>
<next:EditGridPanel title="单点登陆用户配置" id="gridPanel" name="gridPanel" width="100%"
	height="100%" dataset="sooDs">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="add" text="增加" handler="add"></next:ToolBarItem>
		<next:ToolBarItem iconCls="remove" text="删除" handler="del"></next:ToolBarItem>
		<next:ToolBarItem iconCls="undo" text="撤销" handler="undo"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="save"></next:ToolBarItem>
	</next:TopBar>

	<next:Columns>
		<next:RowNumberColumn />
		<next:Column header="类型" field="type"  sortable="true" width="30%">
			<next:ComboBox  dataset="typeds"  displayField="text" valueField="value"  triggerAction="all"/>
		</next:Column>
		<next:Column header="用户名" field="userName"  sortable="true" width="30%">
			<next:TextField></next:TextField>
		</next:Column>
		<next:Column header="密码" field="userPassword"  sortable="true" width="30%">
			<next:TextField></next:TextField>
		</next:Column>
	</next:Columns>

	<next:BottomBar>
		<next:PagingToolBar dataset="sooDs" />
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>