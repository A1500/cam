<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
	<head>
		<title>伤残抚恤金发放名册查看</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="<%=SkinUtils.getJS(request, "camsCheck.js")%>"></script>
		<script type="text/javascript" src="bptcapitaldetail.js"></script>
		<script language="javascript">
		    var registerId=<%=request.getParameter("registerId")%>;
		    var method='<%=request.getParameter("method")%>';
		</script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.bpt.manage.cmd.BptCapitalDetailQueryCommand" global="true" pageSize="500" method="queryYearDataSet" isGroup="true">
		<model:record fromBean="com.inspur.cams.bpt.capital.data.BptCapitalDetail"></model:record>
	</model:dataset>
	<!-- 发放类别 -->
	<model:dataset id="GrantTypeDataset" enumName="GRANTTYPE.FLAG" autoLoad="true" global="true"></model:dataset>
	<!-- 优抚对象类别-->
	<model:dataset id="objectDs" enumName="DISABILITY.TYPE.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 优抚对象状态 -->
	<model:dataset id="ObjectStateDataset" enumName="OBJECT.STATE" autoLoad="true" global="true"></model:dataset>
	<!-- 伤残等级-->
	<model:dataset id="LevelDs" enumName="LEVEL.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 优抚对象状态 -->
	<model:dataset id="ObjectStateDataset" enumName="OBJECT.STATE" autoLoad="true" global="true"></model:dataset>
	<!-- 伤残性质-->
	<model:dataset id="caseDs" enumName="CASE.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 伤残属别-->
	<model:dataset id="genusDs" enumName="GENUS.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 优抚对象状态 -->
	<model:dataset id="ObjectStateDataset" enumName="OBJECT.STATE" autoLoad="true" global="true"></model:dataset>
	<!-- 伤残时期-->
	<model:dataset id="warDs" enumName="WAR.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 孤老标志-->
	<model:dataset id="dsLoneFlag" enumName="COMM.YESORNO" autoLoad="true"></model:dataset>  
</model:datasets>
<next:GridPanel id="editGridPanel" name="bptcapitaldetailGrid" width="100%" stripeRows="true" height="100%" dataset="ds" enableHdMenu="true" enableColumnHide="true" enableColumnMove="true" enableScollGridView="true">
	<next:GroupingView></next:GroupingView>
	<next:Columns>
	     <next:RowNumberColumn width="40" header="序号"/>
		<next:Column id="domicileName" header="户籍地" field="domicileName" width="230"></next:Column>
		<next:Column id="name" header="姓名" field="name" width="50" sortable="true"></next:Column>
		<next:Column id="idCord" header="身份证号" field="idCord" width="135" sortable="true"></next:Column>
		<next:Column id="accountCode" header="银行帐号" field="accountCode" width="170" sortable="true"></next:Column>
		<next:Column id="credentialsNo" header="残疾证号" field="credentialsNo" width="90" sortable="true"></next:Column>
		<next:Column id="objectType" header="优抚对象类别" field="objectType" width="130" dataset="objectDs" sortable="true"></next:Column>
		<next:Column id="changeState" header="发放类别" field="changeState" width="130" dataset="GrantTypeDataset" sortable="true"></next:Column>
		<next:Column id="disabilityLevelCode" header="伤残等级代码" field="disabilityLevelCode" width="80" dataset="LevelDs" sortable="true"></next:Column>
		<next:Column id="disabilityWarCode" header="伤残时期" field="disabilityWarCode" width="60" dataset="warDs" sortable="true"></next:Column>
		<next:Column id="oldLonelyFlag" header="是否孤老" field="oldLonelyFlag" width="60" dataset="dsLoneFlag" sortable="true"></next:Column>
		<next:Column id="disabilityCaseCode" header="伤残性质" field="disabilityCaseCode" width="60" dataset="caseDs" sortable="true"></next:Column>
		<next:Column id="disabilityGenusCode" header="伤残属别" field="disabilityGenusCode" width="60" dataset="genusDs" sortable="true"></next:Column>
		<next:Column id="grantStaMon" header="省标准" field="grantStaMon" hidden="true"
			renderer="formatNum(this)" width="80" align="right" editable="false">
		</next:Column>
		<next:Column id="grantMonths" header="发放月数" field="grantMonths"
			width="80" align="right" editable="false">
		</next:Column>
		<next:Column id="grantMon" header="发放金额" field="grantMon"
			renderer="formatNum(this)" width="80" align="right" editable="false">
		</next:Column>
		<next:Column id="nursingMon" header="护理费" field="nursingMon"
			renderer="formatNum(this)" width="80" align="right" editable="false">
		</next:Column>
		<next:Column id="subTotal" header="地方补贴小计" field="subTotal"
			renderer="formatNum(this)" width="120" align="right" editable="false">
		</next:Column>
		<next:Column id="increaseMechanism" header="自然增长机制"
			field="increaseMechanism" renderer="formatNum(this)" width="120"
			align="right" editable="false">
		</next:Column>
		<next:Column id="grainOilMon" header="粮油补贴" field="grainOilMon"
			renderer="formatNum(this)" width="80" align="right" editable="false">
		</next:Column>
		<next:Column id="coalSubsidyMon" header="煤补补贴" field="coalSubsidyMon"
			renderer="formatNum(this)" width="80" align="right" editable="false">
		</next:Column>
		<next:Column id="antiJapaneseMon" header="抗日增发"
			field="antiJapaneseMon" renderer="formatNum(this)" width="80"
			align="right" editable="false">
		</next:Column>
		<next:Column id="oldLonelyMon" header="孤老增发" field="oldLonelyMon"
			renderer="formatNum(this)" width="80" align="right" editable="false">
		</next:Column>
		<next:Column id="supplyMon" header="补发金额" field="supplyMon"
			renderer="formatNum(this)" width="80" align="right" editable="false">
		</next:Column>
		<next:Column id="otherSubsidyOne" header="其他补助1"
			field="otherSubsidyOne" renderer="formatNum(this)" width="80"
			align="right" editable="false">
		</next:Column>
		<next:Column id="otherSubsidyTwo" header="其他补助2"
			field="otherSubsidyTwo" renderer="formatNum(this)" width="80"
			align="right" editable="false">
		</next:Column>
		<next:Column id="otherSubsidyThree" header="其他补助3"
			field="otherSubsidyThree" renderer="formatNum(this)" width="80"
			align="right" editable="false">
		</next:Column>
		<next:Column id="otherSubsidyFour" header="其他补助4"
			field="otherSubsidyFour" renderer="formatNum(this)" width="80"
			align="right" editable="false">
		</next:Column>
		<next:Column id="otherSubsidyFive" header="其他补助5"
			field="otherSubsidyFive" renderer="formatNum(this)" width="80"
			align="right" editable="false">
		</next:Column>
		<next:Column id="grantMonSum" header="发放资金总额" field="grantMonSum"
			renderer="formatNum(this)" width="80" align="right" editable="false">
		</next:Column>
		<next:Column id="note" header="备注" field="note" width="200">
		</next:Column>
	  </next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
