<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>

<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<title>社 会 团 体</title>
<%
	String taskCode = (String) request.getParameter("taskCode");
%>
<next:ScriptManager />
<script type="text/javascript" src="../../js/float.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
<link href="../../css/float.css" type="text/css" rel="stylesheet" />
<script language="javascript">
	var taskCode='<%=taskCode%>';
	//初始化
	function init(){
		createGroupEditSelect();
		somCheckChangesDataSet.setParameter("TASK_CODE@=", taskCode);
		somCheckChangesDataSet.load();
		somCheckChangesDataSet.on("load",function(ds){
			if(ds.getCount()<1){
				somCheckChangesDataSet.newRecord({"taskCode":taskCode});
			}else{
				for(i=1;i<=ds.getCount();i++){
					var type = ds.getAt(i-1).get("type");
					document.getElementById("changeType"+type).value=ds.getAt(i-1).get("dealStatus");
					document.getElementById("changeDate"+type).value=ds.getAt(i-1).get("approveDate");
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
	//保存
	function save(){
		var command = new L5.Command("com.inspur.cams.sorg.check.somcheck.cmd.SomCheckCommand");
		somCheckChangesDataSet.removeAll();
		for(i=1;i<10;i++){
			var checkChangeRecord = somCheckChangesDataSet.newRecord();
			checkChangeRecord.set("taskCode",taskCode);
			checkChangeRecord.set("type",i);
			checkChangeRecord.set("dealStatus",document.getElementById("changeType"+i).value);
			checkChangeRecord.set("approveDate",document.getElementById("changeDate"+i).value);
			var dealStatus=document.getElementById("changeType"+i).value;
			var approveDate=document.getElementById("changeDate"+i).value;
			if(dealStatus==""){
				L5.Msg.alert("提示","请填写办理情况！");
				return "break";
			}			
			if(dealStatus=="0"&&approveDate==""){//已办理
				L5.Msg.alert("提示","请填写批准时间！");
				return "break";
			}
		}
		command.setParameter("checkChangesRecords", somCheckChangesDataSet.getAllRecords());
		
		var somCheckMeetingElectionDataSetIsValidate = somCheckMeetingElectionDataSet.isValidate();
		if(somCheckMeetingElectionDataSetIsValidate!=true){
			L5.Msg.alert("提示",somCheckMeetingElectionDataSetIsValidate);
			return "break";
		}
		var checkMeetingElectionRecord=somCheckMeetingElectionDataSet.getCurrent();
		command.setParameter("checkMeetingElectionRecord", checkMeetingElectionRecord);
		command.setParameter("taskCode",taskCode);
		command.execute("savePage3");
		if (!command.error) {
			alert("保存成功！");	
		}else{
			L5.Msg.alert('提示',"保存时出现错误！"+command.error);
		}
	}
	function saveNoCheck(){
		var command = new L5.Command("com.inspur.cams.sorg.check.somcheck.cmd.SomCheckCommand");
		somCheckChangesDataSet.removeAll();
		for(i=1;i<10;i++){
			var checkChangeRecord = somCheckChangesDataSet.newRecord();
			checkChangeRecord.set("taskCode",taskCode);
			checkChangeRecord.set("type",i);
			checkChangeRecord.set("dealStatus",document.getElementById("changeType"+i).value);
			checkChangeRecord.set("approveDate",document.getElementById("changeDate"+i).value);
		}
		command.setParameter("checkChangesRecords", somCheckChangesDataSet.getAllRecords());
		
		var checkMeetingElectionRecord=somCheckMeetingElectionDataSet.getCurrent();
		command.setParameter("checkMeetingElectionRecord", checkMeetingElectionRecord);
		command.setParameter("taskCode",taskCode);
		command.execute("savePage3");
		if (!command.error) {
			alert("保存成功！");	
		}else{
			L5.Msg.alert('提示',"保存时出现错误！"+command.error);
		}
	}
</script>
<style>
textarea {
	overflow: hidden;
}
</style>
</head>
<body>
<model:datasets>
	<!-- 变更情况 -->
	<model:dataset id="somCheckChangesDataSet" cmd="com.inspur.cams.sorg.check.checkchanges.cmd.SomCheckChangesQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.checkchanges.data.SomCheckChanges"></model:record>
	</model:dataset>
	<!-- 本年度会议及换届情况 -->
	<model:dataset id="somCheckMeetingElectionDataSet" cmd="com.inspur.cams.sorg.check.checkmeetingelection.cmd.SomCheckMeetingElectionQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.checkmeetingelection.data.SomCheckMeetingElection">
			<model:field name="generalElectionYears" type="string" rule="require" />
			<model:field name="electionMeetingTime" type="string" rule="require" />
			<model:field name="orderCouncilYears" type="string" rule="require" />			
			<model:field name="orderCouncilTimes" type="string" rule="require" />
			<model:field name="councilTimes" type="string" rule="require" />
			<model:field name="orderGeneralcouncilYears" type="string" rule="require" />
			<model:field name="orderGeneralcouncilTimes" type="string" rule="require" />
			<model:field name="generalcouncilTimes" type="string" rule="require" />
			<model:field name="reason" type="string" rule="require" />
		</model:record>
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
<div id="float">
	<input type="button" value="上一页" style="height: 25px; width: 80px; position: absolute; margin-left: 20px;" onclick="lastPage('2');"/>
	<input type="button" value="下一页" style="height: 25px; width: 80px; position: absolute; margin-left: 120px;" onclick="nextPage('4');"/>
	<input type="button" value="保存" style="height: 25px; width: 80px; position: absolute; margin-left: 220px;" onclick="saveNoCheck();" /> 
	<input type="button" value="返回" style="height: 25px; width: 80px; position: absolute; margin-left: 320px;" onclick="back();" />
	<!--[if lte IE 7]><div></div><![endif]-->
	<span style="height:25px;width:80px;position:absolute;margin-left:420px;">当前页数：5</span>
</div>
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
				<select name='变更名称' id="changeType1" style="width: 98%" />
					<option dataset="changesStatusSelect"></option>
				</select></span></p>
			</td>
			<td width="20%" valign=top
				style='width: 20.34%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 18.0pt'>
				<input type="text" id="changeDate1" name='参加时间'  onClick="WdatePicker()" style="width:98%"/>
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
				<select name='变更活动地域' id="changeType2" style="width: 98%" />
					<option dataset="changesStatusSelect"></option>
				</select></span></p>
			</td>
			<td width="20%" valign=top
				style='width: 20.34%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 18.0pt'>
			<p class=MsoNormal
				style='line-height: 25.0pt; mso-line-height-rule: exactly'><b
				style='mso-bidi-font-weight: normal'><span> 
				<input type="text" id="changeDate2" name='参加时间'  onClick="WdatePicker()" style="width:98%"/>
				</span></p>
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
				<select name='变更业务范围' id="changeType3" style="width: 98%" />
					<option dataset="changesStatusSelect"></option>
				</select></span></p>
			</td>
			<td width="20%" valign=top
				style='width: 20.34%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 18.0pt'>
			<p class=MsoNormal
				style='line-height: 25.0pt; mso-line-height-rule: exactly'><b
				style='mso-bidi-font-weight: normal'><span> 
				<input type="text" id="changeDate3" name='参加时间'  onClick="WdatePicker()" style="width:98%"/>
				</span></p>
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
				<select name='变更住所' id="changeType4" style="width: 98%" />
					<option dataset="changesStatusSelect"></option>
				</select></span></p>
			</td>
			<td width="20%" valign=top
				style='width: 20.34%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 18.0pt'>
			<p class=MsoNormal
				style='line-height: 25.0pt; mso-line-height-rule: exactly'><b
				style='mso-bidi-font-weight: normal'><span> 
				<input type="text" id="changeDate4" name='参加时间'  onClick="WdatePicker()" style="width:98%"/>
				</span></p>
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
				<select name='变更注册资金' id="changeType5" style="width: 98%" />
					<option dataset="changesStatusSelect"></option>
				</select></span></p>
			</td>
			<td width="20%" valign=top
				style='width: 20.34%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 18.0pt'>
			<p class=MsoNormal
				style='line-height: 25.0pt; mso-line-height-rule: exactly'><b
				style='mso-bidi-font-weight: normal'><span> 
				<input type="text" id="changeDate5" name='参加时间'  onClick="WdatePicker()" style="width:98%"/>
				</span></p>
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
				<select name='变更法定代表人' id="changeType6" style="width: 98%" />
					<option dataset="changesStatusSelect"></option>
				</select></span></p>
			</td>
			<td width="20%" valign=top
				style='width: 20.34%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 18.0pt'>
			<p class=MsoNormal
				style='line-height: 25.0pt; mso-line-height-rule: exactly'><b
				style='mso-bidi-font-weight: normal'><span> 
				<input type="text" id="changeDate6" name='参加时间'  onClick="WdatePicker()" style="width:98%"/>
				</span></p>
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
				<select name='变更业务主管单位' id="changeType7" style="width: 98%" />
					<option dataset="changesStatusSelect"></option>
				</select></span></p>
			</td>
			<td width="20%" valign=top
				style='width: 20.34%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 18.0pt'>
			<p class=MsoNormal
				style='line-height: 25.0pt; mso-line-height-rule: exactly'><b
				style='mso-bidi-font-weight: normal'><span> 
				<input type="text" id="changeDate7" name='参加时间'  onClick="WdatePicker()" style="width:98%"/>
				</span></p>
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
				<select name='变更章程' id="changeType8" style="width: 98%" />
					<option dataset="changesStatusSelect"></option>
				</select></span></p>
			</td>
			<td width="20%" valign=top
				style='width: 20.34%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 18.0pt'>
			<p class=MsoNormal
				style='line-height: 25.0pt; mso-line-height-rule: exactly'><b
				style='mso-bidi-font-weight: normal'><span> 
				<input type="text" id="changeDate8" name='参加时间'  onClick="WdatePicker()" style="width:98%"/>
				</span></p>
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
				<select name='变更负责人' id="changeType9" style="width: 98%" />
					<option dataset="changesStatusSelect"></option>
				</select></span></p>
			</td>
			<td width="20%" valign=top
				style='width: 20.34%; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 18.0pt'>
			<p class=MsoNormal
				style='line-height: 25.0pt; mso-line-height-rule: exactly'><b
				style='mso-bidi-font-weight: normal'><span> 
				<input type="text" id="changeDate9" name='参加时间'  onClick="WdatePicker()" style="width:98%"/>
				</span></p>
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
				lang=EN-US><input type="text" name='章程规定换届年数' field="generalElectionYears" style="width: 50;text-align:center" maxlength="10" onkeyup="value=value.replace(/[^\d]/g,'') "/><span style='mso-spacerun: yes'></span></span>）年一届<span
				lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="65%"
				style='width: 65.94%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 23.25pt'>
			<p class=MsoNormal
				style='layout-grid-mode: char; mso-layout-grid-align: none'><span
				style='font-size: 14.0pt; font-family: 宋体'>最近一次换届大会时间为
				（<input type="text" id="electionMeetingTime" name='最近一次换届大会时间' field="electionMeetingTime" onClick="WdatePicker()" style="width:98%"/>）</span></p>
			</td>
		</tr>
		<tr style='height: 23.25pt'>
			<td width="34%" colspan=2
				style='width: 34.06%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 23.25pt'>
			<p class=MsoNormal
				style='layout-grid-mode: char; mso-layout-grid-align: none'><span
				style='font-size: 14.0pt; font-family: 宋体'>理事会（<span
				lang=EN-US><span style='mso-spacerun: yes'>
			</span></span><input type="text" name='章程规定理事会年数' field="orderCouncilYears" style="width: 50;text-align:center" maxlength="10" />）年（<span lang=EN-US><span style='mso-spacerun: yes'>
			</span></span><input type="text" name='章程规定理事会次数' field="orderCouncilTimes" style="width: 50;text-align:center" maxlength="10" onkeyup="value=value.replace(/[^\d]/g,'') "/>）次<span lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="65%"
				style='width: 65.94%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 23.25pt'>
			<p class=MsoNormal
				style='layout-grid-mode: char; mso-layout-grid-align: none'><span
				style='font-size: 14.0pt; font-family: 宋体'>本年度召开理事会（<span
				lang=EN-US><span style='mso-spacerun: yes'></span></span><input type="text" name='开理事会次数' field="councilTimes" style="width: 50;text-align:center" maxlength="10" onkeyup="value=value.replace(/[^\d]/g,'') "/>）次<span
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
			</span></span><input type="text" name='章程规定常务理事会年数' field="orderGeneralcouncilYears" style="width: 50;text-align:center" maxlength="10" />）年（<span lang=EN-US><span style='mso-spacerun: yes'>
			</span></span><input type="text" name='章程规定常务理事会次数' field="orderGeneralcouncilTimes" style="width: 50;text-align:center" maxlength="10" onkeyup="value=value.replace(/[^\d]/g,'') "/>）次<span lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="65%"
				style='width: 65.94%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 23.25pt'>
			<p class=MsoNormal
				style='layout-grid-mode: char; mso-layout-grid-align: none'><span
				style='font-size: 14.0pt; font-family: 宋体'>本年度召开常务理事会（<span
				lang=EN-US><span style='mso-spacerun: yes'></span></span>
				<input type="text" name='召开常务理事会次数' field="generalcouncilTimes" style="width: 50;text-align:center" maxlength="10" 
				onkeyup="value=value.replace(/[^\d]/g,'') "/>）次<span
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
				<textarea name='未召开原因' field="reason" style="width: 655" rows="10"></textarea></span></p>
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
</body>
</html>