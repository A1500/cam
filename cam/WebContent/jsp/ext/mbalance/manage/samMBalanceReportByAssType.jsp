<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="com.inspur.cams.comm.extuser.util.ExtBspInfo"%>
<html>
<head>
<title>一站式结算住院结算按医院、时间段查询条件统计报表</title>
<next:ScriptManager />
<script>
	var organCode='<%=ExtBspInfo.getUserInfo(request).getAreaCode()%>';
	var organId='<%=ExtBspInfo.getUserInfo(request).getOrganId()%>';
	var userId='<%=ExtBspInfo.getUserInfo(request).getUserId()%>';
</script>

<script type="text/javascript" src="samMBalanceReportByAssType.js"></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="samMBExtComm.js"></script>
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
	<!-- 一站式式救助报表统计 -->
	<model:dataset id="reportDataset"
		cmd="com.inspur.cams.drel.mbalance.cmd.SamMBalanceQueryCmd"
		method="queryForReport">
	</model:dataset>
	<!-- 医疗救助类型 -->
	<model:dataset id="assitanceTypeDataset" autoLoad="true"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_assitance_Type'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
			<model:param name="includeCode" value='01,02,03,11'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>

<next:Panel name="form" width="100%" border="0"
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
				<td class="FieldLabel" width="100">救助对象类别:</td>
				<td class="FieldInput" width="10%"><select id="assitanceType"
					name="assitanceType">
					<option dataset="assitanceTypeDataset"></option>
				</select></td>
				<td class="FieldLabel" width="150" nowrap="nowrap">救助（补助）日期：</td>
				<td class="FieldInput" nowrap="nowrap"><input type="text"
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
	width="100%" stripeRows="true" height="100%" dataset="reportDataset"
	title="统计结果列表">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem id="inHosRegButton" iconCls="detail" text="查看明细"
			handler="lookDetail" />
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="20" />
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="assitanceType" header="救助对象类别" field="ASSITANCE_TYPE" dataset="assitanceTypeDataset"
			width="90">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="sumTotalExp" header="住院总费用（元）" field="SUMTOTALEXP"  align="right" 
			width="18%">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="sumInsExp" header="纳入保险报销费用（元）" field="SUMINSEXP"  align="right" 
			width="25%">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="sumInsPay" header="保险支付金额（元）" field="SUMINSPAY"  align="right" 
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
		<next:Column id="sumAssPay" header="医疗救助金额（元）" field="SUMASSPAY"  align="right" 
			width="18%">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="sumPersonalPay" header="自付费用（元）" field="SUMPERSONALPAY"  align="right" 
			width="15%">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="num" header="人次" field="NUM" width="7%">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="assPerNum" header="人均救助费用（元）" field="ASSPERNUM"  align="right" 
			width="18%">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="totalExpPerNum" header="人均住院费用（元）"  align="right" 
			field="TOTALEXPPERNUM" width="18%">
			<next:TextField />
		</next:Column>

		<next:Column id="personalPayPerNum" header="人均自付费用（元）"  align="right" 
			field="PERSONALPAYPERNUM" width="18%">
			<next:TextField />
		</next:Column>
		<next:Column id="insExpPerNum" header="人均保险报销费用（元）" field="INSEXPPERNUM"  align="right" 
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
