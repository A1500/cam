<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.portal.util.PortalJspUtil" %>
<html>
<head>
<next:ScriptManager debug="true"></next:ScriptManager>
<title>选择组织机构</title>
<%
	String webPath=PortalJspUtil.webPath(request);
	//是否管理员操作，用于判断是否进行微件过滤
	String isFilterWidget = request.getParameter("isFilterWidget");
%>
</head>
<body>
<next:Panel   anchor="100% 100%" border="false">
<next:TopBar>
</next:TopBar>
<next:Tree id="widgettree"  rootVisible="true" border="false" lines="true" >
	<next:TreeDataSet dataset="widgetdataset" root="rootdata">
		<next:TreeLoader cmd="org.loushang.portal.widget.cmd.PortalWidgetQueryCmd" method="queryPortalWidgetListByCategoryId" trigger="widgetTrigger">
			<next:treeRecord name="widgetRecord"  idField="id" fromBean="org.loushang.portal.widget.data.PortalWidget">
			</next:treeRecord>
			<next:TreeBaseparam name="cateId"    value="getCateId" />
			<next:TreeBaseparam name="isFilterWidget"    value='<%=isFilterWidget %>' />
		</next:TreeLoader>
		<next:TreeLoader cmd="org.loushang.portal.category.cmd.PortalCategoryQueryCmd" method="queryPortalCategoryList" trigger="widgetCategoryTrigger">
			<next:treeRecord name="widgetCategoryRecord"  idField="cateId" fromBean="org.loushang.portal.category.data.PortalCategory">				
			</next:treeRecord>
			<next:TreeBaseparam name="isFilterWidget"    value='<%=isFilterWidget %>' />
		</next:TreeLoader>
	</next:TreeDataSet>
	<next:TreeNodemodel recordType="widgetRecord">
		<next:TreeNodeAttribute name="text" mapping="name"></next:TreeNodeAttribute>
		<next:TreeNodeAttribute name="leaf" handler="true"></next:TreeNodeAttribute>
		<next:TreeNodeAttribute name="icon" handler="getIcon" ></next:TreeNodeAttribute>
		<next:Listeners>
			<next:Listener eventName="selected" handler="selectedWidgetNode"></next:Listener>
		</next:Listeners>
	</next:TreeNodemodel>
	<next:TreeNodemodel recordType="widgetCategoryRecord">
		<next:TreeNodeAttribute name="text" mapping="name"></next:TreeNodeAttribute>
		<next:TreeNodeAttribute name="leaf" handler="false"></next:TreeNodeAttribute>
	</next:TreeNodemodel>
</next:Tree>

</next:Panel>
</body>
<script type="text/javascript">
function init(){
	var tree = L5.getCmp('widgettree');
	tree.root.expand();
}
//定义根节点结构
var rootdata = {
		cateId : 'rootId',//唯一标志record,如果是前台配置生成record,需要指定id
		isLeaf : '0',
		name : '微件列表',
		recordType : 'widgetCategoryRecord'
};
//微件类别节点触发方法
function widgetCategoryTrigger(record){
	var cateId = record.get("cateId");
	if(cateId=="rootId"){
		return true;
	}
	return false;
}
//微件节点触发方法
function widgetTrigger(record){
	var cateId = record.get("cateId");
	if(cateId != "rootId"){
		return true;
	}
	return false;
}
//微件选择时触发的方法
function selectedWidgetNode(record){
	if(record.recordType != "widgetRecord"){
		return ;
	}
	parent.LoushangPortalUtil.addWidgetToCurPage(record);
}
function getCateId(record){
	return record.get('cateId');
}
function isLeaf(record){
	return '1';
}
function getIcon(record){
	var widgetLogoUri = record.get('logoUri');
	if(!widgetLogoUri){
		return false;
	}

	return parent.LoushangPortalUtil.getFullPathUrl(widgetLogoUri);
}
</script>
</html>