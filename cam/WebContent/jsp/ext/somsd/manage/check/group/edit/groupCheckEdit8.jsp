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
	var somCheckCashFlowDataSet = L5.DatasetMgr.lookup("somCheckCashFlowDataSet");
	somCheckCashFlowDataSet.setParameter("TASK_CODE@=", taskCode);
	somCheckCashFlowDataSet.load();
	somCheckCashFlowDataSet.on('load',function(){
		var count = somCheckCashFlowDataSet.getCount();
		if(count == 0){
			somCheckCashFlowDataSet.newRecord({"taskCode":taskCode});
		}
	});
	somCheckCashFlowDataSet1.setParameter("TASK_CODE@=", taskCode);
	somCheckCashFlowDataSet1.load();
	somCheckCashFlowDataSet1.on('load',function(ds){
		var count = ds.getCount();
		if(count == 0){
			ds.newRecord({"taskCode":taskCode});
		}
	});
	//创建页面导航下拉框
	createGroupEditSelect();
}
function save(){
	var somCheckCashFlowDataSetIsValidate = somCheckCashFlowDataSet.isValidate();
	if(somCheckCashFlowDataSetIsValidate!=true){
		L5.Msg.alert("提示",somCheckCashFlowDataSetIsValidate);
		return "break";
	}
	var checkCashFlowRecord=somCheckCashFlowDataSet.getCurrent();
	/*checkCashFlowRecord.set("baInflowSum",document.getElementById('baInflowSum').innerHTML);
	checkCashFlowRecord.set("baOutflowSum",document.getElementById('baOutflowSum').innerHTML);
	checkCashFlowRecord.set("baNetAmount",document.getElementById('baNetAmount').innerHTML);*/
	
	checkCashFlowRecord.set("iaInflowSum",document.getElementById('iaInflowSum').innerHTML);
	checkCashFlowRecord.set("iaOutflowSum",document.getElementById('iaOutflowSum').innerHTML);
	checkCashFlowRecord.set("iaNetAmount",document.getElementById('iaNetAmount').innerHTML);
	
	checkCashFlowRecord.set("faInflowSum",document.getElementById('faInflowSum').innerHTML);
	checkCashFlowRecord.set("faOutflowSum",document.getElementById('faOutflowSum').innerHTML);
	checkCashFlowRecord.set("faNetAmount",document.getElementById('faNetAmount').innerHTML);
	
	checkCashFlowRecord.set("netRevalueation",document.getElementById('netRevalueation').innerHTML);
	var command = new L5.Command("com.inspur.cams.sorg.check.somcheck.cmd.SomCheckCommand");
	command.setParameter("checkCashFlowRecord", checkCashFlowRecord);
	command.setParameter("taskCode", taskCode);
	command.execute("savePage8");
	if (!command.error) {
		alert("保存成功！");
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
function saveNoCheck(){
	var checkCashFlowRecord=somCheckCashFlowDataSet.getCurrent();
	/*checkCashFlowRecord.set("baInflowSum",document.getElementById('baInflowSum').innerHTML);
	checkCashFlowRecord.set("baOutflowSum",document.getElementById('baOutflowSum').innerHTML);
	checkCashFlowRecord.set("baNetAmount",document.getElementById('baNetAmount').innerHTML);*/
	
	checkCashFlowRecord.set("iaInflowSum",document.getElementById('iaInflowSum').innerHTML);
	checkCashFlowRecord.set("iaOutflowSum",document.getElementById('iaOutflowSum').innerHTML);
	checkCashFlowRecord.set("iaNetAmount",document.getElementById('iaNetAmount').innerHTML);
	
	checkCashFlowRecord.set("faInflowSum",document.getElementById('faInflowSum').innerHTML);
	checkCashFlowRecord.set("faOutflowSum",document.getElementById('faOutflowSum').innerHTML);
	checkCashFlowRecord.set("faNetAmount",document.getElementById('faNetAmount').innerHTML);
	
	checkCashFlowRecord.set("netRevalueation",document.getElementById('netRevalueation').innerHTML);
	var command = new L5.Command("com.inspur.cams.sorg.check.somcheck.cmd.SomCheckCommand");
	command.setParameter("checkCashFlowRecord", checkCashFlowRecord);
	command.setParameter("taskCode", taskCode);
	command.execute("savePage8");
	if (!command.error) {
		alert("保存成功！");
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
function countBaInflowSum(){
	var baInflowSum0=document.getElementById('baInflowSum0').value;
	var baInflowSum1=document.getElementById('baInflowSum1').value;
	var baInflowSum2=document.getElementById('baInflowSum2').value;
	var baInflowSum3=document.getElementById('baInflowSum3').value;
	var baInflowSum4=document.getElementById('baInflowSum4').value;
	var baInflowSum5=document.getElementById('baInflowSum5').value;
	if(baInflowSum0==""){
		baInflowSum0=0;
	}
	if(baInflowSum1==""){
		baInflowSum1=0;
	}
	if(baInflowSum2==""){
		baInflowSum2=0;
	}
	if(baInflowSum3==""){
		baInflowSum3=0;
	}
	if(baInflowSum4==""){
		baInflowSum4=0;
	}
	if(baInflowSum5==""){
		baInflowSum5=0;
	}
	var num=parseFloat(baInflowSum0)+parseFloat(baInflowSum1)+parseFloat(baInflowSum2)+parseFloat(baInflowSum3)+parseFloat(baInflowSum4)+parseFloat(baInflowSum5);
	document.getElementById('baInflowSum').innerHTML =num.toFixed(2)*1;
	baNetAmountcount();
}
function countBaOutflowSum(){
	var baOutflowSum1=document.getElementById('baOutflowSum1').value;
	var baOutflowSum2=document.getElementById('baOutflowSum2').value;
	var baOutflowSum3=document.getElementById('baOutflowSum3').value;
	var baOutflowSum4=document.getElementById('baOutflowSum4').value;
	if(baOutflowSum1==""){
		baOutflowSum1=0;
	}
	if(baOutflowSum2==""){
		baOutflowSum2=0;
	}
	if(baOutflowSum3==""){
		baOutflowSum3=0;
	}
	if(baOutflowSum4==""){
		baOutflowSum4=0;
	}
	var num=parseFloat(baOutflowSum1)+parseFloat(baOutflowSum2)+parseFloat(baOutflowSum3)+parseFloat(baOutflowSum4);
	document.getElementById('baOutflowSum').innerHTML =num.toFixed(2)*1;
	baNetAmountcount();
}
function baNetAmountcount(){
	var baInflowSum=document.getElementById('baInflowSum').innerHTML;
	var baOutflowSum=document.getElementById('baOutflowSum').innerHTML;
	if(baInflowSum==""){
		baInflowSum=0;
	}
	if(baOutflowSum==""){
		baOutflowSum=0;
	}
	var num=parseFloat(baInflowSum)-parseFloat(baOutflowSum);
	document.getElementById('baNetAmount').innerHTML =num.toFixed(2)*1;
	netRevalueationcount();
}
function countIaInflowSum(){
	var iaInflowSum1=somCheckCashFlowDataSet1.get('iaRegoupingOutlay');
	var iaInflowSum2=somCheckCashFlowDataSet1.get('iaMadeIncome');
	var iaInflowSum3=document.getElementById('iaInflowSum3').value;
	var iaInflowSum4=document.getElementById('iaInflowSum4').value;
	if(iaInflowSum1==""){
		iaInflowSum1=0;
	}
	if(iaInflowSum2==""){
		iaInflowSum2=0;
	}
	if(iaInflowSum3==""){
		iaInflowSum3=0;
	}
	if(iaInflowSum4==""){
		iaInflowSum4=0;
	}
	var num=parseFloat(iaInflowSum1)+parseFloat(iaInflowSum2)+parseFloat(iaInflowSum3)+parseFloat(iaInflowSum4);
	document.getElementById('iaInflowSum').innerHTML =num.toFixed(2)*1;
	iaNetAmountcount();
}
function countIaOutflowSum(){
	var iaOutflowSum1=document.getElementById('iaOutflowSum1').value;
	var iaOutflowSum2=document.getElementById('iaOutflowSum2').value;
	var iaOutflowSum3=document.getElementById('iaOutflowSum3').value;
	if(iaOutflowSum1==""){
		iaOutflowSum1=0;
	}
	if(iaOutflowSum2==""){
		iaOutflowSum2=0;
	}
	if(iaOutflowSum3==""){
		iaOutflowSum3=0;
	}
	var num=parseFloat(iaOutflowSum1)+parseFloat(iaOutflowSum2)+parseFloat(iaOutflowSum3);
	document.getElementById('iaOutflowSum').innerHTML =num.toFixed(2)*1;
	iaNetAmountcount();
}
function iaNetAmountcount(){
	var iaInflowSum=document.getElementById('iaInflowSum').innerHTML;
	var iaOutflowSum=document.getElementById('iaOutflowSum').innerHTML;
	if(iaInflowSum==""){
		iaInflowSum=0;
	}
	if(iaOutflowSum==""){
		iaOutflowSum=0;
	}
	var num=parseFloat(iaInflowSum)-parseFloat(iaOutflowSum);
	document.getElementById('iaNetAmount').innerHTML =num.toFixed(2)*1;
	netRevalueationcount();
}

function countFaInflowSum(){
	var faInflowSum1=document.getElementById('faInflowSum1').value;
	var faInflowSum2=document.getElementById('faInflowSum2').value;
	if(faInflowSum1==""){
		faInflowSum1=0;
	}
	if(faInflowSum2==""){
		faInflowSum2=0;
	}
	var num=parseFloat(faInflowSum1)+parseFloat(faInflowSum2);
	document.getElementById('faInflowSum').innerHTML =num.toFixed(2)*1;
	faNetAmountcount();
}
function countfaOutflowSum(){
	var faOutflowSum1=document.getElementById('faOutflowSum1').value;
	var faOutflowSum2=document.getElementById('faOutflowSum2').value;
	var faOutflowSum3=document.getElementById('faOutflowSum3').value;
	if(faOutflowSum1==""){
		faOutflowSum1=0;
	}
	if(faOutflowSum2==""){
		faOutflowSum2=0;
	}
	if(faOutflowSum3==""){
		faOutflowSum3=0;
	}
	var num=parseFloat(faOutflowSum1)+parseFloat(faOutflowSum2)+parseFloat(faOutflowSum3);
	document.getElementById('faOutflowSum').innerHTML =num.toFixed(2)*1;
	faNetAmountcount();
}
function faNetAmountcount(){
	var faInflowSum=document.getElementById('faInflowSum').innerHTML;
	var faOutflowSum=document.getElementById('faOutflowSum').innerHTML;
	if(faInflowSum==""){
		faInflowSum=0;
	}
	if(faOutflowSum==""){
		faOutflowSum=0;
	}
	var num=parseFloat(faInflowSum)-parseFloat(faOutflowSum);
	document.getElementById('faNetAmount').innerHTML =num.toFixed(2)*1;
	netRevalueationcount();
}
function netRevalueationcount(){
	var baNetAmount = somCheckCashFlowDataSet1.get('baNetAmount');
	var iaNetAmount = document.getElementById('iaNetAmount').innerHTML;
	var faNetAmount = document.getElementById('faNetAmount').innerHTML;
	var exchangeRateMovement = document.getElementById('exchangeRateMovement').value;
	if(baNetAmount==""){
		baNetAmount=0;
	}
	if(iaNetAmount==""){
		iaNetAmount=0;
	}
	if(faNetAmount==""){
		faNetAmount=0;
	}
	if(exchangeRateMovement==""){
		exchangeRateMovement=0;
	}
	var num=parseFloat(baNetAmount)+parseFloat(iaNetAmount)+parseFloat(faNetAmount)+parseFloat(exchangeRateMovement);
	document.getElementById("netRevalueation").innerHTML = num.toFixed(2)*1;
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
	<model:dataset id="somCheckCashFlowDataSet" cmd="com.inspur.cams.sorg.check.checkcashflow.cmd.SomCheckCashFlowQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.checkcashflow.data.SomCheckCashFlow">
			<model:field name="iaInflowAssets" type="string" rule="require" />
			<model:field name="iaInflowOthers" type="string" rule="require" />
			<model:field name="iaOutflowAssets" type="string" rule="require" />
			<model:field name="iaOutflowAbroad" type="string" rule="require" />
			<model:field name="iaOutflowOthers" type="string" rule="require" />
			<model:field name="faInflowLoan" type="string" rule="require" />
			<model:field name="faInflowOthers" type="string" rule="require" />
			<model:field name="faOutflowDebt" type="string" rule="require" />
			<model:field name="faOutflowRatio" type="string" rule="require" />
			<model:field name="faOutflowOthers" type="string" rule="require" />			
			<model:field name="exchangeRateMovement" type="string" rule="require" />
		</model:record>
	</model:dataset>
	<model:dataset id="somCheckCashFlowDataSet1" cmd="com.inspur.cams.sorg.check.checkcashflow.cmd.SomCheckCashFlowQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.checkcashflow.data.SomCheckCashFlow"></model:record>
	</model:dataset>
</model:datasets>
<div id="float"><!--[if lte IE 7]><div></div><![endif]--> 
<input
	type="button" value="上一页"
	style="height: 25px; width: 80px; position: absolute; margin-left: 20px;"
	onclick="lastPage('7')" />
<input
	type="button" value="下一页"
	style="height: 25px; width: 80px; position: absolute; margin-left: 120px;" onclick="nextPage('9')"/>
<!--[if lte IE 7]><div></div><![endif]--> <input type="button"
	value="保存"
	style="height: 25px; width: 80px; position: absolute; margin-left: 220px;"
	onclick="saveNoCheck();" /> <!--[if lte IE 7]><div></div><![endif]--> <input
	type="button" value="返回"
	style="height: 25px; width: 80px; position: absolute; margin-left: 320px;"
	onclick="back();" />
	<!--[if lte IE 7]><div></div><![endif]-->
	<span style="height:25px;width:80px;position:absolute;margin-left:420px;">当前页数：10</span>
</div>
<div align=center>
<div align=center style="margin-top: 20px; width: 800px">
<form method="post" dataset="somCheckCashFlowDataSet" onsubmit="return false">
<table border=1 cellspacing=0 cellpadding=0 width="800" align=center
	style='width: 800px;border-collapse: collapse; border: none; mso-border-alt: solid windowtext 1.5pt; mso-padding-alt: 0cm 1.5pt 0cm 1.5pt; mso-border-insideh: .75pt solid windowtext; mso-border-insidev: .75pt solid windowtext'>
<tr style='height: 18.0pt'>
	<td width="66%" valign=middle
		style='width: 66.2%; border-top: solid windowtext 1.5pt; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal
		style='line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'><span
		style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
		style='font-size: 14.0pt; font-family: 宋体; color: black'>处置固定资产和无形资产所收回的现金<span
		lang=EN-US><o:p></o:p></span></span></p>
	</td>
	<td width="33%" valign=middle
		style='width: 33.8%; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal align=right
		style='text-align: right; line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'>
		 <input  onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');countIaInflowSum();"id="iaInflowSum3" field="iaInflowAssets" 
  name='"处置固定资产和无形资产所收回的现金"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' />
		</span></p>
	</td>
</tr>
<tr style='height: 18.0pt'>
	<td width="66%" valign=middle
		style='width: 66.2%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal
		style='line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'><span
		style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
		style='font-size: 14.0pt; font-family: 宋体; color: black'>收到的其他与投资活动有关的现金<span
		lang=EN-US><o:p></o:p></span></span></p>
	</td>
	<td width="33%" valign=middle
		style='width: 33.8%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal align=right
		style='text-align: right; line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'>
		<input  onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');countIaInflowSum();"id="iaInflowSum4" field="iaInflowOthers" 
  name='"收到的其他与投资活动有关的现金"' style="width:98%" maxlength="15" style='text-align:right;padding-right:2px;'  />
		</span></p>
	</td>
</tr>
<tr style='height: 18.0pt'>
	<td width="66%" valign=middle
		style='width: 66.2%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal
		style='line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'><span
		style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	</span></span><span style='font-size: 14.0pt; font-family: 宋体; color: black'>现金流入小计<span
		lang=EN-US><o:p></o:p></span></span></p>
	</td>
	<td width="33%" valign=middle
		style='width: 33.8%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal align=right
		style='text-align: right; line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'>
		<label id="iaInflowSum" field="iaInflowSum" name='"现金流入小计"'
style=''></label>
		</span></p>
	</td>
</tr>
<tr style='height: 18.0pt'>
	<td width="66%" valign=middle
		style='width: 66.2%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal
		style='line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'><span
		style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
		style='font-size: 14.0pt; font-family: 宋体; color: black'>购建固定资产和无形资产所支付的现金<span
		lang=EN-US><o:p></o:p></span></span></p>
	</td>
	<td width="33%" valign=middle
		style='width: 33.8%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal align=right
		style='text-align: right; line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'>
		<input  onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');countIaOutflowSum();" id="iaOutflowSum1" field="iaOutflowAssets" 
name='"购建固定资产和无形资产所支付的现金"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' />
		</span></p>
	</td>
</tr>
<tr style='height: 18.0pt'>
	<td width="66%" valign=middle
		style='width: 66.2%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal
		style='line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'><span
		style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
		style='font-size: 14.0pt; font-family: 宋体; color: black'>对外投资所支付的现金<span
		lang=EN-US><o:p></o:p></span></span></p>
	</td>
	<td width="33%" valign=middle
		style='width: 33.8%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal align=right
		style='text-align: right; line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'>
		<input  onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');countIaOutflowSum();" id="iaOutflowSum2" field="iaOutflowAbroad" 
			name='"对外投资所支付的现金"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' />
		</span></p>
	</td>
</tr>
<tr style='height: 18.0pt'>
	<td width="66%" valign=middle
		style='width: 66.2%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal
		style='line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'><span
		style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
		style='font-size: 14.0pt; font-family: 宋体; color: black'>支付的其他与投资活动有关的现金<span
		lang=EN-US><o:p></o:p></span></span></p>
	</td>
	<td width="33%" valign=middle
		style='width: 33.8%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal align=right
		style='text-align: right; line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'>
		<input  onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');countIaOutflowSum();"  id="iaOutflowSum3" field="iaOutflowOthers" 
			name='"支付的其他与投资活动有关的现金"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' />
		</span></p>
	</td>
</tr>
<tr style='height: 18.0pt'>
	<td width="66%" valign=middle
		style='width: 66.2%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal
		style='line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'><span
		style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	</span></span><span style='font-size: 14.0pt; font-family: 宋体; color: black'>现金流出小计<span
		lang=EN-US><o:p></o:p></span></span></p>
	</td>
	<td width="33%" valign=middle
		style='width: 33.8%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal align=right
		style='text-align: right; line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'>
		<label id="iaOutflowSum" field="iaOutflowSum" name='"现金流出小计"'
style=''></label>
		</span></p>
	</td>
</tr>
<tr style='height: 18.0pt'>
	<td width="66%" valign=middle
		style='width: 66.2%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal align=center
		style='text-align: center; line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		style='font-size: 14.0pt; font-family: 宋体; color: black'>投资活动产生的现金流量净额<span
		lang=EN-US><o:p></o:p></span></span></p>
	</td>
	<td width="33%" valign=middle
		style='width: 33.8%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal align=right
		style='text-align: right; line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'>
		<label id="iaNetAmount" field="iaNetAmount" name='"投资活动产生的现金流量净额"'
style=''></label>
		</span></p>
	</td>
</tr>
<tr style='height: 18.0pt'>
	<td width="66%" valign=middle
		style='width: 66.2%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal
		style='line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		style='font-size: 14.0pt; font-family: 宋体; color: black'>三、筹资活动产生的现金流量：<span
		lang=EN-US><o:p></o:p></span></span></p>
	</td>
	<td width="33%" valign=middle
		style='width: 33.8%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal align=right
		style='text-align: right; line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
	</td>
</tr>
<tr style='height: 18.0pt'>
	<td width="66%" valign=middle
		style='width: 66.2%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal
		style='line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'><span
		style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
		style='font-size: 14.0pt; font-family: 宋体; color: black'>借款所收到的现金<span
		lang=EN-US><o:p></o:p></span></span></p>
	</td>
	<td width="33%" valign=middle
		style='width: 33.8%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal align=right
		style='text-align: right; line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'>
		<input  onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');countFaInflowSum();"id="faInflowSum1" field="faInflowLoan" 
			name='"借款所收到的现金"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' />
		</span></p>
	</td>
</tr>
<tr style='height: 18.0pt'>
	<td width="66%" valign=middle
		style='width: 66.2%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal
		style='line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'><span
		style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
		style='font-size: 14.0pt; font-family: 宋体; color: black'>收到的其他与筹资活动有关的现金<span
		lang=EN-US><o:p></o:p></span></span></p>
	</td>
	<td width="33%" valign=middle
		style='width: 33.8%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal align=right
		style='text-align: right; line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'>
		<input  onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');countFaInflowSum();"id="faInflowSum2" field="faInflowOthers" 
			name='"收到的其他与筹资活动有关的现金"' style="width:98%" maxlength="15" style='text-align:right;padding-right:2px;'  />
		</span></p>
	</td>
</tr>
<tr style='height: 18.0pt'>
	<td width="66%" valign=middle
		style='width: 66.2%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal
		style='line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'><span
		style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	</span></span><span style='font-size: 14.0pt; font-family: 宋体; color: black'>现金流入小计<span
		lang=EN-US><o:p></o:p></span></span></p>
	</td>
	<td width="33%" valign=middle
		style='width: 33.8%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal align=right
		style='text-align: right; line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'>
		<label id="faInflowSum" field="faInflowSum" name='"现金流入小计"'
style=''></label>
		</span></p>
	</td>
</tr>
<tr style='height: 18.0pt'>
	<td width="66%" valign=middle
		style='width: 66.2%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal
		style='line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'><span
		style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
		style='font-size: 14.0pt; font-family: 宋体; color: black'>偿还借款所支付的现金<span
		lang=EN-US><o:p></o:p></span></span></p>
	</td>
	<td width="33%" valign=middle
		style='width: 33.8%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal align=right
		style='text-align: right; line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'>
		<input  onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');countfaOutflowSum();" id="faOutflowSum1" field="faOutflowDebt" 
			name='"偿还借款所支付的现金"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' />
		</span></p>
	</td>
</tr>
<tr style='height: 18.0pt'>
	<td width="66%" valign=middle
		style='width: 66.2%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal
		style='line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'><span
		style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
		style='font-size: 14.0pt; font-family: 宋体; color: black'>偿付利息所支付的现金<span
		lang=EN-US><o:p></o:p></span></span></p>
	</td>
	<td width="33%" valign=middle
		style='width: 33.8%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal
		style='text-align: right;line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'>
		<input  onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');countfaOutflowSum();" id="faOutflowSum2" field="faOutflowRatio" 
			name='"偿付利息所支付的现金"' style="width:98%" maxlength="15" style='text-align:right;padding-right:2px;'  />
		</span></p>
	</td>
</tr>
<tr style='height: 18.0pt'>
	<td width="66%" valign=middle
		style='width: 66.2%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal
		style='line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'><span
		style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
		style='font-size: 14.0pt; font-family: 宋体; color: black'>支付的其他与筹资活动有关的现金<span
		lang=EN-US><o:p></o:p></span></span></p>
	</td>
	<td width="33%" valign=middle
		style='width: 33.8%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal
		style='text-align: right;line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'>
		<input  onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');countfaOutflowSum();" id="faOutflowSum3" field="faOutflowOthers" 
			name='"支付的其他与筹资活动有关的现金"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' />
		</span></p>
	</td>
</tr>
<tr style='height: 18.0pt'>
	<td width="66%" valign=middle
		style='width: 66.2%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal
		style='line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'><span
		style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	</span></span><span style='font-size: 14.0pt; font-family: 宋体; color: black'>现金流出小计<span
		lang=EN-US><o:p></o:p></span></span></p>
	</td>
	<td width="33%" valign=middle
		style='width: 33.8%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal align=right
		style='text-align: right; line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'>
		<label id="faOutflowSum"field="faOutflowSum" name='"现金流出小计"'
style=''></label>
		</span></p>
	</td>
</tr>
<tr style='height: 18.0pt'>
	<td width="66%" valign=middle
		style='width: 66.2%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal align=center
		style='text-align: center; line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		style='font-size: 14.0pt; font-family: 宋体; color: black'>筹资活动产生的现金流量净额<span
		lang=EN-US><o:p></o:p></span></span></p>
	</td>
	<td width="33%" valign=middle
		style='width: 33.8%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal align=right
		style='text-align: right; line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'>
		<label id="faNetAmount" field="faNetAmount" name='"筹资活动产生的现金流量净额"'
style=''></label>
		</span></p>
	</td>
</tr>
<tr style='height: 18.0pt'>
	<td width="66%" valign=middle
		style='width: 66.2%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal
		style='line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		style='font-size: 14.0pt; font-family: 宋体; color: black'>四、汇率变动对现金的影响额<span
		lang=EN-US><o:p></o:p></span></span></p>
	</td>
	<td width="33%" valign=middle
		style='width: 33.8%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal align=right
		style='text-align: right; line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'>
		<input id="exchangeRateMovement" onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');netRevalueationcount()" field="exchangeRateMovement" 
			name='"四、汇率变动对现金的影响额"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' />
		</span></p>
	</td>
</tr>
<tr style='mso-yfti-lastrow: yes; height: 18.0pt'>
	<td width="66%" valign=middle
		style='width: 66.2%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: .75pt; mso-border-left-alt: 1.5pt; mso-border-bottom-alt: 1.5pt; mso-border-right-alt: .75pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal
		style='line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		style='font-size: 14.0pt; font-family: 宋体; color: black'>五、现金及现金等价物净增加额<span
		lang=EN-US><o:p></o:p></span></span></p>
	</td>
	<td width="33%" valign=middle
		style='width: 33.8%; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal align=right
		style='text-align: right; line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'>
		<label id="netRevalueation" onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'')" field="netRevalueation" 
			name='"五、现金及现金等价物净增加额"' maxlength="15" style='' ></label>
		</span></p>
	</td>
</tr>
</table>
</form>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</div>
</div>
</body>
</html>
