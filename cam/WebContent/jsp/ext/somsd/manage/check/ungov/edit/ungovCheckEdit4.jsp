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
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
<link href="../../css/float.css" type="text/css" rel="stylesheet" />
<script language="javascript">
var taskCode='<%=request.getParameter("taskCode")%>';
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
				document.getElementById("changeItem"+sequence).value=ds.getAt(i-1).get("type");
				document.getElementById("beforeChange"+sequence).value=ds.getAt(i-1).get("beforeChange");
				document.getElementById("afterChange"+sequence).value=ds.getAt(i-1).get("afterChange");
				document.getElementById("appDate"+sequence).value=ds.getAt(i-1).get("approveDate");
			}
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
	var somCheckChangesDataSet=getSomCheckChangesDataSet();
	if(somCheckChangesDataSet=="break"){
		return "break";
	}
	var somCheckChangesRecords=somCheckChangesDataSet.getAllRecords();
	var command = new L5.Command("com.inspur.cams.sorg.check.somcheck.cmd.SomCheckCommand");
	command.setParameter("taskCode", taskCode);
	command.setParameter("somCheckChangesRecords",somCheckChangesRecords);
	command.setParameter("pageNum", "4");
	command.execute("savePageM3");
	if (!command.error) {
		alert("保存成功！");
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
function getSomCheckChangesDataSet(){
	somCheckChangesDataSet.removeAll();
	for(i=1;i<=6;i++){
		if(document.getElementById("changeItem"+i).value==""||document.getElementById("changeItem"+i).value==null){
			continue;
		}else{
			var record = somCheckChangesDataSet.newRecord();
			var beforeChange=document.getElementById("beforeChange"+i).value;
			var afterChange=document.getElementById("afterChange"+i).value;
			var appDate=document.getElementById("appDate"+i).value;
			if(beforeChange==""||afterChange==""){
				L5.Msg.alert("提示","请填写变更前后情况！");
				return "break";
			}
			if(appDate==""){
				L5.Msg.alert("提示","请选择批准时间！");
				return "break";
			}
			record.set("taskCode",taskCode);
			record.set("sequence",i);
			record.set("type",document.getElementById("changeItem"+i).value);
			record.set("beforeChange",document.getElementById("beforeChange"+i).value);
			record.set("afterChange",document.getElementById("afterChange"+i).value);
			record.set("approveDate",document.getElementById("appDate"+i).value);
		}
	}
	return somCheckChangesDataSet;
}
</script>
<STYLE>
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
	<model:dataset id="somCheckSuborganDataSet" cmd="com.inspur.cams.sorg.check.checksuborgan.cmd.SomCheckSuborganQueryCommand" global="true" pageSize="300" sortField="TO_NUMBER(SEQUENCE)">
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
<div id="float" >
	<input type="button" value="上一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="nextPageM('3')"/>
	<input type="button" value="下一页" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="nextPageM('5')"/>
	<input type="button" value="保存" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="save();"/>
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:320px;" onclick="backM();"/>
	<!--[if lte IE 7]><div></div><![endif]-->
	<span style="height:25px;width:80px;position:absolute;margin-left:420px;">当前页数：3</span>
</div>
<div class=WordSection1 style='layout-grid:15.6pt'>

<p class=MsoNormal align=center style='margin-bottom:7.8pt;mso-para-margin-bottom:
.5gd;text-align:center'><span style='font-size:22.0pt;mso-bidi-font-size:12.0pt;
font-family:黑体;mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:
"Times New Roman"'>本年度变更登记事项</span><span lang=EN-US style='font-size:22.0pt;
mso-bidi-font-size:12.0pt;mso-fareast-font-family:黑体'><o:p></o:p></span></p>

<div align=center>
<form dataset=somCheckChangesDataSet method="post" onsubmit="return false">
<table class=MsoNormalTable border=1 cellspacing=0 cellpadding=0 width=646
 style='width:484.8pt;border-collapse:collapse;border:none;mso-border-alt:solid windowtext 2.25pt;
 mso-padding-alt:0cm 5.4pt 0cm 5.4pt;mso-border-insideh:.75pt solid windowtext;
 mso-border-insidev:.75pt solid windowtext'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes;height:53.85pt'>
  <td width=125 style='width:93.55pt;border-top:2.25pt;border-left:2.25pt;
  border-bottom:1.0pt;border-right:1.0pt;border-color:windowtext;border-style:
  solid;mso-border-top-alt:2.25pt;mso-border-left-alt:2.25pt;mso-border-bottom-alt:
  .75pt;mso-border-right-alt:.75pt;mso-border-color-alt:windowtext;mso-border-style-alt:
  solid;padding:0cm 5.4pt 0cm 5.4pt;height:53.85pt'>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'><span style='font-size:14.0pt;font-family:
  宋体'>变更事项<span lang=EN-US><o:p></o:p></span></span></b></p>
  </td>
  <td width=125 style='width:93.55pt;border-top:solid windowtext 2.25pt;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-left-alt:solid windowtext .75pt;mso-border-alt:solid windowtext .75pt;
  mso-border-top-alt:solid windowtext 2.25pt;padding:0cm 5.4pt 0cm 5.4pt;
  height:53.85pt'>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'><span style='font-size:14.0pt;font-family:
  宋体'>批准时间<span lang=EN-US><o:p></o:p></span></span></b></p>
  </td>
  <td width=125 style='width:93.55pt;border-top:solid windowtext 2.25pt;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-left-alt:solid windowtext .75pt;mso-border-alt:solid windowtext .75pt;
  mso-border-top-alt:solid windowtext 2.25pt;padding:0cm 5.4pt 0cm 5.4pt;
  height:53.85pt'>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'><span style='font-size:14.0pt;font-family:
  宋体'>变更前情况<span lang=EN-US><o:p></o:p></span></span></b></p>
  </td>
  <td width=212 style='width:158.75pt;border-top:solid windowtext 2.25pt;
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
  lang=EN-US style='font-size:14.0pt;font-family:宋体;mso-bidi-font-weight:bold'><o:p><input id="changeItem1" style="width:98%"  maxlength="100"/></o:p></span></p>
  </td>
  <td width=125 valign="middle" style='width:93.55pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  77.95pt'>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt;font-family:宋体;
  mso-bidi-font-weight:bold'><o:p>
  <input type="text" id="appDate1" name='成立日期' onClick="WdatePicker()" style="width:98%"/>
  </o:p></span></p>
  </td>
  <td width=125 valign="middle" style='width:93.55pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  77.95pt'>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt;font-family:宋体;
  mso-bidi-font-weight:bold'><o:p><textarea id=beforeChange1 rows='3' style="width:100%; height:75pt"  ></textarea></o:p></span></p>
  </td>
  <td width=212 valign="middle" style='width:158.75pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 2.25pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;mso-border-right-alt:solid windowtext 2.25pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:77.95pt'>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt;font-family:宋体;
  mso-bidi-font-weight:bold'><o:p><textarea id=afterChange1 rows='3'style="width:100%; height:75pt"></textarea></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:2;height:77.95pt'>
  <td width=125 valign="middle" style='width:93.55pt;border-top:none;border-left:
  solid windowtext 2.25pt;border-bottom:solid windowtext 1.0pt;border-right:
  solid windowtext 1.0pt;mso-border-top-alt:solid windowtext .75pt;mso-border-alt:
  solid windowtext .75pt;mso-border-left-alt:solid windowtext 2.25pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:77.95pt'>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt;font-family:宋体;
  mso-bidi-font-weight:bold'><o:p><input id="changeItem2" style="width:98%"  maxlength="100"/></o:p></span></p>
  </td>
  <td width=125 valign="middle" style='width:93.55pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  77.95pt'>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt;font-family:宋体;
  mso-bidi-font-weight:bold'><o:p>
   <input type="text" id="appDate2" name='成立日期' onClick="WdatePicker()" style="width:98%"/>
  </o:p></span></p>
  </td>
  <td width=125 valign="middle" style='width:93.55pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  77.95pt'>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt;font-family:宋体;
  mso-bidi-font-weight:bold'><o:p><textarea id=beforeChange2 rows='3' style="width:100%; height:75pt"></textarea></o:p></span></p>
  </td>
  <td width=212 valign="middle" style='width:158.75pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 2.25pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;mso-border-right-alt:solid windowtext 2.25pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:77.95pt'>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt;font-family:宋体;
  mso-bidi-font-weight:bold'><o:p><textarea id=afterChange2 rows='3'style="width:100%; height:75pt"></textarea></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:3;height:77.95pt'>
  <td width=125 valign="middle" style='width:93.55pt;border-top:none;border-left:
  solid windowtext 2.25pt;border-bottom:solid windowtext 1.0pt;border-right:
  solid windowtext 1.0pt;mso-border-top-alt:solid windowtext .75pt;mso-border-alt:
  solid windowtext .75pt;mso-border-left-alt:solid windowtext 2.25pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:77.95pt'>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt;font-family:宋体;
  mso-bidi-font-weight:bold'><o:p><input id="changeItem3" style="width:98%"  maxlength="100"/></o:p></span></p>
  </td>
  <td width=125 valign="middle" style='width:93.55pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  77.95pt'>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt;font-family:宋体;
  mso-bidi-font-weight:bold'><o:p>
  <input type="text" id="appDate3" name='成立日期' onClick="WdatePicker()" style="width:98%"/>
  </o:p></span></p>
  </td>
  <td width=125 valign="middle" style='width:93.55pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  77.95pt'>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt;font-family:宋体;
  mso-bidi-font-weight:bold'><o:p><textarea id=beforeChange3 rows='3' style="width:100%; height:75pt"></textarea></o:p></span></p>
  </td>
  <td width=212 valign="middle" style='width:158.75pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 2.25pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;mso-border-right-alt:solid windowtext 2.25pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:77.95pt'>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt;font-family:宋体;
  mso-bidi-font-weight:bold'><o:p><textarea id=afterChange3 rows='3'style="width:100%; height:75pt"></textarea></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:4;height:77.95pt'>
  <td width=125 valign="middle" style='width:93.55pt;border-top:none;border-left:
  solid windowtext 2.25pt;border-bottom:solid windowtext 1.0pt;border-right:
  solid windowtext 1.0pt;mso-border-top-alt:solid windowtext .75pt;mso-border-alt:
  solid windowtext .75pt;mso-border-left-alt:solid windowtext 2.25pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:77.95pt'>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt;font-family:宋体;
  mso-bidi-font-weight:bold'><o:p><input id="changeItem4" style="width:98%"  maxlength="100"/></o:p></span></p>
  </td>
  <td width=125 valign="middle" style='width:93.55pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  77.95pt'>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt;font-family:宋体;
  mso-bidi-font-weight:bold'><o:p>
  <input type="text" id="appDate4" name='成立日期' onClick="WdatePicker()" style="width:98%"/>
  </o:p></span></p>
  </td>
  <td width=125 valign="middle" style='width:93.55pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  77.95pt'>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt;font-family:宋体;
  mso-bidi-font-weight:bold'><o:p><textarea id=beforeChange4 rows='3' style="width:100%; height:75pt"></textarea></o:p></span></p>
  </td>
  <td width=212 valign="middle" style='width:158.75pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 2.25pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;mso-border-right-alt:solid windowtext 2.25pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:77.95pt'>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt;font-family:宋体;
  mso-bidi-font-weight:bold'><o:p><textarea id=afterChange4 rows='3'style="width:100%; height:75pt"></textarea></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:5;height:77.95pt'>
  <td width=125 valign="middle" style='width:93.55pt;border-top:none;border-left:
  solid windowtext 2.25pt;border-bottom:solid windowtext 1.0pt;border-right:
  solid windowtext 1.0pt;mso-border-top-alt:solid windowtext .75pt;mso-border-alt:
  solid windowtext .75pt;mso-border-left-alt:solid windowtext 2.25pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:77.95pt'>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt;font-family:宋体;
  mso-bidi-font-weight:bold'><o:p><input id="changeItem5" style="width:98%"  maxlength="100"/></o:p></span></p>
  </td>
  <td width=125 valign="middle" style='width:93.55pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  77.95pt'>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt;font-family:宋体;
  mso-bidi-font-weight:bold'><o:p>
  <input type="text" id="appDate5" name='成立日期' onClick="WdatePicker()" style="width:98%"/>
  </o:p></span></p>
  </td>
  <td width=125 valign="middle" style='width:93.55pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  77.95pt'>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt;font-family:宋体;
  mso-bidi-font-weight:bold'><o:p><textarea id=beforeChange5 rows='3' style="width:100%; height:75pt"></textarea></o:p></span></p>
  </td>
  <td width=212 valign="middle" style='width:158.75pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 2.25pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;mso-border-right-alt:solid windowtext 2.25pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:77.95pt'>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt;font-family:宋体;
  mso-bidi-font-weight:bold'><o:p><textarea id=afterChange5 rows='3'style="width:100%; height:75pt"></textarea></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:6;height:77.95pt'>
  <td width=125 valign="middle" style='width:93.55pt;border-top:none;border-left:
  solid windowtext 2.25pt;border-bottom:solid windowtext 1.0pt;border-right:
  solid windowtext 1.0pt;mso-border-top-alt:solid windowtext .75pt;mso-border-alt:
  solid windowtext .75pt;mso-border-left-alt:solid windowtext 2.25pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:77.95pt'>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt;font-family:宋体;
  mso-bidi-font-weight:bold'><o:p><input id="changeItem6" style="width:98%"  maxlength="100"/></o:p></span></p>
  </td>
  <td width=125 valign="middle" style='width:93.55pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  77.95pt'>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt;font-family:宋体;
  mso-bidi-font-weight:bold'><o:p>
  <input type="text" id="appDate6" name='成立日期' onClick="WdatePicker()" style="width:98%"/>
  </o:p></span></p>
  </td>
  <td width=125 valign="middle" style='width:93.55pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  77.95pt'>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt;font-family:宋体;
  mso-bidi-font-weight:bold'><o:p><textarea id=beforeChange6 rows='3' style="width:100%; height:75pt"></textarea></o:p></span></p>
  </td>
  <td width=212 valign="middle" style='width:158.75pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 2.25pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;mso-border-right-alt:solid windowtext 2.25pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:77.95pt'>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt;font-family:宋体;
  mso-bidi-font-weight:bold'><o:p><textarea id=afterChange6 rows='3' style="width:100%; height:75pt"></textarea></o:p></span></p>
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
  mso-bidi-font-weight:bold'><o:p><input id="changeItem7" style="width:98%"  maxlength="100"/></o:p></span></p>
  </td>
  <td width=125 valign="middle" style='width:93.55pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 2.25pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;mso-border-bottom-alt:solid windowtext 2.25pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:77.95pt'>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt;font-family:宋体;
  mso-bidi-font-weight:bold'><o:p>
  <input type="text" id="appDate7" name='成立日期' onClick="WdatePicker()" style="width:98%"/>
  </o:p></span></p>
  </td>
  <td width=125 valign="middle" style='width:93.55pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 2.25pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;mso-border-bottom-alt:solid windowtext 2.25pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:77.95pt'>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt;font-family:宋体;
  mso-bidi-font-weight:bold'><o:p><textarea id=beforeChange7 rows='3' style="width:100%; height:75pt"></textarea></o:p></span></p>
  </td>
  <td width=212 valign="middle" style='width:158.75pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 2.25pt;border-right:solid windowtext 2.25pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:77.95pt'>
  <p class=MsoNormal><span lang=EN-US style='font-size:14.0pt;font-family:宋体;
  mso-bidi-font-weight:bold'><o:p><textarea id=afterChange7 rows='3' style="width:100%; height:75pt"></textarea></o:p></span></p>
  </td>
 </tr>
</table>
</form>
</div>

<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>

</div>
</body>
</html>
