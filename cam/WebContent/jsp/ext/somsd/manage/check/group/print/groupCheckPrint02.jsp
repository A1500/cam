<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>

<script language="javascript">
	function formateYMD(reportDate){
		var ymdDate=reportDate.split("-");
		document.getElementById("reportDate1").innerText=ymdDate[0]+"年"+ymdDate[1]+"月"+ymdDate[2]+"日";
		//createGroupDetailSelect();
	}
	function docPrint(){
		document.execCommand("Print", false);
	}
</script>
<style media="print">
	.noprint     { display: none }
</style>

<model:datasets>
</model:datasets>

<!--页面按钮-->
<div id="float" class="noprint" style='height:15px;'>	

</div>
<div align=center style='page-break-after:always'>
<div align=left style="width:610px;margin-top:60">
<form method="post" dataset="somCheckDataSet" onsubmit="return false">
<br><br>
<p class=MsoNormal align=center style='text-align:center;mso-outline-level:
1'><b style='mso-bidi-font-weight:normal'><span style='font-size:22.0pt;
font-family:宋体'>社会团体年度检查</span></b><b style='mso-bidi-font-weight:normal'><span
style='font-size:22.0pt;font-family:宋体;mso-bidi-font-family:宋体'>报</span></b><b
style='mso-bidi-font-weight:normal'><span style='font-size:22.0pt;font-family:
宋体;mso-bidi-font-family:Batang'>告</span></b><b style='mso-bidi-font-weight:
normal'><span style='font-size:22.0pt;font-family:宋体;mso-bidi-font-family:宋体'>书</span></b><b
style='mso-bidi-font-weight:normal'><span lang=EN-US style='font-size:22.0pt;
font-family:宋体'><o:p></o:p></span></b></p>

<p class=MsoNormal><span lang=EN-US style='font-size:16.0pt;font-family:仿宋;
mso-hansi-font-family:宋体;height:50px'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal align="left" style='mso-char-indent-count:4.0'><span
style='font-size:16.0pt;font-family:仿宋;mso-hansi-font-family:宋体'><label field="regOrganName" style='margin-left:0.0pt;text-align:right;font-size: 16.0pt; font-family: 宋体'>
</label>民政厅（局）：<span
lang=EN-US></span></span></p>

<p class=MsoNormal align="left" style='text-indent:32.0pt;mso-char-indent-count:2.0;line-height:60px'><span
style='font-size:16.0pt;font-family:仿宋;mso-hansi-font-family:宋体'>本社会团体根据《社会团体登记管理条例》、《民间非营利组织会计制度》等有关规定编制<span
lang=EN-US><span style='mso-spacerun:yes'><label class='label01'  style='text-align:center;font-size:18.0pt;font-family:仿宋' field="batchYear" >
</label></span></span>年社会团体年度检查报告书，并保证本报告书内容真实、准确、完整。<span
lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal align="left" style='text-indent:32.0pt;mso-char-indent-count:2.0'><span
style='font-size:16.0pt;font-family:仿宋;mso-hansi-font-family:宋体'>请予审查。<span
lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal style='text-indent:28.0pt;mso-char-indent-count:2.0;
line-height:23.0pt;mso-line-height-rule:exactly'><span lang=EN-US
style='font-size:14.0pt;font-family:仿宋;mso-hansi-font-family:宋体'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='text-indent:32.0pt;mso-char-indent-count:2.0;
line-height:23.0pt;mso-line-height-rule:exactly'><span lang=EN-US
style='font-size:16.0pt;font-family:仿宋;mso-hansi-font-family:宋体'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='text-indent:280.0pt;mso-char-indent-count:17.5;
line-height:23.0pt;mso-line-height-rule:exactly'><span style='font-size:16.0pt;
font-family:仿宋;mso-hansi-font-family:宋体'>（印鉴）<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal style='text-indent:230.0pt;mso-char-indent-count:17.5;
line-height:23.0pt;mso-line-height-rule:exactly'><span style='font-size:16.0pt;
font-family:仿宋;mso-hansi-font-family:宋体'>&nbsp;&nbsp; 
<label id="reportDate1" title="日期" style="font-size:16.0pt;font-family:仿宋;mso-hansi-font-family:宋体"></label><span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal align=center style='text-align:center;line-height:18.0pt;
mso-line-height-rule:exactly;mso-layout-grid-align:none;text-autospace:none'><b
style='mso-bidi-font-weight:normal'><span lang=EN-US style='font-size:14.0pt;
font-family:华文中宋'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal align=center style='text-align:center;line-height:18.0pt;
mso-line-height-rule:exactly;mso-layout-grid-align:none;text-autospace:none'><b
style='mso-bidi-font-weight:normal'><span lang=EN-US style='font-size:14.0pt;
font-family:华文中宋'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal align=center style='text-align:center;line-height:18.0pt;
mso-line-height-rule:exactly;mso-layout-grid-align:none;text-autospace:none'><b
style='mso-bidi-font-weight:normal'><span lang=EN-US style='font-size:14.0pt;
font-family:华文中宋'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal align=center style='text-align:center;line-height:18.0pt;
mso-line-height-rule:exactly;mso-layout-grid-align:none;text-autospace:none'><b
style='mso-bidi-font-weight:normal'><span lang=EN-US style='font-size:14.0pt;
font-family:华文中宋'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal align=center style='text-align:center;line-height:18.0pt;
mso-line-height-rule:exactly;mso-layout-grid-align:none;text-autospace:none'><b
style='mso-bidi-font-weight:normal'><span lang=EN-US style='font-size:14.0pt;
font-family:华文中宋'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal align=center style='text-align:center;line-height:18.0pt;
mso-line-height-rule:exactly;mso-layout-grid-align:none;text-autospace:none'><b
style='mso-bidi-font-weight:normal'><span lang=EN-US style='font-size:14.0pt;
font-family:华文中宋'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal align=center style='text-align:center;mso-layout-grid-align:
none;text-autospace:none'><b style='mso-bidi-font-weight:normal'><span
style='font-size:22.0pt;font-family:宋体'>社团法定代表人申明<span lang=EN-US><o:p></o:p></span></span></b></p>

<p class=MsoNormal align=center style='text-align:center;mso-layout-grid-align:
none;text-autospace:none'><b style='mso-bidi-font-weight:normal'><span
lang=EN-US style='font-size:18.0pt;font-family:华文中宋;height:50px'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal style='text-indent:32.0pt;mso-char-indent-count:2.0'><span
style='font-size:16.0pt;font-family:仿宋;mso-hansi-font-family:宋体'>本报告书情况属实，本人愿意承担由此引起的一切法律责任。<span
lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal style='text-indent:180.0pt;mso-char-indent-count:15.0;
line-height:18.0pt;mso-line-height-rule:exactly;mso-layout-grid-align:none;
text-autospace:none'><span lang=EN-US style='font-size:12.0pt;font-family:宋体;
color:black;height:80px'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='text-indent:168.0pt;mso-char-indent-count:8.0'><span
style='font-size:16.0pt;font-family:仿宋;mso-hansi-font-family:宋体'>社团法定代表人签字：<span
lang=EN-US><span
style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span><o:p></o:p></span></span></p>
<br>
<p class=MsoNormal style='text-indent:256.0pt;mso-char-indent-count:16.0'><span
style='font-size:16.0pt;font-family:仿宋;mso-hansi-font-family:宋体'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;年<span
lang=EN-US><span style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp; </span></span>月<span
lang=EN-US><span style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp; </span></span>日<span
lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal style='text-indent:180.0pt;mso-char-indent-count:15.0;
line-height:18.0pt;mso-line-height-rule:exactly;mso-layout-grid-align:none;
text-autospace:none'><span lang=EN-US style='font-size:12.0pt;font-family:宋体;
color:black'><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal style='text-indent:180.0pt;mso-char-indent-count:15.0;
line-height:18.0pt;mso-line-height-rule:exactly;mso-layout-grid-align:none;
text-autospace:none'><span lang=EN-US style='font-size:12.0pt;font-family:宋体;
color:black'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</form>
</div>
</div>