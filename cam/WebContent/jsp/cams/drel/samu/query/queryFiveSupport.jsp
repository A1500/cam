<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.*"%>
<html>
<head>
<title>农村五保人员查询</title>
<next:ScriptManager />
		<script type="text/javascript" src="<%=SkinUtils.getRootUrl(request)%>skins/js/ygms/MultiSimpleGridHelp.js"></script>
	<script type="text/javascript" src="queryFiveSupport.js"></script>
	<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
	<script type="text/javascript" src='<%=SkinUtils.getJS(request,"DatePicker.js")%>'></script>
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
		method="querySamPeopleList" pageSize="15">
	</model:dataset>
	<!-- 健康状况 -->
	<model:dataset id="samHealthCode" enumName="SAM_HEALTH_CODE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 劳动能力 -->
	<model:dataset id="selfCareAbilityDataset" enumName="SAM_SELF_CARE_ABILITY" autoLoad="true" global="true"></model:dataset>
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
	<!-- 供养方式 -->
	<model:dataset id="supportWayDataset" enumName="SAM.SUPPORT_WAY" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel name="form" width="100%" border="0">
	<next:Html>
		<fieldset><legend>查询条件 <img
			class="GroupBoxExpandButton"
			src=<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>
			onclick="collapse(this)" /> </legend>
		<div>
		<form class="L5form" id="queryForm">
		<table width="100%">
			<tr>
				<td class="FieldLabel" nowrap="nowrap" width="10%">地区</td>
				<td class="FieldInput" width="20%"><input type="text"
					id="domicileName" name="domicileName" readonly="readonly"
					style="width: 180px" /><img
					src="<%=SkinUtils.getImage(request, "l5/help.gif")%>"
					style="cursor: hand" onclick="func_ForDomicileSelect()" /> <input
					type="text" id="domicileCode" name="domicileCode"
					style="display: none" /></td>
				<td class="FieldLabel" nowrap="nowrap" width="10%">姓名</td>
				<td class="FieldInput" width="20%"><input type="text" id="name"
					name="name" style="width: 180px" /></td>
				<td class="FieldLabel" nowrap="nowrap" width="10%">身份证号</td>
				<td class="FieldInput" width="20%"><input type="text"
					name="idCard" id="idCard" style="width: 180px"  onchange="checkIDCard(this)"/></td>
			</tr>
			<tr>
				<td class="FieldLabel" nowrap="nowrap">性别</td>
				<td class="FieldInput"><select name="sex"
					id="sex" style="width: 180px">
					<option dataset="sex"></option></select></td>
				<td class="FieldLabel" nowrap="nowrap" width="10%">年龄</td>
				<td class="FieldInput" width="20%">
					<input type="text" id="sAge" name="sAge" style="width: 52px" />
					&nbsp;～&nbsp; 
					<input type="text" id="eAge" name="eAge" style="width: 52px" />
				</td>
				<td class="FieldLabel" nowrap="nowrap">民族</td>
				<td class="FieldInput"><select name="nation"
					id="nation" style="width: 180px">
					<option dataset="nation"></option></td>
			</tr>
			<tr>
				<td class="FieldLabel" nowrap="nowrap">政治面貌</td>
                <td class="FieldInput"><select name="政治面貌" id="qPoliticalCode"
                    style="width: 180px">
                    <option dataset="DmZzmmDataSet"></option>
                </select></td>
				<td class="FieldLabel" nowrap="nowrap">健康状况</td>
				<td class="FieldInput"><select name="healthCode"
					id="healthCode" style="width: 180px">
					<option dataset="samHealthCode"></option>
				</select></td>
				<td class="FieldLabel" nowrap="nowrap">婚姻状况</td>
				<td class="FieldInput"><select name="marriageCode"
					id="marriageCode" style="width: 180px">
					<option dataset="marriage"></option>
				</select></td>
			</tr>
			<tr>
				<td class="FieldLabel" nowrap="nowrap">生活自理能力</td>
				<td class="FieldInput">
				    <select name="生活自理能力" title="生活自理能力" id="selfCareAbility" style="width: 180px"> 
				      <option dataset="selfCareAbilityDataset" /> 
				    </select>
				</td>
				<td class="FieldLabel" nowrap="nowrap">残疾类别</td>
				<td class="FieldInput"><select name="disabilityType"
					id="disabilityType" style="width: 180px">
					<option dataset="disabilityType"></option>
				</select></td>
				<td class="FieldLabel" nowrap="nowrap">残疾等级</td>
				<td class="FieldInput"><select name="残疾等级" id="qDisabilityLevel"
					 style="width: 180px">
					<option dataset="DmCjdjDataSet"></option>
				</select></td>
			</tr>
			<tr>
				<td class="FieldLabel" nowrap="nowrap">学业状况</td>
				<td class="FieldInput"><select name="学业状况" id="qEduStatus"
					 style="width: 180px">
					<option dataset="eduStatusDataset"></option>
				</select></td>
				<td class="FieldLabel" nowrap="nowrap">文化程度</td>
				<td class="FieldInput"><select name="eduCode" id="eduCode"
					style="width: 180px">
					<option dataset="education"></option>
				</select></td>
				<td class="FieldLabel" nowrap="nowrap">享受年月</td>
                <td class="FieldInput" width="25%"><input type="text"
                    id="assistanceBegin" name="assistanceBegin" 
                    readonly="readonly" onclick="setmonth(this)"  style="width: 180px"/></td>
			</tr>
			<tr>
				<td class="FieldLabel" nowrap="nowrap"></td>
				<td class="FieldInput"></td>
				<td class="FieldButton" colspan="2"></td>
				<td nowrap="nowrap" class="FieldButton" colspan="2">
                    <button id="queryId" onclick="query()">查 询</button>
                    &nbsp;
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
		<next:ToolBarItem id="qrToolbar" text="农村五保人员查询信息"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
   		<next:RowNumberColumn width="30"/>
   		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column header="地区" field="DOMICILE_FULL_NAME" width="100" align="center" />
		<next:Column header="姓名" field="NAME" width="80" align="center" renderer="detailHref" />
		<next:Column header="性别" field="SEX" width="50" align="center" dataset="sex" />
		<next:Column header="年龄" field="AGE" width="50" align="center" />
		<next:Column header="民族" field="NATION" width="80" align="center"  />
		<next:Column header="身份证号" field="ID_CARD" width="135" align="center" />
		 <next:Column header="供养方式" field="SUPPORT_WAY" width="120" align="center" dataset="supportWayDataset" />
		<next:Column header="年收入（元）" field="INCOME_YEAR" width="129" align="right" renderer="formatNum" />
		<next:Column header="文化程度" field="EDU_CODE" width="165" align="center"  />
        <next:Column header="健康状况" field="HEALTH_CODE" width="80" align="center" dataset="samHealthCode" />
        <next:Column header="婚姻状况" field="MARRIAGE_CODE" width="80" align="center" />
		<next:Column header="生活自理能力" field="SELF_CARE_ABILITY" width="104" align="center" dataset="selfCareAbilityDataset" />
		<next:Column header="残疾类别" field="DISABILITY_TYPE" width="80" align="center"  />
        <next:Column header="残疾等级" field="DISABILITY_LEVEL" width="80" align="center"  />
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="baseinfoPeopleDS" />
	</next:BottomBar>
</next:GridPanel>
</body>
</html>