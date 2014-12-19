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
	var somJxCheckCashFlowDataSet = L5.DatasetMgr.lookup("somJxCheckCashFlowDataSet");
	somJxCheckCashFlowDataSet.setParameter("TASK_CODE@=", taskCode);
	somJxCheckCashFlowDataSet.load();
	somJxCheckCashFlowDataSet.on("load",function(ds){
		if(ds.getCount()==0){
			somJxCheckCashFlowDataSet.newRecord();
		}
	});
	//创建页面导航下拉框
	createUngovDetailSelect();
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
	document.getElementById('baInflowSum').innerHTML =num.toFixed(6)*1;
	baNetAmountcount();
}
function countBaOutflowSum(){
	var baOutflowSum4=document.getElementById('baOutflowSum4').value;
	var baOutflowSum1=document.getElementById('baOutflowSum1').value;
	var baOutflowSum2=document.getElementById('baOutflowSum2').value;
	var baOutflowSum3=document.getElementById('baOutflowSum3').value;
	if(baOutflowSum4==""){
		baOutflowSum4=0;
	}
	if(baOutflowSum1==""){
		baOutflowSum1=0;
	}
	if(baOutflowSum2==""){
		baOutflowSum2=0;
	}
	if(baOutflowSum3==""){
		baOutflowSum3=0;
	}
	var num=parseFloat(baOutflowSum4)+parseFloat(baOutflowSum1)+parseFloat(baOutflowSum2)+parseFloat(baOutflowSum3);
	document.getElementById('baOutflowSum').innerHTML =num.toFixed(6)*1;
	baNetAmountcount();
}
function baNetAmountcount(){
	var baOutflowSum=document.getElementById('baOutflowSum').innerHTML;
	var baInflowSum=document.getElementById('baInflowSum').innerHTML;
	if(baOutflowSum==""){
		baOutflowSum=0;
	}
	if(baInflowSum==""){
		baInflowSum=0;
	}
	var num=parseFloat(baInflowSum)-parseFloat(baOutflowSum);
	document.getElementById('baNetAmount').innerHTML =num.toFixed(6)*1;

}
function countIaInflowSum(){
	var iaInflowSum4=document.getElementById('iaInflowSum4').value;
	var iaInflowSum1=document.getElementById('iaInflowSum1').value;
	var iaInflowSum2=document.getElementById('iaInflowSum2').value;
	var iaInflowSum3=document.getElementById('iaInflowSum3').value;
	if(iaInflowSum4==""){
		iaInflowSum4=0;
	}
	if(iaInflowSum1==""){
		iaInflowSum1=0;
	}
	if(iaInflowSum2==""){
		iaInflowSum2=0;
	}
	if(iaInflowSum3==""){
		iaInflowSum3=0;
	}
	var num=parseFloat(iaInflowSum4)+parseFloat(iaInflowSum1)+parseFloat(iaInflowSum2)+parseFloat(iaInflowSum3);
	document.getElementById('iaInflowSum').innerHTML =num.toFixed(6)*1;
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
	document.getElementById('iaOutflowSum').innerHTML =num.toFixed(6)*1;
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
	document.getElementById('iaNetAmount').innerHTML =num.toFixed(6)*1;
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
	document.getElementById('faInflowSum').innerHTML =num.toFixed(6)*1;
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
	document.getElementById('faOutflowSum').innerHTML =num.toFixed(6)*1;
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
	document.getElementById('faNetAmount').innerHTML =num.toFixed(6)*1;
}
</script>
<style media="print">
.noprint {
	display: none
}
</style>
<style>
label {
	font-size: 13.0pt;
	font-family: 仿宋 ;
}
</style>
</head>

<body>
<model:datasets>
	<model:dataset id="somJxCheckCashFlowDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxcheckcashflow.cmd.SomJxCheckCashFlowQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxcheckcashflow.dao.SomJxCheckCashFlow"></model:record>
	</model:dataset>
</model:datasets>
<div id="float"class="noprint">
	<input type="button" value="下一页" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="nextPageM1('11')"/>
	<input type="button" value="上一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="lastPageM1('9')"/>
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="backM();"/>
	<input type="button" value="打印" style="height:25px;width:80px;position:absolute;margin-left:320px;" onclick="docPrint();"/>
</div>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal align=center
	style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly'><b
	style='mso-bidi-font-weight: normal'><span lang=EN-US
	style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>3.</span></b><b
	style='mso-bidi-font-weight: normal'><span
	style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>现金流量表<span
	lang=EN-US><o:p></o:p></span></span></b></p>

<p class=MsoNormal align=right
	style='text-align:center; line-height: 18.0pt; mso-line-height-rule: exactly'><span
	lang=EN-US
	style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
	style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span
	style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>单位：
<span style="color:red;font-size: 15.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋">元</span>

	<span
	lang=EN-US><o:p></o:p></span></span></p>

<div align=center>
<form method="post" dataset="somJxCheckCashFlowDataSet" onsubmit="return false">
<table class=MsoNormalTable border=1 cellspacing=0 cellpadding=0
	style='border-collapse: collapse; border: none; mso-border-top-alt: solid windowtext 1.5pt; mso-border-bottom-alt: solid windowtext 1.5pt; mso-padding-alt: 0cm 1.5pt 0cm 1.5pt; mso-border-insideh: .75pt solid windowtext; mso-border-insidev: .75pt solid windowtext'>
	<tr style='mso-yfti-irow: 0; mso-yfti-firstrow: yes; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext 1.5pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>项<span
			lang=EN-US><span style='mso-spacerun: yes'>&nbsp; </span></span>目<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>行次<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=204
			style='width: 153.0pt; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: none; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext 1.5pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>金<span
			lang=EN-US><span style='mso-spacerun: yes'>&nbsp; </span></span>额<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 1; height: 12.9pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 12.9pt'>
		<p class=MsoNormal style='text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>一、业务活动产生的现金流量：<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 12.9pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 12.9pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 2; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>接受捐赠收到的现金<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>1<o:p></o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label  onkeyup="value=value.replace(/[^\d.]/g,'');countBaInflowSum();" id="baInflowSum0" field="baReceiveDonations" name='"接受捐赠收到的现金"' style="width:98%"  maxlength="8" style='text-align:right' />
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 3; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>收取会费收到的现金<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>2<o:p></o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label  onkeyup="value=value.replace(/[^\d.]/g,'');countBaInflowSum();" id="baInflowSum1" field="baGatherDues" name='"收取会费收到的现金"' style="width:98%"  maxlength="8" style='text-align:right' />
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 4; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>提供服务收到的现金<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>3<o:p></o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label  onkeyup="value=value.replace(/[^\d.]/g,'');countBaInflowSum();" id="baInflowSum2" field="baRenderServices" name='"提供服务收到的现金"' style="width:98%" maxlength="8" style='text-align:right'  />
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 5; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>销售商品收到的现金<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>4<o:p></o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label  onkeyup="value=value.replace(/[^\d.]/g,'');countBaInflowSum();" id="baInflowSum3" field="baSellProduct" name='"销售商品收到的现金"' style="width:98%"  maxlength="8" style='text-align:right' />
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 6; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>政府补助收到的现金<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>5<o:p></o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label  onkeyup="value=value.replace(/[^\d.]/g,'');countBaInflowSum();" id="baInflowSum4" field="baGovernmentGrants" name='"政府补助收到的现金"' style="width:98%" maxlength="8" style='text-align:right'  />
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 7; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>收到的其他与业务活动有关的现金<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>8<o:p></o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label  onkeyup="value=value.replace(/[^\d.]/g,'');countBaInflowSum();" id="baInflowSum5" field="baInfolwOthers" name='"收到的其他与业务活动有关的现金"' style="width:98%"  maxlength="8" style='text-align:right' />
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 8; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>现金流入小计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>13<o:p></o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
<label id="baInflowSum" field="baInflowSum" name='"现金流入小计"' style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 9; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>提供捐赠或者资助支付的现金<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>14<o:p></o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label  onkeyup="value=value.replace(/[^\d.]/g,'');countBaOutflowSum();"id="baOutflowSum1" field="baDonatedPay" name='"提供捐赠或者资助支付的现金"' style="width:98%"  maxlength="8" style='text-align:right' />
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 10; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>支付给员工以及为员工支付的现金<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>15<o:p></o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label  onkeyup="value=value.replace(/[^\d.]/g,'');countBaOutflowSum();"id="baOutflowSum2" field="baPayEmployee" name='"支付给员工以及为员工支付的现金"' style="width:98%"  maxlength="8" style='text-align:right' />
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 11; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>购买商品、接受服务支付的现金<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>16<o:p></o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label  onkeyup="value=value.replace(/[^\d.]/g,'');countBaOutflowSum();" id="baOutflowSum3" field="baProductServices" name='"购买商品、接受服务支付的现金"' style="width:98%"  maxlength="8" style='text-align:right' />
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 12; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>支付的其他与业务活动有关的现金<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>19<o:p></o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label  onkeyup="value=value.replace(/[^\d.]/g,'');countBaOutflowSum();" id="baOutflowSum4" field="baOutflowOthers" name='"支付的其他与业务活动有关的现金"' style="width:98%"  maxlength="8" style='text-align:right' />
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 13; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>现金流出小计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>23<o:p></o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
<label id="baOutflowSum" field="baOutflowSum" name='"现金流出小计"' style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 14; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>业务活动产生的现金流量净额<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>24<o:p></o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
<label id="baNetAmount" field="baNetAmount" name='"业务活动产生的现金流量净额"'style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 15; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>二、投资活动产生的现金流量：<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 16; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp; </span><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;</span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>收回投资所收到的现金<span
			lang=EN-US> <o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>25<o:p></o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label  onkeyup="value=value.replace(/[^\d.]/g,'');countIaInflowSum();"id="iaInflowSum4" field="iaRegoupingOutlay" name='"收回投资所收到的现金"' style="width:98%"  maxlength="8" style='text-align:right' />
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 17; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>取得投资收益所收到的现金<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>26<o:p></o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label  onkeyup="value=value.replace(/[^\d.]/g,'');countIaInflowSum();"id="iaInflowSum3" field="iaMadeIncome" name='"取得投资收益所收到的现金"' style="width:98%"  maxlength="8" style='text-align:right' />
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 18; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>处置固定资产和无形资产所收回的现金<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>27<o:p></o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label  onkeyup="value=value.replace(/[^\d.]/g,'');countIaInflowSum();"id="iaInflowSum2" field="iaInflowAssets" name='"处置固定资产和无形资产所收回的现金"' style="width:98%"  maxlength="8" style='text-align:right' />
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 19; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>收到的其他与投资活动有关的现金<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>30<o:p></o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label  onkeyup="value=value.replace(/[^\d.]/g,'');countIaInflowSum();"id="iaInflowSum1" field="iaInflowOthers" name='"收到的其他与投资活动有关的现金"' style="width:98%" maxlength="8" style='text-align:right'  />
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 20; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>现金流入小计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>34<o:p></o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
<label id="iaInflowSum" field="iaInflowSum" name='"现金流入小计"'style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 21; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>购建固定资产和无形资产所支付的现金<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>35<o:p></o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label  onkeyup="value=value.replace(/[^\d.]/g,'');countIaOutflowSum();" id="iaOutflowSum1" field="iaOutflowAssets" name='"购建固定资产和无形资产所支付的现金"' style="width:98%"  maxlength="8" style='text-align:right' />
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 22; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>对外投资所支付的现金<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>36<o:p></o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label  onkeyup="value=value.replace(/[^\d.]/g,'');countIaOutflowSum();" id="iaOutflowSum2" field="iaOutflowAbroad" name='"对外投资所支付的现金"' style="width:98%"  maxlength="8" style='text-align:right' />
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 23; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>支付的其他与投资活动有关的现金<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>39<o:p></o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label  onkeyup="value=value.replace(/[^\d.]/g,'');countIaOutflowSum();"  id="iaOutflowSum3" field="iaOutflowOthers" name='"支付的其他与投资活动有关的现金"' style="width:98%"  maxlength="8" style='text-align:right' />
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 24; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>现金流出小计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>43<o:p></o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
<label id="iaOutflowSum" field="iaOutflowSum" name='"现金流出小计"'style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 25; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>投资活动产生的现金流量净额<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>44<o:p></o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
<label id="iaNetAmount" field="iaNetAmount" name='"投资活动产生的现金流量净额"'style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 26; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>三、筹资活动产生的现金流量：<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 27; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>借款所收到的现金<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>45<o:p></o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label  onkeyup="value=value.replace(/[^\d.]/g,'');countFaInflowSum();"id="faInflowSum1" field="faInflowLoan" name='"借款所收到的现金"' style="width:98%"  maxlength="8" style='text-align:right' />
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 28; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>收到的其他与筹资活动有关的现金<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>48<o:p></o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label  onkeyup="value=value.replace(/[^\d.]/g,'');countFaInflowSum();"id="faInflowSum2" field="faInflowOthers" name='"收到的其他与筹资活动有关的现金"' style="width:98%" maxlength="8" style='text-align:right'  />
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 29; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>现金流入小计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>50<o:p></o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
<label id="faInflowSum" field="faInflowSum" name='"现金流入小计"'style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 30; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>偿还借款所支付的现金<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>51<o:p></o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label  onkeyup="value=value.replace(/[^\d.]/g,'');countfaOutflowSum();" id="faOutflowSum1" field="faOutflowDebt" name='"偿还借款所支付的现金"' style="width:98%"  maxlength="8" style='text-align:right' />
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 31; height: 16.65pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 16.65pt'>
		<p class=MsoNormal style='text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>偿付利息所支付的现金<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 16.65pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>52<o:p></o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 16.65pt'>
		<p class=MsoNormal style='text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label  onkeyup="value=value.replace(/[^\d.]/g,'');countfaOutflowSum();" id="faOutflowSum2" field="faOutflowRatio" name='"偿付利息所支付的现金"' style="width:98%" maxlength="8" style='text-align:right'  />
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 32; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>支付的其他与筹资活动有关的现金<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>55<o:p></o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label  onkeyup="value=value.replace(/[^\d.]/g,'');countfaOutflowSum();" id="faOutflowSum3" field="faOutflowOthers" name='"支付的其他与筹资活动有关的现金"' style="width:98%"  maxlength="8" style='text-align:right' />
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 33; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>现金流出小计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>58<o:p></o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
<label id="faOutflowSum"field="faOutflowSum" name='"现金流出小计"'style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 34; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>筹资活动产生的现金流量净额<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>59<o:p></o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
<label id="faNetAmount" field="faNetAmount" name='"筹资活动产生的现金流量净额"'style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 35; height: 8.7pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 8.7pt'>
		<p class=MsoNormal style='text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>四、汇率变动对现金的影响额<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 8.7pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>60<o:p></o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 8.7pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label  onkeyup="value=value.replace(/[^\d.]/g,'')" field="exchangeRateMovement" name='"四、汇率变动对现金的影响额"' style="width:98%"  maxlength="8" style='text-align:right' />
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 36; mso-yfti-lastrow: yes; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext 1.5pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>五、现金及现金等价物净增加额<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>61<o:p></o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label  onkeyup="value=value.replace(/[^\d.]/g,'')" field="netRevalueation" name='"五、现金及现金等价物净增加额"' style="width:98%"  maxlength="8" style='text-align:right' />
			</o:p></span></p>
		</td>
	</tr>
</table>
</form>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</div>
</body>
</html>
