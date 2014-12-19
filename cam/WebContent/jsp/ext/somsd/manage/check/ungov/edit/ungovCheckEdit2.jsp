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
	<input type="button" value="上一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="nextPageM('1')"/>
	<input type="button" value="下一页" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="nextPageM('3')"/>
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="backM();"/>
	<!--[if lte IE 7]><div></div><![endif]-->
	<span style="height:25px;width:80px;position:absolute;margin-left:420px;">当前页数：1</span>
</div>
<div align=center>
<div align=center style=" width: 800px">

<p class=MsoNormal style='line-height:12.0pt'><span lang=EN-US
style='font-size:10.5pt;font-family:楷体_GB2312'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='line-height:12.0pt'><span lang=EN-US
style='font-size:10.5pt;font-family:楷体_GB2312'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='line-height:12.0pt'><span lang=EN-US
style='font-size:10.5pt;font-family:楷体_GB2312'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='text-indent:31.8pt;mso-char-indent-count:2.0;
mso-line-height-alt:12.0pt'><span lang=EN-US style='mso-bidi-font-size:16.0pt;
font-family:楷体_GB2312'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='text-indent:31.8pt;mso-char-indent-count:2.0;
mso-line-height-alt:12.0pt'><span lang=EN-US style='mso-bidi-font-size:16.0pt;
font-family:楷体_GB2312'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal align=center style='text-align:center;mso-line-height-alt:
12.0pt'><span style='font-size:18.0pt;font-family:黑体;mso-hansi-font-family:
"Times New Roman"'>填 表 须 知<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal align=center style='text-align:center;text-indent:35.8pt;
mso-char-indent-count:2.0;mso-line-height-alt:12.0pt'><span lang=EN-US
style='font-size:18.0pt;font-family:黑体;mso-hansi-font-family:"Times New Roman"'><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal align=center style='text-align:center;text-indent:35.8pt;
mso-char-indent-count:2.0;mso-line-height-alt:12.0pt'><span lang=EN-US
style='font-size:18.0pt;font-family:黑体;mso-hansi-font-family:"Times New Roman"'><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal align=center style='text-align:center;text-indent:35.8pt;
mso-char-indent-count:2.0;mso-line-height-alt:12.0pt'><span lang=EN-US
style='font-size:18.0pt;font-family:黑体;mso-hansi-font-family:"Times New Roman"'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal align=left style='text-indent:31.8pt;mso-char-indent-count:2.0;
mso-line-height-alt:12.0pt'><span style='font-size:16.0pt;line-height:200%;font-family:
宋体'>一、民办非企业单位必须认真、如实填写《民办非企业单位年度检查报告书》。<span
lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal align=left style='text-indent:31.8pt;mso-char-indent-count:2.0;
mso-line-height-alt:12.0pt'><span style='font-size:16.0pt;line-height:200%;font-family:
宋体'>二、年度变更登记事项，主要填写登记、备案事项中发生的变更内容。如：单位名称、法定代表人、住所、业务主管单位、业务范围等变更情况。<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal align=left style='text-indent:31.8pt;mso-char-indent-count:2.0;
mso-line-height-alt:12.0pt'><span style='font-size:16.0pt;line-height:200%;font-family:
宋体'>三、年度工作报告主要指本单位遵守法律法规和国家政策的情况，按照章程开展活动的情况，财务管理的情况，下一年度工作计划等。<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal align=left style='text-indent:31.8pt;mso-char-indent-count:2.0;
mso-line-height-alt:12.0pt'><span style='font-size:16.0pt;line-height:200%;font-family:
宋体'>四、本报告所填内容应打印，需个人签字或盖章的除外。<span lang=EN-US></span><span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal align=left style='text-indent:31.8pt;mso-char-indent-count:2.0;
mso-line-height-alt:12.0pt'><span style='font-size:16.0pt;line-height:200%;font-family:
宋体'>五、本报告必须经法定代表人签字及单位盖章，方为有效。<span lang=EN-US><o:p></o:p></span></span></p>


<p class=MsoNormal style='text-indent:31.8pt;mso-char-indent-count:2.0;
mso-line-height-alt:12.0pt;layout-grid-mode:char'><span lang=EN-US
style='mso-bidi-font-size:16.0pt;font-family:理德小标宋简;mso-hansi-font-family:华文中宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='text-indent:31.8pt;mso-char-indent-count:2.0;
mso-line-height-alt:12.0pt'><span lang=EN-US style='mso-bidi-font-size:16.0pt;
font-family:楷体_GB2312'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='text-indent:31.8pt;mso-char-indent-count:2.0;
mso-line-height-alt:12.0pt'><span lang=EN-US style='mso-bidi-font-size:16.0pt;
font-family:楷体_GB2312'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='text-indent:31.8pt;mso-char-indent-count:2.0;
mso-line-height-alt:12.0pt'><span lang=EN-US style='mso-bidi-font-size:16.0pt;
font-family:楷体_GB2312'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='text-indent:31.8pt;mso-char-indent-count:2.0;
mso-line-height-alt:12.0pt'><span lang=EN-US style='mso-bidi-font-size:16.0pt;
font-family:楷体_GB2312'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='text-indent:31.8pt;mso-char-indent-count:2.0;
mso-line-height-alt:12.0pt'><span lang=EN-US style='mso-bidi-font-size:16.0pt;
font-family:楷体_GB2312'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='text-indent:31.8pt;mso-char-indent-count:2.0;
mso-line-height-alt:12.0pt'><span lang=EN-US style='mso-bidi-font-size:16.0pt;
font-family:楷体_GB2312'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='text-indent:31.8pt;mso-char-indent-count:2.0;
mso-line-height-alt:12.0pt'><span lang=EN-US style='mso-bidi-font-size:16.0pt;
font-family:楷体_GB2312'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</div>
</div>
</body>
</html>
