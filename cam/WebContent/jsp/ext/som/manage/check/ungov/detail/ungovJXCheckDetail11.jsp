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
	var somJxCheckDataSet = L5.DatasetMgr.lookup("somJxCheckDataSet");
	somJxCheckDataSet.setParameter("TASK_CODE@=", taskCode);
	somJxCheckDataSet.load();
	somJxCheckDataSet.on("load",function(ds){
		if(ds.getCount()==0){
			somJxCheckDataSet.newRecord();
		}
	});
	//创建页面导航下拉框
	createUngovDetailSelect();
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
	<model:dataset id="somJxCheckDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxcheck.dao.SomJxCheck"></model:record>
	</model:dataset>
</model:datasets>
<div id="float"class="noprint">	
	<input type="button" value="上一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="lastPageM1('10')"/>
	<input type="button" value="下一页" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="nextPageM1('12')"/>
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="backM();"/>
	<input type="button" value="打印" style="height:25px;width:80px;position:absolute;margin-left:320px;" onclick="docPrint();"/>
</div>
<div align=center>
<div align=left style=" width: 800px">
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<form method="post" dataset="somJxCheckDataSet" onsubmit="return false">
<p class=MsoNormal style='margin-bottom:6.0pt;mso-para-margin-bottom:.5gd'><b
style='mso-bidi-font-weight:normal'><span style='font-size:14.0pt;mso-bidi-font-size:
12.0pt;font-family:仿宋;mso-hansi-font-family:仿宋'>八、年度工作总结（500-1000字）<span
lang=EN-US></span><span lang=EN-US></span><span lang=EN-US><o:p></o:p></span></span></b></p>

<table class=MsoNormalTable border=1 cellspacing=0 cellpadding=0
 style='margin-left:5.4pt;border-collapse:collapse;border:none;mso-border-alt:
 solid windowtext .5pt;mso-padding-alt:0cm 5.4pt 0cm 5.4pt;mso-border-insideh:
 .5pt solid windowtext;mso-border-insidev:.5pt solid windowtext'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes;mso-yfti-lastrow:yes;
  height:369.85pt'>
  <td width=567 valign=top style='width:15.0cm;border:solid windowtext 1.0pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:369.85pt'>
  <p class=MsoNormal><b style='mso-bidi-font-weight:normal'><span lang=EN-US
  style='font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋;
  mso-hansi-font-family:仿宋'><o:p>
  <textarea field="workSummary" name='"年度工作总结"'
				style="width: 750; overflow: auto" rows="30"  readonly="readonly"></textarea>
  </o:p></span></b></p>
  </td>
 </tr>
</table>

<p class=MsoNormal><b style='mso-bidi-font-weight:normal'><span lang=EN-US
style='font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋;
mso-hansi-font-family:仿宋'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal style='margin-bottom:6.0pt;mso-para-margin-bottom:.5gd'><b
style='mso-bidi-font-weight:normal'><span style='font-size:14.0pt;mso-bidi-font-size:
12.0pt;font-family:仿宋;mso-hansi-font-family:仿宋'>九、下年度工作计划（200－500字）<span
lang=EN-US></span><span lang=EN-US></span><span lang=EN-US><o:p></o:p></span></span></b></p>

<table class=MsoNormalTable border=1 cellspacing=0 cellpadding=0
 style='margin-left:5.4pt;border-collapse:collapse;border:none;mso-border-alt:
 solid windowtext .5pt;mso-padding-alt:0cm 5.4pt 0cm 5.4pt;mso-border-insideh:
 .5pt solid windowtext;mso-border-insidev:.5pt solid windowtext'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes;mso-yfti-lastrow:yes;
  height:254.55pt'>
  <td width=567 valign=top style='width:15.0cm;border:solid windowtext 1.0pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:254.55pt'>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt;mso-bidi-font-size:
  12.0pt;font-family:仿宋;mso-hansi-font-family:仿宋'><o:p>
  <textarea field="nextYearPlan" name='"年度工作计划"'
				style="width: 750;; overflow: auto" rows="25" readonly="readonly"></textarea>
  </o:p></span></p>
  </td>
 </tr>
</table>

</form>
</span>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</div>
</body>
</html>
