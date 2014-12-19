<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
	<head>
	    <title>馆墓一体</title>
		<next:ScriptManager/>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
		<script type="text/javascript" src="fisOrganTypeConfigList.js"></script>
		<script language="javascript">
			var queryId = '<%=request.getParameter("id")%>';
		</script>
	</head>
<body>
<model:datasets>
	<model:dataset id="fisOrganTypeConfig" cmd="com.inspur.cams.fis.base.cmd.FisOrganTypeConfigQueryCmd"  global="true" autoLoad="true" pageSize="10">
	    <model:record fromBean="com.inspur.cams.fis.base.data.FisOrganTypeConfig"></model:record>
	</model:dataset>
</model:datasets>
<next:GridPanel id="gridPanel"   notSelectFirstRow="true"  title="馆墓一体配置" name="informGrid"  width="100%" height="100%" dataset="fisOrganTypeConfig"  >
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column header="配置ID" field="configId" width="100" hidden="false" hidden="true"></next:Column>
		<next:Column header="殡仪馆编码" field="funeralOrgan"   width="120" >
			<next:TextField />
		</next:Column>
		<next:Column header="殡仪馆名称" field="funeralOrganName"   width="200"  sortable="true">
			<next:TextField />
		</next:Column>
		<next:Column header="公墓编码" field="cemeteryOrgan"  width="120" sortable="true">
			<next:TextField />
		</next:Column>
		<next:Column header="公墓名称" field="cemeteryOrganName"  width="200" sortable="true">
			<next:TextField></next:TextField>
		</next:Column>
		<next:Column header="配置时间" field="configTime"   width="150" sortable="true">
			<next:TextField />
		</next:Column>

	</next:Columns>
	<next:TopBar>
	<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="add"  text="新建" handler="add"/>
		<next:ToolBarItem iconCls="edit"  text="修改" handler="update"/>
		<next:ToolBarItem iconCls="remove"  text="删除" handler="click_delete"/>
		<next:ToolBarItem iconCls="detail"  text="查看" handler="click_view"/>
		<next:ToolBarItem iconCls="common-query"  text="查询"  hidden="true"/>
	</next:TopBar>
	<next:BottomBar>
		<next:PagingToolBar dataset="fisOrganTypeConfig"/>
	</next:BottomBar>
</next:GridPanel>

</body>
</html>

