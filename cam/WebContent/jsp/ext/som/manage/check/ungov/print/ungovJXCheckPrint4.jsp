<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<script language="javascript">
//var taskCode='<%=request.getParameter("taskCode")%>';
//初始化
function init4(){
	somJxPeopleDataSet.setParameter("TASK_CODE", taskCode);
	somJxPeopleDataSet.load();
	somJxPeopleDataSet.on('load',function (){
		if(somJxPeopleDataSet.getCount() == 0){
			somJxPeopleDataSet.newRecord();
		}
		PROGRESS_BAR++;
	});
	//创建页面导航下拉框
	//createUngovDetailSelect();
}
</script>
<style>
.label4 {
	text-align:center;
	border-bottom: solid 1px black;
	font-size: 13.0pt;
	font-family: 仿宋;
}
</style>
<model:datasets>
	<model:dataset id="somJxPeopleDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxpeople.cmd.SomJxPeopleQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxpeople.dao.SomJxPeople"></model:record>
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
<div align=left style="margin-top: 60px;layout-grid:10.6pt; width: 700px">

<p class=MsoNormal
	style=' '><b><span
	style='font-size: 14.0pt;  font-family: 仿宋; '>二、人员情况<span
	lang=EN-US><o:p></o:p></span></span></b></p>
<form method="post" onsubmit="return false" dataset="somJxPeopleDataSet">
<p class=MsoNormal
	style=' '><span
	style='font-size: 14.0pt;  font-family: 仿宋; '>（一）<span
	lang=EN-US></span>从业人员总数 <label field='practitionerNum'	style='width: 70'  class='label4'></label>
	 <u><span lang=EN-US><span
	style=''> </span></span></u>人。 其中女性人数 <label field='womanPracNum' style='width: 70'class='label4'></label>人。 <span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='margin-left: 52.5pt;   '><![if !supportLists]><span
	lang=EN-US
	style='font-size: 14.0pt;  font-family: 仿宋; '><span
	></span></span><![endif]><span
	style='font-size: 14.0pt;  font-family: 仿宋; color: black'>1、专职人员数
<label field='fulltimeNum' style='width:70;text-align:center'  class='label4'></label>
	
	人， 其中离退休返聘<label field='retiredNum'	style='width:70;text-align:center'  class='label4'></label>人，专职人员中签订劳动合同
<label 
	field='fulltimeContractNum' style='width:70'  class='label4'></label> <u><span
	lang=EN-US><span style=''> </span></span></u> <u><span lang=EN-US><span
	style=''></span></span></u>人；兼职人员数
<label field="parttimeNum" style='width:100;'class='label4'></label>人，其中兼职人员在国家机关任职<label
	 field='parttimeGovNum'
	style='width: 70'  class='label4'></label> <u><span lang=EN-US><span
	style=''></span></span></u>人，企事业单位在职 <label
	 field='enterprisesNum'
	style='width: 70'  class='label4'></label> <u><span lang=EN-US><span
	style=''></span></span></u>人，其他 <label
	 field='otherNum'
	style='width: 70'  class='label4'></label> <u><span lang=EN-US><span
	style=''></span></span></u>人。<span lang=EN-US><o:p></o:p></span></span></span></p>

<p class=MsoNormal
	style='margin-left: 52.5pt;     ; '><![if !supportLists]><span
	lang=EN-US
	style='font-size: 14.0pt;  font-family: 仿宋; ; '><span
	style=''></span></span><![endif]><span
	style='font-size: 14.0pt;  font-family: 仿宋;  color: black'>2、年龄结构</span><span
	style='font-size: 14.0pt;  font-family: 仿宋; '>：<span
	lang=EN-US></span>35岁及以下 <label
	 field='underThirtyfiveNum'
	style='width: 70'  class='label4'></label> <u><span lang=EN-US><span
	style=''></span></span></u>人，36—50岁 <label
	 field='thirtysixToFiftyNum'
	style='width: 70'  class='label4'></label> <u><span lang=EN-US><span
	style=''></span></span></u>人，51—60岁 <label
	 field='fiftyoneToSixtyNum'
	style='width: 70'  class='label4'></label> <u><span lang=EN-US><span
	style=''></span></span></u>人，60岁以上 <label
	 field='aboveSixtyNum'
	style='width: 70'  class='label4'></label> <u><span lang=EN-US><span
	style=''></span></span></u>人。<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal align=left
	style='margin-left: 52.5pt;  text-align: left;     '><![if !supportLists]><span
	lang=EN-US
	style='font-size: 14.0pt;  font-family: 仿宋;   color: black'><span
	style=''></span></span><![endif]><span
	style='font-size: 14.0pt;  font-family: 仿宋; '>3、学历结构：高中及以下
<label 
	field='underHighschoolNum' style='width: 70'  class='label4'></label> <u><span
	lang=EN-US><span style=''></span></span></u>人，大学本科及专科 <label
	 field='universityNum'
	style='width: 70'  class='label4'></label> <u><span lang=EN-US><span
	style=''></span></span></u>人，硕士及以上 <label
	 field='aboveMasterNum'
	style='width: 70'  class='label4'></label> <u><span lang=EN-US><span
	style=''></span><span style=''></span></span></u>人。<span
	lang=EN-US><o:p></o:p></span></span></p>
	
<p class=MsoNormal align=left
	style='margin-left: 52.5pt;  text-align: left;   line-height: 24.0pt;  '><![if !supportLists]><span
	lang=EN-US
	style='font-size: 14.0pt;  font-family: 仿宋;   color: black'><span
	style=''></span></span><![endif]><span
	style='font-size: 14.0pt;  font-family: 仿宋; '>4.从业人员中担任党代表人数
<label field='aboveCountyNum' style='width: 70'  ></label>
	<u></u>,其中，省级及以下的
<label field='partyNumProvince' style='width: 70'  ></label>
人，全国性的
<label field='partyNumNation' style='width: 70'  ></label>
 人；从业人员中担任人大代表人数
 <label field='npcNum' style='width: 70'  ></label>
其中，省级及以下的
<label field='npcNumProvince' style='width: 70'  ></label>
人，全国性的
<label field='npcNumNation' style='width: 70'  ></label>
人；
	<u> </u>担任政协委员人数
<label field='cppccNum' style='width: 70'  ></label>
	<u> </u>。其中，省级及以下的
<label field='cppccNumProvince' style='width: 70'  ></label>
人，全国性的
<label field='cppccNumNation' style='width: 70'  ></label>
人。</span></p>

<p class=MsoNormal align=left
	style='text-align: left;  '><span
	style='font-size: 14.0pt;  font-family: 仿宋; '>（二）负责人总数
<label  field='principalNum'
	style='width: 70'  class='label4'></label> <u><span lang=EN-US><span
	style=''> </span></span></u>其中女性数 <label
	 field='womenPrincipalNum'
	style='width: 70'  class='label4'></label> <u><span lang=EN-US><span
	style=''> </span><o:p></o:p></span></u></span></p>

<p class=MsoNormal
	style=' '><span
	lang=EN-US
	style='font-size: 14.0pt;  font-family: 仿宋; '><span
	style=''>&nbsp;&nbsp;&nbsp; </span></span><span lang=EN-US
	style='font-size: 14.0pt;  font-family: 黑体'><span
	style=''>&nbsp;&nbsp;</span>*</span><span
	style='font-size: 14.0pt;  font-family: 黑体'>负责人指单位领导，包括法定代表人、正副院长、园长、主任、理事长等。<span
	lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style=' '><span
	style='font-size: 14.0pt;  font-family: 仿宋; '>（三）法定代表人（负责人）情况<span
	lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='   '><span
	style='font-size: 14.0pt;  font-family: 仿宋; '>姓名
<label field='legalPeople' style='width: 100'  class='label4'></label> <u><span
	lang=EN-US><span style=''> </span></span></u><span
	lang=EN-US><span style=''>&nbsp;&nbsp;</span></span>性别
<label field="legalSex" style='width:100' dataset="sexDataSet"class='label4'></label>
 <u><span lang=EN-US><span style=''></span></span></u><span
	lang=EN-US><span style=''>&nbsp;&nbsp;</span></span>电话
<label field='legalPhone' style='width: 120' class='label4'></label> <u><span
	lang=EN-US><span style=''> </span></span></u><span
	lang=EN-US><span style=''>&nbsp;&nbsp;</span></span>手机
<label  field='legalMobile'
	style='width: 120'  class='label4'></label> <u><span lang=EN-US><span
	style=''> </span></span></u><span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='   '><span
	style='font-size: 14.0pt;  font-family: 仿宋; '>政治面貌
<label field="legalPolitical" style='width:250' dataset="politicsDataSet"class='label4'></label>
 <u><span lang=EN-US><span style=''>
</span></span></u><span lang=EN-US><span style=''>&nbsp;&nbsp;</span></span>文化程度
<label field="legalEducation" style='width:250' dataset="eduDataSet"class='label4'></label>
 <u><span lang=EN-US><span style=''></span></span></u><span
	lang=EN-US><span style=''></span>
	<br></span>离退休否
<label field="ifLegalRetired" style='width:50' dataset="yesornoDataSet"class='label4'></label>
 <u><span lang=EN-US><span style=''></span></span></u><span
	lang=EN-US><o:p></o:p></span></span>
	<span	style='font-size: 14.0pt;  font-family: 仿宋; '>专职/兼职 <label field="ifLegalFulltime" style='width:60' dataset="ifFulltimeDataSet"class='label4'></label>
	 <u><span lang=EN-US><span style=''>
</span></span></u><span lang=EN-US><span style=''>&nbsp;&nbsp;</span></span>工作单位
<label field='legalWorkName' style='width: 300'  class='label4'></label> <u><span
	lang=EN-US><span style=''> </span></span></u><span
	lang=EN-US><span style=''>&nbsp;&nbsp;</span><o:p></o:p></span></span></p>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</form>
</div>
