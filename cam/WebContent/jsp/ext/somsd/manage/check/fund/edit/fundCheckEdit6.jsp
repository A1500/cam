<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<html>

<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<title>基 金 会</title>
<next:ScriptManager />
<script type="text/javascript" src="../../js/float.js"></script>
<link href="../../css/float.css" type="text/css" rel="stylesheet" />
<script language="javascript">
var taskCode='<%=request.getParameter("taskCode")%>';
//初始化
function init(){
	somJxCheckPartyDataSet.setParameter("TASK_CODE", taskCode);
	somJxCheckPartyDataSet.load();
	somJxCheckPartyDataSet.on('load',function (ds){
		if(ds.getCount() == 0){
			ds.newRecord();
		}
		document.getElementById("ifBuildParty").value=ds.get("ifBuildParty");
		showParty();
		showPartyOfficer();
		showPartyOtherStudyWay();		
	});
	//创建页面导航下拉框
	createFundEditSelect();
}
function save(){	
	if(somJxCheckPartyDataSet.get("ifBuildParty")==''){
		L5.Msg.alert("提示",'"是否建立党组织"'+"不能为空！");
		return "break";
	}
	var somJxCheckPartyDataSetIsValidate = somJxCheckPartyDataSet.isValidate();
	if(somJxCheckPartyDataSetIsValidate != true){
		L5.Msg.alert("提示",somJxCheckPartyDataSetIsValidate);
		return "break";
	}
	var record=somJxCheckPartyDataSet.getCurrent();
	var ifBuildParty=record.get("ifBuildParty");
	if(ifBuildParty=='0'){
		var noBuildPartyReson=record.get("noBuildPartyReson");
		if(noBuildPartyReson==''){
			L5.Msg.alert("提示",'"未建立党组织原因"'+"不能为空！");
			return "break";
		}
		var ifPartyOfficer=record.get("ifPartyOfficer");
		var partyOfficerName=record.get("partyOfficerName");
		var partyOfficerContact=record.get("partyOfficerContact");
		if(ifPartyOfficer==''){
			L5.Msg.alert("提示",'"党建指导员"'+"不能为空！");
			return "break";
		}else if(ifPartyOfficer=='1'){
			if(partyOfficerName==''){
				L5.Msg.alert("提示",'"党建指导员姓名"'+"不能为空！");
				return "break";
			}
			if(partyOfficerContact==''){
				L5.Msg.alert("提示",'"党建指导员联系方式"'+"不能为空！");
				return "break";
			}			
		}
		
	}else{
		var partyType=record.get("partyType");
		if(partyType==''){
			L5.Msg.alert("提示",'"党组织形式"'+"不能为空！");
			return "break";
		}
		var partyRelationType=record.get("partyRelationType");
		if(partyRelationType==''){
			L5.Msg.alert("提示",'"党组织隶属关系"'+"不能为空！");
			return "break";
		}
		var partySpace=record.get("partySpace");
		if(partySpace==''){
			L5.Msg.alert("提示",'"党组织活动场所"'+"不能为空！");
			return "break";
		}
		record.set("partyActivityMon",document.getElementById("partyActivityMon").value);
		var partyActivityMon=record.get("partyActivityMon");
		if(partyActivityMon==''){
			L5.Msg.alert("提示",'"本年度党组织活动经费数"'+"不能为空！");
			return "break";
		}
		var partyDuesMon=record.get("partyDuesMon");
		if(partyDuesMon==''){
			L5.Msg.alert("提示",'"党费数"'+"不能为空！");
			return "break";
		}
		var partySupportMon=record.get("partySupportMon");
		if(partySupportMon==''){
			L5.Msg.alert("提示",'"上级党组织支持数"'+"不能为空！");
			return "break";
		}
		var partyBusinessMon=record.get("partyBusinessMon");
		if(partyBusinessMon==''){
			L5.Msg.alert("提示",'"业务经费数"'+"不能为空！");
			return "break";
		}
		var partyFinanceMon=record.get("partyFinanceMon");
		if(partyFinanceMon==''){
			L5.Msg.alert("提示",'"财政支持数"'+"不能为空！");
			return "break";
		}
		var partyOtherMon=record.get("partyOtherMon");
		if(partyOtherMon==''){
			L5.Msg.alert("提示",'"其他形式数"'+"不能为空！");
			return "break";
		}
		var partyPeopleType=record.get("partyPeopleType");
		if(partyPeopleType==''){
			L5.Msg.alert("提示",'"党组织负责人在社会组织中担任职务"'+"不能为空！");
			return "break";
		}
		var partyPeopleAge=record.get("partyPeopleAge");
		if(partyPeopleAge==''){
			L5.Msg.alert("提示",'"党组织负责人年龄"'+"不能为空！");
			return "break";
		}
		var partyPeopleEdu=record.get("partyPeopleEdu");
		if(partyPeopleEdu==''){
			L5.Msg.alert("提示",'"党组织负责人学历"'+"不能为空！");
			return "break";
		}
		var partyMemberTotal=record.get("partyMemberTotal");
		if(partyMemberTotal==''){
			L5.Msg.alert("提示",'"党员总数"'+"不能为空！");
			return "break";
		}
		var legalPartyNum=record.get("legalPartyNum");
		if(legalPartyNum==''){
			L5.Msg.alert("提示",'"领导班子中党员数"'+"不能为空！");
			return "break";
		}
		var partyPartyNum=record.get("partyPartyNum");
		if(partyPartyNum==''){
			L5.Msg.alert("提示",'"社会组织党组织数"'+"不能为空！");
			return "break";
		}
		
		var partyStudyWaySelf=record.get("partyStudyWaySelf");
		var partyStudyWayTalk=record.get("partyStudyWayTalk");
		var partyStudyWayChair=record.get("partyStudyWayChair");
		var partyStudyWayVisit=record.get("partyStudyWayVisit");
		var partyStudyWayArt=record.get("partyStudyWayArt");
		var partyStudyWayOther=record.get("partyStudyWayOther");
		var partyOtherStudyWay=record.get("partyOtherStudyWay");
		if(partyStudyWaySelf==''&&partyStudyWayTalk==''&&partyStudyWayChair==''&&partyStudyWayVisit==''&&partyStudyWayArt==''&&partyStudyWayOther==''){
			L5.Msg.alert("提示",'"党员学习教育方式"'+"不能为空！");
			return "break";
		}		
		if(partyStudyWayOther!=''&&partyOtherStudyWay==''){
			L5.Msg.alert("提示",'"党员学习教育其他方式的说明"'+"不能为空！");
			return "break";
		}
		var partyActivityNum=record.get("partyActivityNum");
		if(partyActivityNum==''){
			L5.Msg.alert("提示",'"本年度共开展党员活动数"'+"不能为空！");
			return "break";
		}
		var activityGoodNum=record.get("activityGoodNum");
		if(activityGoodNum==''){
			L5.Msg.alert("提示",'"为群众办实事、办好事数"'+"不能为空！");
			return "break";
		}	
		var ifAcceptance=record.get("ifAcceptance");
		if(ifAcceptance==''){
			L5.Msg.alert("提示",'"是否开展服务承诺"'+"不能为空！");
			return "break";
		}
		var partyWorkerNum=record.get("partyWorkerNum");
		if(partyWorkerNum==''){
			L5.Msg.alert("提示",'"专职党务工作者数"'+"不能为空！");
			return "break";
		}
		var partyCoordinatorName=record.get("partyCoordinatorName");
		if(partyCoordinatorName==''){
			L5.Msg.alert("提示",'"党建联络员姓名"'+"不能为空！");
			return "break";
		}	
		var partyCoordinatorContact=record.get("partyCoordinatorContact");
		if(partyCoordinatorContact==''){
			L5.Msg.alert("提示",'"党建联络员联系方式"'+"不能为空！");
			return "break";
		}
		var partyActivityDetail=record.get("partyActivityDetail");
		if(partyActivityDetail==''){
			L5.Msg.alert("提示",'"本年度开展党建活动情况"'+"不能为空！");
			return "break";
		}
		var partySuggest=record.get("partySuggest");
		if(partySuggest==''){
			L5.Msg.alert("提示",'"对于加强社会组织党组织建设工作有何思路或建议"'+"不能为空！");
			return "break";
		}
	}
	var partyMemberTotal=somJxCheckPartyDataSet.get("partyMemberTotal");	
	var partyPractitionerNum=somJxCheckPartyDataSet.get("partyPractitionerNum");	
	if(ifBuildParty=='0'){	
		var newPartyPeopleNum=somJxCheckPartyDataSet.get("newPartyPeopleNum");	
		if(parseInt(newPartyPeopleNum) > (parseInt(partyPractitionerNum))){
			L5.Msg.alert("提示",'"本年度发展新党员数"不能大于"从业人员中党员总数！"');
			return "break";
		}
		var partyFullTimeNum=somJxCheckPartyDataSet.get("partyFullTimeNum");
		if(parseInt(partyFullTimeNum) > (parseInt(partyPractitionerNum))){
			L5.Msg.alert("提示",'"专职人员中党员数"不能大于"从业人员中党员总数！"');
			return "break";
		}
		var partyRetireNum=somJxCheckPartyDataSet.get("partyRetireNum");	
		if(parseInt(partyRetireNum) > (parseInt(partyPractitionerNum))){
			L5.Msg.alert("提示",'"离退休党员数"不能大于"从业人员中党员总数！"');
			return "break";
		}
		if(parseInt(record.get('partyPractitionerNum')) != (parseInt(record.get('partyUnderThirtyFiveNum'))+parseInt(record.get('partyAboveThirtyFiveNum'))+parseInt(record.get('partyUnderSixtyNum'))+parseInt(record.get('partyAboveSixtyNum')))){
			L5.Msg.alert("提示","数据逻辑不正确！\n\n从业人员中党员总数=35岁及以下党员数+36—50岁党员数+51—60岁党员数+60岁以上党员数");
			return "break";
		}	
		if(parseInt(record.get('partyPractitionerNum')) != (parseInt(record.get('partySeniorNum'))+parseInt(record.get('partyBachelorNum'))+parseInt(record.get('partyMasterNum'))+parseInt(record.get('partyAbroadNum')) )){
			L5.Msg.alert("提示","数据逻辑不正确！\n\n从业人员中党员总数=高中及以下党员数+大学本科及专科党员数+硕士及以上文凭党员数+留学半年以上归国人员党员数");
			return "break";
		}	
		if(parseInt(record.get('partyPractitionerNum')) != (parseInt(record.get('partyBorgNum'))+parseInt(record.get('partyLinkedNum'))+parseInt(record.get('partyColonyNum'))+parseInt(record.get('partyWorkSpaceNum'))+parseInt(record.get('partyOtherSubjectionNum')))){
			L5.Msg.alert("提示","数据逻辑不正确！\n\n从业人员中党员总数=业务主管单位党组织党员数+挂靠单位党组织党员数+属地党组织党员数+原工作单位党组织党员数+其他党员数");
			return "break";
		}	
	}else{
		var legalPartyNum=somJxCheckPartyDataSet.get("legalPartyNum");	
		if(parseInt(legalPartyNum) > (parseInt(partyMemberTotal))){
			L5.Msg.alert("提示",'"领导班子中党员数"不能大于"党员总数！"');
			return "break";
		}
		if(parseInt(partyPractitionerNum) > (parseInt(partyMemberTotal))){
			L5.Msg.alert("提示",'"从业人员中党员数"不能大于"党员总数！"');
			return "break";
		}
		var newPartyPeopleNum=somJxCheckPartyDataSet.get("newPartyPeopleNum");	
		if(parseInt(newPartyPeopleNum) > (parseInt(partyPractitionerNum))){
			L5.Msg.alert("提示",'"本年度发展新党员数"不能大于"从业人员中党员总数！"');
			return "break";
		}
		var partyFullTimeNum=somJxCheckPartyDataSet.get("partyFullTimeNum");
		if(parseInt(partyFullTimeNum) > (parseInt(partyPractitionerNum))){
			L5.Msg.alert("提示",'"专职人员中党员数"不能大于"从业人员中党员总数！"');
			return "break";
		}
		var partyRetireNum=somJxCheckPartyDataSet.get("partyRetireNum");	
		if(parseInt(partyRetireNum) > (parseInt(partyPractitionerNum))){
			L5.Msg.alert("提示",'"离退休党员数"不能大于"从业人员中党员总数！"');
			return "break";
		}
		if(parseInt(record.get('partyPractitionerNum')) != (parseInt(record.get('partyUnderThirtyFiveNum'))+parseInt(record.get('partyAboveThirtyFiveNum'))+parseInt(record.get('partyUnderSixtyNum'))+parseInt(record.get('partyAboveSixtyNum')))){
			L5.Msg.alert("提示","数据逻辑不正确！\n\n从业人员中党员总数=35岁及以下党员数+36—50岁党员数+51—60岁党员数+60岁以上党员数");
			return "break";
		}	
		if(parseInt(record.get('partyPractitionerNum')) != (parseInt(record.get('partySeniorNum'))+parseInt(record.get('partyBachelorNum'))+parseInt(record.get('partyMasterNum'))+parseInt(record.get('partyAbroadNum')) )){
			L5.Msg.alert("提示","数据逻辑不正确！\n\n从业人员中党员总数=高中及以下党员数+大学本科及专科党员数+硕士及以上文凭党员数+留学半年以上归国人员党员数");
			return "break";
		}	
		if(parseInt(record.get('partyPractitionerNum')) != (parseInt(record.get('partyPartyNum'))+parseInt(record.get('partyBorgNum'))+parseInt(record.get('partyLinkedNum'))+parseInt(record.get('partyColonyNum'))+parseInt(record.get('partyWorkSpaceNum'))+parseInt(record.get('partyOtherSubjectionNum')))){
			L5.Msg.alert("提示","数据逻辑不正确！\n\n从业人员中党员总数=社会组织党组织党员数+业务主管单位党组织党员数+挂靠单位党组织党员数+属地党组织党员数+原工作单位党组织党员数+其他党员数");
			return "break";
		}	
	}
			
	var command = new L5.Command("com.inspur.cams.sorg.check.somcheck.cmd.SomCheckCommand");
	command.setParameter("taskCode",taskCode);
	command.setParameter("somJxCheckPartyRecord",record);
	command.execute("savePageJ6");
	if (!command.error) {
		alert("保存成功！");	
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
function showParty(){
	if(document.getElementById("ifBuildParty").value=='1'){
		document.getElementById("buildParty").style.display='block';
		document.getElementById("unBuildParty").style.display='none';
	}else{
		document.getElementById("unBuildParty").style.display='block';
		document.getElementById("buildParty").style.display='none';
	}
}
function showParty1(){
	var ifBuildParty = document.getElementById("ifBuildParty").value;
	if(ifBuildParty == '1'){
		document.getElementById("buildParty").style.display='block';
		document.getElementById("unBuildParty").style.display='none';
	}else{
		document.getElementById("unBuildParty").style.display='block';
		document.getElementById("buildParty").style.display='none';
	}
	var somJxCheckPartyRecord=somJxCheckPartyDataSet.getCurrent();
	somJxCheckPartyDataSet.removeAll();
	somJxCheckPartyDataSet.newRecord({"id":somJxCheckPartyRecord.get("id"),"taskCode":somJxCheckPartyRecord.get("taskCode"),"ifBuildParty":ifBuildParty});
}
function showPartyOfficer(){
	var partyOfficerName=document.getElementById("partyOfficerName");
	var partyOfficerContact=document.getElementById("partyOfficerContact");
	if(document.getElementById("ifPartyOfficer").value=='1'){
		document.getElementById("partyOfficerName").disabled=false;
		document.getElementById("partyOfficerContact").disabled=false;
	}else{
		document.getElementById("partyOfficerName").disabled=true;
		document.getElementById("partyOfficerContact").disabled=true;
		partyOfficerName.value='';
		partyOfficerContact.value='';
	}
}
function showPartyOtherStudyWay(){	
	var partyOtherStudyWay=document.getElementById("partyOtherStudyWay");
	if(document.getElementById("partyStudyWayOther").checked){
		document.getElementById("partyOtherStudyWay").disabled=false;
	}else{
		document.getElementById("partyOtherStudyWay").disabled=true;
		partyOtherStudyWay.value='';
	}
}
function countPartyActivityMon(){
	var partyDuesMon=document.getElementById("partyDuesMon").value;	
	var partySupportMon=document.getElementById("partySupportMon").value;
	var partyBusinessMon=document.getElementById("partyBusinessMon").value;
	var partyFinanceMon=document.getElementById("partyFinanceMon").value;
	var partyOtherMon=document.getElementById("partyOtherMon").value;
	if(partyDuesMon==""){
		partyDuesMon=0;
	}
	if(partySupportMon==""){
		partySupportMon=0;
	}
	if(partyBusinessMon==""){
		partyBusinessMon=0;
	}
	if(partyFinanceMon==""){
		partyFinanceMon=0;
	}
	if(partyOtherMon==""){
		partyOtherMon=0;
	}
	var num=parseFloat(partyDuesMon)+parseFloat(partySupportMon)+parseFloat(partyBusinessMon)+parseFloat(partyFinanceMon)+parseFloat(partyOtherMon);
	document.getElementById('partyActivityMon').value =num.toFixed(2)*1;
}
function getParseFloat(value){
	if(!value){
		return 0;
	}else{
		return parseFloat(value);
	}
}
</script>
<style>
textarea{
	overflow:hidden;
}
</style>
</head>

<body>
<model:datasets>
	<model:dataset id="somJxCheckPartyDataSet" cmd="com.inspur.cams.sorg.check.somcheckparty.cmd.SomCheckPartyQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.somcheckparty.dao.SomCheckParty">
			<model:field name="partyPractitionerNum" type="string" rule="require" />
			<model:field name="newPartyPeopleNum" type="string" rule="require" />
			<model:field name="partyFullTimeNum" type="string" rule="require" />
			<model:field name="partyRetireNum" type="string" rule="require" />
			<model:field name="partyUnderThirtyFiveNum" type="string" rule="require" />
			<model:field name="partyAboveThirtyFiveNum" type="string" rule="require" />
			<model:field name="partyUnderSixtyNum" type="string" rule="require" />
			<model:field name="partyAboveSixtyNum" type="string" rule="require" />
			<model:field name="partySeniorNum" type="string" rule="require" />
			<model:field name="partyBachelorNum" type="string" rule="require" />
			<model:field name="partyMasterNum" type="string" rule="require" />
			<model:field name="partyAbroadNum" type="string" rule="require" />
			<model:field name="partyBorgNum" type="string" rule="require" />
			<model:field name="partyLinkedNum" type="string" rule="require" />
			<model:field name="partyColonyNum" type="string" rule="require" />
			<model:field name="partyWorkSpaceNum" type="string" rule="require" />
			<model:field name="partyOtherSubjectionNum" type="string" rule="require" />
			<model:field name="partyOtherStudyWay" type="string" rule="length{100}" />
			<model:field name="partyActivityDetail" type="string" rule="length{1000}" />
			<model:field name="partySuggest" type="string" rule="length{1000}" />
		</model:record>
	</model:dataset>
	<!-- 是否 -->
	<model:dataset id="YorNDataset" enumName="COMM.YESORNO" autoLoad="true"	global="true"></model:dataset>
	<!-- 有无 -->
	<model:dataset id="HorNDataset" enumName="COMM.HAVEORNO" autoLoad="true"	global="true"></model:dataset>
	<!-- 年龄 -->
	<model:dataset id="ageSelect" enumName="SOM.AGE" autoLoad="true"	global="true"></model:dataset>
	<!-- 学历 -->
	<model:dataset id="degreeSelect" enumName="SOM.DEGREE" autoLoad="true"	global="true"></model:dataset>
	<!-- 党组织形式 -->
	<model:dataset id="partyTypeDataset" enumName="SORG.PARTY.BUILDTYPE.CODE" global="true" autoLoad="true">
	</model:dataset>
	<!-- 党组织隶属关系 -->
	<model:dataset id="partyRelationDataset" enumName="SORG.PARTY.RELATION.CODE" global="true" autoLoad="true">
	</model:dataset>
	<!-- 党组织负责人-->
	<model:dataset id="partyResponsibleDataset" enumName="SORG.PARTY.RESPONSIBLE.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 党组织活动场所 -->
	<model:dataset id="partyActPlaceDataset" enumName="SOM.PARTY.ACT_PLACE" autoLoad="true"	global="true"></model:dataset>
	<!-- 未建党组织 -->
	<model:dataset id="noPartyReasonDataset" enumName="SORG.PARTY.NOREASON.CODE" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<div id="float">	<input type="button" value="下一页" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="nextPageJ('7')"/>
		<input type="button" value="上一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="lastPageJ('5')"/>
	<!--[if lte IE 7]><div></div><![endif]-->
	<input type="button" value="保存" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="save();"/>
	<!--[if lte IE 7]><div></div><![endif]-->
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:320px;" onclick="backJ();"/>
</div>
<form method="post" onsubmit="return false"
	dataset="somJxCheckPartyDataSet">
	<div align='center'>
<div class=Section1 align="left"
	style=' width: 800px; '>
<p>&nbsp;</p>

<TABLE cellSpacing=0 cellPadding=0 width=800 align=center border=0>
	<TBODY>
		<TR>
			<TD width='33%' height=51><STRONG class=word-st-14>（五）党组织建设情况
			</STRONG></TD>
		</TR>
	</TBODY>
</TABLE>
<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt; tab-stops: 53.25pt'
	align="left"><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'>是否建立党组织：
	<select id="ifBuildParty" field="" onchange="showParty1();" style="width: 100"><option dataset="YorNDataset"></option></select></span>
</p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt; tab-stops: 53.25pt'
	align="left"><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'>(一)未建立党组织</span><span
	lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋; mso-bidi-font-weight: bold'><o:p></o:p></span></p>
	
<div id='unBuildParty'>
<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt; tab-stops: 53.25pt'
	align="left"><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋; mso-bidi-font-weight: bold'>1</span><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'>、未建立党组织原因：</span><span>
<select id="" field="noBuildPartyReson" style='width:200'>
	<option dataset="noPartyReasonDataset">
</select></span>
<br/>
<span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'>
	（“应建未建”是指专职工作人员中有3名以上正式党员，但未建立党组织的社会组织。）
	</span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt; tab-stops: 53.25pt;'
	align="left"><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋; mso-bidi-font-weight: bold'>2</span><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'>、从业人员中党员总数
<input style="width:100" title='从业人员中党员总数'  onkeyup="value=value.replace(/[^\d]/g,'')" type="text"
	id='partyPractitionerNum'field="partyPractitionerNum"	maxlength="6">
	人，本年度发展新党员
<input style="width:100" title='本年度发展新党员数' onkeyup="value=value.replace(/[^\d]/g,'')" id='newPartyPeopleNum'field="newPartyPeopleNum"
	type="text"	maxlength="6">
	人。其中，专职人员中党员数
<input style="width:100" title='专职人员中党员数'  onkeyup="value=value.replace(/[^\d]/g,'')" id='partyFullTimeNum'field="partyFullTimeNum"
	type="text"	maxlength="6">
	人，离退休党员
<input style="width:100" title='离退休党员' onkeyup="value=value.replace(/[^\d]/g,'')"id='partyRetireNum' field="partyRetireNum"
	type="text"	maxlength="6">
	人。</span><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋; mso-bidi-font-weight: bold'><o:p></o:p></span></p>	

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt; tab-stops: 53.25pt'
	align="left"><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋; mso-bidi-font-weight: bold'>3</span><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'>、党员年龄结构：</span><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋; letter-spacing: -1.4pt'>
35岁及以下
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='35岁及以下' name='"35岁及以下"' field="partyUnderThirtyFiveNum" style="width:100"  maxlength="6"/>
	人，36—50岁
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='36——50岁' name='"36——50岁"' field="partyAboveThirtyFiveNum" style="width:100"  maxlength="6"/>
	人，
	<br/>
	51—60岁
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='51——60岁' name='"51——60岁"' field="partyUnderSixtyNum" style="width:100"  maxlength="6"/>
	人，60岁以上
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='60岁以上' name='"60岁以上"' field="partyAboveSixtyNum" style="width:100"  maxlength="6"/>
	人。</span></p>	

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt; tab-stops: 53.25pt'
	align="left"><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋; mso-bidi-font-weight: bold'>4</span><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'>、党员学历结构：</span><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋; letter-spacing: -1.4pt'>
高中及以下	
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='高中及以下学历' name='"高中及以下学历"' field="partySeniorNum" style="width:100"  maxlength="6"/>
	人，本科及专科
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='大学本科及专科学历' name='"大学本科及专科学历"' field="partyBachelorNum" style="width:100"  maxlength="6"/>
	人，
	<br/>
	硕士及以上
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='硕士及以上学历' name='"硕士及以上学历"' field="partyMasterNum" style="width:100"  maxlength="6"/>
	人，留学半年以上归国人员
<input onkeyup="value=value.replace(/[^\d]/g,'')"  type="text" title='留学半年以上归国人员' name='"留学半年以上归国人员"' field="partyAbroadNum" style="width:100"  maxlength="6"/>
	人。</span></p>	

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt; tab-stops: 53.25pt'
	align="left"><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋; mso-bidi-font-weight: bold'>5</span><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'>、党员组织关系隶属：</span><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋; letter-spacing: -1.4pt'>
业务主管单位党组织	
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='业务主管单位党组织' name='"业务主管单位党组织"' field="partyBorgNum" style="width:100"  maxlength="6"/>
	人，挂靠单位党组织
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='挂靠单位党组织' name='"挂靠单位党组织"' field="partyLinkedNum" style="width:100"  maxlength="6"/>
	人，属地党组织
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='属地党组织' name='"属地党组织"' field="partyColonyNum" style="width:100"  maxlength="6"/>
	人，原工作单位党组织
<input onkeyup="value=value.replace(/[^\d]/g,'')"  type="text" title='原工作单位党组织' name='"原工作单位党组织"' field="partyWorkSpaceNum" style="width:100"  maxlength="6"/>
	人，其他
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='其他' name='"其他"' field="partyOtherSubjectionNum" style="width:100"  maxlength="6"/>
	人。</span></p>	

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt; tab-stops: 53.25pt'
	align="left"><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋; mso-bidi-font-weight: bold'>6</span><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'>、党建指导员：</span><span>
<select id="ifPartyOfficer" field="ifPartyOfficer" style='width:100;'onchange='showPartyOfficer()'>
	<option dataset="HorNDataset">
</select></span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt; tab-stops: 53.25pt'
	align="left"><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋; mso-bidi-font-weight: bold'></span><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'>
姓名
<input type="text" title='姓名' name='"姓名"'id='partyOfficerName' field="partyOfficerName" style="width:150"  maxlength="50"/>
联系方式
<input type="text" title='联系方式' name='"联系方式"'id='partyOfficerContact' field="partyOfficerContact" style="width:300"  maxlength="50"/></span></p>
</div>
		
<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt; tab-stops: 53.25pt'
	align="left"><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'>(二)已建立党组织情况</span><span
	lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋; mso-bidi-font-weight: bold'><o:p></o:p></span></p>

<div id='buildParty'>
<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt; tab-stops: 53.25pt;'
	align="left"><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋; mso-bidi-font-weight: bold'>1</span><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'>、党组织形式：</span><span>
<select title="党组织形式" id="" field="partyType"style='width:100;'>
	<option dataset="partyTypeDataset">
</select></span></p>
	
<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt; tab-stops: 53.25pt'
	align="left"><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋; mso-bidi-font-weight: bold'>2</span><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'>、党组织隶属关系：</span><span>
<select id="" field="partyRelationType"style='width:200;'>
	<option dataset="partyRelationDataset">
</select></span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt; tab-stops: 53.25pt'
	align="left"><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋; mso-bidi-font-weight: bold'>3</span><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'>、党组织活动场所：</span><span>
<select id="" field="partySpace"style='width:300;'>
	<option dataset="partyActPlaceDataset">
</select></span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt; tab-stops: 53.25pt'
	align="left"><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋; mso-bidi-font-weight: bold'>4</span><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'>、本年度党组织活动经费
<input type="text" title='本年度党组织活动经费' name='"本年度党组织活动经费"' id='partyActivityMon'field="partyActivityMon" style="width:100"  maxlength="15" disabled/>
	元。其中，来源于党费
<input onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.]/g,'');countPartyActivityMon()" type="text" title='党费' name='"党费"' id='partyDuesMon'field="partyDuesMon" style="width:100"  maxlength="15"/>
	元；上级党组织支持
<input onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.]/g,'');countPartyActivityMon()" type="text" title='上级党组织支持' name='"上级党组织支持"' id='partySupportMon'field="partySupportMon" style="width:100"  maxlength="15"/>
	元；业务经费
<input onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.]/g,'');countPartyActivityMon()"  type="text" title='业务经费' name='"业务经费"' id='partyBusinessMon'field="partyBusinessMon" style="width:100"  maxlength="15"/>
	元；财政支持
<input onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.]/g,'');countPartyActivityMon()" type="text" title='财政支持' name='"财政支持"' id='partyFinanceMon'field="partyFinanceMon" style="width:100"  maxlength="15"/>
	元；其他形式
<input onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.]/g,'');countPartyActivityMon()" type="text" title='其他形式' name='"其他形式"' id='partyOtherMon'field="partyOtherMon" style="width:100"  maxlength="15"/>
	元。</span></p>	
	
<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt; tab-stops: 53.25pt'
	align="left"><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋; mso-bidi-font-weight: bold'>5</span><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'>、党组织负责人情况。在社会组织中担任职务：
<select id="" field="partyPeopleType" style='width:150'>
	<option dataset="partyResponsibleDataset">
</select>
年龄
<select title='年龄' name='"年龄"' field="partyPeopleAge" style="width:200"><option dataset='ageSelect'></select>
学历
<select title='学历' name='"学历"' field="partyPeopleEdu" style="width:200"><option dataset='degreeSelect'></select>
</span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt; tab-stops: 53.25pt'
	align="left"><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋; mso-bidi-font-weight: bold'>6</span><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'>、党员总数
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='党员总数' name='"党员总数"' field="partyMemberTotal" style="width:100"  maxlength="6"/>
	人。领导班子中党员
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='领导班子中党员' name='"领导班子中党员"' field="legalPartyNum" style="width:100"  maxlength="6"/>
	人；从业人员中党员
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='从业人员中党员' name='"从业人员中党员"' field="partyPractitionerNum" style="width:100"  maxlength="6"/>
	人，本年度发展新党员
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='本年度发展新党员' name='"本年度发展新党员"' field="newPartyPeopleNum" style="width:100"  maxlength="6"/>
	人。其中专职人员中党员
<input onkeyup="value=value.replace(/[^\d]/g,'')"  type="text" title='其中专职人员中党员' name='"其中专职人员中党员"' field="partyFullTimeNum" style="width:100"  maxlength="6"/>
	人，离退休党员
<input style="width:100" title='离退休党员' onkeyup="value=value.replace(/[^\d]/g,'')" field="partyRetireNum"
	type="text"	maxlength="6">
	人。</span></p>	

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt; tab-stops: 53.25pt'
	align="left"><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋; mso-bidi-font-weight: bold'>7</span><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'>、党员年龄结构：</span><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋; letter-spacing: -1.4pt'>
35岁及以下
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='35岁及以下' name='"35岁及以下"' field="partyUnderThirtyFiveNum" style="width:100"  maxlength="6"/>
	人，36—50岁
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='36——50岁' name='"36——50岁"' field="partyAboveThirtyFiveNum" style="width:100"  maxlength="6"/>
	人，
	<br/>
	51—60岁
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='51——60岁' name='"51——60岁"' field="partyUnderSixtyNum" style="width:100"  maxlength="6"/>
	人，60岁以上
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='60岁以上' name='"60岁以上"' field="partyAboveSixtyNum" style="width:100"  maxlength="6"/>
	人。</span></p>	

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt; tab-stops: 53.25pt'
	align="left"><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋; mso-bidi-font-weight: bold'>8</span><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'>、党员学历结构：</span><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋; letter-spacing: -1.4pt'>
高中及以下	
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='高中及以下学历' name='"高中及以下学历"' field="partySeniorNum" style="width:100"  maxlength="6"/>
	人，本科及专科
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='大学本科及专科学历' name='"大学本科及专科学历"' field="partyBachelorNum" style="width:100"  maxlength="6"/>
	人，
	<br/>
	硕士及以上
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='硕士及以上学历' name='"硕士及以上学历"' field="partyMasterNum" style="width:100"  maxlength="6"/>
	人，留学半年以上归国人员
<input onkeyup="value=value.replace(/[^\d]/g,'')"  type="text" title='留学半年以上归国人员' name='"留学半年以上归国人员"' field="partyAbroadNum" style="width:100"  maxlength="6"/>
	人。</span></p>	
	
<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt; tab-stops: 53.25pt'
	align="left"><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋; mso-bidi-font-weight: bold'>9</span><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'>、党员组织关系隶属：</span><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋; letter-spacing: -1.4pt'>
社会组织党组织
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='社会组织党组织' name='"社会组织党组织"' field="partyPartyNum" style="width:100"  maxlength="6"/>
	人，业务主管单位党组织	
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='业务主管单位党组织' name='"业务主管单位党组织"' field="partyBorgNum" style="width:100"  maxlength="6"/>
	人，挂靠单位党组织
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='挂靠单位党组织' name='"挂靠单位党组织"' field="partyLinkedNum" style="width:100"  maxlength="6"/>
	人，属地党组织
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='属地党组织' name='"属地党组织"' field="partyColonyNum" style="width:100"  maxlength="6"/>
	人，原工作单位党组织
<input onkeyup="value=value.replace(/[^\d]/g,'')"  type="text" title='原工作单位党组织' name='"原工作单位党组织"' field="partyWorkSpaceNum" style="width:100"  maxlength="6"/>
	人，其他
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='其他' name='"其他"' field="partyOtherSubjectionNum" style="width:100"  maxlength="6"/>
	人。</span></p>	
	
<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt; tab-stops: 53.25pt'
	align="left"><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋; mso-bidi-font-weight: bold'>10</span><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'>、党员学习教育方式有：
<br/>
<input id=''field='partyStudyWaySelf' type='checkbox' value='1' />个人自学
<input id=''field='partyStudyWayTalk' type='checkbox' value='1' />支部学习讨论
<input id=''field='partyStudyWayChair' type='checkbox' value='1' />听辅导报告或专题讲座
<input id=''field='partyStudyWayVisit' type='checkbox' value='1' />外出交流参观
<br/>
<input id=''field='partyStudyWayArt' type='checkbox' value='1' />组织文艺活动
<input id='partyStudyWayOther'field='partyStudyWayOther' type='checkbox' value='1' onchange='showPartyOtherStudyWay()'/>其他
</span></p>

<p class=MsoNormal 
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt; tab-stops: 53.25pt'
	align="left"><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋; mso-bidi-font-weight: bold'></span><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'>请说明：</span><span>
<textarea id='partyOtherStudyWay' field='partyOtherStudyWay'style='width:600' rows='5'></textarea>
</span></p>


<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt; tab-stops: 53.25pt'
	align="left"><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋; mso-bidi-font-weight: bold'>11</span><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'>、本年度共开展党员活动
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='本年度共开展党员活动' name='"本年度共开展党员活动"' field="partyActivityNum" style="width:100"  maxlength="6"/>
次，为群众办实事、办好事
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='为群众办实事、办好事' name='"为群众办实事、办好事"' field="activityGoodNum" style="width:100"  maxlength="6"/>
件。
</span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt; tab-stops: 53.25pt'
	align="left"><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋; mso-bidi-font-weight: bold'>12</span><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'>、是否开展服务承诺：</span><span>
	<select id="" field="ifAcceptance" style="width: 100"><option dataset="YorNDataset"></option></select></span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt; tab-stops: 53.25pt'
	align="left"><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋; mso-bidi-font-weight: bold'>13</span><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'>、专职党务工作者
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='专职党务工作者' name='"专职党务工作者"' field="partyWorkerNum" style="width:100"  maxlength="6"/>
人。党建联络员姓名
<input type="text" title='党建联络员姓名' name='"党建联络员姓名"' field="partyCoordinatorName" style="width:150"  maxlength="50"/>
，联系方式
<input type="text" title='联系方式' name='"联系方式"' field="partyCoordinatorContact" style="width:300"  maxlength="50"/></span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt; tab-stops: 53.25pt'
	align="left"><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋; mso-bidi-font-weight: bold'>14</span><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'>、本年度开展党建活动情况（不少于150字）</span><span>
</span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt; tab-stops: 53.25pt'
	align="center"><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋; mso-bidi-font-weight: bold'></span><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'></span><span>
<textarea field='partyActivityDetail' style='width:750' rows='8'></textarea>
</span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt; tab-stops: 53.25pt'
	align="left"><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋; mso-bidi-font-weight: bold'>15</span><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'>、对于加强社会组织党组织建设工作有何思路或建议：</span><span>
</span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt; tab-stops: 53.25pt'
	align="center"><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋; mso-bidi-font-weight: bold'></span><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'></span><span>
<textarea field='partySuggest' style='width:750' rows='8'></textarea>
</span></p>
</div>
</div>

</form>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</body>
</html>

