<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%
	response.setHeader("Expires", "Sat, 6 May 1995 12:00:00 GMT");  
	response.setHeader("Cache-Control", "no-store,no-cache,must-revalidate");  
	response.addHeader("Cache-Control", "post-check=0, pre-check=0");  
	response.setHeader("Pragma", "no-cache");  
%>
<html>
	<head>
		<next:ScriptManager/>
		<script type="text/javascript" src="selectCurrentContent.js"></script>
		<script>
			var peopleId= '<%=request.getParameter("peopleId")%>' ;
			var serviceType= '<%=request.getParameter("serviceType")%>';
			var organCode =  '<%=BspUtil.getOrganCode()%>' ;
		</script>
	</head>
<body >
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.bpt.manage.cmd.BptElectronicQueryCommand" method="querySelectedContent" global="true" pageSize="30" >
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptElectronic"></model:record>
	</model:dataset> 
	<!-- 业务类型 -->
	<model:dataset id="dsService"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BPT_SERVICE_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>

<next:GridPanel id="gridPanel" name="uploadfile" width="100%" notSelectFirstRow="true" autoExpandColumn="catalogName" stripeRows="true" height="100%" dataset="ds" title="档案目录">
	<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem id="saveButoon" iconCls="yes" text="确定" handler="confirmValue()"></next:ToolBarItem>
				<next:ToolBarItem id="closeButoon" iconCls="no" text="关闭" handler="closew()"></next:ToolBarItem>
				<next:ToolBarItem id="closeButoon" iconCls="no" text="清除" handler="clears()"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="50" header="编号"/>
	    <next:RadioBoxColumn></next:RadioBoxColumn>
	    <next:Column id="catalogCode" header="附件类别代码" field="catalogCode" width="120" hidden="true" >
		</next:Column>
		<next:Column id="serviceType" header="业务类型" field="serviceType" width="220" dataset="dsService">
		</next:Column>
		<next:Column id="catalogName" header="档案目录" field="catalogName" width="300" >
		</next:Column>
		<next:Column id="fileName" header="电子文档" field="fileName" width="260" renderer="lookDetail">
		</next:Column>
		<next:Column id="fileOper" header="责任者" field="fileOper" width="100">
		<next:TextField/>
		</next:Column>
		<next:Column id="fileTime" header="日期" field="fileTime" width="80">
		<next:DateField allowBlank="false" format="Y-m-d"/>
		</next:Column>
		<next:Column id="fileNumber" header="页数" field="fileNumber" width="80">
		<next:TextField  />
		</next:Column>
		<next:Column id="filePath" header="" field="filePath"  hidden="true" >
		</next:Column>
		<next:Column id="electronicId" header="" field="electronicId" hidden="true" >
		</next:Column>
		<next:Column id="fileId" header="" field="fileId"  hidden="true" >
		</next:Column>
	</next:Columns>
</next:GridPanel>

</body>

</html>
