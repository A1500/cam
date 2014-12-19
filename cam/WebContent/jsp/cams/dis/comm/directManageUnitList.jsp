
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
	<head>
		<title>直管单位配置表列表</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="directManageUnitList.js"></script>
		<script language="javascript">
		</script>
	</head>
<body>
<script type="text/javascript">
	var organCode = '<%=BspUtil.getOrganCode()%>';
	var organName = '<%=BspUtil.getOrganName()%>';
</script>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.dis.base.cmd.DisDirectManageUnitQueryCmd" global="true" pageSize="20">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisDirectManageUnit"></model:record>
	</model:dataset>
</model:datasets>


<next:GridPanel id="editGridPanel" name="disdirectmanageunitGrid" width="100%" stripeRows="true" height="100%" dataset="ds" >
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="增加" iconCls="add" handler="insert" />
		<next:ToolBarItem text="删除" iconCls="remove" handler="del"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:RadioBoxColumn></next:RadioBoxColumn>
	     
		<next:Column id="recordId" header="内码" field="recordId" width="90" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="id" header="单位编码" field="id" width="90" hidden="true">
			<next:TextField  />
		</next:Column>
	
		<next:Column id="name" header="名称" field="name" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="leve" header="等级" field="leve" width="90" hidden="true">
			<next:TextField  />
		</next:Column>
	
		<next:Column id="ups" header="上级" field="ups" width="90" hidden="true">
			<next:TextField  />
		</next:Column>
	
		<next:Column id="flag" header="标志" field="flag" width="90" hidden="true">
			<next:TextField  />
		</next:Column>
	
		<next:Column id="fullName" header="全称" field="fullName" width="190" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="isSelf" header="是否本级" field="isSelf" width="90" hidden="true" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="inUse" header="是否在用" field="inUse" width="90" hidden="true">
			<next:TextField  />
		</next:Column>
	
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
