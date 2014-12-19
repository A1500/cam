<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
	<head>
		<title>发件箱</title>
		<next:ScriptManager/>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
		<script type="text/javascript" src="fisMattersAttentionList.js"></script>
		<script language="javascript">
			var queryId = '<%=request.getParameter("id")%>';
		</script>
	</head>
<body>
<model:datasets>
	<model:dataset id="type" enumName="Inform.Type" autoLoad="true" global="false"></model:dataset>
	<model:dataset id="attentionType" enumName="FIS.MATTERS.ATTENTION.TYPE" autoLoad="true" global="false"></model:dataset>
	<model:dataset id="fisMattersAttention" cmd="com.inspur.cams.fis.base.cmd.FisMattersAttentionQueryCmd" global="true" autoLoad="true" pageSize="10">
	    <model:record fromBean="com.inspur.cams.fis.base.data.FisMattersAttention"></model:record>
	</model:dataset>
</model:datasets>
<next:GridPanel id="gridPanel"   notSelectFirstRow="true"  title="发件箱列表" name="informGrid"  width="100%" height="100%" dataset="fisMattersAttention"  >
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column header="通知ID" field="attentionId" width="100" hidden="true"></next:Column>
		<next:Column header="标题" field="attentionTitle"  renderer="titleRender" width="260" >
			<next:TextField />
		</next:Column>
		<next:Column header="通知类型" field="attentionType"   width="100"  sortable="true">
			<next:ComboBox dataset="attentionType" />
		</next:Column>
		<next:Column header="紧急程度" field="emergencyDegree"  width="120" sortable="true">
			<next:ComboBox dataset="type" />
		</next:Column>
		<next:Column header="面向馆 / 墓 / 馆墓一体" field="toOrganFis"  width="200" sortable="true">
			<next:TextField></next:TextField>
		</next:Column>
		<next:Column header="发送时间" field="attentionTime"   width="150" sortable="true">
			<next:TextField />
		</next:Column>

	</next:Columns>
	<next:TopBar>
	<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="add"  text="新建" handler="click_add"/>
		<next:ToolBarItem xtype="tbseparator"/>
		<next:ToolBarItem iconCls="edit"  text="修改" handler="updateAttention"/>
		<next:ToolBarItem xtype="tbseparator"/>
		<next:ToolBarItem iconCls="remove"  text="删除" handler="click_delete"/>
		<next:ToolBarItem xtype="tbseparator"/>
		<next:ToolBarItem iconCls="detail"  text="查看" handler="click_view"/>
		<next:ToolBarItem xtype="tbseparator"/>
		<next:ToolBarItem iconCls="common-query"  text="查询" handler="click_query" hidden="true"/>
	</next:TopBar>
	<next:BottomBar>
		<next:PagingToolBar dataset="fisMattersAttention"/>
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

