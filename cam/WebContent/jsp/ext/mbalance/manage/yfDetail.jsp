<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>一站式结算住院结算报表查询</title>
<next:ScriptManager />
<script type="text/javascript">
	 var bptType='<%=request.getParameter("bptType")%>';
	 var domicileCode='<%=request.getParameter("domicileCode")%>';
	 var hospitalId ='<%=request.getParameter("hospitalId")%>';
	 var currentJsp ='<%=request.getParameter("currentJsp")%>';
     var organCode   ='<%=request.getParameter("organCode")%>';
	 var beginTime  ='<%=request.getParameter("beginTime")%>';
	 var endTime ='<%=request.getParameter("endTime")%>';
	 var regId ='<%=request.getParameter("regId")%>';
</script>
<script type="text/javascript" src="yfDetail.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
</head>
<body>
<model:datasets>
	<!-- 一站式式救助信息 -->
	<model:dataset id="ds"
		cmd="com.inspur.cams.drel.mbalance.cmd.SamMBalanceQueryCmd"
		method="queryYfDetail" global="true">
		<model:record>
			<model:field name="bptName" type="string" />
			<model:field name="hospitalName" type="string" />
			<model:field name="domicileName" type="string" />
			<model:field name="NAME" type="string" />
			<model:field name="SEX" type="string" />
			<model:field name="BALANCE_TIME" type="string" />
			<model:field name="INSURANCE_EXPENSE" type="string" />
			<model:field name="INSURANCE_PAY" type="string" />
			<model:field name="HOSPITAL_PAY" type="string" />
			<model:field name="TOTAL_EXPENSE" type="string" />
			<model:field name="SPECIAL_PAY" type="string" />
			<model:field name="PERSONAL_PAY" type="string" />
			<model:field name="BPT_CARD_NO" type="string" />
		</model:record>
	</model:dataset>
	<!-- 一站式式救助信息 -->
	<model:dataset id="repordDataset"
		cmd="com.inspur.cams.drel.mbalance.cmd.SamMBalanceQueryCmd"
		method="queryYfDetail" global="true">
	</model:dataset>
	<!-- 性别 -->
	<model:dataset id="SexDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SEX'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 医疗保障方式 -->
	<model:dataset id="SafeguardDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_MEDICAL_STATUS'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 病种 -->
	<model:dataset id="diseaseDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_DISEASE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 救助类型 -->
	<model:dataset id="assitanceTypeDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_assitance_Type'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>

<next:GridPanel id="editGridPanel" name="sammedicalbalanceGrid"
	width="100%" stripeRows="true" height="100%" dataset="ds"
	title="住院结算报表">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="undo" text="返回" handler="back" />
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="20" />
		<next:Column id="peopleId" header="姓名" field="NAME" width="90">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="peopleId" header="性别" field="SEX" width="90">
			<next:ComboBox dataset="SexDataset" displayField="text"
				valueField="value" typeAhead="true" />
		</next:Column>
		<next:Column id="bptName" header="优抚对象类别" field="bptName" width="90">
			<next:TextField/>
		</next:Column>
		<next:Column id="cardNo" header="证件编号（优抚）" field="BPT_CARD_NO" width="15%">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="hospitalName" header="入住医院" field="hospitalName"  width="15%">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="domicileName" header="人员所在地" field="domicileName" width="90">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="balanceTime" header="结算日期" field="BALANCE_TIME" width="90">
			<next:TextField />
		</next:Column>
		<next:Column id="totalExpense" header="住院总费用（元）" field="TOTAL_EXPENSE"  align="right"  width="15%" renderer="formatNum">
			<next:TextField />
		</next:Column>
		<next:Column id="insuranceExpense" header="保内费用（元）" field="INSURANCE_EXPENSE"  align="right"  width="15%" renderer="formatNum">
			<next:TextField />
		</next:Column>
	
		<next:Column id="INSURENCE_PAY" header="保险机构支付费用（元）" field="INSURANCE_PAY"  align="right"  width="18%" renderer="formatNum">
			<next:TextField />
		</next:Column>
	
		<next:Column id="assitancePay" header="医疗救助费用（元）" field="SPECIAL_PAY"  align="right"  width="15%" renderer="formatNum">
			<next:TextField />
		</next:Column>
	
		<next:Column id="personalPay" header="个人支付费用（元）" field="PERSONAL_PAY"  align="right"  width="15%" renderer="formatNum">
			<next:TextField />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds" />
	</next:BottomBar>
</next:GridPanel>
</body>
</html>