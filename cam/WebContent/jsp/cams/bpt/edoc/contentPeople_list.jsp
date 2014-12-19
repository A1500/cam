<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<script type="text/javascript">
   var organCode = '<%=BspUtil.getOrganCode()%>';
   var contentNumId= '<%=request.getParameter("contentNumId")%>';
</script>
<html>
	<head>
		<title>优抚人员档案目录</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="contentPeople_list.js"></script>
		<script type="text/javascript" src="<%=SkinUtils.getJS(request, "ISPrint.js") %>"></script>
		<script type="text/javascript" src="../comm/bptComm.js"></script>
		<script type="text/javascript" src="<%=SkinUtils.getJS(request, "cams.js") %>"></script>
	</head>
<body>
<model:datasets>
	<!-- 目录号 -->
	<model:dataset id="ContentPeopleDataset" cmd="com.inspur.cams.bpt.manage.cmd.BptElectronicQueryCommand" global="true" pageSize="500" method="queryContentPeople">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptElectronic">
			<model:field name="PEOPLE_ID" type="string" />
			<model:field name="NAME" type="string" />
			<model:field name="ID_CARD" type="string" />
			<model:field name="SEX" type="string" />
			<model:field name="BPT_NO" type="string" />
			<model:field name="CONTENT_YEAR" type="string" />
			<model:field name="ROOM_NO" type="string" />
		</model:record>
	</model:dataset>
	<!-- 性别 -->
	<model:dataset id="SexDataset" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:GridPanel id="gridPanel" name="bptcontentnummaintainGrid" width="100%" stripeRows="true" height="100%" dataset="ContentPeopleDataset" >
	<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
	        <next:ToolBarItem symbol="-"></next:ToolBarItem>
			<next:ToolBarItem iconCls="print" text="打印" handler="printBill()"  />
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
		<next:Column id="NAME" header="姓名" field="NAME" width="95" >			
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="ID_CARD" header="身份证号" field="ID_CARD" width="135">			
			<next:TextField  />
		</next:Column>
		<next:Column id="SEX" header="性别" field="SEX" dataset="SexDataset" width="95" >			
			<next:TextField  />
		</next:Column>
		<next:Column id="BPT_NO" header="抚恤证号" field="BPT_NO" width="95" >			
			<next:TextField  />
		</next:Column>
		<next:Column id="BPT_NO" header="年度" field="CONTENT_YEAR" width="95" >			
			<next:TextField  />
		</next:Column>
			<next:Column id="ARCHIVE_NO" header="室编卷号" field="ARCHIVE_NO" width="95" >			
			<next:TextField  />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ContentPeopleDataset"/>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
