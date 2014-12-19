<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.*"%>
<html>
<head>
<title>城市低保人员查询</title>
<next:ScriptManager />
	<script type="text/javascript" src="queryCityResPeopleAction.js"></script>
	<script type="text/javascript" src="../comm/samInfoDetailComm.js"></script>
	<script type="text/javascript" src='<%=SkinUtils.getJS(request,"DatePicker.js")%>'></script>
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
			String nowTime= DateUtil.getDay();
		    %>
			var nowTime ='<%=nowTime%>';
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
    	<!-- 与户主关系 -->
	 <model:dataset id="relationshipTypeDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_RELATIONSHIP_TYPE'></model:param>
		</model:params>
	</model:dataset>
	<!-- 分类施保类别 -->
			<model:dataset id="asisstanceClassDataset1" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" autoLoad="true">
				<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
				<model:params>
					<model:param name="dic" value='SAM_ASSISTANCE_CLASS'></model:param>
					<model:param name="value" value='ASSISTANCE_CLASS_CODE'></model:param>
					<model:param name="text" value='ASSISTANCE_CLASS_NAME'></model:param>
					<model:param name="ASSISTANCE_TYPE" value="01" />
				</model:params>
			</model:dataset>
		<model:dataset id="sambankDS" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" autoLoad="true">
				<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
				<model:params>
					<model:param name="dic" value='DIC_BANK'></model:param>
					<model:param name="value" value='CODE'></model:param>
					<model:param name="text" value='NAME'></model:param>
				</model:params>
			</model:dataset>
    <!-- 属别 -->
	<model:dataset id="belongingDataSet" enumName="SAM_BELONGING" autoLoad="true" global="true">
	</model:dataset>
	<!-- 人员状态 -->
	<model:dataset id="samPersonalStatsDataSet" enumName="SAM_PERSONAL_STATS_TAG" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
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
					<option dataset="nation"></option>
					</select>
				</td>
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
				<td class="FieldLabel" nowrap="nowrap">劳动能力</td>
				<td class="FieldInput"><select name="laborCapacity"
					id="laborCapacity" style="width: 180px">
					<option dataset="samLaborCapacity"></option>
				</select></td>
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
				<td class="FieldLabel" nowrap="nowrap">是否“三无”</td>
				<td class="FieldInput"><select name="isThreeNo" id="isThreeNo"
					style="width: 180px">
					<option dataset="yesOrNo"></option>
				</select></td>
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
			</tr>
			<tr>
				<td class="FieldLabel" nowrap="nowrap">属别</td>
				<td class="FieldInput"><select name="belonging"
					id="belonging" style="width: 180px">
					<option dataset="belongingDataSet"></option>
				</select></td>
			   <td class="FieldLabel" nowrap="nowrap">享受年月</td>
                <td class="FieldInput" width="25%"><input type="text"
                    id="assistanceBegin" name="assistanceBegin" 
                    readonly="readonly" onclick="setmonth(this)" style="width: 180px;padding-right:20px;background:url('<%= SkinUtils.getImage(request, "default/rl.gif ") %> ') no-repeat scroll right center transparent; " /></td>
				
				<td class="FieldLabel" nowrap="nowrap">与户主关系</td>
                <td class="FieldInput" ><select id="relationshipType" style="width:90%" name="与户主关系"  title="与户主关系"  style="width:90%" > <option dataset="relationshipTypeDataset"></option> </select></td>
			
			</tr>
			<tr>
				<td class="FieldLabel" width="8%">人员类型</td>
				<td class="FieldInput">			    	
					<input type="text" id='peopleTypeName' style="width:75%" readOnly="true" />
					<img src="<%=SkinUtils.getImage(request, "l5/help.gif")%>" style="cursor:hand" onclick="openTypeWin()"/>
					<input type="hidden" id='peopleType'>
				</td>
				<td class="FieldLabel" nowrap="nowrap">是否保障对象</td>
				<td class="FieldInput"><select name="是否保障对象" id="isAssistance"
					 style="width: 180px">
					<option dataset="comm_yesorno"></option>
				</select></td>
				<td class="FieldLabel" nowrap="nowrap">人员状态</td>
				<td class="FieldInput"><select name="人员状态" id="peopleStatus"
					style="width: 180px">
					<option dataset="samPersonalStatsDataSet"></option>
				</select></td>
			</tr>
			<tr>
				<td class="FieldButton" nowrap="nowrap" colspan="6">
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
		<next:ToolBarItem id="qrToolbar" text="城市低保人员查询信息"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="查看家庭明细" iconCls="detail"
			handler="detailFamily"></next:ToolBarItem>
		<next:ToolBarItem text="导出CSV" iconCls="chart"
			handler="exportExcel"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="30"/>
		<next:Column header="地区" field="DOMICILE_FULL_NAME" width="200" align="center" />
			<next:Column header="家庭主键" field="FAMILY_ARCHIVE_ID" width="50"
					align="center" hidden="true">
					<next:TextField />
				</next:Column>
				
		<next:Column header="姓名" field="NAME" width="80" align="center" renderer="detailHref" />
		<next:Column header="性别" field="SEX" width="50" align="center" dataset="sex"/>
		<next:Column header="年龄" field="AGE" width="50" align="center" />
		<next:Column header="民族" field="NATION" width="80" align="center"  />
		<next:Column header="身份证号" field="ID_CARD" width="135" align="center" />
		<next:Column header="与户主关系" field="RELATIONSHIP_TYPE" width="120" align="center" dataset="relationshipTypeDataset" />
		<next:Column header="人员状态" field="PERSONAL_STATS_TAG" width="120" align="center" dataset="samPersonalStatsDataSet" />
		<next:Column header="是否保障对象" field="IS_ASSISTANCE" width="120" align="center" dataset="comm_yesorno" />
		<next:Column header="月收入（元）" field="INCOME_MONTH" width="129"	align="right" renderer="formatNum" />
		<next:Column header="属别" field="BELONGING" dataset="belongingDataSet" width="100" align="center" />
		<next:Column header="低保证号" field="CARD_NO" width="130" align="center">
					<next:TextField />
				</next:Column>
		<next:Column header="起始保障年月" field="BEGIN_DATE" width="100"
					align="center">
					<next:TextField />
				</next:Column>
		<next:Column header="户月保障金额（元）" field="ASSISTANCE_MONEY" width="120"
					align="right" renderer="formatNum">
					<next:TextField />
				</next:Column>
		<next:Column header="分类施保类别" field="ASSISTANCE_CLASS_MODE" width="100" dataset="asisstanceClassDataset1" align="center" > <next:TextField />
				</next:Column>
		<next:Column header="分类施保金（元）" field="ASSISTANCE_CLASS_MONEY" width="120"
					align="right" renderer="formatNum">
					<next:TextField />
				</next:Column>
			<next:Column header="户主姓名" field="FAMILY_NAME" width="80"
					align="center" >
					<next:TextField />
				</next:Column>		
		<next:Column header="开户银行" field="BANK" width="150"
					align="center" dataset="sambankDS">
					<next:TextField />
				</next:Column>
				<next:Column header="账户名称" field="ACCOUNT_NAME" width="100"
					align="center">
					<next:TextField />
				</next:Column>
		<next:Column header="银行账号" field="ACCOUNT_NUMBER" width="150"
					align="center">
					<next:TextField />
	</next:Column>	
		<next:Column header="家庭住址" field="ADDRESS" width="300"
					align="center">
					<next:TextField />
				</next:Column>
		<next:Column header="联系电话" field="FAMILY_MOBILE" width="100"
					align="center">
					<next:TextField />
				</next:Column>
		<next:Column header="是否“三无”" field="IS_THREE_NO" width="90" align="center" dataset="yesOrNo" />
		<next:Column header="文化程度" field="EDU_CODE" width="165" align="center"  />
		<next:Column header="健康状况" field="HEALTH_CODE" width="80" align="center" dataset="samHealthCode" />
		<next:Column header="婚姻状况" field="MARRIAGE_CODE" width="80" align="center" />
		<next:Column header="劳动能力" field="LABOR_CAPACITY" width="104" align="center" dataset="samLaborCapacity" />
		<next:Column header="残疾类别" field="DISABILITY_TYPE" width="80" align="center"  />
		<next:Column header="残疾等级" field="DISABILITY_LEVEL" width="80" align="center"  />
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="baseinfoPeopleDS" />
	</next:BottomBar>
</next:GridPanel>

<jsp:include page="../comm/assistanceType.jsp" flush="true">   
	<jsp:param name= "ifPeople" value= "1"/> 
	<jsp:param name= "assistanceType" value= "01"/> 
</jsp:include>	
</body>
</html>