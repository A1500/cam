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
	var somCheckCashFlowDataSet = L5.DatasetMgr.lookup("somCheckCashFlowDataSet");
	somCheckCashFlowDataSet.setParameter("TASK_CODE@=", taskCode);
	somCheckCashFlowDataSet.load();
	somCheckCashFlowDataSet.on("load",function(ds){
		if(ds.getCount()==0){
			somCheckCashFlowDataSet.newRecord();
		}
	});
	//创建页面导航下拉框
	createGroupDetailSelect();
}
function nextPage(){
	var data = new L5.Map();
	var url='jsp/cams/sorg/check/group/detail/groupCheckDetail9.jsp';
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
	<model:dataset id="somCheckCashFlowDataSet" cmd="com.inspur.cams.sorg.check.checkcashflow.cmd.SomCheckCashFlowQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.checkcashflow.data.SomCheckCashFlow"></model:record>
	</model:dataset>
</model:datasets>
<div id="float">
<!--[if lte IE 7]><div></div><![endif]--> 
<input	type="button" value="下一页"	style="height: 25px; width: 80px; position: absolute; margin-left: 20px;" onclick="nextPage()"/>
<!--[if lte IE 7]><div></div><![endif]--> 
<input	type="button" value="返回"	style="height: 25px; width: 80px; position: absolute; margin-left: 120px;"	onclick="back();" />
</div>
<div align=center>
<div align=center style="margin-top: 60px; width: 800px">
<form method="post" dataset="somCheckCashFlowDataSet" onsubmit="return false">
<table border=1 cellspacing=0 cellpadding=0 width="800" align=center
	style='width: 800px;border-collapse: collapse; border: none; mso-border-alt: solid windowtext 1.5pt; mso-padding-alt: 0cm 1.5pt 0cm 1.5pt; mso-border-insideh: .75pt solid windowtext; mso-border-insidev: .75pt solid windowtext'>
<tr style='height: 18.0pt'>
	<td width="66%" valign=top
		style='width: 66.2%; border-top: solid windowtext 1.5pt; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal
		style='line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'><span
		style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
		style='font-size: 14.0pt; font-family: 宋体; color: black'>处置固定资产和无形资产所收回的现金<span
		lang=EN-US><o:p></o:p></span></span></p>
	</td>
	<td width="33%" valign=top
		style='width: 33.8%; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal align=right
		style='text-align: right; line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'><label field="iaInflowAssets" name='"处置固定资产和无形资产所收回的现金"' style="width: 98%; text-align: right" maxlength="10" /></span></p>
	</td>
</tr>
<tr style='height: 18.0pt'>
	<td width="66%" valign=top
		style='width: 66.2%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal
		style='line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'><span
		style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
		style='font-size: 14.0pt; font-family: 宋体; color: black'>收到的其他与投资活动有关的现金<span
		lang=EN-US><o:p></o:p></span></span></p>
	</td>
	<td width="33%" valign=top
		style='width: 33.8%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal align=right
		style='text-align: right; line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'><label field="iaInflowOthers" name='"收到的其他与投资活动有关的现金"' style="width: 98%; text-align: right" maxlength="10" /></span></p>
	</td>
</tr>
<tr style='height: 18.0pt'>
	<td width="66%" valign=top
		style='width: 66.2%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal
		style='line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'><span
		style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	</span></span><span style='font-size: 14.0pt; font-family: 宋体; color: black'>现金流入小计<span
		lang=EN-US><o:p></o:p></span></span></p>
	</td>
	<td width="33%" valign=top
		style='width: 33.8%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal align=right
		style='text-align: right; line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'><label field="iaInflowSum" name='"现金流入小计"' style="width: 98%; text-align: right" maxlength="10" /></span></p>
	</td>
</tr>
<tr style='height: 18.0pt'>
	<td width="66%" valign=top
		style='width: 66.2%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal
		style='line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'><span
		style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
		style='font-size: 14.0pt; font-family: 宋体; color: black'>购建固定资产和无形资产所支付的现金<span
		lang=EN-US><o:p></o:p></span></span></p>
	</td>
	<td width="33%" valign=top
		style='width: 33.8%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal align=right
		style='text-align: right; line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'><label field="iaOutflowAssets" name='"购建固定资产和无形资产所支付的现金"' style="width: 98%; text-align: right" maxlength="10" /></span></p>
	</td>
</tr>
<tr style='height: 18.0pt'>
	<td width="66%" valign=top
		style='width: 66.2%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal
		style='line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'><span
		style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
		style='font-size: 14.0pt; font-family: 宋体; color: black'>对外投资所支付的现金<span
		lang=EN-US><o:p></o:p></span></span></p>
	</td>
	<td width="33%" valign=top
		style='width: 33.8%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal align=right
		style='text-align: right; line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'><label field="iaOutflowAbroad" name='"对外投资所支付的现金"' style="width: 98%; text-align: right" maxlength="10" /></span></p>
	</td>
</tr>
<tr style='height: 18.0pt'>
	<td width="66%" valign=top
		style='width: 66.2%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal
		style='line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'><span
		style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
		style='font-size: 14.0pt; font-family: 宋体; color: black'>支付的其他与投资活动有关的现金<span
		lang=EN-US><o:p></o:p></span></span></p>
	</td>
	<td width="33%" valign=top
		style='width: 33.8%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal align=right
		style='text-align: right; line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'><label field="iaOutflowOthers" name='"支付的其他与投资活动有关的现金"' style="width: 98%; text-align: right" maxlength="10" /></span></p>
	</td>
</tr>
<tr style='height: 18.0pt'>
	<td width="66%" valign=top
		style='width: 66.2%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal
		style='line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'><span
		style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	</span></span><span style='font-size: 14.0pt; font-family: 宋体; color: black'>现金流出小计<span
		lang=EN-US><o:p></o:p></span></span></p>
	</td>
	<td width="33%" valign=top
		style='width: 33.8%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal align=right
		style='text-align: right; line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'><label field="iaOutflowSum" name='"现金流出小计"' style="width: 98%; text-align: right" maxlength="10" /></span></p>
	</td>
</tr>
<tr style='height: 18.0pt'>
	<td width="66%" valign=top
		style='width: 66.2%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal align=center
		style='text-align: center; line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		style='font-size: 14.0pt; font-family: 宋体; color: black'>投资活动产生的现金流量净额<span
		lang=EN-US><o:p></o:p></span></span></p>
	</td>
	<td width="33%" valign=top
		style='width: 33.8%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal align=right
		style='text-align: right; line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'><label field="iaNetAmount" name='"投资活动产生的现金流量净额"' style="width: 98%; text-align: right" maxlength="10" /></span></p>
	</td>
</tr>
<tr style='height: 18.0pt'>
	<td width="66%" valign=top
		style='width: 66.2%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal
		style='line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		style='font-size: 14.0pt; font-family: 宋体; color: black'>三、筹资活动产生的现金流量：<span
		lang=EN-US><o:p></o:p></span></span></p>
	</td>
	<td width="33%" valign=top
		style='width: 33.8%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal align=right
		style='text-align: right; line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
	</td>
</tr>
<tr style='height: 18.0pt'>
	<td width="66%" valign=top
		style='width: 66.2%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal
		style='line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'><span
		style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
		style='font-size: 14.0pt; font-family: 宋体; color: black'>借款所收到的现金<span
		lang=EN-US><o:p></o:p></span></span></p>
	</td>
	<td width="33%" valign=top
		style='width: 33.8%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal align=right
		style='text-align: right; line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'><label field="faInflowLoan" name='"借款所收到的现金"' style="width: 98%; text-align: right" maxlength="10" /></span></p>
	</td>
</tr>
<tr style='height: 18.0pt'>
	<td width="66%" valign=top
		style='width: 66.2%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal
		style='line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'><span
		style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
		style='font-size: 14.0pt; font-family: 宋体; color: black'>收到的其他与筹资活动有关的现金<span
		lang=EN-US><o:p></o:p></span></span></p>
	</td>
	<td width="33%" valign=top
		style='width: 33.8%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal align=right
		style='text-align: right; line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'><label field="faInflowOthers" name='"收到的其他与筹资活动有关的现金"' style="width: 98%; text-align: right" maxlength="10" /></span></p>
	</td>
</tr>
<tr style='height: 18.0pt'>
	<td width="66%" valign=top
		style='width: 66.2%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal
		style='line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'><span
		style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	</span></span><span style='font-size: 14.0pt; font-family: 宋体; color: black'>现金流入小计<span
		lang=EN-US><o:p></o:p></span></span></p>
	</td>
	<td width="33%" valign=top
		style='width: 33.8%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal align=right
		style='text-align: right; line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'><label field="faInflowSum" name='"现金流入小计"' style="width: 98%; text-align: right" maxlength="10" /></span></p>
	</td>
</tr>
<tr style='height: 18.0pt'>
	<td width="66%" valign=top
		style='width: 66.2%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal
		style='line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'><span
		style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
		style='font-size: 14.0pt; font-family: 宋体; color: black'>偿还借款所支付的现金<span
		lang=EN-US><o:p></o:p></span></span></p>
	</td>
	<td width="33%" valign=top
		style='width: 33.8%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal align=right
		style='text-align: right; line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'><label field="faOutflowDebt" name='"偿还借款所支付的现金"' style="width: 98%; text-align: right" maxlength="10" /></span></p>
	</td>
</tr>
<tr style='height: 18.0pt'>
	<td width="66%" valign=top
		style='width: 66.2%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal
		style='line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'><span
		style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
		style='font-size: 14.0pt; font-family: 宋体; color: black'>偿付利息所支付的现金<span
		lang=EN-US><o:p></o:p></span></span></p>
	</td>
	<td width="33%" valign=top
		style='width: 33.8%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal
		style='line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'><label field="faOutflowRatio" name='"偿付利息所支付的现金"' style="width: 98%; text-align: right" maxlength="10" /></span></p>
	</td>
</tr>
<tr style='height: 18.0pt'>
	<td width="66%" valign=top
		style='width: 66.2%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal
		style='line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'><span
		style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
		style='font-size: 14.0pt; font-family: 宋体; color: black'>支付的其他与筹资活动有关的现金<span
		lang=EN-US><o:p></o:p></span></span></p>
	</td>
	<td width="33%" valign=top
		style='width: 33.8%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal
		style='line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'><span
		style='mso-spacerun: yes'>&nbsp;</span><label field="faOutflowOthers" name='"支付的其他与筹资活动有关的现金"' style="width: 98%; text-align: right" maxlength="10" /></span></p>
	</td>
</tr>
<tr style='height: 18.0pt'>
	<td width="66%" valign=top
		style='width: 66.2%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal
		style='line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'><span
		style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	</span></span><span style='font-size: 14.0pt; font-family: 宋体; color: black'>现金流出小计<span
		lang=EN-US><o:p></o:p></span></span></p>
	</td>
	<td width="33%" valign=top
		style='width: 33.8%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal align=right
		style='text-align: right; line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'><label field="faOutflowSum" name='"现金流出小计"' style="width: 98%; text-align: right" maxlength="10" /></span></p>
	</td>
</tr>
<tr style='height: 18.0pt'>
	<td width="66%" valign=top
		style='width: 66.2%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal align=center
		style='text-align: center; line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		style='font-size: 14.0pt; font-family: 宋体; color: black'>筹资活动产生的现金流量净额<span
		lang=EN-US><o:p></o:p></span></span></p>
	</td>
	<td width="33%" valign=top
		style='width: 33.8%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal align=right
		style='text-align: right; line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'><label field="faNetAmount" name='"筹资活动产生的现金流量净额"' style="width: 98%; text-align: right" maxlength="10" /></span></p>
	</td>
</tr>
<tr style='height: 18.0pt'>
	<td width="66%" valign=top
		style='width: 66.2%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal
		style='line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		style='font-size: 14.0pt; font-family: 宋体; color: black'>四、汇率变动对现金的影响额<span
		lang=EN-US><o:p></o:p></span></span></p>
	</td>
	<td width="33%" valign=top
		style='width: 33.8%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; mso-border-alt: solid windowtext .75pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal align=right
		style='text-align: right; line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'><label field="exchangeRateMovement" name='"四、汇率变动对现金的影响额"' style="width: 98%; text-align: right" maxlength="10" /></span></p>
	</td>
</tr>
<tr style='mso-yfti-lastrow: yes; height: 18.0pt'>
	<td width="66%" valign=top
		style='width: 66.2%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .75pt; mso-border-top-alt: .75pt; mso-border-left-alt: 1.5pt; mso-border-bottom-alt: 1.5pt; mso-border-right-alt: .75pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal
		style='line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		style='font-size: 14.0pt; font-family: 宋体; color: black'>五、现金及现金等价物净增加额<span
		lang=EN-US><o:p></o:p></span></span></p>
	</td>
	<td width="33%" valign=top
		style='width: 33.8%; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .75pt; mso-border-left-alt: solid windowtext .75pt; padding: 0cm 1.5pt 0cm 1.5pt; height: 18.0pt'>
	<p class=MsoNormal align=right
		style='text-align: right; line-height: 32.0pt; mso-line-height-rule: exactly; mso-layout-grid-align: none; text-autospace: none'><span
		lang=EN-US style='font-size: 14.0pt; font-family: 宋体; color: black'><label field="netRevalueation" name='"五、现金及现金等价物净增加额"' style="width: 98%; text-align: right" maxlength="10" /></span></p>
	</td>
</tr>
</table>
</form>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</div>
</div>
</body>
</html>

