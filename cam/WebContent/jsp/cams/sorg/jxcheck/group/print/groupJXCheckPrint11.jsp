<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<script language="javascript">
//初始化
function init11(){
	/*var somCheckDataSet = L5.DatasetMgr.lookup("somCheckDataSet");
	somCheckDataSet.setParameter("TASK_CODE@=", taskCode);
	somCheckDataSet.load();
	somCheckDataSet.on("load",function(ds){
		if(ds.getCount()==0){
			somCheckDataSet.newRecord();
		}else{
			var checkYear=ds.get("checkYear");
			document.getElementById("checkYear").innerHTML=checkYear;
			document.getElementById("nextYear").innerHTML=parseInt(checkYear)+1;
			document.getElementById("checkYear1").innerHTML=checkYear;
			document.getElementById("nextYear1").innerHTML=parseInt(checkYear)+1;
		}
	});*/
}
</script>
<style>
textarea {
	overflow-x: hidden;
	overflow-y: hidden;
}
</style>
<model:datasets>
	<model:dataset id="somCheckDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxcheck.dao.SomJxCheck"></model:record>
	</model:dataset>
</model:datasets>
<div style='page-break-after:always'>
<div id="float_1" class="noprint">	

</div>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal align=center
	style='text-align:center; text-indent: 32.15pt; mso-char-indent-count: 2.0; tab-stops: 248.15pt'><b
	style='mso-bidi-font-weight: normal'><span
	style='font-size: 16.0pt; font-family: 黑体; mso-hansi-font-family: 宋体; color: black'>八、<span
	lang=EN-US><label id=checkYear_11 style='font-size: 14.0pt;'></label></span>年年度工作总结及<span lang=EN-US><label id=nextYear_11 style='font-size: 14.0pt;'></label></span>年工作计划<span
	lang=EN-US><o:p></o:p></span></span></b></p>
<form method="post" dataset="somCheckDataSet" onsubmit="return false">
<table class=MsoNormalTable border=1 cellspacing=0 cellpadding=0 align=center width=800
	style='text-align:center;border-collapse: collapse; border: none; mso-border-alt: solid windowtext 1.5pt; mso-padding-alt: 0cm 5.4pt 0cm 5.4pt'>
	<tr style='mso-yfti-irow: 0; mso-yfti-firstrow: yes; height: 354.4pt'>
		<td width=800 valign=top
			style='width: 500.4pt; border: solid windowtext 1.5pt; border-bottom: none; padding: 0cm 5.4pt 0cm 5.4pt; height: 354.4pt'>
		<p class=MsoNormal align=left
			style='margin-left: 5.4pt; text-align: left; tab-stops: 248.15pt'><span
			lang=EN-US
			style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体; color: black'>1</span><span
			style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体; color: black'>、<span
			lang=EN-US><label id=checkYear1_11 style='font-size: 14.0pt;'></label></span>年年度工作总结（500-1000字）<span
			lang=EN-US><o:p></o:p></span></span></p>
		<br/>
		<p class=MsoNormal align=center
			style='margin-left: 10.4pt; text-align: left; tab-stops: 248.15pt'><span
			lang=EN-US
			style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
			<textarea field="workSummary" name='"年度工作总结"' style="width:750;" rows="30" readonly="readonly"></textarea>
			</o:p></span></p>
			<br>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 1; mso-yfti-lastrow: yes; height: 354.35pt'>
		<td width=800 valign=top
			style='width: 500.4pt; border: solid windowtext 1.5pt; border-top: none; padding: 0cm 5.4pt 0cm 5.4pt; height: 354.35pt'>
		<p class=MsoNormal align=left
			style='margin-left: 5.4pt; text-align: left; tab-stops: 248.15pt'><span
			lang=EN-US
			style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体; color: black'>2</span><span
			style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体; color: black'>、<span
			lang=EN-US><label id=nextYear1_11 style='font-size: 14.0pt;'></label></span>年年度工作计划（200-500字）<span
			lang=EN-US><o:p></o:p></span></span></p>
		<br/>
		<p class=MsoNormal align=center
			style='margin-left: 10.4pt; text-align: left; tab-stops: 248.15pt'><span
			lang=EN-US
			style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
			<textarea field="nextYearPlan" name='"年度工作计划"' style="width:750;" rows="25" readonly="readonly"></textarea>
			</o:p></span></p>	
			<br>		
		</td>
	</tr>
</table>
</form>

<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</div>
</div>