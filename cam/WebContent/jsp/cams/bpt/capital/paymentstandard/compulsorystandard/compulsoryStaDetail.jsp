<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
	<head>
		<title>查看义务兵优待金标准</title>
		<next:ScriptManager/>
		<script>
		    var standardsCounties='<%=request.getParameter("STANDARDS_COUNTIES")%>';
			var startDate='<%=request.getParameter("START_DATE")%>';
			var endDate='<%=request.getParameter("END_DATE")%>';
			var method='<%=request.getParameter("method")%>';
		</script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.bpt.manage.cmd.BptCapitalstaQueryCommand" global="true"method="query" sortField="domicileType">
		<model:record fromBean="com.inspur.cams.bpt.capital.data.BptCapitalsta">
		    <model:field name="standardsName"/>
		</model:record>
	</model:dataset>
	<!-- 是否进藏、进疆 -->
	<model:dataset id="composedPort" enumName="COMM.YESORNO" global="true" autoLoad="true"></model:dataset>
	<!-- 优抚对象类别-->
	<model:dataset id="objectDs" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BPT_OBJECT_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset> 
	<!-- 户口类型 -->
	<model:dataset id="domicileTypeEnum" enumName="DOMICILE.TYPE" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:EditGridPanel id="editGridPanel" name="bptcapitalstadisabilityGrid" width="100%" stripeRows="true" height="100%" dataset="ds">
	<next:TopBar>
			<next:ToolBarItem symbol="->" ></next:ToolBarItem>
	        <next:ToolBarItem symbol="-" ></next:ToolBarItem>
			<next:ToolBarItem iconCls="undo"  text="返回" handler="back"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="40" header="序号"/><next:Column id="standardsCounties" header="标准所属县区代码" field="standardsCounties" hidden="true"></next:Column>
	    <next:Column id="standardsName" header="标准所属县区" field="standardsName" width="95" hidden="true"></next:Column>
		<next:Column id="objectType" header="优抚对象类别" field="objectType" width="120" dataset="objectDs" hidden="true"></next:Column>
	    <next:Column id="domicileType" header="户籍类别" field="domicileType" width="60" dataset="domicileTypeEnum"></next:Column>
		<next:Column id="inTibet" header="进藏进疆" field="inTibet" width="90" dataset="composedPort"></next:Column>
		<next:Column id="startDate" header="生效日期（起）" field="startDate" width="95"></next:Column>
		<next:Column id="endDate" header="生效日期（止）" field="endDate" width="95"></next:Column>
	    <next:Column id="spotStandards" header="现月标准" field="spotStandards" width="95" align="right"></next:Column>
		<next:Column id="newmoonStandards" header="新月标准" field="newmoonStandards" width="95" align="right"></next:Column>
		<next:Column id="inTibetAdditional" header="进藏进疆增发" field="inTibetAdditional" width="90" align="right"></next:Column>
		<next:Column id="id" header="ID" field="id" width="95" hidden="true" >			
			<next:TextField allowBlank="false"/>
		</next:Column>
	</next:Columns>
</next:EditGridPanel>
</body>
<script type="text/javascript">
function init() {
	ds.baseParams["STANDARDS_COUNTIES@="]=standardsCounties;
	ds.baseParams["START_DATE@="]=startDate;
	ds.baseParams["END_DATE@="]=endDate;
	ds.baseParams["TYPE@="]=4;
	ds.load();
};
function back(){	 	
	history.go(-1);
}
</script>
</html>
