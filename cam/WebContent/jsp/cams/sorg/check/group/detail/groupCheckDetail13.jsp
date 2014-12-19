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
var flag='<%=request.getParameter("flag")%>';
//初始化
function init(){
	var somCheckDataSet = L5.DatasetMgr.lookup("somCheckDataSet");
	somCheckDataSet.setParameter("TASK_CODE@=", taskCode);
	somCheckDataSet.load();
	somCheckDataSet.on("load",function(ds){
		if(ds.getCount()==0){
			somCheckDataSet.newRecord();
		}
	});
	//创建页面导航下拉框
	createGroupDetailSelect();
}
	//打印
	function docPrint(){
		document.execCommand("Print", false);
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
	<input type="button" value="上一页" style="height: 25px; width: 80px; position: absolute; margin-left: 20px;" onclick="lastPage1('12');"/>
	<input type="button" value="下一页" style="height: 25px; width: 80px; position: absolute; margin-left: 120px;" onclick="nextPage1('14');"/>
	<input type="button" value="返回" style="height: 25px; width: 80px; position: absolute; margin-left: 220px;" onclick="back();" />
	<input type="button" value="打印" style="height: 25px; width: 80px; position: absolute; margin-left: 320px;" onclick="docPrint();"/>
</div>
<div align=center>
<div align=center style="margin-top: 20px; width: 800px">
<p class=MsoNormal align=center
	style='margin-top: 7.8pt; mso-para-margin-top: .5gd; text-align: center'><span
	style='font-size: 16.0pt; font-family: 黑体; mso-hansi-font-family: 宋体'>五、业务活动情况<span
	lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal style='margin-top: 7.8pt; mso-para-margin-top: .5gd'><b
	style='mso-bidi-font-weight: normal'><span
	style='font-size: 14.0pt; font-family: 宋体'>（一）本年度业务活动总体情况</span></b><span
	style='font-size: 14.0pt; font-family: 宋体'>（限1500<span lang=EN-US></span>字）</span><span
	lang=EN-US
	style='font-size: 14.0pt; font-family: 黑体; mso-hansi-font-family: 宋体'><o:p></o:p></span></p>
<form method="post" dataset="somCheckDataSet" onsubmit="return false">
<table class=MsoNormalTable border=1 cellspacing=0 cellpadding=0 align=center
	width="100%"
	style='width: 100.0%; border-collapse: collapse; border: none; mso-border-alt: solid windowtext 1.5pt; mso-yfti-tbllook: 480; mso-padding-alt: 0cm 5.4pt 0cm 5.4pt; mso-border-insideh: .5pt solid windowtext; mso-border-insidev: .5pt solid windowtext'>
	<tr style='mso-yfti-lastrow: yes; height: 561.35pt'>
		<td width="100%" valign=top
			style='width: 100.0%; border: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 561.35pt'>
		<p class=MsoNormal align=center
			style='margin-top: 7.8pt;text-align:center; tab-stops: 248.15pt'><b
			style='mso-bidi-font-weight: normal'><span lang=EN-US
			style='mso-bidi-font-size: 10.5pt; font-family: 宋体'><o:p>
			<textarea field="workSummary" name="本年度业务活动总体情况" style="width:800;height:561.35pt;"  readonly></textarea>
			</o:p></span></b></p>
		</td>
	</tr>
</table>
</form>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</div>
</body>
</html>
