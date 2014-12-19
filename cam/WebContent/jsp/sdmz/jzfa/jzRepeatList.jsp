<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.sdmz.comm.util.BspUtil"%>

<html>
<head>
<title>明细查询列表</title>

<script type="text/javascript">
var szdxId = '<%=request.getParameter("dataBean")%>';
var jzfaids = '<%=request.getParameter("jzfaids")%>';
</script>
<next:ScriptManager ></next:ScriptManager>
<script type="text/javascript" src="jzRepeatList.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="jzfamxDataset" cmd="com.inspur.sdmz.jzfa.cmd.DetailQueryCmd" global="true">
		<model:record fromBean="com.inspur.sdmz.jzfa.data.Detail"></model:record>
		<model:params>
			<model:param name="PLAN_ID" value='<%=request.getParameter("jzfa")%>'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="szdxlxDataset" enumName="SZDXLX.TYPE"  autoLoad="true" global="true"></model:dataset>
	<model:dataset id="DmJzfxDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_ASSITANCE_SIDE'></model:param>
		</model:params>
	</model:dataset>
	
</model:datasets>



<next:GridPanel id="editGridPanel" name="editGridPanel" width="100%" stripeRows="true" height="330" dataset="jzfamxDataset" notSelectFirstRow="true" title="明细查询">
<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="undo" text="返回" handler="undo"/>
</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="30" />
		<next:Column id="assistedName" header="受助人/单位名称" field="assistedName" width="120" sortable="true">
			<next:TextField />
		</next:Column>

		<next:Column id="assistedType" header="类型" field="assistedType" width="120" sortable="true" dataset="szdxlxDataset">
			<next:TextField />
		</next:Column>

		<next:Column id="assitanceDate" header="受助日期" field="assitanceDate" width="120" sortable="true">
			<next:TextField />
		</next:Column>

		<next:Column id="captial" header="救助资金现金金额" field="captial" width="120"  sortable="true">
			<next:TextField />
		</next:Column>

		<next:Column id="goodsName" header="救助物品名称" field="goodsName" width="120" sortable="true">
			<next:TextField />
		</next:Column>
		<next:Column id="goodsNum" header="救助物品数量" field="goodsNum" width="120" sortable="true">
			<next:TextField />
		</next:Column>
		
		<next:Column id="goodsNums" header="救助物品折价金额" field="goodsNums" width="120"  sortable="true">
			<next:TextField />
		</next:Column>
		
		<next:Column id="totalFund" header="合计金额" field="totalFund" width="120"  sortable="true">
			<next:TextField />
		</next:Column>
		
		<next:Column id="assistedSide" header="救助方向" field="assistedSide" width="120"  sortable="true" dataset="DmJzfxDataset">
			<next:TextField />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="jzfamxDataset" />
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
