<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>发证页面</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript">
var sorgId='';
var taskCode = '<%=request.getParameter("taskCode")%>';
var legalRecord="";
var legalDuties="00012";
var sorgType="J";
var sorgCodeNum="";
var cnNameNum="";
var somApplyType="204";
var applyType="219,220,221";
var fileCodeL="J016";//理事
var fileCodeS="";//监事
var fileCodeF="J015";//法定代表人
var legalDutyId="";
var peopleType='';
var dutyId = 0;//初始dutyId
var currentId='';
var president='';//理事长
var fetchPeople='';//领证人 
var fetchDate='';//领证日期
//初始化
function init() {
var winDutyDataSet = L5.DatasetMgr.lookup("winDutyDataSet");
	L5.getCmp("tab").setActiveTab("1");
	L5.getCmp("tab").setActiveTab("2");
	L5.getCmp("tab").setActiveTab("3");
	L5.getCmp("tab").setActiveTab("4");
	L5.getCmp("tab").setActiveTab("5");
	L5.getCmp("tab").setActiveTab("0");
	
	var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
	somApplyDataSet.setParameter("TASK_CODE", taskCode);
	somApplyDataSet.load();
	somApplyDataSet.on('load', loadInfo);		
		
	//过滤负责人职务：法定代表人
	sorgDutiesSelect.filterBy(function(record, id){
		if("00012".indexOf(record.get('value'))==-1){
			return record;
		}
	});
}
function loadInfo(){
	sorgId = somApplyDataSet.get('sorgId');
	var somOrganDataSet=L5.DatasetMgr.lookup("somOrganDataSet");
	somOrganDataSet.setParameter("SORG_ID@=", sorgId);
	somOrganDataSet.load();
	
	somFlowDataSet.setParameter("TASK_CODE@=", taskCode);
	somFlowDataSet.load();
	
	aspForJianShi.setParameter("TASK_CODE", taskCode);
	aspForJianShi.setParameter("SORG_DUTIES", "00006");
	aspForJianShi.load();
	
	somResumeInsertDataSet.setParameter("TASK_CODE", taskCode);
	somResumeInsertDataSet.on("load",function(){
		aspForLiShi.setParameter("TASK_CODE", taskCode);
		aspForLiShi.setParameter("SORG_DUTIES@in", "00001,00003,00004,00005,00012");
		aspForLiShi.load();
		aspForLiShi.on('load',function(){
			var sorgOpinion="";
			var sorgCheckDate="";
			//加载法定代表人
			aspForLiShi.each(function(record, index){
				if(record.get('sorgDuties') == legalDuties){
					legalDutyId = record.get("dutyId");
					sorgOpinion=record.get("sorgOpinion");
					sorgCheckDate=record.get("sorgCheckDate");
				}
			});
			aspForLiShi.each(function(record, index){
				if(record.get('sorgDuties') == "00001"){
					president=record;
					LegalPeopleDataSet.insert(0,president.copy());
					LegalPeopleDataSet.set("sorgOpinion",sorgOpinion);
					LegalPeopleDataSet.set("sorgCheckDate",sorgCheckDate);					
					synPhotoDetail(president.get('photoId'),null);//同步照片
					document.getElementById("labelAge").innerHTML = getAgeByCode(president.get('idCard'));
					//回填法定代表人简历
						var j=0;
						for(var i=somResumeInsertDataSet.getCount()-1;i>=0;i--){
							var somResumeRecord =somResumeInsertDataSet.getAt(i);
							if(record.get('dutyId') == somResumeRecord.get('dutyId')){
								somResumeLegalDataSet.insert(j,somResumeRecord);
								j++;
							}
						}
						//回填法定代表人简历结束
				}
				aspForLiShi.filterBy(function(record, id){
					if("00012".indexOf(record.get('sorgDuties'))==-1){
						return record;
					}
				});
			});
			somLegalPeopleElectronicDataSet_load();//同步法定代表人法律要件
		});
	});
	somResumeInsertDataSet.load();
	somElectronicDataSet_load();//同步法律要件
	
	LegalPeopleDataSet.on('load',function(){
		if(LegalPeopleDataSet.getCount() == 0){
			LegalPeopleDataSet.newRecord();
		}
	});
	
	somSessionDataSet.setParameter("TASK_CODE", taskCode);
	somSessionDataSet.load();
	somSessionDataSet.on('load',function(){
		if(somSessionDataSet.getCount() == 0){
			somSessionDataSet.newRecord();
		}
	});
	var somRuleDataSet=L5.DatasetMgr.lookup("somRuleDataSet");
	somRuleDataSet.setParameter("TASK_CODE", taskCode);
	somRuleDataSet.load();
	somRuleDataSet.on('load',function(){
		if(somRuleDataSet.getCount() == 0){
			somRuleDataSet.newRecord();
		}
	});
	
}
//返回
function back(){
	history.go(-1);
}

// 查看负责人明细
function detailL(){
	peopleType="L";
	var grid=L5.getCmp("peopleGrid");
	var currentRecord=grid.getSelectionModel().getSelected();
	if(!currentRecord){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	somDutyDataSet.removeAll();
	somDutyDataSet.insert(0,currentRecord.copy());
	somResumeInsertDataSet.filterBy(function(record, id){
		if(record.get('dutyId') == currentRecord.get('dutyId')){
			return record;
		}
	});
	L5.getCmp("peopleWin").show();
	showAge();
	synPhotoDetail(somDutyDataSet.get("photoId"),"1");//同步照片
	somPeopleElectronicDataSet_load(fileCodeL,currentRecord.get('dutyId'));//同步法律要件
}
// 查看负责人明细
function detailS(){
	peopleType="S";
	var grid=L5.getCmp("peopleGrid1");
	var currentRecord=grid.getSelectionModel().getSelected();
	if(!currentRecord){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	somDutyDataSet.removeAll();
	somDutyDataSet.insert(0,currentRecord.copy());
	somResumeInsertDataSet.filterBy(function(record, id){
		if(record.get('dutyId') == currentRecord.get('dutyId')){
			return record;
		}
	});
	L5.getCmp("peopleWin").show();
	showAge();
	synPhotoDetail(somDutyDataSet.get("photoId"),"1");//同步照片
	somPeopleElectronicDataSet.removeAll();//同步法律要件
}
function closeWin(){
	L5.getCmp("peopleWin").setVisible(false);
}
function countRender(value){
	var count = aspForLiShi.getTotalCount();
	if(count === undefined){
		count=0;
	}
	return "理事总人数: "+count+" 人";

}
function countRenderS(value){
	var count = aspForJianShi.getTotalCount();
	if(count === undefined){
		count=0;
	}
	return "监事总人数: "+count+" 人";

}
</script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js")%>'></script>
<script type="text/javascript">var rootPath='<%=SkinUtils.getRootUrl(request)%>';</script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/somPhoto.js") %>'></script>
<script type="text/javascript" src="<%=SkinUtils.getRootUrl(request)%>skins/js/ISEditPhoto.js"></script>
</head>
<body>
<%--定义dataset--%>
<model:datasets>
	<%--基金会基本信息--%>
	<model:dataset id="somOrganDataSet"
		cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" global="true"
		method="queryOrgan">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan"></model:record>
	</model:dataset>
	<!-- 届次信息 -->
	<model:dataset id="somSessionDataSet"
		cmd="com.inspur.cams.sorg.base.cmd.SomSessionQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomSession">
			<model:field name="tenure" type="string" rule="integer" />
		</model:record>
	</model:dataset>
	<!-- 监事备案 -->
	<model:dataset id="aspForJianShi"
		cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true"
		method="queryAspchief">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<!-- 理事备案 -->
	<model:dataset id="aspForLiShi"
		cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd"
		method="queryAspchief" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<!-- 法定代表人信息 -->
	<model:dataset id="LegalPeopleDataSet"
		cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty">

		</model:record>
	</model:dataset>
	<!-- 负责人录入窗口 -->
	<model:dataset id="peopleInsertDataset"
		cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<%--所有符合身份证号的人员列表--%>
	<model:dataset id="winPeopleDataSet"
		cmd="com.inspur.cams.sorg.base.cmd.SomPeopleQueryCmd">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeople"></model:record>
	</model:dataset>
	<%--所有符合身份证号的人员列表--%>
	<model:dataset id="winDutyDataSet"
		cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd"
		method="queryPeople">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<%-- 章程核准信息 --%>
	<model:dataset id="somRuleDataSet"
		cmd="com.inspur.cams.sorg.base.cmd.SomRuleQueryCmd" method="queryRule"
		global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomRule"></model:record>
	</model:dataset>
	<%--电子档案--%>
	<model:dataset id="somElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true" method="queryCatalog" isGroup="true" groupField="applyType" pageSize="50">>
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--下载窗口--%>
	<model:dataset id="downloadDataSet"
		cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd"
		method="queryElectronic">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--人员电子档案--%>
	<model:dataset id="somPeopleElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true" method="queryPeopleCatalog">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--法定代表人员电子档案--%>
	<model:dataset id="somLegalPeopleElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true" method="queryPeopleCatalog" >
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--业务意见--%>
	<model:dataset id="somApplyDataSet"
		cmd="com.inspur.cams.sorg.base.cmd.SomApplyQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomApply">
			<%--业务意见信息验证--%>
			<model:field name="curOpinionId" type="string" rule="require" />
			<model:field name="curOpinion" type="string" rule="length{200}" />
		</model:record>
	</model:dataset>
	<%--历史意见 --%>
	<model:dataset id="somFlowDataSet"
		cmd="com.inspur.cams.sorg.base.cmd.SomFlowQueryCmd" global="true"
		sortField="COMMIT_TIME" pageSize="100">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomFlow"></model:record>
	</model:dataset>
	<%--人员简历 --%>
	<model:dataset id="somResumeInsertDataSet"
		cmd="com.inspur.cams.sorg.base.cmd.SomPeopleResumeQueryCommand"
		sortField="startDate" sortDirection="DESC" global="true">
		<model:record
			fromBean="com.inspur.cams.sorg.base.data.SomPeopleResume"></model:record>
	</model:dataset>
	<%--法定代表人人员简历 --%>
	<model:dataset id="somResumeLegalDataSet"
		cmd="com.inspur.cams.sorg.base.cmd.SomPeopleResumeQueryCommand"
		global="true">
		<model:record
			fromBean="com.inspur.cams.sorg.base.data.SomPeopleResume"></model:record>
	</model:dataset>
	<!-- 处理单位 -->
	<model:dataset id="pubOrganDataSet"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='PUB_ORGAN'></model:param>
			<model:param name="value" value='ORGAN_ID'></model:param>
			<model:param name="text" value='ORGAN_NAME'></model:param>
		</model:params>
	</model:dataset>

	<%--定义字典表--%>
	<model:dataset id="cataLogCodeSelect"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_CATALOG'></model:param>
			<model:param name="value" value='CATALOG_CODE'></model:param>
			<model:param name="text" value='CATALOG_NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 社会组织种类 -->
	<model:dataset id="sorgKindSelect"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_FUND_KIND'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 政治面貌 -->
	<model:dataset id="politicsSelect"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_POLITICAL'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 住所来源 -->
	<model:dataset id="resideSourceSelect"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_RESIDE_SOURCE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 住所来源 -->
	<model:dataset id="sorgNameSelect"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_ORGAN'></model:param>
			<model:param name="value" value='SORG_ID'></model:param>
			<model:param name="text" value='CN_NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 所属行事业 -->
	<model:dataset id="busScopeSelect"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BUS_SCOPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 社会组织职务 -->
	<model:dataset id="sorgDutiesSelect"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_DUTY'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 专兼职 -->
	<model:dataset id="ifFulltimeSelect"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_IF_FULLTIME'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 民族 -->
	<model:dataset id="folkSelect"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 民族 -->
	<model:dataset id="ifServeSelect"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_DUTY_IF_SERVE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 业务主管单位 -->
	<model:dataset id="businessOrganSelect"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true" sortField="ORDER_NUMBER">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_BUSINESS_ORGAN'></model:param>
			<model:param name="value" value='BORG_CODE'></model:param>
			<model:param name="text" value='BORG_NAME'></model:param>
			<model:param name="filterSql" value='<%="MORG_CODE ="+BspUtil.getOrganCode().substring(0,6)%>'></model:param>
		</model:params>
	</model:dataset>
	<!-- 证件类型 -->
	<model:dataset id="cardTypeSelect"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CARD_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 性别 -->
	<model:dataset id="sexSelect"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SEX'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 社会组织职务 -->
	<model:dataset id="sorgDutiesDataSet"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_DUTY'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO"
		autoLoad="true" global="true"></model:dataset>
	<model:dataset id="opinionSelect" enumName="WORKFLOW.OPINION"
		autoLoad="true" global="true"></model:dataset>
	<model:dataset id="hisOpinionDataSet" enumName="WORKFLOW.OPINION"
		autoLoad="true" global="true"></model:dataset>
	<model:dataset id="yesornoDataSet" enumName="COMM.YESORNO"
		autoLoad="true" global="true"></model:dataset>
</model:datasets>
<%--定义界面--%>
<next:Panel width="100%" height="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem  iconCls="return" text="返回" handler="back" ></next:ToolBarItem>		
	</next:TopBar>
	<next:TabPanel width="100%" height="100%" id="tab">
		<next:Tabs>
			<next:Panel title="基金会法人设立申请表" width="100%">
				<next:Panel width="100%" height="100%" id="tab1" autoScroll="true">
					<next:Html>
						<fieldset><legend>基金会法人设立申请表</legend>
						<form method="post" onsubmit="return false" class="L5form"
							dataset="somOrganDataSet">
						<table width="100%">
							<tr>
								<td class="FieldLabel">基金会中文名称：</td>
								<td class="FieldInput" colspan="3"><label field="cnName"></label></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width: 17%">基金会英文名称：</td>
								<td class="FieldInput" style="width: 17%"><label field="enName"/></td>
								<td class="FieldLabel" style="width: 17%">基金会英文名称缩写：</td>
								<td class="FieldInput" style="width: 17%"><label field="abName"/></td>
							</tr>
							<tr>
								<td class="FieldLabel">登记证号：</td>
								<td class="FieldInput"><label field="sorgCode"/></td>
								<td class="FieldLabel">组织机构代码：</td>
								<td class="FieldInput"><label field="organCode"/></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width: 17%">登记时间：</td>
								<td class="FieldInput" style="width: 17%"><label field="regDate"/></td>
								<td class="FieldLabel">基金会类型：</td>
								<td class="FieldInput"><label field="sorgKind" dataset="sorgKindSelect"/></td>
							</tr>
							<tr>
								<td class="FieldLabel">法定代表人：</td>
								<td class="FieldInput"><label field="legalPeople" /></td>
								<td class="FieldLabel">原始基金：</td>
								<td class="FieldInput"><label field="regMon"/>万元</td>
							</tr>
							<tr>
								<td class="FieldLabel">理事数：</td>
								<td class="FieldInput"><label field="councilNum" /></td>
								<td class="FieldLabel">监事数：</td>
								<td class="FieldInput"><label field="standCouncilNum"/></td>
							</tr>
							<tr>
								<td class="FieldLabel">业务主管单位：</td>
								<td class="FieldInput" colspan="3"><label field="borgName" dataset="businessOrganSelect"/></td>
							</tr>
							<tr>
								<td class="FieldLabel">住所：</td>
								<td class="FieldInput"><label field="residence"/></td>
								<td class="FieldLabel" style="width: 17%">邮编：</td>
								<td class="FieldInput" style="width: 17%"><label field="postCode"/><</td>
							</tr>
						</table>
						</form>
						</fieldset>
						<fieldset><legend>联系人信息</legend>
						<form method="post" onsubmit="return false" class="L5form"
							style="border-width: 0px" dataset="somApplyDataSet">
						<table width="100%">
							<tr>
								<td class="FieldLabel" style="width: 17%">联系人：</td>
								<td class="FieldInput" style="width: 17%"><label field="appPeople"/></td>
								<td class="FieldLabel" style="width: 17%">联系人电话：</td>
								<td class="FieldInput" style="width: 17%"><label field="appPhone"/></td>
							</tr>
						</table>
						</form>
						</fieldset>
						<fieldset><legend>业务主管单位审查意见</legend>
					<form id="form2" method="post" onsubmit="return false"
						class="L5form" dataset="somApplyDataSet">
					<table width="100%">
						<tr>
							<td class="FieldLabel">业务主管单位审查意见：</td>
							<td class="FieldInput" colspan="5"><textarea
								field="borgOpinion" cols="65" rows="2" 
								style="width: 98%; background-color: #F5FAFA; border: 0;overflow:auto;"
								 readonly="readonly"></textarea></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 17%">业务主管单位：</td>
							<td class="FieldInput" style="width: 51%"><label field="borgName" dataset="businessOrganSelect"/></td>
							<td class="FieldLabel" style="width: 17%">业务主管单位审查日期：</td>
							<td class="FieldInput" style="width: 17%"><label field="borgCheckDate"/></td>
						</tr>
					</table>
					</form>
					</fieldset>
						<fieldset><legend>历史处理意见</legend>
						<form method="post" dataset="somApplyDataSet"
							onsubmit="return false" class="L5form">
						<table width="100%">
							<tr>
								<td class="FieldLabel" style="width: 17%">承办人意见：</td>
								<td class="FieldInput" style="width: 17%"><label
									field="acceptOpinionId" name='"承办人意见"' style="width: 90%"
									dataset="hisOpinionDataSet" default="0" /></td>
								<td class="FieldLabel" style="width: 17%">承办人：</td>
								<td class="FieldInput" style="width: 17%"><label
									type="text" field="acceptPeopleName" name='承办人'
									style="width: 90%" /></td>
								<td class="FieldLabel" style="width: 17%">承办时间：</td>
								<td class="FieldInput" style="width: 17%"><label
									type="text" name='承办时间' field="acceptTime" style="width: 90%" /></td>
							</tr>
							<tr>
								<td class="FieldLabel">承办补充意见：</td>
								<td class="FieldInput" colspan="5"><textarea rows="3"
									name='承办补充意见' field="acceptOpinion"
									style="width: 98%; background-color: #F5FAFA; border: 0;overflow:auto;"
									readonly></textarea></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width: 17%">现场勘查意见：</td>
								<td class="FieldInput" style="width: 17%"><label
									type="text" field="prospectOpinionId" name='"现场勘查意见"'
									style="width: 90%" dataset="hisOpinionDataSet" /></td>
								<td class="FieldLabel" style="width: 17%">现场勘查承办人：</td>
								<td class="FieldInput" style="width: 17%"><label
									type="text" field="prospectPeopleName" name='现场勘查承办人'
									style="width: 90%" /></td>
								<td class="FieldLabel" style="width: 17%">现场勘查日期：</td>
								<td class="FieldInput" style="width: 17%"><label
									type="text" name='现场勘查日期' field="prospectDate"
									style="width: 90%" /></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width: 17%">现场勘查双方参加人员：</td>
								<td class="FieldInput" colspan="5"><label type="text"
									field="prospectAttendPeople" name='"现场勘查双方参加人员"'
									style="width: 90%" /></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width: 17%">现场勘查地点：</td>
								<td class="FieldInput" colspan="5"><label type="text"
									field="prospectPlace" name='现场勘查地点' style="width: 90%" /></td>
							</tr>
							<tr>
								<td class="FieldLabel">现场勘查补充意见：</td>
								<td class="FieldInput" colspan="5"><textarea rows="3"
									name='现场勘查补充意见' field="prospectOpinion"
									style="width: 98%; background-color: #F5FAFA; border: 0;overflow:auto;"
									readonly></textarea></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width: 17%">初审意见：</td>
								<td class="FieldInput" style="width: 17%"><label
									field="examinOpinionId" name='"初审意见"' style="width: 90%"
									dataset="hisOpinionDataSet" /></td>
								<td class="FieldLabel" style="width: 17%">初审负责人：</td>
								<td class="FieldInput" style="width: 17%"><label
									type="text" field="examinPeopleName" name='初审负责人'
									style="width: 90%" /></td>
								<td class="FieldLabel" style="width: 17%">初审时间：</td>
								<td class="FieldInput" style="width: 17%"><label
									type="text" name='初审时间' field="examinTime" style="width: 90%" /></td>
							</tr>
							<tr>
								<td class="FieldLabel">初审补充意见：</td>
								<td class="FieldInput" colspan="5"><textarea rows="3"
									name='初审补充意见' field="examinOpinion"
									style="width: 98%; background-color: #F5FAFA; border: 0;overflow:auto;"
									readonly></textarea></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width: 17%">审核意见：</td>
								<td class="FieldInput" style="width: 17%"><label
									field="checkOpinionId" name='"审核意见"' style="width: 90%"
									dataset="hisOpinionDataSet" /></td>
								<td class="FieldLabel" style="width: 17%">审核人：</td>
								<td class="FieldInput" style="width: 17%"><label
									type="text" field="checkPeopleName" name='审核人'
									style="width: 90%" /></td>
								<td class="FieldLabel" style="width: 17%">审核时间：</td>
								<td class="FieldInput" style="width: 17%"><label
									type="text" name='审核时间' field="checkTime" style="width: 90%" /></td>
							</tr>
							<tr>
								<td class="FieldLabel">审核补充意见：</td>
								<td class="FieldInput" colspan="5"><textarea rows="3"
									name='审核补充意见' field="checkOpinion"
									style="width: 98%; background-color: #F5FAFA; border: 0;overflow:auto;"
									readonly></textarea></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width: 17%">批准意见：</td>
								<td class="FieldInput" style="width: 17%"><label
									field="auditOpinionId" name='"批准意见"' style="width: 90%"
									dataset="hisOpinionDataSet" /></td>
								<td class="FieldLabel" style="width: 17%">批准人：</td>
								<td class="FieldInput" style="width: 17%"><label
									type="text" field="auditPeopleName" name='批准人'
									style="width: 90%" /></td>
								<td class="FieldLabel" style="width: 17%">批准时间：</td>
								<td class="FieldInput" style="width: 17%"><label
									type="text" name='批准时间' field="auditTime" style="width: 90%" /></td>
							</tr>
							<tr>
								<td class="FieldLabel">批准补充意见：</td>
								<td class="FieldInput" colspan="5"><textarea rows="3"
									name='批准补充意见' field="auditOpinion"
									style="width: 98%; background-color: #F5FAFA; border: 0;overflow:auto;"
									readonly></textarea></td>
							</tr>
						</table>
						</form>
						</fieldset>
					</next:Html>
				</next:Panel>
			</next:Panel>
			<next:Panel title="基金会理事、监事备案表"width='100%' autoScroll="true">
				<next:Panel>
					<next:Html>
						<fieldset><legend>基金会信息</legend>
						<form onsubmit="return false" class="L5form"
							dataset="somSessionDataSet">
						<table width="100%">
							<tr>
								<td class="FieldLabel">届次名称：</td>
								<td class="FieldInput" colspan="3"><label field="sessionName"/></td>
								<td class="FieldLabel" style="width: 17%">本届任期（年）：</td>
								<td class="FieldInput" style="width: 17%"><label field="tenure"/></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width: 17%">本届开始日期：</td>
								<td class="FieldInput" style="width: 17%"><label field="startDate"/></td>
								<td class="FieldLabel" style="width: 17%">规定换届日期：</td>
								<td class="FieldInput" style="width: 15%"><label field="endDate"/></td>
								<td class="FieldLabel" style="width: 17%"></td>
								<td class="FieldInput" style="width: 17%"></td>
							</tr>
						</table>
						</form>
						</fieldset>
					</next:Html>
				</next:Panel>
				<next:Panel height="300" >
					<next:EditGridPanel id="peopleGrid" dataset="aspForLiShi"
						stripeRows="true" height="99.9%" hasSum="true"
						title="理事备案表">
						<next:TopBar>
							<next:ToolBarItem symbol="->"></next:ToolBarItem>
							<next:ToolBarItem iconCls="edit" text="查看" handler="detailL"></next:ToolBarItem>
						</next:TopBar>
						<next:Columns>
							<next:RowNumberColumn />
							<next:RadioBoxColumn></next:RadioBoxColumn>
							<next:Column header="身份证号" field="idCard" width="20%"
								editable="false" summaryType="count">
								<next:ExtendConfig>
									summaryRenderer : countRender
								</next:ExtendConfig>
								<next:TextField />
							</next:Column>
							<next:Column header="姓名" field="name" width="10%"
								editable="false">
								<next:TextField />
							</next:Column>
							<next:Column header="性别" field="sex" width="10%" editable="false">
								<next:ComboBox dataset="sexSelect" />
							</next:Column>
							<next:Column header="出生年月" field="birthday" width="10%"
								editable="false">
								<next:TextField />
							</next:Column>
							<next:Column header="担任职务" field="sorgDuties" width="10%"
								editable="false">
								<next:ComboBox dataset="sorgDutiesSelect" />
							</next:Column>
							<next:Column header="是否在任" field="ifServe" width="10%"
								editable="false">
								<next:TextField />
								<next:ComboBox dataset="ifServeSelect" />
							</next:Column>
							<next:Column header="任职开始日期" field="startDate" width="15%"
								editable="false">
								<next:TextField />
							</next:Column>
							<next:Column header="任职结束日期" field="endDate" width="15%"
								editable="false">
								<next:TextField />
							</next:Column>
						</next:Columns>
						<next:BottomBar>
							<next:PagingToolBar dataset="aspForLiShi"/>
						</next:BottomBar>
					</next:EditGridPanel>
				</next:Panel>
				<next:Panel height="250" >
					<next:EditGridPanel id="peopleGrid1" dataset="aspForJianShi"
						 stripeRows="true" hasSum="true" height="99.9%"
						title="监事备案表">
						<next:TopBar>
							<next:ToolBarItem symbol="->"></next:ToolBarItem>
							<next:ToolBarItem iconCls="edit" text="查看" handler="detailS"></next:ToolBarItem>
						</next:TopBar>
						<next:Columns>
							<next:RowNumberColumn />
							<next:RadioBoxColumn></next:RadioBoxColumn>
							<next:Column header="身份证号" field="idCard" width="20%"
								editable="false" summaryType="count">
								<next:ExtendConfig>
									summaryRenderer : countRenderS
								</next:ExtendConfig>
								<next:TextField />
							</next:Column>
							<next:Column header="姓名" field="name" width="10%"
								editable="false">
								<next:TextField />
							</next:Column>
							<next:Column header="性别" field="sex" width="10%" editable="false">
								<next:ComboBox dataset="sexSelect" />
							</next:Column>
							<next:Column header="出生年月" field="birthday" width="10%"
								editable="false">
								<next:TextField />
							</next:Column>
							<next:Column header="担任职务" field="sorgDuties" width="10%"
								editable="false">
								<next:ComboBox dataset="sorgDutiesSelect" />
							</next:Column>
							<next:Column header="是否在任" field="ifServe" width="10%"
								editable="false">
								<next:TextField />
								<next:ComboBox dataset="ifServeSelect" />
							</next:Column>
							<next:Column header="任职开始日期" field="startDate" width="15%"
								editable="false">
								<next:TextField />
							</next:Column>
							<next:Column header="任职结束日期" field="endDate" width="15%"
								editable="false">
								<next:TextField />
							</next:Column>
						</next:Columns>
						<next:BottomBar>
							<next:PagingToolBar dataset="aspForJianShi"/>
						</next:BottomBar>
					</next:EditGridPanel>
				</next:Panel>
			</next:Panel>
			<next:Panel title="法定代表人登记表">
				<next:TabPanel  width="100%" height="100%">
					<next:Tabs>
						<next:Panel  title="基本信息"  width="100%" height="100%" autoScroll="true">
							<next:Html>
								<form method="post" dataset="LegalPeopleDataSet"
									onsubmit="return false" class="L5form">
								<table width="100%">
									<tr>
										<td class="FieldLabel" style="width: 15%">身份证号码：</td>
										<td class="FieldInput" style="width: 21%"><label
											id="labelIdCard" field="idCard" /></td>
										<td class="FieldLabel" style="width: 14%">姓名：</td>
										<td class="FieldInput" style="width: 17%"><label
											field="name" /></td>
										<td class="FieldLabel" style="width: 14%" rowspan="4">照片:</td>
										<td class="FieldInput" style="width: 19%" nowrap colspan="1" rowspan="4">
										<div id="photoDiv"><img id="img"
											name="RELATIONER_PHOTOC_IMG" width=82.5 height=110
											src="<%=SkinUtils.getRootUrl(request) %>jsp/cams/sorg/comm/signet/default.jpg"
											align="top"
											ondblclick="editPhoto(1,'photoId','RELATIONER_PHOTOC_IMG');"
											onerror="javascript:this.src='<%=SkinUtils.getRootUrl(request) %>jsp/cams/sorg/comm/signet/default.jpg'"
											alt="暂无图片" /> <input type="hidden" id="photoId" name="photoId" />
										</div>
										</td>
									</tr>
									<tr>
										<td class="FieldLabel">曾用名：</td>
										<td class="FieldInput"><label field="aliasName" /></td>
										<td class="FieldLabel">年龄：</td>
										<td class="FieldInput"><label id="labelAge" name='年龄' /></td>
									</tr>
									<tr>
										<td class="FieldLabel">性别：</td>
										<td class="FieldInput"><label field="sex"
											dataset="sexSelect" /></td>
										<td class="FieldLabel">出生年月：</td>
										<td class="FieldInput"><label field="birthday" /></td>
									</tr>
									<tr>
										<td class="FieldLabel">政治面貌：</td>
										<td class="FieldInput"><label field="politics"
											dataset="politicsSelect" /></td>
										<td class="FieldLabel">民族：</td>
										<td class="FieldInput"><label field="folk"
											dataset="folkSelect" /></td>
									</tr>
									<tr>
										<td class="FieldLabel">家庭住址：</td>
										<td class="FieldInput" colspan="3"><label field="adds" /></td>
										<td class="FieldLabel">户口所在地：</td>
										<td class="FieldInput"><label field="populace" /></td>
									</tr>
									<tr>
										<td class="FieldLabel">邮编：</td>
										<td class="FieldInput"><label field="postCode" /></td>
										<td class="FieldLabel">电话：</td>
										<td class="FieldInput"><label field="phone" /></td>
										<td class="FieldLabel">专/兼职：</td>
										<td class="FieldInput"><label field="ifFulltime"
											dataset="ifFulltimeSelect" /></td>
									</tr>
									<tr>
										<td class="FieldLabel">工作单位：</td>
										<td class="FieldInput" colspan="3"><label field="workName" /></td>
										<td class="FieldLabel">工作单位职务：</td>
										<td class="FieldInput"><label field="workDuties" /></td>
									</tr>
									<tr>
										<td class="FieldLabel">基金会职务：</td>
										<td class="FieldInput"><label field="sorgDuties"
											dataset="sorgDutiesDataSet" /></td>
										<td class="FieldLabel">任职开始日期：</td>
										<td class="FieldInput"><label field="startDate" /></td>
										<td class="FieldLabel"><label>任职结束日期：</label></td>
										<td class="FieldInput"></td>
									</tr>
									<tr>
										<td class="FieldLabel">是否党政机关领导干部：</td>
										<td class="FieldInput"><label field="ifPartyLeader"
											name='是否党政机关领导干部' dataset="comm_yesorno" /></td>
										<td class="FieldLabel">批准机关：</td>
										<td class="FieldInput"><label field="promiseOrgan" /></td>
										<td class="FieldLabel">批准文号：</td>
										<td class="FieldInput"><label field="promiseCode" /></td>
									</tr>
									<tr>
										<td class="FieldLabel">其他社会职务：</td>
										<td class="FieldInput" colspan="5"><textarea rows="3"
											field="otherDuties" name='"其他社会职务"'
											style="width: 98%; background-color: #F5FAFA; border: 0;overflow:auto;"
											readonly></textarea></td>
									</tr>
									<tr>
										<td class="FieldLabel">本人所在单位人事部门审查意见：</td>
										<td class="FieldInput" colspan="5"><textarea rows="2"
											name='"所在单位人事部门审查意见"' field="workOpinion"
											style="width: 98%; background-color: #F5FAFA; border: 0;overflow:auto;"
											readonly></textarea></td>
									</tr>
									<tr>
										<td class="FieldLabel">审查工作单位：</td>
										<td class="FieldInput" colspan="3"><label field="workName" /></td>
										<td class="FieldLabel">审查日期：</td>
										<td class="FieldInput"><label field="workCheckDate" /></td>
									</tr>
									<tr>
										<td class="FieldLabel"><label>按照本基金会章程会议产生通过情况：</label></td>
										<td class="FieldInput" colspan="5"><textarea rows="2"
											name='"按照本基金会章程会议产生通过情况"' field="sorgOpinion"
											style="width: 98%; background-color: #F5FAFA; border: 0;overflow:auto;" readonly="readonly"></textarea>
											</td>
									</tr>
									<tr>
										<td class="FieldLabel"><label>签署日期：</label></td>
										<td class="FieldInput" colspan="5"><label field="sorgCheckDate" /></td>
									</tr>
									<tr>
										<td class="FieldLabel">备注：</td>
										<td class="FieldInput" colspan="5"><textarea rows="2"
											name='"备注"' field="note"
											style="width: 98%; background-color: #F5FAFA; border: 0;overflow:auto;"
											readonly></textarea></td>
									</tr>
								</table>
								</form>
							</next:Html>
						</next:Panel>
				<next:EditGridPanel id="somResumeLegalGrid" dataset="somResumeLegalDataSet" stripeRows="true" title="本人简历" width="100%" height="100%" autoScroll="true">
					<next:TopBar>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn />
						<next:Column header="内码" field="id" width="15%" editable="true"
							hidden="true">
							<next:TextField />
						</next:Column>
						<next:Column header="开始年月" field="startDate" width="10%"
							editable="false">
							<next:TextField />
						</next:Column>
						<next:Column header="结束年月" field="endDate" width="10%"
							editable="false">
							<next:TextField />
						</next:Column>
						<next:Column header="在何地区何单位" field="workOrgan" width="45%"
							editable="false">
							<next:TextField />
						</next:Column>
						<next:Column header="任（兼）何职" field="duty" width="20%"
							editable="false">
							<next:TextField />
						</next:Column>
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
			<next:Panel title="章程核准表" width="100%" autoScroll="true">
				<next:Html>
					<fieldset><legend>章程核准表</legend>
					<form id="ruleForm" method="post" onsubmit="return false"
						class="L5form" dataset="somRuleDataSet">
					 <input type="hidden"
						id="sorgId" field="sorgId" value="社团ID">
					<table width="100%">

						<tr>
							<td class="FieldLabel">会议名称：</td>
							<td class="FieldInput"><label field="meetingName"/></td>
							<td class="FieldLabel">表决形式：</td>
							<td class="FieldInput" colspan="3"><label field="meetingFormat"/></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 17%">时间：</td>
							<td class="FieldInput" style="width: 17%"><label field="meetingDate"/></td>
							<td class="FieldLabel" style="width: 17%">应到人数：</td>
							<td class="FieldInput" style="width: 15%"><label field="shouldNum"/></td>
							<td class="FieldLabel" style="width: 17%">实到人数：</td>
							<td class="FieldInput" style="width: 17%"><label field="realNum"/></td>
						</tr>
						<tr>
							<td class="FieldLabel">赞同人数：</td>
							<td class="FieldInput"><label field="passNum"/></td>
							<td class="FieldLabel">反对人数：</td>
							<td class="FieldInput"><label field="nopassNum"/></td>
							<td class="FieldLabel">弃权人数：</td>
							<td class="FieldInput"><label field="giveupNum"/></td>
						</tr>
						<tr>
							<td class="FieldLabel">修改说明：</td>
							<td class="FieldInput" colspan="5"><textarea name="需说明的主要问题"
								id=mainQuestion field="mainQuestion" cols="65" rows="4"
								style="width: 98%; background-color: #F5FAFA; border: 0;overflow:auto;" readonly="readonly"></textarea></td>
						</tr>
					</table>
					</form>
					</fieldset>
					
				</next:Html>
			</next:Panel>

			<next:Panel title="法律要件">
				<next:EditGridPanel id="uploadGrid" width="100%" stripeRows="true"
					height="100%" dataset="somElectronicDataSet">
					<next:GroupingView forceFit="true"></next:GroupingView>
					<next:TopBar>
						<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
					</next:TopBar>

					<next:Columns>
						<next:RowNumberColumn />
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="档案目录名" field="catalogCode" width="38%"
							editable="false" dataset="cataLogCodeSelect">
							<next:TextField />
						</next:Column>
						<next:Column header="附件名称" field="fileName" width="30%"
							editable="false">
							<next:TextField />
						</next:Column>
						<next:Column header="附件描述" field="fileMess" width="20%"
							editable="false">
							<next:TextField />
						</next:Column>
						<next:Column header="下载附件" field="" width="10%" editable="false"
							renderer="clickDownloadHref">
							<next:TextField />
						<next:Column header="业务类型"    field="applyType" hidden="true">
							<next:ExtendConfig>
								groupRenderer:grender,groupName:"法律要件目录"
							</next:ExtendConfig>
						</next:Column>
						</next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="somElectronicDataSet" />
					</next:BottomBar>
				</next:EditGridPanel>
			</next:Panel>

			<next:Panel title="流程历史意见">
				<next:EditGridPanel id="somFlowGrid" dataset="somFlowDataSet"
					width="100%" stripeRows="true" height="100%">
					<next:Columns>
						<next:RowNumberColumn />
						<next:Column header="处理环节" field="activity" width="13%"
							editable="false">
							<next:TextField />
						</next:Column>
						<next:Column header="处理单位" field="organId" width="13%"
							editable="false">
							<next:ComboBox dataset="pubOrganDataSet" />
						</next:Column>
						<next:Column header="处理部门" field="deptId" width="13%"
							editable="false">
							<next:ComboBox dataset="pubOrganDataSet" />
						</next:Column>
						<next:Column header="处理人" field="actorId" width="10%"
							editable="false">
							<next:ComboBox dataset="pubOrganDataSet" />
						</next:Column>
						<next:Column header="处理时间" field="commitTime" width="18%"
							editable="false">
							<next:TextField />
						</next:Column>
						<next:Column header="意见" field="opinionId" width="10%"
							editable="false">
							<next:ComboBox dataset="hisOpinionDataSet" />
						</next:Column>
						<next:Column header="补充意见" field="opinion" width="40%"
							editable="false">
							<next:TextField />
						</next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="somFlowDataSet" />
					</next:BottomBar>
				</next:EditGridPanel>
			</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>
<jsp:include page="../../../comm/upload/uploadWindow.jsp" flush="true"/>
<jsp:include page="../../../comm/people/fundPeopleDetail.jsp" flush="true"/>
</body>
</html>