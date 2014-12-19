<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<next:ScriptManager />
<script type="text/javascript">
	var organCode = '<%=BspUtil.getOrganCode()%>'; 
	var selectOrganCode ='<%=request.getParameter("selectOrganCode")%>';
	var level ='<%=request.getParameter("level")%>';
</script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request, "camsCheck.js")%>"></script>
<script type="text/javascript" src="page_city_list.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.bpt.capital.cmd.BPTCapitalBudgetQueryCmd" method="queryCity"  global="true">
		<model:record fromBean="com.inspur.cams.bpt.capital.data.BPTCapitalBudget">
			<model:field name="upperTotal" type="string"/>
			<model:field name="currentTotal" type="string"/>
			<model:field name="total" type="string"/>
		</model:record>
	</model:dataset>
</model:datasets>
<next:GridPanel id="GridPanel" name="prsretiredsoldiersGrid"
	width="100%" stripeRows="true"  style="padding: 5px;" height="100%"
	dataset="ds"  notSelectFirstRow="true" title="" autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="增加" iconCls="add" handler="insert" id="insert" />
		<next:ToolBarItem text="修改" iconCls="edit" handler="update" id="update"/>
		<next:ToolBarItem text="删除" iconCls="remove" id="del" handler="del" id="del"/>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="30"/>
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="year" header="年份" field="year" width="60">
			<next:TextField/>
		</next:Column>
		<next:Column id="upperTotal" header="上级补助经费小计(万元)" field="upperTotal" renderer="formatNum(this)" width="140" align="right">
			<next:TextField allowBlank="false"/>
		</next:Column>
		<next:Column id="compensationSubsidyUp" header="抚恤补助经费(上级)(万元)" field="compensationSubsidyUp" renderer="formatNum(this)" width="145" align="right">
			<next:TextField allowBlank="false"/>
		</next:Column>
		<next:Column id="institutionSubsidyUp" header="优抚事业单位补助经费(上级)(万元)" field="institutionSubsidyUp" renderer="formatNum(this)" width="200" align="right">
			<next:TextField/>
		</next:Column>
		<next:Column id="medicalSubsidyUp" header="医疗补助经费(上级)(万元)" field="medicalSubsidyUp" align="right" renderer="formatNum(this)" width="150">
			<next:TextField/>
		</next:Column>
		<next:Column id="houseSubsidyUp" header="住房补助经费(上级)(万元)" field="houseSubsidyUp" align="right" renderer="formatNum(this)" width="150">
			<next:TextField/>
		</next:Column>
		<next:Column id="currentTotal" header="本级补助经费小计(万元)" field="currentTotal" renderer="formatNum(this)" width="150" align="right">
			<next:TextField allowBlank="false"/>
		</next:Column>
		<next:Column id="compensationSubsidy" header="抚恤补助经费(万元)" field="compensationSubsidy" renderer="formatNum(this)" width="130" align="right">
			<next:TextField allowBlank="false"/>
		</next:Column>
		<next:Column id="institutionSubsidy" header="优抚事业单位补助经费(万元)" field="institutionSubsidy" renderer="formatNum(this)" width="150" align="right">
			<next:TextField/>
		</next:Column>
		<next:Column id="medicalSubsidy" header="医疗补助经费(万元)" field="medicalSubsidy" align="right" renderer="formatNum(this)" width="120">
			<next:TextField/>
		</next:Column>
		<next:Column id="houseSubsidy" header="住房补助经费(万元)" field="houseSubsidy" align="right" renderer="formatNum(this)" width="120"> 
			<next:TextField/>
		</next:Column>
		<next:Column id="total" header="合计(万元)" field="total" renderer="formatNum(this)" width="150" align="right">
			<next:TextField allowBlank="false"/>
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>