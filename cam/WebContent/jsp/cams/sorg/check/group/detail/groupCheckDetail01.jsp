<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>

<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<title>社 会 团 体</title>
<%
	String taskCode = (String)request.getParameter("taskCode");
	String flag = (String)request.getParameter("flag");
%>
<next:ScriptManager />
<script type="text/javascript" src="../../js/float.js"></script>
<link href="../../css/float.css" type="text/css" rel="stylesheet" />
<script language="javascript">
	var taskCode='<%=taskCode%>';
	var flag='<%=flag%>';
	function init(){
		var somCheckDataSet = L5.DatasetMgr.lookup("somCheckDataSet");
		somCheckDataSet.setParameter("TASK_CODE@=", taskCode);
		somCheckDataSet.load();
		somCheckDataSet.on("load",function(ds){
			if(ds.getCount()==0){
				somCheckDataSet.newRecord();
			}
		});
		createGroupDetailSelect();
	}
	function docPrint(){
		document.execCommand("Print", false);
	}
</script>
<style media="print">
	.noprint     { display: none }
</style>
<style>
label {
	text-align:left;
	font-size: 14pt;
	font-family: 宋体;
}
</style>
</head>

<body>
<model:datasets>
	<model:dataset id="somCheckDataSet" cmd="com.inspur.cams.sorg.check.somcheck.cmd.SomCheckQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.somcheck.data.SomCheck"></model:record>
	</model:dataset>
</model:datasets>

<!--页面按钮-->
<div id="float" class="noprint">
	<input type="button" value="下一页" style="height: 25px; width: 80px; position: absolute; margin-left: 20px;" onclick="nextPage1('02');"/>
	<input type="button" value="返回" style="height: 25px; width: 80px; position: absolute; margin-left: 120px;" onclick="back();" />
	<input type="button" value="打印" style="height: 25px; width: 80px; position: absolute; margin-left: 220px;" onclick="docPrint();"/>
</div>
<div align=center>

<p class=MsoNormal align=right style='text-align:right;mso-outline-level:
1'><span style='font-size:15.0pt;mso-bidi-font-size:15.0pt;font-family:宋体;
mso-hansi-font-family:华文中宋'>编号：15&nbsp&nbsp&nbsp&nbsp&nbsp<span lang=EN-US><o:p></o:p></span></span></p>


<div align=left style='width:800;margin-top:60;'>
<form method="post" dataset="somCheckDataSet" onsubmit="return false">
<div class=Section1 style='layout-grid:15.6pt'>
<br><br>
<p class=MsoNormal align=center style='text-align:center;mso-outline-level:
1'><span style='font-size:38.0pt;mso-bidi-font-size:16.0pt;font-family:宋体;
mso-hansi-font-family:华文中宋'>社 会 团 体<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal align=center style='text-align:center;mso-outline-level:
1'><span style='font-size:38.0pt;mso-bidi-font-size:16.0pt;font-family:宋体;
mso-hansi-font-family:华文中宋'>年 度 检 查 报 告 书<span lang=EN-US><o:p></o:p></span></span></p>
<br>
<p class=MsoNormal align=center style='text-align:center;mso-outline-level:
1'><b><span style='font-size:16.0pt;font-family:宋体;mso-hansi-font-family:华文中宋'>&nbsp;&nbsp;（<span
lang=EN-US><span style='mso-spacerun:yes'><label style='width:60pt;text-align:center;font-size:18.0pt;font-family:仿宋_GB2312' field="batchYear" ></label>
</span></span>年度）<span lang=EN-US><o:p></o:p></span></span></b></p>

<p class=MsoNormal style='mso-outline-level:1'><span lang=EN-US
style='font-size:16.0pt;font-family:楷体_GB2312;mso-hansi-font-family:华文中宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='mso-outline-level:1'><span lang=EN-US
style='font-size:16.0pt;font-family:楷体_GB2312;mso-hansi-font-family:华文中宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='mso-outline-level:1'><span lang=EN-US
style='font-size:16.0pt;font-family:楷体_GB2312;mso-hansi-font-family:华文中宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='mso-outline-level:1'><span lang=EN-US
style='font-size:16.0pt;font-family:楷体_GB2312;mso-hansi-font-family:华文中宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='mso-outline-level:1'><span lang=EN-US
style='font-size:16.0pt;font-family:楷体_GB2312;mso-hansi-font-family:华文中宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='mso-outline-level:1'><span lang=EN-US
style='font-size:16.0pt;font-family:楷体_GB2312;mso-hansi-font-family:华文中宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='mso-outline-level:1'><span lang=EN-US
style='font-size:16.0pt;font-family:楷体_GB2312;mso-hansi-font-family:华文中宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='mso-outline-level:1'><span lang=EN-US
style='font-size:16.0pt;font-family:楷体_GB2312;mso-hansi-font-family:华文中宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='mso-outline-level:1'><span lang=EN-US
style='font-size:16.0pt;font-family:楷体_GB2312;mso-hansi-font-family:华文中宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='mso-outline-level:1'><span lang=EN-US
style='font-size:16.0pt;font-family:楷体_GB2312;mso-hansi-font-family:华文中宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='mso-outline-level:1'><span lang=EN-US
style='font-size:16.0pt;font-family:楷体_GB2312;mso-hansi-font-family:华文中宋'><o:p>&nbsp;</o:p></span></p>


<p class=MsoNormal align=left style='margin-left:96.0pt;mso-char-indent-count:6.0;
mso-outline-level:1;text-align:center'><span style='font-size:16.0pt;font-family:黑体;mso-hansi-font-family:
华文中宋'>社团名称:
<label field="cnName" style='width:310;'></label>（盖章）
</span></p>

<p class=MsoNormal align=left style='margin-left:96.0pt;mso-char-indent-count:6.0;
mso-outline-level:1;text-align:center'><span style='font-size:16.0pt;font-family:黑体;mso-hansi-font-family:
华文中宋'>登记证号:
<label  field="sorgCode" style='width:400;'></label>
</span></p>

<p class=MsoNormal align=left style='margin-left:96.0pt;mso-char-indent-count:6.0;
mso-outline-level:1;text-align:center'><span style='font-size:16.0pt;font-family:黑体;mso-hansi-font-family:
华文中宋'>报告日期:
<label  id='reportDate'   field="reportDate" style="width:400" ></label>	
</span></p>


<p class=MsoNormal style='mso-outline-level:1'><span lang=EN-US
style='font-size:16.0pt;font-family:楷体_GB2312;mso-hansi-font-family:华文中宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='mso-outline-level:1'><span lang=EN-US
style='font-size:16.0pt;font-family:楷体_GB2312;mso-hansi-font-family:华文中宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='mso-outline-level:1'><span lang=EN-US
style='font-size:16.0pt;font-family:楷体_GB2312;mso-hansi-font-family:华文中宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style='mso-outline-level:1'><span lang=EN-US
style='font-size:16.0pt;font-family:楷体_GB2312;mso-hansi-font-family:华文中宋'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>

</div>
</form>

</body>
</html>