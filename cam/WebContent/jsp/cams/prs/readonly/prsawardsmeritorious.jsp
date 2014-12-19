<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.inspur.cams.comm.util.IdHelp"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
	<head>
		<title>立功受奖情况</title>
		<next:ScriptManager/>
			<script>
			var idField='<%=request.getParameter("dataBean")%>';
		</script>	
		<script type="text/javascript" src="prsawardsmeritorious.js"></script>
	</head>
<body>
<model:datasets>
		<model:dataset id="prsawardsmeritoriousDataset"
		cmd="com.inspur.cams.prs.prsawardsmeritorious.cmd.PrsAwardsMeritoriousQueryCommand"
		global="true">
		<model:record  fromBean="com.inspur.cams.prs.prsawardsmeritorious.dao.PrsAwardsMeritorious" >
			<model:field name="awardsId" mapping="AWARDS_ID" type="string" />
			<model:field name="soldiersId" mapping="SOLDIERS_ID" type="string" />
			<model:field name="awardsType" mapping="AWARDS_TYPE" type="string" />
			<model:field name="awardsName" mapping="AWARDS_NAME" type="string" />
			<model:field name="awardsNumber" mapping="AWARDS_NUMBER" type="string" />
			<model:field name="awardsTime" mapping="AWARDS_TIME" type="string" />
			<model:field name="awardsNote" mapping="AWARDS_NOTE" type="string" />
		</model:record>
	</model:dataset>
    <!-- 立功受奖种类 -->
	<model:dataset id="AwardsTypeDataset" enumName="AWARDS.CODE" 
             autoLoad="true" global="true"></model:dataset>	
    <!-- 立功受奖名称 -->
	<model:dataset id="AwardsNameDataset" enumName="AWARDS.CASE" 
             autoLoad="true" global="true"></model:dataset>	
</model:datasets>
<next:GridPanel id="editGridPanel" name="prsawardsmeritoriousGrid" width="100%" stripeRows="true" height="100%" dataset="prsawardsmeritoriousDataset" >
	<next:Columns>
		<next:RowNumberColumn width="30" />
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="awardsType" header="立功受奖种类" field="awardsType"
							width="95">
			<next:ComboBox dataset="AwardsTypeDataset"
								id="awardsTypeComboBox" />
		</next:Column>

		<next:Column id="awardsName" header="立功受奖名称" field="awardsName" width="200">
			<next:ComboBox dataset="AwardsNameDataset"id="awardsNameComboBox" />
		</next:Column>
		<next:Column id="awardsNumber" header="立功受奖次数" field="awardsNumber" width="95">
			<next:TextField />
		</next:Column>
		<next:Column id="awardsTime" header="立功受奖年份" field="awardsTime" width="100">
			<next:TextField />
		</next:Column>
		<next:Column id="awardsNote" header="立功受奖具体时间" field="awardsNote" width="450">
			<next:TextField />
		</next:Column>
		</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="prsawardsmeritoriousDataset"/>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
