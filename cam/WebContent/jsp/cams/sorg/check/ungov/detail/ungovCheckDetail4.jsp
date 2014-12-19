<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
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
var taskFlag='<%=request.getParameter("taskFlag")%>';
//初始化
function init(){
	somCheckChangesDataSet.setParameter("TASK_CODE", taskCode);
	somCheckChangesDataSet.load();
	somCheckChangesDataSet.on('load',function (ds){
		if(ds.getCount() == 0){
			ds.newRecord({"taskCode":taskCode});
		}else{
			for(i=1;i<=ds.getCount();i++){
				var sequence = ds.getAt(i-1).get("sequence");
				document.getElementById("changeItem"+sequence).innerText=ds.getAt(i-1).get("type");
				document.getElementById("beforeChange"+sequence).innerText=ds.getAt(i-1).get("beforeChange");
				document.getElementById("afterChange"+sequence).innerText=ds.getAt(i-1).get("afterChange");
				document.getElementById("appDate"+sequence).innerText=ds.getAt(i-1).get("approveDate");
			}
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
<STYLE>
label {
	text-align:center;
	font-size: 13px;
	font-family: 宋体;
}
textarea {
	overflow-x: hidden;
	overflow-y: hidden;
}
</STYLE>
</head>

<body>
<model:datasets>
	<model:dataset id="somCheckDataSet" cmd="com.inspur.cams.sorg.check.somcheck.cmd.SomCheckQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.somcheck.data.SomCheck">
		</model:record>
	</model:dataset>
	<!-- 工作人员情况 -->
	<model:dataset id="somCheckWorkerDataSet" cmd="com.inspur.cams.sorg.check.checkworker.cmd.SomCheckWorkerQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.checkworker.data.SomCheckWorker"></model:record>
	</model:dataset>		
	<model:dataset id="somCheckSuborganDataSet" cmd="com.inspur.cams.sorg.check.checksuborgan.cmd.SomCheckSuborganQueryCommand" global="true" pageSize="300">
		<model:record fromBean="com.inspur.cams.sorg.check.checksuborgan.data.SomCheckSuborgan"></model:record>
	</model:dataset>
	<model:dataset id="somCheckChangesDataSet" cmd="com.inspur.cams.sorg.check.checkchanges.cmd.SomCheckChangesQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.checkchanges.data.SomCheckChanges"></model:record>
	</model:dataset>
	<!-- 业务主管单位 -->
	<model:dataset id="businessOrganSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true" sortField="ORDER_NUMBER">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_BUSINESS_ORGAN'></model:param>
			<model:param name="value" value='BORG_CODE'></model:param>
			<model:param name="text" value='BORG_NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="sorgKindSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_UNGOV_KIND'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>	
	<model:dataset id="resideSourceSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_RESIDE_SOURCE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>	
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>		
</model:datasets>
<div id="float" class="noprint" >
	<input type="button" value="上一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="nextPageM1('3')"/>
	<input type="button" value="下一页" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="nextPageM1('5')"/>
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="back1();"/>
	<input type="button" value="打印" style="height:25px;width:80px;position:absolute;margin-left:320px;" onclick="docPrint();"/>
</div>
<div class=WordSection1 style='layout-grid:15.6pt'>

<p class=MsoNormal align=center style='margin-bottom:7.8pt;mso-para-margin-bottom:
.5gd;text-align:center'><span style='font-size:22.0pt;mso-bidi-font-size:12.0pt;
font-family:黑体;mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:
"Times New Roman"'>本年度变更登记事项</span><span lang=EN-US style='font-size:22.0pt;
mso-bidi-font-size:12.0pt;mso-fareast-font-family:黑体'><o:p></o:p></span></p>

<div align=center>
<form dataset=somCheckChangesDataSet method="post" onsubmit="return false">
<table class=MsoNormalTable border=1 cellspacing=0 cellpadding=0 width=610
 style='width:610;border-collapse:collapse;border:none;mso-border-alt:solid windowtext 2.25pt;
 mso-padding-alt:0cm 5.4pt 0cm 5.4pt;mso-border-insideh:.75pt solid windowtext;
 mso-border-insidev:.75pt solid windowtext'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes;height:53.85pt'>
  <td width=110 style='width:93.55pt;border-top:2.25pt;border-left:2.25pt;
  border-bottom:1.0pt;border-right:1.0pt;border-color:windowtext;border-style:
  solid;mso-border-top-alt:2.25pt;mso-border-left-alt:2.25pt;mso-border-bottom-alt:
  .75pt;mso-border-right-alt:.75pt;mso-border-color-alt:windowtext;mso-border-style-alt:
  solid;padding:0cm 5.4pt 0cm 5.4pt;height:53.85pt'>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'><span style='font-size:14.0pt;font-family:
  宋体'>变更事项<span lang=EN-US><o:p></o:p></span></span></b></p>
  </td>
  <td width=110 style='width:93.55pt;border-top:solid windowtext 2.25pt;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-left-alt:solid windowtext .75pt;mso-border-alt:solid windowtext .75pt;
  mso-border-top-alt:solid windowtext 2.25pt;padding:0cm 5.4pt 0cm 5.4pt;
  height:53.85pt'>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'><span style='font-size:14.0pt;font-family:
  宋体'>批准时间<span lang=EN-US><o:p></o:p></span></span></b></p>
  </td>
  <td width=130 style='width:93.55pt;border-top:solid windowtext 2.25pt;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-left-alt:solid windowtext .75pt;mso-border-alt:solid windowtext .75pt;
  mso-border-top-alt:solid windowtext 2.25pt;padding:0cm 5.4pt 0cm 5.4pt;
  height:53.85pt'>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'><span style='font-size:14.0pt;font-family:
  宋体'>变更前情况<span lang=EN-US><o:p></o:p></span></span></b></p>
  </td>
  <td width=260 style='width:158.75pt;border-top:solid windowtext 2.25pt;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 2.25pt;
  mso-border-left-alt:solid windowtext .75pt;mso-border-top-alt:2.25pt;
  mso-border-left-alt:.75pt;mso-border-bottom-alt:.75pt;mso-border-right-alt:
  2.25pt;mso-border-color-alt:windowtext;mso-border-style-alt:solid;padding:
  0cm 5.4pt 0cm 5.4pt;height:53.85pt'>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'><span style='font-size:14.0pt;font-family:
  宋体'>变更后情况<span lang=EN-US><o:p></o:p></span></span></b></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:1;height:77.95pt'>
  <td width=125 valign="middle" style='width:93.55pt;border-top:none;border-left:
  solid windowtext 2.25pt;border-bottom:solid windowtext 1.0pt;border-right:
  solid windowtext 1.0pt;mso-border-top-alt:solid windowtext .75pt;mso-border-alt:
  solid windowtext .75pt;mso-border-left-alt:solid windowtext 2.25pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:77.95pt'>
  <p class=MsoNormal style='line-height:9.0pt;mso-line-height-rule:exactly'><span
  lang=EN-US style='font-size:14.0pt;font-family:宋体;mso-bidi-font-weight:bold'><o:p><label id="changeItem1" style="width:98%" ></label></o:p></span></p>
  </td>
  <td width=125 valign="middle" style='width:93.55pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  77.95pt'>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt;font-family:宋体;
  mso-bidi-font-weight:bold'><o:p><label id=appDate1 style='width:98%' ></label></o:p></span></p>
  </td>
  <td width=125 valign="middle" style='width:93.55pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  77.95pt'>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt;font-family:宋体;
  mso-bidi-font-weight:bold'><o:p><label id=beforeChange1  width='98%'></label></o:p></span></p>
  </td>
  <td width=212 valign="middle" style='width:158.75pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 2.25pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;mso-border-right-alt:solid windowtext 2.25pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:77.95pt'>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt;font-family:宋体;
  mso-bidi-font-weight:bold'><o:p><label id=afterChange1 width='98%'></label></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:2;height:77.95pt'>
  <td width=125 valign="middle" style='width:93.55pt;border-top:none;border-left:
  solid windowtext 2.25pt;border-bottom:solid windowtext 1.0pt;border-right:
  solid windowtext 1.0pt;mso-border-top-alt:solid windowtext .75pt;mso-border-alt:
  solid windowtext .75pt;mso-border-left-alt:solid windowtext 2.25pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:77.95pt'>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt;font-family:宋体;
  mso-bidi-font-weight:bold'><o:p><label id="changeItem2" style="width:98%" ></label></o:p></span></p>
  </td>
  <td width=125 valign="middle" style='width:93.55pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  77.95pt'>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt;font-family:宋体;
  mso-bidi-font-weight:bold'><o:p><label id=appDate2 style='width:98%' ></label></o:p></span></p>
  </td>
  <td width=125 valign="middle" style='width:93.55pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  77.95pt'>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt;font-family:宋体;
  mso-bidi-font-weight:bold'><o:p><label id=beforeChange2  width='98%'></label></o:p></span></p>
  </td>
  <td width=212 valign="middle" style='width:158.75pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 2.25pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;mso-border-right-alt:solid windowtext 2.25pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:77.95pt'>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt;font-family:宋体;
  mso-bidi-font-weight:bold'><o:p><label id=afterChange2 width='98%'></label></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:3;height:77.95pt'>
  <td width=125 valign="middle" style='width:93.55pt;border-top:none;border-left:
  solid windowtext 2.25pt;border-bottom:solid windowtext 1.0pt;border-right:
  solid windowtext 1.0pt;mso-border-top-alt:solid windowtext .75pt;mso-border-alt:
  solid windowtext .75pt;mso-border-left-alt:solid windowtext 2.25pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:77.95pt'>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt;font-family:宋体;
  mso-bidi-font-weight:bold'><o:p><label id="changeItem3" style="width:98%" ></label></o:p></span></p>
  </td>
  <td width=125 valign="middle" style='width:93.55pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  77.95pt'>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt;font-family:宋体;
  mso-bidi-font-weight:bold'><o:p><label id=appDate3 style='width:98%' ></label></o:p></span></p>
  </td>
  <td width=125 valign="middle" style='width:93.55pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  77.95pt'>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt;font-family:宋体;
  mso-bidi-font-weight:bold'><o:p><label id=beforeChange3  width='98%'></label></o:p></span></p>
  </td>
  <td width=212 valign="middle" style='width:158.75pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 2.25pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;mso-border-right-alt:solid windowtext 2.25pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:77.95pt'>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt;font-family:宋体;
  mso-bidi-font-weight:bold'><o:p><label id=afterChange3 width='98%'></label></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:4;height:77.95pt'>
  <td width=125 valign="middle" style='width:93.55pt;border-top:none;border-left:
  solid windowtext 2.25pt;border-bottom:solid windowtext 1.0pt;border-right:
  solid windowtext 1.0pt;mso-border-top-alt:solid windowtext .75pt;mso-border-alt:
  solid windowtext .75pt;mso-border-left-alt:solid windowtext 2.25pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:77.95pt'>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt;font-family:宋体;
  mso-bidi-font-weight:bold'><o:p><label id="changeItem4" style="width:98%"></label></o:p></span></p>
  </td>
  <td width=125 valign="middle" style='width:93.55pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  77.95pt'>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt;font-family:宋体;
  mso-bidi-font-weight:bold'><o:p><label id=appDate4 style='width:98%' ></label></o:p></span></p>
  </td>
  <td width=125 valign="middle" style='width:93.55pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  77.95pt'>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt;font-family:宋体;
  mso-bidi-font-weight:bold'><o:p><label id=beforeChange4  width='98%'></label></o:p></span></p>
  </td>
  <td width=212 valign="middle" style='width:158.75pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 2.25pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;mso-border-right-alt:solid windowtext 2.25pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:77.95pt'>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt;font-family:宋体;
  mso-bidi-font-weight:bold'><o:p><label id=afterChange4 width='98%'></label></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:5;height:77.95pt'>
  <td width=125 valign="middle" style='width:93.55pt;border-top:none;border-left:
  solid windowtext 2.25pt;border-bottom:solid windowtext 1.0pt;border-right:
  solid windowtext 1.0pt;mso-border-top-alt:solid windowtext .75pt;mso-border-alt:
  solid windowtext .75pt;mso-border-left-alt:solid windowtext 2.25pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:77.95pt'>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt;font-family:宋体;
  mso-bidi-font-weight:bold'><o:p><label id="changeItem5" style="width:98%"></label></o:p></span></p>
  </td>
  <td width=125 valign="middle" style='width:93.55pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  77.95pt'>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt;font-family:宋体;
  mso-bidi-font-weight:bold'><o:p><label id=appDate5 style='width:98%'></label></o:p></span></p>
  </td>
  <td width=125 valign="middle" style='width:93.55pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  77.95pt'>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt;font-family:宋体;
  mso-bidi-font-weight:bold'><o:p><label id=beforeChange5  width='98%'></label></o:p></span></p>
  </td>
  <td width=212 valign="middle" style='width:158.75pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 2.25pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;mso-border-right-alt:solid windowtext 2.25pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:77.95pt'>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt;font-family:宋体;
  mso-bidi-font-weight:bold'><o:p><label id=afterChange5 width='98%'></label></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:6;height:77.95pt'>
  <td width=125 valign="middle" style='width:93.55pt;border-top:none;border-left:
  solid windowtext 2.25pt;border-bottom:solid windowtext 1.0pt;border-right:
  solid windowtext 1.0pt;mso-border-top-alt:solid windowtext .75pt;mso-border-alt:
  solid windowtext .75pt;mso-border-left-alt:solid windowtext 2.25pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:77.95pt'>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt;font-family:宋体;
  mso-bidi-font-weight:bold'><o:p><label id="changeItem6" style="width:98%" ></label></o:p></span></p>
  </td>
  <td width=125 valign="middle" style='width:93.55pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  77.95pt'>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt;font-family:宋体;
  mso-bidi-font-weight:bold'><o:p><label id=appDate6 style='width:98%' ></label></o:p></span></p>
  </td>
  <td width=125 valign="middle" style='width:93.55pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  77.95pt'>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt;font-family:宋体;
  mso-bidi-font-weight:bold'><o:p><label id=beforeChange6  width='98%'></label></o:p></span></p>
  </td>
  <td width=212 valign="middle" style='width:158.75pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 2.25pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;mso-border-right-alt:solid windowtext 2.25pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:77.95pt'>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt;font-family:宋体;
  mso-bidi-font-weight:bold'><o:p><label id=afterChange6 width='98%'></label></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:7;mso-yfti-lastrow:yes;height:77.95pt'>
  <td width=125 valign="middle" style='width:93.55pt;border-top:none;border-left:
  solid windowtext 2.25pt;border-bottom:solid windowtext 2.25pt;border-right:
  solid windowtext 1.0pt;mso-border-top-alt:solid windowtext .75pt;mso-border-top-alt:
  .75pt;mso-border-left-alt:2.25pt;mso-border-bottom-alt:2.25pt;mso-border-right-alt:
  .75pt;mso-border-color-alt:windowtext;mso-border-style-alt:solid;padding:
  0cm 5.4pt 0cm 5.4pt;height:77.95pt'>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt;font-family:宋体;
  mso-bidi-font-weight:bold'><o:p><label id="changeItem7" style="width:98%"></label></o:p></span></p>
  </td>
  <td width=125 valign="middle" style='width:93.55pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 2.25pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;mso-border-bottom-alt:solid windowtext 2.25pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:77.95pt'>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt;font-family:宋体;
  mso-bidi-font-weight:bold'><o:p><label id=appDate7 style='width:98%'></label></o:p></span></p>
  </td>
  <td width=125 valign="middle" style='width:93.55pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 2.25pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;mso-border-bottom-alt:solid windowtext 2.25pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:77.95pt'>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt;font-family:宋体;
  mso-bidi-font-weight:bold'><o:p><label id=beforeChange7  width='98%'></label></o:p></span></p>
  </td>
  <td width=212 valign="middle" style='width:158.75pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 2.25pt;border-right:solid windowtext 2.25pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:77.95pt'>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt;font-family:宋体;
  mso-bidi-font-weight:bold'><o:p><label id=afterChange7 width='98%'></label></o:p></span></p>
  </td>
 </tr>
</table>
</form>
</div>

<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>

</div>
</body>
</html>
