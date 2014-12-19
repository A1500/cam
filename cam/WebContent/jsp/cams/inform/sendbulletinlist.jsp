<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
	<head>
		<title>发件箱</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="sendbulletinlist.js"></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="notifyDataset" cmd=" com.inspur.cams.comm.inform.InformQueryCommand" method="querySendBox" autoLoad="false">
		<model:record>
			<model:field name="id" type="string"/>
			<model:field name="title" type="string"/>
			<model:field name="sendman" type="string"/>
			<model:field name="sendtime" type="date" dateFormat="Y-m-d H:i:s"/>
			<model:field name="informtype" type="string"/>
			<model:field name="flag" type="string"/>
		</model:record>
	</model:dataset>
	<model:dataset id="type" enumName="Inform.Type" autoLoad="true" global="false"></model:dataset>
</model:datasets>
<next:GridPanel id="gridPanel"   notSelectFirstRow="true"   title="发件箱列表" name="informGrid" width="100%" height="400" dataset="notifyDataset" frame="true" >
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column header="标题" field="title" renderer="titleRender" width="360" >
			<next:TextField />
		</next:Column>
		<next:Column header="时间" field="sendtime" width="180" sortable="true">
			<next:DateField />
		</next:Column>

		<next:Column header="起草人" field="sendman" width="160" sortable="true">
			<next:TextField />
		</next:Column>
		<next:Column header="状态" field="flag" width="120" renderer="flagRender" sortable="true">
			<next:TextField />
		</next:Column>
	</next:Columns>
	<next:TopBar>
	<next:ToolBarItem symbol="->" ></next:ToolBarItem>

		<next:ToolBarItem iconCls="add"  text="新建" handler="click_add"/>
		<next:ToolBarItem xtype="tbseparator"/>
		<next:ToolBarItem iconCls="common-query"  text="查看回执" handler="click_response" />
		<next:ToolBarItem xtype="tbseparator"/>
		<next:ToolBarItem iconCls="undo"  text="撤销" handler="click_undo"/>
		<next:ToolBarItem xtype="tbseparator"/>
		<next:ToolBarItem iconCls="remove"  text="删除" handler="click_delete"/>
		<next:ToolBarItem xtype="tbseparator"/>
		<next:ToolBarItem iconCls="common-query"  text="查看" handler="click_view"/>
		<next:ToolBarItem xtype="tbseparator"/>
		<next:ToolBarItem iconCls="common-query"  text="查询" handler="click_query"/>
	</next:TopBar>
	<next:BottomBar>
		<next:PagingToolBar dataset="notifyDataset"/>
	</next:BottomBar>
</next:GridPanel>

<!-- 弹出添加窗口 -->
<next:Window id="organize" name="organizeWin" title="公告发件箱查询"
	resizable="false" width="300" lazyRender="false" height="150"
	closeAction="hide" autoScroll="false">
	<next:Buttons>
		<next:ToolButton text="查询" handler="query"></next:ToolButton>
		<next:ToolButton text="关闭" handler="undoit"></next:ToolButton>
	</next:Buttons>

	<next:Html>
		<form id="informcfg" method="post" onsubmit="return false">
		<table id="table0"  border="0">
			<tr>
				<td align="center" ><label>标题：</label></td>
				<td >
				    <input type="text" id="titlequery" name="titlequery"
					   title="标题" size="30"/>
				</td>
		    </tr>

		    <tr>
				<td align="center" ><label>起草人：</label></td>
				<td >
				    <input type="text" id="sendmanquery"
					   title="起草人" size="30"/>
				</td>
		    </tr>


		</table>
		</form>
	</next:Html>
</next:Window>
</body>
</html>

