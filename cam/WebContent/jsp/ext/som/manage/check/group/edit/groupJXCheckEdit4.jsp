<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.IdHelp;"%>
<html>

<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<title>社 会 团 体</title>
<%
	String taskCode = (String)request.getParameter("taskCode");
	if(taskCode==null){
		taskCode=IdHelp.getUUID32();
	}
%>
<next:ScriptManager/>
		<script type="text/javascript" src="../../js/float.js"></script>
		<link href="../../css/float.css" type="text/css" rel="stylesheet" />
		<script language="javascript">
			var taskCode='<%=taskCode%>';
			var taskId='<%=request.getParameter("taskId")%>';
			var batch='<%=request.getParameter("batch")%>';
			var batchYear='<%=request.getParameter("batchYear")%>';
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
				createGroupEditSelect();
			}
			function save(){
				var somJxPeopleDataSetIsValidate = somJxPeopleDataSet.isValidate();
				if(somJxPeopleDataSetIsValidate != true){
					L5.Msg.alert("提示",somJxPeopleDataSetIsValidate);
					return "break";
				}
				
	var practitionerNum=document.getElementById("practitionerNum").value;	
	var womanPracNum=document.getElementById("womanPracNum").value;
	if(parseInt(womanPracNum) > (parseInt(practitionerNum))){
		L5.Msg.alert("提示","从业人员中女性数不能大于从业人员数！");
		return "break";
	}
	var principalNum=document.getElementById("principalNum").value;	
	var womenPrincipalNum=document.getElementById("womenPrincipalNum").value;
	if(parseInt(womenPrincipalNum) > (parseInt(principalNum))){
		L5.Msg.alert("提示","负责人中女性数不能大于负责人数！");
		return "break";
	}
				var somJxPeopleRecord=somJxPeopleDataSet.getCurrent();
	var parttimeNum=somJxPeopleRecord.get('parttimeNum');
	var parttimeGovNum=somJxPeopleRecord.get('parttimeGovNum');
	var enterprisesNum=somJxPeopleRecord.get('enterprisesNum');
	var otherNum=somJxPeopleRecord.get('otherNum');
	if(parseInt(parttimeNum) != (parseInt(parttimeGovNum)+parseInt(enterprisesNum)+parseInt(otherNum))){
		L5.Msg.alert("提示","兼职人员总数不正确！\n兼职人员总数=兼职人员在国家机关任职人数+企事业单位任职人数+其他人数");
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
	if(parseInt(somJxPeopleRecord.get('practitionerNum')) != (parseInt(somJxPeopleRecord.get('underHighschoolNum'))+parseInt(somJxPeopleRecord.get('universityNum'))+parseInt(somJxPeopleRecord.get('aboveMasterNum'))+parseInt(somJxPeopleRecord.get('fromAbroadNum')) )){
		L5.Msg.alert("提示","数据逻辑不正确！\n\n从业人员总数=高中及以下人数+大学本科及专科人数+硕士及以上文凭人数+留学半年以上归国人员人数");
		return "break";
	}
				var command = new L5.Command("com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckCommand");
				command.setParameter("taskCode",taskCode);
				command.setParameter("somJxPeopleRecord",somJxPeopleRecord);
				command.execute("savePage4");
				if (!command.error) {
					alert("保存成功！");		
				}else{
					L5.Msg.alert('提示',"保存时出现错误！"+command.error);
				}
			}
		</script>
<style>
.MsoNormal{
	text-align:left;
}
</style>
</head>

<body>
<model:datasets>
	<model:dataset id="somJxPeopleDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxpeople.cmd.SomJxPeopleQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxpeople.dao.SomJxPeople">
			<model:field name="practitionerNum" type="string" rule="require" />
			<model:field name="womanPracNum" type="string" rule="require" />
			<model:field name="fulltimeNum" type="string" rule="require" />
			<model:field name="fulltimeContractNum" type="string" rule="require" />
			<model:field name="retiredNum" type="string" rule="require" />
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
			<model:field name="fromAbroadNum" type="string" rule="require" />
			<model:field name="caseworkerNum" type="string" rule="require" />
			<model:field name="vawirrmqNum" type="string" rule="require" />
			<model:field name="aboveCountyNum" type="string" rule="require" />
			<model:field name="npcNum" type="string" rule="require" />
			<model:field name="cppccNum" type="string" rule="require" />
			<model:field name="provincialNum" type="string" rule="require" />
			<model:field name="boardNum" type="string" rule="require" />
			<model:field name="chujiNum" type="string" rule="require" />
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
			<model:field name="legalOtherDuty" type="string" rule="require" />
			<model:field name="presidentName" type="string" rule="require" />
			<model:field name="presidentSex" type="string" rule="require" />
			<model:field name="presidentEducation" type="string" rule="require" />
			<model:field name="ifPresidentRetired" type="string" rule="require" />
			<model:field name="presidentPhone" type="string" rule="require" />
			<model:field name="presidentMobile" type="string" rule="require" />
			<model:field name="ifPresidentFulltime" type="string" rule="require" />
			<model:field name="presidentWorkName" type="string" rule="require" />
			<model:field name="presidentOtherDuty" type="string" rule="require" />
			<model:field name="secretaryName" type="string" rule="require" />
			<model:field name="secretaryPolitical" type="string" rule="require" />
			<model:field name="secretarySex" type="string" rule="require" />
			<model:field name="secretaryEducation" type="string" rule="require" />
			<model:field name="ifSecretaryRetired" type="string" rule="require" />
			<model:field name="secretaryPhone" type="string" rule="require" />
			<model:field name="secretaryMobile" type="string" rule="require" />
			<model:field name="secretaryEmail" type="string" rule="require" />
			<model:field name="ifSecretaryFulltime" type="string" rule="require" />
			<model:field name="secretaryWorkName" type="string" rule="require" />
			<model:field name="secretaryOtherDuty" type="string" rule="require" />
			<model:field name="parttimeNum" type="string" rule="require" />
			<model:field name="partyNumNation" type="string" rule="require" />
			<model:field name="partyNumProvince" type="string" rule="require" />
			<model:field name="npcNumNation" type="string" rule="require" />
			<model:field name="npcNumProvince" type="string" rule="require" />
			<model:field name="cppccNumNation" type="string" rule="require" />
			<model:field name="cppccNumProvince" type="string" rule="require" />
			<model:field name="retiredProvincialNum" type="string" rule="require" />
			<model:field name="retiredBoardNum" type="string" rule="require" />
			<model:field name="retiredChujiNum" type="string" rule="require" />
			<model:field name="mgRetiredProvincialNum" type="string" rule="require" />
			<model:field name="mgRetiredBoardNum" type="string" rule="require" />
			<model:field name="mgRetiredChujiNum" type="string" rule="require" />
			<model:field name="mgProvincialNum" type="string" rule="require" />
			<model:field name="mgBoardNum" type="string" rule="require" />
			<model:field name="mgChujiNum" type="string" rule="require" />
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
		<input type="button" value="下一页" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="nextPage('5')"/>
		<input type="button" value="上一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="lastPage('3')"/>
	<!--[if lte IE 7]><div></div><![endif]-->
	<input type="button" value="保存" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="save();"/>
	<!--[if lte IE 7]><div></div><![endif]-->
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:320px;" onclick="back();"/>
</div>
<div style="text-align: center">
<form method="post"onsubmit="return false" dataset="somJxPeopleDataSet">
<div class=Section1 style="width: 800px;">
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal style='text-indent: 32.15pt'><b><span
	style='font-size: 16.0pt; font-family: 黑体'>三、人员情况</span></b></p>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal style="text-align: left"><span
	style='font-size: 16.0pt; font-family: 仿宋'>&nbsp;&nbsp;&nbsp;&nbsp;（一）从业人员总数
<input type="text" title='从业人员总数' name='"从业人员总数"' onkeyup="value=value.replace(/[^\d]/g,'')"id='practitionerNum' field="practitionerNum" style="width:10%"  maxlength="6"/>	
人，（其中女性数
<input type="text" title='女性总数' name='"女性总数"' onkeyup="value=value.replace(/[^\d]/g,'')"id='womanPracNum' field="womanPracNum" style="width:10%"  maxlength="6"/>	

人）。
	</span></p>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal><span
	style='font-size: 16.0pt; font-family: 仿宋; '>&nbsp;&nbsp;1.专职人员总数
<input type="text" title='专职人员' name='"专职人员"' onkeyup="value=value.replace(/[^\d]/g,'')" field="fulltimeNum" style="width:10%"  maxlength="6"/>
	<u></u>人。其中，专职人员中签订劳动合同
<input  onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='专职人员中签订劳动合同' name='"专职人员中签订劳动合同"' field="fulltimeContractNum" style="width:10%"  maxlength="50"/>
	<u> </u>人，离退休返聘
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='离退休返聘' name='"离退休返聘"' field="retiredNum" style="width:10%"  maxlength="6"/>
	人；</span><span style='font-size: 16.0pt; font-family: 仿宋'>兼职人员数
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='兼职人员总数' name='"兼职人员总数"' field="parttimeNum" style="width:10%"  maxlength="6"/>	
	人。其中，兼职人员在国家机关任职
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='在国家机关任职' name='"在国家机关任职"' field="parttimeGovNum" style="width:10%"  maxlength="6"/>
	人，在企事业单位任职<input type="text" onkeyup="value=value.replace(/[^\d]/g,'')" title='在企事业单位任职' name='"在企事业单位任职"' field="enterprisesNum" style="width:10%"  maxlength="6"/>
	人，其他
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='其他' name='"其他"' field="otherNum" style="width:10%"  maxlength="6"/>
	<u></u>人。</span></p>
<p class=MsoNormal><span
	style='font-size: 16.0pt; font-family: 仿宋; color: black'>&nbsp;&nbsp;2.年龄结构：35岁及以下
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='35岁及以下' name='"35岁及以下"' field="underThirtyfiveNum" style="width:10%"  maxlength="6"/>
	人，36—50岁
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='36——50岁' name='"36——50岁"' field="thirtysixToFiftyNum" style="width:10%"  maxlength="6"/>
	人，51—60岁
<p style="text-align:left" /><input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='51——60岁' name='"51——60岁"' field="fiftyoneToSixtyNum" style="width:10%"  maxlength="6"/>
	人，</span><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋; letter-spacing: -1.4pt'>60岁以上
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='60岁以上' name='"60岁以上"' field="aboveSixtyNum" style="width:10%"  maxlength="6"/>
	人。</span></span></p>
<p class=MsoNormal><span
	style='font-size: 16.0pt; font-family: 仿宋'>&nbsp;&nbsp;3.学历结构：高中及以下
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='高中及以下学历' name='"高中及以下学历"' field="underHighschoolNum" style="width:10%"  maxlength="6"/>
	人，大学本科及专科
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='大学本科及专科学历' name='"大学本科及专科学历"' field="universityNum" style="width:10%"  maxlength="6"/>
	人，硕士<p style="text-align:left" />及以上
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='硕士及以上学历' name='"硕士及以上学历"' field="aboveMasterNum" style="width:10%"  maxlength="6"/>
	人，</span><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋; letter-spacing: -1.4pt'>
	留学半年以上归国人员
<input onkeyup="value=value.replace(/[^\d]/g,'')"  type="text" title='留学半年以上归国人员' name='"留学半年以上归国人员"' field="fromAbroadNum" style="width:10%"  maxlength="6"/>
	人。</span></p>
<p class=MsoNormal><span style='font-size: 16.0pt; font-family: 仿宋'>&nbsp;&nbsp;4.从业人员中持有“社会工作者”资格证书
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='从业人员中持有“社会工作者”资格证书'name='"从业人员中持有“社会工作者”资格证书"' field="caseworkerNum" style="width:10%"  maxlength="6"/>
	<u>
	</u>人，持有从事岗位相应<p style="text-align: left" />专业技术资格证书
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='持有从事岗位相应专业技术资格证书' name='"持有从事岗位相应专业技术资格证书"' field="vawirrmqNum" style="width:10%"  maxlength="6"/>
	<u> </u>人。</span></p>
<p class=MsoNormal><span
	style='font-size: 16.0pt; font-family: 仿宋'>&nbsp;&nbsp;5.从业人员中担任党代表人数
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
<p class=MsoNormal><span
	style='font-size: 16.0pt; font-family: 仿宋'>&nbsp;&nbsp;6.从业人员中具有行政级别：（现职：省部级
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='省部级' name='"省部级"' field="provincialNum" style="width:10%"  maxlength="6"/>	
	<u></u>人、厅局级
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='厅局级' name='"厅局级"' field="boardNum" style="width:10%"  maxlength="6"/>	
	<u></u>人、处级
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='处级' name='"处级"' field="chujiNum" style="width:10%"  maxlength="6"/>
	<u></u>人；离退休：省部级
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='省部级' name='"省部级"' field="retiredProvincialNum" style="width:10%"  maxlength="6"/>	
	<u></u>人、厅局级
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='厅局级' name='"厅局级"' field="retiredBoardNum" style="width:10%"  maxlength="6"/>	
	<u></u>人、处级
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='处级' name='"处级"' field="retiredChujiNum" style="width:10%"  maxlength="6"/>
	<u></u>人；</span></p>
	
<p class=MsoNormal><span
	style='font-size: 16.0pt; font-family: 仿宋'>&nbsp;&nbsp;7.名誉会长和顾问：（现职：省部级
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='省部级' name='"省部级"' field="mgProvincialNum" style="width:10%"  maxlength="6"/>	
	<u></u>人、厅局级
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='厅局级' name='"厅局级"' field="mgBoardNum" style="width:10%"  maxlength="6"/>	
	<u></u>人、处级
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='处级' name='"处级"' field="mgChujiNum" style="width:10%"  maxlength="6"/>
	<u></u>人；离退休：省部级
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='省部级' name='"省部级"' field="mgRetiredProvincialNum" style="width:10%"  maxlength="6"/>	
	<u></u>人、厅局级
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='厅局级' name='"厅局级"' field="mgRetiredBoardNum" style="width:10%"  maxlength="6"/>	
	<u></u>人、处级
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='处级' name='"处级"' field="mgRetiredChujiNum" style="width:10%"  maxlength="6"/>
	<u></u>人；</span></p>


<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal style="text-align: left"><span
	style='font-size: 16.0pt; font-family: 仿宋;'>&nbsp;&nbsp;&nbsp;&nbsp;（二）负责人总数
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='负责人总数' name='"负责人总数"'id='principalNum' field="principalNum" style="width:10%"  maxlength="6"/>	
	</span><span
	style='font-size: 16.0pt; font-family: 仿宋'>人（其中女性数
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" title='负责人总数中女性数' name='"负责人总数中女性数"'id='womenPrincipalNum' field="womenPrincipalNum" style="width:10%"  maxlength="6"/>	
	</span><u></u><span style='font-size: 16.0pt; font-family: 仿宋'>）。</span></p>
<p class=MsoNormal style="text-align: left"><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋'>
	<b style="color:red">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*</b></span><strong><span
	style='font-size: 16.0pt; font-family: 仿宋; font-weight: normal'>负责人指法定代表人、会长、副会长和秘书长</span></strong></p>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal style="text-align: left"><span
	style='font-size: 16.0pt; font-family: 仿宋'>&nbsp;&nbsp;&nbsp;&nbsp;（三）法定代表人情况</span></p>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal style="text-align: left"><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;姓名
<input type="text" title='法定代表人姓名' name='"法定代表人姓名"' field="legalPeople" style="width:10%"  maxlength="50"/>
	</span><u></u><span lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'>&nbsp;</span><span
	style='font-size: 16.0pt; font-family: 仿宋'>政治面貌
<select field="legalPolitical" name='"法定代表人政治面貌"' title='法定代表人政治面貌'><option dataset="politicsDataSet"></option></select>
	</span><u></u><span lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'>&nbsp;</span><span
	style='font-size: 16.0pt; font-family: 仿宋'>性别
<select id="sex" field="legalSex"title="法定代表人性别" name='"法定代表人性别"'><option dataset="sexDataSet"></option></select>
	</span><u></u><br><p style="text-align:left"/><span lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'>&nbsp;</span><span
	style='font-size: 16.0pt; font-family: 仿宋'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;文化程度
<select field="legalEducation" title="文化程度" name='"法定代表人文化程度"'><option dataset="eduDataSet"></option></select>	
	</span><u></u><span lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'>&nbsp;</span><span
	style='font-size: 16.0pt; font-family: 仿宋'>离退休否
<select id="ifServe" field="ifLegalRetired" name='"法定代表人离退休否"' title='法定代表人离退休否'><option dataset="yesornoDataSet"></option></select>
	</span><u></u><br><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;电话
<input type="text" onkeyup="value=value.replace(/[^\d-]/g,'')" title='法定代表人电话' name='"法定代表人电话"' field="legalPhone" style="width:15%"  maxlength="30"/>
	</span><u></u><span lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'>&nbsp;</span>
	<span
	style='font-size: 16.0pt; font-family: 仿宋'>手机
<input type="text" title='法定代表人手机' onkeyup="value=value.replace(/[^\d]/g,'')" name='"法定代表人手机"' field="legalMobile" style="width:15%"  maxlength="30"/>	
	</span><u></u><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋'>专职/兼职
<select field="ifLegalFulltime" name='"法定代表人专/兼职"' title='法定代表人专/兼职'><option dataset="ifFulltimeDataSet"></option></select>	
	</span><u></u><span lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'>&nbsp;</span>
	<br><span
	style='font-size: 16.0pt; font-family: 仿宋'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;工作单位
<input type="text" title='法定代表人工作单位' name='"法定代表人工作单位"' field="legalWorkName" style="width:15%"  maxlength="50"/>	
	</span><u></u><span lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'>&nbsp;</span><span
	style='font-size: 16.0pt; font-family: 仿宋'>其它社会职务
<input type="text" title='法定代表人其它社会职务' name='"法定代表人其它社会职务"' field="legalOtherDuty" style="width:15%"  maxlength="50"/>	
	</span><u></u></p>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal style="text-align:left"><span
	style='font-size: 16.0pt; font-family: 仿宋'>&nbsp;&nbsp;&nbsp;&nbsp;（四）会长（理事长、主席）情况</span></p>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal style="text-align: left"><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;姓名
<input type="text" title='会长（理事长、主席）姓名' name='"会长（理事长、主席）姓名"' field="presidentName" style="width:10%"  maxlength="50"/>
	<u></u><span lang=EN-US>&nbsp;</span>政治面貌
<select field="presidentPolitical" title='会长（理事长、主席）政治面貌' name='"会长（理事长、主席）政治面貌"'><option dataset="politicsDataSet"></option></select>
	<u></u><span lang=EN-US>&nbsp;</span>性别
<select id="sex" field="presidentSex" title='会长（理事长、主席）性别' name='"会长（理事长、主席）性别"'><option dataset="sexDataSet"></option></select>	
	<u></u><span lang=EN-US>&nbsp;</span><br><p style="text-align:left"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;文化程度
<select field="presidentEducation" title="文化程度" name='"会长（理事长、主席）文化程度"'><option dataset="eduDataSet"></option></select>	
	<u></u><span lang=EN-US>&nbsp;</span><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋'>离退休否
<select id="ifServe" title='会长（理事长、主席）离退休否' field="ifPresidentRetired" name='"会长（理事长、主席）离退休否"'><option dataset="yesornoDataSet"></option></select>	
	<br><p style="text-align:left"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;电话
<input type="text" onkeyup="value=value.replace(/[^\d-]/g,'')" title='会长（理事长、主席）电话' name='"会长（理事长、主席）电话"' field="presidentPhone" style="width:15%"  maxlength="30"/>
	<u></u><span lang=EN-US>&nbsp;</span></span><span
	style='font-size: 16.0pt; font-family: 仿宋'>手机
<input type="text" onkeyup="value=value.replace(/[^\d]/g,'')" name='"会长（理事长、主席）手机"' title='会长（理事长、主席）手机' field="presidentMobile" style="width:15%"  maxlength="30"/>	
	</span><u></u><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋'>专职/兼职
<select field="ifPresidentFulltime" title='会长（理事长、主席）专/兼职' name='"会长（理事长、主席）专/兼职"'><option dataset="ifFulltimeDataSet"></option></select>	
	<u></u><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;工作单位
<input type="text" name='"会长（理事长、主席）工作单位"' title='会长（理事长、主席）工作单位' field="presidentWorkName" style="width:15%"  maxlength="50"/>
	<u></u>其它社会职务
<input type="text" name='"会长（理事长、主席）其它社会职务"' title='会长（理事长、主席）其它社会职务' field="presidentOtherDuty" style="width:15%"  maxlength="50"/>
	<u></u></span></p>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal style="text-align: left"><span
	style='font-size: 16.0pt; font-family: 仿宋'>&nbsp;&nbsp;&nbsp;&nbsp;（五）秘书长情况</span></p>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p style="text-align:left"><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;姓名
<input type="text" name='"秘书长姓名"' title='秘书长姓名' field="secretaryName" style="width:10%"  maxlength="50"/>	
	</span><u></u><span
	style='font-size: 16.0pt; font-family: 仿宋'>政治面貌
<select field="secretaryPolitical" title='秘书长政治面貌' name='"秘书长政治面貌"'><option dataset="politicsDataSet"></option></select>	
	</span><span
	style='font-size: 16.0pt; font-family: 仿宋'>性别
<select id="sex" field="secretarySex" title='"秘书长性别"' name='"秘书长性别"'><option dataset="sexDataSet"></option></select>	
	</span><p style="text-align:left" /><span
	style='font-size: 16.0pt; font-family: 仿宋'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;文化程度
<select field="secretaryEducation" title="文化程度" name='"秘书长文化程度"'><option dataset="eduDataSet"></option></select>		
	离退休否
<select id="ifSecretaryRetired" title='秘书长离退休否' field="ifSecretaryRetired" name='"秘书长离退休否"'><option dataset="yesornoDataSet"></option></select>	
	</span><u></u><u><span style='font-size: 16.0pt; font-family: 仿宋'> <span
	lang=EN-US> </span></span></u><p style="text-align:left" /><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;电话
<input onkeyup="value=value.replace(/[^\d-]/g,'')" type="text" name='"秘书长电话"' title='秘书长电话' field="secretaryPhone" style="width:15%"  maxlength="30"/>	
	</span><span
	style='font-size: 16.0pt; font-family: 仿宋'>手机
<input onkeyup="value=value.replace(/[^\d]/g,'')" type="text" name='"秘书长手机"' title='秘书长手机' field="secretaryMobile" style="width:15%"  maxlength="30"/>	
	</span><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋'>电子邮件
<input type="text" name='"秘书长电子邮件"' title='秘书长电子邮件' field="secretaryEmail" style="width:15%"  maxlength="50"/>	
	</span></p>
<p style="text-align:left"><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;专职/兼职
<select field="ifSecretaryFulltime" name='"秘书长专/兼职"' title='"秘书长专/兼职"'><option dataset="ifFulltimeDataSet"></option></select>		
	</span><span
	style='font-size: 16.0pt; font-family: 仿宋'>工作单位
<input type="text" name='"秘书长工作单位"' title='秘书长工作单位' field="secretaryWorkName" style="width:15%"  maxlength="50"/>	
	</span><span
	style='font-size: 16.0pt; font-family: 仿宋'>其它社会职务
<input type="text" name='"秘书长其它社会职务"' title='秘书长其它社会职务' field="secretaryOtherDuty" style="width:15%"  maxlength="50"/>	
	</span><u></u></p>
</div>
</form>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</div>
</body>
</html>
