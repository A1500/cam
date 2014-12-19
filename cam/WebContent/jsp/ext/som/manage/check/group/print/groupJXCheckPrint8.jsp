<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<script language="javascript">
//初始化
function init8(){
	var somJxCheckBalanceSheetDataSet = L5.DatasetMgr.lookup("somJxCheckBalanceSheetDataSet");
	somJxCheckBalanceSheetDataSet.setParameter("TASK_CODE@=", taskCode);
	somJxCheckBalanceSheetDataSet.load();
	somJxCheckBalanceSheetDataSet.on("load",function(ds){
		if(ds.getCount()==0){
			somJxCheckBalanceSheetDataSet.newRecord();
		}
		PROGRESS_BAR++;
	});
}
</script>
<model:datasets>
	<model:dataset id="somJxCheckBalanceSheetDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxcheckbalancesheet.cmd.SomJxCheckBalanceSheetQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxcheckbalancesheet.dao.SomJxCheckBalanceSheet"></model:record>
	</model:dataset>
</model:datasets>
<div style='page-break-after:always'>
<div id="float_1" class="noprint">

</div>
<div align=center>
<div style="width:700;text-align:center">

<p  align="left"><b><span
	style='font-size: 16.0pt; font-family: 黑体; '>七、财务报表<span
	lang=EN-US> <o:p></o:p></span></span></b></p>

<p class=MsoNormal align=center
	style='text-align: center; line-height: 24.0pt; mso-line-height-rule: exactly'><b
	style='mso-bidi-font-weight: normal'><span lang=EN-US
	style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>1.</span></b><b
	style='mso-bidi-font-weight: normal'><span
	style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>资产负债表<span
	lang=EN-US><o:p></o:p></span></span></b></p>

<p class=MsoNormal align=center
	style='text-align: center; line-height: 24.0pt; mso-line-height-rule: exactly'><b
	style='mso-bidi-font-weight: normal'><span lang=EN-US
	style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
	style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></b><span
	style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>单位：元<span
	lang=EN-US><o:p></o:p></span></span></p>

<div align=center>
<form method="post" dataset="somJxCheckBalanceSheetDataSet" onsubmit="return false">
<table class=MsoNormalTable border=0 cellspacing=0 cellpadding=0
	style='border-collapse: collapse; mso-padding-alt: 0cm 1.5pt 0cm 1.5pt; mso-border-insideh: .75pt solid black; mso-border-insidev: .75pt solid black'>
	<tr style='mso-yfti-irow: 0; mso-yfti-firstrow: yes; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid windowtext 1.5pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>资<span
			lang=EN-US><span style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;
		</span></span>产<span lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>行次<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>年初数<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: windowtext 1.5pt; mso-border-left-alt: black .75pt; mso-border-bottom-alt: black .75pt; mso-border-right-alt: windowtext 1.5pt; mso-border-style-alt: solid; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>期末数<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-top-alt: windowtext 1.5pt; mso-border-left-alt: windowtext 1.5pt; mso-border-bottom-alt: black .75pt; mso-border-right-alt: black .75pt; mso-border-style-alt: solid; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>负债和净资产<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>行次<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>年初数<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid black 1.0pt; border-right: none; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid windowtext 1.5pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>期末数<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 1; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>流动资产：<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>流动负债：<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 2; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>货币资金<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>1<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="caMoneyfundsS" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="caMoneyfundsE" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>短期借款<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>61<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="clShorttermBorrowingS" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="clShorttermBorrowingE" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 3; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>短期投资<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>2<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="caLiquidInvestmentS" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="caLiquidInvestmentE" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>应付款项<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>62<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="clDuesS" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="clDuesE" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 4; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>应收款项<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>3<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="caReceivablesS" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="caReceivablesE" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>应付工资<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>63<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="clAccruedPayrollsS" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="clAccruedPayrollsE" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 5; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='text-indent: 14.0pt; mso-char-indent-count: 1.0; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>预付账款<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>4<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="caAdvanceMoneyS" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="caAdvanceMoneyE" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>应交税金<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>65<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="clTasPayableS" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="clTasPayableE" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 6; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>存<span
			lang=EN-US><span style='mso-spacerun: yes'>&nbsp; </span></span>货<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>8<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="caInventoryS" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="caInventoryE" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='text-indent: 14.0pt; mso-char-indent-count: 1.0; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>预收账款<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>66<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="clDepositReceivedS" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="clDepositReceivedE" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 7; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>待摊费用<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>9<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="caDeferredExpensesS" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="caDeferredExpensesE" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='text-indent: 14.0pt; mso-char-indent-count: 1.0; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>预提费用<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>71<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="clAccruedExpensesS" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="clAccruedExpensesE" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 8; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>一年内到期的长期债权投资<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>15<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="caDebtInvestmentsS" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="caDebtInvestmentsE" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='text-indent: 14.0pt; mso-char-indent-count: 1.0; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>预计负债<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>72<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="clAccruedLiabilitiesS" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="clAccruedLiabilitiesE" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 9; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>其他流动资产<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>18<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="caOthersS" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="caOthersE" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>一年内到期的长期负债<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>74<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="clLongtermDueS" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="clLongtermDueE" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 10; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>流动资产合计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>20<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="caSumS" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="caSumE" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>其他流动负债<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>78<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="clOthersS" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="clOthersE" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 11; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt;  height: 10.1pt'>
		<p class=MsoNormal
			style='text-indent: 22.0pt; mso-char-indent-count: 2.0; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>流动负债合计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>80<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="clSumS" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="clSumE" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 12; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>长期投资：<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='text-indent: 28.0pt; mso-char-indent-count: 2.0; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 13; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>长期股权投资<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>21<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="piLongtermEquityInvS" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="piLongtermEquityInvE" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>长期负债：<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 14; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>长期债权投资<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>24<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="piLongtermDebtInvS" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="piLongtermDebtInvE" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>长期借款<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>81<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="llLongtermLoansS" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="llLongtermLoansE" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 15; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>长期投资合计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>30<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="piSumS" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="piSumE" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>长期应付款<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>84<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="llLongtermPayableS" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="llLongtermPayableE" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 16; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>其他长期负债<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>88<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="llOthersS" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="llOthersE" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 17; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>固定资产：<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='text-indent: 22.0pt; mso-char-indent-count: 2.0; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>长期负债合计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>90<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="llSumS" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="llSumE" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 18; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>固定资产原价<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>31<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="faPrimeCostS" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="faPrimeCostE" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='text-indent: 28.0pt; mso-char-indent-count: 2.0; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 19; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>减：累计折旧<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>32<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="faAccumulatedDepreciationS" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="faAccumulatedDepreciationE" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>受托代理负债：<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 20; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>固定资产净值<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>33<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="faNetValueS" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="faNetValueE" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>受托代理负债<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>91<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="paDebtS" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="paDebtE" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 21; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>在建工程<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>34<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="faConstructionInProcessS" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="faConstructionInProcessE" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 22; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>文物文化资产<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>35<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="faCulturalHeritageS" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="faCulturalHeritageE" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>负债合计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>100<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="paSumS" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="paSumE" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 23; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>固定资产清理<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>38<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="faDisposalFixedAssetsS" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="faDisposalFixedAssetsE" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 24; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>固定资产合计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>40<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="faSumS" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="faSumE" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 25; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 26; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>无形资产：<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 27; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>无形资产<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>41<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="intangibleAssetsS" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="intangibleAssetsE" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>净资产：<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 28; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>非限定性净资产<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>101<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="unlimitNetAssetsS" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="unlimitNetAssetsE" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 29; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>受托代理资产：<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>限定性净资产<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>105<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="limitNetAssetsS" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="limitNetAssetsE" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 30; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>受托代理资产<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>51<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="entrustedAgentAssetsS" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="entrustedAgentAssetsE" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>净资产合计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>110<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="netAssetsSumS" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="netAssetsSumE" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 31; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 32; mso-yfti-lastrow: yes; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid windowtext 1.5pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>资产总计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-bottom-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>60<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-bottom-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="assetsSumS" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="assetsSumE" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-top-alt: black .75pt; mso-border-left-alt: windowtext 1.5pt; mso-border-bottom-alt: windowtext 1.5pt; mso-border-right-alt: black .75pt; mso-border-style-alt: solid; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>负债和净资产总计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-bottom-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>120<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-bottom-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="debtAssetsSumS" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="debtAssetsSumE" style='font-size: 14px; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
		</o:p></span></p>
		</td>
	</tr>
</table>
</form>
</div>
</div>
</div>
</div>