<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
	<head>
		<title>发件箱</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="sendnotifylist.js"></script>
		<script language="javascript">
			var queryId = '<%=request.getParameter("id")%>';
		</script>
	</head>
<body>
<model:datasets>
	<model:dataset id="notifyDataset" cmd="com.inspur.cams.comm.inform.InformQueryCommand" method="querySendBox" global="false">
		<model:record>
			<model:field name="ID" type="string"/>
			<model:field name="TITLE" type="string"/>
			<model:field name="SENDMANID" type="string"/>
			<model:field name="SENDTIME" type="date" dateFormat="Y-m-d H:i:s"/>
			<model:field name="INFORMTYPE" type="string"/>
			<model:field name="FLAG" type="string"/>
			<model:field name="RECEIVEMAN" type="string"/>
	</model:record>
	</model:dataset>
	<model:dataset id="organ" cmd="com.inspur.cams.comm.informUtil.InformPubOrganQueryCommand" global="true" autoLoad="true" pageSize="-1">
		<model:record fromBean="com.inspur.cams.comm.informUtil.InformPubOrganDao">
		    <model:field name="value" mapping="organCode"/>
			<model:field name="text" mapping="shortName"/>
		</model:record>
	</model:dataset>
	<model:dataset id="type" enumName="Inform.Type" autoLoad="true" global="false"></model:dataset>
</model:datasets>
<next:GridPanel id="gridPanel"   notSelectFirstRow="true"  title="发件箱列表" name="informGrid"  width="100%" height="400" dataset="notifyDataset" frame="true" >
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column header="标题" field="TITLE"  renderer="titleRender" width="260" >
			<next:TextField />
		</next:Column>
		<next:Column header="时间" field="SENDTIME"  align="center" width="140" sortable="true">
			<next:DateField />
		</next:Column>
		<next:Column header="通知类型" field="INFORMTYPE"   width="100"  sortable="true">
			<next:ComboBox dataset="type" />
		</next:Column>
		<next:Column header="接收单位" field="RECEIVEMAN"  width="120" sortable="true">
			<next:ComboBox dataset="organ" />
		</next:Column>
		<next:Column header="发送单位" field="SENDMAN"  width="120" sortable="true">
			<next:ComboBox dataset="organ" />
		</next:Column>
		<next:Column header="发送人" field="SENDMANID"   width="100" sortable="true">
			<next:TextField />
		</next:Column>
		<next:Column header="状态" field="FLAG" width="80" renderer="flagRender"   sortable="true">
			<next:TextField />
		</next:Column>
	</next:Columns>
	<next:TopBar>
	<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="add"  text="新建" handler="click_add"/>
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
<next:Window id="organize" name="organizeWin" title="发件箱查询"
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
				<td align="center" ><label>发送人：</label></td>
				<td >
				    <input type="text" id="sendmanIdquery"
					   title="发送人" size="30"/>
				</td>
		    </tr>
		</table>
		</form>
	</next:Html>
</next:Window>
</body>
</html>

