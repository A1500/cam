<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.bsp.util.BspConstants" %>
<next:ScriptManager ></next:ScriptManager>
<html>
<head>
<title>选择行政区划</title> 
<script type="text/javascript">
	//要选择的行政区划结构树的根，取cantCode的值，如果不指定的话，根据数据权限取值，方式待定
	var rootId='<%=request.getParameter("rootId")%>';
	//配置可以选择的类型，如果需要选择多种行政区划类型，则请以“,” 号分割。 默认值为0 ，表示全部类型都是可以选择
	var choiceCantType='<%=request.getParameter("choiceCantType")%>';
	//用来控制显示的组织类型，如果需要显示多种组织类型，则请以“,” 号分割。 默认值为0 ，表示全部类型都可以显示
	var showCantType='<%=request.getParameter("showCantType")%>';
	//0单选 ，1 多选
	var isCheckBox='<%=request.getParameter("isCheckBox")%>';
</script>
<script type="text/javascript" src="select_cant.js"></script>
</head>
<body>

<next:Panel   anchor="100% 100%" border="false" autoScroll="false">
<next:TopBar>
	<next:ToolBarItem symbol="->"></next:ToolBarItem>
	<next:ToolBarItem id="saveButoon" iconCls="yes" text="确定" handler="confirmValue()"></next:ToolBarItem>
	<next:ToolBarItem id="closeButoon" iconCls="no" text="关闭" handler="closew()"></next:ToolBarItem>
	<next:ToolBarItem id="closeButoon" iconCls="no" text="清除" handler="clears()"></next:ToolBarItem>
</next:TopBar>
<next:Tree name="canttree" id="canttree"  title="选择行政区划"  rootVisible="true" rootExpanded="false"
   allowCheck="isCheckedSub"    border="false" lines="true"  autoScroll="true" >
	<next:TreeDataSet dataset="cantDs" root="rootdata">
		<next:TreeLoader cmd="org.loushang.bsp.ext.location.cmd.CantQueryCmd"  method="getSelectHelp" >
			<next:treeRecord name="cant"  idField="cantCode" fromBean="org.loushang.bsp.ext.location.data.Cant">
			</next:treeRecord>
			<next:TreeBaseparam name="superCode"    value="getSuperCode" />
			<next:TreeBaseparam name="cantCode"    value="getCantCode" />
			<next:TreeBaseparam name="choiceCantType"    value="getChoiceCantType" />
			<next:TreeBaseparam name="showCantType"    value="getShowCantType" />
		</next:TreeLoader>
	</next:TreeDataSet>
	<next:TreeNodemodel recordType="cant">
	   <next:TreeNodeAttribute name="text" handler="getNodeText"></next:TreeNodeAttribute>
	   <next:TreeNodeAttribute name="showType" handler="getChoiceBox"></next:TreeNodeAttribute>
	   <next:TreeNodeAttribute name="leaf" value="false"></next:TreeNodeAttribute>
	   <next:TreeNodeAttribute name="changeParent" value="false"></next:TreeNodeAttribute>
	</next:TreeNodemodel>
</next:Tree>
 </next:Panel>
</body>
</html>