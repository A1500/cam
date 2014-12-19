<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.inspur.cams.comm.util.StrUtil,org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next" %>
<%@ taglib uri="/tags/next-model" prefix="model" %>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>民办非企业信息管理</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js")%>'></script>
<script type="text/javascript">var rootPath='<%=SkinUtils.getRootUrl(request)%>';</script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/somPhoto.js") %>'></script>
<script type="text/javascript" src="<%=SkinUtils.getRootUrl(request)%>skins/js/ISEditPhoto.js"></script>
<script type="text/javascript">
var sorgId='';
var taskCode = '<%=request.getParameter("taskCode")%>';
var applyType = "105";
var legalRecord="";
var fileCodeF="M015";//法定代表人fileCode
var legalDuties="00012";
var dutyId='';
var legalDutyId='';
//初始化
function init(){
	L5.getCmp("sorgTab").setActiveTab("5");
	L5.getCmp("sorgTab").setActiveTab("4");
	L5.getCmp("sorgTab").setActiveTab("2");
	
	L5.getCmp("tab").setActiveTab("0");
	L5.getCmp("sorgTab").setActiveTab("0");
	var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
	somApplyDataSet.setParameter("TASK_CODE", taskCode);
	somApplyDataSet.load();
	somApplyDataSet.on('load', loadInfo);
	
	//负责人window关闭时把数据清空
	if(L5.getCmp("peopleWin")){
		L5.getCmp("peopleWin").on("beforehide",function(){
			updateRecord="";
		});
	}
}
function loadInfo(){
	var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
	sorgId = somApplyDataSet.get('sorgId');
	
	var somApplyRecord=somApplyDataSet.getCurrent();
	//法人
	var somOrganDataSet=L5.DatasetMgr.lookup("somOrganDataSet");
	somOrganDataSet.setParameter("SORG_ID",sorgId);
	somOrganDataSet.load();
	
	var somOfficeDataSet=L5.DatasetMgr.lookup("somOfficeDataSet");
	somOfficeDataSet.setParameter("TASK_CODE", taskCode);
	somOfficeDataSet.load();
	//电子档案
	somElectronicDataSet_load();
	
	var somSessionDataSet=L5.DatasetMgr.lookup("somSessionDataSet");
	somSessionDataSet.setParameter("TASK_CODE", taskCode);
	somSessionDataSet.load();
	
	var somRuleDataSet=L5.DatasetMgr.lookup("somRuleDataSet");
	somRuleDataSet.setParameter("TASK_CODE", taskCode);
	somRuleDataSet.load();
	
	var somResumeDataSet=L5.DatasetMgr.lookup("somResumeDataSet");
	var somResumeLegalDataSet=L5.DatasetMgr.lookup("somResumeLegalDataSet");
	somResumeDataSet.setParameter("TASK_CODE", taskCode);
	somResumeDataSet.load();
	
	var somDutyDataSet=L5.DatasetMgr.lookup("somDutyDataSet");
	somDutyDataSet.setParameter("TASK_CODE", taskCode);
	somDutyDataSet.load();
	somDutyDataSet.on('load',function(){
		var peopleId="";
		var sorgOpinion="";
		var sorgCheckDate="";
		somDutyDataSet.each(function(record, index){
			if(record.get('sorgDuties') == legalDuties){
				peopleId=record.get('peopleId');
				sorgOpinion=record.get("sorgOpinion");
				sorgCheckDate=record.get("sorgCheckDate");
				legalDutyId=record.get('dutyId');
				//回填法定代表人简历
				var j=0;
				for(var i=somResumeDataSet.getCount()-1;i>=0;i--){
					var somResumeRecord =somResumeDataSet.getAt(i);
					if(record.get('dutyId') == somResumeRecord.get('dutyId')){
						somResumeLegalDataSet.insert(j,somResumeRecord);
						j++;
					}
				}
				//回填法定代表人简历结束
			}
		});
		somDutyDataSet.filterBy(function(record, id){
			if(record.get('sorgDuties') != legalDuties){
				if(record.get('peopleId') == peopleId){
					legalRecord=record;
					record.set("ifLegal","1");
						legalRecord.set("sorgOpinion",sorgOpinion);
						legalRecord.set("sorgCheckDate",sorgCheckDate);
					somDutyDataSet.commitChanges();
				}
				return record;
			}
		});
		var LegalPeopleDataSet=L5.DatasetMgr.lookup("LegalPeopleDataSet");
		LegalPeopleDataSet.insert(0,legalRecord);
		LegalPeopleDataSet.set("dutyId",legalDutyId);
		document.getElementById("labelAge").innerHTML=getAgeByCode(legalRecord.get("idCard"));
		synPhotoDetail(LegalPeopleDataSet.get("photoId"),null);
		somLegalPeopleElectronicDataSet_load();//同步法定代表人法律要件
	});
	//流程历史意见
	var somFlowListDataSet=L5.DatasetMgr.lookup("somFlowListDataSet");
	somFlowListDataSet.setParameter("TASK_CODE", taskCode);
	//somFlowListDataSet.setParameter("SORG_ID", sorgId);
	//somFlowListDataSet.setParameter("APPLY_TYPE", "101");
	somFlowListDataSet.load();
		
	//电子档案上传窗口关闭事件
	uploadListCloseEvent();
		
	//单位领导成员（合伙人）window关闭时把数据清空
	L5.getCmp("peopleWin").on("beforehide",function(){
		updateRecord="";
	});
}

//返回按钮
function back(){
	window.history.go(-1);
}
//判断住所来源，如果是租赁则显示租赁期限
function changeResideSource(){
	if(_$("resideSource") == "2"){
		$("leasePeriod").style.display = "block";
	}else{
		$("leasePeriod").value = "";
		$("leasePeriod").style.display = "none";
	}
}
//点击上传附件按钮
function clickUploadFile(){
	if(sorgId == ""){
		L5.Msg.alert('提示','请先填写“民办非企业中文名称！”');
		L5.getCmp("tab").setActiveTab("0");
		return false;
	}
	uploadFile();
}
//------------------单位领导成员（合伙人）处理------------------------------
//查看单位领导成员（合伙人）
function detailPeople(){
	var grid = L5.getCmp("peopleGrid");
	var sm = grid.getSelectionModel();
	var record = sm.getSelected();
	if(!record){
		L5.Msg.alert("提示","请选择一条记录!");
		return;
	}
	var somDutyInsertDataSet=L5.DatasetMgr.lookup("somDutyInsertDataSet");
	somDutyInsertDataSet.removeAll();
	somDutyInsertDataSet.insert(0,record);
	
	var somResumeInsertDataSet=L5.DatasetMgr.lookup("somResumeInsertDataSet");
	var somResumeDataSet=L5.DatasetMgr.lookup("somResumeDataSet");
	somResumeInsertDataSet.removeAll();
	var j=0;
	for(var i=somResumeDataSet.getCount()-1;i>=0;i--){
		var somResumeRecord =somResumeDataSet.getAt(i);
		if(record.get('dutyId')==somResumeRecord.get('dutyId')){
				somResumeInsertDataSet.insert(j,somResumeRecord);
				j++;
			}
	}
	
	var win = L5.getCmp("peopleWin");
	win.show();
	$("peopleAge").innerHTML = getAgeByCode(record.get("idCard"));
}
//单位领导成员（合伙人）窗户关闭
function winClosePeople(){
	var win = L5.getCmp("peopleWin");
	win.hide();
}
var peopleId=0;
var resumeCount=0;
//选择是否党政机关领导
function valid_ifPartyLeader_add(){
	if(document.getElementById('ifPartyLeader_add').value == '1'){
		document.getElementById('promiseOrgan_add').style.display="block";
		document.getElementById('promiseCode_add').style.display="block";
	}else{
		document.getElementById('promiseOrgan_add').style.display="none";
		document.getElementById('promiseCode_add').style.display="none";
		document.getElementById('promiseOrgan_add').value="";
		document.getElementById('promiseCode_add').value="";
	}
}


var officeRecord = null;
//内设机构明细
function detailOffice(){
	var grid = L5.getCmp("officeGrid");
	var sm = grid.getSelectionModel();
	var record = sm.getSelected();
	if(!record){
		L5.Msg.alert("提示","请选择一条记录!");
		return;
	}
	officeRecord = record;
	var winOfficeDataSet = L5.DatasetMgr.lookup("winOfficeDataSet");
	winOfficeDataSet.removeAll();
	var newRecord = winOfficeDataSet.newRecord();
	var win = L5.getCmp("officeWin");
	win.show();
	newRecord.set("name",record.get("name"));
	newRecord.set("place",record.get("place"));
	newRecord.set("phone",record.get("phone"));
	newRecord.set("postCode",record.get("postCode"));
	newRecord.set("officeChief",record.get("officeChief"));
	newRecord.set("dutiesDesc",record.get("dutiesDesc"));
	newRecord.set("reason",record.get("reason"));
	newRecord.set("process",record.get("process"));
}
//常设办事机构窗口关闭
function winCloseOffice(){
	var win = L5.getCmp("officeWin");
	win.setVisible(false);
}
function closePeopleWIn(){
	var win = L5.getCmp("peopleWin");
	win.hide();
}
</script>
</head>
<body>
<%--定义dataset--%>
<model:datasets>
	<%--民办非企业基本信息--%>
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" global="true" method="queryOrgan">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan">
			<%--民办非企业基本信息验证 --%>
			<model:field name="sorgCode" type="string" rule="require|length{20}" />
			<model:field name="cnName" type="string" rule="require|length{100}" />
			<model:field name="enName" type="string" rule="length{100}" />
			<model:field name="abName" type="string" rule="length{50}" />
			<model:field name="sorgKind" type="string" rule="require" />
			<model:field name="residence" type="string" rule="require|length{100}" />
			<model:field name="sorgAdds" type="string" rule="length{200}" />
			<model:field name="sorgEmail" type="string" rule="email|length{100}" />
			<model:field name="actArea" type="string" rule="length{50}" />
			<model:field name="purpose" type="string" rule="length{1000}" />
			<model:field name="business" type="string" rule="length{1000}" />
			<model:field name="busScope" type="string" rule="require"/>
			<model:field name="unitsNum" type="string" rule="integer" />
			<model:field name="peopleNum" type="string" rule="integer" />
			<model:field name="councilNum" type="string" rule="integer" />
			<model:field name="standCouncilNum" type="string" rule="integer" />
			<model:field name="fundingPeople" type="string" rule="length{500}" />
			<model:field name="checkCapitalOrgan" type="string" rule="length{100}" />
			<model:field name="moneySource" type="string" rule="length{500}" />
			<model:field name="housingOrgan" type="string" rule="length{100}" />
			<model:field name="resideSource" type="string" rule="require" />
			<model:field name="leasePeriod" type="string" rule="length{100}" />
			<model:field name="regDate" type="string" rule="require" />
			<model:field name="legalPeople" type="string"/>
		</model:record>
	</model:dataset>
	<!-- 届次信息 -->
	<model:dataset id="somSessionDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomSessionQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomSession">
		
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
	<!-- 负责人录入窗口 -->
	<model:dataset id="somDutyInsertDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true" method="queryPeople">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty">
			<model:field name="idCard" type="string" rule="require" />
			<model:field name="name" type="string" rule="require|length{72}" />
			<model:field name="aliasName" type="string" rule="length{72}" />
			<model:field name="phone" type="string" rule="length{30}" />
			<model:field name="sorgDuties" type="string" rule="require" />
			<model:field name="adds" type="string" rule="length{100}" />
			<model:field name="populace" type="string" rule="length{100}" />
			<model:field name="workName" type="string" rule="length{100}" />
			<model:field name="ifPartyLeader" type="string" rule="require" />
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
	<%--法定代表人员电子档案--%>
	<model:dataset id="somLegalPeopleElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true" method="queryPeopleCatalog" >
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--业务意见--%>
	<model:dataset id="somApplyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomApplyQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomApply"></model:record>
	</model:dataset>
	<model:dataset id="pubOrganDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='PUB_ORGAN'></model:param>
			<model:param name="value" value='ORGAN_ID'></model:param>
			<model:param name="text" value='ORGAN_NAME'></model:param>
		</model:params>
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
	<!-- 证书类型 -->
	<model:dataset id="certTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CERT_TYPE'></model:param>
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
	<!-- 民族 -->
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
			<model:param name="filterSql" value='<%="MORG_CODE ="+BspUtil.getOrganCode().substring(0,6)%>'></model:param>
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
	<%--流程历史意见--%>
	<model:dataset id="somFlowListDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomFlowQueryCmd" global="true" sortField="COMMIT_TIME">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomFlow"></model:record>
	</model:dataset>
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="opinionSelect" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="workFlowOpinionSelect" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="hisOpinionDataSet" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>
</model:datasets>	
<%--定义界面--%>
<next:Panel width="100%" height="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem  iconCls="return" text="返回" handler="back" ></next:ToolBarItem>			
	</next:TopBar>
	<next:TabPanel width="100%" height="100%" id="tab">
		<next:Tabs>
			<next:Panel title="成立登记详细信息" width="100%" >
				<next:TabPanel width="100%" height="100%" id="sorgTab" activeTab="1">
					<next:Tabs>
						<next:Panel title="登记申请表" width="100%" height="100%" autoScroll="true">
							<next:Panel >
								<next:Html>
									<fieldset>
										<form method="post" dataset="somOrganDataSet" onsubmit="return false" class="L5form">
											<table width="100%">
												<tr>
													<td class="FieldLabel"style="width:17%">民办非企业中文名称：</td>
													<td class="FieldInput" style="width:51%"colspan="3"><label  field="cnName" style="width:96%"/><span style="color:red"></span></td>
													<td class="FieldLabel" style="width:17%">电话：</td>
													<td class="FieldInput" style="width:17%"><label  field="sorgPhone" style="width:90%"/></td>
												</tr>
												<tr>	
													<td class="FieldLabel" style="width:17%">住所来源：</td>
													<td class="FieldInput" style="width:17%"><label  field="resideSource" dataset="resideSourceSelect"/><span style="color:red"></span></td>
													<td class="FieldLabel" style="width:17%">住所：</td>
													<td class="FieldInput" colspan="3"><label  field="residence"/><span style="color:red"></span></td>
												</tr>	
												<tr>
													<td class="FieldLabel" style="width:17%">邮编：</td>
													<td class="FieldInput" style="width:17%"><label  field="sorgPost" style="width:90%"/></td>
													<td class="FieldLabel" style="width:17%">民办非企业类型：</td>
													<td class="FieldInput"style="width:17%"><label  field="sorgKind" dataset="sorgKindSelect"/><span style="color:red"></span></td>
													<td class="FieldLabel" style="width:17%">所属行（事）业：</td>
													<td class="FieldInput"style="width:17%"><label  field="busScope" dataset="busScopeSelect"/><span style="color:red"></span></td>						
												</tr>
												<tr>
													<td class="FieldLabel" style="width:17%">从业人员数：</td>
													<td class="FieldInput"><label  field="engagedNum" style="width:90%"/></td>
													<td class="FieldLabel" style="width:17%">其中执业人员数：</td>
													<td class="FieldInput"><label  field="practiceNum" style="width:90%"/></td>
													<td class="FieldLabel"></td>
													<td class="FieldInput"></td>		
												</tr>
												<tr>	
													<td class="FieldLabel">宗旨：</td>
													<td class="FieldInput" colspan="5"><textarea rows="5" name='民办非企业宗旨' field="purpose" style="width:98%"style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" readonly="readonly"></textarea><span style="color:red"></span></td>
												</tr>
												<tr>	
													<td class="FieldLabel">业务范围：</td>
													<td class="FieldInput" colspan="5"><textarea rows="5" name='业务范围' field="business" style="width:98%"style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" readonly="readonly"></textarea><span style="color:red"></span></td>
												</tr>
												<tr>	
													<td class="FieldLabel">基本设备、设施：</td>
													<td class="FieldInput" colspan="5"><textarea rows="5" name='基本设备、设施' field="facilities" style="width:98%"style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" readonly="readonly"></textarea><span style="color:red"></span></td>
												</tr>
												<tr>
													<td class="FieldLabel">开办资金数额：</td>
													<td class="FieldInput"><label  field="regMon"/>万元</td>
													<td class="FieldLabel">验资单位：</td>
													<td class="FieldInput" colspan="3"><label  field="checkCapitalOrgan"/></td>
												</tr>
												<tr>
													<td class="FieldLabel">开办资金来源：</td>
													<td class="FieldInput" colspan="5"><label  field="moneySource"/></td>
												</tr>
												<tr>	
													<td class="FieldLabel">住所产权单位：</td>
													<td class="FieldInput" colspan="3"><label  field="housingOrgan"/></td>
													<td class="FieldLabel">用房面积：</td>
													<td class="FieldInput"><label  field="housingArea"/>平方米</td>
												</tr>
												<tr id="leasePeriod" style="display:none">
													<td class="FieldLabel">租（借）期限：</td>
													<td class="FieldInput" colspan="5"><label  field="leasePeriod"/></td>
												</tr>
												<tr>	
													<td class="FieldLabel">民办非企业通信地址：</td>
													<td class="FieldInput"><label  field="sorgAdds"/></td>
													<td class="FieldLabel">民办非企业电子邮箱：</td>
													<td class="FieldInput"><label  field="sorgEmail"/></td>
													<td class="FieldLabel" style="width:15%">民办非企业传真：</td>
													<td class="FieldInput" style="width:17%"><label  field="sorgFax"/></td>
												</tr>
											</table>
										</form>
									</fieldset>
									<fieldset>
										<legend>业务主管单位意见</legend>
										<form method="post" dataset="somApplyDataSet" onsubmit="return false" class="L5form" >
											<table width="100%">
												<tr>
													<td class="FieldLabel" style="width:17%">业务主管单位：</td>
													<td class="FieldInput" colspan='3'><label field="borgName" name='"业务主管单位"' style="width:90%" dataset="businessOrganSelect"/></td>
													<td class="FieldLabel" style="width:17%">业务主管单位审查同意日期：</td>
													<td class="FieldInput" style="width:17%"><label  field="borgCheckDate"/></td>
												</tr>
												<tr>
													<td class="FieldLabel" style="width:17%">单位负责人：</td>
													<td class="FieldInput" style="width:17%"><label  field="borgPeople"/></td>
													<td class="FieldLabel" style="width:17%">单位电话：</td>
													<td class="FieldInput" style="width:17%"><label  field="borgPhone"/></td>
													<td class="FieldLabel" style="width:17%"></td>
													<td class="FieldInput" style="width:17%"></td>
												</tr>
											</table>
										</form>
									</fieldset>
									<fieldset>
										<legend>历史处理意见</legend>
										<form method="post" dataset="somApplyDataSet" onsubmit="return false" class="L5form" >
											<table width="100%">
												<tr>
													<td class="FieldLabel" style="width:17%">承办人意见：</td>
													<td class="FieldInput" style="width:17%">
													<label field="acceptOpinionId" name='"承办人意见"' style="width:90%" dataset="hisOpinionDataSet" default="0" />
													</td>
													<td class="FieldLabel" style="width:17%">承办人：</td>
													<td class="FieldInput" style="width:17%"><label type="text" field="acceptPeopleName" name='承办人'  style="width:90%" />
													</td>
													<td class="FieldLabel" style="width:17%">承办时间：</td>
													<td class="FieldInput" style="width:17%"><label type="text" name='承办时间' field="acceptTime" style="width:90%" />
													</td>
												</tr>
												<tr>
													<td class="FieldLabel">承办补充意见：</td>
													<td class="FieldInput" colspan="5"><textarea rows="3" name='承办补充意见' field="acceptOpinion" style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" readonly></textarea>
													</td>
												</tr>
												<tr>
													<td class="FieldLabel" style="width:17%">现场勘查意见：</td>
													<td class="FieldInput" style="width:17%">
														<label type="text"  field="prospectOpinionId" name='"现场勘查意见"' style="width:90%" dataset="workFlowOpinionSelect"  />
													</td>
													<td class="FieldLabel" style="width:17%">现场勘查承办人：</td>
													<td class="FieldInput" style="width:17%"><label type="text" field="prospectPeopleName" name='现场勘查承办人'  style="width:90%" /></td>
													<td class="FieldLabel" style="width:17%">现场勘查日期：</td>
													<td class="FieldInput" style="width:17%"><label type="text" name='现场勘查日期' field="prospectDate" style="width:90%" /></td>
												</tr>
												<tr>
													<td class="FieldLabel" style="width:17%">现场勘查双方参加人员：</td>
													<td class="FieldInput" colspan="5">
														<label type="text"  field="prospectAttendPeople" name='"现场勘查双方参加人员"' style="width:90%"/>
													</td>
												</tr>
												<tr>
													<td class="FieldLabel" style="width:17%">现场勘查地点：</td>
													<td class="FieldInput" colspan="5"><label type="text" field="prospectPlace" name='现场勘查地点'  style="width:90%" /></td>
												</tr>
												<tr>
													<td class="FieldLabel">现场勘查补充意见：</td>
													<td class="FieldInput" colspan="5"><textarea rows="3" name='现场勘查补充意见' field="prospectOpinion" style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" readonly></textarea>
													</td>
												</tr>
												<tr>
													<td class="FieldLabel" style="width:17%">初审意见：</td>
													<td class="FieldInput" style="width:17%">
														<label field="examinOpinionId" name='"初审意见"' style="width:90%" dataset="workFlowOpinionSelect" default="0" />
													</td>
													<td class="FieldLabel" style="width:17%">初审负责人：</td>
													<td class="FieldInput" style="width:17%"><label type="text" field="examinPeopleName" name='初审负责人'  style="width:90%" />
													</td>
													<td class="FieldLabel" style="width:17%">初审时间：</td>
													<td class="FieldInput" style="width:17%"><label type="text" name='初审时间' field="examinTime" style="width:90%" />
													</td>
												</tr>
												<tr>
													<td class="FieldLabel">初审补充意见：</td>
													<td class="FieldInput" colspan="5"><textarea rows="3" name='初审补充意见' field="examinOpinion" style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" readonly></textarea>
													</td>
												</tr>
												<tr>
													<td class="FieldLabel" style="width:17%">审核意见：</td>
													<td class="FieldInput" style="width:17%">
														<label field="checkOpinionId" name='"审核意见"' style="width:90%" dataset="workFlowOpinionSelect" default="0" />
													</td>
													<td class="FieldLabel" style="width:17%">审核人：</td>
													<td class="FieldInput" style="width:17%"><label type="text" field="checkPeopleName" name='审核人' style="width:90%" />
													</td>
													<td class="FieldLabel" style="width:17%">审核时间：</td>
													<td class="FieldInput" style="width:17%"><label type="text" name='审核时间' field="checkTime" style="width:90%" />
													</td>
												</tr>
												<tr>
													<td class="FieldLabel">审核补充意见：</td>
													<td class="FieldInput" colspan="5"><textarea rows="3" name='审核补充意见' field="checkOpinion" style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" readonly></textarea>
													</td>
												</tr>
												<tr>
													<td class="FieldLabel" style="width:17%">批准意见：</td>
													<td class="FieldInput" style="width:17%">
														<label field="auditOpinionId" name='"批准意见"' style="width:90%" dataset="workFlowOpinionSelect" default="0" />
													</td>
													<td class="FieldLabel" style="width:17%">批准人：</td>
													<td class="FieldInput" style="width:17%"><label type="text" field="auditPeopleName" name='批准人' style="width:90%" />
													</td>
													<td class="FieldLabel" style="width:17%">批准时间：</td>
													<td class="FieldInput" style="width:17%"><label type="text" name='批准时间' field="auditTime" style="width:90%" />
													</td>
												</tr>
												<tr>
													<td class="FieldLabel">批准补充意见：</td>
													<td class="FieldInput" colspan="5"><textarea rows="3" name='批准补充意见' field="auditOpinion" style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" readonly></textarea>
													</td>
												</tr>
											</table>
										</form>
									</fieldset>
								</next:Html>
							</next:Panel>
						</next:Panel>
						<next:Panel title="全体合伙人情况">
							<next:EditGridPanel id="peopleGrid" dataset="somDutyDataSet" width="100%" stripeRows="true" height="99.9%">
								<next:TopBar>
									<next:ToolBarItem symbol="->"></next:ToolBarItem>
									<next:ToolBarItem iconCls="detail" text="查看" handler="detailPeople"></next:ToolBarItem>
								</next:TopBar>
								<next:Columns>
									<next:RowNumberColumn/>
									<next:RadioBoxColumn></next:RadioBoxColumn>
									<next:Column header="内码" field="id" width="15%" editable="false" hidden="true"><next:TextField/></next:Column>
									<next:Column header="身份证号" field="idCard" width="20%" editable="false"><next:TextField/></next:Column>
									<next:Column header="姓名" field="name" width="10%" editable="false"><next:TextField/></next:Column>
									<next:Column header="性别" field="sex" width="10%" editable="false"><next:ComboBox dataset="sexSelect"/></next:Column>
									<next:Column header="出生年月" field="birthday" width="10%" editable="false"><next:TextField/></next:Column>
									<next:Column header="是否在任" field="ifServe"width="10%" editable="false"><next:TextField/><next:ComboBox dataset="ifServeSelect"/></next:Column>
									<next:Column header="是否负责人" field="ifLegal" width="15%" editable="false"><next:TextField/><next:ComboBox dataset="comm_yesorno"/></next:Column>
								</next:Columns>
								<next:BottomBar>
									<next:PagingToolBar dataset="somDutyDataSet"/>
								</next:BottomBar>
							</next:EditGridPanel>
						</next:Panel>
						<next:Panel title="负责人登记表" >
							<next:TabPanel  width="100%" height="100%">
								<next:Tabs>
									<next:Panel  title="基本信息"  width="100%" height="100%" autoScroll="true">
										<next:Html>
											<form  method="post" dataset="LegalPeopleDataSet" onsubmit="return false" class="L5form">
												<table width="100%">
													<tr>
														<td class="FieldLabel" style="width:15%">身份证号码：</td>
														<td class="FieldInput" style="width:21%"><label id="labelIdCard" field="idCard"/></td>
														<td class="FieldLabel" style="width:14%">姓名：</td>
														<td class="FieldInput" style="width:17%"><label field="name"/></td>
														<td class="FieldLabel" style="width:14%" rowspan="4">照片:</td>
														<td class="FieldInput" style="width:19%" nowrap colspan="1" rowspan="4">
														<div id="photoDiv">
															<img id="img" name="RELATIONER_PHOTOC_IMG" width=82.5 height=110 src="<%=SkinUtils.getRootUrl(request) %>jsp/cams/sorg/comm/signet/default.jpg" 
															align="top" ondblclick="editPhoto(1,'photoId','RELATIONER_PHOTOC_IMG');"
															onerror="javascript:this.src='<%=SkinUtils.getRootUrl(request) %>jsp/cams/sorg/comm/signet/default.jpg'" alt="暂无图片" />
															<input type="hidden" id="photoId" name="photoId"/>
														</div>	
														</td>
													</tr>
													<tr>
														<td class="FieldLabel">曾用名：</td>
														<td class="FieldInput"><label field="aliasName"/></td>
														<td class="FieldLabel">年龄：</td>
														<td class="FieldInput"><label id="labelAge" name='年龄'/></td>
													</tr>
													<tr>
														<td class="FieldLabel">性别：</td>
														<td class="FieldInput"><label field="sex" dataset="sexSelect"/></td>
														<td class="FieldLabel">出生年月：</td>
														<td class="FieldInput"><label field="birthday"/></td>
													</tr>
													<tr>
														<td class="FieldLabel">政治面貌：</td>
														<td class="FieldInput"><label field="politics" dataset="politicsSelect"/></td>
														<td class="FieldLabel">民族：</td>
														<td class="FieldInput"><label field="folk" dataset="folkSelect"/></td>
													</tr>
													<tr>
														<td class="FieldLabel">文化程度：</td>
														<td class="FieldInput"><label field="education" dataset="educationSelect"/>
														</td>
														<td class="FieldLabel">技术职称：</td>
														<td class="FieldInput" colspan="5"><label field="profession"/></td>
													</tr>
													<tr>
														<td class="FieldLabel">家庭住址：</td>
														<td class="FieldInput" colspan="3"><label field="adds"/></td>
														<td class="FieldLabel">户口所在地：</td>
														<td class="FieldInput"><label field="populace"/></td>
													</tr>
													<tr>
														<td class="FieldLabel">邮编：</td>
														<td class="FieldInput"><label field="postCode"/></td>
														<td class="FieldLabel">电话：</td>
														<td class="FieldInput"><label field="phone"/></td>
														<td class="FieldLabel">专/兼职：</td>
														<td class="FieldInput"><label field="ifFulltime" dataset="ifFulltimeSelect" /></td>
													</tr>
													<tr>
														<td class="FieldLabel">人事关系所在单位：</td>
														<td class="FieldInput" colspan="3"><label field="personUnit"/></td>
														<td class="FieldLabel">人事关系所在单位电话：</td>
														<td class="FieldInput"><label field="personUnitPhone"/></td>
													</tr>											
													<tr>
														<td class="FieldLabel">工作单位：</td>
														<td class="FieldInput" colspan="3"><label field="workName"/></td>
														<td class="FieldLabel">工作单位职务：</td>
														<td class="FieldInput"><label field="workDuties"/></td>
													</tr>
													<tr>
														<td class="FieldLabel">是否党政机关领导干部：</td>
														<td class="FieldInput"><label field="ifPartyLeader" dataset="comm_yesorno"/></td>
														<td class="FieldLabel">批准机关：</td>
														<td class="FieldInput"><label field="promiseOrgan"/></td>
														<td class="FieldLabel">批准文号：</td>
														<td class="FieldInput"><label field="promiseCode" /></td>
													</tr>
													<tr>
														<td class="FieldLabel">本人所在单位人事部门审查意见：</td>
														<td class="FieldInput" colspan="5"><textarea rows="2" name='"所在单位人事部门审查意见"' readonly="readonly" field="workOpinion" style="width:97.7%;background-color:#F5FAFA;border:0;overflow:auto;"></textarea></td>
													</tr>
													<tr>
														<td class="FieldLabel">审查工作单位：</td>
														<td class="FieldInput" colspan="3"><label  field="workName"/></td>
														<td class="FieldLabel">审查日期：</td>
														<td class="FieldInput"><label  field="workCheckDate"/></td>
													</tr>
													<tr>
															<td class="FieldLabel"><label>按照本民办非企业章程会议产生通过情况：</label></td>
															<td class="FieldInput" colspan="5"><textarea   rows="2" name='"按照本民办非企业章程会议产生通过情况"' field="sorgOpinion" style="width:97.7%;background-color:#F5FAFA;border:0;overflow:auto;" readonly></textarea><span style="color:red"></span></td>
														</tr>
														<tr>	
															<td class="FieldLabel"><label>签署日期：</label></td>
															<td class="FieldInput" colspan="5"><label  field="sorgCheckDate"/></td>
													</tr>
													<tr>
														<td class="FieldLabel">备注：</td>
														<td class="FieldInput" colspan="5"><textarea rows="2" name='"备注"' readonly="readonly" field="note" style="width:97.7%;background-color:#F5FAFA;border:0;overflow:auto;"></textarea></td>
													</tr>
												</table>
											</form>
										</next:Html>
									</next:Panel>
									<next:EditGridPanel id="somResumeLegalGrid" dataset="somResumeLegalDataSet"  stripeRows="true" title="本人简历" width="100%" height="100%" autoScroll="true">
										<next:TopBar>
											<next:ToolBarItem symbol="->"></next:ToolBarItem>
										</next:TopBar>
										<next:Columns>
											<next:RowNumberColumn/>
											<next:Column header="内码" field="id" width="15%" editable="true" hidden="true"><next:TextField/></next:Column>
											<next:Column header="开始年月" field="startDate" width="10%" editable="false"><next:TextField/></next:Column>
											<next:Column header="结束年月" field="endDate" width="10%" editable="false"><next:TextField/></next:Column>
											<next:Column header="在何地区何单位" field="workOrgan" width="45%" editable="false"><next:TextField/></next:Column>
											<next:Column header="任（兼）何职" field="duty" width="20%" editable="false"><next:TextField/></next:Column>
										</next:Columns>
										<next:BottomBar>
											<next:PagingToolBar dataset="somResumeLegalDataSet"/>
										</next:BottomBar>
									</next:EditGridPanel>
									<next:EditGridPanel id="uploadLegalPeopleGrid" title="法律要件" stripeRows="true" dataset="somLegalPeopleElectronicDataSet" width="100%" height="100%" autoScroll="true">
										<next:TopBar>
											<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
											<next:ToolBarItem symbol="->"></next:ToolBarItem>
										</next:TopBar>
										<next:Columns>
											<next:RowNumberColumn />
											<next:RadioBoxColumn></next:RadioBoxColumn>
											<next:Column header="档案目录名" field="catalogCode" width="38%" editable="false" dataset="cataLogCodeSelect">
												<next:TextField />
											</next:Column>
											<next:Column header="附件名称" field="fileName" width="30%" editable="false">
												<next:TextField />
											</next:Column>
											<next:Column header="附件描述" field="fileMess" width="20%" editable="false">
												<next:TextField />
											</next:Column>
											<next:Column header="下载附件" field="" width="10%" editable="false" renderer="clickDownloadLegalPeopleHref">
												<next:TextField />
											</next:Column>
										</next:Columns>
										<next:BottomBar>
											<next:PagingToolBar dataset="somLegalPeopleElectronicDataSet" />
										</next:BottomBar>
									</next:EditGridPanel>
								</next:Tabs>
							</next:TabPanel>
						</next:Panel>
						<next:Panel title="内设机构">
							<next:EditGridPanel id="officeGrid" width="100%" stripeRows="true" height="100%" dataset="somOfficeDataSet">
								<next:TopBar>
									<next:ToolBarItem symbol="内设办事机构列表"></next:ToolBarItem>
									<next:ToolBarItem symbol="->"></next:ToolBarItem>
									<next:ToolBarItem iconCls="detail" text="查看" handler="detailOffice"></next:ToolBarItem>
								</next:TopBar>
			
								<next:Columns>
									<next:RowNumberColumn />
									<next:RadioBoxColumn></next:RadioBoxColumn>
									<next:Column header="内设机构名称" field="name" width="25%" editable="false" ><next:TextField /></next:Column>
									<next:Column header="机构负责人" field="officeChief" width="15%" editable="false"><next:TextField /></next:Column>
									<next:Column header="场所"    field="place" width="43%" editable="false"><next:TextField /></next:Column>
									<next:Column header="电话" 	  field="phone"      width="15%" editable="false" ><next:TextField /></next:Column>
								</next:Columns>
								<next:BottomBar>
									<next:PagingToolBar dataset="somOfficeDataSet" />
								</next:BottomBar>
							</next:EditGridPanel>
						</next:Panel>
						<next:Panel title="章程核准表"  width="100%" autoScroll="true">
							<next:Html>
									<fieldset>
										<legend>民办非企业单位章程</legend>
								<form method="post" onsubmit="return false" dataset="somRuleDataSet" class="L5form">
										<input type="hidden" id="sorgId" field="sorgId" value="社团ID"/>
										<table width="100%">
											<tr>
												<td class="FieldLabel">会议名称：</td>
												<td class="FieldInput" colspan="5"><label  field="meetingName"/></td>
											</tr>
											<tr>
												<td class="FieldLabel" style="width:17%">时间：</td>
												<td class="FieldInput" style="width:17%"><label  field="meetingDate"/></td>
												<td class="FieldLabel" style="width:17%">应到人数：</td>
												<td class="FieldInput" style="width:15%"><label  field="shouldNum"/></td>
												<td class="FieldLabel" style="width:17%">实到人数：</td>
												<td class="FieldInput" style="width:17%"><label  field="realNum"/></td>
											</tr>
											<tr>
												<td class="FieldLabel">同意人数：</td>
												<td class="FieldInput"><label  field="passNum"/></td>
												<td class="FieldLabel">反对人数：</td>
												<td class="FieldInput"><label  field="nopassNum"/></td>
												<td class="FieldLabel">弃权人数：</td>
												<td class="FieldInput"><label  field="giveupNum"/></td>
											</tr>
											<tr>
												<td class="FieldLabel">需说明的主要问题：</td>
												<td class="FieldInput" colspan="5"><textarea name="需说明的主要问题" id=mainQuestion field="mainQuestion" cols="65" rows="4" style="width:97%;background-color:#F5FAFA;border:0;overflow:auto;" readonly></textarea></td>
											</tr>
										</table>
								</form>
									</fieldset>
							</next:Html>
						</next:Panel>
						<next:Panel title="法律要件" >
							<next:EditGridPanel id="uploadGrid" width="100%" stripeRows="true" height="100%" dataset="somElectronicDataSet">
								<next:TopBar>
									<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
									<next:ToolBarItem symbol="->"></next:ToolBarItem>
								</next:TopBar>
				
								<next:Columns>
									<next:RowNumberColumn />
									<next:RadioBoxColumn></next:RadioBoxColumn>
									<next:Column header="档案目录名"  field="catalogCode" width="38%" editable="false" dataset="cataLogCodeSelect" ><next:TextField /></next:Column>
									<next:Column header="附件名称"    field="fileName" width="30%" editable="false"><next:TextField /></next:Column>
									<next:Column header="附件描述"    field="fileMess" width="20%" editable="false"><next:TextField /></next:Column>
									<next:Column header="下载附件"    field="" width="10%" editable="false" renderer="clickDownloadHref"><next:TextField /></next:Column>
								</next:Columns>
								<next:BottomBar>
									<next:PagingToolBar dataset="somElectronicDataSet" />
								</next:BottomBar>
							</next:EditGridPanel>
						</next:Panel>
					</next:Tabs>
				</next:TabPanel>
			</next:Panel>
			<next:Panel title="流程历史意见" width="100%" >
				<next:GridPanel id="flowGrid" width="100%" stripeRows="true" height="100%" dataset="somFlowListDataSet" >
					<next:Columns>
						<next:RowNumberColumn/>
						<next:Column id="activity" header="流程环节" field="activity" width="13%" editable="false"></next:Column>
						<next:Column id="organId" header="处理单位" field="organId" width="13%" editable="false" dataset="pubOrganDataSet"></next:Column>
						<next:Column id="deptId" header="处理部门" field="deptId" width="13%" editable="false" dataset="pubOrganDataSet"></next:Column>
						<next:Column id="actorId" header="处理人" field="actorId" width="10%" editable="false" dataset="pubOrganDataSet"></next:Column>
						<next:Column id="commitTime" header="处理时间" field="commitTime" width="18%" editable="false"></next:Column>
						<next:Column id="opinionId" header="处理意见" field="opinionId" width="10%" editable="false" dataset="workFlowOpinionSelect"></next:Column>
						<next:Column id="opinion" header="处理补充意见" field="opinion" width="40%" editable="false"></next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="somFlowListDataSet" />
					</next:BottomBar>
				</next:GridPanel>
			</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>
<!-- 负责人录入窗口 -->
<next:Window id="peopleWin" title="全体合伙人情况" resizable="false" width="800" height="400" closeAction="hide" autoScroll="true">
	<next:Panel id="panel_win">
		<next:Html>
			<form title="全体合伙人情况" id="addForm" method="post" dataset="somDutyInsertDataSet" onsubmit="return false" class="L5form">
				<table width="100%">
					<tr>
						<td class="FieldLabel" style="width:15%">身份证号码：</td>
						<td class="FieldInput" style="width:21%"><label  field="idCard"/></td>
						<td class="FieldLabel" style="width:14%">姓名：</td>
						<td class="FieldInput" style="width:17%"><label  field="name"/></td>
						<td class="FieldLabel" style="width:14%">曾用名：</td>
						<td class="FieldInput" style="width:19%"><label  field="aliasName"/></td>
					</tr>
					<tr>
						<td class="FieldLabel">性别：</td>
						<td class="FieldInput"><label  field="sex" dataset="sexSelect"/></td>
						<td class="FieldLabel">出生年月：</td>
						<td class="FieldInput"><label  field="birthday"/></td>
						<td class="FieldLabel">年龄：</td>
						<td class="FieldInput"><label id="peopleAge" name='年龄'/></td>
					</tr>
					<tr>
						<td class="FieldLabel">政治面貌：</td>
						<td class="FieldInput"><label  field="politics" dataset="politicsSelect"/></td>
						<td class="FieldLabel">民族：</td>
						<td class="FieldInput" colspan="3"><label  field="folk" dataset="folkSelect"/></td>
					</tr>
					<tr>
						<td class="FieldLabel">文化程度：</td>
						<td class="FieldInput"><label field="education" dataset="educationSelect"/>
						</td>
						<td class="FieldLabel">技术职称：</td>
						<td class="FieldInput" colspan="3"><label field="profession"/></td>
					<tr>
						<td class="FieldLabel">家庭住址：</td>
						<td class="FieldInput" colspan="3"><label  field="adds"/></td>
						<td class="FieldLabel">户口所在地：</td>
						<td class="FieldInput"><label  field="populace"/></td>
					</tr>
					<tr>
						<td class="FieldLabel">邮编：</td>
						<td class="FieldInput"><label  field="postCode"/></td>
						<td class="FieldLabel">电话：</td>
						<td class="FieldInput"><label  field="phone"/></td>
						<td class="FieldLabel">专/兼职：</td>
						<td class="FieldInput"><label  field="ifFulltime" dataset="ifFulltimeSelect"/></td>
					</tr>
					<tr>
						<td class="FieldLabel">人事关系所在单位：</td>
						<td class="FieldInput" colspan="3"><label field="personUnit"/></td>
						<td class="FieldLabel">人事关系所在单位电话：</td>
						<td class="FieldInput"><label field="personUnitPhone"/></td>
					</tr>						
					<tr>
						<td class="FieldLabel">工作单位：</td>
						<td class="FieldInput" colspan="3"><label  field="workName"/></td>
						<td class="FieldLabel">工作单位职务：</td>
						<td class="FieldInput"><label  field="workDuties"/></td>
					</tr>
					<tr>
						<td class="FieldLabel">是否党政机关领导干部：</td>
						<td class="FieldInput"><label  field="ifPartyLeader" dataset="comm_yesorno" /></td>
						<td class="FieldLabel">批准机关：</td>
						<td class="FieldInput"><label  field="promiseOrgan"/></td>
						<td class="FieldLabel">批准文号：</td>
						<td class="FieldInput"><label  field="promiseCode"/></td>
					</tr>
					<tr>
						<td class="FieldLabel">其他社会职务：</td>
						<td class="FieldInput" colspan="5"><textarea rows="3" field="otherDuties" readonly="readonly" name='"其他社会职务"' style="width:97.7%;background-color:#F5FAFA;border:0;overflow:auto;"></textarea></td>
					</tr>
					<tr>
						<td class="FieldLabel">本人所在单位人事部门审查意见：</td>
						<td class="FieldInput" colspan="5"><textarea rows="2" name='"所在单位人事部门审查意见"' readonly="readonly" field="workOpinion" style="width:97.7%;background-color:#F5FAFA;border:0;overflow:auto;"></textarea></td>
					</tr>
					<tr>
						<td class="FieldLabel">审查工作单位：</td>
						<td class="FieldInput" colspan="3"><label  field="workName"/></td>
						<td class="FieldLabel">审查日期：</td>
						<td class="FieldInput"><label  field="workCheckDate"/></td>
					</tr>
					<tr>
						<td class="FieldLabel">备注：</td>
						<td class="FieldInput" colspan="5"><textarea rows="2" name='"备注"' field="note" style="width:97.7%;background-color:#F5FAFA;border:0;overflow:auto;" readonly="readonly"></textarea></td>
					</tr>
				</table>
			</form>				
		</next:Html>
	</next:Panel>
	<next:EditGridPanel id="somResumeGrid" dataset="somResumeInsertDataSet" width="800" stripeRows="true" height="250" title="本人简历">
				<next:TopBar>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
				</next:TopBar>
				<next:Columns>
					<next:RowNumberColumn/>
					<next:Column header="内码" field="id" width="15%" editable="true" hidden="true"><next:TextField/></next:Column>
					<next:Column header="开始年月" field="startDate" width="10%" editable="false"><next:TextField/></next:Column>
					<next:Column header="结束年月" field="endDate" width="10%" editable="false"><next:TextField/></next:Column>
					<next:Column header="在何地区何单位" field="workOrgan" width="45%" editable="false"><next:TextField/></next:Column>
					<next:Column header="任（兼）何职" field="duty" width="20%" editable="false"><next:TextField/></next:Column>
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar dataset="somResumeInsertDataSet"/>
				</next:BottomBar>
	</next:EditGridPanel>
	<next:Buttons>
		<next:ToolButton text="关闭" handler="winClosePeople"></next:ToolButton>
	</next:Buttons>
</next:Window>
<next:Window id="officeWin" title="民办非企业单位内设机构备案表" closeAction="hide" width="740"modal='true'>
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="关闭" handler="winCloseOffice"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form dataset="winOfficeDataSet"  onsubmit="return false"  class="L5form">
		<table border="1" width='100%'>
			<tr>
				<td class="FieldLabel" ><label>内设机构名称：</label></td>
				<td class="FieldInput"><label  field="name"/></td>
				<td class="FieldLabel"><label>场所：</label></td>
				<td class="FieldInput" colspan="3"><label  field="place"/></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width:13%"><label>机构负责人：</label></td>
				<td class="FieldInput" style="width:20%"><label  field="officeChief"/></td>
				<td class="FieldLabel" style="width:13%"><label>电话：</label></td>
				<td class="FieldInput" style="width:20%"><label  field="phone"/></td>
				<td class="FieldLabel" style="width:13%"><label>邮编：</label></td>
				<td class="FieldInput" style="width:20%"><label  field="postCode"/></td>
			</tr>

			<tr>
				<td class="FieldLabel"><label>职能：</label></td>
				<td class="FieldInput" colspan="5"><textarea type="text" name="职能" id="dutiesDesc" field="dutiesDesc" rows="5" style="width:98%"style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" readonly="readonly"></textarea></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>设立理由：</label></td>
				<td class="FieldInput" colspan="5"><textarea type="text" name="设立理由" id="reason" field="reason" cols="75" rows="4" style="width:98%"style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" readonly="readonly"></textarea></td>
			</tr>
		</table>
		</form>
   </next:Html>
</next:Window>
<jsp:include page="../../../comm/upload/uploadWindow.jsp" flush="true"/>
</body>
</html>