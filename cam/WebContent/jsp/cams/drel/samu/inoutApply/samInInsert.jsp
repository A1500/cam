<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.IdHelp"%>
<%@page import="com.inspur.cams.comm.util.*"%>
<html>
<head>
<title>供养对象信息表编辑</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="samInInsert.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript">
	<%
	String applyId=IdHelp.getUUID32();
	String newPersonId=IdHelp.getUUID32();
	%>
	var method='<%=request.getParameter("method")%>';
	var personId='<%=request.getParameter("personId")%>';
	var newPersonId='<%=newPersonId%>';
	var applyId='<%=applyId%>';
	<%
		String organArea=BspUtil.getCorpOrgan().getOrganCode();
		String organName=DicUtil.getTextValueFromDic("DIC_CITY","ID",organArea,"NAME");
	%>
	var organArea='<%=organArea%>';
	var organName='<%=organName%>';
</script>
</head>
<body>
<model:datasets>
	<!-- 基础信息_人员信息 -->
	<model:dataset id="baseinfoPeopleDS"
		cmd="com.inspur.cams.drel.sam.cmd.BaseinfoPeopleQueryCmd"
		method="querySamPeopleList" pageSize="15">
		<model:record>
			<model:field name="TREATMENT_ID"/>
			<model:field name="TOWN"/>
			<model:field name="NAME"/>
			<model:field name="SUPPORT_ORG"/>
			<model:field name="GEROCOMIUM_NAME"/>
			<model:field name="GEROCOMIUM_ID"/>
			<model:field name="IN_ROOM"/>
			<model:field name="IN_BED"/>
			<model:field name="SEX"/>
			<model:field name="AGE"/>
			<model:field name="NATION_CODE"/>
			<model:field name="POLITICAL_CODE"/>
			<model:field name="ADDRESS"/>
			<model:field name="ID_CARD"/>
			<model:field name="INOUT_DATE"/>
			<model:field name="inHospital"/>
		</model:record>
	</model:dataset>
	<!-- 敬老院下拉框选项 -->
	<model:dataset id="samGeroDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SAM_GEROCOMIUM_INFO'></model:param>
			<model:param name="value" value='GEROCOMIUM_ID'></model:param>
			<model:param name="text" value='GEROCOMIUM_NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="samGeroKeptPersonDataSet" cmd="com.inspur.cams.drel.samu.cmd.SamGeroKeptPersonQueryCmd"  pageSize="15">
		<model:record fromBean="com.inspur.cams.drel.samu.data.SamGeroKeptPerson"/>
	</model:dataset>
	<model:dataset id="samGeroApplyDataSet" cmd="com.inspur.cams.drel.samu.cmd.SamGeroApplyQueryCmd" pageSize="15">
		<model:record fromBean="com.inspur.cams.drel.samu.data.SamGeroApply"/>
	</model:dataset>
	<!-- 性别 -->
	<model:dataset id="sex" enumName="COMM.SEX"
		autoLoad="true" global="true"></model:dataset>
	<!-- 民族 -->
	<model:dataset id="nation" autoLoad="true"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 政治面貌-->
	<model:dataset id="DmZzmmDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_POLITICAL'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>
<next:EditGridPanel id="infoQueryGrid" name="baseinfoPeopleResource"
	stripeRows="true" height="100%" width="100%" dataset="baseinfoPeopleDS" clickToSelectedForChkSM="true">
	<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="save" text="批量入院" handler="save"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
	</next:TopBar>
	<next:Columns>
   		<next:RowNumberColumn width="30"/>
   		<next:CheckBoxColumn></next:CheckBoxColumn>
		<%-- <next:Column header="地区" field="TOWN" width="100" align="center" /> --%>
		<next:Column header="姓名" field="NAME" width="80" align="center" />
		<next:Column header="性别" field="SEX" width="50" align="center" dataset="sex" />
		<next:Column header="年龄" field="AGE" width="50" align="center" />
		<next:Column header="民族" field="NATION_CODE" width="80" align="center" dataset="nation"/>
		<next:Column header="政治面貌" field="POLITICAL_CODE" width="80" align="center" dataset="DmZzmmDataSet"/>
		<next:Column header="家庭住址" field="ADDRESS" width="80" align="center" />
		<next:Column header="身份证号" field="ID_CARD" width="135" align="center" />
		<next:Column header="敬老院" field="GEROCOMIUM_ID" width="120" align="center" dataset="samGeroDataSet">
			<next:ComboBox triggerAction="all" valueField="value" displayField="text"  dataset="samGeroDataSet"/>
		</next:Column>
		<next:Column header="入院时间" field="INOUT_DATE" width="100" align="center">
		<next:DateField allowBlank="false" format="Y-m-d" ></next:DateField>
		</next:Column>
		<next:Column header="房间" field="IN_ROOM" width="80" align="center">
		<next:TextField></next:TextField>
		</next:Column>
		<next:Column header="床位" field="IN_BED" width="80" align="center">
		<next:TextField></next:TextField>
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="baseinfoPeopleDS" />
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>