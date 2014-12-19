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
			document.getElementById('partyDiv').style.display = 'none';
		}else{
			if(ds.get('ifBuildParty') != '1'){
				document.getElementById('partyDiv').style.display = 'none';
			}
		}
		showParty();
	});
	//创建页面导航下拉框
	createFundDetailSelect();
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
</script>
<style media="print">
	.noprint     { display: none }
</style>
<style>
textarea{
	overflow:hidden;
}
label {
	text-indent:0;
	text-align:center;
	border-bottom: solid 1px black;	
	font-size: 13.0pt;
	font-family: 仿宋_GB2312;
}
</style>
</head>

<body>
<model:datasets>
	<model:dataset id="somJxCheckPartyDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxcheckparty.cmd.SomJxCheckPartyQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxcheckparty.dao.SomJxCheckParty"></model:record>
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
<div id="float"  class="noprint">	
	<input type="button" value="下一页" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="nextPageJ1('7')"/>
	<input type="button" value="上一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="lastPageJ1('5')"/>
	<!--[if lte IE 7]><div></div><![endif]-->
	<!--[if lte IE 7]><div></div><![endif]-->
	<input type="button" value="打印" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="docPrint();"/>
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
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'>是否建立党组织：
	<select id="ifBuildParty" field="ifBuildParty" onchange="" style="width: 100"disabled><option dataset="YorNDataset"/></select></span>
</p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt; tab-stops: 53.25pt'
	align="left"><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'>(一)未建立党组织</span><span
	lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-bidi-font-weight: bold'><o:p></o:p></span></p>
	
<div id='unBuildParty'>
<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt; tab-stops: 53.25pt'
	align="left"><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-bidi-font-weight: bold'>1</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'>、未建立党组织原因：</span><span>
<label id="" field="noBuildPartyReson" style='width:400' dataset="noPartyReasonDataset"></label></span>
<br/>
<span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'>
	（“应建未建”是指专职工作人员中有3名以上正式党员，但未建立党组织的社会组织。）
	</span></p>

<p class=MsoNormal id="noBuildPartyResonSpan" 
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt; tab-stops: 53.25pt'
	align="left"><span lang=EN-US
	style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-bidi-font-weight: bold'></span><span
	style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'>应建未建党组织原因具体说明：</span><span>
<textarea id='noBuildPartyResonDesc' field='noBuildPartyResonDesc' style='width:750' rows='5' readonly></textarea>
</span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt; tab-stops: 53.25pt;'
	align="left"><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-bidi-font-weight: bold'>2</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'>、从业人员中党员总数
<label style="width:100" title='从业人员中党员总数'  onkeyup="value=value.replace(/[^\d]/g,'')" type="text"
	id='partyPractitionerNum'field="partyPractitionerNum"	maxlength="6"></label>
	人，本年度发展新党员
<label style="width:100" title='本年度发展新党员数' onkeyup="value=value.replace(/[^\d]/g,'')" id='newPartyPeopleNum'field="newPartyPeopleNum"
	type="text"	maxlength="6"></label>
	人。其中，专职人员中党员数
<label style="width:100" title='专职人员中党员数'  onkeyup="value=value.replace(/[^\d]/g,'')" id='partyFullTimeNum'field="partyFullTimeNum"
	type="text"	maxlength="6"></label>
	人，离退休党员
<label style="width:100" title='离退休党员' onkeyup="value=value.replace(/[^\d]/g,'')"id='partyRetireNum' field="partyRetireNum"
	type="text"	maxlength="6"></label>
	人。</span><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-bidi-font-weight: bold'><o:p></o:p></span></p>	

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt; tab-stops: 53.25pt'
	align="left"><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-bidi-font-weight: bold'>3</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'>、党员年龄结构：</span><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; letter-spacing: -1.4pt'>
35岁及以下
<label onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='35岁及以下' name='"35岁及以下"' field="partyUnderThirtyFiveNum" style="width:100"  maxlength="6"></label>
	人，36—50岁
<label onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='36——50岁' name='"36——50岁"' field="partyAboveThirtyFiveNum" style="width:100"  maxlength="6"></label>
	人，
	<br/>
	51—60岁
<label onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='51——60岁' name='"51——60岁"' field="partyUnderSixtyNum" style="width:100"  maxlength="6"></label>
	人，60岁以上
<label onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='60岁以上' name='"60岁以上"' field="partyAboveSixtyNum" style="width:100"  maxlength="6"></label>
	人。</span></p>	

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt; tab-stops: 53.25pt'
	align="left"><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-bidi-font-weight: bold'>4</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'>、党员学历结构：</span><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; letter-spacing: -1.4pt'>
高中及以下	
<label onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='高中及以下学历' name='"高中及以下学历"' field="partySeniorNum" style="width:100"  maxlength="6"></label>
	人，本科及专科
<label onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='大学本科及专科学历' name='"大学本科及专科学历"' field="partyBachelorNum" style="width:100"  maxlength="6"></label>
	人，
	<br/>
	硕士及以上
<label onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='硕士及以上学历' name='"硕士及以上学历"' field="partyMasterNum" style="width:100"  maxlength="6"></label>
	人，留学半年以上归国人员
<label onkeyup="value=value.replace(/[^\d]/g,'')"  type="text" title='留学半年以上归国人员' name='"留学半年以上归国人员"' field="partyAbroadNum" style="width:100"  maxlength="6"></label>
	人。</span></p>	

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt; tab-stops: 53.25pt'
	align="left"><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-bidi-font-weight: bold'>5</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'>、党员组织关系隶属：</span><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; letter-spacing: -1.4pt'>
业务主管单位党组织	
<label onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='业务主管单位党组织' name='"业务主管单位党组织"' field="partyBorgNum" style="width:100"  maxlength="6"></label>
	人，挂靠单位党组织
<label onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='挂靠单位党组织' name='"挂靠单位党组织"' field="partyLinkedNum" style="width:100"  maxlength="6"></label>
	人，属地党组织
<label onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='属地党组织' name='"属地党组织"' field="partyColonyNum" style="width:100"  maxlength="6"></label>
	人，原工作单位党组织
<label onkeyup="value=value.replace(/[^\d]/g,'')"  type="text" title='原工作单位党组织' name='"原工作单位党组织"' field="partyWorkSpaceNum" style="width:100"  maxlength="6"></label>
	人，其他
<label onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='其他' name='"其他"' field="partyOtherSubjectionNum" style="width:100"  maxlength="6"></label>
	人。</span></p>	

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt; tab-stops: 53.25pt'
	align="left"><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-bidi-font-weight: bold'>6</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'>、党建指导员：</span><span>
<label id="ifPartyOfficer" field="ifPartyOfficer" style='width:100;'onchange='' dataset="HorNDataset"></label></span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt; tab-stops: 53.25pt'
	align="left"><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-bidi-font-weight: bold'></span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'>
姓名
<label type="text" title='姓名' name='"姓名"'id='partyOfficerName' field="partyOfficerName" style="width:150"  maxlength="50"></label>
联系方式
<label type="text" title='联系方式' name='"联系方式"'id='partyOfficerContact' field="partyOfficerContact" style="width:300"  maxlength="50"></label></span></p>
</div>
		
<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt; tab-stops: 53.25pt'
	align="left"><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'>(二)已建立党组织情况</span><span
	lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-bidi-font-weight: bold'><o:p></o:p></span></p>

<div id='buildParty'>
<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt; tab-stops: 53.25pt;'
	align="left"><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-bidi-font-weight: bold'>1</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'>、党组织形式：</span><span>
<label title="党组织形式" id="" field="partyType"style='width:100;'dataset="partyTypeDataset"></label></span></p>
	
<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt; tab-stops: 53.25pt'
	align="left"><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-bidi-font-weight: bold'>2</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'>、党组织隶属关系：</span><span>
<label id="" field="partyRelationType"style='width:200;' dataset="partyRelationDataset"></label></span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt; tab-stops: 53.25pt'
	align="left"><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-bidi-font-weight: bold'>3</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'>、党组织活动场所：</span><span>
<label id="" field="partySpace"style='width:300;' dataset="partyActPlaceDataset"></label></span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt; tab-stops: 53.25pt'
	align="left"><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-bidi-font-weight: bold'>4</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'>、本年度党组织活动经费
<label onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.]/g,'')" type="text" title='本年度党组织活动经费' name='"本年度党组织活动经费"' field="partyActivityMon" style="width:100"  maxlength="6"></label>
	元。其中，来源于党费
<label onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.]/g,'')" type="text" title='党费' name='"党费"' field="partyDuesMon" style="width:100"  maxlength="6"></label>
	元；上级党组织支持
<label onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.]/g,'')" type="text" title='上级党组织支持' name='"上级党组织支持"' field="partySupportMon" style="width:100"  maxlength="6"></label>
	元；业务经费
<label onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.]/g,'')"  type="text" title='业务经费' name='"业务经费"' field="partyBusinessMon" style="width:100"  maxlength="6"></label>
	元；财政支持
<label onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.]/g,'')" type="text" title='财政支持' name='"财政支持"' field="partyFinanceMon" style="width:100"  maxlength="6"></label>
	元；其他形式
<label onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.]/g,'')" type="text" title='其他形式' name='"其他形式"' field="partyOtherMon" style="width:100"  maxlength="6"></label>
	元。</span></p>	
	
<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt; tab-stops: 53.25pt'
	align="left"><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-bidi-font-weight: bold'>5</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'>、党组织负责人情况。在社会组织中担任职务：
<label id="" field="partyPeopleType" style='width:150' dataset="partyResponsibleDataset"></label>
年龄
<label title='年龄' name='"年龄"' field="partyPeopleAge" style="width:200" dataset='ageSelect'></label>
学历
<label title='学历' name='"学历"' field="partyPeopleEdu" style="width:200" dataset='degreeSelect'></label>
</span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt; tab-stops: 53.25pt'
	align="left"><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-bidi-font-weight: bold'>6</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'>、党员总数
<label onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='党员总数' name='"党员总数"' field="partyMemberTotal" style="width:100"  maxlength="6"></label>
	人。领导班子中党员
<label onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='领导班子中党员' name='"领导班子中党员"' field="legalPartyNum" style="width:100"  maxlength="6"></label>
	人；从业人员中党员
<label onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='从业人员中党员' name='"从业人员中党员"' field="partyPractitionerNum" style="width:100"  maxlength="6"></label>
	人，本年度发展新党员
<label onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='本年度发展新党员' name='"本年度发展新党员"' field="newPartyPeopleNum" style="width:100"  maxlength="6"></label>
	人。其中专职人员中党员
<label onkeyup="value=value.replace(/[^\d]/g,'')"  type="text" title='其中专职人员中党员' name='"其中专职人员中党员"' field="partyFullTimeNum" style="width:100"  maxlength="6"></label>
	人，离退休党员
<label style="width:100" title='离退休党员' onkeyup="value=value.replace(/[^\d]/g,'')" field="partyRetireNum"
	type="text"	maxlength="6"></label>
	人。</span></p>	

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt; tab-stops: 53.25pt'
	align="left"><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-bidi-font-weight: bold'>7</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'>、党员年龄结构：</span><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; letter-spacing: -1.4pt'>
35岁及以下
<label onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='35岁及以下' name='"35岁及以下"' field="partyUnderThirtyFiveNum" style="width:100"  maxlength="6"></label>
	人，36—50岁
<label onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='36——50岁' name='"36——50岁"' field="partyAboveThirtyFiveNum" style="width:100"  maxlength="6"></label>
	人，
	<br/>
	51—60岁
<label onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='51——60岁' name='"51——60岁"' field="partyUnderSixtyNum" style="width:100"  maxlength="6"></label>
	人，60岁以上
<label onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='60岁以上' name='"60岁以上"' field="partyAboveSixtyNum" style="width:100"  maxlength="6"></label>
	人。</span></p>	

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt; tab-stops: 53.25pt'
	align="left"><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-bidi-font-weight: bold'>8</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'>、党员学历结构：</span><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; letter-spacing: -1.4pt'>
高中及以下	
<label onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='高中及以下学历' name='"高中及以下学历"' field="partySeniorNum" style="width:100"  maxlength="6"></label>
	人，本科及专科
<label onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='大学本科及专科学历' name='"大学本科及专科学历"' field="partyBachelorNum" style="width:100"  maxlength="6"></label>
	人，
	<br/>
	硕士及以上
<label onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='硕士及以上学历' name='"硕士及以上学历"' field="partyMasterNum" style="width:100"  maxlength="6"></label>
	人，留学半年以上归国人员
<label onkeyup="value=value.replace(/[^\d]/g,'')"  type="text" title='留学半年以上归国人员' name='"留学半年以上归国人员"' field="partyAbroadNum" style="width:100"  maxlength="6"></label>
	人。</span></p>	
	
<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt; tab-stops: 53.25pt'
	align="left"><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-bidi-font-weight: bold'>9</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'>、党员组织关系隶属：</span><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; letter-spacing: -1.4pt'>
社会组织党组织
<label onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='社会组织党组织' name='"社会组织党组织"' field="partyPartyNum" style="width:100"  maxlength="6"></label>
	人，业务主管单位党组织	
<label onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='业务主管单位党组织' name='"业务主管单位党组织"' field="partyBorgNum" style="width:100"  maxlength="6"></label>
	人，挂靠单位党组织
<label onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='挂靠单位党组织' name='"挂靠单位党组织"' field="partyLinkedNum" style="width:100"  maxlength="6"></label>
	人，属地党组织
<label onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='属地党组织' name='"属地党组织"' field="partyColonyNum" style="width:100"  maxlength="6"></label>
	人，原工作单位党组织
<label onkeyup="value=value.replace(/[^\d]/g,'')"  type="text" title='原工作单位党组织' name='"原工作单位党组织"' field="partyWorkSpaceNum" style="width:100"  maxlength="6"></label>
	人，其他
<label onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='其他' name='"其他"' field="partyOtherSubjectionNum" style="width:100"  maxlength="6"></label>
	人。</span></p>	
	
<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt; tab-stops: 53.25pt'
	align="left"><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-bidi-font-weight: bold'>10</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'>、党员学习教育方式有：
<br/>
<input id=''field='partyStudyWaySelf' type='checkbox' value='1' disabled/>个人自学
<input id=''field='partyStudyWayTalk' type='checkbox' value='1' disabled/>支部学习讨论
<input id=''field='partyStudyWayChair' type='checkbox' value='1' disabled/>听辅导报告或专题讲座
<input id=''field='partyStudyWayVisit' type='checkbox' value='1' disabled/>外出交流参观
<br/>
<input id=''field='partyStudyWayArt' type='checkbox' value='1' disabled/>组织文艺活动
<input id='partyStudyWayOther'field='partyStudyWayOther' type='checkbox' value='1' onchange=''disabled/>其他
</span></p>

<p class=MsoNormal 
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt; tab-stops: 53.25pt'
	align="left"><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-bidi-font-weight: bold'></span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'>请说明：</span><span>
<textarea id='partyOtherStudyWay' field='partyOtherStudyWay'style='width:600' rows='5'readonly></textarea>
</span></p>


<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt; tab-stops: 53.25pt'
	align="left"><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-bidi-font-weight: bold'>11</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'>、本年度共开展党员活动
<label onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='本年度共开展党员活动' name='"本年度共开展党员活动"' field="partyActivityNum" style="width:100"  maxlength="6"></label>
次，为群众办实事、办好事
<label onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='为群众办实事、办好事' name='"为群众办实事、办好事"' field="activityGoodNum" style="width:100"  maxlength="6"></label>
件。
</span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt; tab-stops: 53.25pt'
	align="left"><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-bidi-font-weight: bold'>12</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'>、是否开展服务承诺：</span><span>
	<label id="" field="ifAcceptance" style="width: 100" dataset="YorNDataset"></label></span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt; tab-stops: 53.25pt'
	align="left"><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-bidi-font-weight: bold'>13</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'>、专职党务工作者
<label onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='专职党务工作者' name='"专职党务工作者"' field="partyWorkerNum" style="width:100"  maxlength="6"></label>
人。党建联络员姓名
<label type="text" title='党建联络员姓名' name='"党建联络员姓名"' field="partyCoordinatorName" style="width:150"  maxlength="50"></label>
，联系方式
<label type="text" title='联系方式' name='"联系方式"' field="partyCoordinatorContact" style="width:300"  maxlength="50"></label></span></p>
<div  id="partyDiv" style='display:block '>
<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt; tab-stops: 53.25pt'
	align="left"><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-bidi-font-weight: bold'>14</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'>、本年度开展党建活动情况（不少于150字）</span><span>
</span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt; tab-stops: 53.25pt'
	align="center"><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-bidi-font-weight: bold'></span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'></span><span>
<textarea field='partyActivityDetail' style='width:750' rows='8'readonly></textarea>
</span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt; tab-stops: 53.25pt'
	align="left"><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-bidi-font-weight: bold'>15</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'>、对于加强社会组织党组织建设工作有何思路或建议：</span><span>
</span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt; tab-stops: 53.25pt'
	align="center"><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-bidi-font-weight: bold'></span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'></span><span>
<textarea field='partySuggest' style='width:750' rows='8'readonly></textarea>
</span></p>
</div>
</div>
</div>
</div>
</form>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</body>
</html>
