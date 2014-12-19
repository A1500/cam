<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%
	response.setHeader("Expires", "Sat, 6 May 1995 12:00:00 GMT");  
	response.setHeader("Cache-Control", "no-store,no-cache,must-revalidate");  
	response.addHeader("Cache-Control", "post-check=0, pre-check=0");  
	response.setHeader("Pragma", "no-cache");  
%>
<html>
	<head>
		<title>三属定期抚恤金发放名册变更明细</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="<%=SkinUtils.getJS(request, "camsCheck.js")%>"></script>
		<script type="text/javascript" src="depandentGrantDetail.js"></script>
		<script language="javascript">
		    var registerId='<%=request.getParameter("registerId")%>';
		</script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.bpt.manage.cmd.BptCapitalDetailQueryCommand" global="true" pageSize="500" method="queryYearDataSet" isGroup="true">
		<model:record fromBean="com.inspur.cams.bpt.capital.data.BptCapitalDetail"></model:record>
	</model:dataset>
	<!-- 发放类别 -->
	<model:dataset id="GrantTypeDataset" enumName="GRANTTYPE.FLAG" autoLoad="true" global="true"></model:dataset>
	<!-- 三属类别 -->
	<model:dataset id="DependantTypeDataset" enumName="DEPENDANT.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 户籍类别 -->
	<model:dataset id="DomicileDataset" enumName="DOMICILE.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 孤老标志-->
	<model:dataset id="dsLoneFlag" enumName="COMM.YESORNO" autoLoad="true"></model:dataset>
</model:datasets>
<next:GridPanel id="editGridPanel" name="bptcapitaldetailGrid" width="100%" stripeRows="true" height="100%" dataset="ds" enableHdMenu="true"  enableColumnHide="true" enableColumnMove="true" enableScollGridView="true">
	<next:GroupingView></next:GroupingView>
	<next:Columns>
	    <next:RowNumberColumn width="40" header="序号"/>
		<next:Column id="domicileName" header="户籍地" field="domicileName"
			width="230"></next:Column>
		<next:Column id="name" header="姓名" field="name" width="50"></next:Column>
		<next:Column id="idCord" header="身份证号" field="idCord" width="135"></next:Column>
		<next:Column id="accountCode" header="银行帐号" field="accountCode"
			width="170"></next:Column>
		<next:Column id="credentialsNo" header="优抚证号" field="credentialsNo"
			width="90"></next:Column>
		<next:Column id="objectType" header="优抚对象类别" field="objectType"
			width="130" dataset="DependantTypeDataset"></next:Column>
		<next:Column id="changeState" header="发放类别" field="changeState"
			width="130" dataset="GrantTypeDataset"></next:Column>
		<next:Column id="oldLonelyFlag" header="是否孤老" field="oldLonelyFlag"
			width="60" dataset="dsLoneFlag"></next:Column>
		<next:Column id="grantStaMon" header="省标准" field="grantStaMon" hidden="true"
			renderer="formatNum(this)" width="80" align="right" editable="false">
		</next:Column>
		<next:Column id="grantMonths" header="发放月数" field="grantMonths"
			width="80" align="right" editable="false">
		</next:Column>
		<next:Column id="grantMon" header="发放金额" field="grantMon"
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
<script type="text/javascript">
function init(){
	ds.setParameter("REGISTER_ID",registerId);
	ds.setParameter("CHANGE_STATE@!=","2");	
	ds.load();
}
</script>
</body>
</html>
