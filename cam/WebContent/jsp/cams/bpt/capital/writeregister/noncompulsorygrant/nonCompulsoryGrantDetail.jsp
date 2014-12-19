<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
	<head>
		<title>除义务兵家庭外其他优抚对象优待金发放查看</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="<%=SkinUtils.getJS(request, "camsCheck.js")%>"></script>
		<script type="text/javascript" src="nonCompulsoryGrantEdit.js"></script>
		<script language="javascript">
			var registerId='<%=request.getParameter("registerId")%>';
		</script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.bpt.manage.cmd.BptCompulsoryDetailsQueryCommand" global="true" method="queryCompulsoryUpdate" pageSize="500" isGroup="true">
		<model:record fromBean="com.inspur.cams.bpt.capital.data.BptCompulsoryDetails">
			<model:field name="domicileCode" type="string"/>
			<model:field name="domicileName" type="string"/>
			<model:field name="name" type="string"/>
			<model:field name="idCard" type="string"/>
			<model:field name="accountCode" type="string"/>
			<model:field name="domicileType" type="string"/>
		</model:record>
	</model:dataset>
	<!-- 优抚对象类别 -->
	<model:dataset id="ObjectTypeDataset" enumName="OBJECT.TYPE.PART" autoLoad="true" global="true"></model:dataset>
	<!-- 户籍类别 -->
	<model:dataset id="DomicileTypeEnum" enumName="DOMICILE.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 是否孤老 -->
	<model:dataset id="LoneIfEnum" enumName="COMM.YESORNO" autoLoad="true"></model:dataset>
	<!-- 供养方式 -->
	<model:dataset id="SupportPatternEnum" enumName="SUPPORT.PATTERN" autoLoad="true"></model:dataset>
</model:datasets>
<next:GridPanel id="editGridPanel" name="bptcompulsorydetailsGrid" width="100%" stripeRows="true" height="100%" dataset="ds" autoExpandColumn="note" enableHdMenu="true" enableColumnHide="true" enableColumnMove="true" enableScollGridView="true">
	<next:GroupingView></next:GroupingView>
	<next:Columns>
		<next:RowNumberColumn width="40" header="序号"/>
	    <next:Column id="domicileName" header="户籍地" field="domicileName" sortable="true"></next:Column>   
		<next:Column id="name" header="姓名" field="name" width="90"  sortable="true"></next:Column>
		<next:Column id="idCard" header="身份证号" field="idCard" width="140"  sortable="true"></next:Column>
		<next:Column id="objectTypeCode" header="优抚对象类别" field="objectTypeCode" width="130" dataset="ObjectTypeDataset" sortable="true"></next:Column>
		<next:Column id="domicileType" header="户籍类别" field="domicileType" width="90" sortable="true" dataset="DomicileTypeEnum"></next:Column>
		<next:Column id="oldLonelyFlag" header="是否孤老" field="oldLonelyFlag" width="90" sortable="true" dataset="LoneIfEnum"></next:Column>
		<next:Column id="supportPattern" header="供养方式" field="supportPattern" width="90" sortable="true" dataset="SupportPatternEnum"></next:Column>
		<next:Column id="accountCode" header="银行帐号" field="accountCode" width="140" sortable="true"></next:Column>
		<next:Column id="grantMonSta" header="发放标准" field="grantMonSta" renderer="formatNum(this)" align="right" width="90" sortable="true"></next:Column>
		<next:Column id="grantMonths" header="发放月数" field="grantMonths" width="80" align="right" editable="false"></next:Column>
		<next:Column id="oldLonelyMon" header="孤老增发" field="oldLonelyMon" renderer="formatNum(this)" align="right" width="90" sortable="true"></next:Column>
		<next:Column id="otherSubsidyOne" header="其他补助1" field="otherSubsidyOne" renderer="formatNum(this)" align="right" width="90" sortable="true"></next:Column>
		<next:Column id="otherSubsidyTwo" header="其他补助2" field="otherSubsidyTwo" renderer="formatNum(this)" align="right" width="90" sortable="true"></next:Column>
		<next:Column id="otherSubsidyThree" header="其他补助3" field="otherSubsidyThree" renderer="formatNum(this)" align="right" width="90" sortable="true"></next:Column>
		<next:Column id="otherSubsidyFour" header="其他补助4" field="otherSubsidyFour" renderer="formatNum(this)" align="right" width="90" sortable="true"></next:Column>
		<next:Column id="otherSubsidyFive" header="其他补助5" field="otherSubsidyFive" renderer="formatNum(this)" align="right" width="90" sortable="true"></next:Column>
		<next:Column id="grantMonSum" header="发放总额" field="grantMonSum" renderer="formatNum(this)" align="right" width="90" sortable="true">
			<next:NumberField/>
		</next:Column>
		<next:Column id="note" header="备注" field="note" width="90" sortable="true">
			<next:TextField></next:TextField>
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:GridPanel>
</body>
<script type="text/javascript">
	function init() {
		var ds =L5.DatasetMgr.lookup("ds");	
		ds.setParameter("registerId",registerId);
		ds.load();
	}
</script>
</html>