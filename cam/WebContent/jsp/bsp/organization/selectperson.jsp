<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ page import="org.loushang.bsp.util.BspConstants"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<next:ScriptManager ></next:ScriptManager>
<%
	//String struType = (String)request.getParameter("struType");
	//String struId = (String)request.getParameter("struId");
	String flag = BspConstants.bspShareAdapter;
%>
<html>
<head>
<title>选择员工</title>
<script type="text/javascript">
	var rootid='<%=request.getParameter("rootId")%>';
	var choiceOrganType='8';
	var isCheckBox='1';
	var struTypeId='00';
	var isTree='1';
	var expandAll ='false';
	//当前登录用户ID,配置了该参数后，通用帮助将根据登录用户的数据权限进行过滤
    var userId='<%=request.getParameter("userId")%>';
	//struIds保存的是上次操作已经选择的记录的id
	var struIds='<%=request.getParameter("struIds")%>';
	//用来设置返回值的形式：默认情况为字符串，如果returnValueType=“array”,表示返回值为二维数组【】【】形式
	var returnValueType='<%=request.getParameter("returnValueType")%>';
	//用来设置是否要去掉岗位一级,true:显示岗位一级；false：不显示岗位一级
    var showPost='<%=request.getParameter("showPost")%>';
    //定位开关,false:关闭定位到登录人的功能；true：启用定位到登陆人的功能
	var locateLoginUser='<%=request.getParameter("locateLoginUser")%>';
	//判断是适配到bsp3还是bsp5
	var flag='<%=flag%>';
</script>
<script type="text/javascript" src="selectperson.js"></script>
<style type="text/css">
	label{
		width:150px;

	}
</style>
</head>
<body>
<model:datasets>
	<model:dataset id="organDataset" cmd="org.loushang.bsp.organization.cmd.StruQueryCommand" method="getSelectedPerson" global="true">
		<model:record fromBean="org.loushang.bsp.share.organization.bean.StruView"></model:record>
	</model:dataset>
</model:datasets>

<next:Panel border="2" autoScroll="false" width="100%">
<next:TopBar>
	<next:ToolBarItem symbol="->"></next:ToolBarItem>
	<next:ToolBarItem id="saveButoon" iconCls="yes" text="确定" handler="confirmValue()"></next:ToolBarItem>
	<next:ToolBarItem id="closeButoon" iconCls="no" text="关闭" handler="closew()"></next:ToolBarItem>
	<next:ToolBarItem id="closeButoon" iconCls="no" text="清除" handler="clears()"></next:ToolBarItem>
</next:TopBar>
 <next:ColumnLayout>
			<next:Panel width="50%" height="100%" id="treeContent" name="treeContent" title="人力资源树"
				collapsible="true" border="1" autoScroll="true">
				<next:Tree name="orgstrutree" id="orgstrutree" rootVisible="true"
					rootExpanded="false" allowCheck="isCheckedSub" border="false"
					lines="true" bodyBorder="2" autoScroll="true" >
					<!--定义树的数据模型-->
					<next:TreeDataSet dataset="orgstruDs" root="rootdata">
						<next:TreeLoader
							cmd="org.loushang.bsp.organization.cmd.StruQueryCommand"
							method="getSelectEmployeeHelp">
							<next:treeRecord name="stru" idField="struId"
								fromBean="org.loushang.bsp.share.organization.bean.StruView">
							</next:treeRecord>
							<!--向后台请求数据时可以传递参数，可以配置多个TreeBaseParam-->
							<next:TreeBaseparam name="parentId" value="getParentId" />
							<next:TreeBaseparam name="struId" value="getStruId" />
							<next:TreeBaseparam name="struType" value="getStruType" />
							<next:TreeBaseparam name="choiceOrganType" value="getChoiceOrganType" />
							<next:TreeBaseparam name="showPost" value="getShowPost" />
							<next:TreeBaseparam name="userId"    value="getUserId" />
						</next:TreeLoader>
					</next:TreeDataSet>
					<!--TreeNodemodel将后台数据映射到树形节点上，一个后台业务模型对应一个TreeNodeModel -->
					<next:TreeNodemodel recordType="stru">
						<!--设置每一个业务字段与树节点属性之间的映射关系-->
						<next:TreeNodeAttribute name="text" mapping="organName"></next:TreeNodeAttribute>
						<next:TreeNodeAttribute name="icon" handler="getIcon"></next:TreeNodeAttribute>
						<next:TreeNodeAttribute name="leaf" handler="getIsLeaf"></next:TreeNodeAttribute>
						<next:TreeNodeAttribute name="struPath" mapping="struId"></next:TreeNodeAttribute>
					 </next:TreeNodemodel>
				 </next:Tree>
			 </next:Panel>

		<next:Panel width="40" title="" height="100%" autoScroll="false">
<next:Html>
<div style="margin: 80 15  5 5;">
<button class="multiselect_top2" style="width: 22px; height: 22px; cursor: pointer;" onclick="moveTop()" title="置顶"></button>
   <br/>
  <button class="multiselect_up2"	style="width: 22px; height: 22px; cursor: pointer;" onclick="moveUp()" title="上移"></button>
  <br />
  <button class="multiselect_right2" style="width: 22px; height: 22px; cursor: pointer;" onclick="moveRight()" title="添加"></button>
  <br />
  <button class="multiselect_left2" style="width: 22px; height: 22px; cursor: pointer;" onclick="moveLeft()" title="移除"></button>
  <br />
   <button class="multiselect_down2" style="width: 22px; height: 22px; cursor: pointer;" onclick="moveDown()" title="下移"></button>
   <br />
   <button class="multiselect_bottom2"	style="width: 22px; height: 22px; cursor: pointer;" onclick="moveBottom()" title="置底"></button>
</div>
</next:Html>
</next:Panel>
<next:Panel title="" height="100%"  border="0" autoScroll="false" title="员工列表">
<next:Html>
<fieldset style="overflow: visible; width: 100%;" class="GroupBox">
 <next:Panel id="selectedStru" name="selectedStru" width="100%"  collapsible="false" border="0">
	<next:EditGridPanel id="struGrid" name="struGrid" width="100%" height="100%" dataset="organDataset" frame="true" autoScroll="true">
       <next:Columns>
        <next:RowNumberColumn/>
        <next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column hidden="true" header='' field="struId" editable="false"  id="struId" >
		<next:TextField allowBlank="false"/>
		</next:Column>
		<next:Column hidden="true" header='' field="organId" editable="false"  id="organId" >
		<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column hidden="true" header='' field="deptId" editable="false"  id="deptId" >
		<next:TextField allowBlank="false"/>
		</next:Column>
		<next:Column hidden="true" header='' field="cropId" editable="false"  id="cropId" >
		<next:TextField allowBlank="false"/>
		</next:Column>
		<next:Column hidden="true" header='' field="deptName" editable="false"  id="deptName" >
		<next:TextField allowBlank="false"/>
		</next:Column>
		<next:Column hidden="true" header='' field="cropName" editable="false"  id="cropName" >
		<next:TextField allowBlank="false"/>
		</next:Column>
		<next:Column  header='员工姓名' field="organName" editable="false" width="100" id="organName">
		<next:TextField allowBlank="false" />
		</next:Column>
	</next:Columns>
	</next:EditGridPanel>
	</next:Panel>
</fieldset>
</next:Html>
</next:Panel>
</next:ColumnLayout>
</next:Panel>
</body>
</html>
