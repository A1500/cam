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
	});
	//创建页面导航下拉框
	createUngovDetailSelect();
}
function save(){
}
function docPrint(){
    document.execCommand("Print", false);
}			
</script>
<style media="print">
.noprint {
	display: none
}
</style>
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
		<model:record fromBean="com.inspur.cams.sorg.check.balancesheet.data.SomCheckBalanceSheet"></model:record>
	</model:dataset>
</model:datasets>
<div id="float" class="noprint">	
	<input type="button" value="上一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="nextPageM1('5')"/>
	<input type="button" value="下一页" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="nextPageM1('7')"/>
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="backM();"/>
	<input type="button" value="打印" style="height:25px;width:80px;position:absolute;margin-left:320px;" onclick="docPrint();"/>
</div>

<div align=center>
<div align=left style=" width: 610px">
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<form method="post" dataset="somCheckBalanceSheetDataSet" onsubmit="return false">

<p class=MsoNormal align=center style='text-align:center'><b style='mso-bidi-font-weight:
normal'><span style='font-size:14.0pt;font-family:宋体'>财务会计报告<span lang=EN-US><o:p></o:p></span></span></b></p>

<p class=MsoNormal align=center style='text-align:center;line-height:20.0pt;
mso-line-height-rule:exactly'><span style='font-size:12.0pt;font-family:黑体;
mso-hansi-font-family:宋体;color:black'>（一）资产负债表<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal align=center style='text-align:center;line-height:20.0pt;
mso-line-height-rule:exactly'><span style='font-size:10.5pt;font-family:楷体_GB2312;
mso-hansi-font-family:宋体;color:black'>（截止到本年度<span lang=EN-US>12</span>月<span
lang=EN-US>31</span>日）<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal align=center style='line-height:20.0pt;mso-line-height-rule:exactly'><span
style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
color:black'>编制单位：<label field="organizationUnit" style="width: 260;text-align:left" ></label><span lang=EN-US><span
style='mso-spacerun:yes'>
</span></span><span lang=EN-US><span
style='mso-spacerun:yes'></span><span
style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span
style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;</span></span>　　　单位：元<span
lang=EN-US><o:p></o:p></span></span></p>

<div align=center>

<table class=MsoNormalTable border=0 cellspacing=0 cellpadding=0 width="610"
 style='width:610;border-collapse:collapse;mso-yfti-tbllook:191;mso-padding-alt:
 0cm 1.5pt 0cm 1.5pt;mso-border-insideh:.75pt solid black;mso-border-insidev:
 .75pt solid black'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes;height:17.25pt'>
  <td width="25%" valign=top style='width:25.64%;border-top:windowtext 1.5pt;
  border-left:black 1.5pt;border-bottom:black 1.0pt;border-right:black 1.0pt;
  border-style:solid;mso-border-top-alt:windowtext 1.5pt;mso-border-left-alt:
  black 1.5pt;mso-border-bottom-alt:black .75pt;mso-border-right-alt:black .75pt;
  mso-border-style-alt:solid;padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=center style='text-align:center;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span style='font-size:
  10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;color:black'>资<span
  lang=EN-US><span style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp; </span></span>产<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="11%" valign=top style='width:11.78%;border-top:solid windowtext 1.5pt;
  border-left:none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-left-alt:solid black .75pt;mso-border-alt:solid black .75pt;
  mso-border-top-alt:solid windowtext 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;
  height:17.25pt'>
  <p class=MsoNormal align=center style='text-align:center;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span style='font-size:
  10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;color:black'>年初数<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="11%" valign=top style='width:11.58%;border-top:solid windowtext 1.5pt;
  border-left:none;border-bottom:solid black 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-left-alt:solid black .75pt;mso-border-top-alt:windowtext 1.5pt;
  mso-border-left-alt:black .75pt;mso-border-bottom-alt:black .75pt;mso-border-right-alt:
  windowtext 1.5pt;mso-border-style-alt:solid;padding:0cm 1.5pt 0cm 1.5pt;
  height:17.25pt'>
  <p class=MsoNormal align=center style='text-align:center;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span style='font-size:
  10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;color:black'>期末数<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="27%" valign=top style='width:27.42%;border-top:solid windowtext 1.5pt;
  border-left:none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-left-alt:solid windowtext 1.5pt;mso-border-top-alt:windowtext 1.5pt;
  mso-border-left-alt:windowtext 1.5pt;mso-border-bottom-alt:black .75pt;
  mso-border-right-alt:black .75pt;mso-border-style-alt:solid;padding:0cm 1.5pt 0cm 1.5pt;
  height:17.25pt'>
  <p class=MsoNormal align=center style='text-align:center;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span style='font-size:
  10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;color:black'>负债和净资产<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="11%" valign=top style='width:11.78%;border-top:solid windowtext 1.5pt;
  border-left:none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-left-alt:solid black .75pt;mso-border-alt:solid black .75pt;
  mso-border-top-alt:solid windowtext 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;
  height:17.25pt'>
  <p class=MsoNormal align=center style='text-align:center;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span style='font-size:
  10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;color:black'>年初数<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="11%" valign=top style='width:11.8%;border-top:solid windowtext 1.5pt;
  border-left:none;border-bottom:solid black 1.0pt;border-right:solid black 1.5pt;
  mso-border-left-alt:solid black .75pt;mso-border-top-alt:windowtext 1.5pt;
  mso-border-left-alt:black .75pt;mso-border-bottom-alt:black .75pt;mso-border-right-alt:
  black 1.5pt;mso-border-style-alt:solid;padding:0cm 1.5pt 0cm 1.5pt;
  height:17.25pt'>
  <p class=MsoNormal align=center style='text-align:center;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span style='font-size:
  10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;color:black'>期末数<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:1;height:17.25pt'>
  <td width="25%" valign=top style='width:25.64%;border-top:none;border-left:
  solid black 1.5pt;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-alt:solid black .75pt;
  mso-border-left-alt:solid black 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;height:
  17.25pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span style='font-size:10.5pt;font-family:楷体_GB2312;
  mso-hansi-font-family:宋体;color:black'>流动资产：<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="11%" valign=top style='width:11.78%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.58%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="27%" valign=top style='width:27.42%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid windowtext 1.5pt;
  mso-border-alt:solid black .75pt;mso-border-left-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span style='font-size:10.5pt;font-family:楷体_GB2312;
  mso-hansi-font-family:宋体;color:black'>流动负债：<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="11%" valign=top style='width:11.78%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.8%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.5pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;mso-border-right-alt:solid black 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:19.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>&nbsp;</o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:2;height:17.25pt'>
  <td width="25%" valign=top style='width:25.64%;border-top:none;border-left:
  solid black 1.5pt;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-alt:solid black .75pt;
  mso-border-left-alt:solid black 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;height:
  17.25pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><span
  style='mso-spacerun:yes'>&nbsp; </span></span><span style='font-size:10.5pt;
  font-family:楷体_GB2312;mso-hansi-font-family:宋体;color:black'>货币资金<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="11%" valign=top style='width:11.78%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="caMoneyfundsS" id="货币资金" name='"货币资金"' style="width: 98%; "
				maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,''); " 
       />
  </o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.58%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="caMoneyfundsE" id="_货币资金" name='"_货币资金"' style="width: 98%; "
				  maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,''); "/>
  </o:p></span></p>
  </td>
  <td width="27%" valign=top style='width:27.42%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid windowtext 1.5pt;
  mso-border-alt:solid black .75pt;mso-border-left-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><span
  style='mso-spacerun:yes'>&nbsp; </span></span><span style='font-size:10.5pt;
  font-family:楷体_GB2312;mso-hansi-font-family:宋体;color:black'>短期借款<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="11%" valign=top style='width:11.78%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="clShorttermBorrowingS" id="短期借款" name='"短期借款"' style="width: 98%; text-align: right"
				 maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,''); "/>
  </o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.8%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.5pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;mso-border-right-alt:solid black 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:19.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="clShorttermBorrowingE" id="_短期借款" name='"_短期借款"' style="width: 98%; "
				 maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,''); "/>
  </o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:3;height:17.25pt'>
  <td width="25%" valign=top style='width:25.64%;border-top:none;border-left:
  solid black 1.5pt;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-alt:solid black .75pt;
  mso-border-left-alt:solid black 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;height:
  17.25pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><span
  style='mso-spacerun:yes'>&nbsp; </span></span><span style='font-size:10.5pt;
  font-family:楷体_GB2312;mso-hansi-font-family:宋体;color:black'>短期投资<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="11%" valign=top style='width:11.78%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="caLiquidInvestmentS" id="短期投资" name='"短期投资"' style="width: 98%; "
				 maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,''); "/>
  </o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.58%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="caLiquidInvestmentE" id="_短期投资" name='"_短期投资"' style="width: 98%; "
				 maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,''); "/>
  </o:p></span></p>
  </td>
  <td width="27%" valign=top style='width:27.42%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid windowtext 1.5pt;
  mso-border-alt:solid black .75pt;mso-border-left-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><span
  style='mso-spacerun:yes'>&nbsp; </span></span><span style='font-size:10.5pt;
  font-family:楷体_GB2312;mso-hansi-font-family:宋体;color:black'>应付款项<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="11%" valign=top style='width:11.78%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="clDuesS" id="应付款项" name='"应付款项"' style="width: 98%; "
				 maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,''); "/>
  </o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.8%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.5pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;mso-border-right-alt:solid black 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:19.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="clDuesE" id="_应付款项" name='"_应付款项"' style="width: 98%; "
				maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,''); " />
  </o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:4;height:17.25pt'>
  <td width="25%" valign=top style='width:25.64%;border-top:none;border-left:
  solid black 1.5pt;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-alt:solid black .75pt;
  mso-border-left-alt:solid black 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;height:
  17.25pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><span
  style='mso-spacerun:yes'>&nbsp; </span></span><span style='font-size:10.5pt;
  font-family:楷体_GB2312;mso-hansi-font-family:宋体;color:black'>应收款项<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="11%" valign=top style='width:11.78%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="caReceivablesS" id="应收款项" name='"应收款项"' style="width: 98%; "
				 maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,''); "/>
  </o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.58%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="caReceivablesE" id="_应收款项" name='"_应收款项"' style="width: 98%; "
				 maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,''); "/>
  </o:p></span></p>
  </td>
  <td width="27%" valign=top style='width:27.42%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid windowtext 1.5pt;
  mso-border-alt:solid black .75pt;mso-border-left-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><span
  style='mso-spacerun:yes'>&nbsp; </span></span><span style='font-size:10.5pt;
  font-family:楷体_GB2312;mso-hansi-font-family:宋体;color:black'>应付工资<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="11%" valign=top style='width:11.78%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="clAccruedPayrollsS" id="应付工资" name='"应付工资"' style="width: 98%; "
				 maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,''); "/>
  </o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.8%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.5pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;mso-border-right-alt:solid black 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:19.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="clAccruedPayrollsE" id="_应付工资" name='"_应付工资"' style="width: 98%; "
				maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,''); " />
  </o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:5;height:17.25pt'>
  <td width="25%" valign=top style='width:25.64%;border-top:none;border-left:
  solid black 1.5pt;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-alt:solid black .75pt;
  mso-border-left-alt:solid black 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;height:
  17.25pt'>
  <p class=MsoNormal style='text-indent:10.4pt;mso-char-indent-count:1.0;
  line-height:16.0pt;mso-line-height-rule:exactly;text-autospace:none'><span
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'>预付账款<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="11%" valign=top style='width:11.78%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="caAdvanceMoneyS" id="预付账款" name='"预付账款"' style="width: 98%; "
				maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,''); " />
  </o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.58%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="caAdvanceMoneyE" id="_预付账款" name='"_预付账款"' style="width: 98%; "
				maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,''); " />
  </o:p></span></p>
  </td>
  <td width="27%" valign=top style='width:27.42%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid windowtext 1.5pt;
  mso-border-alt:solid black .75pt;mso-border-left-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><span
  style='mso-spacerun:yes'>&nbsp; </span></span><span style='font-size:10.5pt;
  font-family:楷体_GB2312;mso-hansi-font-family:宋体;color:black'>应交税金<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="11%" valign=top style='width:11.78%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="clTasPayableS" id="应交税金" name='"应交税金"' style="width: 98%; "
				maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,''); " />
  </o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.8%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.5pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;mso-border-right-alt:solid black 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:19.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="clTasPayableE" id="_应交税金" name='"_应交税金"' style="width: 98%; "
				maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,''); " />
  </o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:6;height:17.25pt'>
  <td width="25%" valign=top style='width:25.64%;border-top:none;border-left:
  solid black 1.5pt;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-alt:solid black .75pt;
  mso-border-left-alt:solid black 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;height:
  17.25pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><span
  style='mso-spacerun:yes'>&nbsp; </span></span><span style='font-size:10.5pt;
  font-family:楷体_GB2312;mso-hansi-font-family:宋体;color:black'>存<span
  lang=EN-US><span style='mso-spacerun:yes'>&nbsp; </span></span>货<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="11%" valign=top style='width:11.78%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="caInventoryS" id="存货" name='"存货"' style="width: 98%; "
				maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,''); " />
  </o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.58%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="caInventoryE" id="_存货" name='"_存货"' style="width: 98%; "
				maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,''); " />
  </o:p></span></p>
  </td>
  <td width="27%" valign=top style='width:27.42%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid windowtext 1.5pt;
  mso-border-alt:solid black .75pt;mso-border-left-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal style='text-indent:10.4pt;mso-char-indent-count:1.0;
  line-height:16.0pt;mso-line-height-rule:exactly;text-autospace:none'><span
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'>预收账款<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="11%" valign=top style='width:11.78%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="clDepositReceivedS" id="预收账款" name='"预收账款"' style="width: 98%; "
				maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,''); " />
  </o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.8%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.5pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;mso-border-right-alt:solid black 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:19.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="clDepositReceivedE" id="_预收账款" name='"_预收账款"' style="width: 98%; "
				maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,''); " />
  </o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:7;height:17.25pt'>
  <td width="25%" valign=top style='width:25.64%;border-top:none;border-left:
  solid black 1.5pt;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-alt:solid black .75pt;
  mso-border-left-alt:solid black 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;height:
  17.25pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><span
  style='mso-spacerun:yes'>&nbsp; </span></span><span style='font-size:10.5pt;
  font-family:楷体_GB2312;mso-hansi-font-family:宋体;color:black'>待摊费用<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="11%" valign=top style='width:11.78%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="caDeferredExpensesS" id="待摊费用" name='"待摊费用"' style="width: 98%; "
				maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,''); " />
  </o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.58%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="caDeferredExpensesE" id="_待摊费用" name='"_待摊费用"' style="width: 98%; "
				maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,''); " />
  </o:p></span></p>
  </td>
  <td width="27%" valign=top style='width:27.42%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid windowtext 1.5pt;
  mso-border-alt:solid black .75pt;mso-border-left-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal style='text-indent:10.4pt;mso-char-indent-count:1.0;
  line-height:16.0pt;mso-line-height-rule:exactly;text-autospace:none'><span
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'>预提费用<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="11%" valign=top style='width:11.78%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="clAccruedExpensesS" id="预提费用" name='"预提费用"' style="width: 98%; "
				maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,''); " />
  </o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.8%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.5pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;mso-border-right-alt:solid black 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:19.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="clAccruedExpensesE" id="_预提费用" name='"_预提费用"' style="width: 98%; "
				maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,''); " />
  </o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:8;height:17.25pt'>
  <td width="25%" valign=top style='width:25.64%;border-top:none;border-left:
  solid black 1.5pt;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-alt:solid black .75pt;
  mso-border-left-alt:solid black 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;height:
  17.25pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span style='font-size:10.5pt;font-family:楷体_GB2312;
  mso-hansi-font-family:宋体;color:black;letter-spacing:-1.0pt'>一年内到期的长期债权投资<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="11%" valign=top style='width:11.78%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="caDebtInvestmentsS" id="一年内到期的长期债权投资" name='"一年内到期的长期债权投资"' style="width: 98%; "
				maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,''); " />
  </o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.58%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="caDebtInvestmentsE" id="_一年内到期的长期债权投资" name='"_一年内到期的长期债权投资"' style="width: 98%; "
				maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,''); " />
  </o:p></span></p>
  </td>
  <td width="27%" valign=top style='width:27.42%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid windowtext 1.5pt;
  mso-border-alt:solid black .75pt;mso-border-left-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal style='text-indent:10.4pt;mso-char-indent-count:1.0;
  line-height:16.0pt;mso-line-height-rule:exactly;text-autospace:none'><span
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'>预计负债<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="11%" valign=top style='width:11.78%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="clAccruedLiabilitiesS" id="预计负债" name='"预计负债"' style="width: 98%; "
				maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,''); " />
  </o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.8%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.5pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;mso-border-right-alt:solid black 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="clAccruedLiabilitiesE" id="_预计负债" name='"_预计负债"' style="width: 98%; "
				maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,''); " />
  </o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:9;height:17.25pt'>
  <td width="25%" valign=top style='width:25.64%;border-top:none;border-left:
  solid black 1.5pt;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-alt:solid black .75pt;
  mso-border-left-alt:solid black 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;height:
  17.25pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><span
  style='mso-spacerun:yes'>&nbsp; </span></span><span style='font-size:10.5pt;
  font-family:楷体_GB2312;mso-hansi-font-family:宋体;color:black'>其他流动资产<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="11%" valign=top style='width:11.78%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="caOthersS" id="其他流动资产" name='"其他流动资产"' style="width: 98%; "
			maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,''); "	 />
  </o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.58%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="caOthersE" id="_其他流动资产" name='"_其他流动资产"' style="width: 98%; "
				maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,''); " />
  </o:p></span></p>
  </td>
  <td width="27%" valign=top style='width:27.42%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid windowtext 1.5pt;
  mso-border-alt:solid black .75pt;mso-border-left-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span style='font-size:10.5pt;font-family:楷体_GB2312;
  mso-hansi-font-family:宋体;color:black'>一年内到期的长期负债<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="11%" valign=top style='width:11.78%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="clLongtermDueS" id="一年内到期的长期负债" name='"一年内到期的长期负债"' style="width: 98%; "
				maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,''); " />
  </o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.8%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.5pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;mso-border-right-alt:solid black 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="clLongtermDueE" id="_一年内到期的长期负债" name='"_一年内到期的长期负债"' style="width: 98%; "
				maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,''); " />
  </o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:10;height:17.25pt'>
  <td width="25%" valign=top style='width:25.64%;border-top:none;border-left:
  solid black 1.5pt;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-alt:solid black .75pt;
  mso-border-left-alt:solid black 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;height:
  17.25pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><span
  style='mso-spacerun:yes'>&nbsp; </span></span><span style='font-size:10.5pt;
  font-family:楷体_GB2312;mso-hansi-font-family:宋体;color:black'>流动资产合计<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="11%" valign=top style='width:11.78%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="caSumS" id="流动资产合计" name='"流动资产合计"' style="width: 98%; " readonly="readonly"
				maxlength="15" style='text-align:right' ></label>
  </o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.58%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="caSumE" id="_流动资产合计" name='"_流动资产合计"' style="width: 98%; " readonly="readonly"
				maxlength="15" style='text-align:right' ></label>
  </o:p></span></p>
  </td>
  <td width="27%" valign=top style='width:27.42%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid windowtext 1.5pt;
  mso-border-alt:solid black .75pt;mso-border-left-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><span
  style='mso-spacerun:yes'>&nbsp; </span></span><span style='font-size:10.5pt;
  font-family:楷体_GB2312;mso-hansi-font-family:宋体;color:black'>其他流动负债<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="11%" valign=top style='width:11.78%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="clOthersS" id="其他流动负债" name='"其他流动负债"' style="width: 98%; "
				maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,''); " />
  </o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.8%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.5pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;mso-border-right-alt:solid black 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="clOthersE" id="_其他流动负债" name='"_其他流动负债"' style="width: 98%; "
				maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,''); " />
  </o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:11;height:17.25pt'>
  <td width="25%" valign=top style='width:25.64%;border-top:none;border-left:
  solid black 1.5pt;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-alt:solid black .75pt;
  mso-border-left-alt:solid black 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;height:
  17.25pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.78%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.58%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="27%" valign=top style='width:27.42%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid windowtext 1.5pt;
  mso-border-alt:solid black .75pt;mso-border-left-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal style='text-indent:10.4pt;mso-char-indent-count:1.0;
  line-height:16.0pt;mso-line-height-rule:exactly;text-autospace:none'><span
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'>流动负债合计<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="11%" valign=top style='width:11.78%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="clSumS" id="流动负债合计" name='"流动负债合计"' style="width: 98%; " readonly="readonly"
				maxlength="15" style='text-align:right'  ></label>
  </o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.8%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.5pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;mso-border-right-alt:solid black 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="clSumE" id="_流动负债合计" name='"_流动负债合计"' style="width: 98%; "
				maxlength="15" style='text-align:right' readonly="readonly" ></label>
  </o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:12;height:17.25pt'>
  <td width="25%" valign=top style='width:25.64%;border-top:none;border-left:
  solid black 1.5pt;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-alt:solid black .75pt;
  mso-border-left-alt:solid black 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;height:
  17.25pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span style='font-size:10.5pt;font-family:楷体_GB2312;
  mso-hansi-font-family:宋体;color:black'>长期投资：<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="11%" valign=top style='width:11.78%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.58%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="27%" valign=top style='width:27.42%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid windowtext 1.5pt;
  mso-border-alt:solid black .75pt;mso-border-left-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal style='text-indent:20.8pt;mso-char-indent-count:2.0;
  line-height:16.0pt;mso-line-height-rule:exactly;text-autospace:none'><span
  lang=EN-US style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:
  宋体;color:black'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.78%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.8%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.5pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;mso-border-right-alt:solid black 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>&nbsp;</o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:13;height:17.25pt'>
  <td width="25%" valign=top style='width:25.64%;border-top:none;border-left:
  solid black 1.5pt;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-alt:solid black .75pt;
  mso-border-left-alt:solid black 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;height:
  17.25pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><span
  style='mso-spacerun:yes'>&nbsp; </span></span><span style='font-size:10.5pt;
  font-family:楷体_GB2312;mso-hansi-font-family:宋体;color:black'>长期股权投资<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="11%" valign=top style='width:11.78%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="piLongtermEquityInvS" id="长期股权投资" name='"长期股权投资"' style="width: 98%; "
				maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,''); " />
  </o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.58%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="piLongtermEquityInvE" id="_长期股权投资" name='"_长期股权投资"' style="width: 98%; "
				maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,''); " />
  </o:p></span></p>
  </td>
  <td width="27%" valign=top style='width:27.42%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid windowtext 1.5pt;
  mso-border-alt:solid black .75pt;mso-border-left-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span style='font-size:10.5pt;font-family:楷体_GB2312;
  mso-hansi-font-family:宋体;color:black'>长期负债：<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="11%" valign=top style='width:11.78%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.8%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.5pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;mso-border-right-alt:solid black 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>&nbsp;</o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:14;height:17.25pt'>
  <td width="25%" valign=top style='width:25.64%;border-top:none;border-left:
  solid black 1.5pt;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-alt:solid black .75pt;
  mso-border-left-alt:solid black 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;height:
  17.25pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><span
  style='mso-spacerun:yes'>&nbsp; </span></span><span style='font-size:10.5pt;
  font-family:楷体_GB2312;mso-hansi-font-family:宋体;color:black'>长期债权投资<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="11%" valign=top style='width:11.78%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="piLongtermDebtInvS" id="长期债权投资" name='"长期债权投资"' style="width: 98%; "
				maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,''); " />
  </o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.58%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="piLongtermDebtInvE" id="_长期债权投资" name='"_长期债权投资"' style="width: 98%; "
				maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,''); " />
  </o:p></span></p>
  </td>
  <td width="27%" valign=top style='width:27.42%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid windowtext 1.5pt;
  mso-border-alt:solid black .75pt;mso-border-left-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><span
  style='mso-spacerun:yes'>&nbsp; </span></span><span style='font-size:10.5pt;
  font-family:楷体_GB2312;mso-hansi-font-family:宋体;color:black'>长期借款<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="11%" valign=top style='width:11.78%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="llLongtermLoansS" id="长期借款" name='"长期借款"' style="width: 98%; "
				maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,''); " />
  </o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.8%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.5pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;mso-border-right-alt:solid black 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="llLongtermLoansE" id="_长期借款" name='"_长期借款"' style="width: 98%; "
				maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,''); " />
  </o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:15;height:17.25pt'>
  <td width="25%" valign=top style='width:25.64%;border-top:none;border-left:
  solid black 1.5pt;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-alt:solid black .75pt;
  mso-border-left-alt:solid black 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;height:
  17.25pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><span
  style='mso-spacerun:yes'>&nbsp; </span></span><span style='font-size:10.5pt;
  font-family:楷体_GB2312;mso-hansi-font-family:宋体;color:black'>长期投资合计<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="11%" valign=top style='width:11.78%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="piSumS" id="长期投资合计" name='"长期投资合计"' style="width: 98%; "
				maxlength="15" style='text-align:right' readonly="readonly" ></label>
  </o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.58%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="piSumE" id="_长期投资合计" name='"_长期投资合计"' style="width: 98%; "
				maxlength="15" style='text-align:right' readonly="readonly" ></label>
  </o:p></span></p>
  </td>
  <td width="27%" valign=top style='width:27.42%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid windowtext 1.5pt;
  mso-border-alt:solid black .75pt;mso-border-left-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><span
  style='mso-spacerun:yes'>&nbsp; </span></span><span style='font-size:10.5pt;
  font-family:楷体_GB2312;mso-hansi-font-family:宋体;color:black'>长期应付款<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="11%" valign=top style='width:11.78%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="llLongtermPayableS" id="长期应付款" name='"长期应付款"' style="width: 98%; "
				maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,''); " />
  </o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.8%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.5pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;mso-border-right-alt:solid black 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="llLongtermPayableE" id="_长期应付款" name='"_长期应付款"' style="width: 98%; "
				maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,''); " />
  </o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:16;height:17.25pt'>
  <td width="25%" valign=top style='width:25.64%;border-top:none;border-left:
  solid black 1.5pt;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-alt:solid black .75pt;
  mso-border-left-alt:solid black 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;height:
  17.25pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.78%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.58%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="27%" valign=top style='width:27.42%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid windowtext 1.5pt;
  mso-border-alt:solid black .75pt;mso-border-left-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><span
  style='mso-spacerun:yes'>&nbsp; </span></span><span style='font-size:10.5pt;
  font-family:楷体_GB2312;mso-hansi-font-family:宋体;color:black'>其他长期负债<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="11%" valign=top style='width:11.78%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="llOthersS" id="其他长期负债" name='"其他长期负债"' style="width: 98%; "
				maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,''); " />
  </o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.8%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.5pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;mso-border-right-alt:solid black 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="llOthersE" id="_其他长期负债" name='"_其他长期负债"' style="width: 98%; "
				maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,''); " />
  </o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:17;height:17.25pt'>
  <td width="25%" valign=top style='width:25.64%;border-top:none;border-left:
  solid black 1.5pt;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-alt:solid black .75pt;
  mso-border-left-alt:solid black 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;height:
  17.25pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span style='font-size:10.5pt;font-family:楷体_GB2312;
  mso-hansi-font-family:宋体;color:black'>固定资产：<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="11%" valign=top style='width:11.78%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.58%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="27%" valign=top style='width:27.42%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid windowtext 1.5pt;
  mso-border-alt:solid black .75pt;mso-border-left-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal style='text-indent:10.4pt;mso-char-indent-count:1.0;
  line-height:16.0pt;mso-line-height-rule:exactly;text-autospace:none'><span
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'>长期负债合计<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="11%" valign=top style='width:11.78%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="llSumS" id="长期负债合计" name='"长期负债合计"' style="width: 98%; "
			maxlength="15" style='text-align:right' readonly="readonly" ></label>
  </o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.8%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.5pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;mso-border-right-alt:solid black 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="llSumE" id="_长期负债合计" name='"_长期负债合计"' style="width: 98%; "
			maxlength="15" style='text-align:right' readonly="readonly" ></label>
  </o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:18;height:17.25pt'>
  <td width="25%" valign=top style='width:25.64%;border-top:none;border-left:
  solid black 1.5pt;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-alt:solid black .75pt;
  mso-border-left-alt:solid black 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;height:
  17.25pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><span
  style='mso-spacerun:yes'>&nbsp; </span></span><span style='font-size:10.5pt;
  font-family:楷体_GB2312;mso-hansi-font-family:宋体;color:black'>固定资产原价<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="11%" valign=top style='width:11.78%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="faPrimeCostS" id="固定资产原价" name='"固定资产原价"' style="width: 98%; "
				maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,''); " />
  </o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.58%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="faPrimeCostE" id="_固定资产原价" name='"_固定资产原价"' style="width: 98%; "
				maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,''); " />
  </o:p></span></p>
  </td>
  <td width="27%" valign=top style='width:27.42%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid windowtext 1.5pt;
  mso-border-alt:solid black .75pt;mso-border-left-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal style='text-indent:20.8pt;mso-char-indent-count:2.0;
  line-height:16.0pt;mso-line-height-rule:exactly;text-autospace:none'><span
  lang=EN-US style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:
  宋体;color:black'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.78%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.8%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.5pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;mso-border-right-alt:solid black 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>&nbsp;</o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:19;height:17.25pt'>
  <td width="25%" valign=top style='width:25.64%;border-top:none;border-left:
  solid black 1.5pt;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-alt:solid black .75pt;
  mso-border-left-alt:solid black 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;height:
  17.25pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><span
  style='mso-spacerun:yes'>&nbsp; </span></span><span style='font-size:10.5pt;
  font-family:楷体_GB2312;mso-hansi-font-family:宋体;color:black'>减：累计折旧<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="11%" valign=top style='width:11.78%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="faAccumulatedDepreciationS" id="减：累计折旧" name='"减：累计折旧"' style="width: 98%; "
				maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,''); " />
  </o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.58%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="faAccumulatedDepreciationE" id="_减：累计折旧" name='"_减：累计折旧"' style="width: 98%; "
				maxmaxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,''); " />
  </o:p></span></p>
  </td>
  <td width="27%" valign=top style='width:27.42%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid windowtext 1.5pt;
  mso-border-alt:solid black .75pt;mso-border-left-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal style='text-indent:10.4pt;mso-char-indent-count:1.0;
  line-height:16.0pt;mso-line-height-rule:exactly;text-autospace:none'><span
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'>受托代理负债：<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="11%" valign=top style='width:11.78%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.8%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.5pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;mso-border-right-alt:solid black 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>&nbsp;</o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:20;height:17.25pt'>
  <td width="25%" valign=top style='width:25.64%;border-top:none;border-left:
  solid black 1.5pt;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-alt:solid black .75pt;
  mso-border-left-alt:solid black 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;height:
  17.25pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><span
  style='mso-spacerun:yes'>&nbsp; </span></span><span style='font-size:10.5pt;
  font-family:楷体_GB2312;mso-hansi-font-family:宋体;color:black'>固定资产净值<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="11%" valign=top style='width:11.78%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="faNetValueS" id="固定资产净值" name='"固定资产净值"' style="width: 98%; "
				maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,''); " />
  </o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.58%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="faNetValueE" id="_固定资产净值" name='"_固定资产净值"' style="width: 98%; "
				maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,''); " />
  </o:p></span></p>
  </td>
  <td width="27%" valign=top style='width:27.42%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid windowtext 1.5pt;
  mso-border-alt:solid black .75pt;mso-border-left-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><span
  style='mso-spacerun:yes'>&nbsp; </span></span><span style='font-size:10.5pt;
  font-family:楷体_GB2312;mso-hansi-font-family:宋体;color:black'>受托代理负债<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="11%" valign=top style='width:11.78%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="paDebtS" id="受托代理负债" name='"受托代理负债"' style="width: 98%; "
				maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,''); " />
  </o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.8%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.5pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;mso-border-right-alt:solid black 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="paDebtE" id="_受托代理负债" name='"_受托代理负债"' style="width: 98%; "
				maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,''); " />
  </o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:21;height:17.25pt'>
  <td width="25%" valign=top style='width:25.64%;border-top:none;border-left:
  solid black 1.5pt;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-alt:solid black .75pt;
  mso-border-left-alt:solid black 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;height:
  17.25pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><span
  style='mso-spacerun:yes'>&nbsp; </span></span><span style='font-size:10.5pt;
  font-family:楷体_GB2312;mso-hansi-font-family:宋体;color:black'>在建工程<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="11%" valign=top style='width:11.78%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="faConstructionInProcessS" id="在建工程" name='"在建工程"' style="width: 98%; "
				maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,''); " />
  </o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.58%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="faConstructionInProcessE" id="_在建工程" name='"_在建工程"' style="width: 98%; "
				maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,''); " />
  </o:p></span></p>
  </td>
  <td width="27%" valign=top style='width:27.42%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid windowtext 1.5pt;
  mso-border-alt:solid black .75pt;mso-border-left-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.78%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.8%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.5pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;mso-border-right-alt:solid black 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>&nbsp;</o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:22;height:17.25pt'>
  <td width="25%" valign=top style='width:25.64%;border-top:none;border-left:
  solid black 1.5pt;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-alt:solid black .75pt;
  mso-border-left-alt:solid black 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;height:
  17.25pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><span
  style='mso-spacerun:yes'>&nbsp; </span></span><span style='font-size:10.5pt;
  font-family:楷体_GB2312;mso-hansi-font-family:宋体;color:black'>文物文化资产<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="11%" valign=top style='width:11.78%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="faCulturalHeritageS" id="文物文化资产" name='"文物文化资产"' style="width: 98%; "
				maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,''); " />
  </o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.58%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="faCulturalHeritageE" id="_文物文化资产" name='"_文物文化资产"' style="width: 98%; "
				maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,''); " />
  </o:p></span></p>
  </td>
  <td width="27%" valign=top style='width:27.42%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid windowtext 1.5pt;
  mso-border-alt:solid black .75pt;mso-border-left-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp; </span></span><span
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'>负债合计<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="11%" valign=top style='width:11.78%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="paSumS" id="负债合计" name='"负债合计"' style="width: 98%; "
			maxlength="15" style='text-align:right' readonly="readonly" ></label>
  </o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.8%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.5pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;mso-border-right-alt:solid black 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="paSumE" id="_负债合计" name='"_负债合计"' style="width: 98%; "
				maxlength="15" style='text-align:right' readonly="readonly" ></label>
  </o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:23;height:17.25pt'>
  <td width="25%" valign=top style='width:25.64%;border-top:none;border-left:
  solid black 1.5pt;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-alt:solid black .75pt;
  mso-border-left-alt:solid black 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;height:
  17.25pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><span
  style='mso-spacerun:yes'>&nbsp; </span></span><span style='font-size:10.5pt;
  font-family:楷体_GB2312;mso-hansi-font-family:宋体;color:black'>固定资产清理<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="11%" valign=top style='width:11.78%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="faDisposalFixedAssetsS" id="固定资产清理" name='"固定资产清理"' style="width: 98%; "
			maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,''); "	 />
  </o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.58%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="faDisposalFixedAssetsE" id="_固定资产清理" name='"_固定资产清理"' style="width: 98%; "
				maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,''); " />
  </o:p></span></p>
  </td>
  <td width="27%" valign=top style='width:27.42%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid windowtext 1.5pt;
  mso-border-alt:solid black .75pt;mso-border-left-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.78%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.8%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.5pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;mso-border-right-alt:solid black 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>&nbsp;</o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:24;height:17.25pt'>
  <td width="25%" valign=top style='width:25.64%;border-top:none;border-left:
  solid black 1.5pt;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-alt:solid black .75pt;
  mso-border-left-alt:solid black 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;height:
  17.25pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><span
  style='mso-spacerun:yes'>&nbsp; </span></span><span style='font-size:10.5pt;
  font-family:楷体_GB2312;mso-hansi-font-family:宋体;color:black'>固定资产合计<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="11%" valign=top style='width:11.78%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="faSumS" id="固定资产合计" name='"固定资产合计"' style="width: 98%; "
			maxlength="15" style='text-align:right' readonly="readonly"	 ></label>
  </o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.58%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="faSumE" id="_固定资产合计" name='"_固定资产合计"' style="width: 98%; "
				maxlength="15" style='text-align:right' readonly="readonly"></label>
  </o:p></span></p>
  </td>
  <td width="27%" valign=top style='width:27.42%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid windowtext 1.5pt;
  mso-border-alt:solid black .75pt;mso-border-left-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.78%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.8%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.5pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;mso-border-right-alt:solid black 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>&nbsp;</o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:25;height:17.25pt'>
  <td width="25%" valign=top style='width:25.64%;border-top:none;border-left:
  solid black 1.5pt;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-alt:solid black .75pt;
  mso-border-left-alt:solid black 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;height:
  17.25pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.78%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.58%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="27%" valign=top style='width:27.42%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid windowtext 1.5pt;
  mso-border-alt:solid black .75pt;mso-border-left-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.78%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.8%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.5pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;mso-border-right-alt:solid black 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>&nbsp;</o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:26;height:17.25pt'>
  <td width="25%" valign=top style='width:25.64%;border-top:none;border-left:
  solid black 1.5pt;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-alt:solid black .75pt;
  mso-border-left-alt:solid black 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;height:
  17.25pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span style='font-size:10.5pt;font-family:楷体_GB2312;
  mso-hansi-font-family:宋体;color:black'>无形资产：<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="11%" valign=top style='width:11.78%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.58%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="27%" valign=top style='width:27.42%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid windowtext 1.5pt;
  mso-border-alt:solid black .75pt;mso-border-left-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.78%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.8%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.5pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;mso-border-right-alt:solid black 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>&nbsp;</o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:27;height:17.25pt'>
  <td width="25%" valign=top style='width:25.64%;border-top:none;border-left:
  solid black 1.5pt;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-alt:solid black .75pt;
  mso-border-left-alt:solid black 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;height:
  17.25pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><span
  style='mso-spacerun:yes'>&nbsp; </span></span><span style='font-size:10.5pt;
  font-family:楷体_GB2312;mso-hansi-font-family:宋体;color:black'>无形资产<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="11%" valign=top style='width:11.78%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="intangibleAssetsS" id="无形资产" name='"无形资产"' style="width: 98%; "
				maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,''); " />
  </o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.58%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="intangibleAssetsE" id="_无形资产" name='"_无形资产"' style="width: 98%; "
			maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,''); "	 />
  </o:p></span></p>
  </td>
  <td width="27%" valign=top style='width:27.42%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid windowtext 1.5pt;
  mso-border-alt:solid black .75pt;mso-border-left-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span style='font-size:10.5pt;font-family:楷体_GB2312;
  mso-hansi-font-family:宋体;color:black'>净资产：<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="11%" valign=top style='width:11.78%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.8%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.5pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;mso-border-right-alt:solid black 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>&nbsp;</o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:28;height:17.25pt'>
  <td width="25%" valign=top style='width:25.64%;border-top:none;border-left:
  solid black 1.5pt;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-alt:solid black .75pt;
  mso-border-left-alt:solid black 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;height:
  17.25pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.78%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.58%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="27%" valign=top style='width:27.42%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid windowtext 1.5pt;
  mso-border-alt:solid black .75pt;mso-border-left-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><span
  style='mso-spacerun:yes'>&nbsp; </span></span><span style='font-size:10.5pt;
  font-family:楷体_GB2312;mso-hansi-font-family:宋体;color:black'>非限定性净资产<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="11%" valign=top style='width:11.78%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="unlimitNetAssetsS" id="非限定性净资产" name='"非限定性净资产"' style="width: 98%; "
				maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,''); " />
  </o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.8%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.5pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;mso-border-right-alt:solid black 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:17.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="unlimitNetAssetsE" id="_非限定性净资产" name='"_非限定性净资产"' style="width: 98%; "
			maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,''); "	 />
  </o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:29;height:3.25pt'>
  <td width="25%" valign=top style='width:25.64%;border-top:none;border-left:
  solid black 1.5pt;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-alt:solid black .75pt;
  mso-border-left-alt:solid black 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;height:
  3.25pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span style='font-size:10.5pt;font-family:楷体_GB2312;
  mso-hansi-font-family:宋体'>受托代理资产：<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="11%" valign=top style='width:11.78%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;padding:0cm 1.5pt 0cm 1.5pt;height:3.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.58%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:3.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="27%" valign=top style='width:27.42%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid windowtext 1.5pt;
  mso-border-alt:solid black .75pt;mso-border-left-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:3.25pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><span
  style='mso-spacerun:yes'>&nbsp; </span></span><span style='font-size:10.5pt;
  font-family:楷体_GB2312;mso-hansi-font-family:宋体;color:black'>限定性净资产<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="11%" valign=top style='width:11.78%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;padding:0cm 1.5pt 0cm 1.5pt;height:3.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="limitNetAssetsS" id="限定性净资产" name='"限定性净资产"' style="width: 98%; "
			maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,''); "	 />
  </o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.8%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.5pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;mso-border-right-alt:solid black 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:3.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="limitNetAssetsE" id="_限定性净资产" name='"_限定性净资产"' style="width: 98%; "
			maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,''); "	 />
  </o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:30;height:3.25pt'>
  <td width="25%" valign=top style='width:25.64%;border-top:none;border-left:
  solid black 1.5pt;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-alt:solid black .75pt;
  mso-border-left-alt:solid black 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;height:
  3.25pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体'><span style='mso-spacerun:yes'>&nbsp;
  </span></span><span style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:
  宋体'>受托代理资产<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="11%" valign=top style='width:11.78%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;padding:0cm 1.5pt 0cm 1.5pt;height:3.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="entrustedAgentAssetsS" id="受托代理资产" name='"受托代理资产"' style="width: 98%; "
				maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,''); " />
  </o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.58%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:3.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="entrustedAgentAssetsE" id="_受托代理资产" name='"_受托代理资产"' style="width: 98%; "
				maxlength="15" style='text-align:right' onkeyup="value=value.replace(/[^\d.-]/g,''); " />
  </o:p></span></p>
  </td>
  <td width="27%" valign=top style='width:27.42%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid windowtext 1.5pt;
  mso-border-alt:solid black .75pt;mso-border-left-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:3.25pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><span
  style='mso-spacerun:yes'>&nbsp; </span></span><span style='font-size:10.5pt;
  font-family:楷体_GB2312;mso-hansi-font-family:宋体;color:black'>净资产合计<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="11%" valign=top style='width:11.78%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;padding:0cm 1.5pt 0cm 1.5pt;height:3.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="netAssetsSumS" id="净资产合计" name='"净资产合计"' style="width: 98%; "
				maxlength="15" style='text-align:right' readonly="readonly" ></label>
  </o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.8%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.5pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;mso-border-right-alt:solid black 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:3.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="netAssetsSumE" id="_净资产合计" name='"_净资产合计"' style="width: 98%; "
				maxlength="15" style='text-align:right' readonly="readonly" ></label>
  </o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:31;height:3.25pt'>
  <td width="25%" valign=top style='width:25.64%;border-top:none;border-left:
  solid black 1.5pt;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-alt:solid black .75pt;
  mso-border-left-alt:solid black 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;height:
  3.25pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.78%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;padding:0cm 1.5pt 0cm 1.5pt;height:3.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.58%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:3.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="27%" valign=top style='width:27.42%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid windowtext 1.5pt;
  mso-border-alt:solid black .75pt;mso-border-left-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:3.25pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.78%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;padding:0cm 1.5pt 0cm 1.5pt;height:3.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>&nbsp;</o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.8%;border-top:none;border-left:
  none;border-bottom:solid black 1.0pt;border-right:solid black 1.5pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;mso-border-right-alt:solid black 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:3.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>&nbsp;</o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:32;mso-yfti-lastrow:yes;height:3.25pt'>
  <td width="25%" valign=top style='width:25.64%;border-top:none;border-left:
  solid black 1.5pt;border-bottom:solid windowtext 1.5pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-top-alt:black .75pt;
  mso-border-left-alt:black 1.5pt;mso-border-bottom-alt:windowtext 1.5pt;
  mso-border-right-alt:black .75pt;mso-border-style-alt:solid;padding:0cm 1.5pt 0cm 1.5pt;
  height:3.25pt'>
  <p class=MsoNormal align=center style='text-align:center;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span style='font-size:
  10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;color:black'>资产总计<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="11%" valign=top style='width:11.78%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.5pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;mso-border-bottom-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:3.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="assetsSumS" id="资产总计" name='"资产总计"' style="width: 98%; "
				maxlength="15" style='text-align:right' readonly="readonly" ></label>
  </o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.58%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.5pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:3.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="assetsSumE" id="_资产总计" name='"_资产总计"' style="width: 98%; "
				maxlength="15" style='text-align:right' readonly="readonly" ></label>
  </o:p></span></p>
  </td>
  <td width="27%" valign=top style='width:27.42%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.5pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid windowtext 1.5pt;
  mso-border-top-alt:black .75pt;mso-border-left-alt:windowtext 1.5pt;
  mso-border-bottom-alt:windowtext 1.5pt;mso-border-right-alt:black .75pt;
  mso-border-style-alt:solid;padding:0cm 1.5pt 0cm 1.5pt;height:3.25pt'>
  <p class=MsoNormal align=center style='text-align:center;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span style='font-size:
  10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;color:black'>负债和净资产总计<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="11%" valign=top style='width:11.78%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.5pt;border-right:solid black 1.0pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  mso-border-alt:solid black .75pt;mso-border-bottom-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:3.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="debtAssetsSumS" id="负债和净资产总计" name='"负债和净资产总计"' style="width: 98%; "
				maxlength="15" style='text-align:right' readonly="readonly" ></label>
  </o:p></span></p>
  </td>
  <td width="11%" valign=top style='width:11.8%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.5pt;border-right:solid black 1.5pt;
  mso-border-top-alt:solid black .75pt;mso-border-left-alt:solid black .75pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:3.25pt'>
  <p class=MsoNormal align=right style='text-align:right;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
  <label field="debtAssetsSumE" id="_负债和净资产总计" name='"_负债和净资产总计"' style="width: 98%; "
				maxlength="15" style='text-align:right' readonly="readonly" ></label>
  </o:p></span></p>
  </td>
 </tr>
</table>

</div>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</form>
</div>
</div>
</body>
</html>
