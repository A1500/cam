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
	//创建页面导航下拉框
	createGroupDetailSelect();
	somCheckDataSet.setParameter("TASK_CODE", taskCode);
	somCheckDataSet.load();
	somCheckDataSet.on('load',function (){
		if(somCheckDataSet.getCount() != 0){
			var command = new L5.Command("com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckCommand");
			command.setParameter("checkYear",somCheckDataSet.get('checkYear'));
			command.setParameter("fillPeopleId",somCheckDataSet.get('fillPeopleId'));
			command.execute("queryLastYearCheckResult");
			document.getElementById("lastYearCheckResult").innerHTML = command.getReturn("lastYearCheckResult");
		}
	});
	
}
function save(){
}
</script>
<style media="print">
.noprint {
	display: none
}
</style>
</head>

<body>
<model:datasets>
	<model:dataset id="somCheckDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxcheck.dao.SomJxCheck"></model:record>
	</model:dataset>
</model:datasets>
<div id="float"class="noprint">	
		<input type="button" value="上一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="lastPage1('12')"/>
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="back();"/>
	<input type="button" value="打印" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="docPrint();"/>
</div>
<div align=center>
<div align=left style=" width: 700px">
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal
	style='margin-top: 6.0pt; mso-para-margin-top: .5gd; text-indent: 32.0pt; mso-char-indent-count: 2.0'><span
	style='font-size: 16.0pt; font-family: 黑体; mso-hansi-font-family: 宋体'>九、年检审查意见<span
	lang=EN-US><o:p></o:p></span></span></p>

<table class=MsoNormalTable border=1 cellspacing=0 cellpadding=0
	align=center
	style='border-collapse: collapse; border: none; mso-border-alt: solid windowtext .5pt; mso-table-overlap: never; mso-table-lspace: 9.0pt; margin-left: 6.75pt; mso-table-rspace: 9.0pt; margin-right: 6.75pt; mso-table-anchor-vertical: paragraph; mso-table-anchor-horizontal: column; mso-table-left: left; mso-table-top: .05pt; mso-padding-alt: 0cm 5.4pt 0cm 5.4pt; mso-border-insideh: .5pt solid windowtext; mso-border-insidev: .5pt solid windowtext'>
	<tr
		style='mso-yfti-irow: 0; mso-yfti-firstrow: yes; page-break-inside: avoid; height: 102.9pt'>
	<td width=93 colspan=2
			style='width: 69.45pt; border: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-alt: solid windowtext 1.5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 102.9pt'>
		<p class=MsoNormal align=center
			style='text-align: center; mso-element: frame; mso-element-frame-hspace: 9.0pt; mso-element-wrap: around; mso-element-anchor-vertical: paragraph; mso-element-anchor-horizontal: column; mso-element-top: .05pt; mso-height-rule: exactly'><span
			style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>去年年检结果<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=578 valign=center align="center"
			style='width: 433.6pt; border: solid windowtext 1.5pt; border-left: none; mso-border-left-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 102.9pt'>
			<label id="lastYearCheckResult"style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'></label>
		</td>
	</tr>
	
	<tr
		style='mso-yfti-irow: 0; mso-yfti-firstrow: yes; page-break-inside: avoid; height: 102.9pt'>
		<td width=93 colspan=2
			style='width: 69.45pt; border: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-alt: solid windowtext 1.5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 202.9pt'>
		<p class=MsoNormal align=center
			style='text-align: center; mso-element: frame; mso-element-frame-hspace: 9.0pt; mso-element-wrap: around; mso-element-anchor-vertical: paragraph; mso-element-anchor-horizontal: column; mso-element-top: .05pt; mso-height-rule: exactly'><span
			style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>业务主管单位初审意见<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=578 valign=top
			style='width: 433.6pt; border: solid windowtext 1.5pt; border-left: none; mso-border-left-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 202.9pt'>
		<p class=MsoNormal align=center
			style='text-align: center; mso-element: frame; mso-element-frame-hspace: 9.0pt; mso-element-wrap: around; mso-element-anchor-vertical: paragraph; mso-element-anchor-horizontal: column; mso-element-top: .05pt; mso-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'><o:p>&nbsp;</o:p></span></p>
		<p class=MsoNormal align=center
			style='text-align: center; mso-element: frame; mso-element-frame-hspace: 9.0pt; mso-element-wrap: around; mso-element-anchor-vertical: paragraph; mso-element-anchor-horizontal: column; mso-element-top: .05pt; mso-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'><o:p>&nbsp;</o:p></span></p>
		<p class=MsoNormal align=center
			style='text-align: center; mso-element: frame; mso-element-frame-hspace: 9.0pt; mso-element-wrap: around; mso-element-anchor-vertical: paragraph; mso-element-anchor-horizontal: column; mso-element-top: .05pt; mso-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'><o:p>&nbsp;</o:p></span></p>
		<p class=MsoNormal align=center
			style='text-align: center; mso-element: frame; mso-element-frame-hspace: 9.0pt; mso-element-wrap: around; mso-element-anchor-vertical: paragraph; mso-element-anchor-horizontal: column; mso-element-top: .05pt; mso-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'><o:p>&nbsp;</o:p></span></p>
		<p class=MsoNormal align=center
			style='text-align: center; mso-element: frame; mso-element-frame-hspace: 9.0pt; mso-element-wrap: around; mso-element-anchor-vertical: paragraph; mso-element-anchor-horizontal: column; mso-element-top: .05pt; mso-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'><o:p>&nbsp;</o:p></span></p>
		<p class=MsoNormal align=center
			style='text-align: center; mso-element: frame; mso-element-frame-hspace: 9.0pt; mso-element-wrap: around; mso-element-anchor-vertical: paragraph; mso-element-anchor-horizontal: column; mso-element-top: .05pt; mso-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'><o:p>&nbsp;</o:p></span></p>
		<p class=MsoNormal align=center
			style='text-align: center; mso-element: frame; mso-element-frame-hspace: 9.0pt; mso-element-wrap: around; mso-element-anchor-vertical: paragraph; mso-element-anchor-horizontal: column; mso-element-top: .05pt; mso-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'><o:p>&nbsp;</o:p></span></p>
		<p class=MsoNormal align=center
			style='text-align: center; mso-element: frame; mso-element-frame-hspace: 9.0pt; mso-element-wrap: around; mso-element-anchor-vertical: paragraph; mso-element-anchor-horizontal: column; mso-element-top: .05pt; mso-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'><o:p>&nbsp;</o:p></span></p>
		<p class=MsoNormal align=center
			style='margin-right: -13.0pt; mso-para-margin-right: -1.24gd; text-align: center; mso-element: frame; mso-element-frame-hspace: 9.0pt; mso-element-wrap: around; mso-element-anchor-vertical: paragraph; mso-element-anchor-horizontal: column; mso-element-top: .05pt; mso-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</span></span><span
			style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>（印鉴）<span
			lang=EN-US><o:p></o:p></span></span></p>
		<p class=MsoNormal align=center
			style='text-align: center; mso-element: frame; mso-element-frame-hspace: 9.0pt; mso-element-wrap: around; mso-element-anchor-vertical: paragraph; mso-element-anchor-horizontal: column; mso-element-top: .05pt; mso-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</span></span><span
			style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>年<span
			lang=EN-US><span style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;
		</span></span>月<span lang=EN-US><span style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;
		</span></span>日<span lang=EN-US><span style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</span><span style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><o:p></o:p></span></span></p>
		</td>
	</tr>
	<tr
		style='mso-yfti-irow: 1; page-break-inside: avoid; height: 144.75pt'>
		<td width=44 rowspan=3 valign=top
			style='width: 33.3pt; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext 1.5pt; mso-border-alt: solid windowtext 1.5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 144.75pt'>
		<p class=MsoNormal align=center
			style='margin-top: 0cm; margin-right: 5.65pt; margin-bottom: 0cm; margin-left: 5.65pt; margin-bottom: .0001pt; text-align: center; mso-element: frame; mso-element-frame-hspace: 9.0pt; mso-element-wrap: around; mso-element-anchor-vertical: paragraph; mso-element-anchor-horizontal: column; mso-element-top: .05pt; mso-height-rule: exactly'><span
			style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>登记管理机关审查意见<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.15pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext 1.5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 144.75pt'>
		<p class=MsoNormal align=center
			style='text-align: center; mso-element: frame; mso-element-frame-hspace: 9.0pt; mso-element-wrap: around; mso-element-anchor-vertical: paragraph; mso-element-anchor-horizontal: column; mso-element-top: .05pt; mso-height-rule: exactly'><span
			style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>初审意见<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=578
			style='width: 433.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext 1.5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: 1.5pt; mso-border-left-alt: .5pt; mso-border-bottom-alt: .5pt; mso-border-right-alt: 1.5pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid; padding: 0cm 5.4pt 0cm 5.4pt; height: 144.75pt'>
		<p class=MsoNormal align=center
			style='text-align: center; mso-element: frame; mso-element-frame-hspace: 9.0pt; mso-element-wrap: around; mso-element-anchor-vertical: paragraph; mso-element-anchor-horizontal: column; mso-element-top: .05pt; mso-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'><o:p>&nbsp;</o:p></span></p>
		<p class=MsoNormal align=center
			style='text-align: center; mso-element: frame; mso-element-frame-hspace: 9.0pt; mso-element-wrap: around; mso-element-anchor-vertical: paragraph; mso-element-anchor-horizontal: column; mso-element-top: .05pt; mso-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'><o:p>&nbsp;</o:p></span></p>
		<p class=MsoNormal align=center
			style='text-align: center; mso-element: frame; mso-element-frame-hspace: 9.0pt; mso-element-wrap: around; mso-element-anchor-vertical: paragraph; mso-element-anchor-horizontal: column; mso-element-top: .05pt; mso-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'><o:p>&nbsp;</o:p></span></p>
		<p class=MsoNormal align=center
			style='text-align: center; mso-element: frame; mso-element-frame-hspace: 9.0pt; mso-element-wrap: around; mso-element-anchor-vertical: paragraph; mso-element-anchor-horizontal: column; mso-element-top: .05pt; mso-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'><o:p>&nbsp;</o:p></span></p>
		<p class=MsoNormal align=center
			style='text-align: center; mso-element: frame; mso-element-frame-hspace: 9.0pt; mso-element-wrap: around; mso-element-anchor-vertical: paragraph; mso-element-anchor-horizontal: column; mso-element-top: .05pt; mso-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'><o:p>&nbsp;</o:p></span></p>
		<p class=MsoNormal
			style='mso-element: frame; mso-element-frame-hspace: 9.0pt; mso-element-wrap: around; mso-element-anchor-vertical: paragraph; mso-element-anchor-horizontal: column; mso-element-top: .05pt; mso-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</span></span><span
			style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>经办人：<span
			lang=EN-US><o:p></o:p></span></span></p>
		<p class=MsoNormal
			style='text-indent: 320.0pt; mso-char-indent-count: 20.0; mso-element: frame; mso-element-frame-hspace: 9.0pt; mso-element-wrap: around; mso-element-anchor-vertical: paragraph; mso-element-anchor-horizontal: column; mso-element-top: .05pt; mso-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp; </span><o:p></o:p></span></p>
		<p class=MsoNormal
			style='mso-element: frame; mso-element-frame-hspace: 9.0pt; mso-element-wrap: around; mso-element-anchor-vertical: paragraph; mso-element-anchor-horizontal: column; mso-element-top: .05pt; mso-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</span></span><span
			style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>年<span
			lang=EN-US><span style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;
		</span></span>月<span lang=EN-US><span style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;
		</span></span>日<span lang=EN-US><o:p></o:p></span></span></p>
		</td>
	</tr>
	<tr
		style='mso-yfti-irow: 2; page-break-inside: avoid; height: 145.55pt'>
		<td width=48
			style='width: 36.15pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 145.55pt'>
		<p class=MsoNormal align=center
			style='text-align: center; mso-element: frame; mso-element-frame-hspace: 9.0pt; mso-element-wrap: around; mso-element-anchor-vertical: paragraph; mso-element-anchor-horizontal: column; mso-element-top: .05pt; mso-height-rule: exactly'><span
			style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>复审意见<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=578 valign=bottom
			style='width: 433.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 145.55pt'>
		<p class=MsoNormal align=right
			style='text-align: right; mso-element: frame; mso-element-frame-hspace: 9.0pt; mso-element-wrap: around; mso-element-anchor-vertical: paragraph; mso-element-anchor-horizontal: column; mso-element-top: .05pt; mso-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'><o:p>&nbsp;</o:p></span></p>
		<p class=MsoNormal
			style='mso-element: frame; mso-element-frame-hspace: 9.0pt; mso-element-wrap: around; mso-element-anchor-vertical: paragraph; mso-element-anchor-horizontal: column; mso-element-top: .05pt; mso-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</span></span><span
			style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>负责人：<span
			lang=EN-US><o:p></o:p></span></span></p>
		<p class=MsoNormal
			style='text-indent: 288.0pt; mso-char-indent-count: 18.0; mso-element: frame; mso-element-frame-hspace: 9.0pt; mso-element-wrap: around; mso-element-anchor-vertical: paragraph; mso-element-anchor-horizontal: column; mso-element-top: .05pt; mso-height-rule: exactly'><span
			style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>年<span
			lang=EN-US><span style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;
		</span></span>月<span lang=EN-US><span style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;
		</span></span>日<span lang=EN-US><o:p></o:p></span></span></p>
		</td>
	</tr>
	<tr
		style='mso-yfti-irow: 3; mso-yfti-lastrow: yes; page-break-inside: avoid; height: 145.85pt'>
		<td width=48
			style='width: 36.15pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 145.85pt'>
		<p class=MsoNormal align=center
			style='text-align: center; mso-element: frame; mso-element-frame-hspace: 9.0pt; mso-element-wrap: around; mso-element-anchor-vertical: paragraph; mso-element-anchor-horizontal: column; mso-element-top: .05pt; mso-height-rule: exactly'><span
			style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>审定意见<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=578
			style='width: 433.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 145.85pt'>
		<p class=MsoNormal align=center
			style='text-align: center; mso-element: frame; mso-element-frame-hspace: 9.0pt; mso-element-wrap: around; mso-element-anchor-vertical: paragraph; mso-element-anchor-horizontal: column; mso-element-top: .05pt; mso-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'><o:p>&nbsp;</o:p></span></p>
		<p class=MsoNormal align=center
			style='text-align: center; mso-element: frame; mso-element-frame-hspace: 9.0pt; mso-element-wrap: around; mso-element-anchor-vertical: paragraph; mso-element-anchor-horizontal: column; mso-element-top: .05pt; mso-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'><o:p>&nbsp;</o:p></span></p>
		<p class=MsoNormal align=center
			style='text-align: center; mso-element: frame; mso-element-frame-hspace: 9.0pt; mso-element-wrap: around; mso-element-anchor-vertical: paragraph; mso-element-anchor-horizontal: column; mso-element-top: .05pt; mso-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'><o:p>&nbsp;</o:p></span></p>
		<p class=MsoNormal align=center
			style='text-align: center; mso-element: frame; mso-element-frame-hspace: 9.0pt; mso-element-wrap: around; mso-element-anchor-vertical: paragraph; mso-element-anchor-horizontal: column; mso-element-top: .05pt; mso-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'><o:p>&nbsp;</o:p></span></p>
		<p class=MsoNormal align=center
			style='text-align: center; mso-element: frame; mso-element-frame-hspace: 9.0pt; mso-element-wrap: around; mso-element-anchor-vertical: paragraph; mso-element-anchor-horizontal: column; mso-element-top: .05pt; mso-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'><o:p>&nbsp;</o:p></span></p>
		<p class=MsoNormal align=center
			style='text-align: center; mso-element: frame; mso-element-frame-hspace: 9.0pt; mso-element-wrap: around; mso-element-anchor-vertical: paragraph; mso-element-anchor-horizontal: column; mso-element-top: .05pt; mso-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</span></span><span
			style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>（印鉴）<span
			lang=EN-US> <o:p></o:p></span></span></p>
		<p class=MsoNormal
			style='mso-element: frame; mso-element-frame-hspace: 9.0pt; mso-element-wrap: around; mso-element-anchor-vertical: paragraph; mso-element-anchor-horizontal: column; mso-element-top: .05pt; mso-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</span><span style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></span><span
			style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>年<span
			lang=EN-US><span style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;
		</span></span>月<span lang=EN-US><span style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;
		</span></span>日<span lang=EN-US><o:p></o:p></span></span></p>
		</td>
	</tr>
</table>

<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</div>
</div>
</body>
</html>
