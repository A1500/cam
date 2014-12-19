<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.*"%>
<html>
<head>
<title>家庭成员信息列表</title>
<next:ScriptManager />
<script type="text/javascript" src="samReleasePeopleDetail.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"DatePicker.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript">
		    var name='<%=request.getParameter("name")%>';
		    var idCard='<%=request.getParameter("idCard")%>';
	         var qReleaseDate = '<%=request.getParameter("qReleaseDate") %>';
		    var domicileCode='<%=request.getParameter("domicileCode")%>';
		    <%
		    String organArea=BspUtil.getCorpOrgan().getOrganCode();
			String organName=DicUtil.getTextValueFromDic("DIC_CITY","ID",organArea,"NAME");
			String assistanceType = request.getParameter("assistanceType");
		    %>
			var organArea='<%=organArea%>';
			var organName='<%=organName%>';
			var assistanceType='<%=assistanceType%>';
	</script>
</head>
<body>
<model:datasets>
	<!-- 导出家庭成员信息BaseinfoPeopleArchive -->
	<model:dataset id="PeopleDetailListDs" cmd="com.inspur.cams.drel.funds.release.cmd.SamReleaseDetailQueryCmd" method="queryPeopleDetail" global="true" pageSize="15">
	</model:dataset>
	<model:dataset id="peopleDetailDs"
		cmd="com.inspur.cams.drel.funds.release.cmd.SamReleaseDetailQueryCmd" method="queryPeopleDetail" global="true">
	</model:dataset>
	<!-- 与户主关系 -->
	 <model:dataset id="relationshipTypeDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_RELATIONSHIP_TYPE'></model:param>
		</model:params>
	</model:dataset>
	<!-- 性别 -->
	<model:dataset id="sex" enumName="COMM.SEX"
		autoLoad="true" global="true"></model:dataset>
		<!-- 婚姻状况 -->
	<model:dataset id="marriage" autoLoad="true"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_MARRIAGE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 文化程度 -->
	<model:dataset id="education" autoLoad="true"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_EDUCATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 健康状况 -->
	<model:dataset id="samHealthCode" enumName="SAM_HEALTH_CODE"
		autoLoad="true" global="true"></model:dataset>
		
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>

   <next:GridPanel id="peopleDetailGridPanel" name="peopleDetailGridPanel" notSelectFirstRow="true" clickToSelectedForChkSM="true" 
	stripeRows="true" height="400" width="100%" dataset="PeopleDetailListDs" >
	<next:TopBar>
        <next:ToolBarItem symbol="->"/>
        <next:ToolBarItem iconCls="chart" text="导出家庭成员信息" handler="exportPeopleDetail" id="exportPeopleDetail"/>
        <next:ToolBarItem iconCls="return" text="关闭" handler="viewCloseWin"/>
    </next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="30" />
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="domicileName" header="地区" field="DOMICILE_NAME"
			width="120" align="center">
			<next:TextField />
		</next:Column>
		<next:Column id="name" header="姓名" field="NAME" width="90"
			align="center">
			<next:TextField />
		</next:Column>
		<next:Column id="idCard" header="身份证号" field="ID_CARD" width="150"
			align="center">
			<next:TextField />
		</next:Column>
		<next:Column id="sex" header="性别"
			field="SEX" width="90" align="right" dataset="sex">
			<next:TextField />
		</next:Column>
		
		<next:Column id="idCard" header="户主姓名" field="FAMILY_NAME" width="90"
			align="center">
			<next:TextField />
		</next:Column>
		<%
			if(!"03".equals(assistanceType)) {
		%>
		<next:Column   header="是否保障对象"
			field="IS_ASSISTANCE" width="90" align="center" dataset="comm_yesorno">
			<next:TextField />
		</next:Column>
		<%
			} 
		%>
		<next:Column id="relationshipType" header="与户主关系" field="RELATIONSHIP_TYPE" width="90"
			 align="right" dataset="relationshipTypeDataset">
			<next:TextField />
		</next:Column>
		<%
			if("01".equals(assistanceType)) {
		%>
		<next:Column id="年收入" header="月收入(元)" field="INCOME_MONTH"
			width="90" renderer="formatMoney" align="right">
			<next:NumberField />
		</next:Column>
		<%
			} else if("02".equals(assistanceType)){
		%>
		<next:Column   header="年收入(元)" field="INCOME_YEAR"
			width="90" renderer="formatMoney" align="right">
			<next:NumberField />
		</next:Column>
		<%} %>
		<next:Column id="healthCode" header="健康状况" field="HEALTH_CODE" width="150"
			align="center" dataset="samHealthCode">
			<next:TextField />
		</next:Column>
		<next:Column id="eduCode" header="教育状况" 
			field="EDU_CODE" width="90" align="right" dataset="education">
			<next:TextField />
		</next:Column>
		<next:Column id="marriageCode" header="婚姻状况"
			field="MARRIAGE_CODE" width="90" align="right" dataset="marriage">
			<next:TextField />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="PeopleDetailListDs" />
	</next:BottomBar>
	</next:GridPanel> 
</body>
</html>