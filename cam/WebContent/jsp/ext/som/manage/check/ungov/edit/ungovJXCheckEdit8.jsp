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
	var somJxCheckBalanceSheetDataSet = L5.DatasetMgr.lookup("somJxCheckBalanceSheetDataSet");
	somJxCheckBalanceSheetDataSet.setParameter("TASK_CODE@=", taskCode);
	somJxCheckBalanceSheetDataSet.load();
	somJxCheckBalanceSheetDataSet.on("load",function(ds){
		if(ds.getCount()==0){
			somJxCheckBalanceSheetDataSet.newRecord();
		}
	});
	//创建页面导航下拉框
	createUngovEditSelect();
}
function save(){
	var somJxCheckBalanceSheetDataSetIsValidate = somJxCheckBalanceSheetDataSet.isValidate();
	if(somJxCheckBalanceSheetDataSetIsValidate!=true){
		L5.Msg.alert("提示",somJxCheckBalanceSheetDataSetIsValidate);
		return "break";
	}
	var JxCheckBalanceSheetRecord=somJxCheckBalanceSheetDataSet.getCurrent();
	//if(JxCheckBalanceSheetRecord.get('assetsSumS') != JxCheckBalanceSheetRecord.get('debtAssetsSumS')){
		//L5.Msg.alert("提示","资产总计的年初数与负债和净资产总计的年初数不相等，请核对！");
		//return "break";
	//}
	if(JxCheckBalanceSheetRecord.get('assetsSumE') != JxCheckBalanceSheetRecord.get('debtAssetsSumE')){
		L5.Msg.alert("提示","资产总计的期末数与负债和净资产总计的期末数不相等，请核对！");
		return "break";
	}
	var command = new L5.Command("com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckCommand");
	command.setParameter("JxCheckBalanceSheetRecord", JxCheckBalanceSheetRecord);
	command.setParameter("taskCode", taskCode);
	command.execute("savePage8");
	if (!command.error) {
		alert("保存成功！");
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
function setSumMoney(){
	somJxCheckBalanceSheetDataSet.set("caSumS",(setParseFloat("货币资金")+setParseFloat("短期投资")+setParseFloat("应收款项")+setParseFloat("预付账款")+setParseFloat("存货")+setParseFloat("待摊费用")+setParseFloat("一年内到期的长期债权投资")+setParseFloat("其他流动资产")).toFixed(6)*1);
	somJxCheckBalanceSheetDataSet.set("caSumE",(setParseFloat("_货币资金")+setParseFloat("_短期投资")+setParseFloat("_应收款项")+setParseFloat("_预付账款")+setParseFloat("_存货")+setParseFloat("_待摊费用")+setParseFloat("_一年内到期的长期债权投资")+setParseFloat("_其他流动资产")).toFixed(6)*1);
	somJxCheckBalanceSheetDataSet.set("piSumS",(setParseFloat("长期股权投资")+setParseFloat("长期债权投资")).toFixed(6)*1);
	somJxCheckBalanceSheetDataSet.set("piSumE",(setParseFloat("_长期股权投资")+setParseFloat("_长期债权投资")).toFixed(6)*1);
	somJxCheckBalanceSheetDataSet.set("faNetValueS",(setParseFloat("固定资产原价")-setParseFloat("减：累计折旧")).toFixed(6)*1);
	somJxCheckBalanceSheetDataSet.set("faNetValueE",(setParseFloat("_固定资产原价")-setParseFloat("_减：累计折旧")).toFixed(6)*1);
	somJxCheckBalanceSheetDataSet.set("faSumS",(setParseFloat("固定资产原价")-setParseFloat("减：累计折旧")+setParseFloat("在建工程")+setParseFloat("文物文化资产")+setParseFloat("固定资产清理")).toFixed(6)*1);
	somJxCheckBalanceSheetDataSet.set("faSumE",(setParseFloat("_固定资产原价")-setParseFloat("_减：累计折旧")+setParseFloat("_在建工程")+setParseFloat("_文物文化资产")+setParseFloat("_固定资产清理")).toFixed(6)*1);

	somJxCheckBalanceSheetDataSet.set("assetsSumS",(getParseFloat(somJxCheckBalanceSheetDataSet.get("caSumS"))+getParseFloat(somJxCheckBalanceSheetDataSet.get("piSumS"))+getParseFloat(somJxCheckBalanceSheetDataSet.get("faSumS"))+setParseFloat("无形资产")+setParseFloat("受托代理资产")).toFixed(6)*1);
	somJxCheckBalanceSheetDataSet.set("assetsSumE",(getParseFloat(somJxCheckBalanceSheetDataSet.get("caSumE"))+getParseFloat(somJxCheckBalanceSheetDataSet.get("piSumE"))+getParseFloat(somJxCheckBalanceSheetDataSet.get("faSumE"))+setParseFloat("_无形资产")+setParseFloat("_受托代理资产")).toFixed(6)*1);

	somJxCheckBalanceSheetDataSet.set("clSumS",(setParseFloat("短期借款")+setParseFloat("应付款项")+setParseFloat("应付工资")+setParseFloat("应交税金")+setParseFloat("预收账款")+setParseFloat("预提费用")+setParseFloat("预计负债")+setParseFloat("一年内到期的长期负债")+setParseFloat("其他流动负债")).toFixed(6)*1);
	somJxCheckBalanceSheetDataSet.set("clSumE",(setParseFloat("_短期借款")+setParseFloat("_应付款项")+setParseFloat("_应付工资")+setParseFloat("_应交税金")+setParseFloat("_预收账款")+setParseFloat("_预提费用")+setParseFloat("_预计负债")+setParseFloat("_一年内到期的长期负债")+setParseFloat("_其他流动负债")).toFixed(6)*1);
	somJxCheckBalanceSheetDataSet.set("llSumS",(setParseFloat("长期借款")+setParseFloat("长期应付款")+setParseFloat("其他长期负债")).toFixed(6)*1);
	somJxCheckBalanceSheetDataSet.set("llSumE",(setParseFloat("_长期借款")+setParseFloat("_长期应付款")+setParseFloat("_其他长期负债")).toFixed(6)*1);
	somJxCheckBalanceSheetDataSet.set("paSumS",(getParseFloat(somJxCheckBalanceSheetDataSet.get("clSumS"))+getParseFloat(somJxCheckBalanceSheetDataSet.get("llSumS"))+setParseFloat("受托代理负债")).toFixed(6)*1);
	somJxCheckBalanceSheetDataSet.set("paSumE",(getParseFloat(somJxCheckBalanceSheetDataSet.get("clSumE"))+getParseFloat(somJxCheckBalanceSheetDataSet.get("llSumE"))+setParseFloat("_受托代理负债")).toFixed(6)*1);

	somJxCheckBalanceSheetDataSet.set("netAssetsSumS",(setParseFloat("非限定性净资产")+setParseFloat("限定性净资产")).toFixed(6)*1);
	somJxCheckBalanceSheetDataSet.set("netAssetsSumE",(setParseFloat("_非限定性净资产")+setParseFloat("_限定性净资产")).toFixed(6)*1);
	somJxCheckBalanceSheetDataSet.set("debtAssetsSumS",(getParseFloat(somJxCheckBalanceSheetDataSet.get("paSumS"))+getParseFloat(somJxCheckBalanceSheetDataSet.get("netAssetsSumS"))).toFixed(6)*1);
	somJxCheckBalanceSheetDataSet.set("debtAssetsSumE",(getParseFloat(somJxCheckBalanceSheetDataSet.get("paSumE"))+getParseFloat(somJxCheckBalanceSheetDataSet.get("netAssetsSumE"))).toFixed(6)*1);
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
</head>

<body>
<model:datasets>
	<model:dataset id="somJxCheckBalanceSheetDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxcheckbalancesheet.cmd.SomJxCheckBalanceSheetQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxcheckbalancesheet.dao.SomJxCheckBalanceSheet">
			<model:field name="caMoneyfundsE" type="string" rule="require" />
			<model:field name="clShorttermBorrowingE" type="string" rule="require" />
			<model:field name="caLiquidInvestmentE" type="string" rule="require" />
			<model:field name="clDuesE" type="string" rule="require" />
			<model:field name="caReceivablesE" type="string" rule="require" />
			<model:field name="clAccruedPayrollsE" type="string" rule="require" />
			<model:field name="caAdvanceMoneyE" type="string" rule="require" />
			<model:field name="clTasPayableE" type="string" rule="require" />
			<model:field name="caInventoryE" type="string" rule="require" />
			<model:field name="clDepositReceivedE" type="string" rule="require" />
			<model:field name="caDeferredExpensesE" type="string" rule="require" />
			<model:field name="clAccruedExpensesE" type="string" rule="require" />
			<model:field name="caDebtInvestmentsE" type="string" rule="require" />
			<model:field name="clAccruedLiabilitiesE" type="string" rule="require" />
			<model:field name="caOthersE" type="string" rule="require" />
			<model:field name="clLongtermDueE" type="string" rule="require" />
			<model:field name="clOthersE" type="string" rule="require" />
			<model:field name="piLongtermEquityInvE" type="string" rule="require" />
			<model:field name="piLongtermDebtInvE" type="string" rule="require" />
			<model:field name="llLongtermLoansE" type="string" rule="require" />
			<model:field name="llLongtermPayableE" type="string" rule="require" />
			<model:field name="llOthersE" type="string" rule="require" />
			<model:field name="faPrimeCostE" type="string" rule="require" />
			<model:field name="faAccumulatedDepreciationE" type="string" rule="require" />
			<model:field name="paDebtE" type="string" rule="require" />
			<model:field name="faConstructionInProcessE" type="string" rule="require" />
			<model:field name="faCulturalHeritageE" type="string" rule="require" />
			<model:field name="faDisposalFixedAssetsE" type="string" rule="require" />
			<model:field name="intangibleAssetsE" type="string" rule="require" />
			<model:field name="unlimitNetAssetsE" type="string" rule="require" />
			<model:field name="limitNetAssetsE" type="string" rule="require" />
			<model:field name="entrustedAgentAssetsE" type="string" rule="require" />
		</model:record>
	</model:dataset>
</model:datasets>
<div id="float">
	<input type="button" value="上一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="lastPageM('7')"/>
	<input type="button" value="下一页" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="nextPageM('9')"/>
	<input type="button" value="保存" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="save();"/>
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:320px;" onclick="backM();"/>
</div>
<div align=center>
<div style="width:800;text-align:center">
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal align=left
	style='text-align: left; text-indent: 32.15pt; mso-char-indent-count: 2.0; tab-stops: 248.15pt'><b
	style='mso-bidi-font-weight: normal'><span
	style='font-size: 16.0pt; font-family: 黑体; mso-hansi-font-family: 宋体; color: black'>七、财务报表<span
	lang=EN-US> <o:p></o:p></span></span></b></p>

<p class=MsoNormal align=center
	style='text-align: center; line-height: 24.0pt; mso-line-height-rule: exactly'><b
	style='mso-bidi-font-weight: normal'><span lang=EN-US
	style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>1.</span></b><b
	style='mso-bidi-font-weight: normal'><span
	style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>资产负债表<span
	lang=EN-US><o:p></o:p></span></span></b></p>

<p class=MsoNormal align=center
	style='text-align: center; line-height: 24.0pt; mso-line-height-rule: exactly'><b
	style='mso-bidi-font-weight: normal'><span lang=EN-US
	style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
	style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></b><span
	style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>单位：

	<span style="color:red;font-size: 15.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋">元</span>

	<span lang=EN-US><o:p></o:p></span></span></p>
<div align=center>
<form method="post" dataset="somJxCheckBalanceSheetDataSet" onsubmit="return false">
<table class=MsoNormalTable border=0 cellspacing=0 cellpadding=0
	style='border-collapse: collapse; mso-padding-alt: 0cm 1.5pt 0cm 1.5pt; mso-border-insideh: .75pt solid black; mso-border-insidev: .75pt solid black'>
	<tr style='mso-yfti-irow: 0; mso-yfti-firstrow: yes; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid windowtext 1.5pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>资<span
			lang=EN-US><span style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;
		</span></span>产<span lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>行次<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>年初数<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: windowtext 1.5pt; mso-border-left-alt: black .75pt; mso-border-bottom-alt: black .75pt; mso-border-right-alt: windowtext 1.5pt; mso-border-style-alt: solid; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>期末数<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-top-alt: windowtext 1.5pt; mso-border-left-alt: windowtext 1.5pt; mso-border-bottom-alt: black .75pt; mso-border-right-alt: black .75pt; mso-border-style-alt: solid; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>负债和净资产<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>行次<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>年初数<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid black 1.0pt; border-right: none; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid windowtext 1.5pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>期末数<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 1; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>流动资产：<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>流动负债：<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 2; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>货币资金<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>1<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="caMoneyfundsS" id="货币资金" name='"货币资金"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "
       />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="caMoneyfundsE" id="_货币资金" name='"_货币资金"' style="width: 98%; "
				  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
		</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>短期借款<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>61<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="clShorttermBorrowingS" id="短期借款" name='"短期借款"' style="width: 98%; text-align: right"
				 maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="clShorttermBorrowingE" id="_短期借款" name='"_短期借款"' style="width: 98%; "
				 maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
		</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 3; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>短期投资<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>2<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="caLiquidInvestmentS" id="短期投资" name='"短期投资"' style="width: 98%; "
				 maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="caLiquidInvestmentE" id="_短期投资" name='"_短期投资"' style="width: 98%; "
				 maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
		</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>应付款项<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>62<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="clDuesS" id="应付款项" name='"应付款项"' style="width: 98%; "
				 maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="clDuesE" id="_应付款项" name='"_应付款项"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 4; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>应收款项<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>3<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="caReceivablesS" id="应收款项" name='"应收款项"' style="width: 98%; "
				 maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="caReceivablesE" id="_应收款项" name='"_应收款项"' style="width: 98%; "
				 maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
		</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>应付工资<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>63<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="clAccruedPayrollsS" id="应付工资" name='"应付工资"' style="width: 98%; "
				 maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="clAccruedPayrollsE" id="_应付工资" name='"_应付工资"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 5; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='text-indent: 14.0pt; mso-char-indent-count: 1.0; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>预付账款<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>4<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="caAdvanceMoneyS" id="预付账款" name='"预付账款"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="caAdvanceMoneyE" id="_预付账款" name='"_预付账款"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>应交税金<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>65<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="clTasPayableS" id="应交税金" name='"应交税金"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="clTasPayableE" id="_应交税金" name='"_应交税金"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 6; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>存<span
			lang=EN-US><span style='mso-spacerun: yes'>&nbsp; </span></span>货<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>8<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="caInventoryS" id="存货" name='"存货"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="caInventoryE" id="_存货" name='"_存货"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='text-indent: 14.0pt; mso-char-indent-count: 1.0; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>预收账款<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>66<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="clDepositReceivedS" id="预收账款" name='"预收账款"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="clDepositReceivedE" id="_预收账款" name='"_预收账款"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 7; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>待摊费用<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>9<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="caDeferredExpensesS" id="待摊费用" name='"待摊费用"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="caDeferredExpensesE" id="_待摊费用" name='"_待摊费用"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='text-indent: 14.0pt; mso-char-indent-count: 1.0; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>预提费用<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>71<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="clAccruedExpensesS" id="预提费用" name='"预提费用"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="clAccruedExpensesE" id="_预提费用" name='"_预提费用"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 8; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>一年内到期的长期债权投资<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>15<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="caDebtInvestmentsS" id="一年内到期的长期债权投资" name='"一年内到期的长期债权投资"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="caDebtInvestmentsE" id="_一年内到期的长期债权投资" name='"_一年内到期的长期债权投资"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='text-indent: 14.0pt; mso-char-indent-count: 1.0; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>预计负债<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>72<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="clAccruedLiabilitiesS" id="预计负债" name='"预计负债"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="clAccruedLiabilitiesE" id="_预计负债" name='"_预计负债"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 9; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>其他流动资产<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>18<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="caOthersS" id="其他流动资产" name='"其他流动资产"' style="width: 98%; "
			maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "	 />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="caOthersE" id="_其他流动资产" name='"_其他流动资产"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>一年内到期的长期负债<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>74<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="clLongtermDueS" id="一年内到期的长期负债" name='"一年内到期的长期负债"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="clLongtermDueE" id="_一年内到期的长期负债" name='"_一年内到期的长期负债"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 10; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>流动资产合计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>20<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="caSumS" id="流动资产合计" name='"流动资产合计"' style="width: 98%; " readonly="readonly"
				maxlength="15" style='text-align:right;padding-right:2px;' ></label>
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="caSumE" id="_流动资产合计" name='"_流动资产合计"' style="width: 98%; " readonly="readonly"
				maxlength="15" style='text-align:right;padding-right:2px;' ></label>
		</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>其他流动负债<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>78<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="clOthersS" id="其他流动负债" name='"其他流动负债"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="clOthersE" id="_其他流动负债" name='"_其他流动负债"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 11; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='text-indent: 28.0pt; mso-char-indent-count: 2.0; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>流动负债合计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>80<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="clSumS" id="流动负债合计" name='"流动负债合计"' style="width: 98%; " readonly="readonly"
				maxlength="15" style='text-align:right;padding-right:2px;'  ></label>
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="clSumE" id="_流动负债合计" name='"_流动负债合计"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' readonly="readonly" ></label>
		</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 12; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>长期投资：<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='text-indent: 28.0pt; mso-char-indent-count: 2.0; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 13; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>长期股权投资<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>21<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="piLongtermEquityInvS" id="长期股权投资" name='"长期股权投资"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="piLongtermEquityInvE" id="_长期股权投资" name='"_长期股权投资"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>长期负债：<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 14; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>长期债权投资<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>24<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="piLongtermDebtInvS" id="长期债权投资" name='"长期债权投资"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="piLongtermDebtInvE" id="_长期债权投资" name='"_长期债权投资"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>长期借款<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>81<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="llLongtermLoansS" id="长期借款" name='"长期借款"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="llLongtermLoansE" id="_长期借款" name='"_长期借款"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 15; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>长期投资合计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>30<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="piSumS" id="长期投资合计" name='"长期投资合计"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' readonly="readonly" ></label>
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="piSumE" id="_长期投资合计" name='"_长期投资合计"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' readonly="readonly" ></label>
		</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>长期应付款<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>84<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="llLongtermPayableS" id="长期应付款" name='"长期应付款"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="llLongtermPayableE" id="_长期应付款" name='"_长期应付款"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 16; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>其他长期负债<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>88<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="llOthersS" id="其他长期负债" name='"其他长期负债"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="llOthersE" id="_其他长期负债" name='"_其他长期负债"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 17; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>固定资产：<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='text-indent: 28.0pt; mso-char-indent-count: 2.0; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>长期负债合计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>90<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="llSumS" id="长期负债合计" name='"长期负债合计"' style="width: 98%; "
			maxlength="15" style='text-align:right;padding-right:2px;' readonly="readonly" ></label>
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="llSumE" id="_长期负债合计" name='"_长期负债合计"' style="width: 98%; "
			maxlength="15" style='text-align:right;padding-right:2px;' readonly="readonly" ></label>
		</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 18; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>固定资产原价<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>31<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="faPrimeCostS" id="固定资产原价" name='"固定资产原价"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="faPrimeCostE" id="_固定资产原价" name='"_固定资产原价"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='text-indent: 28.0pt; mso-char-indent-count: 2.0; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 19; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>减：累计折旧<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>32<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="faAccumulatedDepreciationS" id="减：累计折旧" name='"减：累计折旧"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="faAccumulatedDepreciationE" id="_减：累计折旧" name='"_减：累计折旧"' style="width: 98%; "
				maxmaxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>受托代理负债：<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 20; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>固定资产净值<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>33<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="faNetValueS" id="固定资产净值" name='"固定资产净值"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' ></label>
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="faNetValueE" id="_固定资产净值" name='"_固定资产净值"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' ></label>
		</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>受托代理负债<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>91<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="paDebtS" id="受托代理负债" name='"受托代理负债"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="paDebtE" id="_受托代理负债" name='"_受托代理负债"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 21; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>在建工程<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>34<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="faConstructionInProcessS" id="在建工程" name='"在建工程"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="faConstructionInProcessE" id="_在建工程" name='"_在建工程"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 22; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>文物文化资产<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>35<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="faCulturalHeritageS" id="文物文化资产" name='"文物文化资产"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="faCulturalHeritageE" id="_文物文化资产" name='"_文物文化资产"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>负债合计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>100<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="paSumS" id="负债合计" name='"负债合计"' style="width: 98%; "
			maxlength="15" style='text-align:right;padding-right:2px;' readonly="readonly" ></label>
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="paSumE" id="_负债合计" name='"_负债合计"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' readonly="readonly" ></label>
		</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 23; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>固定资产清理<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>38<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="faDisposalFixedAssetsS" id="固定资产清理" name='"固定资产清理"' style="width: 98%; "
			maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "	 />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="faDisposalFixedAssetsE" id="_固定资产清理" name='"_固定资产清理"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 24; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>固定资产合计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>40<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="faSumS" id="固定资产合计" name='"固定资产合计"' style="width: 98%; "
			maxlength="15" style='text-align:right;padding-right:2px;' readonly="readonly"	 ></label>
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="faSumE" id="_固定资产合计" name='"_固定资产合计"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' readonly="readonly"></label>
		</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 25; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 26; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>无形资产：<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 27; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>无形资产<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>41<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="intangibleAssetsS" id="无形资产" name='"无形资产"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="intangibleAssetsE" id="_无形资产" name='"_无形资产"' style="width: 98%; "
			maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "	 />
		</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>净资产：<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 28; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>非限定性净资产<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>101<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="unlimitNetAssetsS" id="非限定性净资产" name='"非限定性净资产"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="unlimitNetAssetsE" id="_非限定性净资产" name='"_非限定性净资产"' style="width: 98%; "
			maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "	 />
		</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 29; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>受托代理资产：<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>限定性净资产<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>105<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="limitNetAssetsS" id="限定性净资产" name='"限定性净资产"' style="width: 98%; "
			maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "	 />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="limitNetAssetsE" id="_限定性净资产" name='"_限定性净资产"' style="width: 98%; "
			maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "	 />
		</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 30; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>受托代理资产<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>51<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="entrustedAgentAssetsS" id="受托代理资产" name='"受托代理资产"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="entrustedAgentAssetsE" id="_受托代理资产" name='"_受托代理资产"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>净资产合计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>110<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="netAssetsSumS" id="净资产合计" name='"净资产合计"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' readonly="readonly" ></label>
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="netAssetsSumE" id="_净资产合计" name='"_净资产合计"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' readonly="readonly" ></label>
		</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 31; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 32; mso-yfti-lastrow: yes; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid windowtext 1.5pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>资产总计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-bottom-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>60<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-bottom-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="assetsSumS" id="资产总计" name='"资产总计"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' readonly="readonly" ></label>
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="assetsSumE" id="_资产总计" name='"_资产总计"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' readonly="readonly" ></label>
		</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-top-alt: black .75pt; mso-border-left-alt: windowtext 1.5pt; mso-border-bottom-alt: windowtext 1.5pt; mso-border-right-alt: black .75pt; mso-border-style-alt: solid; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>负债和净资产总计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-bottom-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>120<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-bottom-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="debtAssetsSumS" id="负债和净资产总计" name='"负债和净资产总计"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' readonly="readonly" ></label>
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="debtAssetsSumE" id="_负债和净资产总计" name='"_负债和净资产总计"' style="width: 98%; "
				maxlength="15" style='text-align:right;padding-right:2px;' readonly="readonly" ></label>
		</o:p></span></p>
		</td>
	</tr>
</table>
</form>
</div>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</div>
</div>
</body>
</html>
