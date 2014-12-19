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
var flag='<%=request.getParameter("flag")%>';
//初始化
function init(){
	//创建页面导航下拉框
	createGroupDetailSelect();
}
	//打印
	function docPrint(){
		document.execCommand("Print", false);
	}
	function receive(){
		var command = new L5.Command("com.inspur.cams.sorg.check.manage.SomCheckManageCommand");
		var taskCodes=[];
		taskCodes[0]=taskCode;
		command.setParameter("taskCodes", taskCodes);
		command.setParameter("status", "2");
		command.execute("updateStatusRecevie");
		if (!command.error) {
			L5.Msg.alert("提示","接收成功！",function(){
				init();
			});		
		}else{
			L5.Msg.alert('提示',"接收时出现错误！"+command.error);
		}
	}
</script>
<style media="print">
	.noprint     { display: none }
</style>
<style>
textarea {
	overflow: hidden;
}
</style>
</head>

<body>
<model:datasets>
	<model:dataset id="somCheckDataSet" cmd="com.inspur.cams.sorg.check.somcheck.cmd.SomCheckQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.somcheck.data.SomCheck"></model:record>
	</model:dataset>
</model:datasets>
<div id="float" class="noprint">
	<input type="button" value="上一页" style="height: 25px; width: 80px; position: absolute; margin-left: 20px;" onclick="lastPage1('18');"/>
	<input type="button" value="返回" style="height: 25px; width: 80px; position: absolute; margin-left: 120px;" onclick="back();" />
	<input type="button" value="打印" style="height: 25px; width: 80px; position: absolute; margin-left: 220px;" onclick="docPrint();"/>
	<%if(request.getParameter("flag").equals("receive")){ %>
		<input type="button" value="接收" style="height: 25px; width: 80px; position: absolute; margin-left: 320px;" onclick="receive();"/>
	<%} %>
</div>
<div align=center>
<div style="margin-top: 20px; width: 800px">

<p class=MsoNormal align=center style='margin-top:7.8pt;mso-para-margin-top:
.5gd;text-align:center'><span style='font-size:16.0pt;font-family:黑体;
mso-hansi-font-family:宋体'>七、年检审查意见<span lang=EN-US><o:p></o:p></span></span></p>

<table class=MsoNormalTable border=1 cellspacing=0 cellpadding=0 width=100%
 style='width:100%;border-collapse:collapse;border:none;mso-border-alt:solid windowtext 1.5pt;
 mso-yfti-tbllook:480;mso-padding-alt:0cm 5.4pt 0cm 5.4pt;mso-border-insideh:
 .5pt solid windowtext;mso-border-insidev:.5pt solid windowtext'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes;height:278.55pt'>
  <td width="9%" style='width:9.02%;border-top:1.5pt;border-left:1.5pt;
  border-bottom:1.0pt;border-right:1.0pt;border-color:windowtext;border-style:
  solid;mso-border-top-alt:1.5pt;mso-border-left-alt:1.5pt;mso-border-bottom-alt:
  .5pt;mso-border-right-alt:.5pt;mso-border-color-alt:windowtext;mso-border-style-alt:
  solid;padding:0cm 5.4pt 0cm 5.4pt;height:278.55pt'>
  <p class=MsoNormal align=center style='text-align:center;line-height:22.0pt;
  mso-line-height-rule:exactly'><b style='mso-bidi-font-weight:normal'><span
  style='font-size:14.0pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>业</span></b><b style='mso-bidi-font-weight:
  normal'><span lang=EN-US style='font-size:14.0pt'><o:p></o:p></span></b></p>
  <p class=MsoNormal align=center style='text-align:center;line-height:22.0pt;
  mso-line-height-rule:exactly'><span class=GramE><b style='mso-bidi-font-weight:
  normal'><span style='font-size:14.0pt;font-family:宋体;mso-ascii-font-family:
  "Times New Roman";mso-hansi-font-family:"Times New Roman"'>务</span></b></span><b
  style='mso-bidi-font-weight:normal'><span lang=EN-US style='font-size:14.0pt'><o:p></o:p></span></b></p>
  <p class=MsoNormal align=center style='text-align:center;line-height:22.0pt;
  mso-line-height-rule:exactly'><b style='mso-bidi-font-weight:normal'><span
  style='font-size:14.0pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>主</span></b><b style='mso-bidi-font-weight:
  normal'><span lang=EN-US style='font-size:14.0pt'><o:p></o:p></span></b></p>
  <p class=MsoNormal align=center style='text-align:center;line-height:22.0pt;
  mso-line-height-rule:exactly'><b style='mso-bidi-font-weight:normal'><span
  style='font-size:14.0pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>管</span></b><b style='mso-bidi-font-weight:
  normal'><span lang=EN-US style='font-size:14.0pt'><o:p></o:p></span></b></p>
  <p class=MsoNormal align=center style='text-align:center;line-height:22.0pt;
  mso-line-height-rule:exactly'><b style='mso-bidi-font-weight:normal'><span
  style='font-size:14.0pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>单</span></b><b style='mso-bidi-font-weight:
  normal'><span lang=EN-US style='font-size:14.0pt'><o:p></o:p></span></b></p>
  <p class=MsoNormal align=center style='text-align:center;line-height:22.0pt;
  mso-line-height-rule:exactly'><b style='mso-bidi-font-weight:normal'><span
  style='font-size:14.0pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>位</span></b><b style='mso-bidi-font-weight:
  normal'><span lang=EN-US style='font-size:14.0pt'><o:p></o:p></span></b></p>
  <p class=MsoNormal align=center style='text-align:center;line-height:22.0pt;
  mso-line-height-rule:exactly'><b style='mso-bidi-font-weight:normal'><span
  style='font-size:14.0pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>初</span></b><b style='mso-bidi-font-weight:
  normal'><span lang=EN-US style='font-size:14.0pt'><o:p></o:p></span></b></p>
  <p class=MsoNormal align=center style='text-align:center;line-height:22.0pt;
  mso-line-height-rule:exactly'><b style='mso-bidi-font-weight:normal'><span
  style='font-size:14.0pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>审</span></b><b style='mso-bidi-font-weight:
  normal'><span lang=EN-US style='font-size:14.0pt'><o:p></o:p></span></b></p>
  <p class=MsoNormal align=center style='text-align:center;line-height:22.0pt;
  mso-line-height-rule:exactly'><b style='mso-bidi-font-weight:normal'><span
  style='font-size:14.0pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>意</span></b><b style='mso-bidi-font-weight:
  normal'><span lang=EN-US style='font-size:14.0pt'><o:p></o:p></span></b></p>
  <p class=MsoNormal align=center style='text-align:center;line-height:22.0pt;
  mso-line-height-rule:exactly'><b style='mso-bidi-font-weight:normal'><span
  style='font-size:14.0pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>见</span></b><b style='mso-bidi-font-weight:
  normal'><span lang=EN-US style='font-size:14.0pt'><o:p></o:p></span></b></p>
  </td>
  <td width="90%" valign=top style='width:90.98%;border-top:solid windowtext 1.5pt;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-left-alt:solid windowtext .5pt;mso-border-top-alt:1.5pt;
  mso-border-left-alt:.5pt;mso-border-bottom-alt:.5pt;mso-border-right-alt:
  1.5pt;mso-border-color-alt:windowtext;mso-border-style-alt:solid;padding:
  0cm 5.4pt 0cm 5.4pt;height:278.55pt'>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt'><o:p>&nbsp;</o:p></span></p>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt'><o:p>&nbsp;</o:p></span></p>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt'><o:p>&nbsp;</o:p></span></p>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt'><o:p>&nbsp;</o:p></span></p>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt'><o:p>&nbsp;</o:p></span></p>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt'><o:p>&nbsp;</o:p></span></p>
  
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt'><o:p>&nbsp;</o:p></span></p>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt'><o:p>&nbsp;</o:p></span></p>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt'><o:p>&nbsp;</o:p></span></p>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt'><o:p>&nbsp;</o:p></span></p>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt'><o:p>&nbsp;</o:p></span></p>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt'><o:p>&nbsp;</o:p></span></p>
  
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt;width:600'><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span><b style='mso-bidi-font-weight:normal'><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></b></span><b
  style='mso-bidi-font-weight:normal'><span style='font-size:14.0pt;font-family:
  宋体;mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:"Times New Roman"'>（盖章）</span></b><span
  lang=EN-US style='font-size:14.0pt'><o:p></o:p></span></p>
  <p class=MsoNormal style='margin-top:7.8pt;margin-right:0cm;margin-bottom:
  7.8pt;margin-left:0cm;mso-para-margin-top:.5gd;mso-para-margin-right:0cm;
  mso-para-margin-bottom:.5gd;mso-para-margin-left:0cm'><span lang=EN-US
  style='font-size:14.0pt;width:600'><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span><b style='mso-bidi-font-weight:normal'><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span
  style='mso-spacerun:yes'>&nbsp;</span></b></span><b style='mso-bidi-font-weight:
  normal'><span style='font-size:14.0pt;font-family:宋体;mso-ascii-font-family:
  "Times New Roman";mso-hansi-font-family:"Times New Roman"'>年</span></b><b
  style='mso-bidi-font-weight:normal'><span lang=EN-US style='font-size:14.0pt'><span
  style='mso-spacerun:yes'>&nbsp; </span><span
  style='mso-spacerun:yes'>&nbsp;</span></span></b><b style='mso-bidi-font-weight:
  normal'><span style='font-size:14.0pt;font-family:宋体;mso-ascii-font-family:
  "Times New Roman";mso-hansi-font-family:"Times New Roman"'>月</span></b><b
  style='mso-bidi-font-weight:normal'><span style='font-size:14.0pt'> <span
  style='mso-spacerun:yes'>&nbsp;</span><span
  style='mso-spacerun:yes'>&nbsp;</span></span></b><b style='mso-bidi-font-weight:
  normal'><span style='font-size:14.0pt;font-family:宋体;mso-ascii-font-family:
  "Times New Roman";mso-hansi-font-family:"Times New Roman"'>日</span></b><b
  style='mso-bidi-font-weight:normal'><span lang=EN-US style='font-size:14.0pt'><o:p></o:p></span></b></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:1;height:24.75pt'>
  <td width="9%" rowspan=4 style='width:9.02%;border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.5pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-top-alt:.5pt;mso-border-left-alt:
  1.5pt;mso-border-bottom-alt:1.5pt;mso-border-right-alt:.5pt;mso-border-color-alt:
  windowtext;mso-border-style-alt:solid;padding:0cm 5.4pt 0cm 5.4pt;height:
  24.75pt'>
  <p class=MsoNormal align=center style='text-align:center;line-height:22.0pt;
  mso-line-height-rule:exactly'><b style='mso-bidi-font-weight:normal'><span
  style='font-size:14.0pt;font-family:宋体'>登<span lang=EN-US><span
  style='mso-spacerun:yes'>&nbsp; </span></span>记<span lang=EN-US><span
  style='mso-spacerun:yes'>&nbsp; </span></span>管<span lang=EN-US><span
  style='mso-spacerun:yes'>&nbsp; </span></span>理<span lang=EN-US><span
  style='mso-spacerun:yes'>&nbsp; </span></span>机<span lang=EN-US><span
  style='mso-spacerun:yes'>&nbsp; </span></span>关<span lang=EN-US><span
  style='mso-spacerun:yes'>&nbsp; </span></span>审<span lang=EN-US><span
  style='mso-spacerun:yes'>&nbsp; </span></span>定<span lang=EN-US><span
  style='mso-spacerun:yes'>&nbsp; </span></span>意<span lang=EN-US><span
  style='mso-spacerun:yes'>&nbsp; </span></span>见<span lang=EN-US><span
  style='mso-spacerun:yes'>&nbsp; </span></p>
  </td>
  <td width="90%" valign=top style='width:90.98%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:24.75pt'>
  <p class=MsoNormal align=center style='text-align:center;line-height:24.0pt;
  mso-line-height-rule:exactly;tab-stops:276.75pt'><b style='mso-bidi-font-weight:
  normal'><span style='font-size:14.0pt;font-family:宋体;mso-ascii-font-family:
  "Times New Roman";mso-hansi-font-family:"Times New Roman"'>初</span></b><b
  style='mso-bidi-font-weight:normal'><span lang=EN-US style='font-size:14.0pt'><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span></span></b><b style='mso-bidi-font-weight:normal'><span
  style='font-size:14.0pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>审</span></b><b style='mso-bidi-font-weight:
  normal'><span lang=EN-US style='font-size:14.0pt'><o:p></o:p></span></b></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:2;height:91.5pt'>
  <td width="90%" valign=top style='width:90.98%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:91.5pt'>
  <p class=MsoNormal align=center style='text-align:center;line-height:24.0pt;
  mso-line-height-rule:exactly;tab-stops:276.75pt'><b style='mso-bidi-font-weight:
  normal'><span lang=EN-US style='font-size:14.0pt'><o:p>&nbsp;</o:p></span></b></p>
  <p class=MsoNormal align=center style='text-align:center;line-height:24.0pt;
  mso-line-height-rule:exactly;tab-stops:276.75pt'><b style='mso-bidi-font-weight:
  normal'><span lang=EN-US style='font-size:14.0pt'><o:p>&nbsp;</o:p></span></b></p>
  <p class=MsoNormal style='line-height:24.0pt;mso-line-height-rule:exactly;
  tab-stops:276.75pt'><b style='mso-bidi-font-weight:normal'><span lang=EN-US
  style='font-size:14.0pt;width:300'><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span></span></b><b style='mso-bidi-font-weight:normal'><span
  style='font-size:14.0pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>承办人：</span></b><b style='mso-bidi-font-weight:
  normal'><span lang=EN-US style='font-size:14.0pt'><o:p></o:p></span></b></p>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt;width:600'><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span><b style='mso-bidi-font-weight:normal'><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span
  style='mso-spacerun:yes'>&nbsp;</span></b></span><b style='mso-bidi-font-weight:
  normal'><span style='font-size:14.0pt;font-family:宋体;mso-ascii-font-family:
  "Times New Roman";mso-hansi-font-family:"Times New Roman"'>年</span></b><b
  style='mso-bidi-font-weight:normal'><span lang=EN-US style='font-size:14.0pt'><span
  style='mso-spacerun:yes'>&nbsp; </span><span
  style='mso-spacerun:yes'>&nbsp;</span></span></b><b style='mso-bidi-font-weight:
  normal'><span style='font-size:14.0pt;font-family:宋体;mso-ascii-font-family:
  "Times New Roman";mso-hansi-font-family:"Times New Roman"'>月</span></b><b
  style='mso-bidi-font-weight:normal'><span style='font-size:14.0pt'> <span
  style='mso-spacerun:yes'>&nbsp;</span><span
  style='mso-spacerun:yes'>&nbsp;</span></span></b><b style='mso-bidi-font-weight:
  normal'><span style='font-size:14.0pt;font-family:宋体;mso-ascii-font-family:
  "Times New Roman";mso-hansi-font-family:"Times New Roman"'>日</span></b><span
  lang=EN-US style='font-size:14.0pt'><o:p></o:p></span></p>
  <p class=MsoNormal style='line-height:9.0pt;mso-line-height-rule:exactly;
  tab-stops:276.75pt'><b style='mso-bidi-font-weight:normal'><span lang=EN-US
  style='font-size:14.0pt'><o:p>&nbsp;</o:p></span></b></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:3;height:22.3pt'>
  <td width="90%" valign=top style='width:90.98%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:22.3pt'>
  <p class=MsoNormal align=center style='text-align:center;line-height:24.0pt;
  mso-line-height-rule:exactly;tab-stops:276.75pt'><b style='mso-bidi-font-weight:
  normal'><span style='font-size:14.0pt;font-family:宋体;mso-ascii-font-family:
  "Times New Roman";mso-hansi-font-family:"Times New Roman"'>审</span></b><b
  style='mso-bidi-font-weight:normal'><span lang=EN-US style='font-size:14.0pt'><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span></span></b><b style='mso-bidi-font-weight:normal'><span
  style='font-size:14.0pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>核</span></b><b style='mso-bidi-font-weight:
  normal'><span lang=EN-US style='font-size:14.0pt'><o:p></o:p></span></b></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:4;mso-yfti-lastrow:yes;height:148.85pt'>
  <td width="90%" valign=top style='width:90.98%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.5pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:148.85pt'>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt'><o:p>&nbsp;</o:p></span></p>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt'><o:p>&nbsp;</o:p></span></p>
  
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt'><o:p>&nbsp;</o:p></span></p>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt'><o:p>&nbsp;</o:p></span></p>
  
  <p class=MsoNormal style='line-height:24.0pt;mso-line-height-rule:exactly;
  tab-stops:276.75pt'><span lang=EN-US style='font-size:14.0pt;width:300'><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span></span><b style='mso-bidi-font-weight:normal'><span style='font-size:
  14.0pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:
  "Times New Roman"'>负责人：</span></b><span lang=EN-US style='font-size:14.0pt'><o:p></o:p></span></p>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt;width:600'><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span><b style='mso-bidi-font-weight:normal'><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></b></span><b
  style='mso-bidi-font-weight:normal'><span style='font-size:14.0pt;font-family:
  宋体;mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:"Times New Roman"'>（盖章）</span></b><span
  lang=EN-US style='font-size:14.0pt'><o:p></o:p></span></p>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt;width:600'><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><b
  style='mso-bidi-font-weight:normal'><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span
  style='mso-spacerun:yes'>&nbsp;</span></b></span><b style='mso-bidi-font-weight:
  normal'><span style='font-size:14.0pt;font-family:宋体;mso-ascii-font-family:
  "Times New Roman";mso-hansi-font-family:"Times New Roman"'>年</span></b><b
  style='mso-bidi-font-weight:normal'><span lang=EN-US style='font-size:14.0pt'><span
  style='mso-spacerun:yes'>&nbsp; </span><span
  style='mso-spacerun:yes'>&nbsp;</span></span></b><b style='mso-bidi-font-weight:
  normal'><span style='font-size:14.0pt;font-family:宋体;mso-ascii-font-family:
  "Times New Roman";mso-hansi-font-family:"Times New Roman"'>月</span></b><b
  style='mso-bidi-font-weight:normal'><span style='font-size:14.0pt'> <span
  style='mso-spacerun:yes'>&nbsp;</span><span
  style='mso-spacerun:yes'>&nbsp;</span></span></b><b style='mso-bidi-font-weight:
  normal'><span style='font-size:14.0pt;font-family:宋体;mso-ascii-font-family:
  "Times New Roman";mso-hansi-font-family:"Times New Roman"'>日</span></b><span
  lang=EN-US style='font-size:14.0pt'><o:p></o:p></span></p>
  <p class=MsoNormal style='line-height:9.0pt;mso-line-height-rule:exactly;
  tab-stops:276.75pt'><span lang=EN-US style='font-size:14.0pt'><span
  style='mso-tab-count:1'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span></span><span style='font-size:14.0pt;font-family:宋体;mso-ascii-font-family:
  "Times New Roman";mso-hansi-font-family:"Times New Roman"'>　</span><span
  lang=EN-US style='font-size:14.0pt'><o:p></o:p></span></p>
  </td>
 </tr>
</table>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</div>
</body>
</html>

