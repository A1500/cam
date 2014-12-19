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
			document.getElementById("checkYear1").innerHTML=checkYear;
			document.getElementById("nextYear1").innerHTML=parseInt(checkYear)+1;
		}
	});
	//创建页面导航下拉框
	createUngovEditSelect();
}
function save(){
	var somJxCheckDataSetIsValidate = somJxCheckDataSet.isValidate();
	if(somJxCheckDataSetIsValidate!=true){
		L5.Msg.alert("提示",somJxCheckDataSetIsValidate);
		return;
	}
	var jxCheckRecord=somJxCheckDataSet.getCurrent();
	var command = new L5.Command("com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckCommand");
	command.setParameter("jxCheckRecord", jxCheckRecord);
	command.setParameter("taskCode", taskCode);
	command.execute("savePage11");
	if (!command.error) {
		L5.Msg.alert("提示","保存成功！",function(){
		});		
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
</script>
</head>

<body>
<model:datasets>
	<model:dataset id="somJxCheckDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxcheck.dao.SomJxCheck"></model:record>
	</model:dataset>
</model:datasets>
<div id="float">	
	<input type="button" value="上一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="lastPageM('10')"/>
	<input type="button" value="保存" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="save();"/>
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="backM();"/>
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
	<tr style='mso-yfti-irow: 0; mso-yfti-firstrow: yes; height: 354.4pt'>
		<td width=800 valign=top
			style='width: 500.4pt; border: solid windowtext 1.5pt; border-bottom: none; padding: 0cm 5.4pt 0cm 5.4pt; height: 354.4pt'>
		<p class=MsoNormal align=left
			style='margin-left: 5.4pt; text-align: left; tab-stops: 248.15pt'><span
			lang=EN-US
			style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体; color: black'>1</span><span
			style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体; color: black'>、<span
			lang=EN-US><label id=checkYear1 style='font-size: 14.0pt;'></label></span>年年度工作总结（<span lang=EN-US>500-1000</span>）<span
			lang=EN-US><o:p></o:p></span></span></p>
		<br/>
		<p class=MsoNormal align=center
			style='margin-left: 10.4pt; text-align: left; tab-stops: 248.15pt'><span
			lang=EN-US
			style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
			<textarea field="workSummary" name='"年度工作总结"' style="width:750;overflow:auto" rows="30" ></textarea>
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
			lang=EN-US><label id=nextYear1 style='font-size: 14.0pt;'></label></span>年年度工作计划（<span lang=EN-US>200-500</span>字）<span
			lang=EN-US><o:p></o:p></span></span></p>
		<br/>
		<p class=MsoNormal align=center
			style='margin-left: 10.4pt; text-align: left; tab-stops: 248.15pt'><span
			lang=EN-US
			style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体; color: black'><o:p>
			<textarea field="nextYearPlan" name='"年度工作计划"' style="width:750;;overflow:auto" rows="25" ></textarea>
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
