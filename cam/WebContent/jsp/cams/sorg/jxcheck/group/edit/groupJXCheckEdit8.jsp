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
	var somCheckDataSet = L5.DatasetMgr.lookup("somCheckDataSet");
	somCheckDataSet.setParameter("TASK_CODE@=", taskCode);
	somCheckDataSet.load();
	somCheckDataSet.on("load",function(ds){
		if(ds.getCount()==0){
			somCheckDataSet.newRecord();
		}
	});
	//创建页面导航下拉框
	createGroupEditSelect();
}
function save(){
	var somCheckDataSetIsValidate = somCheckDataSet.isValidate();
	if(somCheckDataSetIsValidate!=true){
		L5.Msg.alert("提示",somCheckDataSetIsValidate);
		return;
	}
	var checkRecord=somCheckDataSet.getCurrent();
	var command = new L5.Command("com.inspur.cams.sorg.check.somcheck.cmd.SomCheckCommand");
	command.setParameter("checkRecord", checkRecord);
	command.setParameter("taskCode", taskCode);
	command.execute("savePage18");
	if (!command.error) {
		L5.Msg.alert("提示","保存成功！",function(){
		});		
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
function nextPage(){
	
	var data = new L5.Map();
	var url='jsp/cams/sorg/jxcheck/group/edit/groupJXCheckEdit9.jsp';
	data.put("taskCode",taskCode);
	var text = '年检列表';
	L5.forward(url,text,data);
}
function back(){
	var data = new L5.Map();
	var url='jsp/cams/sorg/check/group/somchecktask/somchecktask_list.jsp';
	var text = '年检列表';
	L5.forward(url,text,data);
}
</script>
</head>

<body>
<model:datasets>
	<model:dataset id="somCheckDataSet" cmd="com.inspur.cams.sorg.check.somcheck.cmd.SomCheckQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.somcheck.data.SomCheck">
			<model:field name="otherDesc" type="string" rule="require|length{3500}"/>
		</model:record>
	</model:dataset>
</model:datasets>
<div id="float">	
<!--[if lte IE 7]><div></div><![endif]-->
	<input type="button" value="下一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="nextPage()"/>
<!--[if lte IE 7]><div></div><![endif]--> 
	<input type="button" value="保存" style="height: 25px; width: 80px; position: absolute; margin-left: 120px;"	onclick="save();" /> 
<!--[if lte IE 7]><div></div><![endif]--> 
	<input type="button" value="返回" style="height: 25px; width: 80px; position: absolute; margin-left: 220px;"	onclick="back();" />
</div>
<div align=center>
<div style="width:800;text-align:center">
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal align=left
	style='text-align: left; text-indent: 32.15pt; mso-char-indent-count: 2.0; tab-stops: 248.15pt'><b
	style='mso-bidi-font-weight: normal'><span
	style='font-size: 16.0pt; font-family: 黑体; mso-hansi-font-family: 宋体; color: black'>七、财务报表<span
	lang=EN-US> <o:p></o:p></span></span></b></p>

<p class=MsoNormal align=center
	style='text-align: center; line-height: 24.0pt; mso-line-height-rule: exactly'><b
	style='mso-bidi-font-weight: normal'><span lang=EN-US
	style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>1.</span></b><b
	style='mso-bidi-font-weight: normal'><span
	style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>资产负债表<span
	lang=EN-US><o:p></o:p></span></span></b></p>

<p class=MsoNormal align=center
	style='text-align: center; line-height: 24.0pt; mso-line-height-rule: exactly'><b
	style='mso-bidi-font-weight: normal'><span lang=EN-US
	style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><span
	style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></b><span
	style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>单位：元<span
	lang=EN-US><o:p></o:p></span></span></p>

<div align=center>

<table class=MsoNormalTable border=0 cellspacing=0 cellpadding=0
	style='border-collapse: collapse; mso-padding-alt: 0cm 1.5pt 0cm 1.5pt; mso-border-insideh: .75pt solid black; mso-border-insidev: .75pt solid black'>
	<tr style='mso-yfti-irow: 0; mso-yfti-firstrow: yes; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid windowtext 1.5pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>资<span
			lang=EN-US><span style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;
		</span></span>产<span lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>行次<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>年初数<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: windowtext 1.5pt; mso-border-left-alt: black .75pt; mso-border-bottom-alt: black .75pt; mso-border-right-alt: windowtext 1.5pt; mso-border-style-alt: solid; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>期末数<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-top-alt: windowtext 1.5pt; mso-border-left-alt: windowtext 1.5pt; mso-border-bottom-alt: black .75pt; mso-border-right-alt: black .75pt; mso-border-style-alt: solid; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>负债和净资产<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>行次<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>年初数<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid black 1.0pt; border-right: none; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid windowtext 1.5pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>期末数<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 1; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>流动资产：<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>流动负债：<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 2; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>货币资金<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>1<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"货币资金"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"货币资金"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>短期借款<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>61<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"短期借款"' style="width: 98%; text-align: right"
				maxlength="" />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"短期借款"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 3; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>短期投资<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>2<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"短期投资"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"短期投资"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>应付款项<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>62<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"应付款项"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"应付款项"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 4; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>应收款项<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>3<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"应收款项"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"应收款项"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>应付工资<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>63<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"应付工资"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"应付工资"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 5; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='text-indent: 14.0pt; mso-char-indent-count: 1.0; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>预付账款<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>4<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"预付账款"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"预付账款"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>应交税金<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>65<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"应交税金"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"应交税金"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 6; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>存<span
			lang=EN-US><span style='mso-spacerun: yes'>&nbsp; </span></span>货<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>8<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"存货"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"存货"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='text-indent: 14.0pt; mso-char-indent-count: 1.0; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>预收账款<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>66<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"预收账款"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"预收账款"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 7; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>待摊费用<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>9<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"待摊费用"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"待摊费用"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='text-indent: 14.0pt; mso-char-indent-count: 1.0; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>预提费用<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>71<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"预提费用"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"预提费用"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 8; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>一年内到期的长期债权投资<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>15<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"一年内到期的长期债权投资"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"一年内到期的长期债权投资"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='text-indent: 14.0pt; mso-char-indent-count: 1.0; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>预计负债<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>72<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"预计负债"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"预计负债"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 9; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>其他流动资产<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>18<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"其他流动资产"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"其他流动资产"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>一年内到期的长期负债<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>74<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"一年内到期的长期负债"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"一年内到期的长期负债"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 10; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>流动资产合计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>20<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"流动资产合计"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"流动资产合计"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>其他流动负债<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>78<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"其他流动负债"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"其他流动负债"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 11; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='text-indent: 28.0pt; mso-char-indent-count: 2.0; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>流动负债合计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>80<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"流动负债合计"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"流动负债合计"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 12; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>长期投资：<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='text-indent: 28.0pt; mso-char-indent-count: 2.0; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 13; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>长期股权投资<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>21<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"长期股权投资"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"长期股权投资"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>长期负债：<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 14; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>长期债权投资<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>24<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"长期债权投资"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"长期债权投资"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>长期借款<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>81<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"长期借款"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"长期借款"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 15; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>长期投资合计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>30<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"长期投资合计"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"长期投资合计"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>长期应付款<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>84<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"长期应付款"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"长期应付款"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 16; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>其他长期负债<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>88<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"其他长期负债"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"其他长期负债"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 17; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>固定资产：<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='text-indent: 28.0pt; mso-char-indent-count: 2.0; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>长期负债合计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>90<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"长期负债合计"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"长期负债合计"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 18; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>固定资产原价<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>31<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"固定资产原价"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"固定资产原价"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='text-indent: 28.0pt; mso-char-indent-count: 2.0; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 19; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>减：累计折旧<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>32<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"减：累计折旧"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"减：累计折旧"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>受托代理负债：<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 20; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>固定资产净值<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>33<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"固定资产净值"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"固定资产净值"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>受托代理负债<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>91<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"受托代理负债"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"受托代理负债"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 21; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>在建工程<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>34<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"在建工程"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"在建工程"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 22; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>文物文化资产<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>35<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"文物文化资产"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"文物文化资产"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>负债合计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>100<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"负债合计"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"负债合计"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 23; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>固定资产清理<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>38<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"固定资产清理"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"固定资产清理"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 24; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>固定资产合计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>40<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"固定资产合计"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"固定资产合计"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 25; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 26; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>无形资产：<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 27; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>无形资产<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>41<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"无形资产"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"无形资产"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>净资产：<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 28; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>非限定性净资产<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>101<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"非限定性净资产"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"非限定性净资产"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 29; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>受托代理资产：<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>限定性净资产<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>105<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"限定性净资产"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"限定性净资产"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 30; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>受托代理资产<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>51<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"受托代理资产"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"受托代理资产"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>净资产合计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>110<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"净资产合计"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"净资产合计"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 31; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal
			style='line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-bottom-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 32; mso-yfti-lastrow: yes; height: 10.1pt'>
		<td width=166 valign=top
			style='width: 124.3pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-top-alt: solid black .75pt; mso-border-bottom-alt: solid windowtext 1.5pt; mso-border-right-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>资产总计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=39 valign=top
			style='width: 28.95pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-bottom-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>60<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-bottom-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"资产总计"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"资产总计"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
		<td width=170 valign=top
			style='width: 127.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid windowtext 1.5pt; mso-border-top-alt: black .75pt; mso-border-left-alt: windowtext 1.5pt; mso-border-bottom-alt: windowtext 1.5pt; mso-border-right-alt: black .75pt; mso-border-style-alt: solid; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>负债和净资产总计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 valign=top
			style='width: 28.7pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-bottom-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>120<o:p></o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; mso-border-alt: solid black .75pt; mso-border-bottom-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"负债和净资产总计"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
		<td width=100 valign=top
			style='border: none; border-bottom: solid windowtext 1.5pt; mso-border-top-alt: solid black .75pt; mso-border-left-alt: solid black .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 10.1pt'>
		<p class=MsoNormal align=right
			style='text-align: right; line-height: 18.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="" name='"负债和净资产总计"' style="width: 98%; "
				maxlength="" />
		</o:p></span></p>
		</td>
	</tr>
</table>

</div>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</div>
</div>
</body>
</html>
