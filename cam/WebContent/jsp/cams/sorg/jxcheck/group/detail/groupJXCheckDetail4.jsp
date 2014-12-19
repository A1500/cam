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
				createGroupDetailSelect();
			}
			function save(){
				
			}
			function docPrint(){
		        document.execCommand("Print", false);
		    }
		</script>
<style media="print">
	.noprint     { display: none }
</style>
<style>
label {
	text-align:center;
	border-bottom: solid 1px black;	
	font-size: 14.0pt;
	font-family: 仿宋_GB2312;
}
.MsoNormal{
	text-align:left;
}
</style>
</head>

<body>
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
<div id="float" class="noprint">
		<input type="button" value="下一页" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="nextPage1('5')"/>
		<input type="button" value="上一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="lastPage1('3')"/>
	<!--[if lte IE 7]><div></div><![endif]-->
	<!--[if lte IE 7]><div></div><![endif]-->
	<input type="button" value="打印" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="docPrint();"/>
</div>

<div style="text-align: center">
<form method="post"onsubmit="return false" dataset="somJxPeopleDataSet">
<div class=Section1 style="width: 800px;">
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal style='margin-left: 32.15pt'><b><span
	style='font-size: 16.0pt; font-family: 黑体'>三、人员情况</span></b></p>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal style="text-align: left"><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>&nbsp;&nbsp;&nbsp;&nbsp;（一）从业人员总数
<label  name='"从业人员总数"' field="practitionerNum"style='width:100;'></label>	
人，（其中女性数
<label  name='"女性总数"' field="womanPracNum" style='width:100;'></label>

人）。
	</span></p>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; '>&nbsp;&nbsp;1.专职人员总数
<label field="fulltimeNum" style='width:100;'></label>
	<u></u>人。其中，专职人员中签订劳动合同
<label field="fulltimeContractNum" style='width:100;'></label>
	<u> </u>人，离退休返聘
<label field="retiredNum" style='width:100;'></label>
	人；</span><span style='font-size: 16.0pt; font-family: 仿宋_GB2312'>兼职人员中在国家机关任职
<label field="parttimeGovNum" style='width:100;'></label>
	人，在企事业单位任职<label field="enterprisesNum" style='width:100;'></label>
	人，其他
<label field="otherNum" style='width:100;'></label>
	<u></u>人。</span></p>
	
<p class=MsoNormal><span style='font-size: 16.0pt; font-family: 仿宋_GB2312;'>&nbsp;&nbsp;2.年龄结构：35岁及以下
<label field="underThirtyfiveNum" style='width:100;'></label>
	人，36——50岁
<label field="thirtysixToFiftyNum" style='width:100;'></label>
	人，51——60岁
<label field="fiftyoneToSixtyNum" style='width:100;'></label>
	人，</span><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312;'>60岁以上
<label field="aboveSixtyNum" style='width:100;'></label>
	人。</span></p>
	
<p class=MsoNormal><span style='font-size: 16.0pt; font-family: 仿宋_GB2312'>&nbsp;&nbsp;3.学历结构：高中及以下
<label field="underHighschoolNum" style='width:100;'></label>
	人，大学本科及专科
<label field="universityNum" style='width:100;'></label>
	人，硕士及以上
<label field="aboveMasterNum" style='width:100;'></label>
	人，</span><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; letter-spacing: -1.4pt'>
	留学半年以上归国人员
<label field="fromAbroadNum" style='width:100;'></label>
	人。</span></p>
	
<p class=MsoNormal><span style='font-size: 16.0pt; font-family: 仿宋_GB2312'>&nbsp;&nbsp;4.从业人员中持有“社会工作者”资格证书
<label field="caseworkerNum" style='width:100;'></label>
	<u>
	</u>人，持有从事岗位相应专业技术资格证书
<label field="vawirrmqNum" style='width:100;'></label>
	<u> </u>人。</span></p>
	
<p class=MsoNormal><span style='font-size: 16.0pt; font-family: 仿宋_GB2312'>&nbsp;&nbsp;5.从业人员中担任党代表人数
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
	
<p class=MsoNormal><span style='font-size: 16.0pt; font-family: 仿宋_GB2312'>&nbsp;&nbsp;6.从业人员中具有行政级别：（现职：省部级
<label field="provincialNum" style='width:100;'></label>
	<u></u>人、厅局级
<label field="boardNum" style='width:100;'></label>	
	<u></u>人、处级
<label field="chujiNum" style='width:100;'></label>
	<u></u>人；离退休：省部级
<label field="retiredProvincialNum" style='width:100;'></label>
	<u></u>人、厅局级
<label field="retiredBoardNum" style='width:100;'></label>	
	<u></u>人、处级
<label field="retiredChujiNum" style='width:100;'></label>
	<u></u>人；</span></p>
	
<p class=MsoNormal><span style='font-size: 16.0pt; font-family: 仿宋_GB2312'>&nbsp;&nbsp;7.名誉会长和顾问：（现职：省部级
<label field="mgProvincialNum" style='width:100;'></label>
	<u></u>人、厅局级
<label field="mgBoardNum" style='width:100;'></label>	
	<u></u>人、处级
<label field="mgChujiNum" style='width:100;'></label>
	<u></u>人；离退休：省部级
<label field="mgRetiredProvincialNum" style='width:100;'></label>
	<u></u>人、厅局级
<label field="mgRetiredBoardNum" style='width:100;'></label>	
	<u></u>人、处级
<label field="mgRetiredChujiNum" style='width:100;'></label>
	<u></u>人；</span></p>
	
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal style="text-align: left"><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312;'>&nbsp;&nbsp;&nbsp;&nbsp;（二）负责人总数
<label field="principalNum" style='width:100;'></label>	
	</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>人（其中女性数
<label field="womenPrincipalNum" style='width:100;'></label>
	</span><u></u><span style='font-size: 16.0pt; font-family: 仿宋_GB2312'>）。</span></p>
<p class=MsoNormal style="text-align: left"><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>
	<b style="color:red">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*</b></span><strong><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; font-weight: normal'>负责人指法定代表人、会长、副会长和秘书长</span></strong></p>
	
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal style="text-align: left"><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>&nbsp;&nbsp;&nbsp;&nbsp;（三）法定代表人情况</span></p>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style="text-align: left"><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;姓名
<label field="legalPeople" style='width:100;'></label>
	</span><u></u><span lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'>&nbsp;</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>政治面貌
<label field="legalPolitical" dataset="politicsDataSet" style='width:300;'></label>
	</span><u></u><span lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'>&nbsp;</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>性别
<label field="legalSex" dataset="sexDataSet" style='width:50;'></label>
	</span><u></u><br><p style="text-align:left"/><span lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'>&nbsp;</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;文化程度
<label field="legalEducation" dataset="eduDataSet" style='width:200;'></label>
	</span><u></u><span lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'>&nbsp;</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>离退休否
<label field="ifLegalRetired" dataset="yesornoDataSet" style='width:100;'></label>
	</span><u></u>
	
	<br><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;电话
<label field="legalPhone" style='width:150;'></label>
	</span><u></u><span lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'>&nbsp;</span>
	<span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>手机
<label field="legalMobile" style='width:150;'></label>
	</span><u></u>
	
	<br><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;专职/兼职
<label field="ifLegalFulltime" dataset="ifFulltimeDataSet" style='width:100;'></label>
	</span><u></u><span lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'>&nbsp;</span>
	
	<span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>工作单位
<label field="legalWorkName" style='border-bottom: solid 1px;width:300;'></label>	
	</span><u></u><span lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'>&nbsp;</span>
	<br><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>&nbsp;&nbsp;其它社会职务
<label field="legalOtherDuty" style='width:300;'></label>
	</span><u></u></p>
	
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal style="text-align:left"><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>&nbsp;&nbsp;&nbsp;&nbsp;（四）会长（理事长、主席）情况</span></p>	
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal style="text-align: left"><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;姓名
<label field="presidentName" style='width:100;'></label>
	<u></u><span lang=EN-US>&nbsp;</span>政治面貌
<label field="presidentPolitical" dataset="politicsDataSet" style='width:300;'></label>
	<u></u><span lang=EN-US>&nbsp;</span>性别
<label field="presidentSex" dataset="sexDataSet" style='width:50;'></label>
	<u></u><span lang=EN-US>&nbsp;</span><br><p style="text-align:left"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;文化程度
<label field="presidentEducation" dataset="eduDataSet" style='width:200;'></label>
	<u></u><span lang=EN-US>&nbsp;</span><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>离退休否
<label field="ifPresidentRetired" dataset="yesornoDataSet" style='width:100;'></label>	
	
	<br><p style="text-align:left"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;电话
<label field="presidentPhone" style='width:150;'></label>
	<u></u><span lang=EN-US>&nbsp;</span></span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>手机
<label field="presidentMobile" style='width:150;'></label>
	</span><u></u><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;专职/兼职
<label field="ifPresidentFulltime" dataset="ifFulltimeDataSet" style='width:100;'></label>
	<u></u>
	
	工作单位
<label field="presidentWorkName" style='border-bottom: solid 1px;width:300;'></label>
	<u></u><br>&nbsp;&nbsp;其它社会职务
<label field="presidentOtherDuty" style='width:300;'></label>
	<u></u></span></p>
	
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal style="text-align: left"><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>&nbsp;&nbsp;&nbsp;&nbsp;（五）秘书长情况</span></p>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>

<p style="text-align:left"><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;姓名
<label field="secretaryName" style='width:100;'></label>
	</span><u></u><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>政治面貌
<label field="secretaryPolitical" dataset="politicsDataSet" style='width:300;'></label>
	</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>性别
<label field="secretarySex" dataset="sexDataSet" style='width:50;'></label>
	</span><p style="text-align:left" /><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;文化程度
<label field="secretaryEducation" dataset="eduDataSet" style='width:200;'></label>
	离退休否
<label field="ifSecretaryRetired" dataset="yesornoDataSet" style='width:100;'></label>	
	</span><u></u><u><span style='font-size: 16.0pt; font-family: 仿宋_GB2312'> <span
	lang=EN-US> </span></span></u>
	
	<p style="text-align:left" /><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;电话
<label field="secretaryPhone" style='width:150;'></label>
	</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>手机
<label field="secretaryMobile" style='width:150;'></label>
	</span><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>电子邮件
<label field="secretaryEmail" style='width:200;'></label>
	</span></p>

<p style="text-align:left"><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;专职/兼职
<label field="ifSecretaryFulltime" dataset="ifFulltimeDataSet" style='width:100;'></label>
	</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>工作单位
<label field="secretaryWorkName" style='border-bottom: solid 1px;width:300;'></label>
	</span>
	<br/><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>&nbsp;&nbsp;其它社会职务
<label field="secretaryOtherDuty" style='width:300;'></label>
	</span><u></u></p>
</div>
</form>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</div>
</body>
</html>
