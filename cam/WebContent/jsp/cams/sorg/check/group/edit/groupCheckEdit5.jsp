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
				createGroupEditSelect();
			}
			function save(){
				var somCheckBalanceSheetRecord=somCheckBalanceSheetDataSet.getCurrent();
				var command = new L5.Command("com.inspur.cams.sorg.check.somcheck.cmd.SomCheckCommand");
				command.setParameter("somCheckBalanceSheetRecord", somCheckBalanceSheetRecord);
				command.setParameter("taskCode", taskCode);
				command.execute("savePage5");
				if (!command.error) {
					L5.Msg.alert("提示","保存成功！",function(){
					});		
				}else{
					L5.Msg.alert('提示',"保存时出现错误！"+command.error);
				}
			}
			function nextPage(){
				save();
				var data = new L5.Map();
				var url='jsp/cams/sorg/check/group/edit/groupCheckEdit6.jsp';
				data.put("taskCode",taskCode);
				var text = '年检列表';
				L5.forward(url,text,data);
			}
			function back(){
				var data = new L5.Map();
				var url='jsp/cams/sorg/check/group/somchecktask/somchecktask_list.jsp';
				var text = '年检列表';
				L5.forward(url,text,data);
			}
		</script>
</head>

<body>
<model:datasets>
	<model:dataset id="somCheckBalanceSheetDataSet" cmd="com.inspur.cams.sorg.check.balancesheet.cmd.SomCheckBalanceSheetQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.balancesheet.data.SomCheckBalanceSheet"></model:record>
	</model:dataset>
</model:datasets>
<div id="float"><!--[if lte IE 7]><div></div><![endif]--> <input
	type="button" value="下一页"
	style="height: 25px; width: 80px; position: absolute; margin-left: 20px;" onclick="nextPage()"/>
<!--[if lte IE 7]><div></div><![endif]--> <input type="button"
	value="保存"
	style="height: 25px; width: 80px; position: absolute; margin-left: 120px;"
	onclick="save();" /> <!--[if lte IE 7]><div></div><![endif]--> <input
	type="button" value="返回"
	style="height: 25px; width: 80px; position: absolute; margin-left: 220px;"
	onclick="back();" />
</div>
<div align=center style='layout-grid: 15.6pt' width="800">

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
	style='font-size: 14.0pt; font-family: 宋体; color: black'>（截止到本年度<span
	lang=EN-US>12</span>月<span lang=EN-US>31</span>日）<span lang=EN-US><o:p></o:p></span></span></p>
<div align=center width="800px">
<form method="post" dataset="somCheckBalanceSheetDataSet" onsubmit="return false">

<p style='margin: 0 auto; line-height: 20.0pt;'><span
	style='font-size: 14.0pt; font-family: 宋体; color: black'>编制单位： 
	<input type="text" name='编制单位' field="organizationUnit" style="width: 200" maxlength="250" /> 
	<span lang=EN-US><span
	style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></span>
单位：元<span lang=EN-US><o:p></o:p></span></span></p>

<table border=0 cellspacing=0 cellpadding=0 width="800"
	style='width: 800px; border-collapse: collapse; mso-yfti-tbllook: 191; mso-padding-alt: 0cm 1.5pt 0cm 1.5pt; mso-border-insideh: .75pt solid black; mso-border-insidev: .75pt solid black'>
	<tr style='height: 17.0pt'>
		<td width="25%" valign=top
			style='width: 25.64%; border-top: windowtext 1.5pt; border-left: black 1.5pt; border-bottom: black 1.0pt; border-right: black 1.0pt; border-style: solid; mso-border-top-alt: windowtext 1.5pt; mso-border-left-alt: black 1.5pt; mso-border-bottom-alt: black .75pt; mso-border-right-alt: black .75pt; mso-border-style-alt: solid; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>资<span
			lang=EN-US><span style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;
		</span></span>产<span lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.78%; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>年初数<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.58%; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: windowtext 1.5pt; mso-border-left-alt: black .75pt; mso-border-bottom-alt: black .75pt; mso-border-right-alt: windowtext 1.5pt; mso-border-style-alt: solid; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>期末数<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="27%" valign=top
			style='width: 27.42%; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-top-alt: windowtext 1.5pt; mso-border-left-alt: windowtext 1.5pt; mso-border-bottom-alt: black .75pt; mso-border-right-alt: black .75pt; mso-border-style-alt: solid; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>负债和净资产<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.78%; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>年初数<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.8%; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: windowtext 1.5pt; mso-border-left-alt: black .75pt; mso-border-bottom-alt: black .75pt; mso-border-right-alt: black 1.5pt; mso-border-style-alt: solid; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>期末数<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
	</tr>
	<tr style='height: 17.0pt'>
		<td width="25%" valign=top
			style='width: 25.64%; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>流动资产：<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
		</p>
		</td>
		<td width="11%" valign=top
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="27%" valign=top
			style='width: 27.42%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>流动负债：<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 19.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='height: 17.0pt'>
		<td width="25%" valign=top
			style='width: 25.64%; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>货币资金<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
		<input type="text" name='流动资产货币资金年初数' field="caMoneyfundsS"
			style="width: 98%; text-align: right" maxlength="10" /></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
		<input type="text" name='流动资产货币资金期末数' field="caMoneyfundsE"
			style="width: 98%; text-align: right" maxlength="10" /></p>
		</td>
		<td width="27%" valign=top
			style='width: 27.42%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>短期借款<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
		<input type="text" name='短期借款' field="clShorttermBorrowingS"
			style="width: 98%; text-align: right" maxlength="10" /></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 19.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
		<input type="text" name='短期借款' field="clShorttermBorrowingE"
			style="width: 98%; text-align: right" maxlength="10" /></p>
		</td>
	</tr>
	<tr style='height: 17.0pt'>
		<td width="25%" valign=top
			style='width: 25.64%; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>短期投资<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
		<input type="text" name='短期投资' field="caLiquidInvestmentS"
			style="width: 98%; text-align: right" maxlength="10" /></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
		<input type="text" name='短期投资' field="caLiquidInvestmentE"
			style="width: 98%; text-align: right" " maxlength="10" /></p>
		</td>
		<td width="27%" valign=top
			style='width: 27.42%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>应付款项<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
		<input type="text" name='应付款项' field="clDuesS"
			style="width: 98%; text-align: right" maxlength="10" /></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 19.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
		<input type="text" name='应付款项' field="clDuesE"
			style="width: 98%; text-align: right" maxlength="10" /></p>
		</td>
	</tr>
	<tr style='height: 17.0pt'>
		<td width="25%" valign=top
			style='width: 25.64%; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>应收款项<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
		<input type="text" name='应收款项' field="caReceivablesS"
			style="width: 98%; text-align: right" maxlength="10" /></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
		<input type="text" name='应收款项' field="caReceivablesE"
			style="width: 98%; text-align: right" maxlength="10" /></p>
		</td>
		<td width="27%" valign=top
			style='width: 27.42%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>应付工资<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
		<input type="text" name='应付工资' field="clAccruedPayrollsS"
			style="width: 98%; text-align: right" maxlength="10" /></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 19.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
		<input type="text" name='应付工资' field="clAccruedPayrollsE"
			style="width: 98%; text-align: right" maxlength="10" /></p>
		</td>
	</tr>
	<tr style='height: 17.0pt'>
		<td width="25%" valign=top
			style='width: 25.64%; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal
			style='text-indent: 12.0pt; mso-char-indent-count: 1.0; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>预付账款<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
		<input type="text" name='预付账款' field="caAdvanceMoneyS"
			style="width: 98%; text-align: right" maxlength="10" /></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
		<input type="text" name='预付账款' field="caAdvanceMoneyE"
			style="width: 98%; text-align: right" maxlength="10" /></p>
		</td>
		<td width="27%" valign=top
			style='width: 27.42%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>应交税金<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
		<input type="text" name='应交税金' field="clTasPayableS"
			style="width: 98%; text-align: right" maxlength="10" /></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 19.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
		<input type="text" name='应交税金' field="clTasPayableE"
			style="width: 98%; text-align: right" maxlength="10" /></p>
		</td>
	</tr>
	<tr style='height: 17.0pt'>
		<td width="25%" valign=top
			style='width: 25.64%; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>存<span
			lang=EN-US><span style='mso-spacerun: yes'>&nbsp; </span></span>货<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='存货' field="caInventoryS" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
		<td width="11%" valign=top
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='存货' field="caInventoryE" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
		<td width="27%" valign=top
			style='width: 27.42%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal
			style='text-indent: 12.0pt; mso-char-indent-count: 1.0; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>预收账款<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='预收账款' field="clDepositReceivedS" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
		<td width="11%" valign=top
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 19.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='预收账款' field="clDepositReceivedE" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
	</tr>
	<tr style='height: 17.0pt'>
		<td width="25%" valign=top
			style='width: 25.64%; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>待摊费用<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='待摊费用' field="caDeferredExpensesS" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
		<td width="11%" valign=top
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='待摊费用' field="caDeferredExpensesE" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
		<td width="27%" valign=top
			style='width: 27.42%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal
			style='text-indent: 12.0pt; mso-char-indent-count: 1.0; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>预提费用<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='预提费用' field="clAccruedExpensesS" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
		<td width="11%" valign=top
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 19.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='预提费用' field="clAccruedExpensesE" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
	</tr>
	<tr style='height: 34.0pt'>
		<td width="25%" valign=top
			style='width: 25.64%; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 34.0pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>一年内到期的长期债权投资<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 34.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			 <input type="text" name='一年内到期的长期债权投资' field="caDebtInvestmentsS" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
		<td width="11%" valign=top
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 34.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='一年内到期的长期债权投资' field="caDebtInvestmentsE" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
		<td width="27%" valign=top
			style='width: 27.42%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 34.0pt'>
		<p class=MsoNormal
			style='text-indent: 12.0pt; mso-char-indent-count: 1.0; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>预计负债<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 34.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='预计负债' field="clAccruedLiabilitiesS" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
		<td width="11%" valign=top
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 34.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='预计负债' field="clAccruedLiabilitiesE" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
	</tr>
	<tr style='height: 15.6pt'>
		<td width="25%" valign=top
			style='width: 25.64%; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>其他流动资产<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='其他流动资产' field="caOthersS" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
		<td width="11%" valign=top
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='其他流动资产' field="caOthersE" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
		<td width="27%" valign=top
			style='width: 27.42%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>一年内到期的长期负债<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='一年内到期的长期负债' field="clLongtermDueS" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
		<td width="11%" valign=top
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='一年内到期的长期负债' field="clLongtermDueE" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
	</tr>
	<tr style='height: 15.6pt'>
		<td width="25%" valign=top
			style='width: 25.64%; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>流动资产合计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='流动资产合计' field="caSumS" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
		<td width="11%" valign=top
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='流动资产合计' field="caSumE" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
		<td width="27%" valign=top
			style='width: 27.42%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>其他流动负债<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='其他流动负债' field="clOthersS" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
		<td width="11%" valign=top
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='其他流动负债' field="clOthersE" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
	</tr>
	<tr style='height: 15.6pt'>
		<td width="25%" valign=top
			style='width: 25.64%; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="27%" valign=top
			style='width: 27.42%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='text-indent: 12.0pt; mso-char-indent-count: 1.0; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>流动负债合计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='流动负债合计' field="clSumS" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
		<td width="11%" valign=top
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='流动负债合计' field="clSumE" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
	</tr>
	<tr style='height: 15.6pt'>
		<td width="25%" valign=top
			style='width: 25.64%; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>长期投资：<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="27%" valign=top
			style='width: 27.42%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='text-indent: 24.0pt; mso-char-indent-count: 2.0; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='height: 15.6pt'>
		<td width="25%" valign=top
			style='width: 25.64%; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>长期股权投资<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='长期股权投资' field="piLongtermEquityInvS" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
		<td width="11%" valign=top
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='长期股权投资' field="piLongtermEquityInvE" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
		<td width="27%" valign=top
			style='width: 27.42%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>长期负债：<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
		</p>
		</td>
		<td width="11%" valign=top
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='height: 15.6pt'>
		<td width="25%" valign=top
			style='width: 25.64%; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>长期债权投资<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='长期债权投资' field="piLongtermDebtInvS" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
		<td width="11%" valign=top
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='长期债权投资' field="piLongtermDebtInvE" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
		<td width="27%" valign=top
			style='width: 27.42%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>长期借款<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='长期借款' field="llLongtermLoansS" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
		<td width="11%" valign=top
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='长期借款' field="llLongtermLoansE" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
	</tr>
	<tr style='height: 15.6pt'>
		<td width="25%" valign=top
			style='width: 25.64%; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>长期投资合计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='长期投资合计' field="piSumS" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
		<td width="11%" valign=top
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='长期投资合计' field="piSumE" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
		<td width="27%" valign=top
			style='width: 27.42%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>长期应付款<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='长期应付款' field="llLongtermPayableS" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
		<td width="11%" valign=top
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='长期应付款' field="llLongtermPayableE" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
	</tr>
	<tr style='height: 15.6pt'>
		<td width="25%" valign=top
			style='width: 25.64%; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="27%" valign=top
			style='width: 27.42%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>其他长期负债<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='其他长期负债' field="llOthersS" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
		<td width="11%" valign=top
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='其他长期负债' field="llOthersE" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
	</tr>
	<tr style='height: 15.6pt'>
		<td width="25%" valign=top
			style='width: 25.64%; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>固定资产：<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
		</p>
		</td>
		<td width="11%" valign=top
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="27%" valign=top
			style='width: 27.42%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='text-indent: 12.0pt; mso-char-indent-count: 1.0; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>长期负债合计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='长期负债合计' field="llSumS" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
		<td width="11%" valign=top
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='长期负债合计' field="llSumE" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
	</tr>
	<tr style='height: 15.6pt'>
		<td width="25%" valign=top
			style='width: 25.64%; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>固定资产原价<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='固定资产原价' field="faPrimeCostS" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
		<td width="11%" valign=top
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='固定资产原价' field="faPrimeCostE" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
		<td width="27%" valign=top
			style='width: 27.42%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='text-indent: 24.0pt; mso-char-indent-count: 2.0; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='height: 15.6pt'>
		<td width="25%" valign=top
			style='width: 25.64%; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>减：累计折旧<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='减：累计折旧' field="faAccumulatedDepreciationS" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
		<td width="11%" valign=top
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='减：累计折旧' field="faAccumulatedDepreciationE" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
		<td width="27%" valign=top
			style='width: 27.42%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='text-indent: 12.0pt; mso-char-indent-count: 1.0; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>受托代理负债：<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
		</p>
		</td>
		<td width="11%" valign=top
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
		</p>
		</td>
	</tr>
	<tr style='height: 15.6pt'>
		<td width="25%" valign=top
			style='width: 25.64%; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>固定资产净值<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='固定资产净值' field="faNetValueS" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
		<td width="11%" valign=top
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='固定资产净值' field="faNetValueE" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
		<td width="27%" valign=top
			style='width: 27.42%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>受托代理负债<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='受托代理负债' field="paDebtS" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
		<td width="11%" valign=top
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='受托代理负债' field="paDebtE" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
	</tr>
	<tr style='height: 15.6pt'>
		<td width="25%" valign=top
			style='width: 25.64%; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>在建工程<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='在建工程' field="faConstructionInProcessS" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
		<td width="11%" valign=top
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='在建工程' field="faConstructionInProcessE" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
		<td width="27%" valign=top
			style='width: 27.42%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='height: 15.6pt'>
		<td width="25%" valign=top
			style='width: 25.64%; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>文物文化资产<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='文物文化资产' field="faCulturalHeritageS" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
		<td width="11%" valign=top
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='文物文化资产' field="faCulturalHeritageE" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
		<td width="27%" valign=top
			style='width: 27.42%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>负债合计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='负债合计' field="paSumS" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
		<td width="11%" valign=top
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='负债合计' field="paSumE" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
	</tr>
	<tr style='height: 15.6pt'>
		<td width="25%" valign=top
			style='width: 25.64%; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>固定资产清理<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='固定资产清理' field="faDisposalFixedAssetsS" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
		<td width="11%" valign=top
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='固定资产清理' field="faDisposalFixedAssetsE" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
		<td width="27%" valign=top
			style='width: 27.42%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='height: 15.6pt'>
		<td width="25%" valign=top
			style='width: 25.64%; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>固定资产合计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='固定资产合计' field="faSumS" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
		<td width="11%" valign=top
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='固定资产合计' field="faSumE" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
		<td width="27%" valign=top
			style='width: 27.42%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='height: 15.6pt'>
		<td width="25%" valign=top
			style='width: 25.64%; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="27%" valign=top
			style='width: 27.42%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='height: 15.6pt'>
		<td width="25%" valign=top
			style='width: 25.64%; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>无形资产：<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
		</p>
		</td>
		<td width="11%" valign=top
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
		</p>
		</td>
		<td width="27%" valign=top
			style='width: 27.42%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='height: 15.6pt'>
		<td width="25%" valign=top
			style='width: 25.64%; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>无形资产<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='无形资产' field="intangibleAssetsS" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
		<td width="11%" valign=top
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='无形资产' field="intangibleAssetsE" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
		<td width="27%" valign=top
			style='width: 27.42%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>净资产：<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
		</p>
		</td>
		<td width="11%" valign=top
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='height: 15.6pt'>
		<td width="25%" valign=top
			style='width: 25.64%; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="27%" valign=top
			style='width: 27.42%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>非限定性净资产<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='非限定性净资产' field="unlimitNetAssetsS" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
		<td width="11%" valign=top
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='非限定性净资产' field="unlimitNetAssetsE" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
	</tr>
	<tr style='height: 15.6pt'>
		<td width="25%" valign=top
			style='width: 25.64%; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 12.0pt; font-family: 宋体'>受托代理资产：<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="27%" valign=top
			style='width: 27.42%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>限定性净资产<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='限定性净资产' field="limitNetAssetsS" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
		<td width="11%" valign=top
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='限定性净资产' field="limitNetAssetsE" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
	</tr>
	<tr style='height: 15.6pt'>
		<td width="25%" valign=top
			style='width: 25.64%; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体'>受托代理资产<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='受托代理资产' field="entrustedAgentAssetsS" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
		<td width="11%" valign=top
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='受托代理资产' field="entrustedAgentAssetsE" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
		<td width="27%" valign=top
			style='width: 27.42%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>净资产合计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='净资产合计' field="netAssetsSumS" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
		<td width="11%" valign=top
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='净资产合计' field="netAssetsSumE" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
	</tr>
	<tr style='height: 15.6pt'>
		<td width="25%" valign=top
			style='width: 25.64%; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="27%" valign=top
			style='width: 27.42%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal
			style='line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-lastrow: yes; height: 15.6pt'>
		<td width="25%" valign=top
			style='width: 25.64%; border-top: none; border-left: solid black 1.5pt; border-bottom: solid windowtext 1.5pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: black .75pt; mso-border-left-alt: black 1.5pt; mso-border-bottom-alt: windowtext 1.5pt; mso-border-right-alt: black .75pt; mso-border-style-alt: solid; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>资产总计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-bottom-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='资产总计' field="assetsSumS" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
		<td width="11%" valign=top
			style='width: 11.58%; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='资产总计' field="assetsSumE" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
		<td width="27%" valign=top
			style='width: 27.42%; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-top-alt: black .75pt; mso-border-left-alt: windowtext 1.5pt; mso-border-bottom-alt: windowtext 1.5pt; mso-border-right-alt: black .75pt; mso-border-style-alt: solid; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>负债和净资产总计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=top
			style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-bottom-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='负债和净资产总计' field="debtAssetsSumS" style="width: 98%; text-align: right" maxlength="10" />
		</p>
		</td>
		<td width="11%" valign=top
			style='width: 11.8%; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 15.6pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 16.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'>
			<input type="text" name='负债和净资产总计' field="debtAssetsSumE" style="width: 98%; text-align: right" maxlength="10" />
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
