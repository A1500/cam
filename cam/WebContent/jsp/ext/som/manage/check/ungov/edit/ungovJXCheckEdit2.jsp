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
	createUngovEditSelect();
}
function save(){
}
</script>
</head>

<body>
<model:datasets>
</model:datasets>
<div id="float" >
	<input type="button" value="下一页" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="nextPageM('3')"/>
	<input type="button" value="上一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="lastPageM('1')"/>
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="backM();"/>
</div>
<div align=center>
<div align=center style="margin-top: 60px; width: 800px">

<p class=MsoNormal align=center style='text-align:center'><b style='mso-bidi-font-weight:
normal'><span style='font-size:16.0pt;font-family:仿宋;mso-hansi-font-family:
仿宋'>法定代表人（单位负责人）声明</span></b><b style='mso-bidi-font-weight:normal'><span
lang=EN-US style='font-size:16.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋;
mso-hansi-font-family:仿宋'><o:p></o:p></span></b></p>

<p class=MsoNormal style='text-indent:32.15pt;mso-char-indent-count:2.0'><b><span
lang=EN-US style='font-size:16.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋;
mso-hansi-font-family:仿宋'><o:p>&nbsp;</o:p></span></b></p>
<p class=MsoNormal style='text-indent:32.15pt;mso-char-indent-count:2.0'><b><span
lang=EN-US style='font-size:16.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋;
mso-hansi-font-family:仿宋'><o:p>&nbsp;</o:p></span></b></p>
<p class=MsoNormal align=left style='text-indent:32.15pt;mso-char-indent-count:2.0'><b><span
style='font-size:16.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋;
mso-hansi-font-family:仿宋'>谨此确认，本报告书所填内容真实有效，可予以信息公开（私人信息除外）。<span
lang=EN-US><o:p></o:p></span></span></b></p>

<p class=MsoNormal style='text-indent:32.15pt;mso-char-indent-count:2.0'><b><span
lang=EN-US style='font-size:16.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋;
mso-hansi-font-family:仿宋'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal style='text-indent:32.15pt;mso-char-indent-count:2.0'><b><span
lang=EN-US style='font-size:16.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋;
mso-hansi-font-family:仿宋'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal style='text-indent:32.15pt;mso-char-indent-count:2.0'><b><span
lang=EN-US style='font-size:16.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋;
mso-hansi-font-family:仿宋'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal style='text-indent:32.15pt;mso-char-indent-count:2.0'><b><span
lang=EN-US style='font-size:16.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋;
mso-hansi-font-family:仿宋'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal style='text-indent:32.15pt;mso-char-indent-count:2.0'><b><span
lang=EN-US style='font-size:16.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋;
mso-hansi-font-family:仿宋'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal style='text-indent:32.15pt;mso-char-indent-count:2.0'><b><span
lang=EN-US style='font-size:16.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋;
mso-hansi-font-family:仿宋'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal style='text-indent:32.15pt;mso-char-indent-count:2.0'><b><span
lang=EN-US style='font-size:16.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋;
mso-hansi-font-family:仿宋'><o:p>&nbsp;</o:p></span></b></p>
<p class=MsoNormal style='text-indent:32.15pt;mso-char-indent-count:2.0'><b><span
lang=EN-US style='font-size:16.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋;
mso-hansi-font-family:仿宋'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal style='text-indent:32.15pt;mso-char-indent-count:2.0'><b><span
lang=EN-US style='font-size:16.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋;
mso-hansi-font-family:仿宋'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal style='text-indent:32.15pt;mso-char-indent-count:2.0'><b><span
lang=EN-US style='font-size:16.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋;
mso-hansi-font-family:仿宋'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal style='text-indent:32.15pt;mso-char-indent-count:2.0'><b><span
lang=EN-US style='font-size:16.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋;
mso-hansi-font-family:仿宋'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal style='text-indent:32.15pt;mso-char-indent-count:2.0'><b><span
lang=EN-US style='font-size:16.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋;
mso-hansi-font-family:仿宋'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal style='text-indent:32.15pt;mso-char-indent-count:2.0'><b><span
lang=EN-US style='font-size:16.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋;
mso-hansi-font-family:仿宋'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal style='text-indent:32.15pt;mso-char-indent-count:2.0'><b><span
lang=EN-US style='font-size:16.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋;
mso-hansi-font-family:仿宋'><o:p>&nbsp;</o:p></span></b></p>
<p class=MsoNormal style='text-indent:32.15pt;mso-char-indent-count:2.0'><b><span
lang=EN-US style='font-size:16.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋;
mso-hansi-font-family:仿宋'><span style='mso-spacerun:yes'>&nbsp;</span><span
style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span>(</span></b><b><span style='font-size:16.0pt;mso-bidi-font-size:12.0pt;
font-family:仿宋;mso-hansi-font-family:仿宋'>签字<span lang=EN-US>)<o:p></o:p></span></span></b></p>

<p class=MsoNormal align=right style='text-align:right;line-height:22.0pt;
mso-line-height-rule:exactly'><b><span lang=EN-US style='font-size:16.0pt;
mso-bidi-font-size:12.0pt;font-family:仿宋;mso-hansi-font-family:仿宋'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal align=center style='text-align:center;line-height:22.0pt;
mso-line-height-rule:exactly'><b><span lang=EN-US style='font-size:16.0pt;
mso-bidi-font-size:12.0pt;font-family:仿宋;mso-hansi-font-family:仿宋'><span
style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></b><b><span style='font-size:16.0pt;mso-bidi-font-size:12.0pt;
font-family:仿宋;mso-hansi-font-family:仿宋'>年<span lang=EN-US><span
style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp; </span></span>月<span lang=EN-US><span
style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp; </span></span>日<span lang=EN-US><o:p></o:p></span></span></b></p>

<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</div>
</div>
</body>
</html>
