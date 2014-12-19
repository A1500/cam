<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>


<html>
<head>
<title>公墓名称</title>

<next:ScriptManager/>
<script type="text/javascript" src="fisCemeInfomation.js"></script>
<script language="javascript">
     var manaCode = '<%=request.getParameter("manaCode")%>';
     var prop = '<%=request.getParameter("prop")%>';
     var isYs = '<%=request.getParameter("isYs")%>';

</script>

</head>
<body>
  <model:datasets>
	<model:dataset id="CemeInfoDs" cmd="com.inspur.cams.fis.base.cmd.FisCemeInfoQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisCemeInfo"/>
	</model:dataset>
  </model:datasets>
	
<next:Panel width="100%" border="0">


<next:EditGridPanel id="grid" dataset="CemeInfoDs" width="100%" stripeRows="true" height="99.9%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"/>
		<next:ToolBarItem iconCls="select"  text="选择" handler="select"/>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn/>
		<next:RadioBoxColumn/>
		<next:Column field="recordId" header="公墓记录编号" hidden="true" width="10%" sortable="false"/>
		<next:Column field="organId" header="公墓编号" hidden="true" width="10%" sortable="false"/>
		<next:Column field="name" header="公墓名称" width="55%" sortable="false" align="right"/>
	</next:Columns>
	
	<next:BottomBar>
		<next:PagingToolBar dataset="CemeInfoDs"/>
	</next:BottomBar>
</next:EditGridPanel>
</next:Panel>
</body>
</html>