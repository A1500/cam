<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>

<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<title>社 会 团 体</title>
<%
	String taskCode = (String) request.getParameter("taskCode");
%>
<next:ScriptManager />
<script type="text/javascript" src="../../js/float.js"></script>
<link href="../../css/float.css" type="text/css" rel="stylesheet" />
<script language="javascript">
	var taskCode='<%=taskCode%>';
	//初始化
	function init(){
		createGroupDetailSelect();
		somCheckEventDataSet.setParameter("TASK_CODE@=", taskCode);
		somCheckEventDataSet.load();
		somCheckEventDataSet.on("load",function(ds){
			if(ds.getCount()<1){
				somCheckEventDataSet.newRecord({"taskCode":taskCode});
			}else{
				for(i=1;i<=ds.getCount();i++){
					var sequence = ds.getAt(i-1).get("sequence");
					document.getElementById("eventName"+sequence).value=ds.getAt(i-1).get("eventName");
					document.getElementById("eventType"+sequence).value=ds.getAt(i-1).get("eventType");
					document.getElementById("eventDate"+sequence).value=ds.getAt(i-1).get("eventDate");
					document.getElementById("eventPlace"+sequence).value=ds.getAt(i-1).get("eventPlace");
					document.getElementById("approveOrgan"+sequence).value=ds.getAt(i-1).get("approveOrgan");
					document.getElementById("chargeStatus"+sequence).value=ds.getAt(i-1).get("chargeStatus");
				}
			}
		});
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
	<!-- 本年度举办研讨、展览、培训、评比达标表彰等活动的情况 -->
	<model:dataset id="somCheckEventDataSet" cmd="com.inspur.cams.sorg.check.checkevent.cmd.SomCheckEventQueryCommand" method="queryNoPage" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.checkevent.data.SomCheckEvent"></model:record>
	</model:dataset>
	<!-- 本年度举办活动类型 -->
	<model:dataset id="eventTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_EVENT_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>

<!--页面按钮-->
<div id="float" class="noprint">
	<input type="button" value="上一页" style="height: 25px; width: 80px; position: absolute; margin-left: 20px;" onclick="lastPage1('13');"/>
	<input type="button" value="下一页" style="height: 25px; width: 80px; position: absolute; margin-left: 120px;" onclick="nextPage1('15');"/>
	<input type="button" value="返回" style="height: 25px; width: 80px; position: absolute; margin-left: 220px;" onclick="back();" />
	<input type="button" value="打印" style="height: 25px; width: 80px; position: absolute; margin-left: 320px;" onclick="docPrint();"/>
</div>
<div align=center>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal align=left
	style='text-align: center; tab-stops: 248.15pt'><b
	style='mso-bidi-font-weight: normal'><span
	style='font-size: 14.0pt; font-family: 宋体'>（二）本年度举办研讨、展览、培训、评比达标表彰等活动的情况<span
	lang=EN-US><o:p></o:p></span></span></b></p>

<form method="post" dataset=somCheckEventDataSet onsubmit="return false">
	<table cellspacing=0 cellpadding=0 width="800">
		<tr style='mso-yfti-irow: 0; mso-yfti-firstrow: yes; height: 16.35pt'>
			<td width="5%"
				style='width: 5.0%; border-top: 1.5pt; border-left: 1.5pt; border-bottom: 1.0pt; border-right: 1.0pt; border-color: windowtext; border-style: solid; mso-border-top-alt: 1.5pt; mso-border-left-alt: 1.5pt; mso-border-bottom-alt: .5pt; mso-border-right-alt: .5pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid; padding: 0cm 5.4pt 0cm 5.4pt; height: 16.35pt'>
			<p class=MsoNormal style='line-height: 200%; tab-stops: 248.15pt'><span
				style='font-size: 12.0pt; line-height: 200%; font-family: 宋体'>序号<span
				lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="21%"
				style='width: 21.6%; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 16.35pt'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; line-height: 200%; tab-stops: 248.15pt'><span
				style='font-size: 12.0pt; line-height: 200%; font-family: 宋体'>活动名称<span
				lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="11%"
				style='width: 11.76%; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 16.35pt'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; line-height: 200%; tab-stops: 248.15pt'><span
				style='font-size: 12.0pt; line-height: 200%; font-family: 宋体'>类型<span
				lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="11%"
				style='width: 11.78%; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 16.35pt'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; line-height: 200%; tab-stops: 248.15pt'><span
				style='font-size: 12.0pt; line-height: 200%; font-family: 宋体'>时间<span
				lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="11%"
				style='width: 11.78%; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 16.35pt'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; line-height: 200%; tab-stops: 248.15pt'><span
				style='font-size: 12.0pt; line-height: 200%; font-family: 宋体'>地点<span
				lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="17%"
				style='width: 17.66%; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 16.35pt'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; line-height: 200%; tab-stops: 248.15pt'><span
				style='font-size: 12.0pt; line-height: 200%; font-family: 宋体'>批准单位<span
				lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="16%"
				style='width: 16.42%; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: 1.5pt; mso-border-left-alt: .5pt; mso-border-bottom-alt: .5pt; mso-border-right-alt: 1.5pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid; padding: 0cm 5.4pt 0cm 5.4pt; height: 16.35pt'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; line-height: 200%; tab-stops: 248.15pt'><span
				style='font-size: 12.0pt; line-height: 200%; font-family: 宋体'>收费情况<span
				lang=EN-US><o:p></o:p></span></span></p>
			</td>
		</tr>
		<tr style='mso-yfti-irow: 1; height: 14.8pt'>
			<td 
				style=' border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 0pt 0cm 0pt; height: 14.8pt'>
			<p class=MsoNormal
				style='margin-left: 26.4pt; text-indent: -21.0pt; line-height: 30.0pt; mso-line-height-rule: exactly; mso-list: l0 level1 lfo12; tab-stops: list 26.4pt left 248.15pt'><![if !supportLists]><span
				lang=EN-US
				style='mso-bidi-font-size: 10.5pt; font-family: 宋体; mso-bidi-font-family: 宋体'><span
				style='mso-list: Ignore'>1.<span
				style='font: 7.0pt "Times New Roman"'>&nbsp;&nbsp; </span></span></span><![endif]><span
				lang=EN-US style='mso-bidi-font-size: 10.5pt; font-family: 宋体'><o:p>&nbsp;</o:p></span></p>
			</td>
			<td width="21%" style='width: 21.6%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 14.8pt'>
			<p class=MsoNormal align=center ><span> 
				<textarea name="活动名称" id="eventName1" style="width: 177px;height: 38px"readonly></textarea></span></p>
			</td>
			<td width="11%"
				style='width: 11.76%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 14.8pt'>
			<p class=MsoNormal align=center ><span> 
				<select name='类型' disabled id="eventType1" style="width:98%;" />
					<option dataset="eventTypeSelect"></option>
				</select></span></p>
			</td>
			<td width="11%"
				style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 14.8pt'>
			<p class=MsoNormal align=center><span> 
				<textarea type="text" name='时间' style="width: 89px;" rows='2' id="eventDate1" readonly></textarea></span></p>
			</td>
			<td width="11%"
				style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 14.8pt'>
			<p class=MsoNormal align=center><span> 
				<textarea name="地点" id="eventPlace1" style="width: 89px;height: 38px" readonly></textarea></span></p>
			</td>
			<td width="17%"
				style='width: 17.66%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 14.8pt'>
			<p class=MsoNormal align=center><span> 
				<textarea name="批准单位" id="approveOrgan1" style="width: 144px;height: 38px" readonly></textarea></span></p>
			</td>
			<td width="16%"
				style='width: 16.42%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 0pt 0cm 0pt; height: 14.8pt'>
			<p class=MsoNormal align=center><span> 
				<textarea name="收费情况" id="chargeStatus1" style="width: 135px;height: 38px" readonly></textarea></span></p>
			</td>
		</tr>
		<tr style='mso-yfti-irow: 2; height: 31.2pt'>
			<td 
				style=' border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal
				style='margin-left: 26.4pt; text-indent: -21.0pt; mso-list: l0 level1 lfo12; tab-stops: list 26.4pt left 248.15pt'><![if !supportLists]><span
				lang=EN-US
				style='mso-bidi-font-size: 10.5pt; font-family: 宋体; mso-bidi-font-family: 宋体'><span
				style='mso-list: Ignore'>2.<span
				style='font: 7.0pt "Times New Roman"'>&nbsp;&nbsp; </span></span></span><![endif]><span
				lang=EN-US style='mso-bidi-font-size: 10.5pt; font-family: 宋体'><o:p>&nbsp;</o:p></span></p>
			</td>
			<td width="21%"
				style='width: 21.6%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center><span> 
				<textarea name="活动名称" id="eventName2" style="width: 177px;height: 38px"readonly></textarea></span></p>
			</td>
			<td width="11%"
				style='width: 11.76%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center><span> 
				<select name='类型' disabled id="eventType2" style="width:98%;" />
					<option dataset="eventTypeSelect"></option>
				</select></span></p>
			</td>
			<td width="11%"
				style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center><span> 
				<textarea type="text" name='时间' style="width: 89px;" rows='2' id="eventDate2" readonly></textarea></span></p>
			</td>
			<td width="11%"
				style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center><span> 
				<textarea name="地点" id="eventPlace2" style="width: 89px;height: 38px" readonly></textarea></span></p>
			</td>
			<td width="17%"
				style='width: 17.66%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center><span> 
				<textarea name="批准单位" id="approveOrgan2" style="width: 144px;height: 38px"readonly></textarea></span></p>
			</td>
			<td width="16%"
				style='width: 16.42%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center><span> 
				<textarea name="收费情况" id="chargeStatus2" style="width: 135px;height: 38px" readonly></textarea></span></p>
			</td>
		</tr>
		<tr style='mso-yfti-irow: 3; height: 31.2pt'>
			<td 
				style=' border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal
				style='margin-left: 26.4pt; text-indent: -21.0pt; mso-list: l0 level1 lfo12; tab-stops: list 26.4pt left 248.15pt'><![if !supportLists]><span
				lang=EN-US
				style='mso-bidi-font-size: 10.5pt; font-family: 宋体; mso-bidi-font-family: 宋体'><span
				style='mso-list: Ignore'>3.<span
				style='font: 7.0pt "Times New Roman"'>&nbsp;&nbsp; </span></span></span><![endif]><span
				lang=EN-US style='mso-bidi-font-size: 10.5pt; font-family: 宋体'><o:p>&nbsp;</o:p></span></p>
			</td>
			<td width="21%"
				style='width: 21.6%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center><span> 
				<textarea name="活动名称" id="eventName3" style="width: 177px;height: 38px" readonly></textarea></span></p>
			</td>
			<td width="11%"
				style='width: 11.76%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center><span> 
				<select name='类型' disabled id="eventType3" style="width:98%;" />
					<option dataset="eventTypeSelect"></option>
				</select></span></p>
			</td>
			<td width="11%"
				style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center><span> 
				<textarea type="text" name='时间' style="width: 89px;" rows='2' id="eventDate3" readonly></textarea></span></p>
			</td>
			<td width="11%"
				style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center><span> 
				<textarea name="地点" id="eventPlace3" style="width: 89px;height: 38px"readonly></textarea></span></p>
			</td>
			<td width="17%"
				style='width: 17.66%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center><span> 
				<textarea name="批准单位" id="approveOrgan3" style="width: 144px;height: 38px" readonly></textarea></span></p>
			</td>
			<td width="16%"
				style='width: 16.42%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center><span> 
				<textarea name="收费情况" id="chargeStatus3" style="width: 135px;height: 38px" readonly></textarea></span></p>
			</td>
		</tr>
		<tr style='mso-yfti-irow: 4; height: 31.2pt'>
			<td 
				style=' border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal
				style='margin-left: 26.4pt; text-indent: -21.0pt; mso-list: l0 level1 lfo12; tab-stops: list 26.4pt left 248.15pt'><![if !supportLists]><span
				lang=EN-US
				style='mso-bidi-font-size: 10.5pt; font-family: 宋体; mso-bidi-font-family: 宋体'><span
				style='mso-list: Ignore'>4.<span
				style='font: 7.0pt "Times New Roman"'>&nbsp;&nbsp; </span></span></span><![endif]><span
				lang=EN-US style='mso-bidi-font-size: 10.5pt; font-family: 宋体'><o:p>&nbsp;</o:p></span></p>
			</td>
			<td width="21%"
				style='width: 21.6%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center><span> 
				<textarea name="活动名称" id="eventName4" style="width: 177px;height: 38px" readonly></textarea></span></p>
			</td>
			<td width="11%"
				style='width: 11.76%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center><span> 
				<select name='类型' disabled id="eventType4" style="width:98%;" />
					<option dataset="eventTypeSelect"></option>
				</select></span></p>
			</td>
			<td width="11%"
				style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center><span> 
				<textarea type="text" name='时间' style="width: 89px;" rows='2' id="eventDate4" readonly></textarea></span></p>
			</td>
			<td width="11%"
				style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center><span> 
				<textarea name="地点" id="eventPlace4" style="width: 89px;height: 38px" readonly></textarea></span></p>
			</td>
			<td width="17%"
				style='width: 17.66%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center><span> 
				<textarea name="批准单位" id="approveOrgan4" style="width: 144px;height: 38px" readonly></textarea></span></p>
			</td>
			<td width="16%"
				style='width: 16.42%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center><span> 
				<textarea name="收费情况" id="chargeStatus4" style="width: 135px;height: 38px" readonly></textarea></span></p>
			</td>
		</tr>
		<tr style='mso-yfti-irow: 5; height: 31.2pt'>
			<td 
				style=' border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal
				style='margin-left: 26.4pt; text-indent: -21.0pt; mso-list: l0 level1 lfo12; tab-stops: list 26.4pt left 248.15pt'><![if !supportLists]><span
				lang=EN-US
				style='mso-bidi-font-size: 10.5pt; font-family: 宋体; mso-bidi-font-family: 宋体'><span
				style='mso-list: Ignore'>5.<span
				style='font: 7.0pt "Times New Roman"'>&nbsp;&nbsp; </span></span></span><![endif]><span
				lang=EN-US style='mso-bidi-font-size: 10.5pt; font-family: 宋体'><o:p>&nbsp;</o:p></span></p>
			</td>
			<td width="21%"
				style='width: 21.6%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center><span> 
				<textarea name="活动名称" id="eventName5" style="width: 177px;height: 38px" readonly></textarea></span></p>
			</td>
			<td width="11%"
				style='width: 11.76%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center><span> 
				<select name='类型' disabled id="eventType5" style="width:98%;" />
					<option dataset="eventTypeSelect"></option>
				</select></span></p>
			</td>
			<td width="11%"
				style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center><span> 
				<textarea type="text" name='时间' style="width: 89px;" rows='2' id="eventDate5" readonly></textarea></span></p>
			</td>
			<td width="11%"
				style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center><span> 
				<textarea name="地点" id="eventPlace5" style="width: 89px;height: 38px" readonly></textarea></span></p>
			</td>
			<td width="17%"
				style='width: 17.66%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center><span> 
				<textarea name="批准单位" id="approveOrgan5" style="width: 144px;height: 38px"readonly></textarea></span></p>
			</td>
			<td width="16%"
				style='width: 16.42%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center><span> 
				<textarea name="收费情况" id="chargeStatus5" style="width: 135px;height: 38px"readonly></textarea></span></p>
			</td>
		</tr>
		<tr style='mso-yfti-irow: 6; height: 31.2pt'>
			<td 
				style=' border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal
				style='margin-left: 26.4pt; text-indent: -21.0pt; mso-list: l0 level1 lfo12; tab-stops: list 26.4pt left 248.15pt'><![if !supportLists]><span
				lang=EN-US
				style='mso-bidi-font-size: 10.5pt; font-family: 宋体; mso-bidi-font-family: 宋体'><span
				style='mso-list: Ignore'>6.<span
				style='font: 7.0pt "Times New Roman"'>&nbsp;&nbsp; </span></span></span><![endif]><span
				lang=EN-US style='mso-bidi-font-size: 10.5pt; font-family: 宋体'><o:p>&nbsp;</o:p></span></p>
			</td>
			<td width="21%"
				style='width: 21.6%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center><span> 
				<textarea name="活动名称" id="eventName6" style="width: 177px;height: 38px" readonly></textarea></span></p>
			</td>
			<td width="11%"
				style='width: 11.76%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center><span> 
				<select name='类型' disabled id="eventType6" style="width:98%;" />
					<option dataset="eventTypeSelect"></option>
				</select></span></p>
			</td>
			<td width="11%"
				style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center><span> 
				<textarea type="text" name='时间' style="width: 89px;" rows='2' id="eventDate6" readonly></textarea></span></p>
			</td>
			<td width="11%"
				style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center><span> 
				<textarea name="地点" id="eventPlace6" style="width: 89px;height: 38px" readonly></textarea></span></p>
			</td>
			<td width="17%"
				style='width: 17.66%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center><span> 
				<textarea name="批准单位" id="approveOrgan6" style="width: 144px;height: 38px" readonly></textarea></span></p>
			</td>
			<td width="16%"
				style='width: 16.42%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center><span> 
				<textarea name="收费情况" id="chargeStatus6" style="width: 135px;height: 38px"readonly></textarea></span></p>
			</td>
		</tr>
		<tr style='mso-yfti-irow: 7; height: 31.2pt'>
			<td 
				style=' border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal
				style='margin-left: 26.4pt; text-indent: -21.0pt; mso-list: l0 level1 lfo12; tab-stops: list 26.4pt left 248.15pt'><![if !supportLists]><span
				lang=EN-US
				style='mso-bidi-font-size: 10.5pt; font-family: 宋体; mso-bidi-font-family: 宋体'><span
				style='mso-list: Ignore'>7.<span
				style='font: 7.0pt "Times New Roman"'>&nbsp;&nbsp; </span></span></span><![endif]><span
				lang=EN-US style='mso-bidi-font-size: 10.5pt; font-family: 宋体'><o:p>&nbsp;</o:p></span></p>
			</td>
			<td width="21%"
				style='width: 21.6%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center><span> 
				<textarea name="活动名称" id="eventName7" style="width: 177px;height: 38px" readonly></textarea></span></p>
			</td>
			<td width="11%"
				style='width: 11.76%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center><span> 
				<select name='类型' disabled id="eventType7" style="width:98%;" />
					<option dataset="eventTypeSelect"></option>
				</select></span></p>
			</td>
			<td width="11%"
				style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center><span> 
				<textarea type="text" name='时间' style="width: 89px;" rows='2' id="eventDate7" readonly></textarea></span></p>
			</td>
			<td width="11%"
				style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center><span> 
				<textarea name="地点" id="eventPlace7" style="width: 89px;height: 38px" readonly></textarea></span></p>
			</td>
			<td width="17%"
				style='width: 17.66%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center><span> 
				<textarea name="批准单位" id="approveOrgan7" style="width: 144px;height: 38px" readonly></textarea></span></p>
			</td>
			<td width="16%"
				style='width: 16.42%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center><span> 
				<textarea name="收费情况" id="chargeStatus7" style="width: 135px;height: 38px" readonly></textarea></span></p>
			</td>
		</tr>
		<tr style='mso-yfti-irow: 8; height: 31.2pt'>
			<td 
				style=' border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal
				style='margin-left: 26.4pt; text-indent: -21.0pt; mso-list: l0 level1 lfo12; tab-stops: list 26.4pt left 248.15pt'><![if !supportLists]><span
				lang=EN-US
				style='mso-bidi-font-size: 10.5pt; font-family: 宋体; mso-bidi-font-family: 宋体'><span
				style='mso-list: Ignore'>8.<span
				style='font: 7.0pt "Times New Roman"'>&nbsp;&nbsp; </span></span></span><![endif]><span
				lang=EN-US style='mso-bidi-font-size: 10.5pt; font-family: 宋体'><o:p>&nbsp;</o:p></span></p>
			</td>
			<td width="21%"
				style='width: 21.6%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center><span> 
				<textarea name="活动名称" id="eventName8" style="width: 177px;height: 38px" readonly></textarea></span></p>
			</td>
			<td width="11%"
				style='width: 11.76%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center><span> 
				<select name='类型' disabled id="eventType8" style="width:98%;" />
					<option dataset="eventTypeSelect"></option>
				</select></span></p>
			</td>
			<td width="11%"
				style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center><span> 
				<textarea type="text" name='时间' style="width: 89px;" rows='2' id="eventDate8" readonly></textarea></span></p>
			</td>
			<td width="11%"
				style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center
				><span> 
				<textarea name="地点" id="eventPlace8" style="width: 89px;height: 38px" readonly></textarea></span></p>
			</td>
			<td width="17%"
				style='width: 17.66%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center
				><span> 
				<textarea name="批准单位" id="approveOrgan8" style="width: 144px;height: 38px" readonly></textarea></span></p>
			</td>
			<td width="16%"
				style='width: 16.42%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center
				><span> 
				<textarea name="收费情况" id="chargeStatus8" style="width: 135px;height: 38px" readonly></textarea></span></p>
			</td>
		</tr>
		<tr style='mso-yfti-irow: 9; height: 31.2pt'>
			<td 
				style=' border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal
				style='margin-left: 26.4pt; text-indent: -21.0pt; mso-list: l0 level1 lfo12; tab-stops: list 26.4pt left 248.15pt'><![if !supportLists]><span
				lang=EN-US
				style='mso-bidi-font-size: 10.5pt; font-family: 宋体; mso-bidi-font-family: 宋体'><span
				style='mso-list: Ignore'>9.<span
				style='font: 7.0pt "Times New Roman"'>&nbsp;&nbsp; </span></span></span><![endif]><span
				lang=EN-US style='mso-bidi-font-size: 10.5pt; font-family: 宋体'><o:p>&nbsp;</o:p></span></p>
			</td>
			<td width="21%"
				style='width: 21.6%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center
				><span> 
				<textarea name="活动名称" id="eventName9" style="width: 177px;height: 38px" readonly></textarea></span></p>
			</td>
			<td width="11%"
				style='width: 11.76%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center
				><span> 
				<select name='类型' disabled id="eventType9" style="width:98%;" />
					<option dataset="eventTypeSelect"></option>
				</select></span></p>
			</td>
			<td width="11%"
				style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center
				><span> 
				<textarea type="text" name='时间' style="width: 89px;" rows='2' id="eventDate9" readonly></textarea></span></p>
			</td>
			<td width="11%"
				style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center
				><span> 
				<textarea name="地点" id="eventPlace9" style="width: 89px;height: 38px" readonly></textarea></span></p>
			</td>
			<td width="17%"
				style='width: 17.66%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center
				><span> 
				<textarea name="批准单位" id="approveOrgan9" style="width: 144px;height: 38px" readonly></textarea></span></p>
			</td>
			<td width="16%"
				style='width: 16.42%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center
				><span> 
				<textarea name="收费情况" id="chargeStatus9" style="width: 135px;height: 38px" readonly></textarea></span></p>
			</td>
		</tr>
		<tr style='mso-yfti-irow: 10; height: 31.2pt'>
			<td 
				style=' border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal
				style='margin-left: 26.4pt; text-indent: -21.0pt; mso-list: l0 level1 lfo12; tab-stops: list 26.4pt left 248.15pt'><![if !supportLists]><span
				lang=EN-US
				style='mso-bidi-font-size: 10.5pt; font-family: 宋体; mso-bidi-font-family: 宋体'><span
				style='mso-list: Ignore'>10.<span
				style='font: 7.0pt "Times New Roman"'>&nbsp; </span></span></span><![endif]><span
				lang=EN-US style='mso-bidi-font-size: 10.5pt; font-family: 宋体'><o:p>&nbsp;</o:p></span></p>
			</td>
			<td width="21%"
				style='width: 21.6%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center
				><span> 
				<textarea name="活动名称" id="eventName10" style="width: 177px;height: 38px" readonly></textarea></span></p>
			</td>
			<td width="11%"
				style='width: 11.76%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center
				><span> 
				<select name='类型' disabled id="eventType10" style="width:98%;" />
					<option dataset="eventTypeSelect"></option>
				</select></span></p>
			</td>
			<td width="11%"
				style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center
				><span> 
				<textarea type="text" name='时间' style="width: 89px;" rows='2' id="eventDate10" readonly></textarea></span></p>
			</td>
			<td width="11%"
				style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center
				><span> 
				<textarea name="地点" id="eventPlace10" style="width: 89px;height: 38px" readonly></textarea></span></p>
			</td>
			<td width="17%"
				style='width: 17.66%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center
				><span> 
				<textarea name="批准单位" id="approveOrgan10" style="width: 144px;height: 38px" readonly></textarea></span></p>
			</td>
			<td width="16%"
				style='width: 16.42%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center
				><span> 
				<textarea name="收费情况" id="chargeStatus10" style="width: 135px;height: 38px" readonly></textarea></span></p>
			</td>
		</tr>
		<tr style='mso-yfti-irow: 11; height: 31.2pt'>
			<td 
				style=' border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal
				style='margin-left: 26.4pt; text-indent: -21.0pt; mso-list: l0 level1 lfo12; tab-stops: list 26.4pt left 248.15pt'><![if !supportLists]><span
				lang=EN-US
				style='mso-bidi-font-size: 10.5pt; font-family: 宋体; mso-bidi-font-family: 宋体'><span
				style='mso-list: Ignore'>11.<span
				style='font: 7.0pt "Times New Roman"'>&nbsp; </span></span></span><![endif]><span
				lang=EN-US style='mso-bidi-font-size: 10.5pt; font-family: 宋体'><o:p>&nbsp;</o:p></span></p>
			</td>
			<td width="21%"
				style='width: 21.6%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center
				><span> 
				<textarea name="活动名称" id="eventName11" style="width: 177px;height: 38px" readonly></textarea></span></p>
			</td>
			<td width="11%"
				style='width: 11.76%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center
				><b
				style='mso-bidi-font-weight: normal'><span> 
				<select name='类型' disabled id="eventType11" style="width:98%;" />
					<option dataset="eventTypeSelect"></option>
				</select></span></p>
			</td>
			<td width="11%"
				style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center
				><span> 
				<textarea type="text" name='时间' style="width: 89px;" rows='2' id="eventDate11" readonly></textarea></span></p>
			</td>
			<td width="11%"
				style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center
				><span> 
				<textarea name="地点" id="eventPlace11" style="width: 89px;height: 38px" readonly></textarea></span></p>
			</td>
			<td width="17%"
				style='width: 17.66%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center
				><span> 
				<textarea name="批准单位" id="approveOrgan11" style="width: 144px;height: 38px" readonly></textarea></span></p>
			</td>
			<td width="16%"
				style='width: 16.42%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center
				><span> 
				<textarea name="收费情况" id="chargeStatus11" style="width: 135px;height: 38px" readonly></textarea></span></p>
			</td>
		</tr>
		<tr style='mso-yfti-irow: 12; height: 31.2pt'>
			<td 
				style=' border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal
				style='margin-left: 26.4pt; text-indent: -21.0pt; mso-list: l0 level1 lfo12; tab-stops: list 26.4pt left 248.15pt'><![if !supportLists]><span
				lang=EN-US
				style='mso-bidi-font-size: 10.5pt; font-family: 宋体; mso-bidi-font-family: 宋体'><span
				style='mso-list: Ignore'>12.<span
				style='font: 7.0pt "Times New Roman"'>&nbsp; </span></span></span><![endif]><span
				lang=EN-US style='mso-bidi-font-size: 10.5pt; font-family: 宋体'><o:p>&nbsp;</o:p></span></p>
			</td>
			<td width="21%"
				style='width: 21.6%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center
				><span> 
				<textarea name="活动名称" id="eventName12" style="width: 177px;height: 38px" readonly></textarea></span></p>
			</td>
			<td width="11%"
				style='width: 11.76%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center
				><span> 
				<select name='类型' disabled id="eventType12" style="width:98%;" />
					<option dataset="eventTypeSelect"></option>
				</select></span></p>
			</td>
			<td width="11%"
				style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center
				><span> 
				<textarea type="text" name='时间' style="width: 89px;" rows='2' id="eventDate12" readonly></textarea></span></p>
			</td>
			<td width="11%"
				style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center
				><span> 
				<textarea name="地点" id="eventPlace12" style="width: 89px;height: 38px" readonly></textarea></span></p>
			</td>
			<td width="17%"
				style='width: 17.66%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center
				><span> 
				<textarea name="批准单位" id="approveOrgan12" style="width: 144px;height: 38px" readonly></textarea></span></p>
			</td>
			<td width="16%"
				style='width: 16.42%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center
				><span> 
				<textarea name="收费情况" id="chargeStatus12" style="width: 135px;height: 38px" readonly></textarea></span></p>
			</td>
		</tr>
		<tr style='mso-yfti-irow: 13; height: 31.2pt'>
			<td 
				style=' border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal
				style='margin-left: 26.4pt; text-indent: -21.0pt; mso-list: l0 level1 lfo12; tab-stops: list 26.4pt left 248.15pt'><![if !supportLists]><span
				lang=EN-US
				style='mso-bidi-font-size: 10.5pt; font-family: 宋体; mso-bidi-font-family: 宋体'><span
				style='mso-list: Ignore'>13.<span
				style='font: 7.0pt "Times New Roman"'>&nbsp; </span></span></span><![endif]><span
				lang=EN-US style='mso-bidi-font-size: 10.5pt; font-family: 宋体'><o:p>&nbsp;</o:p></span></p>
			</td>
			<td width="21%"
				style='width: 21.6%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center
				><span> 
				<textarea name="活动名称" id="eventName13" style="width: 177px;height: 38px" readonly></textarea></span></p>
			</td>
			<td width="11%"
				style='width: 11.76%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center
				><span> 
				<select name='类型' disabled id="eventType13" style="width:98%;" />
					<option dataset="eventTypeSelect"></option>
				</select></span></p>
			</td>
			<td width="11%"
				style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center
				><span> 
				<textarea type="text" name='时间' style="width: 89px;" rows='2' id="eventDate13" readonly></textarea></span></p>
			</td>
			<td width="11%"
				style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center
				><span> 
				<textarea name="地点" id="eventPlace13" style="width: 89px;height: 38px" readonly></textarea></span></p>
			</td>
			<td width="17%"
				style='width: 17.66%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center
				><span> 
				<textarea name="批准单位" id="approveOrgan13" style="width: 144px;height: 38px" readonly></textarea></span></p>
			</td>
			<td width="16%"
				style='width: 16.42%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center
				><span> 
				<textarea name="收费情况" id="chargeStatus13" style="width: 135px;height: 38px" readonly></textarea></span></p>
			</td>
		</tr>
		<tr style='mso-yfti-irow: 14; height: 31.2pt'>
			<td 
				style=' border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal
				style='margin-left: 26.4pt; text-indent: -21.0pt; mso-list: l0 level1 lfo12; tab-stops: list 26.4pt left 248.15pt'><![if !supportLists]><span
				lang=EN-US
				style='mso-bidi-font-size: 10.5pt; font-family: 宋体; mso-bidi-font-family: 宋体'><span
				style='mso-list: Ignore'>14.<span
				style='font: 7.0pt "Times New Roman"'>&nbsp; </span></span></span><![endif]><span
				lang=EN-US style='mso-bidi-font-size: 10.5pt; font-family: 宋体'><o:p>&nbsp;</o:p></span></p>
			</td>
			<td width="21%"
				style='width: 21.6%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center
				><span> 
				<textarea name="活动名称" id="eventName14" style="width: 177px;height: 38px" readonly></textarea></span></p>
			</td>
			<td width="11%"
				style='width: 11.76%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center
				><span> 
				<select name='类型' disabled id="eventType14" style="width:98%;" />
					<option dataset="eventTypeSelect"></option>
				</select></span></p>
			</td>
			<td width="11%"
				style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center
				><span> 
				<textarea type="text" name='时间' style="width: 89px;" rows='2' id="eventDate14" readonly></textarea></span></p>
			</td>
			<td width="11%"
				style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center
				><span> 
				<textarea name="地点" id="eventPlace14" style="width: 89px;height: 38px" readonly></textarea></span></p>
			</td>
			<td width="17%"
				style='width: 17.66%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center
				><span> 
				<textarea name="批准单位" id="approveOrgan14" style="width: 144px;height: 38px" readonly></textarea></span></p>
			</td>
			<td width="16%"
				style='width: 16.42%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center
				><span> 
				<textarea name="收费情况" id="chargeStatus14" style="width: 135px;height: 38px" readonly></textarea></span></p>
			</td>
		</tr>
		<tr style='mso-yfti-irow: 15; height: 31.2pt'>
			<td 
				style=' border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal
				style='margin-left: 26.4pt; text-indent: -21.0pt; mso-list: l0 level1 lfo12; tab-stops: list 26.4pt left 248.15pt'><![if !supportLists]><span
				lang=EN-US
				style='mso-bidi-font-size: 10.5pt; font-family: 宋体; mso-bidi-font-family: 宋体'><span
				style='mso-list: Ignore'>15.<span
				style='font: 7.0pt "Times New Roman"'>&nbsp; </span></span></span><![endif]><span
				lang=EN-US style='mso-bidi-font-size: 10.5pt; font-family: 宋体'><o:p>&nbsp;</o:p></span></p>
			</td>
			<td width="21%"
				style='width: 21.6%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center
				><span> 
				<textarea name="活动名称" id="eventName15" style="width: 177px;height: 38px" readonly></textarea></span></p>
			</td>
			<td width="11%"
				style='width: 11.76%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center
				><span> 
				<select name='类型' disabled id="eventType15" style="width:98%;" />
					<option dataset="eventTypeSelect"></option>
				</select></span></p>
			</td>
			<td width="11%"
				style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center
				><span> 
				<textarea type="text" name='时间' style="width: 89px;" rows='2' id="eventDate15" readonly></textarea></span></p>
			</td>
			<td width="11%"
				style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center
				><span> 
				<textarea name="地点" id="eventPlace15" style="width: 89px;height: 38px" readonly></textarea></span></p>
			</td>
			<td width="17%"
				style='width: 17.66%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center
				><span> 
				<textarea name="批准单位" id="approveOrgan15" style="width: 144px;height: 38px" readonly></textarea></span></p>
			</td>
			<td width="16%"
				style='width: 16.42%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center
				><span> 
				<textarea name="收费情况" id="chargeStatus15" style="width: 135px;height: 38px" readonly></textarea></span></p>
			</td>
		</tr>
		<tr style='mso-yfti-irow: 16; height: 31.2pt'>
			<td 
				style=' border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal
				style='margin-left: 26.4pt; text-indent: -21.0pt; mso-list: l0 level1 lfo12; tab-stops: list 26.4pt left 248.15pt'><![if !supportLists]><span
				lang=EN-US
				style='mso-bidi-font-size: 10.5pt; font-family: 宋体; mso-bidi-font-family: 宋体'><span
				style='mso-list: Ignore'>16.<span
				style='font: 7.0pt "Times New Roman"'>&nbsp; </span></span></span><![endif]><span
				lang=EN-US style='mso-bidi-font-size: 10.5pt; font-family: 宋体'><o:p>&nbsp;</o:p></span></p>
			</td>
			<td width="21%"
				style='width: 21.6%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center
				><span> 
				<textarea name="活动名称" id="eventName16" style="width: 177px;height: 38px" readonly></textarea></span></p>
			</td>
			<td width="11%"
				style='width: 11.76%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center
				><span> 
				<select name='类型' disabled id="eventType16" style="width:98%;" />
					<option dataset="eventTypeSelect"></option>
				</select></span></p>
			</td>
			<td width="11%"
				style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center
				><span> 
				<textarea type="text" name='时间' style="width: 89px;" rows='2' id="eventDate16" readonly></textarea></span></p>
			</td>
			<td width="11%"
				style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center
				><span> 
				<textarea name="地点" id="eventPlace16" style="width: 89px;height: 38px" readonly></textarea></span></p>
			</td>
			<td width="17%"
				style='width: 17.66%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center
				><span> 
				<textarea name="批准单位" id="approveOrgan16" style="width: 144px;height: 38px" readonly></textarea></span></p>
			</td>
			<td width="16%"
				style='width: 16.42%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center
				><span> 
				<textarea name="收费情况" id="chargeStatus16" style="width: 135px;height: 38px" readonly></textarea></span></p>
			</td>
		</tr>
		<tr style='mso-yfti-irow: 17; height: 31.2pt'>
			<td 
				style=' border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal
				style='margin-left: 26.4pt; text-indent: -21.0pt; mso-list: l0 level1 lfo12; tab-stops: list 26.4pt left 248.15pt'><![if !supportLists]><span
				lang=EN-US
				style='mso-bidi-font-size: 10.5pt; font-family: 宋体; mso-bidi-font-family: 宋体'><span
				style='mso-list: Ignore'>17.<span
				style='font: 7.0pt "Times New Roman"'>&nbsp; </span></span></span><![endif]><span
				lang=EN-US style='mso-bidi-font-size: 10.5pt; font-family: 宋体'><o:p>&nbsp;</o:p></span></p>
			</td>
			<td width="21%"
				style='width: 21.6%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center
				><span> 
				<textarea name="活动名称" id="eventName17" style="width: 177px;height: 38px" readonly></textarea></span></p>
			</td>
			<td width="11%"
				style='width: 11.76%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center
				><span> 
				<select name='类型' disabled id="eventType17" style="width:98%;" />
					<option dataset="eventTypeSelect"></option>
				</select></span></p>
			</td>
			<td width="11%"
				style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center
				><span> 
				<textarea type="text" name='时间' style="width: 89px;" rows='2' id="eventDate17" readonlyreadonly></textarea></span></p>
			</td>
			<td width="11%"
				style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center
				><span> 
				<textarea name="地点" id="eventPlace17" style="width: 89px;height: 38px" readonly></textarea></span></p>
			</td>
			<td width="17%"
				style='width: 17.66%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center
				><span> 
				<textarea name="批准单位" id="approveOrgan17" style="width: 144px;height: 38px" readonly></textarea></span></p>
			</td>
			<td width="16%"
				style='width: 16.42%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center
				><span> 
				<textarea name="收费情况" id="chargeStatus17" style="width: 135px;height: 38px" readonly></textarea></span></p>
			</td>
		</tr>
		<tr style='mso-yfti-irow: 18; mso-yfti-lastrow: yes; height: 31.2pt'>
			<td 
				style=' border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: .5pt; mso-border-left-alt: 1.5pt; mso-border-bottom-alt: 1.5pt; mso-border-right-alt: .5pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal
				style='margin-left: 26.4pt; text-indent: -21.0pt; mso-list: l0 level1 lfo12; tab-stops: list 26.4pt left 248.15pt'><![if !supportLists]><span
				lang=EN-US
				style='mso-bidi-font-size: 10.5pt; font-family: 宋体; mso-bidi-font-family: 宋体'><span
				style='mso-list: Ignore'>18.<span
				style='font: 7.0pt "Times New Roman"'>&nbsp; </span></span></span><![endif]><span
				lang=EN-US style='mso-bidi-font-size: 10.5pt; font-family: 宋体'><o:p>&nbsp;</o:p></span></p>
			</td>
			<td width="21%"
				style='width: 21.6%; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext 1.5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center
				><span> 
				<textarea name="活动名称" id="eventName18" style="width: 177px;height: 38px" readonly></textarea></span></p>
			</td>
			<td width="11%"
				style='width: 11.76%; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext 1.5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center
				><span> 
				<select name='类型' disabled id="eventType18" style="width:98%;" />
					<option dataset="eventTypeSelect"></option>
				</select></span></p>
			</td>
			<td width="11%"
				style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext 1.5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center
				><span> 
				<textarea type="text" name='时间' style="width: 89px;" rows='2' id="eventDate18" readonly></textarea></span></p>
			</td>
			<td width="11%"
				style='width: 11.78%; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext 1.5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center
				><span> 
				<textarea name="地点" id="eventPlace18" style="width: 89px;height: 38px" readonly></textarea></span></p>
			</td>
			<td width="17%"
				style='width: 17.66%; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext 1.5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center
				><span> 
				<textarea name="批准单位" id="approveOrgan18" style="width: 144px;height: 38px" readonly></textarea></span></p>
			</td>
			<td width="16%"
				style='width: 16.42%; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; padding: 0cm 0pt 0cm 0pt; height: 31.2pt'>
			<p class=MsoNormal align=center
				><span> 
				<textarea name="收费情况" id="chargeStatus18" style="width: 135px;height: 38px" readonly></textarea></span></p>
			</td>
		</tr>
	</table>
</form>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</div>
</body>
</html>