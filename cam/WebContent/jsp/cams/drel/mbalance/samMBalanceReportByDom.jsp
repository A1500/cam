<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>一站式结算住院结算按救助对象属地、时间段查询条件统计报表</title>
<next:ScriptManager />
<script type="text/javascript">
   var struId='<%=BspUtil.getStruId()%>';
	var organCode='<%=BspUtil.getCorpOrgan().getOrganCode()%>'
	var organId='<%=BspUtil.getCorpOrgan().getOrganId()%>';
	var organArea='<%=BspUtil.getCorpOrgan().getOrganCode()%>'
	var organName='<%=BspUtil.getCorpOrgan().getOrganName()%>'
</script>
<script type="text/javascript" src="samMBalanceReportByDom.js"></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="samMBalanceComm.js"></script>
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
	<!-- 一站式救助报表统计 -->
	<model:dataset id="reportDataset"
		cmd="com.inspur.cams.drel.mbalance.cmd.SamMBalanceQueryCmd"
		method="queryForReport">
		<model:record>
			<model:field name="domicileName" type="string" />
			<model:field name="DOMICILE_CODE" type="string" />
			<model:field name="SUMTOTALEXP" type="string" />
			<model:field name="SUMINSEXP" type="string" />
			<model:field name="SUMINSPAY" type="string" />
			<model:field name="SUMASSPAY" type="string" />
			<model:field name="SUMPERSONALPAY" type="string" />
			<model:field name="NUM" type="string" />
			<model:field name="ASSPERNUM" type="string" />
			<model:field name="TOTALEXPPERNUM" type="string" />
			<model:field name="PERSONALPAYPERNUM" type="string" />
			<model:field name="INSEXPPERNUM" type="string" />
			<model:field name="ASSPAYPERTOTALEXP" type="string" />
			<model:field name="PERSONALPAYPERBASE" type="string" />
			<model:field name="ILLNESS_INSURANCE_PAY" type="string" />
			<model:field name="HOSPITAL_PAY" type="string" />
		</model:record>
	</model:dataset>
</model:datasets>

<next:Panel name="form" width="99.9%" border="0"
	bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true">
	<next:Html>
		<fieldset style="overflow: visible;" class="GroupBox"><legend
			class="GroupBoxTitle">查询条件 <img class="GroupBoxExpandButton"
			src="<%=SkinUtils.getImage(request,
									"groupbox_collapse.gif")%>"
			onclick="collapse(this)" /> </legend>
		<div>
		<form style="width: 100%; height: 100%;" class="L5form">
		<table border="1" width="100%">
			<tr>
				<td class="FieldLabel" style="width: 23%"><label>救助对象属地：</label></td>
				<td class="FieldInput" width="10%"><input type="text" onclick="forCityHelp(this.id)"
					id="qapanage" /></td>
				<td style="display:none;"><input type="text" id="qapanageCode" /></td>
				<td class="FieldLabel" width="10%" nowrap="nowrap">救助（补助）日期：</td>
				<td class="FieldInput" nowrap="nowrap" width="40%"><input type="text"
					id="beginTime" format="Y-m-d" name="beginTime" style="width: 35%" 
					onclick="LoushangDate(this)" readonly="readonly" /> ----- <input
					type="text" id="endTime" format="Y-m-d" name="endTime" style="width: 35%" 
					onclick="LoushangDate(this)" readonly="readonly" /></td>
				<td class="FieldButton" width="10%">
				<button onclick="query()" width="10%">查 询</button></td>
				<td class="FieldButton" width="10%">
				<button type="reset">重 置</button>
			</tr>
		</table>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="sammedicalbalanceGrid"
	width="99.9%" stripeRows="true" height="100%" dataset="reportDataset"
	title="住院结算报表">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem id="inHosRegButton" iconCls="detail" text="查看明细"
			handler="lookDetail" />
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="20" />
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="domicileCode" header="救助对象属地" field="domicileName"
			width="90">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column hidden="true" id="domicileCode" header="救助对象属地" field="HOSPITAL_AREA"
			width="90">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="sumTotalExp" header="住院总费用（元）" field="SUMTOTALEXP" align="right" 
			width="18%">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="sumInsExp" header="纳入保险报销费用（元）" field="SUMINSEXP" align="right" 
			width="25%">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="sumInsPay" header="保险支付金额（元）" field="SUMINSPAY" align="right" 
			width="18%">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="illnessInsurancePay" header="商业保险金额（元）" field="ILLNESS_INSURANCE_PAY"  align="right" 
			width="18%">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="hospitalPay" header="医院减免金额（元）" field="HOSPITAL_PAY"  align="right" 
			width="18%">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="sumAssPay" header="医疗救助金额（元）" field="SUMASSPAY" align="right" 
			width="18%">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="sumPersonalPay" header="自付费用（元）" field="SUMPERSONALPAY" align="right" 
			width="15%">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="num" header="人次" field="NUM" width="7%">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="assPerNum" header="人均救助费用（元）" field="ASSPERNUM" align="right" 
			width="18%">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="totalExpPerNum" header="人均住院费用（元）" align="right" 
			field="TOTALEXPPERNUM" width="18%">
			<next:TextField />
		</next:Column>

		<next:Column id="personalPayPerNum" header="人均自付费用（元）" align="right" 
			field="PERSONALPAYPERNUM" width="18%">
			<next:TextField />
		</next:Column>
		<next:Column id="insExpPerNum" header="人均保险报销费用（元）" field="INSEXPPERNUM" align="right" 
			width="25%">
			<next:TextField />
		</next:Column>

		<next:Column id="assPayPerTotalExp" header="医疗救助金额占住院总费用比例" renderer="getPercent"
			field="ASSPAYPERTOTALEXP" width="33%">
			<next:TextField />
		</next:Column>

		<next:Column id="personalPayPerNum" header="医疗救助金额占救助基数比例" renderer="getPercent"
			field="PERSONALPAYPERBASE" width="33%">
			<next:TextField />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="reportDataset" />
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
