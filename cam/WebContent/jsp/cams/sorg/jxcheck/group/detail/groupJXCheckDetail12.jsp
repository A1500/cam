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
		}else{
			var checkYear=ds.get("checkYear");
			document.getElementById("checkYear").innerHTML=checkYear;
			document.getElementById("nextYear").innerHTML=parseInt(checkYear)+1;
			document.getElementById("nextYear1").innerHTML=parseInt(checkYear)+1;
		}
	});
	//创建页面导航下拉框
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
textarea {
	overflow-x: hidden;
	overflow-y: hidden;
}
</style>
</head>

<body>
<model:datasets>
	<model:dataset id="somJxCheckDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxcheck.dao.SomJxCheck"></model:record>
	</model:dataset>
</model:datasets>
<div id="float" class="noprint">	
	<input type="button" value="上一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="lastPage1('11')"/>
	<input type="button" value="下一页" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="nextPage1('13')"/>
	<input type="button" value="打印" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="docPrint();"/>
</div>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal align=center
	style='text-align:center; text-indent: 32.15pt; mso-char-indent-count: 2.0; tab-stops: 248.15pt'><b
	style='mso-bidi-font-weight: normal'><span
	style='font-size: 16.0pt; font-family: 黑体; mso-hansi-font-family: 宋体; color: black'>八、<span
	lang=EN-US><label id=checkYear style='font-size: 14.0pt;'></label></span>年年度工作总结及<span lang=EN-US><label id=nextYear style='font-size: 14.0pt;'></label></span>年工作计划<span
	lang=EN-US><o:p></o:p></span></span></b></p>
<form method="post" dataset="somJxCheckDataSet" onsubmit="return false">
<table class=MsoNormalTable border=1 cellspacing=0 cellpadding=0 align=center width=800
	style='text-align:center;border-collapse: collapse; border: none; mso-border-alt: solid windowtext 1.5pt; mso-padding-alt: 0cm 5.4pt 0cm 5.4pt'>
	<tr style='mso-yfti-irow: 1; mso-yfti-lastrow: yes; height: 354.35pt'>
		<td width=800 valign=top
			style='width: 500.4pt; border: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 700pt'>
		<p class=MsoNormal align=left
			style='margin-left: 5.4pt; text-align: left; tab-stops: 248.15pt'><span
			lang=EN-US
			style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体; color: black'>2</span><span
			style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体; color: black'>、<span
			lang=EN-US><label id=nextYear1 style='font-size: 14.0pt;'></label></span>年年度工作计划（200-500字）<span
			lang=EN-US><o:p></o:p></span></span></p>
		<br/>
		<p class=MsoNormal align=center
			style='margin-left: 10.4pt; text-align: left; tab-stops: 248.15pt'><span
			lang=EN-US
			style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
			<textarea field="nextYearPlan" name='"年度工作计划"' style="width:750;height:690pt;font-size: 12.0pt;" rows="25" readonly="readonly"></textarea>
			</o:p></span></p>	
			<br>		
		</td>
	</tr>
</table>
</form>

<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</div>
</body>
</html>
