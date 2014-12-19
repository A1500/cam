<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<script language="javascript">
//var taskCode='<%=request.getParameter("taskCode")%>';
//初始化
function init11(){
	/*var somCheckDataSet = L5.DatasetMgr.lookup("somCheckDataSet");
	somCheckDataSet.setParameter("TASK_CODE@=", taskCode);
	somCheckDataSet.load();
	somCheckDataSet.on("load",function(ds){
		if(ds.getCount()==0){
			somCheckDataSet.newRecord();
		}
	});*/
	//创建页面导航下拉框
	//createUngovDetailSelect();
}
</script>
<style media="print">
.noprint {
	display: none
}
</style>

<div id="float_1"class="noprint">	

</div>
<div align=center style='page-break-after:always'>
<div align=left style=" width: 650px">
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<form method="post" dataset="somCheckDataSet" onsubmit="return false">
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
				style="width: 600; height:690pt;font-size: 12.0pt;" rows="25" readonly="readonly"></textarea>
  </o:p></span></p>
  </td>
 </tr>
</table>

</form>
</span>
</div>
</div>
