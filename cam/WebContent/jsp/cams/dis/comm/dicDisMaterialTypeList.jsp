<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>救灾发放物资类型(字典)列表</title>
<next:ScriptManager></next:ScriptManager><script type="text/javascript">
	var organCode='<%=BspUtil.getOrganCode()%>';
	var organName='<%=BspUtil.getOrganName()%>';
	var organType='<%=BspUtil.getOrganType()%>';
</script>
<script type="text/javascript"
	src="<%=SkinUtils.getJS(request, "cams.js")%>"></script>
<script type="text/javascript"
	src="<%=SkinUtils.getJS(request, "camsCheck.js")%>"></script>
<script type="text/javascript" src="../comm/disComm.js"></script>
<script type="text/javascript" src="dicDisMaterialTypeList.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="dicDisMaterialTypeDataSet" cmd="com.inspur.cams.dis.base.cmd.DicDisMaterialTypeQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.dis.base.data.DicDisMaterialType"/>
	</model:dataset>
</model:datasets>
<next:EditGridPanel id="grid" dataset="dicDisMaterialTypeDataSet" width="100%" height="99.9%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="add" text="新增" handler="insert"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="save"></next:ToolBarItem>
		<next:ToolBarItem iconCls="delete" text="删除" handler="del"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column id="name" header='类型名称' field="name" >
			<next:TextField allowBlank="false"/>
		</next:Column>
		
		<next:Column id="unit" header='拨付/采购单位' field="unit" >
			<next:TextField allowBlank="false"/>
		</next:Column>
		
		<next:Column id="doleUnit" header='发放单位' field="doleUnit" >
			<next:TextField allowBlank="false"/>
		</next:Column>

		<next:Column id="relation" header='系数(拨付/采购单位=系数×发放单位)'
			field="relation" align="right" width="220">
			<next:TextField allowBlank="false" />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="dicDisMaterialTypeDataSet"/>
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>