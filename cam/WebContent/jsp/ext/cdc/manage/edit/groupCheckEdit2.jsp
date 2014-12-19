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
		createGroupEditSelect();
		somCheckWorkerDataSet.setParameter("TASK_CODE@=", taskCode);
		somCheckWorkerDataSet.load();
		somCheckWorkerDataSet.on("load",function(ds){
			if(ds.getCount()==0){
				somCheckWorkerDataSet.newRecord({"taskCode":taskCode});
			}else{
				document.getElementById("totalNum").value = ds.get("totalNum");
				document.getElementById("fullPeopleNum").value = ds.get("fullPeopleNum");
				document.getElementById("partPeopleNum").value = ds.get("partPeopleNum");
				document.getElementById("returnmentNum").value = ds.get("returnmentNum");
				document.getElementById("volunterNum").value = ds.get("volunterNum");
				document.getElementById("volunterPeriod").value = ds.get("volunterPeriod");
				document.getElementById("fullPartyNum").value = ds.get("fullPartyNum");
				document.getElementById("ifBuildParty").value = ds.get("ifBuildParty");
			}
		});
		somCheckOrgDetailDataSet.setParameter("TASK_CODE@=", taskCode);
		somCheckOrgDetailDataSet.load();
		somCheckOrgDetailDataSet.on("load",function(ds){
			if(ds.getCount()==0){
				somCheckOrgDetailDataSet.newRecord({"taskCode":taskCode});
			}else{
				document.getElementById("branchNum").value = ds.get("branchNum");
				document.getElementById("delegateNum").value = ds.get("delegateNum");
				document.getElementById("specialFundNum").value = ds.get("specialFundNum");
				document.getElementById("workingNum").value = ds.get("workingNum");
			}
		});
		somCheckPublicationDataSet.setParameter("TASK_CODE@=", taskCode);
		somCheckPublicationDataSet.load();
		somCheckPublicationDataSet.on("load",function(ds){
			if(ds.getCount()==0){
				somCheckPublicationDataSet.newRecord({"taskCode":taskCode});
			}else{
				document.getElementById("publicationNum").value = ds.get("publicationNum");
				document.getElementById("innerPublicationNum").value = ds.get("innerPublicationNum");
				document.getElementById("publicationName").value = ds.get("publicationName");
			}
		});
		somCheckDuesDataSet.setParameter("TASK_CODE@=", taskCode);
		somCheckDuesDataSet.load();
		somCheckDuesDataSet.on("load",function(ds){
			if(ds.getCount()==0){
				somCheckDuesDataSet.newRecord({"taskCode":taskCode});
			}else{
				document.getElementById("makeFeeDate").value = ds.get("makeFeeDate");
				document.getElementById("regFeeType").value = ds.get("regFeeType");
				document.getElementById("meetingName").value = ds.get("meetingName");
				document.getElementById("feeRule").value = ds.get("feeRule");
			}
		});
	}
	//保存
	function save(){
		var checkWorkerRecord=somCheckWorkerDataSet.getCurrent();
		checkWorkerRecord.set("totalNum",document.getElementById("totalNum").value);
		checkWorkerRecord.set("fullPeopleNum",document.getElementById("fullPeopleNum").value);
		checkWorkerRecord.set("partPeopleNum",document.getElementById("partPeopleNum").value);
		checkWorkerRecord.set("returnmentNum",document.getElementById("returnmentNum").value);
		checkWorkerRecord.set("volunterNum",document.getElementById("volunterNum").value);
		checkWorkerRecord.set("volunterPeriod",document.getElementById("volunterPeriod").value);
		checkWorkerRecord.set("fullPartyNum",document.getElementById("fullPartyNum").value);
		checkWorkerRecord.set("ifBuildParty",document.getElementById("ifBuildParty").value);
		
		var checkOrgDetailRecord=somCheckOrgDetailDataSet.getCurrent();
		checkOrgDetailRecord.set("branchNum",document.getElementById("branchNum").value);
		checkOrgDetailRecord.set("delegateNum",document.getElementById("delegateNum").value);
		checkOrgDetailRecord.set("specialFundNum",document.getElementById("specialFundNum").value);
		checkOrgDetailRecord.set("workingNum",document.getElementById("workingNum").value);		
		
		var checkPublicationRecord=somCheckPublicationDataSet.getCurrent();
		checkPublicationRecord.set("publicationNum",document.getElementById("publicationNum").value);
		checkPublicationRecord.set("innerPublicationNum",document.getElementById("innerPublicationNum").value);
		checkPublicationRecord.set("publicationName",document.getElementById("publicationName").value);
		
		var checkDuesRecord=somCheckDuesDataSet.getCurrent();
		checkDuesRecord.set("makeFeeDate",document.getElementById("makeFeeDate").value);
		checkDuesRecord.set("regFeeType",document.getElementById("regFeeType").value);
		checkDuesRecord.set("meetingName",document.getElementById("meetingName").value);
		checkDuesRecord.set("feeRule",document.getElementById("feeRule").value);
		
		var command = new L5.Command("com.inspur.cams.sorg.check.somcheck.cmd.SomCheckCommand");
		command.setParameter("checkWorkerRecord", checkWorkerRecord);
		command.setParameter("checkOrgDetailRecord", checkOrgDetailRecord);
		command.setParameter("checkPublicationRecord", checkPublicationRecord);
		command.setParameter("checkDuesRecord", checkDuesRecord);
		command.setParameter("taskCode",taskCode);
		command.execute("savePage2");
		if (!command.error) {
			L5.Msg.alert("提示","保存成功！",function(){});		
		}else{
			L5.Msg.alert('提示',"保存时出现错误！"+command.error);
		}
	}
	//返回
	function back(){
		var data = new L5.Map();
		var url='jsp/cams/sorg/check/group/somchecktask/somchecktask_list.jsp';
		var text = '年检列表';
		L5.forward(url,text,data);
	}
	//下一页
	function nextPage(){
		save();
		var data = new L5.Map();
		data.put("taskCode",taskCode);
		var url='jsp/cams/sorg/check/group/edit/groupCheckEdit3.jsp';
		var text = '下一页';
		L5.forward(url,text,data);
	}
</script>
</head>

<body>
<model:datasets>
	<!-- 工作人员情况 -->
	<model:dataset id="somCheckWorkerDataSet" cmd="com.inspur.cams.sorg.check.checkworker.cmd.SomCheckWorkerQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.checkworker.data.SomCheckWorker"></model:record>
	</model:dataset>
	<!-- 机构设置情况 -->
	<model:dataset id="somCheckOrgDetailDataSet" cmd="com.inspur.cams.sorg.check.checkorgdetail.cmd.SomCheckOrgDetailQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.checkorgdetail.data.SomCheckOrgDetail"></model:record>
	</model:dataset>
	<!-- 举办刊物情况 -->
	<model:dataset id="somCheckPublicationDataSet" cmd="com.inspur.cams.sorg.check.checkpublication.cmd.SomCheckPublicationQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.checkpublication.data.SomCheckPublication"></model:record>
	</model:dataset>
	<!-- 会费情况 -->
	<model:dataset id="somCheckDuesDataSet" cmd="com.inspur.cams.sorg.check.checkdues.cmd.SomCheckDuesQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.checkdues.data.SomCheckDues"></model:record>
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
	<model:dataset id="yesOrNoSelect" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset> 
</model:datasets>

<!--页面按钮-->
<div id="float">
	<input type="button" value="下一页" style="height: 25px; width: 80px; position: absolute; margin-left: 20px;" onclick="nextPage();"/>
	<input type="button" value="保存" style="height: 25px; width: 80px; position: absolute; margin-left: 120px;" onclick="save();" /> 
	<input type="button" value="返回" style="height: 25px; width: 80px; position: absolute; margin-left: 220px;" onclick="back();" />
</div>
<div align=center>
<!--工作人员情况-->
<form method="post" onsubmit="return false">
	<table cellspacing=0 cellpadding=0 width="800">
		<tr style='page-break-inside: avoid; height: 27.0pt'>
			<td width="14%" rowspan=4
				style='width: 14.1%; border-top: 1.5pt; border-left: 1.5pt; border-bottom: 1.0pt; border-right: 1.0pt; border-color: windowtext; border-style: solid; mso-border-top-alt: 1.5pt; mso-border-left-alt: 1.5pt; mso-border-bottom-alt: .5pt; mso-border-right-alt: .5pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid; padding: 0cm 5.4pt 0cm 5.4pt; height: 27.0pt'>
			<p class=MsoNormal align=center
				style='margin-left: -5.35pt; mso-para-margin-left: -.51gd; text-align: center; line-height: 25.0pt; mso-line-height-rule: exactly'><span
				style='font-size: 14.0pt; font-family: 宋体'>工作人员<span
				lang=EN-US><o:p></o:p></span></span></p>
			<p class=MsoNormal align=center
				style='margin-left: -5.35pt; mso-para-margin-left: -.51gd; text-align: center; line-height: 25.0pt; mso-line-height-rule: exactly'><span
				style='font-size: 14.0pt; font-family: 宋体'>情<span lang=EN-US><span
				style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp; </span></span>况<span lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="37%" colspan=3
				style='width: 37.02%; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 27.0pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 25.0pt; mso-line-height-rule: exactly'><span
				style='font-size: 14.0pt; font-family: 宋体'>工作人员总数<span
				lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="9%"
				style='width: 9.2%; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 27.0pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 25.0pt; mso-line-height-rule: exactly'><span> 
				<input type="text" name='工作人员总数' id="totalNum" style="width: 98%" maxlength="10" /></span></p>
			</td>
			<td width="28%" colspan=5
				style='width: 28.44%; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 1.4pt 0cm 1.4pt; height: 27.0pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 25.0pt; mso-line-height-rule: exactly'><span
				style='font-size: 14.0pt; font-family: 宋体'>专职工作人员数<span
				lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="11%"
				style='width: 11.24%; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: 1.5pt; mso-border-left-alt: .5pt; mso-border-bottom-alt: .5pt; mso-border-right-alt: 1.5pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid; padding: 0cm 5.4pt 0cm 5.4pt; height: 27.0pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 25.0pt; mso-line-height-rule: exactly'><span> 
				<input type="text" name='专职工作人员数' id="fullPeopleNum" style="width: 98%" maxlength="10" /></span></p>
			</td>
		</tr>
		<tr style='page-break-inside: avoid; height: 27.0pt'>
			<td width="37%" colspan=3
				style='width: 37.02%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 27.0pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 25.0pt; mso-line-height-rule: exactly'><span
				style='font-size: 14.0pt; font-family: 宋体'>兼职人员数<span
				lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="9%"
				style='width: 9.2%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 27.0pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 25.0pt; mso-line-height-rule: exactly'><span> 
				<input type="text" name='兼职人员数' id="partPeopleNum" style="width: 98%" maxlength="10" /></span></p>
			</td>
			<td width="28%" colspan=5
				style='width: 28.44%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 1.4pt 0cm 1.4pt; height: 27.0pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 25.0pt; mso-line-height-rule: exactly'><span
				style='font-size: 14.0pt; font-family: 宋体; letter-spacing: -.6pt'>离退休返聘人员数<span
				lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="11%"
				style='width: 11.24%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 27.0pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 25.0pt; mso-line-height-rule: exactly'><span> 
				<input type="text" name='离退休返聘人员数' id="returnmentNum" style="width: 98%" maxlength="10" /></span></p>
			</td>
		</tr>
		<tr style='page-break-inside: avoid; height: 27.0pt'>
			<td width="37%" colspan=3
				style='width: 37.02%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 27.0pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 25.0pt; mso-line-height-rule: exactly'><span
				style='font-size: 14.0pt; font-family: 宋体'>志愿者人数<span
				lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="9%"
				style='width: 9.2%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 27.0pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 25.0pt; mso-line-height-rule: exactly'><span> 
				<input type="text" name='志愿者人数' id="volunterNum" style="width: 98%" maxlength="10" /></span></p>
			</td>
			<td width="28%" colspan=5
				style='width: 28.44%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 27.0pt'>
			<p class=MsoNormal align=center
				style='margin-left: -5.35pt; mso-para-margin-left: -.51gd; text-align: center; line-height: 25.0pt; mso-line-height-rule: exactly'><span
				style='font-size: 14.0pt; font-family: 宋体'>志愿劳动时间<span
				lang=EN-US><o:p></o:p></span></span></p>
			<p class=MsoNormal align=center
				style='margin-left: -5.35pt; mso-para-margin-left: -.51gd; text-align: center; line-height: 25.0pt; mso-line-height-rule: exactly'><span
				lang=EN-US style='font-size: 14.0pt; font-family: 宋体'>(</span><span
				style='font-size: 14.0pt; font-family: 宋体'>小时<span lang=EN-US>)<o:p></o:p></span></span></p>
			</td>
			<td width="11%"
				style='width: 11.24%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 27.0pt'>
			<p class=MsoNormal align=center
				style='margin-left: -5.45pt; mso-para-margin-left: -.52gd; text-align: center; text-indent: .05pt; line-height: 25.0pt; mso-line-height-rule: exactly'><span> 
				<input type="text" name='志愿劳动时间' id="volunterPeriod" style="width: 98%" maxlength="30" /></span></p>
			</td>
		</tr>
		<tr style='page-break-inside: avoid; height: 27.0pt'>
			<td width="37%" colspan=3
				style='width: 37.02%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 1.4pt 0cm 1.4pt; height: 27.0pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 25.0pt; mso-line-height-rule: exactly'><span
				style='font-size: 14.0pt; font-family: 宋体'>专职工作人员中党员人数<span
				lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="9%"
				style='width: 9.2%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 27.0pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 25.0pt; mso-line-height-rule: exactly'><span> 
				<input type="text" name='专职工作人员中党员人数' id="fullPartyNum" style="width: 98%" maxlength="10" /></span></p>
			</td>
			<td width="28%" colspan=5
				style='width: 28.44%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 27.0pt'>
			<p class=MsoNormal align=center
				style='margin-left: -5.35pt; mso-para-margin-left: -.51gd; text-align: center; line-height: 25.0pt; mso-line-height-rule: exactly'><span
				style='font-size: 14.0pt; font-family: 宋体'>党建情况<span
				lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="11%"
				style='width: 11.24%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 27.0pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 25.0pt; mso-line-height-rule: exactly'><span> 
				<select name='党建情况' id="ifBuildParty" style="width: 98%" />
					<option dataset="yesOrNoSelect"></option>
				</select></span></p>
			</td>
		</tr>
<!--机构设置情况-->
		<tr style='page-break-inside: avoid; height: 27.0pt'>
			<td width="14%" rowspan=2
				style='width: 14.1%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext 1.5pt; mso-border-alt: solid windowtext 1.5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 27.0pt'>
			<p class=MsoNormal align=center
				style='margin-left: -5.35pt; mso-para-margin-left: -.51gd; text-align: center; line-height: 25.0pt; mso-line-height-rule: exactly'><span
				style='font-size: 14.0pt; font-family: 宋体'>机构设置<span
				lang=EN-US><o:p></o:p></span></span></p>
			<p class=MsoNormal align=center
				style='margin-left: -5.35pt; mso-para-margin-left: -.51gd; text-align: center; line-height: 25.0pt; mso-line-height-rule: exactly'><span
				style='font-size: 14.0pt; font-family: 宋体'>情<span lang=EN-US><span
				style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp; </span></span>况<span lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="19%" colspan=2
				style='width: 19.48%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext 1.5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 27.0pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 27.0pt; mso-line-height-rule: exactly'><span
				style='font-size: 14.0pt; font-family: 宋体'>分支机构数<span
				lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="17%"
				style='width: 17.54%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext 1.5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 27.0pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 27.0pt; mso-line-height-rule: exactly'><span> 
				<input type="text" name='分支机构数' id="branchNum" style="width: 98%" maxlength="10" /></span></p>
			</td>
			<td width="23%" colspan=4
				style='width: 23.5%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext 1.5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 27.0pt'>
			<p class=MsoNormal align=center
				style='margin-left: -5.35pt; mso-para-margin-left: -.51gd; text-align: center; line-height: 27.0pt; mso-line-height-rule: exactly'><span
				style='font-size: 14.0pt; font-family: 宋体'>代表机构数<span
				lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="25%" colspan=3
				style='width: 25.38%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext 1.5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: 1.5pt; mso-border-left-alt: .5pt; mso-border-bottom-alt: .5pt; mso-border-right-alt: 1.5pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid; padding: 0cm 5.4pt 0cm 5.4pt; height: 27.0pt'>
			<p class=MsoNormal
				style='line-height: 27.0pt; mso-line-height-rule: exactly'><span> 
				<input type="text" name='代表机构数' id="delegateNum" style="width: 98%" maxlength="10" /></span></p>
			</td>
		</tr>
		<tr style='page-break-inside: avoid; height: 27.0pt'>
			<td width="37%" colspan=3
				style='width: 37.02%; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 27.0pt'>
			<p class=MsoNormal align=center
				style='text-align: center; text-indent: 7.0pt; mso-char-indent-count: .5; line-height: 27.0pt; mso-line-height-rule: exactly'><span
				style='font-size: 14.0pt; font-family: 宋体'>专项基金管理机构数<span
				lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="11%" colspan=2
				style='width: 11.06%; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 27.0pt'>
			<p class=MsoNormal align=center
				style='margin-left: -5.35pt; mso-para-margin-left: -.51gd; text-align: center; line-height: 27.0pt; mso-line-height-rule: exactly'><span> 
				<input type="text" name='专项基金管理机构数' id="specialFundNum" style="width: 98%" maxlength="10" /></span></p>
			</td>
			<td width="18%" colspan=3
				style='width: 18.72%; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 27.0pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 27.0pt; mso-line-height-rule: exactly'><span
				style='font-size: 14.0pt; font-family: 宋体'>办事机构数<span
				lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="19%" colspan=2 valign=top
				style='width: 19.1%; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 27.0pt'>
			<p class=MsoNormal
				style='line-height: 27.0pt; mso-line-height-rule: exactly'><span> 
				<input type="text" name='办事机构数' id="workingNum" style="width: 98%" maxlength="10" /></span></p>
			</td>
		</tr>
<!--举办刊物情况-->
		<tr style='page-break-inside: avoid; height: 69.35pt'>
			<td width="14%" rowspan=2
				style='width: 14.1%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext 1.5pt; mso-border-alt: solid windowtext 1.5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 69.35pt'>
			<p class=MsoNormal align=center
				style='margin-left: -5.35pt; mso-para-margin-left: -.51gd; text-align: center; line-height: 25.0pt; mso-line-height-rule: exactly'><span
				style='font-size: 14.0pt; font-family: 宋体'>举办刊物<span
				lang=EN-US><o:p></o:p></span></span></p>
			<p class=MsoNormal align=center
				style='margin-left: -5.35pt; mso-para-margin-left: -.51gd; text-align: center; line-height: 25.0pt; mso-line-height-rule: exactly'><span
				style='font-size: 14.0pt; font-family: 宋体'>情<span lang=EN-US><span
				style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp; </span></span>况<span lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="37%" colspan=3
				style='width: 37.02%; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext 1.5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: 1.5pt; mso-border-left-alt: .5pt; mso-border-bottom-alt: 1.5pt; mso-border-right-alt: .5pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid; padding: 0cm 5.4pt 0cm 5.4pt; height: 69.35pt'>
			<p class=MsoNormal align=center
				style='margin-left: -5.35pt; mso-para-margin-left: -.51gd; text-align: center; line-height: 27.0pt; mso-line-height-rule: exactly'><span
				style='font-size: 14.0pt; font-family: 宋体'>公开发行的刊物数<span
				lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="11%" colspan=2
				style='width: 11.06%; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext 1.5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: 1.5pt; mso-border-left-alt: .5pt; mso-border-bottom-alt: 1.5pt; mso-border-right-alt: .5pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid; padding: 0cm 5.4pt 0cm 5.4pt; height: 69.35pt'>
			<p class=MsoNormal align=center
				style='margin-left: -5.35pt; mso-para-margin-left: -.51gd; text-align: center; line-height: 27.0pt; mso-line-height-rule: exactly'><span> 
				<input type="text" name='公开发行的刊物数' id="publicationNum" style="width: 98%" maxlength="10" /></span></p>
			</td>
			<td width="18%" colspan=3
				style='width: 18.72%; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext 1.5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: 1.5pt; mso-border-left-alt: .5pt; mso-border-bottom-alt: 1.5pt; mso-border-right-alt: .5pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid; padding: 0cm 5.4pt 0cm 5.4pt; height: 69.35pt'>
			<p class=MsoNormal align=center
				style='margin-left: -5.35pt; mso-para-margin-left: -.51gd; text-align: center; line-height: 27.0pt; mso-line-height-rule: exactly'><span
				style='font-size: 14.0pt; font-family: 宋体'>内部资料性<span
				lang=EN-US><o:p></o:p></span></span></p>
			<p class=MsoNormal align=center
				style='margin-left: -5.35pt; mso-para-margin-left: -.51gd; text-align: center; line-height: 27.0pt; mso-line-height-rule: exactly'><span
				style='font-size: 14.0pt; font-family: 宋体'>刊<span lang=EN-US><span
				style='mso-spacerun: yes'>&nbsp; </span></span>物<span lang=EN-US><span
				style='mso-spacerun: yes'>&nbsp; </span></span>数<span lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="19%" colspan=2 valign=top
				style='width: 19.1%; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext 1.5pt; mso-border-left-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 69.35pt'>
			<p class=MsoNormal
				style='line-height: 27.0pt; mso-line-height-rule: exactly'><span> 
				<input type="text" name='内部资料性刊物数' id="innerPublicationNum" style="width: 98%" maxlength="10" /></span></p>
			</td>
		</tr>
		<tr style='page-break-inside: avoid; height: 27.0pt'>
			<td width="37%" colspan=3
				style='width: 37.02%; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext 1.5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: 1.5pt; mso-border-left-alt: .5pt; mso-border-bottom-alt: 1.5pt; mso-border-right-alt: .5pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid; padding: 0cm 5.4pt 0cm 5.4pt; height: 27.0pt'>
			<p class=MsoNormal align=center
				style='margin-left: -5.35pt; mso-para-margin-left: -.51gd; text-align: center; line-height: 27.0pt; mso-line-height-rule: exactly'><span
				style='font-size: 14.0pt; font-family: 宋体'>公开发行的刊物名称<span
				lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="48%" colspan=7
				style='width: 48.88%; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext 1.5pt; mso-border-left-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 27.0pt'>
			<p class=MsoNormal
				style='line-height: 27.0pt; mso-line-height-rule: exactly'><span> 
				<input type="text" name='公开发行的刊物名称' id="publicationName" style="width: 98%" maxlength="10" /></span></p>
			</td>
		</tr>
<!--会费情况-->
		<tr style='page-break-inside: avoid; height: 20.55pt'>
			<td width="14%" rowspan=3
				style='width: 14.1%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext 1.5pt; mso-border-alt: solid windowtext 1.5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 20.55pt'>
			<p class=MsoNormal align=center
				style='margin-left: -5.35pt; mso-para-margin-left: -.51gd; text-align: center; line-height: 25.0pt; mso-line-height-rule: exactly'><span
				style='font-size: 14.0pt; font-family: 宋体'>会费情况<span
				lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="18%"
				style='width: 18.48%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext 1.5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 20.55pt'>
			<p class=MsoNormal align=center
				style='margin-left: -5.35pt; mso-para-margin-left: -.51gd; text-align: center; line-height: 27.0pt; mso-line-height-rule: exactly'><span
				style='font-size: 14.0pt; font-family: 宋体'>制定会费标准的时间<span
				lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="18%" colspan=2
				style='width: 18.54%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext 1.5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 20.55pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 27.0pt; mso-line-height-rule: exactly'><span> 
				<input type="text" name='制定会费标准的时间' id="makeFeeDate" format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly" style="width: 98%" /></span></p>
			</td>
			<td width="18%" colspan=3
				style='width: 18.46%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext 1.5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 20.55pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 27.0pt; mso-line-height-rule: exactly'><span
				style='font-size: 14.0pt; font-family: 宋体'>会费标准<span
				lang=EN-US><o:p></o:p></span></span></p>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 27.0pt; mso-line-height-rule: exactly'><span
				style='font-size: 14.0pt; font-family: 宋体'>备案情况<span
				lang=EN-US style='color: black'><o:p></o:p></span></span></p>
			</td>
			<td width="30%" colspan=4
				style='width: 30.42%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext 1.5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: 1.5pt; mso-border-left-alt: .5pt; mso-border-bottom-alt: .5pt; mso-border-right-alt: 1.5pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid; padding: 0cm 5.4pt 0cm 5.4pt; height: 20.55pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 27.0pt; mso-line-height-rule: exactly'><span> 
				<select name='会费标准备案情况' id="regFeeType" style="width: 98%" />
					<option dataset="regFeeTypeSelect"></option>
				</select></span></p>
			</td>
		</tr>
		<tr style='page-break-inside: avoid; height: 23.25pt'>
			<td width="37%" colspan=3
				style='width: 37.02%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 1.4pt 0cm 1.4pt; height: 23.25pt'>
			<p class=MsoNormal
				style='line-height: 27.0pt; mso-line-height-rule: exactly'><span
				style='font-size: 14.0pt; font-family: 宋体'>通过会费标准的会议名称<span
				lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="48%" colspan=7
				style='width: 48.88%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 23.25pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 27.0pt; mso-line-height-rule: exactly'><span> 
				<input type="text" name='通过会费标准的会议名称' id="meetingName" style="width: 98%" /></span></p>
			</td>
		</tr>
		<tr style='mso-yfti-lastrow: yes; page-break-inside: avoid; height: 84.55pt'>
			<td width="37%" colspan=3 valign=middle
				style='width: 85.9%; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 84.55pt'>
			<p class=MsoNormal
				style='line-height: 25.0pt; mso-line-height-rule: exactly'><span
				style='font-size: 14.0pt; font-family: 宋体'>会费标准：<span
				lang=EN-US><o:p></o:p></span></span></p>
			</td>
			<td width="48%" colspan=7
				style='width: 48.88%; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 23.25pt'>
			<p class=MsoNormal align=center
				style='text-align: center; line-height: 27.0pt; mso-line-height-rule: exactly'><span> 
				<textarea name='会费标准' id="feeRule" style="width: 98%" rows="10"></textarea></span></p>
			</td>
		</tr>
		<![if !supportMisalignedColumns]>
		<tr height=0>
			<td width=112 style='border: none'></td>
			<td width=146 style='border: none'></td>
			<td width=8 style='border: none'></td>
			<td width=139 style='border: none'></td>
			<td width=73 style='border: none'></td>
			<td width=15 style='border: none'></td>
			<td width=59 style='border: none'></td>
			<td width=40 style='border: none'></td>
			<td width=50 style='border: none'></td>
			<td width=62 style='border: none'></td>
			<td width=89 style='border: none'></td>
		</tr>
		<![endif]>
	</table>
</form>
</div>
</body>
</html>