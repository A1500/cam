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
	somCheckDataSet.setParameter("TASK_CODE", taskCode);
	somCheckDataSet.load();
	somCheckDataSet.on('load',function (ds){
		if(ds.getCount() == 0){
			ds.newRecord({"taskCode":taskCode});
		}
	});		
	//创建页面导航下拉框
	createUngovEditSelect();
}
function save(){
	var somCheckDataSetIsValidate = somCheckDataSet.isValidate();
	if(somCheckDataSetIsValidate!=true){
		L5.Msg.alert("提示",somCheckDataSetIsValidate);
		return "break";
	}	
	var checkRecord=somCheckDataSet.getCurrent();	
	var command = new L5.Command("com.inspur.cams.sorg.check.somcheck.cmd.SomCheckCommand");
	command.setParameter("taskCode", taskCode);
	command.setParameter("checkRecord", checkRecord);
	command.execute("savePage13");
	if (!command.error) {
		alert("保存成功！");
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
</script>
<style>
textarea {
	overflow: hidden;
}
</style>
</head>

<body>
<model:datasets>
	<model:dataset id="somCheckDataSet" cmd="com.inspur.cams.sorg.check.somcheck.cmd.SomCheckQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.somcheck.data.SomCheck">
			<model:field name="workSummary" type="string" rule="require|length{3500}" />
		</model:record>
	</model:dataset>
</model:datasets>
<div id="float">
	<input type="button" value="上一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="nextPageM('8')"/>
	<input type="button" value="下一页" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="nextPageM('10')"/>
	<input type="button" value="保存" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="save();"/>
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:320px;" onclick="backM();"/>	
	<!--[if lte IE 7]><div></div><![endif]-->
	<span style="height:25px;width:80px;position:absolute;margin-left:420px;">当前页数：8</span>
</div>
<div align=center>
<div align=left style="width:800;">
<form method="post" dataset="somCheckDataSet" onsubmit="return false">
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal align=center style='text-align:center'><b style='mso-bidi-font-weight:
normal'><span style='font-size:14.0pt;font-family:宋体'>年度工作报告<span lang=EN-US><o:p></o:p></span></span></b></p>

<table align=center class=MsoNormalTable border=1 cellspacing=0 cellpadding=0
 style='border-collapse:collapse;border:none;mso-border-alt:solid windowtext .5pt;
 mso-yfti-tbllook:480;mso-padding-alt:0cm 5.4pt 0cm 5.4pt;mso-border-insideh:
 .5pt solid windowtext;mso-border-insidev:.5pt solid windowtext'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes;mso-yfti-lastrow:yes;
  height:650.45pt'>
  <td width=608 align=center valign=top style='width:455.85pt;border:solid windowtext 1.0pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:650.45pt'>
  <p class=MsoNormal style='text-indent:10.4pt;mso-char-indent-count:1.0;
  line-height:12.0pt'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体'><o:p>
  <textarea field='workSummary'name='工作报告' style='width:455.85pt;height:650.45pt;'></textarea>
  </o:p></span></p>
  <p class=MsoNormal style='text-indent:10.4pt;mso-char-indent-count:1.0;
  line-height:12.0pt'><span style='font-size:10.5pt;font-family:楷体_GB2312;
  mso-hansi-font-family:宋体'></span><span
  lang=EN-US style='font-size:10.5pt;font-family:宋体'><o:p></o:p></span></p>
  </td>
 </tr>
</table>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</form>
</div>
</div>
</body>
</html>
