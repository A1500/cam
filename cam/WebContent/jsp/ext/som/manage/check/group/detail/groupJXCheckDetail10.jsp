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
	var somJxCheckCashFlowDataSet = L5.DatasetMgr.lookup("somJxCheckCashFlowDataSet");
	somJxCheckCashFlowDataSet.setParameter("TASK_CODE@=", taskCode);
	somJxCheckCashFlowDataSet.load();
	somJxCheckCashFlowDataSet.on("load",function(ds){
		if(ds.getCount()==0){
			somJxCheckCashFlowDataSet.newRecord();
		}
	});
	//创建页面导航下拉框
	createGroupDetailSelect();
}
</script>
<style media="print">
	.noprint     { display: none }
</style>
</head>

<body>
<model:datasets>
	<model:dataset id="somJxCheckCashFlowDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxcheckcashflow.cmd.SomJxCheckCashFlowQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxcheckcashflow.dao.SomJxCheckCashFlow"></model:record>
	</model:dataset>
</model:datasets>
<div id="float" class="noprint">	
	<input type="button" value="下一页" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="nextPage1('11')"/>
	<input type="button" value="上一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="lastPage1('9')"/>
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="back();"/>
	<input type="button" value="打印" style="height:25px;width:80px;position:absolute;margin-left:320px;" onclick="docPrint();"/>	
</div>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal align=center
	style='text-align: center; line-height: 18.0pt; mso-line-height-rule: exactly'><b
	style='mso-bidi-font-weight: normal'><span lang=EN-US
	style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>3.</span></b><b
	style='mso-bidi-font-weight: normal'><span
	style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>现金流量表<span
	lang=EN-US><o:p></o:p></span></span></b></p>

<p class=MsoNormal align=right
	style='text-align:center; line-height: 18.0pt; mso-line-height-rule: exactly'><span
	lang=EN-US
	style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
	style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span
	style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>单位：元<span
	lang=EN-US><o:p></o:p></span></span></p>

<div align=center>
<form method="post" dataset="somJxCheckCashFlowDataSet" onsubmit="return false">
<table class=MsoNormalTable border=1 cellspacing=0 cellpadding=0
	style='border-collapse: collapse; border: none; mso-border-top-alt: solid windowtext 1.5pt; mso-border-bottom-alt: solid windowtext 1.5pt; mso-padding-alt: 0cm 1.5pt 0cm 1.5pt; mso-border-insideh: .75pt solid windowtext; mso-border-insidev: .75pt solid windowtext'>
	<tr style='mso-yfti-irow: 0; mso-yfti-firstrow: yes; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext 1.5pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>项<span
			lang=EN-US><span style='mso-spacerun: yes'>&nbsp; </span></span>目<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>行次<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=204
			style='width: 153.0pt; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: none; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext 1.5pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>金<span
			lang=EN-US><span style='mso-spacerun: yes'>&nbsp; </span></span>额<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 1; height: 12.9pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 12.9pt'>
		<p class=MsoNormal style='text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>一、业务活动产生的现金流量：<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 12.9pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 12.9pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 2; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>接受捐赠收到的现金<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>1<o:p></o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="baReceiveDonations" style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 3; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>收取会费收到的现金<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>2<o:p></o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="baGatherDues" style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 4; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>提供服务收到的现金<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>3<o:p></o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="baRenderServices" style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 5; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>销售商品收到的现金<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>4<o:p></o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="baSellProduct" style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 6; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>政府补助收到的现金<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>5<o:p></o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="baGovernmentGrants" style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 7; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>收到的其他与业务活动有关的现金<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>8<o:p></o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="baInfolwOthers" style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 8; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>现金流入小计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>13<o:p></o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="baInflowSum" style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 9; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>提供捐赠或者资助支付的现金<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>14<o:p></o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="baDonatedPay" style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 10; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>支付给员工以及为员工支付的现金<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>15<o:p></o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="baPayEmployee" style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 11; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>购买商品、接受服务支付的现金<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>16<o:p></o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="baProductServices" style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 12; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>支付的其他与业务活动有关的现金<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>19<o:p></o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="baOutflowOthers" style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 13; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>现金流出小计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>23<o:p></o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="baOutflowSum" style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 14; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>业务活动产生的现金流量净额<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>24<o:p></o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="baNetAmount" style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 15; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>二、投资活动产生的现金流量：<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 16; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp; </span><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;</span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>收回投资所收到的现金<span
			lang=EN-US> <o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>25<o:p></o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="iaRegoupingOutlay" style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 17; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>取得投资收益所收到的现金<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>26<o:p></o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="iaMadeIncome" style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 18; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>处置固定资产和无形资产所收回的现金<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>27<o:p></o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="iaInflowAssets" style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 19; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>收到的其他与投资活动有关的现金<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>30<o:p></o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="iaInflowOthers" style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 20; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>现金流入小计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>34<o:p></o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="iaInflowSum" style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 21; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>购建固定资产和无形资产所支付的现金<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>35<o:p></o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="iaOutflowAssets" style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 22; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>对外投资所支付的现金<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>36<o:p></o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="iaOutflowAbroad" style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 23; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>支付的其他与投资活动有关的现金<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>39<o:p></o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="iaOutflowOthers" style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 24; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>现金流出小计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>43<o:p></o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="iaOutflowSum" style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 25; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>投资活动产生的现金流量净额<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>44<o:p></o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="iaNetAmount" style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 26; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>三、筹资活动产生的现金流量：<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 27; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>借款所收到的现金<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>45<o:p></o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="faInflowLoan" style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 28; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>收到的其他与筹资活动有关的现金<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>48<o:p></o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="faInflowOthers" style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 29; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>现金流入小计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>50<o:p></o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="faInflowSum" style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 30; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>偿还借款所支付的现金<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>51<o:p></o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="faOutflowDebt" style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 31; height: 16.65pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 16.65pt'>
		<p class=MsoNormal style='text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>偿付利息所支付的现金<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 16.65pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>52<o:p></o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 16.65pt'>
		<p class=MsoNormal align=right style='text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="faOutflowRatio" style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 32; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>支付的其他与筹资活动有关的现金<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>55<o:p></o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right style='text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="faOutflowOthers" style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 33; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>现金流出小计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>58<o:p></o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="faOutflowSum" style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 34; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>筹资活动产生的现金流量净额<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>59<o:p></o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="faNetAmount" style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 35; height: 8.7pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 8.7pt'>
		<p class=MsoNormal style='text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>四、汇率变动对现金的影响额<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 8.7pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>60<o:p></o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 8.7pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="exchangeRateMovement" style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 36; mso-yfti-lastrow: yes; height: 17.0pt'>
		<td width=398
			style='width: 298.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext 1.5pt; mso-border-right-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal style='text-autospace: none'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>五、现金及现金等价物净增加额<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=48
			style='width: 36.0pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-bottom-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>61<o:p></o:p></span></p>
		</td>
		<td width=204 valign=top
			style='width: 153.0pt; border: none; border-bottom: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 17.0pt'>
		<p class=MsoNormal align=right
			style='text-align: right; text-autospace: none'><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="netRevalueation" style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'></label>
			</o:p></span></p>
		</td>
	</tr>
</table>
</form>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</div>
</body>
</html>
