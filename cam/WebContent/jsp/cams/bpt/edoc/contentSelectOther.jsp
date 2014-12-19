<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%
	response.setHeader("Expires", "Sat, 6 May 1995 12:00:00 GMT");  
	response.setHeader("Cache-Control", "no-store,no-cache,must-revalidate");  
	response.addHeader("Cache-Control", "post-check=0, pre-check=0");  
	response.setHeader("Pragma", "no-cache");  
%>
<% 
String applyId=request.getParameter("applyId")==null?"":(String)request.getParameter("applyId");
//System.out.println("applyId="+applyId);
%>
<html>
	<head>
		<title>档案目录选择</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="contentSelectOther.js"></script>
		<script>
			var peopleId= '<%=request.getParameter("peopleId")%>';
			var serviceType= '<%=request.getParameter("serviceType")%>';			
			var organCode = '<%=request.getParameter("organCode")%>';
			var applyId='<%=applyId %>';
			//alert(applyId);
			var vbptElectronicRecords;
		</script>
	</head>
<body >
<model:datasets>
	<model:dataset id="ElectronicDataset" cmd="com.inspur.cams.bpt.manage.cmd.BptElectronicQueryCommand" global="true" pageSize="30" method="querySelectedContent">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptElectronic"></model:record>
	</model:dataset>
	<!-- 档案目录Dataset -->
	<model:dataset id="CatalogueArchivesDataset" cmd="com.inspur.cams.bpt.bptelectronicfile.cmd.BptUploadfileQueryCommand" method="queryContentByServiceTypeOther" sortField="catalogOrder" global="true" pageSize="50">
		<model:record fromBean="com.inspur.cams.bpt.edoc.data.BptCatalogueArchives"></model:record>
	</model:dataset>
	<!-- 业务类型 -->
	<model:dataset id="ServiceTypeDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BPT_SERVICE_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>

<next:GridPanel id="CatalogueArchivesSelect"  width="100%" notSelectFirstRow="true" stripeRows="true" height="100%" dataset="CatalogueArchivesDataset">
	<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem id="saveButoon" iconCls="yes" text="确定" handler="confirmValue()"></next:ToolBarItem>
				<next:ToolBarItem id="closeButoon" iconCls="no" text="关闭" handler="closew()"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="50" header="编号"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
	    <next:Column id="serviceType" header="业务类型" field="serviceType" width="220" dataset="ServiceTypeDataset" hidden="true"></next:Column>
		<next:Column id="catalogName" header="档案目录" field="catalogName" width="350"></next:Column>
		<next:Column id="catalogCode" header="档案编码" field="catalogCode" width="350" hidden="true"></next:Column>
		<next:Column id="catalogOrder" header="显示顺序" field="catalogOrder" width="350" hidden="true"></next:Column>
		
	</next:Columns>
</next:GridPanel>
</body>

</html>
