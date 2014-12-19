<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>公墓年检统计报表</title>
<next:ScriptManager />
<script type="text/javascript">
	var isP='<%=request.getParameter("isP")%>'
	 var state='<%=request.getParameter("state")%>';
	 var year='<%=request.getParameter("year")%>';
	 var cityCode='<%=request.getParameter("cityCode")%>';
	 var flag='<%=request.getParameter("flag")%>';
	 var ifSum ='<%=request.getParameter("ifSum")%>';
	 var prop ='<%=request.getParameter("prop")%>';
</script>
<script type="text/javascript" src="inspectionResultCemeDetail.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.fis.ep.base.cmd.FisCemeQueryCmd" method="queryResult" global="true">
		<model:record>
			<model:field name="ORGAN_ID"/>
			<model:field name="NAME"/>
			<model:field name="DEPT_NAME"/>
			<model:field name="MANA_LEVEL"/>
			<model:field name="ORGANIZER"/>
			<model:field name="ADDRESS"/>
			<model:field name="PROP"/>
			<model:field name="LEGAL_PEOPLE"/>
			<model:field name="DIRECTOR_MOBILE"/>
			<model:field name="GESTION_TIME"/>
			<model:field name="NUMBER_REAL"/>
		</model:record>
	</model:dataset>
	<model:dataset id="propDataSet" enumName="FIS.CEME.PROP"  autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:GridPanel id="editGridPanel"  width="99.9%" stripeRows="true" height="100%" dataset="ds" title="公墓基本信息">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="返回" iconCls="return" handler="back"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:RadioBoxColumn></next:RadioBoxColumn>
	     
		<next:Column id="cemeId" header="公墓编号" field="ORGAN_ID" width="110" >
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="cemeName" header="公墓名称" field="NAME"  width="100" >
			<next:TextField  />
		<%-- <next:Column id="cemeName" header="公墓名称" field="NAME" renderer="showDetail" width="100" >
			<next:TextField  /> --%>
		</next:Column>
		<next:Column id="prop" header="公墓性质" field="PROP" dataset="propDataSet"  width="100" >
			<next:TextField  />
		</next:Column>
		<next:Column id="directorMobile" field="DIRECTOR_MOBILE" header="公墓负责人联系方式" width="100" hidden="true">
		    <next:TextField/>
		</next:Column>
	    <next:Column id="legalPerson" header="法人代表" field="LEGAL_PEOPLE" width="100" >
			<next:TextField  />
		</next:Column>
		<next:Column id="organizer" header="主办单位" field="ORGANIZER" width="100" >
			<next:TextField  />
		</next:Column>
		<next:Column id="gestionTime" header="正式营业时间" field="GESTION_TIME" width="100" >
			<next:TextField  />
		</next:Column>
		<next:Column id="totalStaff" header="职工总数(人)" field="NUMBER_REAL" width="100" >
			<next:TextField  />
		</next:Column>
		<next:Column id="address" header="地址" field="ADDRESS" width="220" >
			<next:TextField  />
		</next:Column>
	    <next:Column id="manaLevel" header="主管单位" field="MANA_LEVEL" width="100" >
			<next:TextField  />
		</next:Column>
	    <next:Column id="areaLevel" header="所属行政区" field="DEPT_NAME" width="100" >
			<next:TextField  />
		</next:Column>
		  
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>