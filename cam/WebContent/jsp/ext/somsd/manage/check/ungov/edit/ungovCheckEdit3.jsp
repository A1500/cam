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
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<link href="../../css/float.css" type="text/css" rel="stylesheet" />
<script language="javascript">
var taskCode='<%=request.getParameter("taskCode")%>';
//初始化
function init(){
	somCheckDataSet.setParameter("TASK_CODE", taskCode);
	somCheckDataSet.load();
	somCheckDataSet.on('load',function (){
		if(somCheckDataSet.getCount() == 0){
			somCheckDataSet.newRecord({"taskCode":taskCode});
		}else{
			if(typeof businessOrganSelectDic !="undefined"){
				var borgName = somCheckDataSet.get('borgName');
				var records = businessOrganSelectDic.query("value",borgName);
				if(records.length>0){
					var borgCode = records.items[0].get("text");
					document.getElementById("borgName").value = borgName;
					document.getElementById("borgNameDispaly").value = borgCode;
				}
			}
		}
	});		
	
	//创建页面导航下拉框
	createUngovEditSelect();	
}
function save(){
	var somCheckRecord=somCheckDataSet.getCurrent();
	if(document.getElementById("borgName").value == ""){
		L5.Msg.alert("提示","请填写业务主管单位！");
		return "break";
	}
	somCheckRecord.set('borgName',document.getElementById("borgName").value);
	var somCheckDataSetIsValidate = somCheckDataSet.isValidate();
	if(somCheckDataSetIsValidate!=true){
		L5.Msg.alert("提示",somCheckDataSetIsValidate);
		return "break";
	}
	
	var command = new L5.Command("com.inspur.cams.sorg.check.somcheck.cmd.SomCheckCommand");
	command.setParameter("taskCode", taskCode);
	command.setParameter("somCheckRecord", somCheckRecord);
	command.execute("savePageM3");
	if (!command.error) {
		alert("保存成功！");
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
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
			<model:field name="cnName" type="string" rule="require" />
			<model:field name="residence" type="string" rule="require" />
			<model:field name="sorgPost" type="string" rule="require" />
			<model:field name="sorgPhone" type="string" rule="require" />
			<model:field name="linkmanName" type="string" rule="require" />
			<model:field name="linkmanPhone" type="string" rule="require" />
			<model:field name="linkmanMobile" type="string" rule="require" />
			<model:field name="borgName" type="string" rule="require" />
			<model:field name="legalPeople" type="string" rule="require" />
			<model:field name="regBank" type="string" rule="require" />
			<model:field name="regAccount" type="string" rule="require" />
			<model:field name="engagedNum" type="string" rule="require" />
			<model:field name="practiceNum" type="string" rule="require" />
			<model:field name="partyMemberNum" type="string" rule="require" />
			<model:field name="ifBuildParty" type="string" rule="require" />
			<model:field name="partyType" type="string" rule="require" />
			<model:field name="ifPublication" type="string" rule="require" />
			<model:field name="publication" type="string" rule="require" />
			
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
		<model:dataset id="build_type" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_PARTY_BUILD_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>		
</model:datasets>
<div id="float" >
	<input type="button" value="上一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="nextPageM('2')"/>
	<input type="button" value="下一页" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="nextPageM('4')"/>
	<input type="button" value="保存" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="save();"/>
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:320px;" onclick="backM();"/>
	<!--[if lte IE 7]><div></div><![endif]-->
	<span style="height:25px;width:80px;position:absolute;margin-left:420px;">当前页数：2</span>
</div>
<div class=WordSection1 style='layout-grid:15.6pt'>

<p class=MsoNormal align=center style='margin-bottom:7.8pt;mso-para-margin-bottom:
.5gd;text-align:center'><span style='font-size:22.0pt;mso-bidi-font-size:12.0pt;
font-family:黑体;mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:
"Times New Roman"'>基</span><span lang=EN-US style='font-size:22.0pt;mso-bidi-font-size:
12.0pt;mso-fareast-font-family:黑体'><span style='mso-spacerun:yes'>&nbsp;
</span></span><span style='font-size:22.0pt;mso-bidi-font-size:12.0pt;
font-family:黑体;mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:
"Times New Roman"'>本</span><span lang=EN-US style='font-size:22.0pt;mso-bidi-font-size:
12.0pt;mso-fareast-font-family:黑体'><span style='mso-spacerun:yes'>&nbsp;
</span></span><span style='font-size:22.0pt;mso-bidi-font-size:12.0pt;
font-family:黑体;mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:
"Times New Roman"'>事</span><span lang=EN-US style='font-size:22.0pt;mso-bidi-font-size:
12.0pt;mso-fareast-font-family:黑体'><span style='mso-spacerun:yes'>&nbsp;
</span></span><span style='font-size:22.0pt;mso-bidi-font-size:12.0pt;
font-family:黑体;mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:
"Times New Roman"'>项</span><span lang=EN-US style='font-size:22.0pt;mso-bidi-font-size:
12.0pt;mso-fareast-font-family:黑体'><o:p></o:p></span></p>

<div align=center>
<form dataset=somCheckDataSet method="post" onsubmit="return false">
<table class=MsoNormalTable border=1 cellspacing=0 cellpadding=0 width=700
 style='width:700;border-collapse:collapse;border:none;mso-border-alt:
 solid windowtext 2.25pt;mso-padding-alt:0cm 5.4pt 0cm 5.4pt;mso-border-insideh:
 .75pt solid windowtext;mso-border-insidev:.75pt solid windowtext'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes;height:46.2pt'>
  <td width=147 style='width:110.35pt;border-top:2.25pt;border-left:2.25pt;
  border-bottom:1.0pt;border-right:1.0pt;border-color:windowtext;border-style:
  solid;mso-border-top-alt:2.25pt;mso-border-left-alt:2.25pt;mso-border-bottom-alt:
  .75pt;mso-border-right-alt:.75pt;mso-border-color-alt:windowtext;mso-border-style-alt:
  solid;padding:0cm 5.4pt 0cm 5.4pt;height:46.2pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='text-fit:88.0pt;mso-text-fit-id:330011136'><b style='mso-bidi-font-weight:
  normal'><span style='font-size:14.0pt;font-family:宋体;letter-spacing:5.3pt;
  mso-font-kerning:0pt'>单位名称</span></b></span><b style='mso-bidi-font-weight:
  normal'><span lang=EN-US style='font-size:14.0pt;font-family:宋体'><o:p></o:p></span></b></p>
  </td>
  <td width=498 colspan=8 style='width:373.75pt;border-top:solid windowtext 2.25pt;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 2.25pt;
  mso-border-left-alt:solid windowtext .75pt;mso-border-top-alt:2.25pt;
  mso-border-left-alt:.75pt;mso-border-bottom-alt:.75pt;mso-border-right-alt:
  2.25pt;mso-border-color-alt:windowtext;mso-border-style-alt:solid;padding:
  0cm 5.4pt 0cm 5.4pt;height:46.2pt'>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
  style='font-size:14.0pt;font-family:宋体'><o:p><input field="cnName"name='单位名称' style="width:98%"  maxlength="100"/></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:1;height:51.8pt'>
  <td width=147 style='width:110.35pt;border-top:none;border-left:solid windowtext 2.25pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-alt:solid windowtext .75pt;
  mso-border-left-alt:solid windowtext 2.25pt;padding:0cm 5.4pt 0cm 5.4pt;
  height:51.8pt'>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'><span style='font-size:14.0pt;font-family:
  宋体'>住<span lang=EN-US style='letter-spacing:3.3pt;mso-font-kerning:0pt'><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp; </span></span><span
  style='font-size:14.0pt;font-family:宋体;letter-spacing:3.3pt;mso-font-kerning:0pt'>所</span>
  <span lang=EN-US><o:p></o:p></span></span></b></p>
  </td>
  <td width=498 colspan=8 style='width:373.75pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 2.25pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;mso-border-right-alt:solid windowtext 2.25pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:51.8pt'>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
  style='font-size:14.0pt;font-family:宋体'><o:p><input field="residence"name='住所地址' style="width:98%" maxlength="200"/></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:2;height:51.8pt'>
  <td width=147 style='width:110.35pt;border-top:none;border-left:solid windowtext 2.25pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-alt:solid windowtext .75pt;
  mso-border-left-alt:solid windowtext 2.25pt;padding:0cm 5.4pt 0cm 5.4pt;
  height:51.8pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='text-fit:88.0pt;mso-text-fit-id:330011137'><b style='mso-bidi-font-weight:
  normal'><span style='font-size:14.0pt;font-family:宋体;letter-spacing:3.15pt;
  mso-font-kerning:0pt'>电<span lang=EN-US><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp; </span></span>话</span></b></span><b
  style='mso-bidi-font-weight:normal'><span lang=EN-US style='font-size:14.0pt;
  font-family:宋体'><o:p></o:p></span></b></p>
  </td>
  <td width=245 colspan=4 style='width:183.5pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  51.8pt'>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'><span lang=EN-US style='font-size:14.0pt;
  font-family:宋体'><o:p><input field="linkmanPhone"name='联系电话' style="width:98%" maxlength="50" onKeyUp="value=value.replace(/[^\d-]/g,'');"/></o:p></span></b></p>
  </td>
  <td width=112 colspan=3 style='width:83.9pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  51.8pt'>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'><span style='font-size:14.0pt;font-family:
  宋体'>邮政编码<span lang=EN-US><o:p></o:p></span></span></b></p>
  </td>
  <td width=142 style='width:106.4pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 2.25pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;mso-border-right-alt:solid windowtext 2.25pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:51.8pt'>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'><span lang=EN-US style='font-size:14.0pt;
  font-family:宋体'><o:p><input onkeyup="value=value.replace(/[^\d]/g,'')" field="sorgPost" name='邮政编码'style="width:98%" maxlength="6"/></o:p></span></b></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:3;height:28.9pt'>
  <td width=147 rowspan=2 style='width:110.35pt;border-top:none;border-left:
  solid windowtext 2.25pt;border-bottom:solid windowtext 1.0pt;border-right:
  solid windowtext 1.0pt;mso-border-top-alt:solid windowtext .75pt;mso-border-alt:
  solid windowtext .75pt;mso-border-left-alt:solid windowtext 2.25pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:28.9pt'>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'><span style='font-size:14.0pt;font-family:
  宋体;mso-font-kerning:0pt'>联系人<span lang=EN-US><o:p></o:p></span></span></b></p>
  </td>
  <td width=154 colspan=2 rowspan=2 style='width:115.35pt;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  28.9pt'>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'><span lang=EN-US style='font-size:14.0pt;
  font-family:宋体'><o:p><input field="linkmanName"name='住所地址' style="width:98%" maxlength="50"/></o:p></span></b></p>
  </td>
  <td width=91 colspan=2 style='width:68.15pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  28.9pt'>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'><span style='font-size:14.0pt;font-family:
  宋体'>电话<span lang=EN-US><o:p></o:p></span></span></b></p>
  </td>
  <td width=254 colspan=4 style='width:190.25pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 2.25pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;mso-border-right-alt:solid windowtext 2.25pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:28.9pt'>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'><span lang=EN-US style='font-size:14.0pt;
  font-family:宋体'><o:p><input field="sorgPhone"name='联系电话' style="width:98%" maxlength="50" onKeyUp="value=value.replace(/[^\d-]/g,'');"/></o:p></span></b></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:4;height:28.9pt'>
  <td width=91 colspan=2 style='width:68.15pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  28.9pt'>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'><span style='font-size:14.0pt;font-family:
  宋体'>手机<span lang=EN-US><o:p></o:p></span></span></b></p>
  </td>
  <td width=254 colspan=4 style='width:190.25pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 2.25pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;mso-border-right-alt:solid windowtext 2.25pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:28.9pt'>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'><span lang=EN-US style='font-size:14.0pt;
  font-family:宋体'><o:p><input field="linkmanMobile"name='手机' style="width:98%"  maxlength="50" onKeyUp="value=value.replace(/[^\d-]/g,'');"/></o:p></span></b></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:5;height:51.8pt'>
  <td width=147 style='width:110.35pt;border-top:none;border-left:solid windowtext 2.25pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-alt:solid windowtext .75pt;
  mso-border-left-alt:solid windowtext 2.25pt;padding:0cm 5.4pt 0cm 5.4pt;
  height:51.8pt'>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'><span style='font-size:14.0pt;font-family:
  宋体'>业务主管单位<span lang=EN-US><o:p></o:p></span></span></b></p>
  </td>
  <td width=498 colspan=8 style='width:373.75pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 2.25pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;mso-border-right-alt:solid windowtext 2.25pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:51.8pt'>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
  style='font-size:14.0pt;font-family:宋体'><o:p><!--<select field="borgName" style="width:98%" ><option dataset="businessOrganSelect"></option></select>
  -->
  	<input type="text" id="borgNameDispaly" name="borgNameDispaly"  title="业务主管单位" style="width:85%"  onkeyup="findDiv(this,'borgName','popup','','businessOrganAuto','BORG_NAME@like','borgCode','borgName','-20')" onblur="clearDiv()" onchange="clearBorg(this)"/><img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>" style="cursor:hand" onclick="showBorgWin()"/>
	<div id="popup" style="width:300px; height: 150px; display: none;position: absolute;background-color: #FFFFFF;" >  
					<ul></ul> 
	</div>
	<input type="hidden" id="borgName" name="borgName" field="borgName" title="业务主管单位代码"/></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:6;height:45.85pt'>
  <td width=147 style='width:110.35pt;border-top:none;border-left:solid windowtext 2.25pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-alt:solid windowtext .75pt;
  mso-border-left-alt:solid windowtext 2.25pt;padding:0cm 5.4pt 0cm 5.4pt;
  height:45.85pt'>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'><span style='font-size:14.0pt;font-family:
  宋体'>法定代表人<span lang=EN-US><o:p></o:p></span></span></b></p>
  </td>
  <td width=498 colspan=8 valign=top style='width:373.75pt;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 2.25pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;mso-border-right-alt:solid windowtext 2.25pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:45.85pt'>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
  style='font-size:14.0pt;font-family:宋体'><o:p><input field="legalPeople" name='法定代表人'style="width:98%" maxlength="100"/></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:7;height:51.8pt'>
  <td width=147 style='width:110.35pt;border-top:none;border-left:solid windowtext 2.25pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-alt:solid windowtext .75pt;
  mso-border-left-alt:solid windowtext 2.25pt;padding:0cm 5.4pt 0cm 5.4pt;
  height:51.8pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='text-fit:88.0pt;mso-text-fit-id:330011138'><b style='mso-bidi-font-weight:
  normal'><span style='font-size:14.0pt;font-family:宋体;letter-spacing:5.3pt;
  mso-font-kerning:0pt'>开户银行</span></b></span><b style='mso-bidi-font-weight:
  normal'><span lang=EN-US style='font-size:14.0pt;font-family:宋体'><o:p></o:p></span></b></p>
  </td>
  <td width=498 colspan=8 valign=top style='width:373.75pt;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 2.25pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;mso-border-right-alt:solid windowtext 2.25pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:51.8pt'>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
  style='font-size:14.0pt;font-family:宋体'><o:p><input title="开户银行" field="regBank" style="width:98%"  maxlength="50"/></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:8;height:51.8pt'>
  <td width=147 style='width:110.35pt;border-top:none;border-left:solid windowtext 2.25pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-alt:solid windowtext .75pt;
  mso-border-left-alt:solid windowtext 2.25pt;padding:0cm 5.4pt 0cm 5.4pt;
  height:51.8pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='text-fit:88.0pt;mso-text-fit-id:330011139'><b style='mso-bidi-font-weight:
  normal'><span style='font-size:14.0pt;font-family:宋体;letter-spacing:5.3pt;
  mso-font-kerning:0pt'>开户帐号</span></b></span><b style='mso-bidi-font-weight:
  normal'><span lang=EN-US style='font-size:14.0pt;font-family:宋体'><o:p></o:p></span></b></p>
  </td>
  <td width=498 colspan=8 valign=top style='width:373.75pt;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 2.25pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;mso-border-right-alt:solid windowtext 2.25pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:51.8pt'>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
  style='font-size:14.0pt;font-family:宋体'><o:p><input title="开户帐号" field="regAccount" style="width:98%"  maxlength="50"/></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:9;page-break-inside:avoid;height:51.8pt'>
  <td width=147 style='width:110.35pt;border-top:none;border-left:solid windowtext 2.25pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-alt:solid windowtext .75pt;
  mso-border-left-alt:solid windowtext 2.25pt;padding:0cm 5.4pt 0cm 5.4pt;
  height:51.8pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='text-fit:88.0pt;mso-text-fit-id:330011140'><b style='mso-bidi-font-weight:
  normal'><span style='font-size:14.0pt;font-family:宋体;letter-spacing:2.2pt;
  mso-font-kerning:0pt'>从业人员数</span></b></span><b style='mso-bidi-font-weight:
  normal'><span lang=EN-US style='font-size:14.0pt;font-family:宋体'><o:p></o:p></span></b></p>
  </td>
  <td width=117 style='width:87.6pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  51.8pt'>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
  style='font-size:14.0pt;font-family:宋体'><o:p><input title="从业人员数" field="engagedNum" style="width:98%"  maxlength="50"/></o:p></span></p>
  </td>
  <td width=189 colspan=4 style='width:141.8pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  51.8pt'>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'><span style='font-size:14.0pt;font-family:
  宋体'>执业人员数<span lang=EN-US><o:p></o:p></span></span></b></p>
  </td>
  <td width=192 colspan=3 style='width:144.35pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 2.25pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;mso-border-right-alt:solid windowtext 2.25pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:51.8pt'>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
  style='font-size:14.0pt;font-family:宋体'><o:p><input title="执业人员数" field="practiceNum" style="width:98%"  maxlength="50"/></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:10;page-break-inside:avoid;height:51.8pt'>
  <td width=147 style='width:110.35pt;border-top:none;border-left:solid windowtext 2.25pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-alt:solid windowtext .75pt;
  mso-border-left-alt:solid windowtext 2.25pt;padding:0cm 5.4pt 0cm 5.4pt;
  height:51.8pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='text-fit:88.0pt;mso-text-fit-id:330011141'><b style='mso-bidi-font-weight:
  normal'><span style='font-size:14.0pt;font-family:宋体;letter-spacing:.9pt;
  mso-font-kerning:0pt'>党 员 人 数</span></b></span><b style='mso-bidi-font-weight:
  normal'><span lang=EN-US style='font-size:14.0pt;font-family:宋体'><o:p></o:p></span></b></p>
  </td>
  <td width=117 style='width:87.6pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  51.8pt'>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
  style='font-size:14.0pt;font-family:宋体'><o:p><input title="党员人数" field="partyMemberNum" style="width:98%"  maxlength="50"/></o:p></span></p>
  </td>
  <td width=189 colspan=4 style='width:141.8pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;padding:0cm 5.4pt 0cm 5.4pt;height:
  51.8pt'>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'><span style='font-size:14.0pt;font-family:
  宋体'>是否建立党组织<span lang=EN-US><o:p> </o:p></span></span></b></p>
  </td>
  <td width=192 colspan=3 style='width:144.35pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 2.25pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;mso-border-right-alt:solid windowtext 2.25pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:51.8pt'>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'><span style='font-size:14.0pt;font-family:
  宋体'><o:p><select field="ifBuildParty" name='是否建立党组织' title="是否建立党组织" style="width:98%">
	<option  dataset="comm_yesorno" />
</select></o:p></span></span></b></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:11;height:51.8pt'>
  <td width=147 style='width:110.35pt;border-top:none;border-left:solid windowtext 2.25pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-alt:solid windowtext .75pt;
  mso-border-left-alt:solid windowtext 2.25pt;padding:0cm 5.4pt 0cm 5.4pt;
  height:51.8pt'>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'><span style='font-size:14.0pt;font-family:
  宋体'>党组织建立形式<span lang=EN-US><o:p></o:p></span></span></b></p>
  </td>
  <td width=498 colspan=8 style='width:373.75pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 2.25pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;mso-border-right-alt:solid windowtext 2.25pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:51.8pt'>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'><span lang=EN-US style='font-size:14.0pt;
  font-family:宋体'><o:p><select field="partyType" title="党组织建立形式" name='党组织建立形式' style="width:98%">
	<option  dataset="build_type" />
</select></o:p></span></b></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:12;mso-yfti-lastrow:yes;height:51.8pt'>
  <td width=147 style='width:110.35pt;border-top:none;border-left:solid windowtext 2.25pt;
  border-bottom:solid windowtext 2.25pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-top-alt:.75pt;
  mso-border-left-alt:2.25pt;mso-border-bottom-alt:2.25pt;mso-border-right-alt:
  .75pt;mso-border-color-alt:windowtext;mso-border-style-alt:solid;padding:
  0cm 5.4pt 0cm 5.4pt;height:51.8pt'>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'><span style='font-size:14.0pt;font-family:
  宋体'>公开发行报刑<span lang=EN-US><o:p></o:p></span></span></b></p>
  </td>
  <td width=170 colspan=3 style='width:136.75pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 2.25pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;mso-border-bottom-alt:solid windowtext 2.25pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:51.8pt'>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
  style='font-size:14.0pt;font-family:宋体'><o:p><input title="公开发行报刑" field="ifPublication" style="width:98%"  maxlength="100"/></o:p></span></p>
  </td>
  <td width=145 colspan=3 style='width:110.35pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 2.25pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;mso-border-bottom-alt:solid windowtext 2.25pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:51.8pt'>
  <p class=MsoNormal align=center style='text-align:center'><b
  style='mso-bidi-font-weight:normal'><span style='font-size:14.0pt;font-family:
  宋体'>内部发行报刊<span lang=EN-US><o:p></o:p></span></span></b></p>
  </td>
  <td width=170 colspan=3 style='width:136.75pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 2.25pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .75pt;mso-border-left-alt:solid windowtext .75pt;
  mso-border-alt:solid windowtext .75pt;mso-border-bottom-alt:solid windowtext 2.25pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:51.8pt'>
  <p class=MsoNormal align=center style='text-align:center'><span lang=EN-US
  style='font-size:14.0pt;font-family:宋体'><o:p><input title="内部发行报刊" field="publication" style="width:98%"  maxlength="50"/></o:p></span></p>
  </td>
 </tr>
 <![if !supportMisalignedColumns]>
 <tr height=0>
  <td width=147 style='border:none'></td>
  <td width=117 style='border:none'></td>
  <td width=37 style='border:none'></td>
  <td width=42 style='border:none'></td>
  <td width=49 style='border:none'></td>
  <td width=61 style='border:none'></td>
  <td width=21 style='border:none'></td>
  <td width=29 style='border:none'></td>
  <td width=142 style='border:none'></td>
 </tr>
 <![endif]>
</table>
</form>
</div>

<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>

</div>

<jsp:include page="../../../borg/borgSelectWindow.jsp" flush="true"/>
</body>
</html>
