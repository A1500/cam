<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>

<script language="javascript">
	//初始化
	function init16(){
		//createGroupDetailSelect();
		somCheckInterProjectDataSet.setParameter("TASK_CODE@=", taskCode);
		somCheckInterProjectDataSet.load();
		somCheckInterProjectDataSet.on("load",function(ds){
			if(ds.getCount()<1){
				somCheckInterProjectDataSet.newRecord({"taskCode":taskCode});
			}else{
				for(i=1;i<=ds.getCount();i++){
					document.getElementById("projectName"+i).value=ds.getAt(i-1).get("projectName");
					document.getElementById("auditOrganName"+i).value=ds.getAt(i-1).get("auditOrganName");
					document.getElementById("coopOrganName"+i).value=ds.getAt(i-1).get("coopOrganName");
					document.getElementById("coopOrganNation"+i).value=ds.getAt(i-1).get("coopOrganNation");
					document.getElementById("onProjectFund"+i).innerHTML=ds.getAt(i-1).get("onProjectFund");
					document.getElementById("offProjectFund"+i).innerHTML=ds.getAt(i-1).get("offProjectFund");
					document.getElementById("projectType"+i).value=ds.getAt(i-1).get("projectType");
					document.getElementById("projectPeriod"+i).value=ds.getAt(i-1).get("projectPeriod");
					document.getElementById("projectPlace"+i).value=ds.getAt(i-1).get("projectPlace");
				}
			}
		});
		somCheckInterMeetingDataSet.setParameter("TASK_CODE@=", taskCode);
		somCheckInterMeetingDataSet.load();
		somCheckInterMeetingDataSet.on("load",function(ds){
			if(ds.getCount()<1){
				somCheckInterMeetingDataSet.newRecord({"taskCode":taskCode});
			}else{
				for(i=1;i<=ds.getCount();i++){
					document.getElementById("meetingName"+i).value=ds.getAt(i-1).get("meetingName");
					document.getElementById("meetingDate"+i).value=ds.getAt(i-1).get("meetingDate");
					document.getElementById("meetingType"+i).value=ds.getAt(i-1).get("meetingType");
					document.getElementById("meetingPlace"+i).value=ds.getAt(i-1).get("meetingPlace");
					document.getElementById("hostOrganName"+i).value=ds.getAt(i-1).get("hostOrganName");
					document.getElementById("fundsSource"+i).value=ds.getAt(i-1).get("fundsSource");
					document.getElementById("speakSubject"+i).value=ds.getAt(i-1).get("speakSubject");
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
.label16 {
	text-align:right;
}
</style>

<model:datasets>
	<!-- 国际合作项目 -->
	<model:dataset id="somCheckInterProjectDataSet" cmd="com.inspur.cams.sorg.check.checkinterproject.cmd.SomCheckInterProjectQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.checkinterproject.data.SomCheckInterProject"></model:record>
	</model:dataset>
	<!-- 参加国际会议 -->
	<model:dataset id="somCheckInterMeetingDataSet" cmd="com.inspur.cams.sorg.check.checkintermeeting.cmd.SomCheckInterMeetingQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.checkintermeeting.data.SomCheckInterMeeting"></model:record>
	</model:dataset>
	<!-- 项目类别 -->
	<model:dataset id="projectTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_INTER_PROJECT_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 会议类型 -->
	<model:dataset id="meetingTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_INTER_MEETING_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 我方经费来源 -->
	<model:dataset id="fundsSourceSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_CHECK_FUNDS_SOURCE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>

<!--页面按钮-->
<div id="float" class="noprint" style='height:15px;'>	

</div>
<div align=center style='page-break-after:always'>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal align=left
	style='text-align: center; tab-stops: 248.15pt'><b><span
	style='font-size: 14.0pt; font-family: 宋体'>（四）本年度国际交流与合作情况<span
	lang=EN-US><o:p></o:p></span></span></b></p>

<p class=MsoNormal align=left
	style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span
	lang=EN-US style='font-size: 14.0pt; font-family: 宋体'>1</span><span
	style='font-size: 14.0pt; font-family: 宋体'>．国际合作项目（最主要的五项）<span
	lang=EN-US><o:p></o:p></span></span></p>

<form method="post" dataset=somCheckInterProjectDataSet onsubmit="return false">
	<table cellspacing=0 cellpadding=0 width="800">
		<tr style='page-break-inside: avoid; height: 34.0pt'>
			<td width="15%" rowspan=2
				style='width: 15.78%; border-top: 1.5pt; border-left: 1.5pt; border-bottom: 1.0pt; border-right: 1.0pt; border-color: windowtext; border-style: solid; mso-border-top-alt: 1.5pt; mso-border-left-alt: 1.5pt; mso-border-bottom-alt: .5pt; mso-border-right-alt: .5pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid; padding: 0cm 5.4pt 0cm 5.4pt; height: 34.0pt'>
			<p class=MsoNormal align=center style='text-align: center'><span
				style='font-size: 12.0pt; font-family: 宋体'>项目名称<span
				lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="8%" rowspan=2
				style='width: 8.78%; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 34.0pt'>
			<p class=MsoNormal align=center style='text-align: center'><span
				style='font-size: 12.0pt; font-family: 宋体'>批准<span lang=EN-US><o:p></o:p></span></span></p>
			<p class=MsoNormal align=center style='text-align: center'><span
				style='font-size: 12.0pt; font-family: 宋体'>机关<span lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="12%" rowspan=2
				style='width: 12.04%; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 1.4pt 0cm 1.4pt; height: 34.0pt'>
			<p class=MsoNormal align=center style='text-align: center'><span
				style='font-size: 12.0pt; font-family: 宋体'>境外合作<span
				lang=EN-US><o:p></o:p></span></span></p>
			<p class=MsoNormal align=center style='text-align: center'><span
				style='font-size: 12.0pt; font-family: 宋体'>单位名称<span
				lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="12%" rowspan=2
				style='width: 12.52%; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 1.4pt 0cm 1.4pt; height: 34.0pt'>
			<p class=MsoNormal align=center style='text-align: center'><span
				style='font-size: 12.0pt; font-family: 宋体'>境外合作单位所属国家、地区或<span
				lang=EN-US><o:p></o:p></span></span></p>
			<p class=MsoNormal align=center style='text-align: center'><span
				style='font-size: 12.0pt; font-family: 宋体'>国际组织<span
				lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="21%" colspan=2
				style='width: 21.06%; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 0cm 0cm 0cm; height: 34.0pt'>
			<p class=MsoNormal align=center style='text-align: center'><span
				style='font-size: 12.0pt; font-family: 宋体'>项目资金<span
				lang=EN-US><o:p></o:p></span></span></p>
			<p class=MsoNormal align=center style='text-align: center'><span
				style='font-size: 12.0pt; font-family: 宋体'>（单位：人民币元）<span
				lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="8%" rowspan=2
				style='width: 8.78%; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 34.0pt'>
			<p class=MsoNormal align=center style='text-align: center'><span
				style='font-size: 12.0pt; font-family: 宋体'>项目<span lang=EN-US><o:p></o:p></span></span></p>
			<p class=MsoNormal align=center style='text-align: center'><span
				style='font-size: 12.0pt; font-family: 宋体'>类别<span lang=EN-US
				style='color: red'><o:p></o:p></span></span></p>
			</td>
			<td width="8%" rowspan=2
				style='width: 8.78%; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 34.0pt'>
			<p class=MsoNormal align=center style='text-align: center'><span
				style='font-size: 12.0pt; font-family: 宋体'>项目实施时间<span
				lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="12%" rowspan=2
				style='width: 12.28%; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: 1.5pt; mso-border-left-alt: .5pt; mso-border-bottom-alt: .5pt; mso-border-right-alt: 1.5pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid; padding: 0cm 5.4pt 0cm 5.4pt; height: 34.0pt'>
			<p class=MsoNormal align=center style='text-align: center'><span
				style='font-size: 12.0pt; font-family: 宋体'>项目实施地（填写地市级行政区域名称）<span
				lang=EN-US><o:p></o:p></span></span></p>
			</td>
		</tr>
		<tr style='page-break-inside: avoid; height: 22.4pt'>
			<td width="10%"
				style='width: 10.52%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 22.4pt'>
			<p class=MsoNormal align=center style='text-align: center'><span
				style='font-size: 12.0pt; font-family: 宋体'>境内<span lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="10%"
				style='width: 10.52%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 22.4pt'>
			<p class=MsoNormal align=center style='text-align: center'><span
				style='font-size: 12.0pt; font-family: 宋体'>境外<span lang=EN-US><o:p></o:p></span></span></p>
			</td>
		</tr>
		<tr style='page-break-inside: avoid; height: 36.75pt'>
			<td width="15%"
				style='width: 15.78%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt;  height: 36.75pt'>
			<p class=MsoNormal align=center style='text-align: center'><span> 
				<textarea type="text" name="项目名称" style='width:125;' id="projectName1"  rows='3'  readonly></textarea></span></p>
			</td>
			<td width="8%"
				style='width: 8.78%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt;  height: 36.75pt'>
			<p class=MsoNormal align=center style='text-align: center'><span> 
				<textarea type="text" name="批准机关" style='width:60;' id="auditOrganName1"rows='3'  readonly></textarea></span></p>
			</td>
			<td width="12%"
				style='width: 12.04%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt;  height: 36.75pt'>
			<p class=MsoNormal align=center style='text-align: center'><span> 
				<textarea type="text" name="境外合作单位名称" style='width:100;' id="coopOrganName1"rows='3'  readonly></textarea></span></p>
			</td>
			<td width="12%"
				style='width: 12.52%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt;  height: 36.75pt'>
			<p class=MsoNormal align=center style='text-align: center'><span> 
				<textarea type="text" name="境外合作单位所属国家、地区或国际组织" style='width:98;' id="coopOrganNation1"rows='3'  readonly></textarea></span></p>
			</td>
			<td width="10%"
				style='width: 10.52%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt;  height: 36.75pt'>
			<p class=MsoNormal align=center style='text-align: center'><span> 
				<label class='label16'  type="text" name="境内项目资金" style='width:87;'  onkeyup="value=value.replace(/[^\d.]/g,'') " id="onProjectFund1" style="width: 98%;text-align: right" ></label></span></p>
			</td>
			<td width="10%"
				style='width: 10.52%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt;  height: 36.75pt'>
			<p class=MsoNormal align=center style='text-align: center'><span> 
				<label class='label16'  type="text" name="境外项目资金" style='width:87;'  onkeyup="value=value.replace(/[^\d.]/g,'') " id="offProjectFund1" style="width: 98%;text-align: right" ></label></span></p>
			</td>
			<td width="8%"
				style='width: 8.78%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt;  height: 36.75pt'>
			<p class=MsoNormal align=center style='text-align: center'><span> 
				<select name='项目类别' style='width:60;' disabled id="projectType1">
					<option dataset="projectTypeSelect"></option>
				</select></span></p>
			</td>
			<td width="8%"
				style='width: 8.78%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt;  height: 36.75pt'>
			<p class=MsoNormal align=center style='text-align: center'><span> 
				<textarea type="text" name="项目实施时间" style='width:58;' id="projectPeriod1"rows='3'  readonly></textarea></span></p>
			</td>
			<td width="12%"
				style='width: 12.28%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt;  height: 36.75pt'>
			<p class=MsoNormal align=center style='text-align: center'><span> 
				<textarea type="text" name="项目实施地" style='width:98;' id="projectPlace1"rows='3'  readonly></textarea></span></p>
			</td>
		</tr>
		<tr style='page-break-inside: avoid; height: 36.75pt'>
			<td width="15%"
				style='width: 15.78%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt;  height: 36.75pt'>
			<p class=MsoNormal align=center style='text-align: center'><span> 
				<textarea type="text" name="项目名称" style='width:125;' id="projectName2"rows='3'  readonly></textarea></span></p>
			</td>
			<td width="8%"
				style='width: 8.78%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt;  height: 36.75pt'>
			<p class=MsoNormal align=center style='text-align: center'><span> 
				<textarea type="text" name="批准机关" style='width:60;' id="auditOrganName2"rows='3'  readonly></textarea></span></p>
			</td>
			<td width="12%"
				style='width: 12.04%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt;  height: 36.75pt'>
			<p class=MsoNormal align=center style='text-align: center'><span> 
				<textarea type="text" name="境外合作单位名称" style='width:100;' id="coopOrganName2"rows='3'  readonly></textarea></span></p>
			</td>
			<td width="12%"
				style='width: 12.52%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt;  height: 36.75pt'>
			<p class=MsoNormal align=center style='text-align: center'><span> 
				<textarea type="text" name="境外合作单位所属国家、地区或国际组织" style='width:98;' id="coopOrganNation2"rows='3'  readonly></textarea></span></p>
			</td>
			<td width="10%"
				style='width: 10.52%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt;  height: 36.75pt'>
			<p class=MsoNormal align=center style='text-align: center'><span> 
				<label class='label16'  type="text" name="境内项目资金" style='width:87;'  onkeyup="value=value.replace(/[^\d.]/g,'') " id="onProjectFund2" style="width: 98%;text-align: right" ></label></span></p>
			</td>
			<td width="10%"
				style='width: 10.52%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt;  height: 36.75pt'>
			<p class=MsoNormal align=center style='text-align: center'><span> 
				<label class='label16'  type="text" name="境外项目资金" style='width:87;'  onkeyup="value=value.replace(/[^\d.]/g,'') " id="offProjectFund2" style="width: 98%;text-align: right" ></label></span></p>
			</td>
			<td width="8%"
				style='width: 8.78%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt;  height: 36.75pt'>
			<p class=MsoNormal align=center style='text-align: center'><span> 
				<select name='项目类别' style='width:60;' disabled id="projectType2">
					<option dataset="projectTypeSelect"></option>
				</select></span></p>
			</td>
			<td width="8%"
				style='width: 8.78%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt;  height: 36.75pt'>
			<p class=MsoNormal align=center style='text-align: center'><span> 
				<textarea type="text" name="项目实施时间" style='width:58;' id="projectPeriod2"rows='3'  readonly></textarea></span></p>
			</td>
			<td width="12%"
				style='width: 12.28%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt;  height: 36.75pt'>
			<p class=MsoNormal align=center style='text-align: center'><span> 
				<textarea type="text" name="项目实施地" style='width:98;' id="projectPlace2"rows='3'  readonly></textarea></span></p>
			</td>
		</tr>
		<tr style='page-break-inside: avoid; height: 36.75pt'>
			<td width="15%"
				style='width: 15.78%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt;  height: 36.75pt'>
			<p class=MsoNormal align=center style='text-align: center'><span> 
				<textarea type="text" name="项目名称" style='width:125;' id="projectName3"rows='3'  readonly></textarea></span></p>
			</td>
			<td width="8%"
				style='width: 8.78%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt;  height: 36.75pt'>
			<p class=MsoNormal align=center style='text-align: center'><span> 
				<textarea type="text" name="批准机关" style='width:60;' id="auditOrganName3"rows='3'  readonly></textarea></span></p>
			</td>
			<td width="12%"
				style='width: 12.04%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt;  height: 36.75pt'>
			<p class=MsoNormal align=center
				style='text-align: center; mso-pagination: widow-orphan'><span> 
				<textarea type="text" name="境外合作单位名称" style='width:100;' id="coopOrganName3"rows='3'  readonly></textarea></span></p>
			</td>
			<td width="12%"
				style='width: 12.52%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt;  height: 36.75pt'>
			<p class=MsoNormal align=center
				style='text-align: center; mso-pagination: widow-orphan'><span> 
				<textarea type="text" name="境外合作单位所属国家、地区或国际组织" style='width:98;' id="coopOrganNation3"rows='3'  readonly></textarea></span></p>
			</td>
			<td width="10%"
				style='width: 10.52%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt;  height: 36.75pt'>
			<p class=MsoNormal align=center style='text-align: center'><span> 
				<label class='label16'  type="text" name="境内项目资金" style='width:87;'  onkeyup="value=value.replace(/[^\d.]/g,'') " id="onProjectFund3" style="width: 98%;text-align: right" ></label></span></p>
			</td>
			<td width="10%"
				style='width: 10.52%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt;  height: 36.75pt'>
			<p class=MsoNormal align=center style='text-align: center'><span> 
				<label class='label16'  type="text" name="境外项目资金" style='width:87;'  onkeyup="value=value.replace(/[^\d.]/g,'') " id="offProjectFund3" style="width: 98%;text-align: right" ></label></span></p>
			</td>
			<td width="8%"
				style='width: 8.78%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt;  height: 36.75pt'>
			<p class=MsoNormal align=center style='text-align: center'><span> 
				<select name='项目类别' style='width:60;' disabled id="projectType3">
					<option dataset="projectTypeSelect"></option>
				</select></span></p>
			</td>
			<td width="8%"
				style='width: 8.78%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt;  height: 36.75pt'>
			<p class=MsoNormal align=center style='text-align: center'><span> 
				<textarea type="text" name="项目实施时间" style='width:58;' id="projectPeriod3"rows='3'  readonly></textarea></span></p>
			</td>
			<td width="12%"
				style='width: 12.28%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt;  height: 36.75pt'>
			<p class=MsoNormal align=center style='text-align: center'><span> 
				<textarea type="text" name="项目实施地" style='width:98;' id="projectPlace3"rows='3'  readonly></textarea></span></p>
			</td>
		</tr>
		<tr style='page-break-inside: avoid; height: 36.75pt'>
			<td width="15%"
				style='width: 15.78%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt;  height: 36.75pt'>
			<p class=MsoNormal align=center style='text-align: center'><span> 
				<textarea type="text" name="项目名称" style='width:125;' id="projectName4"rows='3'  readonly></textarea></span></p>
			</td>
			<td width="8%"
				style='width: 8.78%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt;  height: 36.75pt'>
			<p class=MsoNormal align=center style='text-align: center'><span> 
				<textarea type="text" name="批准机关" style='width:60;' id="auditOrganName4"rows='3'  readonly></textarea></span></p>
			</td>
			<td width="12%"
				style='width: 12.04%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt;  height: 36.75pt'>
			<p class=MsoNormal align=center
				style='text-align: center; mso-pagination: widow-orphan'><span> 
				<textarea type="text" name="境外合作单位名称" style='width:100;' id="coopOrganName4"rows='3'  readonly></textarea></span></p>
			</td>
			<td width="12%"
				style='width: 12.52%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt;  height: 36.75pt'>
			<p class=MsoNormal align=center
				style='text-align: center; mso-pagination: widow-orphan'><span> 
				<textarea type="text" name="境外合作单位所属国家、地区或国际组织" style='width:98;' id="coopOrganNation4"rows='3'  readonly></textarea></span></p>
			</td>
			<td width="10%"
				style='width: 10.52%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt;  height: 36.75pt'>
			<p class=MsoNormal align=center style='text-align: center'><span> 
				<label class='label16'  type="text" name="境内项目资金" style='width:87;'  onkeyup="value=value.replace(/[^\d.]/g,'') " id="onProjectFund4" style="width: 98%;text-align: right" ></label></span></p>
			</td>
			<td width="10%"
				style='width: 10.52%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt;  height: 36.75pt'>
			<p class=MsoNormal align=center style='text-align: center'><span> 
				<label class='label16'  type="text" name="境外项目资金" style='width:87;'  onkeyup="value=value.replace(/[^\d.]/g,'') " id="offProjectFund4" style="width: 98%;text-align: right" ></label></span></p>
			</td>
			<td width="8%"
				style='width: 8.78%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt;  height: 36.75pt'>
			<p class=MsoNormal align=center style='text-align: center'><span> 
				<select name='项目类别' style='width:60;' disabled id="projectType4">
					<option dataset="projectTypeSelect"></option>
				</select></span></p>
			</td>
			<td width="8%"
				style='width: 8.78%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt;  height: 36.75pt'>
			<p class=MsoNormal align=center style='text-align: center'><span> 
				<textarea type="text" name="项目实施时间" style='width:58;' id="projectPeriod4"rows='3'  readonly></textarea></span></p>
			</td>
			<td width="12%"
				style='width: 12.28%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt;  height: 36.75pt'>
			<p class=MsoNormal align=center style='text-align: center'><span> 
				<textarea type="text" name="项目实施地" style='width:98;' id="projectPlace4"rows='3'  readonly></textarea></span></p>
			</td>
		</tr>
		<tr
			style='mso-yfti-lastrow: yes; page-break-inside: avoid; height: 36.75pt'>
			<td width="15%"
				style='width: 15.78%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: .5pt; mso-border-left-alt: 1.5pt; mso-border-bottom-alt: 1.5pt; mso-border-right-alt: .5pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid;  height: 36.75pt'>
			<p class=MsoNormal align=center style='text-align: center'><span> 
				<textarea type="text" name="项目名称" style='width:125;' id="projectName5"rows='3'  readonly></textarea></span></p>
			</td>
			<td width="8%"
				style='width: 8.78%; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext 1.5pt;  height: 36.75pt'>
			<p class=MsoNormal align=center style='text-align: center'><span> 
				<textarea type="text" name="批准机关" style='width:60;' id="auditOrganName5"rows='3'  readonly></textarea></span></p>
			</td>
			<td width="12%"
				style='width: 12.04%; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext 1.5pt;  height: 36.75pt'>
			<p class=MsoNormal align=center
				style='text-align: center; mso-pagination: widow-orphan'><span> 
				<textarea type="text" name="境外合作单位名称" style='width:100;' id="coopOrganName5"rows='3'  readonly></textarea></span></p>
			</td>
			<td width="12%"
				style='width: 12.52%; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext 1.5pt;  height: 36.75pt'>
			<p class=MsoNormal align=center
				style='text-align: center; mso-pagination: widow-orphan'><span> 
				<textarea type="text" name="境外合作单位所属国家、地区或国际组织" style='width:98;' id="coopOrganNation5"  rows='3'  readonly></textarea></span></p>
			</td>
			<td width="10%"
				style='width: 10.52%; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext 1.5pt;  height: 36.75pt'>
			<p class=MsoNormal align=center style='text-align: center'><span> 
				<label class='label16'  type="text" name="境内项目资金" style='width:87;'  onkeyup="value=value.replace(/[^\d.]/g,'') " id="onProjectFund5" style="width: 98%;text-align: right" ></label></span></p>
			</td>
			<td width="10%"
				style='width: 10.52%; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext 1.5pt;  height: 36.75pt'>
			<p class=MsoNormal align=center style='text-align: center'><span> 
				<label class='label16'  type="text" name="境外项目资金" style='width:87;'  onkeyup="value=value.replace(/[^\d.]/g,'') " id="offProjectFund5" style="width: 98%;text-align: right" ></label></span></p>
			</td>
			<td width="8%"
				style='width: 8.78%; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext 1.5pt;  height: 36.75pt'>
			<p class=MsoNormal align=center style='text-align: center'><span> 
				<select name='项目类别' style='width:60;' disabled id="projectType5"  />
					<option dataset="projectTypeSelect"></option>
				</select></span></p>
			</td>
			<td width="8%"
				style='width: 8.78%; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext 1.5pt;  height: 36.75pt'>
			<p class=MsoNormal align=center style='text-align: center'><span> 
				<textarea type="text" name="项目实施时间" style='width:58;' id="projectPeriod5"  rows='3'  readonly></textarea></span></p>
			</td>
			<td width="12%"
				style='width: 12.28%; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt;  height: 36.75pt'>
			<p class=MsoNormal align=center style='text-align: center'><span> 
				<textarea type="text" name="项目实施地" style='width:98;' id="projectPlace5" rows='3'  readonly></textarea></span></p>
			</td>
		</tr>
	</table>
</form>
<p class=MsoNormal align=left
	style='margin-left: 5.4pt; text-align: left; line-height: 19.0pt; mso-line-height-rule: exactly; tab-stops: 248.15pt'><span
	lang=EN-US style='font-size: 14.0pt; font-family: 宋体'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal align=left
	style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span
	lang=EN-US style='font-size: 14.0pt; font-family: 宋体'>2</span><span
	style='font-size: 14.0pt; font-family: 宋体'>．参加国际会议（最主要的五项）<span
	lang=EN-US><o:p></o:p></span></span></p>
<form method="post" dataset=somCheckInterMeetingDataSet onsubmit="return false">
	<table cellspacing=0 cellpadding=0 width="800">		
		<tr>
			<td width="15%"
				style='width: 15.78%; border-top: 1.5pt; border-left: 1.5pt; border-bottom: 1.0pt; border-right: 1.0pt; border-color: windowtext; border-style: solid; mso-border-top-alt: 1.5pt; mso-border-left-alt: 1.5pt; mso-border-bottom-alt: .5pt; mso-border-right-alt: .5pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid; padding: 0cm 5.4pt 0cm 5.4pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 150%'><span
				style='font-size: 12.0pt; line-height: 150%; font-family: 宋体; mso-ascii-font-family: "Times New Roman"; mso-hansi-font-family: "Times New Roman"'>会议名称</span><span
				lang=EN-US style='font-size: 12.0pt; line-height: 150%'><o:p></o:p></span></p>
			</td>
			<td width="10%"
				style='width: 10.52%; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 150%'><span
				style='font-size: 12.0pt; line-height: 150%; font-family: 宋体; mso-ascii-font-family: "Times New Roman"; mso-hansi-font-family: "Times New Roman"'>会议</span><span
				lang=EN-US style='font-size: 12.0pt; line-height: 150%'><o:p></o:p></span></p>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 150%'><span
				style='font-size: 12.0pt; line-height: 150%; font-family: 宋体; mso-ascii-font-family: "Times New Roman"; mso-hansi-font-family: "Times New Roman"'>时间</span><span
				lang=EN-US style='font-size: 12.0pt; line-height: 150%'><o:p></o:p></span></p>
			</td>
			<td width="10%"
				style='width: 10.52%; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 150%'><span
				style='font-size: 12.0pt; line-height: 150%; font-family: 宋体; mso-ascii-font-family: "Times New Roman"; mso-hansi-font-family: "Times New Roman"'>会议</span><span
				lang=EN-US style='font-size: 12.0pt; line-height: 150%'><o:p></o:p></span></p>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 150%'><span
				style='font-size: 12.0pt; line-height: 150%; font-family: 宋体; mso-ascii-font-family: "Times New Roman"; mso-hansi-font-family: "Times New Roman"'>地点</span><span
				lang=EN-US style='font-size: 12.0pt; line-height: 150%'><o:p></o:p></span></p>
			</td>
			<td width="12%"
				style='width: 12.28%; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 1.4pt 0cm 1.4pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 150%'><span
				style='font-size: 12.0pt; line-height: 150%; font-family: 宋体; mso-ascii-font-family: "Times New Roman"; mso-hansi-font-family: "Times New Roman"'>会议类型</span><span
				lang=EN-US style='font-size: 12.0pt; line-height: 150%'><o:p></o:p></span></p>
			</td>
			<td width="19%"
				style='width: 19.3%; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 150%'><span
				style='font-size: 12.0pt; line-height: 150%; font-family: 宋体; mso-ascii-font-family: "Times New Roman"; mso-hansi-font-family: "Times New Roman"'>会议主办单位名称</span><span
				lang=EN-US style='font-size: 12.0pt; line-height: 150%'><span
				style='mso-spacerun: yes'>&nbsp; </span></span></p>
			</td>
			<td width="10%"
				style='width: 10.0%; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 1.4pt 0cm 1.4pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 150%'><span
				style='font-size: 12.0pt; line-height: 150%; font-family: 宋体; mso-ascii-font-family: "Times New Roman"; mso-hansi-font-family: "Times New Roman"'>我方经</span><span
				lang=EN-US style='font-size: 12.0pt; line-height: 150%'><o:p></o:p></span></p>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 150%'><span
				style='font-size: 12.0pt; line-height: 150%; font-family: 宋体; mso-ascii-font-family: "Times New Roman"; mso-hansi-font-family: "Times New Roman"'>费来源</span><span
				lang=EN-US style='font-size: 12.0pt; line-height: 150%'><o:p></o:p></span></p>
			</td>
			<td width="21%"
				style='width: 21.58%; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: 1.5pt; mso-border-left-alt: .5pt; mso-border-bottom-alt: .5pt; mso-border-right-alt: 1.5pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid; padding: 0cm 5.4pt 0cm 5.4pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 150%'><span
				style='font-size: 12.0pt; line-height: 150%; font-family: 宋体; mso-ascii-font-family: "Times New Roman"; mso-hansi-font-family: "Times New Roman"'>我方发言主题</span><span
				lang=EN-US style='font-size: 12.0pt; line-height: 150%'><o:p></o:p></span></p>
			</td>
		</tr>
		<tr style='height: 31.5pt'>
			<td width="15%"
				style='width: 15.78%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt;  height: 31.5pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 150%'><span> 
				<textarea type="text" name="会议名称" style='width:117;'rows='3' id="meetingName1"   readonly></textarea></span></p>
			</td>
			<td width="10%"
				style='width: 10.52%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt;  height: 31.5pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 150%'><span> 
				<textarea type="text" name='会议时间' style='width:78;' rows='3' id="meetingDate1"  readonly></textarea></span></p>
			</td>
			<td width="10%"
				style='width: 10.52%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt;  height: 31.5pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 150%'><span> 
				<textarea type="text" name="会议地点" style='width:78;'rows='3' id="meetingPlace1"   readonly></textarea></span></p>
			</td>
			<td width="12%"
				style='width: 12.28%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt;  height: 31.5pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 150%'><span> 
				<select name='会议类型' style='width:78;' disabled id="meetingType1"  />
					<option dataset="meetingTypeSelect"></option>
				</select></span></p>
			</td>
			<td width="19%"
				style='width: 19.3%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt;  height: 31.5pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 150%'><span> 
				<textarea type="text" name="会议主办单位名称" style='width:158;' rows='3' id="hostOrganName1"   readonly></textarea></span></p>
			</td>
			<td width="10%"
				style='width: 10.0%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt;  height: 31.5pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 150%'><span> 
				<select name='我方经费来源' style='width:99;' disabled id="fundsSource1"  />
					<option dataset="fundsSourceSelect"></option>
				</select></span></p>
			</td>
			<td width="21%"
				style='width: 21.58%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt;  height: 31.5pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 150%'><span> 
				<textarea type="text" name="" style='width:172' rows='3' id="speakSubject1"   readonly></textarea></span></p>
			</td>
		</tr>
		<tr style='height: 31.5pt'>
			<td width="15%"
				style='width: 15.78%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt;  height: 31.5pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 150%'><span> 
				<textarea type="text" name="会议名称" style='width:117;'rows='3' id="meetingName2"   readonly></textarea></span></p>
			</td>
			<td width="10%"
				style='width: 10.52%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt;  height: 31.5pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 150%'><span> 
				<textarea type="text" name='会议时间' style='width:78;' rows='3' id="meetingDate2"  readonly></textarea></span></p>
			</td>
			<td width="10%"
				style='width: 10.52%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt;  height: 31.5pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 150%'><span> 
				<textarea type="text" name="会议地点" style='width:78;'rows='3' id="meetingPlace2"   readonly></textarea></span></p>
			</td>
			<td width="12%"
				style='width: 12.28%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt;  height: 31.5pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 150%'><span> 
				<select name='会议类型' style='width:78;' disabled id="meetingType2"  />
					<option dataset="meetingTypeSelect"></option>
				</select></span></p>
			</td>
			<td width="19%"
				style='width: 19.3%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt;  height: 31.5pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 150%'><span> 
				<textarea type="text" name="会议主办单位名称" style='width:158;' rows='3' id="hostOrganName2"   readonly></textarea></span></p>
			</td>
			<td width="10%"
				style='width: 10.0%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt;  height: 31.5pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 150%'><span> 
				<select name='我方经费来源' style='width:99;' disabled id="fundsSource2"  />
					<option dataset="fundsSourceSelect"></option>
				</select></span></p>
			</td>
			<td width="21%"
				style='width: 21.58%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt;  height: 31.5pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 150%'><span> 
				<textarea type="text" name="" style='width:172' rows='3' id="speakSubject2"   readonly></textarea></span></p>
			</td>
		</tr>
		<tr style='height: 31.5pt'>
			<td width="15%"
				style='width: 15.78%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt;  height: 31.5pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 150%'><span> 
				<textarea type="text" name="会议名称" style='width:117;'rows='3' id="meetingName3"   readonly></textarea></span></p>
			</td>
			<td width="10%"
				style='width: 10.52%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt;  height: 31.5pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 150%'><span> 
				<textarea type="text" name='会议时间' style='width:78;' rows='3' id="meetingDate3"  readonly></textarea></span></p>
			</td>
			<td width="10%"
				style='width: 10.52%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt;  height: 31.5pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 150%'><span> 
				<textarea type="text" name="会议地点" style='width:78;'rows='3' id="meetingPlace3"   readonly></textarea></span></p>
			</td>
			<td width="12%"
				style='width: 12.28%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt;  height: 31.5pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 150%'><span> 
				<select name='会议类型' style='width:78;' disabled id="meetingType3"  />
					<option dataset="meetingTypeSelect"></option>
				</select></span></p>
			</td>
			<td width="19%"
				style='width: 19.3%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt;  height: 31.5pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 150%'><span> 
				<textarea type="text" name="会议主办单位名称" style='width:158;' rows='3' id="hostOrganName3"   readonly></textarea></span></p>
			</td>
			<td width="10%"
				style='width: 10.0%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt;  height: 31.5pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 150%'><span> 
				<select name='我方经费来源' style='width:99;' disabled id="fundsSource3"  />
					<option dataset="fundsSourceSelect"></option>
				</select></span></p>
			</td>
			<td width="21%"
				style='width: 21.58%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt;  height: 31.5pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 150%'><span> 
				<textarea type="text" name="" style='width:172' rows='3' id="speakSubject3"   readonly></textarea></span></p>
			</td>
		</tr>
		<tr style='height: 31.5pt'>
			<td width="15%"
				style='width: 15.78%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt;  height: 31.5pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 150%'><span> 
				<textarea type="text" name="会议名称" style='width:117;'rows='3' id="meetingName4"   readonly></textarea></span></p>
			</td>
			<td width="10%"
				style='width: 10.52%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt;  height: 31.5pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 150%'><span> 
				<textarea type="text" name='会议时间' style='width:78;' rows='3' id="meetingDate4"  readonly></textarea></span></p>
			</td>
			<td width="10%"
				style='width: 10.52%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt;  height: 31.5pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 150%'><span> 
				<textarea type="text" name="会议地点" style='width:78;'rows='3' id="meetingPlace4"   readonly></textarea></span></p>
			</td>
			<td width="12%"
				style='width: 12.28%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt;  height: 31.5pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 150%'><span> 
				<select name='会议类型' style='width:78;' disabled id="meetingType4"  />
					<option dataset="meetingTypeSelect"></option>
				</select></span></p>
			</td>
			<td width="19%"
				style='width: 19.3%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt;  height: 31.5pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 150%'><span> 
				<textarea type="text" name="会议主办单位名称" style='width:158;' rows='3' id="hostOrganName4"   readonly></textarea></span></p>
			</td>
			<td width="10%"
				style='width: 10.0%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt;  height: 31.5pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 150%'><span> 
				<select name='我方经费来源' style='width:99;' disabled id="fundsSource4"  />
					<option dataset="fundsSourceSelect"></option>
				</select></span></p>
			</td>
			<td width="21%"
				style='width: 21.58%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt;  height: 31.5pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 150%'><span> 
				<textarea type="text" name="我方发言主题" style='width:172' rows='3' id="speakSubject4"   readonly></textarea></span></p>
			</td>
		</tr>
		<tr style='mso-yfti-lastrow: yes; height: 31.5pt'>
			<td width="15%"
				style='width: 15.78%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: .5pt; mso-border-left-alt: 1.5pt; mso-border-bottom-alt: 1.5pt; mso-border-right-alt: .5pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid;  height: 31.5pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 150%'><span> 
				<textarea type="text" name="会议名称" style='width:117;'rows='3' id="meetingName5"   readonly></textarea></span></p>
			</td>
			<td width="10%"
				style='width: 10.52%; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext 1.5pt;  height: 31.5pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 150%'><span> 
				<textarea type="text" name='会议时间' style='width:78;' rows='3' id="meetingDate5"  readonly></textarea></span></p>
			</td>
			<td width="10%"
				style='width: 10.52%; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext 1.5pt;  height: 31.5pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 150%'><span> 
				<textarea type="text" name="会议地点" style='width:78;'rows='3' id="meetingPlace5"   readonly></textarea></span></p>
			</td>
			<td width="12%"
				style='width: 12.28%; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext 1.5pt;  height: 31.5pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 150%'><span> 
				<select name='会议类型' style='width:78;' disabled id="meetingType5"  />
					<option dataset="meetingTypeSelect"></option>
				</select></span></p>
			</td>
			<td width="19%"
				style='width: 19.3%; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext 1.5pt;  height: 31.5pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 150%'><span> 
				<textarea type="text" name="会议主办单位名称" style='width:158;' rows='3' id="hostOrganName5"   readonly></textarea></span></p>
			</td>
			<td width="10%"
				style='width: 10.0%; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext 1.5pt;  height: 31.5pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 150%'><span> 
				<select name='我方经费来源' style='width:99;' disabled id="fundsSource5"  />
					<option dataset="fundsSourceSelect"></option>
				</select></span></p>
			</td>
			<td width="21%"
				style='width: 21.58%; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt;  height: 31.5pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 150%'><span> 
				<textarea type="text" name="" style='width:172' rows='3' id="speakSubject5"   readonly></textarea></span></p>
			</td>
		</tr>
	</table>
</form>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</div>