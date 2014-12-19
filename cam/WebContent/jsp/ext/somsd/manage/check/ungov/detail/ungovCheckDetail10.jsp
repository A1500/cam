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
</head>

<body>
<model:datasets>

</model:datasets>
<div id="float"class="noprint">
	<input type="button" value="上一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="nextPageM1('9')"/>
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="backM();"/>	
	<input type="button" value="打印" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="docPrint();"/>	
</div>
<div class=WordSection1 style='layout-grid:15.6pt'>

<p class=MsoNormal align=center style='margin-bottom:7.8pt;mso-para-margin-bottom:
.5gd;text-align:center;line-height:29.0pt;mso-line-height-rule:exactly'><span
style='text-fit:120.0pt;mso-text-fit-id:330041600'><span style='font-size:22.0pt;
mso-bidi-font-size:12.0pt;font-family:黑体;mso-hansi-font-family:"Times New Roman";
letter-spacing:5.3pt;mso-font-kerning:0pt'>年检意见</span></span><span lang=EN-US
style='font-size:22.0pt;mso-bidi-font-size:12.0pt;font-family:黑体;mso-hansi-font-family:
"Times New Roman";mso-font-kerning:0pt'><o:p></o:p></span></p>

<div align=center>

<table class=MsoNormalTable border=1 cellspacing=0 cellpadding=0 width=610
 style='width:610;border-collapse:collapse;border:none;mso-border-alt:solid windowtext 2.25pt;
 mso-padding-alt:0cm 5.4pt 0cm 5.4pt;mso-border-insideh:.75pt solid windowtext;
 mso-border-insidev:.75pt solid windowtext'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes;height:216.75pt'>
  <td width=100 style='width:51.7pt;border-top:2.25pt;border-left:2.25pt;
  border-bottom:1.0pt;border-right:1.0pt;border-color:windowtext;border-style:
  solid;mso-border-top-alt:2.25pt;mso-border-left-alt:2.25pt;mso-border-bottom-alt:
  .25pt;mso-border-right-alt:.75pt;mso-border-color-alt:windowtext;mso-border-style-alt:
  solid;padding:0cm 5.4pt 0cm 5.4pt;height:216.75pt'>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'><span style='font-size:14.0pt;font-family:
  宋体'>业务主管单位<span lang=EN-US><o:p></o:p></span></span></b></p>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'><span style='font-size:14.0pt;font-family:
  宋体'>审查意见<span lang=EN-US><o:p></o:p></span></span></b></p>
  </td>
  <td width=600 valign=top style='width:433.1pt;border-top:solid windowtext 2.25pt;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 2.25pt;
  mso-border-left-alt:solid windowtext .75pt;mso-border-top-alt:2.25pt;
  mso-border-left-alt:.75pt;mso-border-bottom-alt:.25pt;mso-border-right-alt:
  2.25pt;mso-border-color-alt:windowtext;mso-border-style-alt:solid;padding:
  0cm 5.4pt 0cm 5.4pt;height:216.75pt'>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
  style='font-size:15.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋'><o:p>&nbsp;</o:p></span></p>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
  style='font-size:15.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋'><o:p>&nbsp;</o:p></span></p>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
  style='font-size:15.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋'><o:p>&nbsp;</o:p></span></p>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
  style='font-size:15.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋'><o:p>&nbsp;</o:p></span></p>
  <p class=MsoNormal align=left style='text-align:left'><span lang=EN-US
  style='font-size:15.0pt;mso-bidi-font-size:12.0pt;font-family:宋体'><o:p>&nbsp;</o:p></span></p>
  <p class=MsoNormal align=left style='text-align:left;text-indent:323.75pt;
  mso-char-indent-count:21.5'><b style='mso-bidi-font-weight:normal'><span
  style='font-size:15.0pt;mso-bidi-font-size:12.0pt;font-family:宋体'>（盖章）<span
  lang=EN-US><o:p></o:p></span></span></b></p>
  <p class=MsoNormal align=left style='text-align:left;text-indent:308.4pt;
  mso-char-indent-count:20.48'><b style='mso-bidi-font-weight:normal'><span
  style='font-size:15.0pt;mso-bidi-font-size:12.0pt;font-family:宋体'>年<span
  lang=EN-US><span style='mso-spacerun:yes'>&nbsp;&nbsp; </span></span>月<span
  lang=EN-US><span style='mso-spacerun:yes'>&nbsp;&nbsp; </span></span>日</span></b><span
  lang=EN-US style='font-size:15.0pt;mso-bidi-font-size:12.0pt;font-family:
  仿宋'><o:p></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:1;height:22.7pt'>
  <td width=69 rowspan=4 style='width:51.7pt;border-top:none;border-left:solid windowtext 2.25pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .25pt;mso-border-top-alt:.25pt;
  mso-border-left-alt:2.25pt;mso-border-bottom-alt:.25pt;mso-border-right-alt:
  .75pt;mso-border-color-alt:windowtext;mso-border-style-alt:solid;padding:
  0cm 5.4pt 0cm 5.4pt;height:22.7pt'>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'><span style='font-size:14.0pt;font-family:
  宋体'>登<span lang=EN-US><o:p></o:p></span></span></b></p>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'><span style='font-size:14.0pt;font-family:
  宋体'>记<span lang=EN-US><o:p></o:p></span></span></b></p>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'><span style='font-size:14.0pt;font-family:
  宋体'>管<span lang=EN-US><o:p></o:p></span></span></b></p>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'><span style='font-size:14.0pt;font-family:
  宋体'>理<span lang=EN-US><o:p></o:p></span></span></b></p>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'><span style='font-size:14.0pt;font-family:
  宋体'>机<span lang=EN-US><o:p></o:p></span></span></b></p>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'><span style='font-size:14.0pt;font-family:
  宋体'>关<span lang=EN-US><o:p></o:p></span></span></b></p>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'><span style='font-size:14.0pt;font-family:
  宋体'>意<span lang=EN-US><o:p></o:p></span></span></b></p>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'><span style='font-size:14.0pt;font-family:
  宋体'>见<span lang=EN-US><o:p></o:p></span></span></b></p>
  </td>
  <td width=577 valign=top style='width:433.1pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 2.25pt;
  mso-border-top-alt:solid windowtext .25pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-top-alt:.25pt;mso-border-left-alt:.75pt;mso-border-bottom-alt:
  .25pt;mso-border-right-alt:2.25pt;mso-border-color-alt:windowtext;mso-border-style-alt:
  solid;padding:0cm 5.4pt 0cm 5.4pt;height:22.7pt'>
  <p class=MsoNormal align=center style='text-align:center;line-height:20.0pt;
  mso-line-height-rule:exactly'><b style='mso-bidi-font-weight:normal'><span
  style='font-size:15.0pt;mso-bidi-font-size:12.0pt;font-family:宋体'>初<span
  lang=EN-US><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span></span>审<span lang=EN-US><o:p></o:p></span></span></b></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:2;height:117.0pt'>
  <td width=577 valign=top style='width:433.1pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 2.25pt;
  mso-border-top-alt:solid windowtext .25pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-top-alt:.25pt;mso-border-left-alt:.75pt;mso-border-bottom-alt:
  .25pt;mso-border-right-alt:2.25pt;mso-border-color-alt:windowtext;mso-border-style-alt:
  solid;padding:0cm 5.4pt 0cm 5.4pt;height:117.0pt'>
  <p class=MsoNormal><b style='mso-bidi-font-weight:normal'><span lang=EN-US
  style='font-size:15.0pt;mso-bidi-font-size:12.0pt;font-family:宋体'><o:p>&nbsp;</o:p></span></b></p>
  <p class=MsoNormal><b style='mso-bidi-font-weight:normal'><span lang=EN-US
  style='font-size:15.0pt;mso-bidi-font-size:12.0pt;font-family:宋体'><o:p>&nbsp;</o:p></span></b></p>
   <p class=MsoNormal><b style='mso-bidi-font-weight:normal'><span lang=EN-US
  style='font-size:15.0pt;mso-bidi-font-size:12.0pt;font-family:宋体'><o:p>&nbsp;</o:p></span></b></p>
   <p class=MsoNormal><b style='mso-bidi-font-weight:normal'><span lang=EN-US
  style='font-size:15.0pt;mso-bidi-font-size:12.0pt;font-family:宋体'><o:p>&nbsp;</o:p></span></b></p>
  <p class=MsoNormal><b style='mso-bidi-font-weight:normal'><span
  style='font-size:15.0pt;mso-bidi-font-size:12.0pt;font-family:宋体'>承办人：<span
  lang=EN-US><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span></span>负责人：<span lang=EN-US><o:p></o:p></span></span></b></p>
   <p class=MsoNormal align=left style='text-align:left;text-indent:308.4pt;
  mso-char-indent-count:20.48'><b style='mso-bidi-font-weight:normal'><span
  style='font-size:15.0pt;mso-bidi-font-size:12.0pt;font-family:宋体'>年<span
  lang=EN-US><span style='mso-spacerun:yes'>&nbsp;&nbsp; </span></span>月<span
  lang=EN-US><span style='mso-spacerun:yes'>&nbsp;&nbsp; </span></span>日</span></b><span
  lang=EN-US style='font-size:15.0pt;mso-bidi-font-size:12.0pt;font-family:
  仿宋'><o:p></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:3;height:22.7pt'>
  <td width=577 valign=top style='width:433.1pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 2.25pt;
  mso-border-top-alt:solid windowtext .25pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-top-alt:.25pt;mso-border-left-alt:.75pt;mso-border-bottom-alt:
  .25pt;mso-border-right-alt:2.25pt;mso-border-color-alt:windowtext;mso-border-style-alt:
  solid;padding:0cm 5.4pt 0cm 5.4pt;height:22.7pt'>
  <p class=MsoNormal align=center style='text-align:center;line-height:20.0pt;
  mso-line-height-rule:exactly'><b style='mso-bidi-font-weight:normal'><span
  style='font-size:15.0pt;mso-bidi-font-size:12.0pt;font-family:宋体'>审<span
  lang=EN-US><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span></span>定<span lang=EN-US><o:p></o:p></span></span></b></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:4;height:116.25pt'>
  <td width=577 valign=top style='width:433.1pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 2.25pt;
  mso-border-top-alt:solid windowtext .25pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-top-alt:.25pt;mso-border-left-alt:.75pt;mso-border-bottom-alt:
  .25pt;mso-border-right-alt:2.25pt;mso-border-color-alt:windowtext;mso-border-style-alt:
  solid;padding:0cm 5.4pt 0cm 5.4pt;height:116.25pt'>
  <p class=MsoNormal style='text-indent:54.2pt;mso-char-indent-count:3.6'><b
  style='mso-bidi-font-weight:normal'><span lang=EN-US style='font-size:15.0pt;
  mso-bidi-font-size:12.0pt;font-family:宋体'><o:p>&nbsp;</o:p></span></b></p>
  <p class=MsoNormal style='text-indent:54.2pt;mso-char-indent-count:3.6'><b
  style='mso-bidi-font-weight:normal'><span lang=EN-US style='font-size:15.0pt;
  mso-bidi-font-size:12.0pt;font-family:宋体'><o:p>&nbsp;</o:p></span></b></p>
  <p class=MsoNormal style='text-indent:54.2pt;mso-char-indent-count:3.6'><b
  style='mso-bidi-font-weight:normal'><span lang=EN-US style='font-size:15.0pt;
  mso-bidi-font-size:12.0pt;font-family:宋体'><o:p>&nbsp;</o:p></span></b></p>
  <p class=MsoNormal style='text-indent:54.2pt;mso-char-indent-count:3.6'><b
  style='mso-bidi-font-weight:normal'><span lang=EN-US style='font-size:15.0pt;
  mso-bidi-font-size:12.0pt;font-family:宋体'><o:p>&nbsp;</o:p></span></b></p>
  <p class=MsoNormal style='text-indent:159.3pt;mso-char-indent-count:10.58'><b
  style='mso-bidi-font-weight:normal'><span style='font-size:15.0pt;mso-bidi-font-size:
  12.0pt;font-family:宋体'>负责人：<span lang=EN-US><o:p></o:p></span></span></b></p>
   <p class=MsoNormal align=left style='text-align:left;text-indent:308.4pt;
  mso-char-indent-count:20.48'><b style='mso-bidi-font-weight:normal'><span
  style='font-size:15.0pt;mso-bidi-font-size:12.0pt;font-family:宋体'>年<span lang=EN-US><span
  style='mso-spacerun:yes'>&nbsp;&nbsp; </span></span>月<span lang=EN-US><span
  style='mso-spacerun:yes'>&nbsp;&nbsp; </span></span>日</span></b><span
  lang=EN-US style='font-size:15.0pt;mso-bidi-font-size:12.0pt;font-family:
  仿宋'><o:p></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:5;mso-yfti-lastrow:yes;height:84.75pt'>
  <td width=69 style='width:51.7pt;border-top:none;border-left:solid windowtext 2.25pt;
  border-bottom:solid windowtext 2.25pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .25pt;mso-border-top-alt:.25pt;
  mso-border-left-alt:2.25pt;mso-border-bottom-alt:2.25pt;mso-border-right-alt:
  .75pt;mso-border-color-alt:windowtext;mso-border-style-alt:solid;padding:
  0cm 5.4pt 0cm 5.4pt;height:84.75pt'>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'><span style='font-size:14.0pt;font-family:
  宋体'>备<span lang=EN-US><o:p></o:p></span></span></b></p>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'><span style='font-size:14.0pt;font-family:
  宋体'>注<span lang=EN-US><o:p></o:p></span></span></b></p>
  </td>
  <td width=577 valign=top style='width:433.1pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 2.25pt;border-right:solid windowtext 2.25pt;
  mso-border-top-alt:solid windowtext .25pt;mso-border-left-alt:solid windowtext .75pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:84.75pt'>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
  style='font-size:15.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋'><o:p>&nbsp;</o:p></span></p>
  </td>
 </tr>
</table>

</div>

<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>

</div>

</body>
</html>
