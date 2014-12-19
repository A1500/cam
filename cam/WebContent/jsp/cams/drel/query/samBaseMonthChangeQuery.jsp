<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.*"%>
<html>
	<head>
		<title>低保、五保新增、减少户数情况查询</title>
		<next:ScriptManager />
		<script type="text/javascript" src="samBaseMonthChangeQuery.js"></script>
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
		<!-- 基础信息_家庭信息 -->
			<model:dataset id="baseinfoFamilyDS"
				cmd="com.inspur.cams.drel.sam.cmd.BaseinfoFamilyQueryCmd"
				method="queryBaseChange" pageSize="20">
			</model:dataset>
		<!-- 主要致贫原因 -->
			<model:dataset id="provertyCause" enumName="SAM_CITY_PROVERTY_CAUSE"
				autoLoad="true" global="true"></model:dataset>
		<!-- 属别 -->
		<model:dataset id="belongingDataSet" enumName="SAM_BELONGING" autoLoad="true" global="true">
		</model:dataset>
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
						<td class="FieldInput" width="25%" >
							<button id="queryId" onclick="query()" align="right">查 询</button>
						</td>	
					</tr>
					<tr>
						<td class="FieldLabel" nowrap="nowrap" width="8%">统计时间</td>
						<td class="FieldInput" width="35%">
							 <input type="text" id="startMonth" format="Y-m" onclick="setmonth(this)" style = "padding-right:20px;background:url('<%= SkinUtils.getImage(request, "default/rl.gif ") %> ') no-repeat scroll right center transparent; "/>
							     
							     
		                     至<input type="text" id="endMonth" format="Y-m" onclick="setmonth(this)" style = "padding-right:20px;background:url('<%= SkinUtils.getImage(request, "default/rl.gif ") %> ') no-repeat scroll right center transparent; "/>
		                     
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
			stripeRows="true" height="100%" width="100%" dataset="baseinfoFamilyDS" clickToSelectedForChkSM="true">
			<next:TopBar>
				<next:ToolBarItem id="qrToolbar" text="低保、五保基本情况变动查询信息"></next:ToolBarItem>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem text="导出CSV" iconCls="chart"
					handler="exportExcel"></next:ToolBarItem>
			</next:TopBar>
			<next:Columns>
	    		<next:RowNumberColumn width="30"/>
				<next:Column header="地区" field="DOMICILE_FULL_NAME" width="200"
					align="center">
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
					align="right" dataset="provertyCause">
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
				<next:Column header="保障金额（元）" field="ASSISTANCE_MONEY" width="100"
					align="right" renderer="formatNum">
					<next:TextField />
				</next:Column>
				<next:Column header="属别" field="BELONGING" dataset="belongingDataSet" width="100" align="center">
					<next:TextField />
				</next:Column>
				<next:Column header="起始保障年月" field="BEGIN_DATE" width="100"
					align="center">
					<next:TextField />
				</next:Column>
			</next:Columns>
			<next:BottomBar>
				<next:PagingToolBar dataset="baseinfoFamilyDS" />
			</next:BottomBar>
		</next:GridPanel>		
	</body>
</html>