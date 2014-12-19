<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<script type="text/javascript">
   var organCode = '<%=BspUtil.getOrganCode()%>';
   var peopleId= '<%=request.getParameter("peopleId")%>';
   var serviceType= '<%=request.getParameter("serviceType")%>';
</script>
<html>
	<head>
		<title>归档文件目录</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="contentPeopleDetail_list.js"></script>
		<script type="text/javascript" src="<%=SkinUtils.getJS(request, "ISPrint.js") %>"></script>
		<script type="text/javascript" src="../comm/bptComm.js"></script>
		<script type="text/javascript" src="<%=SkinUtils.getJS(request, "cams.js") %>"></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds"
		cmd="com.inspur.cams.bpt.manage.cmd.BptElectronicQueryCommand"
		method="querySelectedContent" global="true" pageSize="30">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptElectronic"></model:record>
	</model:dataset>
	<!-- 性别 -->
	<model:dataset id="SexDataset" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
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



<next:GridPanel id="gridPanel" name="ds" width="100%" stripeRows="true" height="100%" dataset="ds" title="">
	<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
	        <next:ToolBarItem symbol="-"></next:ToolBarItem>
			<next:ToolBarItem iconCls="print" text="打印" handler="printBill()"  />
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
		<next:Column id="serviceTypeElectronic" header="业务类型" field="serviceType"
			width="220" dataset="dsService">
		</next:Column>
		<next:Column id="catalogName" header="档案目录" field="catalogName"
			width="260">
		</next:Column>
		<next:Column id="fileOper" header="责任者" field="fileOper" width="100">
			<next:TextField />
		</next:Column>
		<next:Column id="fileTime" header="日期" field="fileTime" width="80">
			<next:DateField allowBlank="false" format="Y-m-d" />
		</next:Column>
		<next:Column id="fileNumber" header="页数" field="fileNumber"
			width="80">
			<next:TextField />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
