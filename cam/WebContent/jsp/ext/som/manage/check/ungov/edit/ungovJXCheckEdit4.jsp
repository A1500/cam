<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<html>

<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<title>民 办 非 企 业 单 位 </title>
<next:ScriptManager/>
<script type="text/javascript" src="../../js/float.js"></script>
<link href="../../css/float.css" type="text/css" rel="stylesheet" />
<script language="javascript">
var taskCode='<%=request.getParameter("taskCode")%>';
//初始化
function init(){
	somJxPeopleDataSet.setParameter("TASK_CODE", taskCode);
	somJxPeopleDataSet.load();
	somJxPeopleDataSet.on('load',function (){
		if(somJxPeopleDataSet.getCount() == 0){
			somJxPeopleDataSet.newRecord();
		}
	});
	//创建页面导航下拉框
	createUngovEditSelect();
}
function save(){
	var somJxPeopleDataSetIsValidate = somJxPeopleDataSet.isValidate();
	if(somJxPeopleDataSetIsValidate!=true){
		L5.Msg.alert("提示",somJxPeopleDataSetIsValidate);
		return "break";
	}
	var practitionerNum=document.getElementById("practitionerNum").value;
	var womanPracNum=document.getElementById("womanPracNum").value;
	if(parseInt(womanPracNum) > (parseInt(practitionerNum))){
		L5.Msg.alert("提示","从业人员中女性人数不能大于从业人员总数！");
		return "break";
	}
	var principalNum=document.getElementById("principalNum").value;
	var womenPrincipalNum=document.getElementById("womenPrincipalNum").value;
	if(parseInt(womenPrincipalNum) > (parseInt(principalNum))){
		L5.Msg.alert("提示","女性负责人数不能大于负责人总数！");
		return "break";
	}
	
	var somJxPeopleRecord=somJxPeopleDataSet.getCurrent();
	var parttimeNum=somJxPeopleRecord.get('parttimeNum');
	var parttimeGovNum=somJxPeopleRecord.get('parttimeGovNum');
	var enterprisesNum=somJxPeopleRecord.get('enterprisesNum');
	var otherNum=somJxPeopleRecord.get('otherNum');
	if(parseInt(parttimeNum) != (parseInt(parttimeGovNum)+parseInt(enterprisesNum)+parseInt(otherNum))){
		L5.Msg.alert("提示","兼职人员数不正确！\n\n兼职人员数=兼职人员在国家机关任职人数+企事业单位任职人数+其他人数");
		return "break";
	}
	if(parseInt(somJxPeopleRecord.get('practitionerNum')) != (parseInt(somJxPeopleRecord.get('parttimeNum'))+parseInt(somJxPeopleRecord.get('fulltimeNum')))){
		L5.Msg.alert("提示","数据逻辑不正确！\n\n从业人员总数=专职人员数+兼职人员数");
		return "break";
	}
	if(parseInt(somJxPeopleRecord.get('practitionerNum')) != (parseInt(somJxPeopleRecord.get('underThirtyfiveNum'))+parseInt(somJxPeopleRecord.get('thirtysixToFiftyNum'))+parseInt(somJxPeopleRecord.get('fiftyoneToSixtyNum'))+parseInt(somJxPeopleRecord.get('aboveSixtyNum')))){
		L5.Msg.alert("提示","数据逻辑不正确！\n\n从业人员总数=35岁及以下人数+36—50岁人数+51—60岁人数+60岁以上人数");
		return "break";
	}
	if(parseInt(somJxPeopleRecord.get('practitionerNum')) != (parseInt(somJxPeopleRecord.get('underHighschoolNum'))+parseInt(somJxPeopleRecord.get('universityNum'))+parseInt(somJxPeopleRecord.get('aboveMasterNum')))){
		L5.Msg.alert("提示","数据逻辑不正确！\n\n从业人员总数=高中及以下人数+大学本科及专科人数+硕士及以上文凭人数");
		return "break";
	}
	var command = new L5.Command("com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckCommand");
	command.setParameter("taskCode",taskCode);
	command.setParameter("somJxPeopleRecord",somJxPeopleRecord);
	command.execute("savePageM4");
	if (!command.error) {
		alert("保存成功！");			
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
</script>
<style>

</style>
</head>

<body>
<model:datasets>
	<model:dataset id="somJxPeopleDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxpeople.cmd.SomJxPeopleQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxpeople.dao.SomJxPeople">
			<model:field name="practitionerNum" type="string" rule="require" />
			<model:field name="womanPracNum" type="string" rule="require" />
			<model:field name="fulltimeNum" type="string" rule="require" />
			<model:field name="retiredNum" type="string" rule="require" />
			<model:field name="fulltimeContractNum" type="string" rule="require" />
			<model:field name="parttimeGovNum" type="string" rule="require" />
			<model:field name="enterprisesNum" type="string" rule="require" />
			<model:field name="otherNum" type="string" rule="require" />
			<model:field name="underThirtyfiveNum" type="string" rule="require" />
			<model:field name="thirtysixToFiftyNum" type="string" rule="require" />
			<model:field name="fiftyoneToSixtyNum" type="string" rule="require" />
			<model:field name="aboveSixtyNum" type="string" rule="require" />
			<model:field name="underHighschoolNum" type="string" rule="require" />
			<model:field name="universityNum" type="string" rule="require" />
			<model:field name="aboveMasterNum" type="string" rule="require" />
			<model:field name="principalNum" type="string" rule="require" />		
			<model:field name="womenPrincipalNum" type="string" rule="require" />			
			<model:field name="legalPeople" type="string" rule="require" />
			<model:field name="legalPolitical" type="string" rule="require" />
			<model:field name="legalSex" type="string" rule="require" />
			<model:field name="legalEducation" type="string" rule="require" />
			<model:field name="ifLegalRetired" type="string" rule="require" />
			<model:field name="legalPhone" type="string" rule="require" />
			<model:field name="legalMobile" type="string" rule="require" />
			<model:field name="ifLegalFulltime" type="string" rule="require" />
			<model:field name="legalWorkName" type="string" rule="require" />
			<model:field name="parttimeNum" type="string" rule="require" />
			<model:field name="partyNumNation" type="string" rule="require" />
			<model:field name="partyNumProvince" type="string" rule="require" />
			<model:field name="npcNumNation" type="string" rule="require" />
			<model:field name="npcNumProvince" type="string" rule="require" />
			<model:field name="cppccNumNation" type="string" rule="require" />
			<model:field name="cppccNumProvince" type="string" rule="require" />
		</model:record>
	</model:dataset>
	<model:dataset id="politicsDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_POLITICAL'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>	
	<model:dataset id="ifFulltimeDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_IF_FULLTIME'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="eduDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='dic_education'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="yesornoDataSet" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>		
	<model:dataset id="sexDataSet" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<div id="float" >
	<input type="button" value="下一页" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="nextPageM('5')"/>
	<input type="button" value="上一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="lastPageM('3')"/>
	<input type="button" value="保存" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="save();"/>
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:320px;" onclick="backM();"/>
</div>
<div align=center>
<div align=left style="margin-top: 60px; width: 800px">

<p class=MsoNormal
	style='line-height: 24.0pt; mso-line-height-rule: exactly'><b><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>二、人员情况<span
	lang=EN-US><o:p></o:p></span></span></b></p>
<form method="post" onsubmit="return false" dataset="somJxPeopleDataSet">
<p class=MsoNormal
	style='line-height: 24.0pt; mso-line-height-rule: exactly'><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>（一）<span
	lang=EN-US></span>从业人员总数 <input
	onkeyup="value=value.replace(/[^\d]/g,'')"id='practitionerNum' field='practitionerNum'
	style='width: 70' maxlength='6' name='"从业人员总数"'/> <u><span lang=EN-US><span
	style='mso-spacerun: yes'> </span></span></u>人。 其中女性人数 <input
	onkeyup="value=value.replace(/[^\d]/g,'')"id='womanPracNum' field='womanPracNum' style='width: 70'
	maxlength='6' name='"其中女性人数"'/>人。 <span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='margin-left: 52.5pt; mso-para-margin-left: 3.0gd; text-indent: -21.0pt; mso-char-indent-count: -1.5; line-height: 24.0pt; mso-line-height-rule: exactly; mso-list: l1 level1 lfo1'><![if !supportLists]><span
	lang=EN-US
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋; mso-hansi-font-family: 仿宋; mso-bidi-font-family: 仿宋'><span
	style='mso-list: Ignore'></span></span><![endif]><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋; mso-hansi-font-family: 仿宋; color: black'>1、专职人员数
<input
	onkeyup="value=value.replace(/[^\d]/g,'')"id='fulltimeNum' field='fulltimeNum'
	style='width: 70' maxlength='6' name='"专职人员数"'/>	
	
	人， 其中离退休返聘<input
	onkeyup="value=value.replace(/[^\d]/g,'')"id='retiredNum' field='retiredNum'
	style='width: 70' maxlength='6' name='"其中离退休返聘"'/>人，专职人员中签订劳动合同
<input onkeyup="value=value.replace(/[^\d]/g,'')" id='fulltimeContractNum'
	field='fulltimeContractNum' style='width: 70' maxlength='6' name='"专职人员中签订劳动合同"'/> <u><span
	lang=EN-US><span style='mso-spacerun: yes'> </span></span></u> <u><span lang=EN-US><span
	style='mso-spacerun: yes'></span></span></u>人；兼职人员数
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='兼职人员总数' name='"兼职人员总数"' field="parttimeNum" style="width:10%"  maxlength="6"/>	
	人，其中兼职人员在国家机关任职
	 <input
	onkeyup="value=value.replace(/[^\d]/g,'')"id='parttimeGovNum' field='parttimeGovNum'
	style='width: 70' maxlength='6' name='"兼职人员中国家机关在职"'/> <u><span lang=EN-US><span
	style='mso-spacerun: yes'></span></span></u>人，企事业单位在职 <input
	onkeyup="value=value.replace(/[^\d]/g,'')"id='enterprisesNum' field='enterprisesNum'
	style='width: 70' maxlength='6' name='"企事业单位在职"'/> <u><span lang=EN-US><span
	style='mso-spacerun: yes'></span></span></u>人，其他 <input
	onkeyup="value=value.replace(/[^\d]/g,'')"id='otherNum' field='otherNum'
	style='width: 70' maxlength='6' name='"其他"'/> <u><span lang=EN-US><span
	style='mso-spacerun: yes'></span></span></u>人。<span lang=EN-US><o:p></o:p></span></span></span></p>

<p class=MsoNormal
	style='margin-left: 52.5pt; mso-para-margin-left: 3.0gd; text-indent: -21.0pt; mso-char-indent-count: -1.5; line-height: 24.0pt; mso-line-height-rule: exactly; mso-list: l1 level1 lfo1'><![if !supportLists]><span
	lang=EN-US
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋; mso-hansi-font-family: 仿宋; mso-bidi-font-family: 仿宋'><span
	style='mso-list: Ignore'></span></span><![endif]><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋; mso-hansi-font-family: 仿宋; color: black'>2、年龄结构</span><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>：<span
	lang=EN-US></span>35岁及以下 <input
	onkeyup="value=value.replace(/[^\d]/g,'')" id='underThirtyfiveNum'field='underThirtyfiveNum'
	style='width: 70' maxlength='6' name='"35岁及以下"'/> <u><span lang=EN-US><span
	style='mso-spacerun: yes'></span></span></u>人，36—50岁 <input
	onkeyup="value=value.replace(/[^\d]/g,'')"id='thirtysixToFiftyNum' field='thirtysixToFiftyNum'
	style='width: 70' maxlength='6' name='"36—50岁"'/> <u><span lang=EN-US><span
	style='mso-spacerun: yes'></span></span></u>人，51—60岁 <input
	onkeyup="value=value.replace(/[^\d]/g,'')"id='fiftyoneToSixtyNum' field='fiftyoneToSixtyNum'
	style='width: 70' maxlength='6' name='"51—60岁"'/> <u><span lang=EN-US><span
	style='mso-spacerun: yes'></span></span></u>人，60岁以上 <input
	onkeyup="value=value.replace(/[^\d]/g,'')"id='aboveSixtyNum' field='aboveSixtyNum'
	style='width: 70' maxlength='6' name='"60岁以上"'/> <u><span lang=EN-US><span
	style='mso-spacerun: yes'></span></span></u>人。<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal align=left
	style='margin-left: 52.5pt; mso-para-margin-left: 3.0gd; text-align: left; text-indent: -21.0pt; mso-char-indent-count: -1.5; line-height: 24.0pt; mso-line-height-rule: exactly; mso-list: l1 level1 lfo1'><![if !supportLists]><span
	lang=EN-US
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋; mso-hansi-font-family: 仿宋; mso-bidi-font-family: 仿宋; color: black'><span
	style='mso-list: Ignore'></span></span><![endif]><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>3、学历结构：高中及以下
<input onkeyup="value=value.replace(/[^\d]/g,'')"id='underHighschoolNum'
	field='underHighschoolNum' style='width: 70' maxlength='6' name='"高中及以下"'/> <u><span
	lang=EN-US><span style='mso-spacerun: yes'></span></span></u>人，大学本科及专科 <input
	onkeyup="value=value.replace(/[^\d]/g,'')"id='universityNum' field='universityNum'
	style='width: 70' maxlength='6' name='"大学本科及专科"'/> <u><span lang=EN-US><span
	style='mso-spacerun: yes'></span></span></u>人，硕士及以上 <input
	onkeyup="value=value.replace(/[^\d]/g,'')"id='aboveMasterNum' field='aboveMasterNum'
	style='width: 70' maxlength='6' name='"硕士及以上"'/> <u><span lang=EN-US><span
	style='mso-spacerun: yes'></span><span style='mso-spacerun: yes'></span></span></u>人。<span
	lang=EN-US><o:p></o:p></span></span></p>
	
<p class=MsoNormal align=left
	style='margin-left: 52.5pt; mso-para-margin-left: 3.0gd; text-align: left; text-indent: -21.0pt; mso-char-indent-count: -1.5; line-height: 24.0pt; mso-line-height-rule: exactly; mso-list: l1 level1 lfo1'><![if !supportLists]><span
	lang=EN-US
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋; mso-hansi-font-family: 仿宋; mso-bidi-font-family: 仿宋; color: black'><span
	style='mso-list: Ignore'></span></span><![endif]><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>4.从业人员中担任党代表人数
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='从业人员中担任党代表人数' name='"从业人员中担任党代表人数"' field="aboveCountyNum" style="width:10%"  maxlength="6"/>
	<u></u>,其中，省级及以下的
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='从业人员中省级及以下担任党代表人数' name='"从业人员中省级及以下担任党代表人数"' field="partyNumProvince" style="width:10%"  maxlength="6"/>
人，全国性的
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='从业人员中全国性的担任党代表人数' name='"从业人员中全国性的担任党代表人数"' field="partyNumNation" style="width:10%"  maxlength="6"/>
 人；从业人员中担任人大代表人数
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='人大代表' name='"人大代表"' field="npcNum" style="width:10%"  maxlength="6"/>
其中，省级及以下的
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='省级及以下人大代表' name='"省级及以下人大代表"' field="npcNumProvince" style="width:10%"  maxlength="6"/>
人，全国性的
 <input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='全国性人大代表' name='"全国性人大代表"' field="npcNumNation" style="width:10%"  maxlength="6"/>
人；
	<u> </u>担任政协委员人数
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='政协委员' name='"政协委员"' field="cppccNum" style="width:10%"  maxlength="6"/>
	<u> </u>。其中，省级及以下的
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='省级及以下的政协委员' name='"省级及以下的政协委员"' field="cppccNumProvince" style="width:10%"  maxlength="6"/>	
人，全国性的
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='全国性的政协委员' name='"全国性的政协委员"' field="cppccNumNation" style="width:10%"  maxlength="6"/>
人。</span></p>

<p class=MsoNormal align=left
	style='text-align: left; line-height: 24.0pt; mso-line-height-rule: exactly'><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>（二）负责人总数
<input onkeyup="value=value.replace(/[^\d]/g,'')"id='principalNum' field='principalNum'
	style='width: 70' maxlength='6' name='"负责人总数"'/> <u><span lang=EN-US><span
	style='mso-spacerun: yes'> </span></span></u>其中女性数 <input
	onkeyup="value=value.replace(/[^\d]/g,'')"id='womenPrincipalNum' field='womenPrincipalNum'
	style='width: 70' maxlength='6' name='"其中女性数"'/> <u><span lang=EN-US><span
	style='mso-spacerun: yes'> </span><o:p></o:p></span></u></span></p>

<p class=MsoNormal
	style='line-height: 24.0pt; mso-line-height-rule: exactly'><span
	lang=EN-US
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
	style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp; </span></span><span lang=EN-US
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 黑体'><span
	style='mso-spacerun: yes'>&nbsp;&nbsp;</span>*</span><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 黑体'>负责人指单位领导，包括法定代表人、正副院长、园长、主任、理事长等。<span
	lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='line-height: 24.0pt; mso-line-height-rule: exactly'><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>（三）法定代表人（负责人）情况<span
	lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 42.0pt; mso-char-indent-count: 3.0; line-height: 24.0pt; mso-line-height-rule: exactly'><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>姓名
<input field='legalPeople' style='width: 100' maxlength='30' name='"法定代表人（负责人）性别"'/> <u><span
	lang=EN-US><span style='mso-spacerun: yes'> </span></span></u><span
	lang=EN-US><span style='mso-spacerun: yes'>&nbsp;&nbsp;</span></span>性别
<select field="legalSex"name='"法定代表人（负责人）性别"'>
	<option dataset="sexDataSet"></option>
</select> <u><span lang=EN-US><span style='mso-spacerun: yes'></span></span></u><span
	lang=EN-US><span style='mso-spacerun: yes'>&nbsp;&nbsp;</span></span>电话
<input field='legalPhone' style='width: 100' maxlength='30' name='"法定代表人（负责人）电话"'/> <u><span
	lang=EN-US><span style='mso-spacerun: yes'> </span></span></u><span
	lang=EN-US><span style='mso-spacerun: yes'>&nbsp;&nbsp;</span></span>手机
<input onkeyup="value=value.replace(/[^\d]/g,'')" field='legalMobile'
	style='width: 100' maxlength='30' name='"法定代表人（负责人）手机"'/> <u><span lang=EN-US><span
	style='mso-spacerun: yes'> </span></span></u><span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 42.0pt; mso-char-indent-count: 3.0; line-height: 24.0pt; mso-line-height-rule: exactly'><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>政治面貌
<select field="legalPolitical"name='"法定代表人（负责人）政治面貌"'>
	<option dataset="politicsDataSet"></option>
</select> <u><span lang=EN-US><span style='mso-spacerun: yes'>
</span></span></u><span lang=EN-US><span style='mso-spacerun: yes'>&nbsp;&nbsp;</span></span>文化程度
<select field="legalEducation" name='"法定代表人（负责人）文化程度"'>
	<option dataset="eduDataSet"></option>
</select> <u><span lang=EN-US><span style='mso-spacerun: yes'></span></span></u><span
	lang=EN-US><span style='mso-spacerun: yes'>&nbsp;&nbsp;</span></span>离退休否
<select field="ifLegalRetired"name='"法定代表人（负责人）离退休否"'>
	<option dataset="yesornoDataSet"></option>
</select> <u><span lang=EN-US><span style='mso-spacerun: yes'></span></span></u><span
	lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 42.0pt; mso-char-indent-count: 3.0; line-height: 24.0pt; mso-line-height-rule: exactly'><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>专职<span
	lang=EN-US>/</span>兼职 <select field="ifLegalFulltime"name='"法定代表人（负责人）专职/兼职"'>
	<option dataset="ifFulltimeDataSet"></option>
</select> <u><span lang=EN-US><span style='mso-spacerun: yes'>
</span></span></u><span lang=EN-US><span style='mso-spacerun: yes'>&nbsp;&nbsp;</span></span>工作单位
<input field='legalWorkName' style='width: 300' maxlength='50' name='"法定代表人（负责人）工作单位"'/> <u><span
	lang=EN-US><span style='mso-spacerun: yes'> </span></span></u><span
	lang=EN-US><span style='mso-spacerun: yes'>&nbsp;&nbsp;</span><o:p></o:p></span></span></p>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</form>
</div>
</div>
</body>
</html>
