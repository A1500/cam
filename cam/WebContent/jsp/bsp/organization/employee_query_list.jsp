
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ include file="/jsp/public/resources_jspdir.jsp"%>
<html>
<head>
<title>员工查询</title>
<next:ScriptManager />
<script language="javascript">
    //用来设置返回值的形式：默认情况为返回一维数组，如果returnValueType=“string”,表示返回值为字符串形式
	var returnValueType='<%=request.getParameter("returnValueType")%>';

	</script>
<script type="text/javascript" src="employee_query_list.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="ds" pageSize="10" pageAble="true" remotePage="false"
		cmd="org.loushang.bsp.organization.cmd.StruQueryCommand" method="queryAllEmployee" global="true" >
		<model:record
			fromBean="org.loushang.bsp.share.organization.bean.StruView"></model:record>
	</model:dataset>
</model:datasets>

<next:EditGridPanel id="editGridPanel"  name="organGrid"  stripeRows="true" border="false" dataset="ds" anchor="100% 100%"
		collapsible="true" height="350" width="100%" hideBorders="false" bodyBorder="true">
	 <next:TopBar>
		<next:ToolBarItem text="员工名称"></next:ToolBarItem>
		<next:ToolBarItem  xtype="textfield" id="organNameText" />
		<next:ToolBarItem text='查询' iconCls="query" handler="queryit" />
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
	   <next:ToolBarItem id="saveButoon" iconCls="yes" text="确定" handler="confirmValue()"></next:ToolBarItem>
	   <next:ToolBarItem id="closeButoon" iconCls="no" text="取消" handler="closew()"></next:ToolBarItem>
	</next:TopBar>
			<next:Columns >
				<next:RowNumberColumn width="40" />
				<next:CheckBoxColumn></next:CheckBoxColumn>
				<next:Column id="organName"
					header='员工名称'
					field="organName" width="120">
					<next:TextField  editable="false"/>
				</next:Column>

				<next:Column id="deptName"
					header='员工所属部门'
					field="deptName" width="155">
					<next:TextField   editable="false"/>
				</next:Column>

				<next:Column id="cropName"
					header='员工所属单位' field="cropName" width="155">
					<next:TextField editable="false"/>
				</next:Column>
			</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="ds" />
	     </next:BottomBar>
		</next:EditGridPanel>

</body>
</html>
