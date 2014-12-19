<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.bsp.util.BspConstants" %>
<next:ScriptManager></next:ScriptManager>
<%
	String flag = BspConstants.bspShareAdapter;
%>
<html>
<head>
<title>选择组织</title>
<script type="text/javascript">
	var rootid='rootId';
	var isExact='0';
	var isCheckBox='1';
	var struTypeId='00';
	//0 弹出框为列表框，1弹出框为树
	var isTree='1';
	var expandAll='false';
	//选择类型,0代表选择员工；1代表选择部门
	var selectType='<%=request.getParameter("selectType")%>';
	
	//用来设置返回值的形式：默认情况为返回一维数组，如果returnValueType=“string”,表示返回值为字符串形式
	var returnValueType='<%=request.getParameter("returnValueType")%>';
	//判断是适配到bsp3还是bsp5
	var flag='<%=flag%>';
	//20111104添加自动定位到登录人的功能zhangqin
	//定位开关,false:关闭定位到登录人的功能；true：启用定位到登陆人的功能
	var locateLoginUser='<%=request.getParameter("locateLoginUser")%>';
</script>
<script type="text/javascript" src="selectemployeeordeptbyparent.js"></script>
</head>
<body>
<next:Panel anchor="100% 100%"  height="100%" width="100%"  border="false"  autoScroll="false">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem id="saveButoon" iconCls="yes" text="确定"
			handler="confirmValue()"></next:ToolBarItem>
		<next:ToolBarItem id="closeButoon" iconCls="no" text="关闭"
			handler="closew()"></next:ToolBarItem>
		<next:ToolBarItem id="closeButoon" iconCls="no" text="清除"
			handler="clears()"></next:ToolBarItem>
	</next:TopBar>
	<next:Tree name="orgstrutree" id="orgstrutree" rootVisible="true"
		rootExpanded="false" allowCheck="isCheckedSub" border="false"
		lines="true" autoScroll="true" height="100%" width="100%">
		<next:TreeDataSet dataset="orgstru" root="rootdata">
			<next:TreeLoader
				cmd="org.loushang.bsp.organization.cmd.StruQueryCommand"
				method="getSelect">
				<next:treeRecord name="stru" idField="struId"
					fromBean="org.loushang.bsp.share.organization.bean.StruView">
				</next:treeRecord>
				<next:TreeBaseparam name="parentId" value="getParentId" />
				<next:TreeBaseparam name="struId" value="getStruId" />
				<next:TreeBaseparam name="struType" value="getStruType"></next:TreeBaseparam>
				<next:TreeBaseparam name="choiceOrganType"
					value="getChoiceOrganType" />
				<next:TreeBaseparam name="showOrganType" value="getShowOrganType" />
				<next:TreeBaseparam name="isExact" value="getIsExact" />
			</next:TreeLoader>
		</next:TreeDataSet>
		<next:TreeNodemodel recordType="stru">
			<next:TreeNodeAttribute name="text" mapping="organName"></next:TreeNodeAttribute>
			<next:TreeNodeAttribute name="icon" handler="getIcon"></next:TreeNodeAttribute>
			<next:TreeNodeAttribute name="leaf" handler="getIsLeaf"></next:TreeNodeAttribute>
			<next:TreeNodeAttribute name="showType" handler="getChoiceBox"></next:TreeNodeAttribute>
			<next:TreeNodeAttribute name="struPath" mapping="struId"></next:TreeNodeAttribute>
		</next:TreeNodemodel>
	</next:Tree>
</next:Panel>
</body>
</html>
