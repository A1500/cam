<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
 
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<next:ScriptManager />
<script type="text/javascript" src="../../js/float.js"></script>
<link href="../../css/float.css" type="text/css" rel="stylesheet" />
<script language="javascript">
var taskCode='<%=request.getParameter("taskCode")%>';
	//初始化
function init(){
	var somCheckBalanceSheetDataSet = L5.DatasetMgr.lookup("somCheckBalanceSheetDataSet");
	somCheckBalanceSheetDataSet.setParameter("TASK_CODE@=", taskCode);
	somCheckBalanceSheetDataSet.load();
	somCheckBalanceSheetDataSet.on('load',function(){
		var count = somCheckBalanceSheetDataSet.getCount();
		if(count == 0){
			somCheckBalanceSheetDataSet.newRecord({"taskCode":taskCode});
		}
		somCheckDataSet.setParameter("TASK_CODE", taskCode);
		somCheckDataSet.load();
		somCheckDataSet.on("load",function(){
			somCheckBalanceSheetDataSet.set("organizationUnit",somCheckDataSet.get("cnName"));
		});
	});
	//创建页面导航下拉框
	createGroupEditSelect();
}
function save(){
	var somCheckBalanceSheetDataSetIsValidate = somCheckBalanceSheetDataSet.isValidate();
	if(somCheckBalanceSheetDataSetIsValidate!=true){
		L5.Msg.alert("提示",somCheckBalanceSheetDataSetIsValidate);
		return "break";
	}
	var somCheckBalanceSheetRecord=somCheckBalanceSheetDataSet.getCurrent();
	if(somCheckBalanceSheetRecord.get('assetsSumS') != somCheckBalanceSheetRecord.get('debtAssetsSumS')){
		L5.Msg.alert("提示","资产总计的年初数与负债和净资产总计的年初数不相等，请核对！");
		return "break";
	}
	if(somCheckBalanceSheetRecord.get('assetsSumE') != somCheckBalanceSheetRecord.get('debtAssetsSumE')){
		L5.Msg.alert("提示","资产总计的年初数与负债和净资产总计的期末数不相等，请核对！");
		return "break";
	}
	var somCheckBalanceSheetRecord=somCheckBalanceSheetDataSet.getCurrent();
	var command = new L5.Command("com.inspur.cams.sorg.check.somcheck.cmd.SomCheckCommand");
	command.setParameter("somCheckBalanceSheetRecord", somCheckBalanceSheetRecord);
	command.setParameter("taskCode", taskCode);
	command.execute("savePage5");
	if (!command.error) {
		alert("保存成功！");
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
function saveNoCheck(){
	var somCheckBalanceSheetRecord=somCheckBalanceSheetDataSet.getCurrent();
	var command = new L5.Command("com.inspur.cams.sorg.check.somcheck.cmd.SomCheckCommand");
	command.setParameter("somCheckBalanceSheetRecord", somCheckBalanceSheetRecord);
	command.setParameter("taskCode", taskCode);
	command.execute("savePage5");
	if (!command.error) {
		alert("保存成功！");
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
function setSumMoney(){
	somCheckBalanceSheetDataSet.set("caSumS",(setParseFloat("货币资金")+setParseFloat("短期投资")+setParseFloat("应收款项")+setParseFloat("预付账款")+setParseFloat("存货")+setParseFloat("待摊费用")+setParseFloat("一年内到期的长期债权投资")+setParseFloat("其他流动资产")).toFixed(2)*1);
	somCheckBalanceSheetDataSet.set("caSumE",(setParseFloat("_货币资金")+setParseFloat("_短期投资")+setParseFloat("_应收款项")+setParseFloat("_预付账款")+setParseFloat("_存货")+setParseFloat("_待摊费用")+setParseFloat("_一年内到期的长期债权投资")+setParseFloat("_其他流动资产")).toFixed(2)*1);
	somCheckBalanceSheetDataSet.set("piSumS",(setParseFloat("长期股权投资")+setParseFloat("长期债权投资")).toFixed(2)*1);
	somCheckBalanceSheetDataSet.set("piSumE",(setParseFloat("_长期股权投资")+setParseFloat("_长期债权投资")).toFixed(2)*1);
	somCheckBalanceSheetDataSet.set("faSumS",(setParseFloat("固定资产原价")-setParseFloat("减：累计折旧")+setParseFloat("固定资产净值")+setParseFloat("在建工程")+setParseFloat("文物文化资产")+setParseFloat("固定资产清理")).toFixed(2)*1);
	somCheckBalanceSheetDataSet.set("faSumE",(setParseFloat("_固定资产原价")-setParseFloat("_减：累计折旧")+setParseFloat("_固定资产净值")+setParseFloat("_在建工程")+setParseFloat("_文物文化资产")+setParseFloat("_固定资产清理")).toFixed(2)*1);
	
	somCheckBalanceSheetDataSet.set("assetsSumS",(getParseFloat(somCheckBalanceSheetDataSet.get("caSumS"))+getParseFloat(somCheckBalanceSheetDataSet.get("piSumS"))+getParseFloat(somCheckBalanceSheetDataSet.get("faSumS"))+setParseFloat("无形资产")+setParseFloat("受托代理资产")).toFixed(2)*1);
	somCheckBalanceSheetDataSet.set("assetsSumE",(getParseFloat(somCheckBalanceSheetDataSet.get("caSumE"))+getParseFloat(somCheckBalanceSheetDataSet.get("piSumE"))+getParseFloat(somCheckBalanceSheetDataSet.get("faSumE"))+setParseFloat("_无形资产")+setParseFloat("_受托代理资产")).toFixed(2)*1);
	
	somCheckBalanceSheetDataSet.set("faNetValueS",(setParseFloat("固定资产原价")-setParseFloat("减：累计折旧")).toFixed(6)*1);
	somCheckBalanceSheetDataSet.set("faNetValueE",(setParseFloat("_固定资产原价")-setParseFloat("_减：累计折旧")).toFixed(6)*1);
	
	somCheckBalanceSheetDataSet.set("clSumS",(setParseFloat("短期借款")+setParseFloat("应付款项")+setParseFloat("应付工资")+setParseFloat("应交税金")+setParseFloat("预收账款")+setParseFloat("预提费用")+setParseFloat("预计负债")+setParseFloat("一年内到期的长期负债")+setParseFloat("其他流动负债")).toFixed(2)*1);
	somCheckBalanceSheetDataSet.set("clSumE",(setParseFloat("_短期借款")+setParseFloat("_应付款项")+setParseFloat("_应付工资")+setParseFloat("_应交税金")+setParseFloat("_预收账款")+setParseFloat("_预提费用")+setParseFloat("_预计负债")+setParseFloat("_一年内到期的长期负债")+setParseFloat("_其他流动负债")).toFixed(2)*1);	
	somCheckBalanceSheetDataSet.set("llSumS",(setParseFloat("长期借款")+setParseFloat("长期应付款")+setParseFloat("其他长期负债")).toFixed(2)*1);
	somCheckBalanceSheetDataSet.set("llSumE",(setParseFloat("_长期借款")+setParseFloat("_长期应付款")+setParseFloat("_其他长期负债")).toFixed(2)*1);
	somCheckBalanceSheetDataSet.set("paSumS",(getParseFloat(somCheckBalanceSheetDataSet.get("clSumS"))+getParseFloat(somCheckBalanceSheetDataSet.get("llSumS"))+setParseFloat("受托代理负债")).toFixed(2)*1);
	somCheckBalanceSheetDataSet.set("paSumE",(getParseFloat(somCheckBalanceSheetDataSet.get("clSumE"))+getParseFloat(somCheckBalanceSheetDataSet.get("llSumE"))+setParseFloat("_受托代理负债")).toFixed(2)*1);
	
	somCheckBalanceSheetDataSet.set("netAssetsSumS",(setParseFloat("非限定性净资产")+setParseFloat("限定性净资产")).toFixed(2)*1);
	somCheckBalanceSheetDataSet.set("netAssetsSumE",(setParseFloat("_非限定性净资产")+setParseFloat("_限定性净资产")).toFixed(2)*1);
	somCheckBalanceSheetDataSet.set("debtAssetsSumS",(getParseFloat(somCheckBalanceSheetDataSet.get("paSumS"))+getParseFloat(somCheckBalanceSheetDataSet.get("netAssetsSumS"))).toFixed(2)*1);
	somCheckBalanceSheetDataSet.set("debtAssetsSumE",(getParseFloat(somCheckBalanceSheetDataSet.get("paSumE"))+getParseFloat(somCheckBalanceSheetDataSet.get("netAssetsSumE"))).toFixed(2)*1);
}
function setParseFloat(id){
	var value = document.getElementById(id).value;
	if(!value){
		return 0;
	}else{
		return parseFloat(value);
	}
}
function getParseFloat(value){
	if(!value){
		return 0;
	}else{
		return parseFloat(value);
	}
}
</script>
<style>
label {
	text-align:right;
	font-size: 13px;
	font-family: 宋体;
}
</style>
</head>

<body>
<model:datasets>
	<model:dataset id="somCheckBalanceSheetDataSet" cmd="com.inspur.cams.sorg.check.balancesheet.cmd.SomCheckBalanceSheetQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.balancesheet.data.SomCheckBalanceSheet">
			<model:field name="organizationUnit" type="string" rule="require" />
			<model:field name="caMoneyfundsS" type="string" rule="require" />
			<model:field name="caMoneyfundsE" type="string" rule="require" />
			<model:field name="clShorttermBorrowingS" type="string" rule="require" />
			<model:field name="clShorttermBorrowingE" type="string" rule="require" />
			<model:field name="caLiquidInvestmentS" type="string" rule="require" />
			<model:field name="caLiquidInvestmentE" type="string" rule="require" />
			<model:field name="clDuesS" type="string" rule="require" />
			<model:field name="clDuesE" type="string" rule="require" />
			<model:field name="caReceivablesS" type="string" rule="require" />
			<model:field name="caReceivablesE" type="string" rule="require" />
			<model:field name="clAccruedPayrollsS" type="string" rule="require" />
			<model:field name="clAccruedPayrollsE" type="string" rule="require" />
			<model:field name="caAdvanceMoneyS" type="string" rule="require" />
			<model:field name="caAdvanceMoneyE" type="string" rule="require" />
			<model:field name="clTasPayableS" type="string" rule="require" />
			<model:field name="clTasPayableE" type="string" rule="require" />
			<model:field name="caInventoryS" type="string" rule="require" />
			<model:field name="caInventoryE" type="string" rule="require" />
			<model:field name="clDepositReceivedS" type="string" rule="require" />
			<model:field name="clDepositReceivedE" type="string" rule="require" />
			<model:field name="caDeferredExpensesS" type="string" rule="require" />
			<model:field name="caDeferredExpensesE" type="string" rule="require" />
			<model:field name="clAccruedExpensesS" type="string" rule="require" />
			<model:field name="clAccruedExpensesE" type="string" rule="require" />
			<model:field name="caDebtInvestmentsS" type="string" rule="require" />
			<model:field name="caDebtInvestmentsE" type="string" rule="require" />
			<model:field name="clAccruedLiabilitiesS" type="string" rule="require" />
			<model:field name="clAccruedLiabilitiesE" type="string" rule="require" />
			<model:field name="caOthersS" type="string" rule="require" />
			<model:field name="caOthersE" type="string" rule="require" />
			<model:field name="clLongtermDueS" type="string" rule="require" />
			<model:field name="clLongtermDueE" type="string" rule="require" />
			<model:field name="caSumS" type="string" rule="require" />
			<model:field name="caSumE" type="string" rule="require" />
			<model:field name="clOthersS" type="string" rule="require" />
			<model:field name="clOthersE" type="string" rule="require" />
			<model:field name="clSumS" type="string" rule="require" />
			<model:field name="clSumE" type="string" rule="require" />
			<model:field name="piLongtermEquityInvS" type="string" rule="require" />
			<model:field name="piLongtermEquityInvE" type="string" rule="require" />
			<model:field name="piLongtermDebtInvS" type="string" rule="require" />
			<model:field name="piLongtermDebtInvE" type="string" rule="require" />
			<model:field name="llLongtermLoansS" type="string" rule="require" />
			<model:field name="llLongtermLoansE" type="string" rule="require" />
			<model:field name="piSumS" type="string" rule="require" />
			<model:field name="piSumE" type="string" rule="require" />
			<model:field name="llLongtermPayableS" type="string" rule="require" />
			<model:field name="llLongtermPayableE" type="string" rule="require" />
			<model:field name="llOthersS" type="string" rule="require" />
			<model:field name="llOthersE" type="string" rule="require" />
			<model:field name="llSumS" type="string" rule="require" />
			<model:field name="llSumE" type="string" rule="require" />
			<model:field name="faPrimeCostS" type="string" rule="require" />
			<model:field name="faPrimeCostE" type="string" rule="require" />
			<model:field name="faAccumulatedDepreciationS" type="string" rule="require" />
			<model:field name="faAccumulatedDepreciationE" type="string" rule="require" />
			<model:field name="faNetValueS" type="string" rule="require" />
			<model:field name="faNetValueE" type="string" rule="require" />
			<model:field name="paDebtS" type="string" rule="require" />
			<model:field name="paDebtE" type="string" rule="require" />
			<model:field name="faConstructionInProcessS" type="string" rule="require" />
			<model:field name="faConstructionInProcessE" type="string" rule="require" />
			<model:field name="faCulturalHeritageS" type="string" rule="require" />
			<model:field name="faCulturalHeritageE" type="string" rule="require" />
			<model:field name="paSumS" type="string" rule="require" />
			<model:field name="paSumE" type="string" rule="require" />
			<model:field name="faDisposalFixedAssetsS" type="string" rule="require" />
			<model:field name="faDisposalFixedAssetsE" type="string" rule="require" />
			<model:field name="faSumS" type="string" rule="require" />
			<model:field name="faSumE" type="string" rule="require" />
			<model:field name="intangibleAssetsS" type="string" rule="require" />
			<model:field name="intangibleAssetsE" type="string" rule="require" />
			<model:field name="unlimitNetAssetsS" type="string" rule="require" />
			<model:field name="unlimitNetAssetsE" type="string" rule="require" />
			<model:field name="limitNetAssetsS" type="string" rule="require" />
			<model:field name="limitNetAssetsE" type="string" rule="require" />
			<model:field name="entrustedAgentAssetsS" type="string" rule="require" />
			<model:field name="entrustedAgentAssetsE" type="string" rule="require" />
			<model:field name="netAssetsSumS" type="string" rule="require" />
			<model:field name="netAssetsSumE" type="string" rule="require" />
			<model:field name="assetsSumS" type="string" rule="require" />
			<model:field name="assetsSumE" type="string" rule="require" />
			<model:field name="debtAssetsSumS" type="string" rule="require" />
			<model:field name="debtAssetsSumE" type="string" rule="require" />
		</model:record>
	</model:dataset>
	<model:dataset id="somCheckDataSet" cmd="com.inspur.cams.sorg.check.somcheck.cmd.SomCheckQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.somcheck.data.SomCheck">
		</model:record>
	</model:dataset>
</model:datasets>
<div id="float"><!--[if lte IE 7]><div></div><![endif]--> 
<input
	type="button" value="上一页"
	style="height: 25px; width: 80px; position: absolute; margin-left: 20px;" onclick="lastPage('4')"/>
<input
	type="button" value="下一页"
	style="height: 25px; width: 80px; position: absolute; margin-left: 120px;" onclick="nextPage('6')"/>
<!--[if lte IE 7]><div></div><![endif]--> <input type="button"
	value="保存"
	style="height: 25px; width: 80px; position: absolute; margin-left: 220px;"
	onclick="saveNoCheck();" /> <!--[if lte IE 7]><div></div><![endif]--> <input
	type="button" value="返回"
	style="height: 25px; width: 80px; position: absolute; margin-left: 320px;"
	onclick="back();" />
	<!--[if lte IE 7]><div></div><![endif]-->
	<span style="height:25px;width:80px;position:absolute;margin-left:420px;">当前页数：7</span>
</div>
<div align=center width="800">
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal align=center
	style='margin-top: 7.8pt; mso-para-margin-top: .5gd; text-align: center; line-height: 20.0pt; mso-line-height-rule: exactly'><span
	style='font-size: 16.0pt; font-family: 黑体; mso-hansi-font-family: 宋体'>三、财务会计报告<span
	lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal align=center
	style='text-align: center; line-height: 20.0pt; mso-line-height-rule: exactly'><b
	style='mso-bidi-font-weight: normal'><span
	style='font-size: 16.0pt; font-family: 宋体; color: black'>（一）资产负债表<span
	lang=EN-US><o:p></o:p></span></span></b></p>

<p class=MsoNormal align=center
	style='text-align: center; line-height: 20.0pt; mso-line-height-rule: exactly'><span
	style='font-size: 14.0pt; font-family: 宋体; color: black'>（截止到本年度12月31日）<span
	lang=EN-US></span><span lang=EN-US></span><span lang=EN-US><o:p></o:p></span></span></p>
<div align=center width="800px">
<form method="post" dataset="somCheckBalanceSheetDataSet" onsubmit="return false">

<p style='margin: 0 auto; line-height: 20.0pt;'><span
	style='font-size: 14.0pt; font-family: 宋体; color: black'>编制单位： 
	<input type="text" name='编制单位' field="organizationUnit" style="width: 240" maxlength="250" /> 
	<span lang=EN-US><span
	style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></span>
单位：元<span lang=EN-US><o:p></o:p></span></span></p>

<table border=0 cellspacing=0 cellpadding=0 width="800"
	style='width: 800px; border-collapse: collapse; mso-yfti-tbllook: 191; mso-padding-alt: 0cm 1.5pt 0cm 1.5pt; mso-border-insideh: .75pt solid black; mso-border-insidev: .75pt solid black'>
	<tr style='height: 17.0pt'>
		<td width="25%" valign=middle
			style='width: 25.64%; border-top: windowtext 1.5pt; border-left: black 1.5pt; border-bottom: black 1.0pt; border-right: black 1.0pt; border-style: solid; mso-border-top-alt: windowtext 1.5pt; mso-border-left-alt: black 1.5pt; mso-border-bottom-alt: black .75pt; mso-border-right-alt: black .75pt; mso-border-style-alt: solid; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>资<span
			lang=EN-US><span style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;
		</span></span>产<span lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>年初数<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.58%; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: windowtext 1.5pt; mso-border-left-alt: black .75pt; mso-border-bottom-alt: black .75pt; mso-border-right-alt: windowtext 1.5pt; mso-border-style-alt: solid; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>期末数<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="27%" valign=middle
			style='width: 27.42%; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-top-alt: windowtext 1.5pt; mso-border-left-alt: windowtext 1.5pt; mso-border-bottom-alt: black .75pt; mso-border-right-alt: black .75pt; mso-border-style-alt: solid; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>负债和净资产<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>年初数<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.8%; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: windowtext 1.5pt; mso-border-left-alt: black .75pt; mso-border-bottom-alt: black .75pt; mso-border-right-alt: black 1.5pt; mso-border-style-alt: solid; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>期末数<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
	</tr>
	<tr style='height: 17.0pt'>
		<td width="25%" valign=middle
			style='width: 25.64%; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>流动资产：<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="27%" valign=middle
			style='width: 27.42%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>流动负债：<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 19.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='height: 17.0pt'>
		<td width="25%" valign=middle
			style='width: 25.64%; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>货币资金<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
		<input field="caMoneyfundsS" id="货币资金" name='"货币资金"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);' onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " 
       /></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
		 <input field="caMoneyfundsE" id="_货币资金" name='"_货币资金"' style="width: 98%; "
				  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</p>
		</td>
		<td width="27%" valign=middle
			style='width: 27.42%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>短期借款<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
		<input field="clShorttermBorrowingS" id="短期借款" name='"短期借款"' style="width: 98%; text-align: right"
				 maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 19.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
		 <input field="clShorttermBorrowingE" id="_短期借款" name='"_短期借款"' style="width: 98%; "
				 maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</p>
		</td>
	</tr>
	<tr style='height: 17.0pt'>
		<td width="25%" valign=middle
			style='width: 25.64%; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>短期投资<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
		<input field="caLiquidInvestmentS" id="短期投资" name='"短期投资"' style="width: 98%; "
				 maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
		<input field="caLiquidInvestmentE" id="_短期投资" name='"_短期投资"' style="width: 98%; "
				 maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</p>
		</td>
		<td width="27%" valign=middle
			style='width: 27.42%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>应付款项<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
		<input field="clDuesS" id="应付款项" name='"应付款项"' style="width: 98%; "
				 maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 19.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
		<input field="clDuesE" id="_应付款项" name='"_应付款项"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
			</p>
		</td>
	</tr>
	<tr style='height: 17.0pt'>
		<td width="25%" valign=middle
			style='width: 25.64%; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>应收款项<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
		<input field="caReceivablesS" id="应收款项" name='"应收款项"' style="width: 98%; "
				 maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
		<input field="caReceivablesE" id="_应收款项" name='"_应收款项"' style="width: 98%; "
				 maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</p>
		</td>
		<td width="27%" valign=middle
			style='width: 27.42%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>应付工资<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
		 <input field="clAccruedPayrollsS" id="应付工资" name='"应付工资"' style="width: 98%; "
				 maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 19.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
		 <input field="clAccruedPayrollsE" id="_应付工资" name='"_应付工资"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
			</p>
		</td>
	</tr>
	<tr style='height: 17.0pt'>
		<td width="25%" valign=middle
			style='width: 25.64%; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal
			style='text-indent: 12.0pt; mso-char-indent-count: 1.0; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>预付账款<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
		<input field="caAdvanceMoneyS" id="预付账款" name='"预付账款"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
			</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
		 <input field="caAdvanceMoneyE" id="_预付账款" name='"_预付账款"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
			</p>
		</td>
		<td width="27%" valign=middle
			style='width: 27.42%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>应交税金<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
		<input field="clTasPayableS" id="应交税金" name='"应交税金"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
			</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 19.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
		 <input field="clTasPayableE" id="_应交税金" name='"_应交税金"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
			</p>
		</td>
	</tr>
	<tr style='height: 17.0pt'>
		<td width="25%" valign=middle
			style='width: 25.64%; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>存<span
			lang=EN-US><span style='mso-spacerun: yes'>&nbsp; </span></span>货<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			 <input field="caInventoryS" id="存货" name='"存货"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input field="caInventoryE" id="_存货" name='"_存货"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</p>
		</td>
		<td width="27%" valign=middle
			style='width: 27.42%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal
			style='text-indent: 12.0pt; mso-char-indent-count: 1.0; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>预收账款<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input field="clDepositReceivedS" id="预收账款" name='"预收账款"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 19.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			 <input field="clDepositReceivedE" id="_预收账款" name='"_预收账款"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</p>
		</td>
	</tr>
	<tr style='height: 17.0pt'>
		<td width="25%" valign=middle
			style='width: 25.64%; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>待摊费用<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input field="caDeferredExpensesS" id="待摊费用" name='"待摊费用"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input field="caDeferredExpensesE" id="_待摊费用" name='"_待摊费用"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</p>
		</td>
		<td width="27%" valign=middle
			style='width: 27.42%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal
			style='text-indent: 12.0pt; mso-char-indent-count: 1.0; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>预提费用<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input field="clAccruedExpensesS" id="预提费用" name='"预提费用"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 19.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input field="clAccruedExpensesE" id="_预提费用" name='"_预提费用"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</p>
		</td>
	</tr>
	<tr style='height: 34.0pt'>
		<td width="25%" valign=middle
			style='width: 25.64%; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 34.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>一年内到期的长期债权投资<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 34.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input field="caDebtInvestmentsS" id="一年内到期的长期债权投资" name='"一年内到期的长期债权投资"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 34.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input field="caDebtInvestmentsE" id="_一年内到期的长期债权投资" name='"_一年内到期的长期债权投资"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</p>
		</td>
		<td width="27%" valign=middle
			style='width: 27.42%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 34.0pt'>
		<p class=MsoNormal
			style='text-indent: 12.0pt; mso-char-indent-count: 1.0; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>预计负债<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 34.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input field="clAccruedLiabilitiesS" id="预计负债" name='"预计负债"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 34.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input field="clAccruedLiabilitiesE" id="_预计负债" name='"_预计负债"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</p>
		</td>
	</tr>
	<tr style='height: 15.6pt'>
		<td width="25%" valign=middle
			style='width: 25.64%; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>其他流动资产<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input field="caOthersS" id="其他流动资产" name='"其他流动资产"' style="width: 98%; "
			maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() "	 />
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input field="caOthersE" id="_其他流动资产" name='"_其他流动资产"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</p>
		</td>
		<td width="27%" valign=middle
			style='width: 27.42%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>一年内到期的长期负债<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input field="clLongtermDueS" id="一年内到期的长期负债" name='"一年内到期的长期负债"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input field="clLongtermDueE" id="_一年内到期的长期负债" name='"_一年内到期的长期负债"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</p>
		</td>
	</tr>
	<tr style='height: 15.6pt'>
		<td width="25%" valign=middle
			style='width: 25.64%; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>流动资产合计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label field="caSumS" id="流动资产合计" name='"流动资产合计"' style="width: 98%; " readonly="readonly"
				maxlength="15" style='text-align:right;padding-right:2px;' ></label>
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label field="caSumE" id="_流动资产合计" name='"_流动资产合计"' style="width: 98%; " readonly="readonly"
				maxlength="15" style='text-align:right;padding-right:2px;' ></label>
		</p>
		</td>
		<td width="27%" valign=middle
			style='width: 27.42%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>其他流动负债<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input field="clOthersS" id="其他流动负债" name='"其他流动负债"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			 <input field="clOthersE" id="_其他流动负债" name='"_其他流动负债"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</p>
		</td>
	</tr>
	<tr style='height: 15.6pt'>
		<td width="25%" valign=middle
			style='width: 25.64%; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="27%" valign=middle
			style='width: 27.42%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='text-indent: 12.0pt; mso-char-indent-count: 1.0; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>流动负债合计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label field="clSumS" id="流动负债合计" name='"流动负债合计"' style="width: 98%; " readonly="readonly"
				maxlength="15" style='text-align:right;padding-right:2px;'  ></label>
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			 <label field="clSumE" id="_流动负债合计" name='"_流动负债合计"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' readonly="readonly" ></label>
		</p>
		</td>
	</tr>
	<tr style='height: 15.6pt'>
		<td width="25%" valign=middle
			style='width: 25.64%; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>长期投资：<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="27%" valign=middle
			style='width: 27.42%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='text-indent: 24.0pt; mso-char-indent-count: 2.0; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='height: 15.6pt'>
		<td width="25%" valign=middle
			style='width: 25.64%; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>长期股权投资<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input field="piLongtermEquityInvS" id="长期股权投资" name='"长期股权投资"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input field="piLongtermEquityInvE" id="_长期股权投资" name='"_长期股权投资"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</p>
		</td>
		<td width="27%" valign=middle
			style='width: 27.42%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>长期负债：<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='height: 15.6pt'>
		<td width="25%" valign=middle
			style='width: 25.64%; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>长期债权投资<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input field="piLongtermDebtInvS" id="长期债权投资" name='"长期债权投资"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			 <input field="piLongtermDebtInvE" id="_长期债权投资" name='"_长期债权投资"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</p>
		</td>
		<td width="27%" valign=middle
			style='width: 27.42%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>长期借款<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input field="llLongtermLoansS" id="长期借款" name='"长期借款"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input field="llLongtermLoansE" id="_长期借款" name='"_长期借款"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</p>
		</td>
	</tr>
	<tr style='height: 15.6pt'>
		<td width="25%" valign=middle
			style='width: 25.64%; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>长期投资合计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label field="piSumS" id="长期投资合计" name='"长期投资合计"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' readonly="readonly" ></label>
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label field="piSumE" id="_长期投资合计" name='"_长期投资合计"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' readonly="readonly" ></label>
		</p>
		</td>
		<td width="27%" valign=middle
			style='width: 27.42%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>长期应付款<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input field="llLongtermPayableS" id="长期应付款" name='"长期应付款"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input field="llLongtermPayableE" id="_长期应付款" name='"_长期应付款"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</p>
		</td>
	</tr>
	<tr style='height: 15.6pt'>
		<td width="25%" valign=middle
			style='width: 25.64%; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="27%" valign=middle
			style='width: 27.42%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>其他长期负债<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input field="llOthersS" id="其他长期负债" name='"其他长期负债"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input field="llOthersE" id="_其他长期负债" name='"_其他长期负债"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</p>
		</td>
	</tr>
	<tr style='height: 15.6pt'>
		<td width="25%" valign=middle
			style='width: 25.64%; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>固定资产：<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="27%" valign=middle
			style='width: 27.42%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='text-indent: 12.0pt; mso-char-indent-count: 1.0; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>长期负债合计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label field="llSumS" id="长期负债合计" name='"长期负债合计"' style="width: 98%; "
			maxlength="15" style='text-align:right;padding-right:2px;' readonly="readonly" ></label>
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label field="llSumE" id="_长期负债合计" name='"_长期负债合计"' style="width: 98%; "
			maxlength="15" style='text-align:right;padding-right:2px;' readonly="readonly" ></label>
		</p>
		</td>
	</tr>
	<tr style='height: 15.6pt'>
		<td width="25%" valign=middle
			style='width: 25.64%; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>固定资产原价<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input field="faPrimeCostS" id="固定资产原价" name='"固定资产原价"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			 <input field="faPrimeCostE" id="_固定资产原价" name='"_固定资产原价"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</p>
		</td>
		<td width="27%" valign=middle
			style='width: 27.42%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='text-indent: 24.0pt; mso-char-indent-count: 2.0; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='height: 15.6pt'>
		<td width="25%" valign=middle
			style='width: 25.64%; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>减：累计折旧<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			 <input field="faAccumulatedDepreciationS" id="减：累计折旧" name='"减：累计折旧"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input field="faAccumulatedDepreciationE" id="_减：累计折旧" name='"_减：累计折旧"' style="width: 98%; "
				maxmaxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</p>
		</td>
		<td width="27%" valign=middle
			style='width: 27.42%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='text-indent: 12.0pt; mso-char-indent-count: 1.0; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>受托代理负债：<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
		</p>
		</td>
	</tr>
	<tr style='height: 15.6pt'>
		<td width="25%" valign=middle
			style='width: 25.64%; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>固定资产净值<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label field="faNetValueS" id="固定资产净值" name='"固定资产净值"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " ></label>
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			 <label field="faNetValueE" id="_固定资产净值" name='"_固定资产净值"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " ></label>
		</p>
		</td>
		<td width="27%" valign=middle
			style='width: 27.42%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>受托代理负债<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input field="paDebtS" id="受托代理负债" name='"受托代理负债"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input field="paDebtE" id="_受托代理负债" name='"_受托代理负债"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</p>
		</td>
	</tr>
	<tr style='height: 15.6pt'>
		<td width="25%" valign=middle
			style='width: 25.64%; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>在建工程<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input field="faConstructionInProcessS" id="在建工程" name='"在建工程"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input field="faConstructionInProcessE" id="_在建工程" name='"_在建工程"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</p>
		</td>
		<td width="27%" valign=middle
			style='width: 27.42%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='height: 15.6pt'>
		<td width="25%" valign=middle
			style='width: 25.64%; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>文物文化资产<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input field="faCulturalHeritageS" id="文物文化资产" name='"文物文化资产"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input field="faCulturalHeritageE" id="_文物文化资产" name='"_文物文化资产"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</p>
		</td>
		<td width="27%" valign=middle
			style='width: 27.42%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>负债合计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label field="paSumS" id="负债合计" name='"负债合计"' style="width: 98%; "
			maxlength="15" style='text-align:right;padding-right:2px;' readonly="readonly" ></label>
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label field="paSumE" id="_负债合计" name='"_负债合计"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' readonly="readonly" ></label>
		</p>
		</td>
	</tr>
	<tr style='height: 15.6pt'>
		<td width="25%" valign=middle
			style='width: 25.64%; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>固定资产清理<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input field="faDisposalFixedAssetsS" id="固定资产清理" name='"固定资产清理"' style="width: 98%; "
			maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() "	 />
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input field="faDisposalFixedAssetsE" id="_固定资产清理" name='"_固定资产清理"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</p>
		</td>
		<td width="27%" valign=middle
			style='width: 27.42%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='height: 15.6pt'>
		<td width="25%" valign=middle
			style='width: 25.64%; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>固定资产合计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label field="faSumS" id="固定资产合计" name='"固定资产合计"' style="width: 98%; "
			maxlength="15" style='text-align:right;padding-right:2px;' readonly="readonly"	 ></label>
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label field="faSumE" id="_固定资产合计" name='"_固定资产合计"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' readonly="readonly"></label>
		</p>
		</td>
		<td width="27%" valign=middle
			style='width: 27.42%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='height: 15.6pt'>
		<td width="25%" valign=middle
			style='width: 25.64%; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="27%" valign=middle
			style='width: 27.42%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='height: 15.6pt'>
		<td width="25%" valign=middle
			style='width: 25.64%; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>无形资产：<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
		</p>
		</td>
		<td width="27%" valign=middle
			style='width: 27.42%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='height: 15.6pt'>
		<td width="25%" valign=middle
			style='width: 25.64%; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>无形资产<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input field="intangibleAssetsS" id="无形资产" name='"无形资产"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input field="intangibleAssetsE" id="_无形资产" name='"_无形资产"' style="width: 98%; "
			maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() "	 />
		</p>
		</td>
		<td width="27%" valign=middle
			style='width: 27.42%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>净资产：<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='height: 15.6pt'>
		<td width="25%" valign=middle
			style='width: 25.64%; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="27%" valign=middle
			style='width: 27.42%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>非限定性净资产<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input field="unlimitNetAssetsS" id="非限定性净资产" name='"非限定性净资产"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input field="unlimitNetAssetsE" id="_非限定性净资产" name='"_非限定性净资产"' style="width: 98%; "
			maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() "	 />
		</p>
		</td>
	</tr>
	<tr style='height: 15.6pt'>
		<td width="25%" valign=middle
			style='width: 25.64%; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 12.0pt; font-family: 宋体'>受托代理资产：<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="27%" valign=middle
			style='width: 27.42%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>限定性净资产<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input field="limitNetAssetsS" id="限定性净资产" name='"限定性净资产"' style="width: 98%; "
			maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() "	 />
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input field="limitNetAssetsE" id="_限定性净资产" name='"_限定性净资产"' style="width: 98%; "
			maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() "	 />
		</p>
		</td>
	</tr>
	<tr style='height: 15.6pt'>
		<td width="25%" valign=middle
			style='width: 25.64%; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体'>受托代理资产<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input field="entrustedAgentAssetsS" id="受托代理资产" name='"受托代理资产"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input field="entrustedAgentAssetsE" id="_受托代理资产" name='"_受托代理资产"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</p>
		</td>
		<td width="27%" valign=middle
			style='width: 27.42%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>净资产合计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label field="netAssetsSumS" id="净资产合计" name='"净资产合计"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' readonly="readonly" ></label>
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label field="netAssetsSumE" id="_净资产合计" name='"_净资产合计"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' readonly="readonly" ></label>
		</p>
		</td>
	</tr>
	<tr style='height: 15.6pt'>
		<td width="25%" valign=middle
			style='width: 25.64%; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="27%" valign=middle
			style='width: 27.42%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-lastrow: yes; height: 15.6pt'>
		<td width="25%" valign=middle
			style='width: 25.64%; border-top: none; border-left: solid black 1.5pt; border-bottom: solid windowtext 1.5pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: black .75pt; mso-border-left-alt: black 1.5pt; mso-border-bottom-alt: windowtext 1.5pt; mso-border-right-alt: black .75pt; mso-border-style-alt: solid; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>资产总计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-bottom-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label field="assetsSumS" id="资产总计" name='"资产总计"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' readonly="readonly" ></label>
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label field="assetsSumE" id="_资产总计" name='"_资产总计"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' readonly="readonly" ></label>
		</p>
		</td>
		<td width="27%" valign=middle
			style='width: 27.42%; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-top-alt: black .75pt; mso-border-left-alt: windowtext 1.5pt; mso-border-bottom-alt: windowtext 1.5pt; mso-border-right-alt: black .75pt; mso-border-style-alt: solid; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>负债和净资产总计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-bottom-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label field="debtAssetsSumS" id="负债和净资产总计" name='"负债和净资产总计"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' readonly="readonly" ></label>
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label field="debtAssetsSumE" id="_负债和净资产总计" name='"_负债和净资产总计"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' readonly="readonly" ></label>
		</p>
		</td>
	</tr>
</table>
</form>
</div>

<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>

</div>
</body>

</html>
