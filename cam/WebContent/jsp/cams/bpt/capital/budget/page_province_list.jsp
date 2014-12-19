<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<next:ScriptManager />
<script type="text/javascript" src="<%=SkinUtils.getJS(request, "camsCheck.js")%>"></script>
<script type="text/javascript" src="page_province_list.js"></script>
<script type="text/javascript">
	var organCode = '<%=BspUtil.getOrganCode()%>'; 
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="ds"cmd="com.inspur.cams.bpt.capital.cmd.BPTCapitalBudgetQueryCmd" method="queryProvince" global="true">
		<model:record fromBean="com.inspur.cams.bpt.capital.data.BptCapitalDetail">
			<model:field name="CENTRAL_TOTAL" type="string"/>
			<model:field name="PROVINCE_TOTAL" type="string"/>
			<model:field name="TOTAL" type="string"/>
		</model:record>
	</model:dataset>
</model:datasets>
<next:GridPanel id="editGridPanel" name="prsretiredsoldiersGrid"
	width="100%" stripeRows="true" height="100%" style="padding: 5px;" autoScroll="true"
	dataset="ds"  notSelectFirstRow="true"
	title="资金投入管理">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="增加" iconCls="add" handler="insert" id="add"/>
		<next:ToolBarItem text="修改" iconCls="edit" handler="update" id="edit"/>
		<next:ToolBarItem text="删除" iconCls="remove" id="del" handler="del" id="del"/>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="30" />
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="YEAR" header="年份" field="YEAR" width="60">
			<next:TextField />
		</next:Column>
		<next:Column id="CENTRAL_TOTAL" header="中央小计(万元)" field="CENTRAL_TOTAL" renderer="formatNum(this)" width="150" align="right">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="COMPENSATION_SUBSIDY" header="中央抚恤补助经费(万元)" field="COMPENSATION_SUBSIDY" renderer="formatNum(this)" width="150" align="right">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="INSTITUTION_SUBSIDY" header="中央优抚事业单位补助经费(万元)" field="INSTITUTION_SUBSIDY" renderer="formatNum(this)" width="200" align="right">
			<next:TextField />
		</next:Column>
		<next:Column id="MEDICAL_SUBSIDY" header="中央医疗补助经费(万元)" field="MEDICAL_SUBSIDY" align="right" renderer="formatNum(this)" width="140">
			<next:TextField />
		</next:Column>
		<next:Column id="HOUSE_SUBSIDY" header="中央住房补助经费(万元)" field="HOUSE_SUBSIDY" align="right" renderer="formatNum(this)" width="140"> 
			<next:TextField />
		</next:Column>
		<next:Column id="PROVINCE_TOTAL" header="省小计(万元)" field="PROVINCE_TOTAL" renderer="formatNum(this)" width="150" align="right">
			<next:TextField allowBlank="false"/>
		</next:Column>
		<next:Column id="COMPENSATION_SUBSIDY1" header="省抚恤补助经费(万元)" field="COMPENSATION_SUBSIDY1" renderer="formatNum(this)" width="150" align="right">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="INSTITUTION_SUBSIDY1" header="省优抚事业单位补助经费(万元)" field="INSTITUTION_SUBSIDY1" renderer="formatNum(this)" width="200" align="right">
			<next:TextField />
		</next:Column>
		<next:Column id="MEDICAL_SUBSIDY1" header="省医疗补助经费(万元)" field="MEDICAL_SUBSIDY1" align="right" renderer="formatNum(this)" width="140">
			<next:TextField />
		</next:Column>
		<next:Column id="HOUSE_SUBSIDY1" header="省住房补助经费(万元)" field="HOUSE_SUBSIDY1" align="right" renderer="formatNum(this)" width="170"> 
			<next:TextField />
		</next:Column>
		<next:Column id="TOTAL" header="合计(万元)" field="TOTAL" renderer="formatNum(this)" width="150" align="right">
			<next:TextField allowBlank="false"/>
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds" />
	</next:BottomBar>
</next:GridPanel>
</body>
</html>