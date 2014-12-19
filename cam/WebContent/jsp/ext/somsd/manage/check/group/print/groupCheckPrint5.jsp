<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>

<script language="javascript">
			//var taskCode='<%=request.getParameter("taskCode")%>';
		 	//初始化
			function init5(){
				var somCheckBalanceSheetDataSet = L5.DatasetMgr.lookup("somCheckBalanceSheetDataSet");
				somCheckBalanceSheetDataSet.setParameter("TASK_CODE@=", taskCode);
				somCheckBalanceSheetDataSet.load();
				somCheckBalanceSheetDataSet.on("load",function(ds){
					if(ds.getCount()==0){
						somCheckBalanceSheetDataSet.newRecord();
					}
					PROGRESS_BAR++;
				});
				//创建页面导航下拉框
				//createGroupDetailSelect();
			}
	//打印
	function docPrint(){
		document.execCommand("Print", false);
	}
		</script>
<style media="print">
	.noprint     { display: none }
</style>

<model:datasets>
	<model:dataset id="somCheckBalanceSheetDataSet" cmd="com.inspur.cams.sorg.check.balancesheet.cmd.SomCheckBalanceSheetQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.balancesheet.data.SomCheckBalanceSheet"></model:record>
	</model:dataset>
</model:datasets>
<div id="float" class="noprint" style='height:15px;'>	

</div>
<div align=center width="610px" style='page-break-after:always'>
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
<div align=center width="610pxpx">
<form method="post" dataset="somCheckBalanceSheetDataSet" onsubmit="return false">

<p style='margin: 0 auto; line-height: 20.0pt;'><span
	style='font-size: 14.0pt; font-family: 宋体; color: black'>编制单位： 
	<label  field="organizationUnit" style="width:240;text-align:left;"></label>
	<span lang=EN-US><span
	style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></span>
单位：元<span lang=EN-US><o:p></o:p></span></span></p>

<table border=0 cellspacing=0 cellpadding=0 width="610px"
	style='width: 610px; border-collapse: collapse; mso-yfti-tbllook: 191; mso-padding-alt: 0cm 1.5pt 0cm 1.5pt; mso-border-insideh: .75pt solid black; mso-border-insidev: .75pt solid black'>
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
		<p  align=right
			style='text-align: right; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p align=right
			style='text-align: right;  mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
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
		<p  align=right
			style='text-align: right;  mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
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
			<label  field="caMoneyfundsS" style="width:98%"/></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label  field="caMoneyfundsE" style="width:98%"/></p>
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
			style='text-align: right;  mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label  field="clShorttermBorrowingS" style="width:98%"/></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p align=right
			style='text-align: right;  mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label  field="clShorttermBorrowingE" style="width:98%"/></p>
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
			style='text-align: right;  mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label  field="caLiquidInvestmentS" style="width:98%"/></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right;  mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label  field="caLiquidInvestmentE" style="width:98%"/></p>
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
			style='text-align: right;  mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label  field="clDuesS" style="width:98%"/></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right;  mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label  field="clDuesE" style="width:98%"/></p>
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
			<label  field="caReceivablesS" style="width:98%"/></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label  field="caReceivablesE" style="width:98%"/></p>
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
			<label  field="clAccruedPayrollsS" style="width:98%"/></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label  field="clAccruedPayrollsE" style="width:98%"/></p>
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
			<label  field="caAdvanceMoneyS" style="width:98%"/></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label  field="caAdvanceMoneyE" style="width:98%"/></p>
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
			<label  field="clTasPayableS" style="width:98%"/></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label  field="clTasPayableE" style="width:98%"/>
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
			<label  field="caInventoryS" style="width:98%"/>
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label  field="caInventoryE" style="width:98%"/>
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
			<label  field="clDepositReceivedS" style="width:98%"/>
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label  field="clDepositReceivedE" style="width:98%"/>
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
			<label  field="caDeferredExpensesS" style="width:98%"/>
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label  field="caDeferredExpensesE" style="width:98%"/>
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
			<label  field="clAccruedExpensesS" style="width:98%"/>
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label  field="clAccruedExpensesE" style="width:98%"/>
		</p>
		</td>
	</tr>
	<tr style='height: 34.0pt'>
		<td width="25%" valign=middle
			style='width: 25.64%; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 34.0pt'>
		<p class=MsoNormal
			style=' mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>一年内到期的长期债权投资<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 34.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right;  mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label  field="caDebtInvestmentsS" style="width:98%"/>
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 34.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right;  mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label  field="caDebtInvestmentsE" style="width:98%"/>
		</p>
		</td>
		<td width="27%" valign=middle
			style='width: 27.42%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 34.0pt'>
		<p class=MsoNormal
			style='text-indent: 12.0pt; mso-char-indent-count: 1.0;  mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>预计负债<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 34.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label  field="clAccruedLiabilitiesS" style="width:98%"/>
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 34.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right;mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label  field="clAccruedLiabilitiesE" style="width:98%"/>
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
			<label  field="caOthersS" style="width:98%"/>
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label  field="caOthersE" style="width:98%"/>
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
			<label  field="clLongtermDueS" style="width:98%"/>
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label  field="clLongtermDueE" style="width:98%"/>
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
			<label  field="caSumS" style="width:98%"/>
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label  field="caSumE" style="width:98%"/>
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
			<label  field="clOthersS" style="width:98%"/>
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label  field="clOthersE" style="width:98%"/>
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
			<label  field="clSumS" style="width:98%"/>
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label  field="clSumE" style="width:98%"/>
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
			<label  field="piLongtermEquityInvS" style="width:98%"/>
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label  field="piLongtermEquityInvE" style="width:98%"/>
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
			<label  field="piLongtermDebtInvS" style="width:98%"/>
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label  field="piLongtermDebtInvE" style="width:98%"/>
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
			<label  field="llLongtermLoansS" style="width:98%"/>
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label  field="llLongtermLoansE" style="width:98%"/>
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
			<label  field="piSumS" style="width:98%"/>
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label  field="piSumE" style="width:98%"/>
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
			<label  field="llLongtermPayableS" style="width:98%"/>
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label  field="llLongtermPayableE" style="width:98%"/>
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
			<label  field="llOthersS" style="width:98%"/>
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label  field="llOthersE" style="width:98%"/>
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
			<label  field="llSumS" style="width:98%"/>
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label  field="llSumE" style="width:98%"/>
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
			<label  field="faPrimeCostS" style="width:98%"/>
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label  field="faPrimeCostE" style="width:98%"/>
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
			<label  field="faAccumulatedDepreciationS" style="width:98%"/>
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label  field="faAccumulatedDepreciationE" style="width:98%"/>
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
			<label  field="faNetValueS" style="width:98%"/>
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label  field="faNetValueE" style="width:98%"/>
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
			<label  field="paDebtS" style="width:98%"/>
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label  field="paDebtE" style="width:98%"/>
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
			<label  field="faConstructionInProcessS" style="width:98%"/>
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label  field="faConstructionInProcessE" style="width:98%"/>
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
			<label  field="faCulturalHeritageS" style="width:98%"/>
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label  field="faCulturalHeritageE" style="width:98%"/>
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
			<label  field="paSumS" style="width:98%"/>
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label  field="paSumE" style="width:98%"/>
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
			<label  field="faDisposalFixedAssetsS" style="width:98%"/>
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label  field="faDisposalFixedAssetsE" style="width:98%"/>
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
			<label  field="faSumS" style="width:98%"/>
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label  field="faSumE" style="width:98%"/>
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
			<label  field="intangibleAssetsS" style="width:98%"/>
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label  field="intangibleAssetsE" style="width:98%"/>
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
			<label  field="unlimitNetAssetsS" style="width:98%"/>
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label  field="unlimitNetAssetsE" style="width:98%"/>
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
			<label  field="limitNetAssetsS" style="width:98%"/>
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label  field="limitNetAssetsE" style="width:98%"/>
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
			<label  field="entrustedAgentAssetsS" style="width:98%"/>
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label  field="entrustedAgentAssetsE" style="width:98%"/>
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
			<label  field="netAssetsSumS" style="width:98%"/>
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label  field="netAssetsSumE" style="width:98%"/>
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
			<label  field="assetsSumS" style="width:98%"/>
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label  field="assetsSumE" style="width:98%"/>
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
			<label  field="debtAssetsSumS" style="width:98%"/>
		</p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<label  field="debtAssetsSumE" style="width:98%"/>
		</p>
		</td>
	</tr>
</table>
</form>
</div>

<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>

</div>
