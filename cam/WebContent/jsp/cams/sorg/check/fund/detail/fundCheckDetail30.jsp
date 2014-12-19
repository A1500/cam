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
	createFundDetailSelect();
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
function save(){}
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
	<input type="button" value="上一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="nextPageJ1('29')"/>
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="backJ();"/>
</div>
<div align=center>
<div align=center style="width: 800px">
<div class=Section1 style='layout-grid:15.6pt'>

<p class=MsoNormal align=center
	style='text-align: center; line-height: 150%'><b
	style='mso-bidi-font-weight: normal'><span
	style='font-size: 14.0pt; line-height: 150%; font-family: 宋体; mso-ascii-font-family: "Times New Roman"; mso-hansi-font-family: "Times New Roman"'>年检审查意见</span></b><b
	style='mso-bidi-font-weight: normal'><span lang=EN-US
	style='font-size: 14.0pt; line-height: 150%'><o:p></o:p></span></b></p>
	
<table class=MsoNormalTable border=1 cellspacing=0 cellpadding=0
	 width=700>
	<tr
		style='mso-yfti-lastrow: yes; page-break-inside: avoid; height: 111.3pt'>
		<td width=655
			style='width: 491.0pt; border: double windowtext 1.5pt; padding: 0cm 1.4pt 0cm 1.4pt; height: 111.3pt'>
		<p class=MsoNormal align=left
			style='text-align: left; mso-element: frame; mso-element-frame-hspace: 9.0pt; mso-element-wrap: around; mso-element-anchor-vertical: paragraph; mso-element-anchor-horizontal: margin; mso-element-top: 14.8pt; mso-height-rule: exactly'><b
			style='mso-bidi-font-weight: normal'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 楷体_GB2312;  layout-grid-mode: line'><o:p>&nbsp;</o:p></span></b></p>
		<p class=MsoNormal align=left
			style='text-align: left; mso-element: frame; mso-element-frame-hspace: 9.0pt; mso-element-wrap: around; mso-element-anchor-vertical: paragraph; mso-element-anchor-horizontal: margin; mso-element-top: 14.8pt; mso-height-rule: exactly'><b
			style='mso-bidi-font-weight: normal'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 楷体_GB2312;  layout-grid-mode: line'>去年年检结果：<span
			lang=EN-US><o:p></o:p></span></span></b></p>
		<p class=MsoNormal align=center
			style='margin-right: 5.65pt; text-align: left; mso-element: frame; mso-element-frame-hspace: 9.0pt; mso-element-wrap: around; mso-element-anchor-vertical: paragraph; mso-element-anchor-horizontal: margin; mso-element-top: 14.8pt; mso-height-rule: exactly'><b
			style='mso-bidi-font-weight: normal'><span lang=EN-US
			style='mso-bidi-font-size: 10.5pt; font-family: 楷体_GB2312;  layout-grid-mode: line'><o:p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<label id="lastYearCheckResult"style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 楷体_GB2312;  layout-grid-mode: line'></label>	
			</o:p></span></b></p>
		</td>
	</tr>
</table>
<table class=MsoNormalTable border=1 cellspacing=0 cellpadding=0 width="700" >
	<tr
		style='mso-yfti-lastrow: yes; page-break-inside: avoid; height: 211.3pt'>
		<td width=655
			style='width: 491.0pt; border: double windowtext 1.5pt; padding: 0cm 1.4pt 0cm 1.4pt; height: 211.3pt'>
		<p class=MsoNormal align=left
			style='margin-right: 5.65pt; text-align: left'><b
			style='mso-bidi-font-weight: normal'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 楷体_GB2312;  layout-grid-mode: line'><o:p>&nbsp;</o:p></span></b></p>
		<p class=MsoNormal align=left
			style='margin-right: 5.65pt; text-align: left'><b
			style='mso-bidi-font-weight: normal'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 楷体_GB2312;  layout-grid-mode: line'>业务主管单位名称：<span
			lang=EN-US><o:p></o:p></span></span></b></p>
		<p class=MsoNormal align=left
			style='margin-right: 5.65pt; text-align: left'><b
			style='mso-bidi-font-weight: normal'><span lang=EN-US
			style='mso-bidi-font-size: 10.5pt; font-family: 楷体_GB2312;  layout-grid-mode: line'><o:p>&nbsp;</o:p></span></b></p>
		<p class=MsoNormal align=left
			style='margin-right: 5.65pt; text-align: left'><b
			style='mso-bidi-font-weight: normal'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 楷体_GB2312;  layout-grid-mode: line'>初审意见：<span
			lang=EN-US><o:p></o:p></span></span></b></p>
		<p class=MsoNormal align=left
			style='margin-right: 5.65pt; text-align: left'><b
			style='mso-bidi-font-weight: normal'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 楷体_GB2312;  layout-grid-mode: line'><o:p>&nbsp;</o:p></span></b></p>
		<p class=MsoNormal align=left
			style='margin-right: 5.65pt; text-align: left'><b
			style='mso-bidi-font-weight: normal'><span lang=EN-US
			style='mso-bidi-font-size: 10.5pt; font-family: 楷体_GB2312;  layout-grid-mode: line'><o:p>&nbsp;</o:p></span></b></p>
		<p class=MsoNormal align=left
			style='margin-right: 5.65pt; text-align: left'><b
			style='mso-bidi-font-weight: normal'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 楷体_GB2312;  layout-grid-mode: line'>经办人：<span
			lang=EN-US><o:p></o:p></span></span></b></p>
		<p class=MsoNormal align=left
			style='margin-right: 5.65pt; text-align: left'><b
			style='mso-bidi-font-weight: normal'><span lang=EN-US
			style='mso-bidi-font-size: 10.5pt; font-family: 楷体_GB2312;  layout-grid-mode: line'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</span><span style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><o:p></o:p></span></b></p>
		<p class=MsoNormal align=center style='text-align: center'><b
			style='mso-bidi-font-weight: normal'><span lang=EN-US
			style='mso-bidi-font-size: 10.5pt; font-family: 楷体_GB2312;  layout-grid-mode: line'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</span></span></b><b style='mso-bidi-font-weight: normal'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 楷体_GB2312;  layout-grid-mode: line'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>(</span></b><b
			style='mso-bidi-font-weight: normal'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 楷体_GB2312;  layout-grid-mode: line'>印鉴<span
			lang=EN-US>)</span></span></b><b style='mso-bidi-font-weight: normal'><span
			lang=EN-US
			style='mso-bidi-font-size: 10.5pt; font-family: 楷体_GB2312;  layout-grid-mode: line'><span
			style='mso-tab-count: 1'>&nbsp;&nbsp;&nbsp; </span><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</span></span></b><b style='mso-bidi-font-weight: normal'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 楷体_GB2312;  layout-grid-mode: line'>年<span
			lang=EN-US><span style='mso-spacerun: yes'>&nbsp; </span></span>&nbsp;&nbsp;&nbsp;月<span
			lang=EN-US><span style='mso-spacerun: yes'>&nbsp; </span></span>&nbsp;&nbsp;&nbsp;日</span></b><b
			style='mso-bidi-font-weight: normal'><span lang=EN-US
			style='mso-bidi-font-size: 10.5pt; font-family: 楷体_GB2312;  layout-grid-mode: line'><o:p></o:p></span></b></p>
		<p class=MsoNormal
			style='line-height: 15.6pt; mso-layout-grid-align: none; vertical-align: baseline'><b
			style='mso-bidi-font-weight: normal'><span lang=EN-US
			style='mso-bidi-font-size: 10.5pt; font-family: 楷体_GB2312; layout-grid-mode: line'><o:p>&nbsp;</o:p></span></b></p>
		</td>
	</tr>
</table>

<p class=MsoNormal
	style='text-indent: 21.0pt; mso-char-indent-count: 2.0'><span
	lang=EN-US><o:p>&nbsp;</o:p></span></p>

<table class=MsoNormalTable border=1 cellspacing=0 cellpadding=0
	 width=700>
	<tr
		style='mso-yfti-lastrow: yes; page-break-inside: avoid; height: 211.3pt'>
		<td width=655
			style='width: 491.0pt; border: double windowtext 1.5pt; padding: 0cm 1.4pt 0cm 1.4pt; height: 211.3pt'>
		<p class=MsoNormal align=left
			style='text-align: left; mso-element: frame; mso-element-frame-hspace: 9.0pt; mso-element-wrap: around; mso-element-anchor-vertical: paragraph; mso-element-anchor-horizontal: margin; mso-element-top: 14.8pt; mso-height-rule: exactly'><b
			style='mso-bidi-font-weight: normal'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 楷体_GB2312;  layout-grid-mode: line'><o:p>&nbsp;</o:p></span></b></p>
		<p class=MsoNormal align=left
			style='text-align: left; mso-element: frame; mso-element-frame-hspace: 9.0pt; mso-element-wrap: around; mso-element-anchor-vertical: paragraph; mso-element-anchor-horizontal: margin; mso-element-top: 14.8pt; mso-height-rule: exactly'><b
			style='mso-bidi-font-weight: normal'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 楷体_GB2312;  layout-grid-mode: line'>登记管理机关年检结论：<span
			lang=EN-US><o:p></o:p></span></span></b></p>
		<p class=MsoNormal align=left
			style='margin-right: 5.65pt; text-align: left; mso-element: frame; mso-element-frame-hspace: 9.0pt; mso-element-wrap: around; mso-element-anchor-vertical: paragraph; mso-element-anchor-horizontal: margin; mso-element-top: 14.8pt; mso-height-rule: exactly'><b
			style='mso-bidi-font-weight: normal'><span lang=EN-US
			style='mso-bidi-font-size: 10.5pt; font-family: 楷体_GB2312;  layout-grid-mode: line'><o:p>&nbsp;</o:p></span></b></p>
		<p class=MsoNormal align=left
			style='margin-right: 5.65pt; text-align: left; mso-element: frame; mso-element-frame-hspace: 9.0pt; mso-element-wrap: around; mso-element-anchor-vertical: paragraph; mso-element-anchor-horizontal: margin; mso-element-top: 14.8pt; mso-height-rule: exactly'><b
			style='mso-bidi-font-weight: normal'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 楷体_GB2312;  layout-grid-mode: line'><o:p>&nbsp;</o:p></span></b></p>
		<p class=MsoNormal align=left
			style='margin-right: 5.65pt; text-align: left; mso-element: frame; mso-element-frame-hspace: 9.0pt; mso-element-wrap: around; mso-element-anchor-vertical: paragraph; mso-element-anchor-horizontal: margin; mso-element-top: 14.8pt; mso-height-rule: exactly'><b
			style='mso-bidi-font-weight: normal'><span lang=EN-US
			style='mso-bidi-font-size: 10.5pt; font-family: 楷体_GB2312;  layout-grid-mode: line'><o:p>&nbsp;</o:p></span></b></p>
		<p class=MsoNormal align=left
			style='margin-right: 5.65pt; text-align: left; mso-element: frame; mso-element-frame-hspace: 9.0pt; mso-element-wrap: around; mso-element-anchor-vertical: paragraph; mso-element-anchor-horizontal: margin; mso-element-top: 14.8pt; mso-height-rule: exactly'><b
			style='mso-bidi-font-weight: normal'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 楷体_GB2312;  layout-grid-mode: line'>经办人：<span
			lang=EN-US><o:p></o:p></span></span></b></p>
		<p class=MsoNormal align=left
			style='margin-right: 5.65pt; text-align: left; mso-element: frame; mso-element-frame-hspace: 9.0pt; mso-element-wrap: around; mso-element-anchor-vertical: paragraph; mso-element-anchor-horizontal: margin; mso-element-top: 14.8pt; mso-height-rule: exactly'><b
			style='mso-bidi-font-weight: normal'><span lang=EN-US
			style='mso-bidi-font-size: 10.5pt; font-family: 楷体_GB2312;  layout-grid-mode: line'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</span><o:p></o:p></span></b></p>
		<p class=MsoNormal align=center
			style='text-align: center; mso-element: frame; mso-element-frame-hspace: 9.0pt; mso-element-wrap: around; mso-element-anchor-vertical: paragraph; mso-element-anchor-horizontal: margin; mso-element-top: 14.8pt; mso-height-rule: exactly'><b
			style='mso-bidi-font-weight: normal'><span lang=EN-US
			style='mso-bidi-font-size: 10.5pt; font-family: 楷体_GB2312;  layout-grid-mode: line'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</span></span></b><b style='mso-bidi-font-weight: normal'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 楷体_GB2312;  layout-grid-mode: line'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;</span></span></b><b
			style='mso-bidi-font-weight: normal'><span lang=EN-US
			style='mso-bidi-font-size: 10.5pt; font-family: 楷体_GB2312;  layout-grid-mode: line'><o:p></o:p></span></b></p>
		<p class=MsoNormal align=right
			style='text-align: right; tab-stops: 12.3pt right 471.4pt; mso-element: frame; mso-element-frame-hspace: 9.0pt; mso-element-wrap: around; mso-element-anchor-vertical: paragraph; mso-element-anchor-horizontal: margin; mso-element-top: 14.8pt; mso-height-rule: exactly'><b
			style='mso-bidi-font-weight: normal'><span lang=EN-US
			style='mso-bidi-font-size: 10.5pt; font-family: 楷体_GB2312;  layout-grid-mode: line'><span
			style='mso-tab-count: 1'>&nbsp;&nbsp;&nbsp; </span><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</span></span></b><b style='mso-bidi-font-weight: normal'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 楷体_GB2312;  layout-grid-mode: line'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;</span></span></b><b
			style='mso-bidi-font-weight: normal'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 楷体_GB2312;  layout-grid-mode: line'>年<span
			lang=EN-US><span style='mso-spacerun: yes'>&nbsp; </span></span>&nbsp;&nbsp;&nbsp;月 <span
			style='mso-spacerun: yes'>&nbsp;</span>&nbsp;&nbsp;日</span></b><b
			style='mso-bidi-font-weight: normal'><span lang=EN-US
			style='mso-bidi-font-size: 10.5pt; font-family: 楷体_GB2312;  layout-grid-mode: line'><o:p></o:p></span></b></p>
		<p class=MsoNormal
			style='line-height: 15.6pt; mso-layout-grid-align: none; vertical-align: baseline; mso-element: frame; mso-element-frame-hspace: 9.0pt; mso-element-wrap: around; mso-element-anchor-vertical: paragraph; mso-element-anchor-horizontal: margin; mso-element-top: 14.8pt; mso-height-rule: exactly'><b
			style='mso-bidi-font-weight: normal'><span lang=EN-US
			style='mso-bidi-font-size: 10.5pt; font-family: 楷体_GB2312; layout-grid-mode: line'><o:p>&nbsp;</o:p></span></b></p>
		</td>
	</tr>
</table>

<p class=MsoNormal><b style='mso-bidi-font-weight: normal'><span
	lang=EN-US
	style='mso-bidi-font-size: 10.5pt; font-family: 楷体_GB2312; layout-grid-mode: line'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>


<TABLE align='center'>
	<tr valign=bottom align='center'>
		<td width='100%' height='27' align=center valign=bottom><br>
		</td>
	</tr>
</TABLE>

<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</div>
</div>
</div>
</body>
</html>
