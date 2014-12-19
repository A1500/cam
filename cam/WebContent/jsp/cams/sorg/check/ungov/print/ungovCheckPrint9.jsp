<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
 
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>

<script language="javascript">
//var taskCode='<%=request.getParameter("taskCode")%>';
//初始化
function init9(){
	/*somCheckDataSet.setParameter("TASK_CODE", taskCode);
	somCheckDataSet.load();
	somCheckDataSet.on('load',function (ds){
		if(ds.getCount() == 0){
			ds.newRecord({"taskCode":taskCode});
		}
	});*/	
	//创建页面导航下拉框
	//createUngovDetailSelect();
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
<style>
textarea {
	overflow: hidden;
}
</style>

<model:datasets>
	<model:dataset id="somCheckDataSet" cmd="com.inspur.cams.sorg.check.somcheck.cmd.SomCheckQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.somcheck.data.SomCheck"></model:record>
	</model:dataset>
</model:datasets>
<div id="float"class="noprint" style='height:15px;'>

</div>
<div align=center style='page-break-after:always'>
<div align=center style=" margin-top: 20px;width: 610px">
<form method="post" dataset="somCheckDataSet" onsubmit="return false">

<p class=MsoNormal align=center style='margin-bottom:7.8pt;mso-para-margin-bottom:
.5gd;text-align:center'><span style='font-size:22.0pt;mso-bidi-font-size:12.0pt;
font-family:黑体;mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:
"Times New Roman"'>年度工作报告</span><span lang=EN-US style='font-size:22.0pt;
mso-bidi-font-size:12.0pt;mso-fareast-font-family:黑体'><o:p></o:p></span></p>

<p class=MsoNormal style='line-height:12.0pt'><span lang=EN-US
style='font-size:10.5pt;font-family:楷体_GB2312'><o:p>&nbsp;</o:p></span></p>
<table align=center class=MsoNormalTable border=1 cellspacing=0 cellpadding=0 width=610
 style='width:610;border-collapse:collapse;border:none;mso-border-alt:solid windowtext .5pt;
 mso-yfti-tbllook:480;mso-padding-alt:0cm 5.4pt 0cm 5.4pt;mso-border-insideh:
 .5pt solid windowtext;mso-border-insidev:.5pt solid windowtext'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes;mso-yfti-lastrow:yes;
  height:650.45pt'>
  <td width=610 align=center valign=top style='width:455.85pt;border:solid windowtext 1.0pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:650.45pt'>
  <p class=MsoNormal style='text-indent:10.4pt;mso-char-indent-count:1.0;
  line-height:12.0pt'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体'><o:p>
  <textarea field='workSummary' style='width:610;height:650.45pt;' readonly ></textarea>
  </o:p></span></p>
  <p class=MsoNormal style='text-indent:10.4pt;mso-char-indent-count:1.0;
  line-height:12.0pt'><span style='font-size:10.5pt;font-family:楷体_GB2312;
  mso-hansi-font-family:宋体'></span><span
  lang=EN-US style='font-size:10.5pt;font-family:宋体'><o:p></o:p></span></p>
  </td>
 </tr>
</table>
</form>
</div>
</div>

