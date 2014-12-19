<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.*"%>
<html>
<head>
<title>可能成为五保对象的人员查询</title>
<next:ScriptManager />
	<script type="text/javascript" src="queryMaybeFiveList.js"></script>
	<script type="text/javascript" src="../comm/samInfoDetailComm.js"></script>
	<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
		<script language="javascript">
		 	 //查询条件打开合并函数
			 function collapse(element){
				var fieldsetParent=L5.get(element).findParent("fieldset");
				if(element.expand==null||element.expand==true){
					fieldsetParent.getElementsByTagName("div")[0].style.display="none";
					element.src = '<%=SkinUtils.getImage(request, "groupbox_expand.gif")%>';
					element.expand=false;
				}else{
					fieldsetParent.getElementsByTagName("div")[0].style.display="";
					element.src = "<%=SkinUtils.getImage(request, "groupbox_collapse.gif")%>";
					element.expand =true;
				}
			}
	</script>
	<script type="text/javascript">
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
		method="queryMaybeFiveList" pageSize="15">
	</model:dataset>
	<!-- 健康状况 -->
	<model:dataset id="samHealthCode" enumName="SAM_HEALTH_CODE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 劳动能力 -->
	<model:dataset id="samLaborCapacity" enumName="SAM_LABOR_CAPACITY"
		autoLoad="true" global="true"></model:dataset>
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
	<!-- 是否“三无” -->
	<model:dataset id="yesOrNo" enumName="COMM.YESORNO" autoLoad="true"
		global="true"></model:dataset>
	<!-- 分类施保类别 -->
	<model:dataset id="assistance" autoLoad="true"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SAM_ASSISTANCE_ITEM'></model:param>
			<model:param name="value" value='ITEM_CODE'></model:param>
			<model:param name="text" value='ITEM_NAME'></model:param>
			<model:param name="itemType" value='01'></model:param>
		</model:params>
	</model:dataset>
	<!-- 户籍类别 -->
	<model:dataset id="domicileType" enumName="SAM_DOMICILE_TYPE"
		autoLoad="true" global="true"></model:dataset>
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
	<!-- 残疾类别 -->
	<model:dataset id="disabilityType" autoLoad="true"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_DISABILITY_TYPE'></model:param>
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
	<!-- 残疾等级 -->
	<model:dataset id="DmCjdjDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_HANDICAP_LEVEL'></model:param>
		</model:params>
	</model:dataset>
	<!-- 学业状况 -->
	<model:dataset id="eduStatusDataset" enumName="SAM_EDU_STATUS" autoLoad="true" global="true"></model:dataset>
     <!-- 人员类型 -->
    <model:dataset id="peoTypeDS" cmd="com.inspur.cams.comm.dicm.cmd.DicDetailsQueryCmd" method="queryForDic" global="true" autoLoad="true">
        <model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
        <model:params>
            <model:param name="dicType" value="PEOPLE_TYPE"></model:param>
        </model:params>
    </model:dataset>
</model:datasets>

<next:Panel name="form" width="100%" border="0">
	<next:Html>
		<fieldset><legend>查询条件 <img
			class="GroupBoxExpandButton"
			src=<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>
			onclick="collapse(this)" /> </legend>
		<div>
		<form class="L5form">
		<table width="100%">
			<tr>
				<td class="FieldLabel" nowrap="nowrap" width="20%">地区</td>
				<td class="FieldInput" width="30%"><input type="text" id="domicileName" name="domicileName" readonly="readonly" style="width: 180px" />
			      <img src="<%=SkinUtils.getImage(request, "l5/help.gif")%>" style="cursor: hand" onclick="func_ForDomicileSelect()" /> 
			    <input type="text" id="domicileCode" name="domicileCode" style="display: none" /></td>
				
				<td class="FieldButton" nowrap="nowrap" width="50%">
					<button id="queryId" onclick="query()">查 询</button>
				</td>
			</tr>
			<tr style="display:none">
				<td class="FieldLabel" nowrap="nowrap" width="10%">是否有赡（抚、扶）养义务人</td>
				<td class="FieldInput" width="10%"><select id="ifSupported" disabled="disabled"
					style="width: 180px">
					<option dataset="yesOrNo"></option>
				</select></td>
				<td class="FieldLabel" nowrap="nowrap" width="10%">是否重度残疾</td>
				<td class="FieldInput" width="10%"><select disabled="disabled"
					id="ifDisability" style="width: 180px">
					<option dataset="yesOrNo" value="1"></option>
				</select></td>
				<td class="FieldLabel" nowrap="nowrap" width="10%">婚姻状况</td>
				<td class="FieldInput" width="10%"><select id="marriageCode" disabled="disabled" style="width: 180px">
					<option dataset="marriage" value="10"></option>
				</select></td>
				<td class="FieldLabel" nowrap="nowrap" width="10%">
					<button onclick="resetQuery()">重 置</button>
				</td>
			</tr>
		</table>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="infoQueryGrid" name="baseinfoPeopleResource"
	stripeRows="true" height="100%" width="100%" dataset="baseinfoPeopleDS" clickToSelectedForChkSM="true">
	<next:TopBar>
		<next:ToolBarItem id="qrToolbar" text="疑似五保对象查询信息"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="导出CSV" iconCls="chart"
			handler="exportExcel"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="30" />
		<next:Column header="地区" field="TOWN" width="100"
			align="center">
			<next:TextField />
		</next:Column>
		<next:Column header="姓名" field="NAME" width="80" align="center" renderer="detailHref">
			<next:TextField />
		</next:Column>
		<next:Column header="性别" field="SEX" width="50" align="center" dataset="sex">
			<next:TextField />
		</next:Column>
		<next:Column header="年龄" field="AGE" width="50" align="center">
			<next:TextField />
		</next:Column>
		<next:Column header="民族" field="NATION" width="80" align="center" >
			<next:TextField />
		</next:Column>
		<next:Column header="身份证号" field="ID_CARD" width="135"
			align="center">
			<next:TextField />
		</next:Column>
		<next:Column header="年收入（元）" field="INCOME_YEAR" width="129"
			align="right" renderer="formatNum">
			<next:TextField />
		</next:Column>
		<next:Column header="文化程度" field="EDU_CODE" width="165" align="center" >
			<next:TextField />
		</next:Column>
		<next:Column header="健康状况" field="HEALTH_CODE" width="80"
			align="center" dataset="samHealthCode">
			<next:TextField />
		</next:Column>
		<next:Column header="婚姻状况" field="MARRIAGE_CODE" width="80"
			align="center" >
			<next:TextField />
		</next:Column>
		<next:Column header="劳动能力" field="LABOR_CAPACITY" width="104"
			align="center" dataset="samLaborCapacity">
			<next:TextField />
		</next:Column>
		<next:Column header="残疾类别" field="DISABILITY_TYPE" width="80" align="center" >
			<next:TextField />
		</next:Column>
		<next:Column header="残疾等级" field="DISABILITY_LEVEL" width="80" align="center" >
			<next:TextField />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="baseinfoPeopleDS" />
	</next:BottomBar>
</next:GridPanel>

<jsp:include page="../comm/assistanceType.jsp" flush="true">   
	<jsp:param name= "ifPeople" value= "1"/> 
</jsp:include>	
</body>
</html>