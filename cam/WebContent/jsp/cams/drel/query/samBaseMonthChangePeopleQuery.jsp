<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.*"%>
<html>
	<head>
		<title>低保、五保新增、减少保障对象情况查询</title>
		<next:ScriptManager />
		<script type="text/javascript" src="samBaseMonthChangePeopleQuery.js"></script>
		<script type="text/javascript" src="../comm/samInfoDetailComm.js"></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"DatePicker.js")%>'></script>
		<script type="text/javascript">
		    <%
		    String organArea=BspUtil.getCorpOrgan().getOrganCode();
			String organName=DicUtil.getTextValueFromDic("DIC_CITY","ID",organArea,"NAME");
		    %>
			var organArea='<%=organArea%>';
			var organName='<%=organName%>';
		</script>
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
	</head>
	<body>
	<model:datasets>
		<!-- 基础信息_人员信息 -->
	<model:dataset id="baseinfoPeopleDS"
		cmd="com.inspur.cams.drel.sam.cmd.BaseinfoPeopleQueryCmd"
		method="queryBaseChange" pageSize="20">
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
		<!-- 与户主关系 -->
	 <model:dataset id="relationshipTypeDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_RELATIONSHIP_TYPE'></model:param>
		</model:params>
	</model:dataset>
	<!-- 学业状况 -->
	<model:dataset id="eduStatusDataset" enumName="SAM_EDU_STATUS" autoLoad="true" global="true"></model:dataset>
	<!-- 供养方式 -->
	<model:dataset id="supportWayDataset" enumName="SAM.SUPPORT_WAY" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	
	</model:datasets>
		<next:Panel name="form" width="100%" border="0">
			<next:Html>
			<form class="L5form">
				<fieldset><legend>查询条件 <img
			class="GroupBoxExpandButton"
			src=<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>
			onclick="collapse(this)" /> </legend>
				<table width="100%">
					<tr>
						<td class="FieldLabel" nowrap="nowrap" width="8%">地区</td>
						<td class="FieldInput" width="25%"><input type="text"
							id="domicileName" name="domicileName" readonly="readonly"
							style="width: 180px" /><img
							src="<%=SkinUtils.getImage(request, "l5/help.gif")%>"
							style="cursor: hand" onclick="func_ForDomicileSelect()" /> <input
							type="text" id="domicileCode" name="domicileCode"
							style="display: none" /></td>
						<td class="FieldLabel" nowrap="nowrap" width="8%">救助对象类别</td>
						<td class="FieldInput" width="25%" >
	                    <select style="width: 180px" id="assistanceType">
                    		<option value="01">城市低保</option>
                    		<option value="02">农村低保</option>
                    		<option value="03">农村五保</option>
	                    </select></td>
						<td class="FieldInput" width="25%">
							<button id="queryId" onclick="query()">查 询</button>
						</td>	
					</tr>
					<tr>
						<td class="FieldLabel" nowrap="nowrap" width="8%">统计时间</td>
						<td class="FieldInput" width="25%">
							 <input type="text" id="startMonth" format="Y-m"  onclick="setmonth(this)" readonly="readonly"/>
		                     至<input type="text" id="endMonth" format="Y-m"  onclick="setmonth(this)" readonly="readonly"/>
	                    </td>
					
						<td class="FieldLabel" nowrap="nowrap" width="8%">变更情况</td>
						<td class="FieldInput" width="25%" >
	                    <select style="width: 180px" id="changeItem">
                    		<option value="new">新增</option>
                    		<option value="03">停保</option>
                    		<option value="01">保障金增加</option>
                    		<option value="02">保障金减少</option>
	                    </select></td>
						<td class="FieldInput" width="25%">
							<button onclick="resetQuery()">重 置</button>
						</td>	
					</tr>
				</table>
				</fieldset>
				</form>
			</next:Html>
		</next:Panel>
		<next:GridPanel id="infoQueryGrid" name="baseinfoFamilyResource"
			stripeRows="true" height="100%" width="100%" dataset="baseinfoPeopleDS" clickToSelectedForChkSM="true">
			<next:TopBar>
				<next:ToolBarItem id="qrToolbar" text="低保、五保基本情况变动查询信息"></next:ToolBarItem>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem text="导出CSV" iconCls="chart"
					handler="exportExcel"></next:ToolBarItem>
			</next:TopBar>
			<next:Columns>
	    		<next:RowNumberColumn width="30"/>
	    		<next:CheckBoxColumn></next:CheckBoxColumn>
				<next:Column header="地区" field="DOMICILE_FULL_NAME" width="200" align="center" />
				<next:Column header="低保证号" field="CARD_NO" width="150" align="center" />
				<next:Column header="姓名" field="NAME" width="80" align="center" renderer="detailHref" />
				<next:Column header="性别" field="SEX" width="50" align="center" dataset="sex" />
				<next:Column header="年龄" field="AGE" width="50" align="center" />
				<next:Column header="民族" field="NATION" width="80" align="center"  />
				<next:Column header="身份证号" field="ID_CARD" width="135" align="center" />
				<next:Column header="与户主关系" field="RELATIONSHIP_TYPE" width="120" align="center" dataset="relationshipTypeDataset" />
				<next:Column header="是否保障对象" field="IS_ASSISTANCE" width="120" align="center" dataset="comm_yesorno" />
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