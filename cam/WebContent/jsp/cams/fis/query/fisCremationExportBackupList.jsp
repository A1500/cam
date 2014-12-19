<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>火化记录查询导出记录</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="fisCremationExportBackupList.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
</head>
<script type="text/javascript">
    var orgCode = '<%= request.getParameter("orgCode")%>';
</script>
<body>
<model:datasets>
	<model:dataset id="fisCremationExportBackupDataSet" cmd="com.inspur.cams.fis.base.cmd.FisCremationExportBackupQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisCremationExportBackup"/>
	</model:dataset>
</model:datasets>
<%-- <next:Panel width="100%" border="0"> --%>
<%-- 	<next:Html> --%>
<!-- 	<fieldset style="overflow:visible;" class="GroupBox"> -->
<!-- 	<legend class="GroupBoxTitle">查询条件</legend> -->
<!-- 		<form class="L5form"> -->
<!-- 			<table border="1" width="100%"> -->
			    
<!-- 				<tr> -->
<!-- 					<td class="FieldButton" style="width:20%"><button onclick="query()">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;<button type="reset">重置</button></td> -->
<!-- 				</tr> -->
<!-- 			</table> -->
<!-- 		</form> -->
<!-- 	</fieldset> -->
<%-- 	</next:Html> --%>
<%-- </next:Panel> --%>
<next:EditGridPanel id="grid" dataset="fisCremationExportBackupDataSet" width="100%" stripeRows="true" height="99.9%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="exportName" header="导出人" width="100" sortable="false"/>
		<next:Column field="exportNum" header="导出数据量" width="100" sortable="false" align="right"/>
		<next:Column field="exportDate" header="导出时间" width="130" sortable="false"/>
		<next:Column field="exportOrganName" header="导出单位" width="150" sortable="false"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="fisCremationExportBackupDataSet"/>
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>