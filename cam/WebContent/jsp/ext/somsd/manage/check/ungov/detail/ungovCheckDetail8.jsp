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
	var somCheckCashFlowDataSet = L5.DatasetMgr.lookup("somCheckCashFlowDataSet");
	somCheckCashFlowDataSet.setParameter("TASK_CODE@=", taskCode);
	somCheckCashFlowDataSet.load();
	somCheckCashFlowDataSet.on("load",function(ds){
		if(ds.getCount()==0){
			ds.newRecord();
		}
	});
	//创建页面导航下拉框
	createUngovDetailSelect();
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
label {
	text-align:right;
	font-size: 14px;
	font-family: 宋体;
}
</style>
</head>

<body>
<model:datasets>
	<model:dataset id="somCheckCashFlowDataSet" cmd="com.inspur.cams.sorg.check.checkcashflow.cmd.SomCheckCashFlowQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.checkcashflow.data.SomCheckCashFlow"></model:record>
	</model:dataset>
</model:datasets>
<div id="float" class="noprint">	
	<input type="button" value="上一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="nextPageM1('7')"/>
	<input type="button" value="下一页" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="nextPageM1('9')"/>
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="backM();"/>
	<input type="button" value="打印" style="height:25px;width:80px;position:absolute;margin-left:320px;" onclick="docPrint();"/>
</div>

<div align=center>
<div align=left style="width: 610px">
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<form method="post" dataset="somCheckCashFlowDataSet" onsubmit="return false">
<p class=MsoNormal align=center style='text-align:center;line-height:21.0pt;
mso-line-height-rule:exactly'><b style='mso-bidi-font-weight:normal'><span
style='font-size:12.0pt;font-family:宋体;color:black'>（三）现金流量表<span lang=EN-US><o:p></o:p></span></span></b></p>

<p class=MsoNormal align=center style='text-align:center;line-height:21.0pt;
mso-line-height-rule:exactly'><span style='font-size:10.5pt;font-family:楷体_GB2312;
mso-hansi-font-family:宋体;color:black'>（截止到本年度<span lang=EN-US>12</span>月<span
lang=EN-US>31</span>日）<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal align=center style='line-height:20.0pt;mso-line-height-rule:exactly'><span
style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
color:black'>编制单位：<label field="organizationUnit" style="width: 260;text-align:left" ></label><span lang=EN-US><span
style='mso-spacerun:yes'>
</span></span><span lang=EN-US><span
style='mso-spacerun:yes'></span><span
style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span
style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;</span></span>　　　单位：元<span
lang=EN-US><o:p></o:p></span></span></p>

<div align=center>

<table class=MsoNormalTable border=1 cellspacing=0 cellpadding=0 width="610"
 style='width:610;border-collapse:collapse;border:none;mso-border-alt:solid windowtext 1.5pt;
 mso-padding-alt:0cm 1.5pt 0cm 1.5pt;mso-border-insideh:.75pt solid windowtext;
 mso-border-insidev:.75pt solid windowtext'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes;height:23.3pt'>
  <td width="66%" style='width:66.2%;border-top:1.5pt;border-left:1.5pt;
  border-bottom:1.0pt;border-right:1.0pt;border-color:windowtext;border-style:
  solid;mso-border-top-alt:1.5pt;mso-border-left-alt:1.5pt;mso-border-bottom-alt:
  .75pt;mso-border-right-alt:.75pt;mso-border-color-alt:windowtext;mso-border-style-alt:
  solid;padding:0cm 1.5pt 0cm 1.5pt;height:23.3pt'>
  <p class=MsoNormal align=center style='text-align:center;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span style='font-size:
  10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;color:black'>项<span
  lang=EN-US><span style='mso-spacerun:yes'>&nbsp; </span></span>目<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="33%" style='width:33.8%;border-top:solid windowtext 1.5pt;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-left-alt:solid windowtext .75pt;mso-border-top-alt:1.5pt;
  mso-border-left-alt:.75pt;mso-border-bottom-alt:.75pt;mso-border-right-alt:
  1.5pt;mso-border-color-alt:windowtext;mso-border-style-alt:solid;padding:
  0cm 1.5pt 0cm 1.5pt;height:23.3pt'>
  <p class=MsoNormal align=center style='text-align:center;line-height:16.0pt;
  mso-line-height-rule:exactly;text-autospace:none'><span style='font-size:
  10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;color:black'>金<span
  lang=EN-US><span style='mso-spacerun:yes'>&nbsp; </span></span>额<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:1;height:3.25pt'>
  <td width="66%" style='width:66.2%;border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-alt:solid windowtext .75pt;
  mso-border-left-alt:solid windowtext 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;
  height:3.25pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><b style='mso-bidi-font-weight:normal'><span
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'>一、业务活动产生的现金流量：<span lang=EN-US><o:p></o:p></span></span></b></p>
  </td>
  <td width="33%" style='width:33.8%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:3.25pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><b style='mso-bidi-font-weight:normal'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>&nbsp;</o:p></span></b></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:2;height:15.0pt'>
  <td width="66%" style='width:66.2%;border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-alt:solid windowtext .75pt;
  mso-border-left-alt:solid windowtext 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;
  height:15.0pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'>接受捐赠收到的现金<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="33%" style='width:33.8%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:15.0pt'>
  <p class=MsoNormal align=right style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><o:p>
  <label  onkeyup="value=value.replace(/[^\d.-]/g,'');countBaInflowSum();" id="baInflowSum0" field="baReceiveDonations" 
  name='"接受捐赠收到的现金"' style="width:98%"  maxlength="15" style='text-align:right' />
  </o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:3;height:15.0pt'>
  <td width="66%" style='width:66.2%;border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-alt:solid windowtext .75pt;
  mso-border-left-alt:solid windowtext 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;
  height:15.0pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'>收取会费收到的现金<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="33%" style='width:33.8%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:15.0pt'>
  <p class=MsoNormal align=right  style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><o:p>
<label  onkeyup="value=value.replace(/[^\d.-]/g,'');countBaInflowSum();" id="baInflowSum1" field="baGatherDues" 
name='"收取会费收到的现金"' style="width:98%"  maxlength="15" style='text-align:right' />
  </o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:4;height:15.0pt'>
  <td width="66%" style='width:66.2%;border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-alt:solid windowtext .75pt;
  mso-border-left-alt:solid windowtext 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;
  height:15.0pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'>提供服务收到的现金<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="33%" style='width:33.8%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:15.0pt'>
  <p class=MsoNormal align=right  style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><o:p>
  <label  onkeyup="value=value.replace(/[^\d.-]/g,'');countBaInflowSum();" id="baInflowSum2" field="baRenderServices" 
  name='"提供服务收到的现金"' style="width:98%" maxlength="15" style='text-align:right'  />
  </o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:5;height:15.0pt'>
  <td width="66%" style='width:66.2%;border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-alt:solid windowtext .75pt;
  mso-border-left-alt:solid windowtext 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;
  height:15.0pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'>销售商品收到的现金<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="33%" style='width:33.8%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:15.0pt'>
  <p class=MsoNormal align=right  style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><o:p>
  <label  onkeyup="value=value.replace(/[^\d.-]/g,'');countBaInflowSum();" id="baInflowSum3" field="baSellProduct" 
  name='"销售商品收到的现金"' style="width:98%"  maxlength="15" style='text-align:right' />
  </o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:6;height:15.0pt'>
  <td width="66%" style='width:66.2%;border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-alt:solid windowtext .75pt;
  mso-border-left-alt:solid windowtext 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;
  height:15.0pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'>政府补助收到的现金<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="33%" style='width:33.8%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:15.0pt'>
  <p class=MsoNormal align=right  style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><o:p>
  <label  onkeyup="value=value.replace(/[^\d.-]/g,'');countBaInflowSum();" id="baInflowSum4" field="baGovernmentGrants" 
  name='"政府补助收到的现金"' style="width:98%" maxlength="15" style='text-align:right'  />
  </o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:7;height:15.0pt'>
  <td width="66%" style='width:66.2%;border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-alt:solid windowtext .75pt;
  mso-border-left-alt:solid windowtext 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;
  height:15.0pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'>收到的其他与业务活动有关的现金<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="33%" style='width:33.8%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:15.0pt'>
  <p class=MsoNormal align=right  style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><o:p>
  <label  onkeyup="value=value.replace(/[^\d.-]/g,'');countBaInflowSum();" id="baInflowSum5" field="baInfolwOthers" 
  name='"收到的其他与业务活动有关的现金"' style="width:98%"  maxlength="15" style='text-align:right' />
  </o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:8;height:15.0pt'>
  <td width="66%" style='width:66.2%;border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-alt:solid windowtext .75pt;
  mso-border-left-alt:solid windowtext 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;
  height:15.0pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></span><span
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'>现金流入小计<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="33%" style='width:33.8%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:15.0pt'>
  <p class=MsoNormal align=right  align=right style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><o:p>
  <label id="baInflowSum" field="baInflowSum" name='"现金流入小计"' 
  style=''></label>
  </o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:9;height:15.0pt'>
  <td width="66%" style='width:66.2%;border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-alt:solid windowtext .75pt;
  mso-border-left-alt:solid windowtext 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;
  height:15.0pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'>提供捐赠或者资助支付的现金<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="33%" style='width:33.8%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:15.0pt'>
  <p class=MsoNormal align=right  style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><o:p>
  <label  onkeyup="value=value.replace(/[^\d.-]/g,'');countBaOutflowSum();"id="baOutflowSum1" field="baDonatedPay" 
  name='"提供捐赠或者资助支付的现金"' style="width:98%"  maxlength="15" style='text-align:right' />
  </o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:10;height:15.0pt'>
  <td width="66%" style='width:66.2%;border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-alt:solid windowtext .75pt;
  mso-border-left-alt:solid windowtext 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;
  height:15.0pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'>支付给员工以及为员工支付的现金<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="33%" style='width:33.8%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:15.0pt'>
  <p class=MsoNormal align=right  style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><o:p>
  <label  onkeyup="value=value.replace(/[^\d.-]/g,'');countBaOutflowSum();"id="baOutflowSum2" field="baPayEmployee" 
  name='"支付给员工以及为员工支付的现金"' style="width:98%"  maxlength="15" style='text-align:right' />
  </o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:11;height:15.0pt'>
  <td width="66%" style='width:66.2%;border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-alt:solid windowtext .75pt;
  mso-border-left-alt:solid windowtext 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;
  height:15.0pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'>购买商品、接受服务支付的现金<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="33%" style='width:33.8%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:15.0pt'>
  <p class=MsoNormal align=right  style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><o:p>
  <label  onkeyup="value=value.replace(/[^\d.-]/g,'');countBaOutflowSum();" id="baOutflowSum3" field="baProductServices" 
  name='"购买商品、接受服务支付的现金"' style="width:98%"  maxlength="15" style='text-align:right' />
  </o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:12;height:15.0pt'>
  <td width="66%" style='width:66.2%;border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-alt:solid windowtext .75pt;
  mso-border-left-alt:solid windowtext 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;
  height:15.0pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'>支付的其他与业务活动有关的现金<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="33%" style='width:33.8%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:15.0pt'>
  <p class=MsoNormal align=right  style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><o:p>
  <label  onkeyup="value=value.replace(/[^\d.-]/g,'');countBaOutflowSum();" id="baOutflowSum4" field="baOutflowOthers" 
  name='"支付的其他与业务活动有关的现金"' style="width:98%"  maxlength="15" style='text-align:right' />
  </o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:13;height:15.0pt'>
  <td width="66%" style='width:66.2%;border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-alt:solid windowtext .75pt;
  mso-border-left-alt:solid windowtext 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;
  height:15.0pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span></span><span style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:
  宋体;color:black'>现金流出小计<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="33%" style='width:33.8%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:15.0pt'>
  <p class=MsoNormal align=right  align=right style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><o:p>
  <label id="baOutflowSum" field="baOutflowSum" name='"现金流出小计"' 
  style=''></label>
  </o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:14;height:15.0pt'>
  <td width="66%" style='width:66.2%;border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-alt:solid windowtext .75pt;
  mso-border-left-alt:solid windowtext 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;
  height:15.0pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span style='font-size:10.5pt;font-family:楷体_GB2312;
  mso-hansi-font-family:宋体;color:black'>业务活动产生的现金流量净额<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="33%" style='width:33.8%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:15.0pt'>
  <p class=MsoNormal align=right style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><o:p>
  <label id="baNetAmount" field="baNetAmount" name='"业务活动产生的现金流量净额"'
  style=''></label>
  </o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:15;height:15.0pt'>
  <td width="66%" style='width:66.2%;border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-alt:solid windowtext .75pt;
  mso-border-left-alt:solid windowtext 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;
  height:15.0pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><b style='mso-bidi-font-weight:normal'><span
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'>二、投资活动产生的现金流量：<span lang=EN-US><o:p></o:p></span></span></b></p>
  </td>
  <td width="33%" style='width:33.8%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:15.0pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><b style='mso-bidi-font-weight:normal'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>&nbsp;</o:p></span></b></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:16;height:15.0pt'>
  <td width="66%" style='width:66.2%;border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-alt:solid windowtext .75pt;
  mso-border-left-alt:solid windowtext 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;
  height:15.0pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'>收回投资所收到的现金<span lang=EN-US> <o:p></o:p></span></span></p>
  </td>
  <td width="33%" style='width:33.8%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:15.0pt'>
  <p class=MsoNormal align=right  style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><o:p>
  <label  onkeyup="value=value.replace(/[^\d.-]/g,'');countIaInflowSum();"id="iaInflowSum4" field="iaRegoupingOutlay" 
  name='"收回投资所收到的现金"' style="width:98%"  maxlength="15" style='text-align:right' />
  </o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:17;height:15.0pt'>
  <td width="66%" style='width:66.2%;border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-alt:solid windowtext .75pt;
  mso-border-left-alt:solid windowtext 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;
  height:15.0pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'>取得投资收益所收到的现金<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="33%" style='width:33.8%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:15.0pt'>
  <p class=MsoNormal align=right  style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><o:p>
  <label  onkeyup="value=value.replace(/[^\d.-]/g,'');countIaInflowSum();"id="iaInflowSum3" field="iaMadeIncome" 
  name='"取得投资收益所收到的现金"' style="width:98%"  maxlength="15" style='text-align:right' />
  </o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:18;height:15.0pt'>
  <td width="66%" style='width:66.2%;border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-alt:solid windowtext .75pt;
  mso-border-left-alt:solid windowtext 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;
  height:15.0pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'>处置固定资产和无形资产所收回的现金<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="33%" style='width:33.8%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:15.0pt'>
  <p class=MsoNormal align=right  style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><o:p>
  <label  onkeyup="value=value.replace(/[^\d.-]/g,'');countIaInflowSum();"id="iaInflowSum2" field="iaInflowAssets" 
  name='"处置固定资产和无形资产所收回的现金"' style="width:98%"  maxlength="15" style='text-align:right' />
  </o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:19;height:15.0pt'>
  <td width="66%" style='width:66.2%;border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-alt:solid windowtext .75pt;
  mso-border-left-alt:solid windowtext 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;
  height:15.0pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><span
  style='mso-spacerun:yes'>&nbsp;&nbsp; </span><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;</span></span><span
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'>收到的其他与投资活动有关的现金<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="33%" style='width:33.8%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:15.0pt'>
  <p class=MsoNormal align=right  style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><o:p>
  <label  onkeyup="value=value.replace(/[^\d.-]/g,'');countIaInflowSum();"id="iaInflowSum1" field="iaInflowOthers" 
  name='"收到的其他与投资活动有关的现金"' style="width:98%" maxlength="15" style='text-align:right'  />
  </o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:20;height:15.0pt'>
  <td width="66%" style='width:66.2%;border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-alt:solid windowtext .75pt;
  mso-border-left-alt:solid windowtext 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;
  height:15.0pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span></span><span style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:
  宋体;color:black'>现金流入小计<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="33%" style='width:33.8%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:15.0pt'>
  <p class=MsoNormal align=right style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><o:p>  
<label id="iaInflowSum" field="iaInflowSum" name='"现金流入小计"'
style=''></label>
  </o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:21;height:15.0pt'>
  <td width="66%" style='width:66.2%;border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-alt:solid windowtext .75pt;
  mso-border-left-alt:solid windowtext 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;
  height:15.0pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'>购建固定资产和无形资产所支付的现金<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="33%" style='width:33.8%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:15.0pt'>
  <p class=MsoNormal  align=right style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><o:p>
<label  onkeyup="value=value.replace(/[^\d.-]/g,'');countIaOutflowSum();" id="iaOutflowSum1" field="iaOutflowAssets" 
name='"购建固定资产和无形资产所支付的现金"' style="width:98%"  maxlength="15" style='text-align:right' />
  </o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:22;height:15.0pt'>
  <td width="66%" style='width:66.2%;border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-alt:solid windowtext .75pt;
  mso-border-left-alt:solid windowtext 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;
  height:15.0pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'>对外投资所支付的现金<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="33%" style='width:33.8%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:15.0pt'>
  <p class=MsoNormal align=right  style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><o:p>
			<label  onkeyup="value=value.replace(/[^\d.-]/g,'');countIaOutflowSum();" id="iaOutflowSum2" field="iaOutflowAbroad" 
			name='"对外投资所支付的现金"' style="width:98%"  maxlength="15" style='text-align:right' />
			</o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:23;height:15.0pt'>
  <td width="66%" style='width:66.2%;border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-alt:solid windowtext .75pt;
  mso-border-left-alt:solid windowtext 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;
  height:15.0pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'>支付的其他与投资活动有关的现金<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="33%" style='width:33.8%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:15.0pt'>
  <p class=MsoNormal align=right  style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><o:p>
			<label  onkeyup="value=value.replace(/[^\d.-]/g,'');countIaOutflowSum();"  id="iaOutflowSum3" field="iaOutflowOthers" 
			name='"支付的其他与投资活动有关的现金"' style="width:98%"  maxlength="15" style='text-align:right' />
			</o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:24;height:15.0pt'>
  <td width="66%" style='width:66.2%;border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-alt:solid windowtext .75pt;
  mso-border-left-alt:solid windowtext 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;
  height:15.0pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span></span><span style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:
  宋体;color:black'>现金流出小计<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="33%" style='width:33.8%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:15.0pt'>
  <p class=MsoNormal align=right style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><o:p>
<label id="iaOutflowSum" field="iaOutflowSum" name='"现金流出小计"'
style=''></label>
			</o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:25;height:15.0pt'>
  <td width="66%" style='width:66.2%;border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-alt:solid windowtext .75pt;
  mso-border-left-alt:solid windowtext 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;
  height:15.0pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span style='font-size:10.5pt;font-family:楷体_GB2312;
  mso-hansi-font-family:宋体;color:black'>投资活动产生的现金流量净额<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="33%" style='width:33.8%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:15.0pt'>
  <p class=MsoNormal align=right style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><o:p>
<label id="iaNetAmount" field="iaNetAmount" name='"投资活动产生的现金流量净额"'
style=''></label>
			</o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:26;height:15.0pt'>
  <td width="66%" style='width:66.2%;border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-alt:solid windowtext .75pt;
  mso-border-left-alt:solid windowtext 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;
  height:15.0pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><b style='mso-bidi-font-weight:normal'><span
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'>三、筹资活动产生的现金流量：<span lang=EN-US><o:p></o:p></span></span></b></p>
  </td>
  <td width="33%" style='width:33.8%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:15.0pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><b style='mso-bidi-font-weight:normal'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>&nbsp;</o:p></span></b></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:27;height:15.0pt'>
  <td width="66%" style='width:66.2%;border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-alt:solid windowtext .75pt;
  mso-border-left-alt:solid windowtext 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;
  height:15.0pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'>借款所收到的现金<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="33%" style='width:33.8%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:15.0pt'>
  <p class=MsoNormal align=right  style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><o:p>
			<label  onkeyup="value=value.replace(/[^\d.-]/g,'');countFaInflowSum();"id="faInflowSum1" field="faInflowLoan" 
			name='"借款所收到的现金"' style="width:98%"  maxlength="15" style='text-align:right' />
			</o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:28;height:15.0pt'>
  <td width="66%" style='width:66.2%;border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-alt:solid windowtext .75pt;
  mso-border-left-alt:solid windowtext 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;
  height:15.0pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'>收到的其他与筹资活动有关的现金<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="33%" style='width:33.8%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:15.0pt'>
  <p class=MsoNormal align=right  style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><o:p>
			<label  onkeyup="value=value.replace(/[^\d.-]/g,'');countFaInflowSum();"id="faInflowSum2" field="faInflowOthers" 
			name='"收到的其他与筹资活动有关的现金"' style="width:98%" maxlength="15" style='text-align:right'  />
			</o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:29;height:15.0pt'>
  <td width="66%" style='width:66.2%;border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-alt:solid windowtext .75pt;
  mso-border-left-alt:solid windowtext 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;
  height:15.0pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span><span style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;</span></span><span
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'>现金流入小计<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="33%" style='width:33.8%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:15.0pt'>
  <p class=MsoNormal align=right style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><o:p>
<label id="faInflowSum" field="faInflowSum" name='"现金流入小计"'
style=''></label>
			</o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:30;height:15.0pt'>
  <td width="66%" style='width:66.2%;border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-alt:solid windowtext .75pt;
  mso-border-left-alt:solid windowtext 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;
  height:15.0pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'>偿还借款所支付的现金<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="33%" style='width:33.8%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:15.0pt'>
  <p class=MsoNormal align=right  style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><o:p>
			<label  onkeyup="value=value.replace(/[^\d.-]/g,'');countfaOutflowSum();" id="faOutflowSum1" field="faOutflowDebt" 
			name='"偿还借款所支付的现金"' style="width:98%"  maxlength="15" style='text-align:right' />
			</o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:31;height:15.0pt'>
  <td width="66%" style='width:66.2%;border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-alt:solid windowtext .75pt;
  mso-border-left-alt:solid windowtext 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;
  height:15.0pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'>偿付利息所支付的现金<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="33%" style='width:33.8%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:15.0pt'>
  <p class=MsoNormal align=right  style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><o:p>
			<label  onkeyup="value=value.replace(/[^\d.-]/g,'');countfaOutflowSum();" id="faOutflowSum2" field="faOutflowRatio" 
			name='"偿付利息所支付的现金"' style="width:98%" maxlength="15" style='text-align:right'  />
			</o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:32;height:15.0pt'>
  <td width="66%" style='width:66.2%;border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-alt:solid windowtext .75pt;
  mso-border-left-alt:solid windowtext 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;
  height:15.0pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span><span
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'>支付的其他与筹资活动有关的现金<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="33%" style='width:33.8%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:15.0pt'>
  <p class=MsoNormal align=right  style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><span
  style='mso-spacerun:yes'>
			<label  onkeyup="value=value.replace(/[^\d.-]/g,'');countfaOutflowSum();" id="faOutflowSum3" field="faOutflowOthers" 
			name='"支付的其他与筹资活动有关的现金"' style="width:98%"  maxlength="15" style='text-align:right' />
		</span><o:p></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:33;height:15.0pt'>
  <td width="66%" style='width:66.2%;border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-alt:solid windowtext .75pt;
  mso-border-left-alt:solid windowtext 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;
  height:15.0pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span></span><span style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:
  宋体;color:black'>现金流出小计<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="33%" style='width:33.8%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:15.0pt'>
  <p class=MsoNormal align=right style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><o:p>
<label id="faOutflowSum"field="faOutflowSum" name='"现金流出小计"'
style=''></label>
		</o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:34;height:15.0pt'>
  <td width="66%" style='width:66.2%;border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-alt:solid windowtext .75pt;
  mso-border-left-alt:solid windowtext 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;
  height:15.0pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span style='font-size:10.5pt;font-family:楷体_GB2312;
  mso-hansi-font-family:宋体;color:black'>筹资活动产生的现金流量净额<span lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="33%" style='width:33.8%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:15.0pt'>
  <p class=MsoNormal align=right style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><span lang=EN-US style='font-size:10.5pt;font-family:
  楷体_GB2312;mso-hansi-font-family:宋体;color:black'><o:p>
<label id="faNetAmount" field="faNetAmount" name='"筹资活动产生的现金流量净额"'
style=''></label>
			</o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:35;height:15.0pt'>
  <td width="66%" style='width:66.2%;border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-alt:solid windowtext .75pt;
  mso-border-left-alt:solid windowtext 1.5pt;padding:0cm 1.5pt 0cm 1.5pt;
  height:15.0pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><b style='mso-bidi-font-weight:normal'><span
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'>四、汇率变动对现金的影响额<span lang=EN-US><o:p></o:p></span></span></b></p>
  </td>
  <td width="33%" style='width:33.8%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;mso-border-right-alt:solid windowtext 1.5pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:15.0pt'>
  <p class=MsoNormal align=right  style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><b style='mso-bidi-font-weight:normal'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
			<label id="exchangeRateMovement" onkeyup="value=value.replace(/[^\d.-]/g,'');netRevalueationcount()" field="exchangeRateMovement" 
			name='"四、汇率变动对现金的影响额"' style="width:98%"  maxlength="15" style='text-align:right' />
		</o:p></span></b></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:36;mso-yfti-lastrow:yes;height:3.25pt'>
  <td width="66%" style='width:66.2%;border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.5pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-top-alt:.75pt;
  mso-border-left-alt:1.5pt;mso-border-bottom-alt:1.5pt;mso-border-right-alt:
  .75pt;mso-border-color-alt:windowtext;mso-border-style-alt:solid;padding:
  0cm 1.5pt 0cm 1.5pt;height:3.25pt'>
  <p class=MsoNormal style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><b style='mso-bidi-font-weight:normal'><span
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'>五、现金及现金等价物净增加额<span lang=EN-US><o:p></o:p></span></span></b></p>
  </td>
  <td width="33%" style='width:33.8%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.5pt;border-right:solid windowtext 1.5pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  padding:0cm 1.5pt 0cm 1.5pt;height:3.25pt'>
  <p class=MsoNormal align=right style='line-height:16.0pt;mso-line-height-rule:exactly;
  text-autospace:none'><b style='mso-bidi-font-weight:normal'><span lang=EN-US
  style='font-size:10.5pt;font-family:楷体_GB2312;mso-hansi-font-family:宋体;
  color:black'><o:p>
			<label id="netRevalueation" onkeyup="value=value.replace(/[^\d.-]/g,'')" field="netRevalueation" 
			name='"五、现金及现金等价物净增加额"' maxlength="15" style='' ></label>
		</o:p></span></b></p>
  </td>
 </tr>
</table>

</div>

<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</form>
</div>
</div>
</body>
</html>
