<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.*"%>
<html>
	<head>
		<title>农村低保家庭查询</title>
		<next:ScriptManager />
		<script type="text/javascript" src="queryRuralResFamilyAction.js"></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"DatePicker.js")%>'></script>
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
			<!-- 基础信息_家庭信息 -->
			<model:dataset id="baseinfoFamilyDS"
				cmd="com.inspur.cams.drel.sam.cmd.BaseinfoFamilyQueryCmd"
				method="querySamFamilyList" pageSize="15">
			</model:dataset>
			<!-- 救助对象类型 -->
			<model:dataset id="AssistanceDataset" autoLoad="true"
				cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true">
				<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
				<model:params>
					<model:param name="dic" value='DIC_ASSITANCE_TYPE'></model:param>
					<model:param name="value" value='CODE'></model:param>
					<model:param name="text" value='NAME'></model:param>
					<model:param name="includeCode" value='01,02,03'></model:param>
				</model:params>
			</model:dataset>
			<!-- 分类施保类别 -->
			<model:dataset id="samAssistanceItemList" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true">
				<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
				<model:params>
					<model:param name="dic" value='SAM_ASSISTANCE_ITEM'></model:param>
					<model:param name="value" value='ITEM_CODE'></model:param>
					<model:param name="text" value='ITEM_NAME'></model:param>
				</model:params>
			</model:dataset>
			<!-- 主要致贫原因 -->
			<model:dataset id="provertyCause" enumName="SAM_CITY_PROVERTY_CAUSE"
				autoLoad="true" global="true"></model:dataset>
			<!-- 分类施保类别 -->
			<model:dataset id="asisstanceClassDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true">
				<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
				<model:params>
					<model:param name="dic" value='SAM_ASSISTANCE_CLASS'></model:param>
					<model:param name="value" value='ASSISTANCE_CLASS_CODE'></model:param>
					<model:param name="text" value='ASSISTANCE_CLASS_NAME'></model:param>
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
			<!-- 分类施保类别 -->
			<model:dataset id="asisstanceClassDataset1" cmd="com.inspur.cams.comm.dicm.DicQueryCmd"  autoLoad="true">
				<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
				<model:params>
					<model:param name="dic" value='SAM_ASSISTANCE_CLASS'></model:param>
					<model:param name="value" value='ASSISTANCE_CLASS_CODE'></model:param>
					<model:param name="text" value='ASSISTANCE_CLASS_NAME'></model:param>
					<model:param name="ASSISTANCE_TYPE" value="01" />
				</model:params>
			</model:dataset>
		<model:dataset id="assistanceModeDataset" enumName="SAM_ASSISTANCE_MODE" autoLoad="true" global="true"></model:dataset>
	
	
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
						<td class="FieldLabel" nowrap="nowrap" width="8%">地区</td>
						<td class="FieldInput" width="25%"><input type="text"
							id="domicileName" name="domicileName" readonly="readonly"
							style="width: 180px" /><img
							src="<%=SkinUtils.getImage(request, "l5/help.gif")%>"
							style="cursor: hand" onclick="func_ForDomicileSelect()" /> <input
							type="text" id="domicileCode" name="domicileCode"
							style="display: none" /></td>
						<td class="FieldLabel" nowrap="nowrap" width="8%">低保证号</td>
						<td class="FieldInput" width="25%"><input id="cardNo"
							name="cardNo" style="width: 180px" /></td>
						<td class="FieldLabel" nowrap="nowrap" width="8%">户主姓名</td>
						<td class="FieldInput" width="25%"><input type="text"
							name="familyName" id="familyName" style="width: 180px" /></td>
					</tr>
					<tr>
						<td class="FieldLabel" nowrap="nowrap" width="8%">身份证号码</td>
						<td class="FieldInput" width="25%"><input type="text"
							name="familyCardNo" id="familyCardNo" style="width: 180px"  onchange="checkIDCard(this)"/></td>
						<td class="FieldLabel" nowrap="nowrap" width="8%">家庭人口数</td>
						<td class="FieldInput" width="25%"><input type="text"
							id="sPeopleNum" name="sPeopleNum" style="width: 52px" />
						&nbsp;～&nbsp; <input type="text" id="ePeopleNum" name="ePeopleNum"
							style="width: 52px" /></td>
						<td class="FieldLabel" nowrap="nowrap" width="8%">主要致贫原因</td>
						<td class="FieldInput" width="25%"><select name="povertyCause"
							id="povertyCause" style="width: 180px">
							<option dataset="provertyCause"></option>
						</select></td>
					</tr>
					<tr>
						<td class="FieldLabel" nowrap="nowrap" width="8%">救助对象类型</td>
						<td class="FieldInput" width="25%"><select disabled
							id="assistanceType_treatment" style="width: 180px">
							<option dataset="AssistanceDataset"></option>
						</select></td>
						<td class="FieldLabel" nowrap="nowrap">分类施保类别</td>
						<td class="FieldInput"><select name="assistanceClass"
							id="assistanceClass" style="width: 180px">
							<option dataset="<%if("00000000".equals(organArea.substring(4, 12))){
							%>samAssistanceItemList<%
							}else{%>asisstanceClassDataset<%}%>"></option>
						</select></td>
						<td class="FieldLabel" nowrap="nowrap" width="8%">享受年月</td>
						<td class="FieldInput" width="25%"><input type="text" id="assistanceBegin" name="assistanceBegin" readonly="readonly" onclick="setmonth(this)" style = "padding-right:20px;background:url('<%= SkinUtils.getImage(request, "default/rl.gif ") %> ') no-repeat scroll right center transparent; "/></td>
					</tr>
					<tr>
						<td class="FieldLabel" nowrap="nowrap" width="8%">保障人口数</td>
						<td class="FieldInput" width="25%"><input type="text"
							id="sAssitancePeopleNum" name="保障人口数起" style="width: 52px" />
						&nbsp;～&nbsp; <input type="text" id="eAssitancePeopleNum" name="保障人口数止"
							style="width: 52px" /></td>
						<td class="FieldLabel" nowrap="nowrap" width="8%">户月保障金</td>
						<td class="FieldInput" width="25%" colspan="3"><input type="text"
							id="assistanceMoneyStart" name="assistanceMoneyStart" style="width: 52px" />
						&nbsp;～&nbsp; <input type="text" id="assistanceMoneyEnd" name="assistanceMoneyEnd"
							style="width: 52px" /></td>
					</tr>
					<tr>
				    	<td class="FieldLabel" width="8%">家庭类型</td>
						<td class="FieldInput" colspan="3">
					    	<input type="text" id='assistanceTypeName' style="width:85%" readOnly="true" />
							<img src="<%=SkinUtils.getImage(request, "l5/help.gif")%>" style="cursor:hand" onclick="openTypeWin()"/>
							<input type="hidden" id='assistanceType'>
						</td>
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
		<next:GridPanel id="infoQueryGrid" name="baseinfoFamilyResource"
			stripeRows="true" height="100%" width="100%" dataset="baseinfoFamilyDS" clickToSelectedForChkSM="true">
			<next:TopBar>
				<next:ToolBarItem id="qrToolbar" text="农村低保家庭查询信息"></next:ToolBarItem>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem text="导出CSV" iconCls="chart"
					handler="exportExcel"></next:ToolBarItem>
			</next:TopBar>
			<next:Columns>
				<next:RowNumberColumn width="30"/>
				<next:Column header="地区" field="DOMICILE_NAME" width="200"
					align="center">
					<next:TextField />
				</next:Column>
				
				<next:Column header="家庭主键" field="FAMILY_ARCHIVE_ID" width="50"
					align="center" hidden="true">
					<next:TextField />
				</next:Column>
				
				<next:Column header="户主姓名" field="FAMILY_NAME" width="80"
					align="center" renderer="detailHref">
					<next:TextField />
				</next:Column>
				<next:Column header="身份证号" field="FAMILY_CARD_NO" width="135"
					align="center">
					<next:TextField />
				</next:Column>
				<next:Column header="低保证号" field="CARD_NO" width="130" align="center">
					<next:TextField />
				</next:Column>
				<next:Column header="主要致贫原因" field="POVERTY_CAUSE" width="100"
					align="left" dataset="provertyCause">
					<next:TextField />
				</next:Column>
				<next:Column header="家庭人口数" field="PEOPLE_NUM" width="90"
					align="right">
					<next:TextField />
				</next:Column>
				<next:Column header="保障人口数" field="ASSISTANCE_PEOPLE_NUM" width="90"
					align="right">
					<next:TextField />
				</next:Column>
				<next:Column header="救助金计算方式" field="ASSISTANCE_MODE" width="120"
					align="center" dataset="assistanceModeDataset">
					<next:TextField />
				</next:Column>
				<next:Column header="保障金额（元）" field="ASSISTANCE_MONEY" width="100"
					align="right" renderer="formatNum">
					<next:TextField />
				</next:Column>
				<next:Column header="分类施保类别" field="ASSISTANCE_CLASS" width="100" dataset="asisstanceClassDataset1"
					align="center" >
					<next:TextField />
				</next:Column>
				<next:Column header="分类施保金（元）" field="ASSISTANCE_CLASS_MONEY" width="100"
					align="right" renderer="formatNum">
					<next:TextField />
				</next:Column>
				<next:Column header="起始保障年月" field="BEGIN_DATE" width="100"
					align="center">
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
			</next:Columns>
			<next:BottomBar>
				<next:PagingToolBar dataset="baseinfoFamilyDS" />
			</next:BottomBar>
		</next:GridPanel>

<jsp:include page="../comm/assistanceType.jsp" flush="true">
	<jsp:param name= "assistanceType" value= "02"/> 
</jsp:include>					
	</body>
</html>