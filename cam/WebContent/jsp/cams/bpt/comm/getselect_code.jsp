<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<next:ScriptManager ></next:ScriptManager>
<html>
<head>
<title>选择组织</title>
<script type="text/javascript">
    //当前登录用户ID,配置了该参数后，通用帮助将根据登录用户的数据权限进行过滤
    var userId='<%=request.getParameter("userId")%>';
	//要选择的组织结构的根，取struId的值，如果不指定的话，根据数据权限取值，方式待定
	var rootid='<%=request.getParameter("rootId")%>';
	//组织类型，如果需要选择多种组织类型，则请以“,” 号分割。 默认值为0 ，表示全部类型都是可以选择
	var choiceOrganType='<%=request.getParameter("organType")%>';
	//用来控制显示的组织类型，如果需要显示多种组织类型，则请以“,” 号分割。 默认值为0 ，表示全部类型都可以显示
	var showOrganType='<%=request.getParameter("showOrganType")%>';
	//isExact，它表示是否进行组织类型显示的精确匹配，例如：原先要显示所有法人级别的组织类型，如果输入1，那么它的扩展（11，12，13等等）都默认全部显示。
	//而加上isExact=1   则表示只显示1 ，不显示 1 这种组织类型的扩展，如果要显示的话，则在showOrganType  ，organType　参数后面明确的加上即可。
	var isExact='<%=request.getParameter("isExact")%>';
	//0单选 ，1 多选
	var isCheckBox='<%=request.getParameter("isCheckBox")%>';
	//组织结构类型，默认00 为人力资源树
	var struTypeId='<%=request.getParameter("struType")%>';
	//0 弹出框为列表框，1弹出框为树
	var isTree='<%=request.getParameter("isTree")%>';
	var expandAll = '<%=request.getParameter("expandAll")%>';
	//定位开关,false:关闭定位到登录人的功能；true：启用定位到登陆人的功能
	var locateLoginUser='<%=request.getParameter("locateLoginUser")%>';
	//用户对应的organId，当启用此参数时，树将自动定位到该organId对应的节点上
	//注意该参数不要和locateLoginUser一起使用。
	var locateOrganId='<%=request.getParameter("locateOrganId")%>';

	//用来设置返回值的形式：默认情况为字符串，如果returnValueType=“array”,表示返回值为数组形式
	var returnValueType='<%=request.getParameter("returnValueType")%>';
</script>
<script type="text/javascript" src="getselect_code.js"></script>
</head>
<body>

<next:Panel   anchor="100% 100%" border="false" height="100%" width="100%" autoScroll="false">
<next:TopBar>
	<next:ToolBarItem symbol="->"></next:ToolBarItem>
	<next:ToolBarItem id="saveButoon" iconCls="yes" text="确定" handler="confirmValue()"></next:ToolBarItem>
	<next:ToolBarItem id="closeButoon" iconCls="no" text="关闭" handler="closew()"></next:ToolBarItem>
	<next:ToolBarItem id="closeButoon" iconCls="no" text="清除" handler="clears()"></next:ToolBarItem>
</next:TopBar>
<next:Tree name="orgstrutree" id="orgstrutree"  title="选择组织"  rootVisible="true" rootExpanded="false"
   allowCheck="isCheckedSub"    border="false" lines="true"  autoScroll="true" height="100%" width="100%">
	<next:TreeDataSet dataset="orgstru" root="rootdata">
		<next:TreeLoader cmd="org.loushang.bsp.organization.cmd.StruQueryCommand"  method="getSelect" >
			<next:treeRecord name="stru"  idField="struId" fromBean="org.loushang.bsp.share.organization.bean.StruView">
			</next:treeRecord>
			<next:TreeBaseparam name="parentId"    value="getParentId" />
			<next:TreeBaseparam name="struId"    value="getStruId" />
			<next:TreeBaseparam name="struType" value="getStruType"></next:TreeBaseparam>
			<next:TreeBaseparam name="choiceOrganType"    value="getChoiceOrganType" />
			<next:TreeBaseparam name="showOrganType"    value="getShowOrganType" />
			<next:TreeBaseparam name="isExact"    value="getIsExact" />
			<next:TreeBaseparam name="userId"    value="getUserId" />
		</next:TreeLoader>
	</next:TreeDataSet>
	<next:TreeNodemodel recordType="stru">
		<next:TreeNodeAttribute name="text" mapping="organName"></next:TreeNodeAttribute>
		<next:TreeNodeAttribute name="icon" handler="getIcon" ></next:TreeNodeAttribute>
	   <next:TreeNodeAttribute name="showType" handler="getChoiceBox"></next:TreeNodeAttribute>
	   <next:TreeNodeAttribute name="struPath" mapping="struId"></next:TreeNodeAttribute>
	   <next:TreeNodeAttribute name="leaf" handler="getIsLeaf"></next:TreeNodeAttribute>
	   <next:TreeNodeAttribute name="changeParent" value="false"></next:TreeNodeAttribute>
	</next:TreeNodemodel>
</next:Tree>
 </next:Panel>
</body>
</html>