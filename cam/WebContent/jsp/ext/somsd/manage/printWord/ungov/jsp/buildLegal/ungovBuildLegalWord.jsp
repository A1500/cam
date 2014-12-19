<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.sorg.online.apply.util.SomIdHelpOnline"%>
<%@page import="com.inspur.cams.sorg.util.ApplyType"%>
<%@ page import="com.inspur.cams.comm.extuser.data.ComExtUser"%>
<%@ page import="com.inspur.cams.sorg.online.extuser.util.SomExtBspInfo"%>
<script type="text/javascript" src="json.js"></script>
<html>
<head>
<next:ScriptManager></next:ScriptManager>
<%
	ComExtUser comExtUser = (ComExtUser)SomExtBspInfo.getUserInfo(request).getComExtUser();
	String username = comExtUser.getUserName();
	String organArea = comExtUser.getAreaCode();//获取外部单位行政区划12位
	String userId = comExtUser.getUserId();
	String sorgId=request.getParameter("sorgId");
	String taskCode=request.getParameter("taskCode");
%>
<script type="text/javascript">
	var taskCode='<%=taskCode%>';
	var sorgId='<%=sorgId%>';
	var applyType='<%=ApplyType.SOM_UNGOV_BUILD_LEGAL%>';
</script>
<script type="text/javascript">
var webObj;
var activeDocument;
var marksNames;
var showMap=new L5.Map("java.util.HashMap");

/**
本方法 以实例的方式，约定说明模板、标签和数据的格式
**/
function init(){
	//取得文件名 和标签
	var nowFileName = "/jsp/ext/somsd/manage/printWord/ungov/doc/ungovBuildLegalWord.doc";
	//marksNames = "name1__1&code1__1";  标签定义格式 字段代码 + __ + 序号
	//打开文件
	webObj = document.getElementById("webOfficeNt");
	webObj.Titlebar = false;
	//webObj.OpenLocalFile(nowFileName);
	webObj.OpenFromURL(L5.webPath+nowFileName);
	activeDocument = webObj.activeDocument;
	activeDocument.Application.ActiveWindow.View.ShowBookmarks = true;

	var somOrganDataSet=L5.DatasetMgr.lookup("somOrganDataSet");
	somOrganDataSet.setParameter("SORG_ID@=", sorgId);
	somOrganDataSet.load();
	somOrganDataSet.on('load', loadInfo);
}
function loadInfo(){
	var somApplyDataSet = L5.DatasetMgr.lookup("somApplyDataSet");
	somApplyDataSet.setParameter("TASK_CODE",taskCode);
	somApplyDataSet.setParameter("APPLY_TYPE",applyType);
	somApplyDataSet.load();
	somApplyDataSet.on("load",function(){
		var somHeldOrganDataSet=L5.DatasetMgr.lookup("somHeldOrganDataSet");
		somHeldOrganDataSet.setParameter("TASK_CODE@=", taskCode);
		somHeldOrganDataSet.load();
		somHeldOrganDataSet.on("load",function(){
			var somHeldPeopleDataSet=L5.DatasetMgr.lookup("somHeldPeopleDataSet");
			somHeldPeopleDataSet.setParameter("TASK_CODE@=", taskCode);
			somHeldPeopleDataSet.load();
			somHeldPeopleDataSet.on("load",function(){
				var somDutyDataSet = L5.DatasetMgr.lookup("somDutyDataSet");
				somDutyDataSet.setParameter("TASK_CODE", taskCode);
				somDutyDataSet.setParameter("SORG_DUTIES!=","00012");//随便赋值，就能去掉法人（法人是00012，其他为空）
				somDutyDataSet.load();
				somDutyDataSet.on('load',function(){
					var somOfficeDataSet = L5.DatasetMgr.lookup("somOfficeDataSet");
					somOfficeDataSet.setParameter("TASK_CODE", taskCode);
					somOfficeDataSet.load();
					somOfficeDataSet.on("load",function(){
						var LegalPeopleDataSet = L5.DatasetMgr.lookup("LegalPeopleDataSet");
						LegalPeopleDataSet.setParameter("TASK_CODE",taskCode);
						LegalPeopleDataSet.setParameter("SORG_DUTIES","00012");//法人编号
						LegalPeopleDataSet.load();
						LegalPeopleDataSet.on("load",function(){
							//somOrganDataSet
							var cnName = somOrganDataSet.get("cnName");//单位名称
							var residence = somOrganDataSet.get("residence");//住所
							var sorgPhone = somOrganDataSet.get("sorgPhone");//电话
							var sorgPost = somOrganDataSet.get("sorgPost");//邮编
							var engagedNum = somOrganDataSet.get("engagedNum");//从业人员数
							var practiceNum = somOrganDataSet.get("practiceNum");//从业职业人员数
							var purpose = somOrganDataSet.get("purpose");//宗旨
							var business = somOrganDataSet.get("business");//业务范围
							var facilities = somOrganDataSet.get("facilities");//基本设备、设施
							var regMon = somOrganDataSet.get("regMon");//开办资金数额
							var checkCapitalOrgan = somOrganDataSet.get("checkCapitalOrgan");//验资单位
							var moneySource = somOrganDataSet.get("moneySource");//开办资金来源
							var housingOrgan = somOrganDataSet.get("housingOrgan");//产 权 单 位
							var housingArea = somOrganDataSet.get("housingArea");//用房面积
							var leasePeriod = somOrganDataSet.get("leasePeriod");//租（借）期限
							var sorgCode = somOrganDataSet.get("sorgCode")//登记证号
							var busScope = changeBusScope(somOrganDataSet.get("busScope"));//所属行事业（封面填写）
							var organCode = somOrganDataSet.get("organCode");//（封面的）代码
							//somApplyDataSet
							var borgCheckDate = somApplyDataSet.get("borgCheckDate");//业务主管单位审查同意日期
							var createTime = somApplyDataSet.get("createTime").substr(0,10);//封面的登记时间
							var borgName = somApplyDataSet.get("borgName");//业务主管单位(代码)
							//somHeldOrganDataSet
							var countSomHeldOrganDataSet = somHeldOrganDataSet.getCount();
							var lengthSomHeldOrganDataSet = 0;//最多填4个
							if(countSomHeldOrganDataSet<4){
								lengthSomHeldOrganDataSet=countSomHeldOrganDataSet;
							}else if(countSomHeldOrganDataSet>=4){
								lengthSomHeldOrganDataSet=4;
							}
							if(lengthSomHeldOrganDataSet>0){
								var records = somHeldOrganDataSet.getAllRecords();
								for(var i=0;i<lengthSomHeldOrganDataSet;i++){
									showMap.put("namedanwei"+i,records[i].get("name"));//举 办 单 位 名 称
								}
							}
							//somHeldPeopleDataSet
							var countSomHeldPeopleDataSet = somHeldPeopleDataSet.getCount();
							var lengthSomHeldPeopleDataSet = 0;//最多填6个举办者情况
							if(countSomHeldPeopleDataSet<6){
								lengthSomHeldPeopleDataSet = countSomHeldPeopleDataSet;
							}else if(countSomHeldPeopleDataSet>=6){
								lengthSomHeldPeopleDataSet = 6;
							}
							if(lengthSomHeldPeopleDataSet>0){
								var records =  somHeldPeopleDataSet.getAllRecords();
								for(var i=0;i<lengthSomHeldPeopleDataSet;i++){
									showMap.put("namePeople"+i,records[i].get("name"));//姓  名
									showMap.put("birthdayPeople"+i,records[i].get("birthday"));//出生年月
									showMap.put("politicsPeople"+i,changePolitics(records[i].get("politics")));//政治面貌
									showMap.put("personUnitPeople"+i,records[i].get("personUnit"));//人事关系所在单位
									showMap.put("phonePeople"+i,records[i].get("phone"));//电 话
								}
							}
							//somDutyDataSet
							var countSomDutyDataSet = somDutyDataSet.getCount();
							var lengthSomDutyDataSet = 0;//最多填5个领导
							if(countSomDutyDataSet<5){
								lengthSomDutyDataSet = countSomDutyDataSet;
							}else if(countSomDutyDataSet>=5){
								lengthSomDutyDataSet = 5;
							}
							if(lengthSomDutyDataSet>0){
								var records = somDutyDataSet.getAllRecords();
								for(var i=0;i<lengthSomDutyDataSet;i++){
									showMap.put("nameSomDutyDataSet"+i,records[i].get("name"));//姓  名
									showMap.put("sexSomDutyDataSet"+i,records[i].get("sex")==1?"男":"女");//性别
									showMap.put("birthdaySomDutyDataSet"+i,records[i].get("birthday"));//出生年月
									showMap.put("personUnitSomDutyDataSet"+i,records[i].get("personUnit"));//人事关系所在单位
									showMap.put("workDutiesSomDutyDataSet"+i,records[i].get("workDuties"));//职务
									showMap.put("professionSomDutyDataSet"+i,records[i].get("profession"));//职称
									showMap.put("politicsSomDutyDataSet"+i,changePolitics(records[i].get("politics")));//政治面貌
									showMap.put("phoneSomDutyDataSet"+i,records[i].get("phone"));//电  话
								}
							}
							//somOfficeDataSet
							var countSomOfficeDataSet = somOfficeDataSet.getCount();
							var lengthSomOfficeDataSet = 0;//最多7个内设机构
							if(countSomOfficeDataSet<7){
								lengthSomOfficeDataSet = countSomOfficeDataSet;
							}else if(countSomOfficeDataSet>=7){
								lengthSomOfficeDataSet = 7;
							}
							if(lengthSomOfficeDataSet>0){
								var records = somOfficeDataSet.getAllRecords();
								for(var i=0;i<lengthSomOfficeDataSet;i++){
									showMap.put("nameSomOfficeDataSet"+i,records[i].get("name"));//机构名称
									showMap.put("officeChiefSomOfficeDataSet"+i,records[i].get("officeChief"));//负责人
									showMap.put("placeSomOfficeDataSet"+i,records[i].get("place"));//地    址
									showMap.put("phoneSomOfficeDataSet"+i,records[i].get("phone"));//电  话
								}
							}
							//legalPeopleDataSet
							if(LegalPeopleDataSet.getCount()!=0){
								var nameLegalPeopleDataSet = LegalPeopleDataSet.get("name");//法定代表人
								var workDutiesLegalPeopleDataSet = LegalPeopleDataSet.get("workDuties");//职务
								var phoneLegalPeopleDataSet = LegalPeopleDataSet.get("phone");//电话
							}

							showMap.put("cnName",cnName);
							showMap.put("residence",residence);
							showMap.put("sorgPhone",sorgPhone);
							showMap.put("sorgPost",sorgPost);
							showMap.put("engagedNum",engagedNum);
							showMap.put("practiceNum",practiceNum);
							showMap.put("purpose",purpose);
							showMap.put("business",business);
							showMap.put("facilities",facilities);
							showMap.put("borgCheckDate",borgCheckDate);
							showMap.put("regMon",regMon);
							showMap.put("checkCapitalOrgan",checkCapitalOrgan);
							showMap.put("moneySource",moneySource);
							showMap.put("housingOrgan",housingOrgan);
							showMap.put("housingArea",housingArea);
							showMap.put("leasePeriod",leasePeriod);
							showMap.put("nameLegalPeopleDataSet",nameLegalPeopleDataSet);
							showMap.put("workDutiesLegalPeopleDataSet",workDutiesLegalPeopleDataSet);
							showMap.put("phoneLegalPeopleDataSet",phoneLegalPeopleDataSet);
							showMap.put("cnName0",cnName);
							showMap.put("sorgCode0",sorgCode);
							showMap.put("createTime",createTime);
							showMap.put("busScope",busScope);
							showMap.put("organCode",organCode);

							var borgDataSet = L5.DatasetMgr.lookup("borgDataSet");
							borgDataSet.setParameter("includeCode",borgName);
							borgDataSet.load();
							borgDataSet.on('load',function(){
								var borgName = borgDataSet.get("text");
								showMap.put("borgName0",borgName);//封面用

								getMarks();
								writeDoc(showMap);
							});
						});
					});
				});
			});
		});
	});
}

//将政治面貌由code转换成name
function changePolitics(politics){
	var po = "";
	switch (politics){
	case "01": po = "中国共产党党员";break;
	case "02": po = "中国共产党预备党员";break;
	case "03": po = "中国共产主义青年团团员";break;
	case "04": po = "中国国民党革命委员会会员";break;
	case "05": po = "中国民主同盟盟员";break;
	case "06": po = "中国民主建国会会员";break;
	case "07": po = "中国民主促进会会员";break;
	case "08": po = "中国农工民主党党员";break;
	case "09": po = "中国致公党党员";break;
	case "10": po = "九三学社社员";break;
	case "11": po = "台湾民主自治同盟盟员";break;
	case "12": po = "无党派民主人士";break;
	case "13": po = "群众";break;
	case "99": po = "其他";break;
	default : po = "";
	}
	return po;
}

//所属行事业
function changeBusScope(busScope){
	var bu = "";
	switch (busScope){
	case "01": bu = "工商";break;
	case "02": bu = "农业农村";break;
	case "03": bu = "自然科学";break;
	case "04": bu = "社会科学";break;
	case "05": bu = "教育";break;
	case "06": bu = "卫生";break;
	case "07": bu = "文化";break;
	case "08": bu = "体育";break;
	case "09": bu = "生态环境";break;
	case "10": bu = "慈善";break;
	case "11": bu = "法律";break;
	case "12": bu = "宗教";break;
	case "13": bu = "职业及从业";break;
	case "14": bu = "涉外";break;
	case "15": bu = "其他";break;
	default : bu = "";
	}
	return bu;
}

function writeDoc(mp){
	//遍历map的值
	for(var key in mp.map)
	{
		//var getMapMark = mp.get(key);
		//分割标签
		var marks=marksNames.split("&");
		//遍历所有标签
		for(var i=0;i<marks.length;i++)
		{
				//分离标签和标记
				var marksStr = marks[i].split("__");
				//标签和预含义标签相等的场合
				if(marksStr[0]==key)
				{
					//获取标签值
		  			var bkmkObj = activeDocument.Bookmarks(marks[i]);
					//向模板中写数据
					if(bkmkObj)
					{
						var inputValue = mp.get(key);
						var saverange = bkmkObj.Range;
						saverange.Text = inputValue;
						//saverange.InsertBefore(""); //之前写内容
						//saverange.InsertAfter("");  //之后写内容
					}

			    }
		}

	}
}
/**
获得 模板中的标签并组成串 "name1__1&code1__1";  标签定义格式 字段代码 + __ + 序号
*/
function getMarks(){

	marksNames = "";
	var count = activeDocument.Bookmarks.Count;
	for(var i=1;i<=count;i++)
	{
		if(i<count){
			marksNames = marksNames + activeDocument.Bookmarks(i).Name + "&";
		}
		else{
			marksNames = marksNames + activeDocument.Bookmarks(i).Name;
		}
	}
	//alert(marksNames);
}




function  returnButton(){
	webObj = document.getElementById("webOfficeNt");
	webObj.close();
	//window.close();  //如果本界面为独立窗口显示，可放开这个注释
}
/**
打印（参数可以控制是前台打印还是后台打印）
*/
function printdoc(isBackground)
{
	var oldOption;
	try
	{
		var objOptions =  activeDocument.Application.Options;
		oldOption = objOptions.PrintBackground;
		objOptions.PrintBackground = isBackground;
	}
	catch(err){};
	webObj.printout(true);
	try
	{
		var objOptions =  activeDocument.Application.Options;
		objOptions.PrintBackground = oldOption;
	}
	catch(err){};
}
</script>
<title>打印</title>
</head>
<body >
<model:datasets>
	<%--民办非企业基本信息--%>
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" global="true" method="queryOrganOnline">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan">
			<model:field name="organCode" type="string" rule="length{10}" />
			<model:field name="cnName" type="string" rule="require|length{100}" />
			<model:field name="enName" type="string" rule="length{100}" />
			<model:field name="abName" type="string" rule="length{50}" />
			<model:field name="regMon" type="string" rule="double|length{100}" />
			<model:field name="residence" type="string" rule="length{100}" />
			<model:field name="sorgAdds" type="string" rule="length{200}" />
			<model:field name="sorgEmail" type="string" rule="length{100}" />
			<model:field name="actArea" type="string" rule="length{50}" />
			<model:field name="purpose" type="string" rule="length{1000}" />
			<model:field name="business" type="string" rule="length{1000}" />
			<model:field name="unitsNum" type="string" rule="integer" />
			<model:field name="peopleNum" type="string" rule="integer" />
			<model:field name="councilNum" type="string" rule="integer" />
			<model:field name="standCouncilNum" type="string" rule="integer" />
			<model:field name="fundingPeople" type="string" rule="length{500}" />
			<model:field name="checkCapitalOrgan" type="string" rule="length{100}" />
			<model:field name="moneySource" type="string" rule="length{500}" />
			<model:field name="housingOrgan" type="string" rule="length{100}" />
			<model:field name="leasePeriod" type="string" rule="length{100}" />
		</model:record>
	</model:dataset>
	<%--举办人情况--%>
	<model:dataset id="somHeldPeopleDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomHeldPeopleQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomHeldPeople">
			<model:field name="idCard" type="string" rule="length{18}" />
			<model:field name="name" type="string" rule="length{72}" />
			<model:field name="sex" type="string" rule="length{1}" />
			<model:field name="birthday" type="string" rule="length{10}" />
			<model:field name="politics" type="string" rule="length{2}" />
			<model:field name="workName" type="string" rule="length{100}" />
			<model:field name="workDuties" type="string" rule="length{100}" />
			<model:field name="ifChief" type="string" rule="length{1}" />
		</model:record>
	</model:dataset>
	<%--举办单位情况--%>
	<model:dataset id="somHeldOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomHeldOrganQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomHeldOrgan">
			<model:field name="name" type="string" rule="require|length{100}" />
			<model:field name="heldorganPeople" type="string" rule="length{72}" />
			<model:field name="phone" type="string" rule="length{30}" />
		</model:record>
	</model:dataset>
	<!-- 负责人信息 -->
	<model:dataset id="somDutyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true" method="queryPeople">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<!-- 法定代表人信息 -->
	<model:dataset id="LegalPeopleDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true" method="queryPeople">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<!-- 届次信息 -->
	<model:dataset id="somSessionDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomSessionQueryCmd">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomSession"></model:record>
	</model:dataset>
	<!-- 负责人录入窗口 -->
	<model:dataset id="somDutyInsertDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true" method="queryPeople">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty">
			<model:field name="idCard" type="string" rule="length{18}" />
			<model:field name="name" type="string" rule="require|length{72}" />
			<model:field name="aliasName" type="string" rule="length{72}" />
			<model:field name="phone" type="string" rule="length{30}" />
			<model:field name="adds" type="string" rule="length{100}" />
			<model:field name="populace" type="string" rule="length{100}" />
			<model:field name="workName" type="string" rule="length{100}" />
			<model:field name="workDuties" type="string" rule="length{50}" />
			<model:field name="resume" type="string" rule="length{1000}" />
			<model:field name="workOpinion" type="string" rule="length{200}" />
			<model:field name="sorgOpinion" type="string" rule="length{200}" />
		</model:record>
	</model:dataset>
	<%--人员简历 --%>
	<model:dataset id="somResumeDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomPeopleResumeQueryCommand" sortField="startDate" sortDirection="DESC">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeopleResume"></model:record>
	</model:dataset>
	<%--法定代表人人员简历 --%>
	<model:dataset id="somResumeLegalDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomPeopleResumeQueryCommand">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeopleResume"></model:record>
	</model:dataset>
	<%--人员简历 --%>
	<model:dataset id="somResumeInsertDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomPeopleResumeQueryCommand">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeopleResume"></model:record>
	</model:dataset>
	<%--内设机构--%>
	<model:dataset id="somOfficeDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOfficeQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOffice">
		</model:record>
	</model:dataset>
	<model:dataset id="winOfficeDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOfficeQueryCmd">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOffice">
		</model:record>
	</model:dataset>
	<%--所有符合身份证号的人员列表--%>
	<model:dataset id="winPeopleDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomPeopleQueryCmd" >
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeople"></model:record>
	</model:dataset>
	<%--所有符合身份证号的人员列表--%>
	<model:dataset id="winDutyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" >
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<!-- 章程核准信息 -->
	<model:dataset id="somRuleDataSet"cmd="com.inspur.cams.sorg.base.cmd.SomRuleQueryCmd" global="true" method="queryRule">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomRule">
			<model:field name="shouldNum" type="string" rule="number|length{6}"/>
		    <model:field name="realNum" type="string" rule="number|length{6}"/>
		    <model:field name="passNum" type="string" rule="number|length{6}"/>
		    <model:field name="nopassNum" type="string" rule="number|length{6}"/>
		    <model:field name="giveupNum" type="string" rule="number|length{6}"/>
		    <model:field name="mainQuestion" type="string" rule="length{1000}"/>
		</model:record>
	</model:dataset>
	<%--电子档案--%>
	<model:dataset id="somElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true" method="queryCatalog">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--下载窗口--%>
	<model:dataset id="downloadDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" method="queryElectronic">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--电子档案上传窗口--%>
	<model:dataset id="winElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--法定代表人员电子档案--%>
	<model:dataset id="somLegalPeopleElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true" method="queryPeopleCatalog" >
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--法定代表人员电子档案上传窗口--%>
	<model:dataset id="winLegalPeopleElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true" method="queryPeopleElectronic">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--业务意见--%>
	<model:dataset id="somApplyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomApplyQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomApply">
		</model:record>
	</model:dataset>

	<%--定义字典表--%>
	<model:dataset id="cataLogCodeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_CATALOG'></model:param>
			<model:param name="value" value='CATALOG_CODE'></model:param>
			<model:param name="text" value='CATALOG_NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 社会组织种类 -->
	<model:dataset id="sorgKindSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_UNGOV_KIND'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 政治面貌 -->
	<model:dataset id="politicsSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_POLITICAL'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 住所来源 -->
	<model:dataset id="resideSourceSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_RESIDE_SOURCE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 住所来源 -->
	<model:dataset id="sorgNameSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_ORGAN'></model:param>
			<model:param name="value" value='SORG_ID'></model:param>
			<model:param name="text" value='CN_NAME'></model:param>
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
	<!-- 专兼职 -->
	<model:dataset id="ifFulltimeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_IF_FULLTIME'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 民族 -->
	<model:dataset id="folkSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 是否在任 -->
	<model:dataset id="ifServeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_DUTY_IF_SERVE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 业务主管单位 -->
	<model:dataset id="businessOrganSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true" sortField="ORDER_NUMBER">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_BUSINESS_ORGAN'></model:param>
			<model:param name="value" value='BORG_CODE'></model:param>
			<model:param name="text" value='BORG_NAME'></model:param>
			<model:param name="filterSql" value='<%="MORG_CODE ="+organArea.substring(0,6)%>'></model:param>
		</model:params>
	</model:dataset>
	<!-- 证件类型 -->
	<model:dataset id="cardTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CARD_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 会议类型 -->
	<model:dataset id="meetingType" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_MEETING_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 性别 -->
	<model:dataset id="sexSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SEX'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 文化程度 -->
	<model:dataset id="educationSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_EDUCATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<%--党员情况--%>
	<model:dataset id="peopleTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_PARTY_PEOPLE_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="somPartyMemberDataSet" cmd="com.inspur.cams.sorg.manage.cmd.SomPartyMemberQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPartyMember"></model:record>
	</model:dataset>
	<!-- 党员专兼职 -->
	<model:dataset id="ifPartyMemberFulltimeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_PARTY_IF_FULLTIME'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="somDutyDataSet2" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true"  method="queryPeople">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<model:dataset id="normalInfoSelect" enumName="SORG.PARTY.NORMAL_INFO" autoLoad="true" global="true"></model:dataset>
	<%--党员情况结束--%>

	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="opinionSelect" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>
	<!-- 业务主管单位 -->
	<model:dataset id="borgDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true"  sortField="ORDER_NUMBER">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_BUSINESS_ORGAN'></model:param>
			<model:param name="value" value='BORG_CODE'></model:param>
			<model:param name="text" value='BORG_NAME'></model:param>
			<model:param name="filterSql" value='<%="MORG_CODE ="+organArea.substring(0,6)%>'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>
<next:ViewPort>
	<next:AnchorLayout>
		<next:Panel  name="form" anchor="100% 100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" >
			<next:Html>
		   		<form id="Form1" >
					<table  cellspacing="0" width="100%">
			            <tr>
			               <td class="FieldLabel">
			               		<div style="width:130px"><span id="limit"></span></div>
			               </td>
			               <td class="FieldLabel">
			               		<div style="width:130px"><span id="evryPrt"></span></div>
			               </td>
				  		   <td class="FieldLabel">
				  		   		<button name="print" onclick="printdoc(false)">打印</button>
				  		   </td>
				  		   <td class="FieldLabel">
				  				<button name="close" onclick="returnButton()">关闭</button>
				  		   </td>
			            </tr>
			        </table>
			      <div id="divOjet" width="100%" height="100%" >
		              <object id="webOfficeNt" codebase="../../../ofcontrol/OfficeControl.cab#version=4,0,6,0" height="100%"
		                  width="100%" classid="clsid:C9BC4DFF-4248-4a3c-8A49-63A7D317F404" viewastext>
		                  <param name="_ExtentX" value="22728">
		                  <param name="_ExtentY" value="17039">
		                  <param name="BorderColor" value="-2147483632">
		                  <param name="BackColor" value="-2147483643">
		                  <param name="ForeColor" value="-2147483640">
		                  <param name="TitlebarColor" value="42768">
		                  <param name="TitlebarTextColor" value="0">
		                  <param name="BorderStyle" value="1">
		                  <param name="Titlebar" value="1">
		                  <param name="Toolbars" value="1">
		                  <param name="Caption" value="正文内容">
		                  <param name="ProductCaption" value="浪潮ECGAP">
		                  <param name="ProductKey" value="99820CD845CC062ECE8362C16BC825CDCA3B1C41">
		                  <param name="MakerCaption" value="山东浪潮齐鲁软件产业股份有限公司">
		                  <param name="MakerKey" value="57B3D598DFFAAE2EC83F4E49B6EB14A03769AF82">
		                  <param name="IsShowToolMenu" value="1">
		                  <param name="IsNoCopy" value="0">
		                  <param name="IsHiddenOpenURL" value="0">
		                  <param name="MaxUploadSize" value="0">
		                  <param name="Menubar" value="1">
		                  <param name="Statusbar" value="1">
		                  <param name="FileNew" value="-1">
		                  <param name="FileOpen" value="-1">
		                  <param name="FileClose" value="-1">
		                  <param name="FileSave" value="-1">
		                  <param name="FileSaveAs" value="-1">
		                  <param name="FilePrint" value="-1">
		                  <param name="FilePrintPreview" value="-1">
		                  <param name="FilePageSetup" value="-1">
		                  <param name="FileProperties" value="-1">
		                  <param name="IsStrictNoCopy" value="0">
		                  <param name="IsUseUTF8URL" value="0">
		                  <param name="MenubarColor" value="16777215">
		                  <param name="IsUseControlAgent" value="0">
		                  <param name="IsUseUTF8Data" value="0">
		                  <param name="IsSaveDocExtention" value="0">
		                  <param name="IsDirectConnect" value="0">
		                  <param name="SignCursorType" value="0">
		                  <param name="IsResetToolbarsOnOpen" value="0">
		                  <param name="IsSaveDataIfHasVDS" value="0">
		                  <param name="MenuButtonStyle" value="0">
		                  <param name="MenuButtonColor" value="16180947">
		                  <param name="MenuButtonFrameColor" value="14924434">
		                  <param name="MenuBarStyle" value="0">
		                  <param name="IsGetPicOnlyOnHandSign" value="0">
		                  <span >不能装载文档控件。请在检查浏览器的选项中检查浏览器的安全设置。</span>
		              </object>
			 	</div>
		    </form>
		  </next:Html>
	  </next:Panel>
	</next:AnchorLayout>
</next:ViewPort>
</body>
</html>
