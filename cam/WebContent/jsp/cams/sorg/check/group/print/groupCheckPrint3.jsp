<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>

<script language="javascript">
	//初始化
	function init3(){
		//createGroupDetailSelect();
		somCheckChangesDataSet.setParameter("TASK_CODE@=", taskCode);
		somCheckChangesDataSet.load();
		somCheckChangesDataSet.on("load",function(ds){
			if(ds.getCount()<1){
				somCheckChangesDataSet.newRecord({"taskCode":taskCode});
			}else{
				for(i=1;i<=ds.getCount();i++){
					var type = ds.getAt(i-1).get("type");
					document.getElementById("changeType"+type).value=ds.getAt(i-1).get("dealStatus");
					document.getElementById("changeDate"+type).innerHTML=ds.getAt(i-1).get("approveDate");
				}
			}
		});
		somCheckMeetingElectionDataSet.setParameter("TASK_CODE@=", taskCode);
		somCheckMeetingElectionDataSet.load();
		somCheckMeetingElectionDataSet.on("load",function(ds){
			if(ds.getCount()==0){
				somCheckMeetingElectionDataSet.newRecord({"taskCode":taskCode});
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
.label3 {
	text-align:center;
}
</style>

<model:datasets>
	<!-- 变更情况 -->
	<model:dataset id="somCheckChangesDataSet" cmd="com.inspur.cams.sorg.check.checkchanges.cmd.SomCheckChangesQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.checkchanges.data.SomCheckChanges"></model:record>
	</model:dataset>
	<!-- 本年度会议及换届情况 -->
	<model:dataset id="somCheckMeetingElectionDataSet" cmd="com.inspur.cams.sorg.check.checkmeetingelection.cmd.SomCheckMeetingElectionQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.checkmeetingelection.data.SomCheckMeetingElection"></model:record>
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
	<!-- 所属行事业 -->
	<model:dataset id="busScopeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BUS_SCOPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 社会组织职务 -->
	<model:dataset id="sorgDutiesSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_DUTY'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 会费标准备案情况 -->
	<model:dataset id="regFeeTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_REG_FEE_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 会费标准备案情况 -->
	<model:dataset id="changesStatusSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CHECK_CHANGES_STATUS'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="yesOrNoSelect" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset> 
</model:datasets>

<!--页面按钮-->
<div id="float" class="noprint" style='height:15px;'>	

</div>
<div style='page-break-after:always'>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<div class=Section1 style='layout-grid: 15.6pt'>

<p class=MsoNormal align=center style='text-align: center'><span
	style='font-size: 16.0pt; font-family: 黑体; mso-hansi-font-family: 宋体'>二、内部建设情况<span
	lang=EN-US><o:p></o:p></span></span></p>
<div align="center">
<form method="post" dataset=somCheckChangesDataSet onsubmit="return false">
	<p class=MsoNormal><b style='mso-bidi-font-weight: normal'><span
		style='font-size: 16.0pt; font-family: 宋体'>（一）本年度登记、备案事项变更情况</span></b><span lang=EN-US
		style='font-size: 16.0pt; font-family: 黑体; mso-hansi-font-family: 宋体'><o:p></o:p></span></p>
	<table cellspacing=0 cellpadding=0 width="800" id="changeTable">
		<tr style='height: 18.0pt'>
			<td width="33%"
				style='width: 33.98%; border-top: 1.5pt; border-left: 1.5pt; border-bottom: 1.0pt; border-right: 1.0pt; border-color: windowtext; border-style: solid; mso-border-top-alt: 1.5pt; mso-border-left-alt: 1.5pt; mso-border-bottom-alt: .5pt; mso-border-right-alt: .5pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid; padding: 0cm 5.4pt 0cm 5.4pt; height: 18.0pt'>
			<p class=MsoNormal align=center
				style='margin-top: 0cm; margin-right: -5.25pt; margin-bottom: 0cm; margin-left: -5.35pt; margin-bottom: .0001pt; mso-para-margin-top: 0cm; mso-para-margin-right: -.5gd; mso-para-margin-bottom: 0cm; mso-para-margin-left: -.51gd; mso-para-margin-bottom: .0001pt; text-align: center; line-height: 25.0pt; mso-line-height-rule: exactly'><span
				style='font-size: 14.0pt; font-family: 宋体'>事项<span lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="45%"
				style='width: 45.68%; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 18.0pt'>
			<p class=MsoNormal align=center
				style='margin-top: 0cm; margin-right: -5.25pt; margin-bottom: 0cm; margin-left: -5.35pt; margin-bottom: .0001pt; mso-para-margin-top: 0cm; mso-para-margin-right: -.5gd; mso-para-margin-bottom: 0cm; mso-para-margin-left: -.51gd; mso-para-margin-bottom: .0001pt; text-align: center; line-height: 25.0pt; mso-line-height-rule: exactly'><span
				style='font-size: 14.0pt; font-family: 宋体'>办理情况<span
				lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="20%" valign=top
				style='width: 20.34%; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: 1.5pt; mso-border-left-alt: .5pt; mso-border-bottom-alt: .5pt; mso-border-right-alt: 1.5pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid; padding: 0cm 5.4pt 0cm 5.4pt; height: 18.0pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 25.0pt; mso-line-height-rule: exactly'><span
				style='font-size: 14.0pt; font-family: 宋体'>批准时间<span
				lang=EN-US><o:p></o:p></span></span></p>
			</td>
		</tr>
		<tr style='height: 18.0pt'>
			<td width="33%"
				style='width: 33.98%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 18.0pt'>
			<p class=MsoNormal
				style='line-height: 25.0pt; mso-line-height-rule: exactly'><span
				style='font-size: 14.0pt; font-family: 宋体'>□<span lang=EN-US><span
				style='mso-spacerun: yes'>&nbsp; </span></span>变更名称<span lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="45%"
				style='width: 45.68%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 18.0pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 25.0pt; mso-line-height-rule: exactly'><span
				style='font-size: 14.0pt; font-family: 宋体'><span> 
				<select name='变更名称' id="changeType1" style="width: 98%" disabled="disabled"/>
					<option dataset="changesStatusSelect"></option>
				</select></span></p>
			</td>
			<td width="20%" valign=top
				style='width: 20.34%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 18.0pt'>
			<p class=MsoNormal
				style='line-height: 25.0pt; mso-line-height-rule: exactly'>
				<span> 
				<label class='label3'  id="changeDate1" style="width: 98%" ></span></p>
			</td>
		</tr>
		<tr style='height: 18.0pt'>
			<td width="33%"
				style='width: 33.98%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 18.0pt'>
			<p class=MsoNormal
				style='line-height: 25.0pt; mso-line-height-rule: exactly'><span
				style='font-size: 14.0pt; font-family: 宋体'>□<span lang=EN-US><span
				style='mso-spacerun: yes'>&nbsp; </span></span>变更活动地域<span lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="45%"
				style='width: 45.68%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 18.0pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 25.0pt; mso-line-height-rule: exactly'><span
				style='font-size: 14.0pt; font-family: 宋体'><span> 
				<select name='变更活动地域' id="changeType2" style="width: 98%" disabled="disabled"/>
					<option dataset="changesStatusSelect"></option>
				</select></span></p>
			</td>
			<td width="20%" valign=top
				style='width: 20.34%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 18.0pt'>
			<p class=MsoNormal
				style='line-height: 25.0pt; mso-line-height-rule: exactly'>
				<span> 
				<label class='label3'  id="changeDate2" style="width: 98%" /></span></p>
			</td>
		</tr>
		<tr style='height: 18.0pt'>
			<td width="33%"
				style='width: 33.98%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 18.0pt'>
			<p class=MsoNormal
				style='line-height: 25.0pt; mso-line-height-rule: exactly'><span
				style='font-size: 14.0pt; font-family: 宋体'>□<span lang=EN-US><span
				style='mso-spacerun: yes'>&nbsp; </span></span>变更业务范围<span lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="45%"
				style='width: 45.68%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 18.0pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 25.0pt; mso-line-height-rule: exactly'><span
				style='font-size: 14.0pt; font-family: 宋体'><span> 
				<select name='变更业务范围' id="changeType3" style="width: 98%" disabled="disabled"/>
					<option dataset="changesStatusSelect"></option>
				</select></span></p>
			</td>
			<td width="20%" valign=top
				style='width: 20.34%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 18.0pt'>
			<p class=MsoNormal
				style='line-height: 25.0pt; mso-line-height-rule: exactly'>
				<span> 
				<label class='label3'  id="changeDate3" style="width: 98%" /></span></p>
			</td>
		</tr>
		<tr style='height: 18.0pt'>
			<td width="33%"
				style='width: 33.98%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 18.0pt'>
			<p class=MsoNormal
				style='line-height: 25.0pt; mso-line-height-rule: exactly'><span
				style='font-size: 14.0pt; font-family: 宋体'>□<span lang=EN-US><span
				style='mso-spacerun: yes'>&nbsp; </span></span>变更住所<span lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="45%"
				style='width: 45.68%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 18.0pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 25.0pt; mso-line-height-rule: exactly'><span
				style='font-size: 14.0pt; font-family: 宋体'><span> 
				<select name='变更住所' id="changeType4" style="width: 98%" disabled="disabled"/>
					<option dataset="changesStatusSelect"></option>
				</select></span></p>
			</td>
			<td width="20%" valign=top
				style='width: 20.34%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 18.0pt'>
			<p class=MsoNormal
				style='line-height: 25.0pt; mso-line-height-rule: exactly'>
				<span> 
				<label class='label3'  id="changeDate4" style="width: 98%" /></span></p>
			</td>
		</tr>
		<tr style='height: 18.0pt'>
			<td width="33%"
				style='width: 33.98%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 18.0pt'>
			<p class=MsoNormal
				style='line-height: 25.0pt; mso-line-height-rule: exactly'><span
				style='font-size: 14.0pt; font-family: 宋体'>□<span lang=EN-US><span
				style='mso-spacerun: yes'>&nbsp; </span></span>变更注册资金<span lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="45%"
				style='width: 45.68%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 18.0pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 25.0pt; mso-line-height-rule: exactly'><span
				style='font-size: 14.0pt; font-family: 宋体'><span> 
				<select name='变更注册资金' id="changeType5" style="width: 98%" disabled="disabled"/>
					<option dataset="changesStatusSelect"></option>
				</select></span></p>
			</td>
			<td width="20%" valign=top
				style='width: 20.34%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 18.0pt'>
			<p class=MsoNormal
				style='line-height: 25.0pt; mso-line-height-rule: exactly'>
				<span> 
				<label class='label3'  id="changeDate5" style="width: 98%" /></span></p>
			</td>
		</tr>
		<tr style='height: 18.0pt'>
			<td width="33%"
				style='width: 33.98%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 18.0pt'>
			<p class=MsoNormal
				style='line-height: 25.0pt; mso-line-height-rule: exactly'><span
				style='font-size: 14.0pt; font-family: 宋体'>□<span lang=EN-US><span
				style='mso-spacerun: yes'>&nbsp; </span></span>变更法定代表人<span lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="45%"
				style='width: 45.68%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 18.0pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 25.0pt; mso-line-height-rule: exactly'><span
				style='font-size: 14.0pt; font-family: 宋体'><span> 
				<select name='变更法定代表人' id="changeType6" style="width: 98%" disabled="disabled"/>
					<option dataset="changesStatusSelect"></option>
				</select></span></p>
			</td>
			<td width="20%" valign=top
				style='width: 20.34%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 18.0pt'>
			<p class=MsoNormal
				style='line-height: 25.0pt; mso-line-height-rule: exactly'>
				<span> 
				<label class='label3'  id="changeDate6" style="width: 98%" /></span></p>
			</td>
		</tr>
		<tr style='height: 18.0pt'>
			<td width="33%"
				style='width: 33.98%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 18.0pt'>
			<p class=MsoNormal
				style='line-height: 25.0pt; mso-line-height-rule: exactly'><span
				style='font-size: 14.0pt; font-family: 宋体'>□<span lang=EN-US><span
				style='mso-spacerun: yes'>&nbsp; </span></span>变更业务主管单位<span lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="45%"
				style='width: 45.68%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 18.0pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 25.0pt; mso-line-height-rule: exactly'><span
				style='font-size: 14.0pt; font-family: 宋体'><span> 
				<select name='变更业务主管单位' id="changeType7" style="width: 98%" disabled="disabled"/>
					<option dataset="changesStatusSelect"></option>
				</select></span></p>
			</td>
			<td width="20%" valign=top
				style='width: 20.34%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 18.0pt'>
			<p class=MsoNormal
				style='line-height: 25.0pt; mso-line-height-rule: exactly'>
				<span> 
				<label class='label3'  id="changeDate7" style="width: 98%" /></span></p>
			</td>
		</tr>
		<tr style='height: 18.0pt'>
			<td width="33%"
				style='width: 33.98%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 18.0pt'>
			<p class=MsoNormal
				style='line-height: 25.0pt; mso-line-height-rule: exactly'><span
				style='font-size: 14.0pt; font-family: 宋体'>□<span lang=EN-US><span
				style='mso-spacerun: yes'>&nbsp; </span></span>修改章程<span lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="45%"
				style='width: 45.68%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 18.0pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 25.0pt; mso-line-height-rule: exactly'><span
				style='font-size: 14.0pt; font-family: 宋体'><span> 
				<select name='变更章程' id="changeType8" style="width: 98%" disabled="disabled"/>
					<option dataset="changesStatusSelect"></option>
				</select></span></p>
			</td>
			<td width="20%" valign=top
				style='width: 20.34%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 18.0pt'>
			<p class=MsoNormal
				style='line-height: 25.0pt; mso-line-height-rule: exactly'>
				<span> 
				<label class='label3'  id="changeDate8" style="width: 98%" /></span></p>
			</td>
		</tr>
		<tr style='mso-yfti-lastrow: yes; height: 18.0pt'>
			<td width="33%"
				style='width: 33.98%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: .5pt; mso-border-left-alt: 1.5pt; mso-border-bottom-alt: 1.5pt; mso-border-right-alt: .5pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid; padding: 0cm 5.4pt 0cm 5.4pt; height: 18.0pt'>
			<p class=MsoNormal
				style='line-height: 25.0pt; mso-line-height-rule: exactly'><span
				style='font-size: 14.0pt; font-family: 宋体'>□<span lang=EN-US><span
				style='mso-spacerun: yes'>&nbsp; </span></span>负责人变更<span lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="45%"
				style='width: 45.68%; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 18.0pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 25.0pt; mso-line-height-rule: exactly'><span
				style='font-size: 14.0pt; font-family: 宋体'><span> 
				<select name='变更负责人' id="changeType9" style="width: 98%" disabled="disabled"/>
					<option dataset="changesStatusSelect"></option>
				</select></span></p>
			</td>
			<td width="20%" valign=top
				style='width: 20.34%; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 18.0pt'>
			<p class=MsoNormal
				style='line-height: 25.0pt; mso-line-height-rule: exactly'>
				<span> 
				<label class='label3'  id="changeDate9" style="width: 98%" /></span></p>
			</td>
		</tr>
	</table>
</form>
<form method="post" dataset=somCheckMeetingElectionDataSet onsubmit="return false">
	<p class=MsoNormal><b style='mso-bidi-font-weight: normal'><span
		style='font-size: 16.0pt; font-family: 宋体'>（二）本年度会议及换届情况<span
		lang=EN-US><o:p></o:p></span></span></b></p>

	<table cellspacing=0 cellpadding=0 width="800">
		<thead>
			<tr style='height: 23.25pt'>
				<td width="34%" colspan=2
					style='width: 34.06%; border-top: 1.5pt; border-left: 1.5pt; border-bottom: 1.0pt; border-right: 1.0pt; border-color: windowtext; border-style: solid; mso-border-top-alt: 1.5pt; mso-border-left-alt: 1.5pt; mso-border-bottom-alt: .5pt; mso-border-right-alt: .5pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid; padding: 0cm 5.4pt 0cm 5.4pt; height: 23.25pt'>
				<p class=MsoNormal align=center
					style='text-align: center; layout-grid-mode: char; mso-layout-grid-align: none'><span
					style='font-size: 14.0pt; font-family: 宋体'>章程规定<span
					lang=EN-US><o:p></o:p></span></span></p>
				</td>
				<td width="65%"
					style='width: 65.94%; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: 1.5pt; mso-border-left-alt: .5pt; mso-border-bottom-alt: .5pt; mso-border-right-alt: 1.5pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid; padding: 0cm 5.4pt 0cm 5.4pt; height: 23.25pt'>
				<p class=MsoNormal align=center
					style='text-align: center; layout-grid-mode: char; mso-layout-grid-align: none'><span
					style='font-size: 14.0pt; font-family: 宋体'>换届或会议情况<span
					lang=EN-US><o:p></o:p></span></span></p>
				</td>
			</tr>
		</thead>
		<tr style='height: 23.25pt'>
			<td width="34%" colspan=2
				style='width: 34.06%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 23.25pt'>
			<p class=MsoNormal
				style='layout-grid-mode: char; mso-layout-grid-align: none'><span
				style='font-size: 14.0pt; font-family: 宋体'>会员（代表）大会（<span
				lang=EN-US><label class='label3'  name='章程规定换届年数' field="generalElectionYears" style="width: 50;text-align:center"></label><span style='mso-spacerun: yes'></span></span>）年一届<span
				lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="65%"
				style='width: 65.94%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 23.25pt'>
			<p class=MsoNormal
				style='layout-grid-mode: char; mso-layout-grid-align: none'><span
				style='font-size: 14.0pt; font-family: 宋体'>最近一次换届大会时间为
				（<label class='label3'  name='最近一次换届大会时间' field="electionMeetingTime" style="width: 80"></label>）</span></p>
			</td>
		</tr>
		<tr style='height: 23.25pt'>
			<td width="34%" colspan=2
				style='width: 34.06%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 23.25pt'>
			<p class=MsoNormal
				style='layout-grid-mode: char; mso-layout-grid-align: none'><span
				style='font-size: 14.0pt; font-family: 宋体'>理事会（<span
				lang=EN-US><span style='mso-spacerun: yes'>
			</span></span><label class='label3'  name='章程规定理事会年数' field="orderCouncilYears" style="width: 50;text-align:center" maxlength="10"></label>）年（<span lang=EN-US><span style='mso-spacerun: yes'>
			</span></span><label class='label3'  type="text" name='章程规定理事会次数' field="orderCouncilTimes" style="width: 50;text-align:center" maxlength="10"></label>）次<span lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="65%"
				style='width: 65.94%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 23.25pt'>
			<p class=MsoNormal
				style='layout-grid-mode: char; mso-layout-grid-align: none'><span
				style='font-size: 14.0pt; font-family: 宋体'>本年度召开理事会（<span
				lang=EN-US><span style='mso-spacerun: yes'></span></span><label class='label3'  name='开理事会次数' field="councilTimes" style="width: 50;text-align:center" maxlength="10"></label>）次<span
				lang=EN-US><o:p></o:p></span></span></p>
			</td>
		</tr>
		<tr style='height: 23.25pt'>
			<td width="34%" colspan=2
				style='width: 34.06%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 23.25pt'>
			<p class=MsoNormal
				style='layout-grid-mode: char; mso-layout-grid-align: none'><span
				style='font-size: 14.0pt; font-family: 宋体'>常务理事会（<span
				lang=EN-US><span style='mso-spacerun: yes'>
			</span></span><label class='label3'  name='章程规定常务理事会年数' field="orderGeneralcouncilYears" style="width: 50;text-align:center" maxlength="10" ></label>）年（<span lang=EN-US><span style='mso-spacerun: yes'>
			</span></span><label class='label3'  name='章程规定常务理事会次数' field="orderGeneralcouncilTimes" style="width: 50;text-align:center" maxlength="10" ></label>）次<span lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="65%"
				style='width: 65.94%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 23.25pt'>
			<p class=MsoNormal
				style='layout-grid-mode: char; mso-layout-grid-align: none'><span
				style='font-size: 14.0pt; font-family: 宋体'>本年度召开常务理事会（<span
				lang=EN-US><span style='mso-spacerun: yes'></span></span><label class='label3'  name='召开常务理事会次数' field="generalcouncilTimes" style="width: 50;text-align:center" maxlength="10" ></label>）次<span
				lang=EN-US><o:p></o:p></span></span></p>
			</td>
		</tr>
		<tr style='mso-yfti-lastrow: yes; height: 126.5pt'>
			<td width="16%"
				style='width: 16.88%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: .5pt; mso-border-left-alt: 1.5pt; mso-border-bottom-alt: 1.5pt; mso-border-right-alt: .5pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid; padding: 0cm 5.4pt 0cm 5.4pt; height: 126.5pt'>
			<p class=MsoNormal
				style='layout-grid-mode: char; mso-layout-grid-align: none'><span
				style='font-size: 14.0pt; font-family: 宋体'>未按章程规定如期、如数召开换届大会、理事会、常务理事会的原因<span
				lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="83%" colspan=2
				style='width: 83.12%; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 126.5pt'>
			<p class=MsoNormal
				style='layout-grid-mode: char; mso-layout-grid-align: none'><span
				lang=EN-US style='font-size: 14.0pt; font-family: 宋体'><span> 
				<textarea name='未召开原因' field="reason" style="width: 655" rows="10" readonly="readonly"></textarea></span></p>
			</td>
		</tr>
		<![if !supportMisalignedColumns]>
		<tr height=0>
			<td width=126 style='border: none'></td>
			<td width=128 style='border: none'></td>
			<td width=492 style='border: none'></td>
		</tr>
		<![endif]>
	</table>
</form>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</div>
</div>
</div>