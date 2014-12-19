<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>

<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<title>社 会 团 体</title>
<%
	String taskCode = (String)request.getParameter("taskCode");
%>
<next:ScriptManager />
<script type="text/javascript" src="../../js/float.js"></script>
<link href="../../css/float.css" type="text/css" rel="stylesheet" />
<script language="javascript">
	var taskCode='<%=taskCode%>';
	function init(){
		createGroupEditSelect();
	}
function save(){
}
</script>

</head>

<body>
<model:datasets>
</model:datasets>

<!--页面按钮-->
<div id="float" class="noprint">
	<input type="button" value="上一页" style="height: 25px; width: 80px; position: absolute; margin-left: 20px;" onclick="lastPage('02');"/>
	<input type="button" value="下一页" style="height: 25px; width: 80px; position: absolute; margin-left: 120px;" onclick="nextPage('1');"/>
	<input type="button" value="返回" style="height: 25px; width: 80px; position: absolute; margin-left: 220px;" onclick="back();" />
	<!--[if lte IE 7]><div></div><![endif]-->
	<span style="height:25px;width:80px;position:absolute;margin-left:420px;">当前页数：2</span>
</div>
<div align=center>
<div align=left style='width:800;margin-top:60;'>
<div class=Section1 style='layout-grid:15.6pt'>

<p class=MsoNormal align=center style='text-align:center'><b style='mso-bidi-font-weight:
normal'><span style='font-size:16.0pt;font-family:华文中宋'>目&nbsp;&nbsp;&nbsp;录<span lang=EN-US><span
style='mso-spacerun:yes'></span></span></span></b><b
style='mso-bidi-font-weight:normal'><span style='font-size:16.0pt;font-family:
宋体;mso-bidi-font-family:宋体'></span></b><b style='mso-bidi-font-weight:normal'><span
lang=EN-US style='font-size:16.0pt;font-family:华文中宋'><o:p></o:p></span></b></p>

<p class=MsoNormal style='text-indent:24.0pt;mso-char-indent-count:2.0;
line-height:24.0pt;mso-line-height-rule:exactly'><span style='font-size:12.0pt;
font-family:仿宋;mso-hansi-font-family:宋体'>一、基本信息<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal style='text-indent:24.0pt;mso-char-indent-count:2.0;
line-height:24.0pt;mso-line-height-rule:exactly'><span style='font-size:12.0pt;
font-family:仿宋;mso-hansi-font-family:宋体'>二、内部建设情况<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal style='text-indent:48.0pt;mso-char-indent-count:4.0;
line-height:24.0pt;mso-line-height-rule:exactly'><span style='font-size:12.0pt;
font-family:仿宋;mso-hansi-font-family:宋体'>（一）本年度登记、备案事项变更情况<span
lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal style='text-indent:48.0pt;mso-char-indent-count:4.0;
line-height:24.0pt;mso-line-height-rule:exactly'><span style='font-size:12.0pt;
font-family:仿宋;mso-hansi-font-family:宋体'>（二）本年度会议及换届情况<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal style='text-indent:48.0pt;mso-char-indent-count:4.0;
line-height:24.0pt;mso-line-height-rule:exactly'><span style='font-size:12.0pt;
font-family:仿宋;mso-hansi-font-family:宋体'>（三）内部制度建设<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal style='text-indent:24.0pt;mso-char-indent-count:2.0;
line-height:24.0pt;mso-line-height-rule:exactly'><span style='font-size:12.0pt;
font-family:仿宋;mso-hansi-font-family:宋体'>三、财务会计报告<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal style='text-indent:48.0pt;mso-char-indent-count:4.0;
line-height:24.0pt;mso-line-height-rule:exactly'><span style='font-size:12.0pt;
font-family:仿宋;mso-hansi-font-family:宋体'>（一）资产负债表<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal style='text-indent:48.0pt;mso-char-indent-count:4.0;
line-height:24.0pt;mso-line-height-rule:exactly'><span style='font-size:12.0pt;
font-family:仿宋;mso-hansi-font-family:宋体'>（二）业务活动表<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal style='text-indent:48.0pt;mso-char-indent-count:4.0;
line-height:24.0pt;mso-line-height-rule:exactly'><span style='font-size:12.0pt;
font-family:仿宋;mso-hansi-font-family:宋体'>（三）现金流量表<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal style='text-indent:24.0pt;mso-char-indent-count:2.0;
line-height:24.0pt;mso-line-height-rule:exactly'><span style='font-size:12.0pt;
font-family:仿宋;mso-hansi-font-family:宋体'>四、分支机构、代表机构、专项基金管理机构、办事机构基本情况<span
lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal style='margin-left:92.0pt;mso-para-margin-left:4.67gd;
text-indent:-42.95pt;mso-char-indent-count:-3.58;line-height:24.0pt;mso-line-height-rule:
exactly'><span style='font-size:12.0pt;font-family:仿宋;mso-hansi-font-family:
宋体'>（一）分支机构情况表<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal style='text-indent:48.0pt;mso-char-indent-count:4.0;
line-height:24.0pt;mso-line-height-rule:exactly'><span style='font-size:12.0pt;
font-family:仿宋;mso-hansi-font-family:宋体'>（二）代表机构情况表<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal style='text-indent:48.0pt;mso-char-indent-count:4.0;
line-height:24.0pt;mso-line-height-rule:exactly'><span style='font-size:12.0pt;
font-family:仿宋;mso-hansi-font-family:宋体'>（三）专项基金管理机构情况表<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal style='text-indent:48.0pt;mso-char-indent-count:4.0;
line-height:24.0pt;mso-line-height-rule:exactly'><span style='font-size:12.0pt;
font-family:仿宋;mso-hansi-font-family:宋体'>（四）办事机构情况表<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal style='text-indent:24.0pt;mso-char-indent-count:2.0;
line-height:24.0pt;mso-line-height-rule:exactly'><span style='font-size:12.0pt;
font-family:仿宋;mso-hansi-font-family:宋体'>五、业务活动情况<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal style='text-indent:48.0pt;mso-char-indent-count:4.0;
line-height:24.0pt;mso-line-height-rule:exactly'><span style='font-size:12.0pt;
font-family:仿宋;mso-hansi-font-family:宋体'>（一）本年度业务活动总体情况<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal style='text-indent:48.0pt;mso-char-indent-count:4.0;
line-height:24.0pt;mso-line-height-rule:exactly'><span style='font-size:12.0pt;
font-family:仿宋;mso-hansi-font-family:宋体'>（二）本年度举办研讨、展览、培训、评比<span
style='mso-bidi-font-weight:bold'>达标</span>表彰等活动情况<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal style='text-indent:48.0pt;mso-char-indent-count:4.0;
line-height:24.0pt;mso-line-height-rule:exactly'><span style='font-size:12.0pt;
font-family:仿宋;mso-hansi-font-family:宋体'>（三）本年度接受捐赠资助情况和使用情况<span
lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal style='text-indent:48.0pt;mso-char-indent-count:4.0;
line-height:24.0pt;mso-line-height-rule:exactly'><span style='font-size:12.0pt;
font-family:仿宋;mso-hansi-font-family:宋体'>（四）本年度国际交流与合作情况<span
lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal style='text-indent:24.0pt;mso-char-indent-count:2.0;
line-height:24.0pt;mso-line-height-rule:exactly'><span style='font-size:12.0pt;
font-family:仿宋;mso-hansi-font-family:宋体'>六、其它需要说明的情况<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal style='text-indent:24.0pt;mso-char-indent-count:2.0;
line-height:24.0pt;mso-line-height-rule:exactly'><span style='font-size:12.0pt;
font-family:仿宋;mso-hansi-font-family:宋体'>七、年检审查意见。<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal style='line-height:23.0pt;mso-line-height-rule:exactly'><span
lang=EN-US style='font-size:14.0pt;font-family:仿宋;mso-hansi-font-family:
宋体'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>

</div>
</body>
</html>