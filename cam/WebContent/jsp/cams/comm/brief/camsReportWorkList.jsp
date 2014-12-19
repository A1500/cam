<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>上报期数管理列表</title>
<next:ScriptManager/>
<script type="text/javascript" src="camsReportWorkList.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
</head>
<body>
<model:datasets>
    <!-- 填报任务状态 -->
	<model:dataset id="workStatusDataSet" enumName="COMM.WORKSTATUS" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.comm.brief.cmd.CamsReportWorkQueryCommand" pageSize="20">
		<model:record fromBean="com.inspur.cams.comm.brief.data.CamsReportWork"/>
	</model:dataset>
</model:datasets>
<next:EditGridPanel id="grid" dataset="reportWorkDataSet" width="100%" stripeRows="true" height="99.9%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"/>
		<next:ToolBarItem iconCls="add" text="增加" handler="insert"/>
		<next:ToolBarItem iconCls="delete" text="删除" handler="del"/>
		<next:ToolBarItem iconCls="unlock" text="开启" handler="unlock"/>
		<next:ToolBarItem iconCls="lock" text="关闭" handler="lock"/>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn/>
		<next:RadioBoxColumn/>
		<next:Column field="workId"   header="业务ID" width="25%"  hidden="true" sortable="false"/>
		<next:Column field="workDesc" header="上报期数描述" width="12%" sortable="false"/>
		<next:Column field="status"   header="填报状态"   align="center" width="10%" sortable="false" dataset="workStatusDataSet"/>
		<next:Column field="createOrganName" header="创建单位名称" width="15%" align="center" editable="false" sortable="false"/>
		<next:Column field="createTime" header="创建时间" width="12%" sortable="false" align="center"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="reportWorkDataSet"/>
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>