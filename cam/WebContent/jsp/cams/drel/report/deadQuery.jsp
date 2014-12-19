<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
	<head>
		<title>待办理去世低保五保对象</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="../comm/samInfoDetailComm.js"></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
		<script type="text/javascript" src="deadQuery.js"></script>
	</head>
<script type="text/javascript">
	var organCode='<%=request.getParameter("organCode")%>';
	var objectType='<%=request.getParameter("objectType")%>';
	var queryType='<%=request.getParameter("queryType")%>';
	var time='<%=request.getParameter("time")%>';
</script>
<body>
<model:datasets>
	<!-- 全部人员信息 -->
	<model:dataset id="deadDrelObject" cmd="com.inspur.cams.drel.report.cmd.SamBaseCaseReportQueryCmd" 
	method="queryDeadDrelObject" global="true" pageSize="25">
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople"></model:record>
	</model:dataset>
	<!-- 性别 -->
	<model:dataset id="SexDataset" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
	<!-- 民族 -->
	<model:dataset id="NationDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset> 
</model:datasets>
<next:ViewPort>
<next:GridPanel id="baseGridPanel" name="basicInfoGridPanel" width="100%" height="100%" 
	autoScroll="false" stripeRows="true" dataset="deadDrelObject" title="待办理去世低保五保对象" notSelectFirstRow="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="低保信息" iconCls="detail" handler="drelDetail" />
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem text="殡葬信息" iconCls="detail" handler="deathDetail" hidden="true" />
		<next:ToolBarItem text="导出Excel" iconCls="export" handler="forExcel" />
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn header="序号" width="45"/>
	    <next:RadioBoxColumn></next:RadioBoxColumn>
        
        <next:Column id="PEOPLE_ID" header="序号" field="PEOPLE_ID" width="60" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="FAMILY_ID" header="序号" field="FAMILY_ID" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="DEAD_ID" header="序号" field="DEAD_ID" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>
        
		<next:Column id="DOMICILE_FULL_NAME" header="所属行政区划" field="DOMICILE_FULL_NAME" width="240">
			<next:TextField allowBlank="false" />
		</next:Column>
		
		<next:Column id="NAME" header="姓名" field="NAME" width="60">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="ID_CARD" header="身份证件号码" field="ID_CARD" width="135" >
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="SEX" header="性别" field="SEX" width="50"  dataset="SexDataset" >
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="NATION" header="民族" field="NATION" width="70" dataset="NationDataset">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="deathDate" header="去世日期" field="DEATH_DATE" width="130">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="cremationTime" header="火化时间" field="CREMATION_TIME" width="130">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="funeralName" header="殡仪馆" field="FUNERAL_NAME" width="130">
			<next:TextField allowBlank="false" />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="deadDrelObject"/>
	</next:BottomBar>
</next:GridPanel>
</next:ViewPort>
</body>
</html>
