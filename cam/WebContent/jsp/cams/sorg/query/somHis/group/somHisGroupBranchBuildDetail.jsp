<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>社会团体分支申请成立登记明细查看</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js")%>'></script>
<script>
var taskCode = '<%=request.getParameter("taskCode")%>';
var applyType = "005";
var sorgId='';
var fileCode="S059";
var fileCode = "S059";
function init() {
	L5.getCmp("tab").setActiveTab("0");
	var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
	somApplyDataSet.setParameter("TASK_CODE", taskCode);
	somApplyDataSet.load();
	somApplyDataSet.on('load', loadInfo);
	//社团职务过滤
	sorgDutiesSelect.filterBy(function(record, id){
		if("00002".indexOf(record.get('value'))>-1){
			return record;
		}
	});
	
	//负责人window关闭时把数据清空
	if(L5.getCmp("peopleWin")){
		L5.getCmp("peopleWin").on("beforehide",function(){
			updateRecord="";
		});
	}
	//电子档案上传窗口关闭事件
	uploadListCloseEvent();
	uploadPeopleListCloseEvent();
}
function loadInfo(){
	var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
	sorgId = somApplyDataSet.get('sorgId');
	var record = somApplyDataSet.getCurrent();
	var somOrganDataSet=L5.DatasetMgr.lookup("somOrganDataSet");
	somOrganDataSet.setParameter("SORG_ID@=", sorgId);
	somOrganDataSet.load();
	somOrganDataSet.on("load",function(ds){		
		$("mainSorgId").value = ds.get("mainSorgId");
		$("name").innerHTML = ds.get("name");
	});
	somSessionDataSet.setParameter("TASK_CODE@=", taskCode);
	somSessionDataSet.load();
	
	var somResumeDataSet=L5.DatasetMgr.lookup("somResumeDataSet");
	somResumeDataSet.setParameter("TASK_CODE", taskCode);
	somResumeDataSet.load();
	somResumeDataSet.on('load',function(){
		somDutyDataSet.setParameter("TASK_CODE", taskCode);
		somDutyDataSet.load();
		somDutyDataSet.on('load',function(){
			if(somDutyDataSet.getCount() > 0){
				isOnly = false;
			}
		});
	});
	
	somFlowDataSet.setParameter("TASK_CODE@=", taskCode);
	somFlowDataSet.load();
	somElectronicDataSet_load();
}
//返回
function back(){
	history.go(-1);
}

//查看负责人
function detailPeople(){
	var grid = L5.getCmp("peopleGrid");
	var sm = grid.getSelectionModel();
	var record = sm.getSelected();
	if(!record){
		L5.Msg.alert("提示","请选择一条记录!");
		return;
	}
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
	if(typeof somPeopleElectronicDataSet != 'undefined'){
		somPeopleElectronicDataSet_load(fileCode,record.get('dutyId'));//同步人员法律要件
	}
	
	var win = L5.getCmp("peopleWin");
	win.show();
	L5.getCmp("peoplePanel1").setActiveTab("2");
	L5.getCmp("peoplePanel1").setActiveTab("1");
	L5.getCmp("peoplePanel1").setActiveTab("0");
	$("peopleAge").innerHTML = getAgeByCode(record.get("idCard"));
}

function valid_ifPartyLeader_win(){
	if(_$("ifPartyLeader_win") == "1"){
		$("promiseCode_win").style.display = "block";
		$("promiseOrgan_win").style.display = "block";
	}else{
		$("promiseCode_win").value = "";
		$("promiseOrgan_win").value = "";
		$("promiseCode_win").style.display = "none";
		$("promiseOrgan_win").style.display = "none";
	}
}

//------------------负责人处理------------------------------
var dutyId='';
var isOnly = true;//判断是否已经添加了负责人
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
//负责人窗户关闭
function winClosePeople(){
	var win = L5.getCmp("peopleWin");
	win.hide();
}
function closePeopleWIn(){
	var win = L5.getCmp("peopleWin");
	win.hide();
}
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="somApplyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomApplyQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomApply"></model:record>
	</model:dataset>
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" global="true" method="queryBranch">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan"></model:record>
	</model:dataset>
	<model:dataset id="somFlowDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomFlowQueryCmd" global="true" sortField="COMMIT_TIME" pageSize="100">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomFlow"></model:record>
	</model:dataset>
	<model:dataset id="somFlowQuery" cmd="com.inspur.cams.sorg.base.cmd.SomFlowQueryCmd" >
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomFlow"></model:record>
	</model:dataset>
	<model:dataset id="borgDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_BUSINESS_ORGAN'></model:param>
			<model:param name="value" value='BORG_CODE'></model:param>
			<model:param name="text" value='BORG_NAME'></model:param>
			<model:param name="filterSql" value='<%="MORG_CODE ="+BspUtil.getOrganCode().substring(0,6)%>'></model:param>

		</model:params>
	</model:dataset>
	<model:dataset id="cataLogCodeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_CATALOG'></model:param>
			<model:param name="value" value='CATALOG_CODE'></model:param>
			<model:param name="text" value='CATALOG_NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="pubOrganDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='PUB_ORGAN'></model:param>
			<model:param name="value" value='ORGAN_ID'></model:param>
			<model:param name="text" value='ORGAN_NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="sorgKindSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_FUND_BRANCH_KIND'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="businessOrganSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_BUSINESS_ORGAN'></model:param>
			<model:param name="value" value='BORG_CODE'></model:param>
			<model:param name="text" value='BORG_NAME'></model:param>
			<model:param name="filterSql" value='<%="MORG_CODE ="+BspUtil.getOrganCode().substring(0,6)%>'></model:param>

		</model:params>
	</model:dataset>
	<model:dataset id="busScopeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BUS_SCOPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 届次信息 -->
	<model:dataset id="somSessionDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomSessionQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomSession">
		</model:record>
	</model:dataset>
	<!-- 负责人信息 -->
	<model:dataset id="somDutyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true"  method="queryPeople">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<%--电子档案--%>
	<model:dataset id="somElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true" method="queryCatalog">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--下载窗口--%>
	<model:dataset id="downloadDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" method="queryElectronic">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--人员电子档案--%>
	<model:dataset id="somPeopleElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true" method="queryPeopleCatalog">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<!-- 负责人详情窗口 -->
	<model:dataset id="somDutyInsertDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true"  method="queryPeople">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<%--人员简历 --%>
	<model:dataset id="somResumeDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomPeopleResumeQueryCommand" sortField="startDate" sortDirection="DESC">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeopleResume"></model:record>
	</model:dataset>	
	<%--人员简历 --%>
	<model:dataset id="somResumeInsertDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomPeopleResumeQueryCommand">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeopleResume"></model:record>
	</model:dataset>
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="sexSelect" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="opinionDataSet" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="hisOpinionDataSet" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>	
	<model:dataset id="politicsSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_POLITICAL'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="resideSourceSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_RESIDE_SOURCE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="busScopeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BUS_SCOPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="sorgDutiesSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_DUTY'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="ifFulltimeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_IF_FULLTIME'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="folkSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="businessOrganSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_BUSINESS_ORGAN'></model:param>
			<model:param name="value" value='BORG_CODE'></model:param>
			<model:param name="text" value='BORG_NAME'></model:param>
			<model:param name="filterSql" value='<%="MORG_CODE ="+BspUtil.getOrganCode().substring(0,6)%>'></model:param>

		</model:params>
	</model:dataset>	
	<model:dataset id="certTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CERT_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="cardTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CARD_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 状态 -->
	<model:dataset id="ifServeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_DUTY_IF_SERVE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>
<%--定义界面--%>
<next:ViewPort>
<next:Panel width="100%" height="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>	
		<next:ToolBarItem  iconCls="return" text="返回" handler="back" ></next:ToolBarItem>			
	</next:TopBar>
	<next:TabPanel id="tab" width="100%" height="100%" activeTab="0">
		<next:Tabs>
			<next:Panel title="社团分支/代表机构明细查看" width="100%" autoScroll="true">
				<next:Html>
				<fieldset>
				<legend>社团分支/代表机构明细信息</legend>
					<form method="post" dataset="somOrganDataSet" onsubmit="return false"class="L5form">
						<table width="100%">
							<tr>
								<td class="FieldLabel"><label>社会团体登记证号：</label></td>
								<td class="FieldInput" colspan="5"><label  field="mainSorgCode" style="width:98%"/></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>社会团体名称：</label></td>
								<td class="FieldInput" colspan="5"><label id="name" style="width:98%"></label></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>分支/代表机构名称：</label></td>
								<td class="FieldInput" colspan="5"><label field="cnName" style="width:98%"/></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>办公场所：</label></td>
								<td class="FieldInput" colspan="5"><label field="residence" style="width:98%"/></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width:17%"><label>分支/代表机构电话：</label></td>
								<td class="FieldInput" style="width:17%"><label field="sorgPhone" style="width:90%"/></td>
								<td class="FieldLabel" style="width:17%"><label>分支/代表机构邮编：</label></td>
								<td class="FieldInput" style="width:17%"><label field="sorgPost" style="width:90%"/></td>
								<td class="FieldLabel" style="width:17%"><label>分支/代表机构类型：</label></td>
								<td class="FieldInput" style="width:17%"><label field="sorgKind" dataset="sorgKindSelect" style="width:90%"/></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>业务范围：</label></td>
								<td class="FieldInput" colspan="5"><textarea rows="10" field="business" style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" readonly="readonly"></textarea></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>设立理由：</label></td>
								<td class="FieldInput" colspan="5"><textarea rows="5" field="appReason" style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" readonly="readonly"></textarea></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>业务主管单位：</label></td>
								<td class="FieldInput" colspan="3"><label field="borgName" style="width:97%" dataset="businessOrganSelect"/></td>
								<td class="FieldLabel"><label>成立日期：</label></td>
								<td class="FieldInput"><label field="buildDate" format="Y-m-d" style="width:90%"/></td>
							</tr>
						</table>
						<div id="mainSorgId" title="隐藏：主体ID" style="display:none"></div>
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
								<label type="text"  field="prospectOpinionId" name='"现场勘查意见"' style="width:90%" dataset="hisOpinionDataSet"  />
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
								<label field="examinOpinionId" name='"初审意见"' style="width:90%" dataset="hisOpinionDataSet" default="0" />
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
								<label field="checkOpinionId" name='"审核意见"' style="width:90%" dataset="hisOpinionDataSet" default="0" />
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
								<label field="auditOpinionId" name='"批准意见"' style="width:90%" dataset="hisOpinionDataSet" default="0" />
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
			<next:Panel title="社团负责人备案表">
					<next:Panel>
					<next:Html>
					<fieldset>
						<legend>社会团体信息</legend>
						<form onsubmit="return false" dataset="somSessionDataSet" class="L5form">
							<table width="100%">
								<tr>
									<td class="FieldLabel">届次名称：</td>
									<td class="FieldInput" colspan="3"><label field="sessionName" style="width:90%"/></td>
									<td class="FieldLabel" style="width:17%">本届任期（年）：</td>
									<td class="FieldInput" style="width:17%"><label field="tenure" style="width:90%"/></td>
								</tr>
								<tr>
									<td class="FieldLabel" style="width:17%">本届开始日期：</td>
									<td class="FieldInput" style="width:17%"><label field="startDate" style="width:90%"/></td>
									<td class="FieldLabel" style="width:17%">规定换届日期：</td>
									<td class="FieldInput" style="width:15%"><label field="endDate" style="width:90%"/></td>
									<td class="FieldLabel" style="width:17%"></td>
									<td class="FieldInput" style="width:17%"></td>
								</tr>
							</table>
						</form>
						</fieldset>
					</next:Html>
				</next:Panel>
					<next:EditGridPanel id="peopleGrid" width="100%" stripeRows="true" height="100%" dataset="somDutyDataSet">
						<next:TopBar>
							<next:ToolBarItem symbol="->"></next:ToolBarItem>
							<next:ToolBarItem iconCls="detail" text="查看" handler="detailPeople"></next:ToolBarItem>
						</next:TopBar>
						<next:Columns>
							<next:RowNumberColumn />
							<next:RadioBoxColumn></next:RadioBoxColumn>
							<next:Column header="内码" field="id" width="15%" editable="false" hidden="true"><next:TextField/></next:Column>
							<next:Column header="身份证号" field="idCard" width="20%" editable="false"><next:TextField/></next:Column>
							<next:Column header="姓名" field="name" width="10%" editable="false"><next:TextField/></next:Column>
							<next:Column header="性别" field="sex" width="10%" editable="false"><next:ComboBox dataset="sexSelect"/></next:Column>
							<next:Column header="出生年月" field="birthday" width="10%" editable="false"><next:TextField/></next:Column>
							<next:Column header="担任职务" field="sorgDuties" width="20%" editable="false"><next:ComboBox dataset="sorgDutiesSelect"/></next:Column>
							<next:Column header="是否在任" field="ifServe"width="10%" editable="false"><next:TextField/><next:ComboBox dataset="ifServeSelect"/></next:Column>
							<next:Column header="任职开始日期" field="startDate" width="15%" editable="false"><next:TextField/></next:Column>
							<next:Column header="任职结束日期" field="endDate" width="15%" editable="false"><next:TextField/></next:Column>
						</next:Columns>
						<next:BottomBar>
							<next:PagingToolBar dataset="somDutyDataSet"/>
						</next:BottomBar>
					</next:EditGridPanel>
			</next:Panel>
			
			<next:Panel title="法律要件">
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
			
			<next:Panel title="流程历史意见">
				<next:EditGridPanel id="somFlowGrid" dataset="somFlowDataSet" width="100%" stripeRows="true" height="100%">
					<next:Columns>
						<next:RowNumberColumn/>
						<next:Column header="处理环节" field="activity" width="13%" editable="false"><next:TextField/></next:Column>
						<next:Column header="处理单位" field="organId" width="13%" editable="false"><next:ComboBox dataset="pubOrganDataSet"/></next:Column>
						<next:Column header="处理部门" field="deptId" width="13%" editable="false"><next:ComboBox dataset="pubOrganDataSet"/></next:Column>
						<next:Column header="处理人" field="actorId" width="10%" editable="false"><next:ComboBox dataset="pubOrganDataSet"/></next:Column>
						<next:Column header="处理时间" field="commitTime" width="18%" editable="false"><next:TextField/></next:Column>
						<next:Column header="意见" field="opinionId" width="10%" editable="false"><next:ComboBox dataset="hisOpinionDataSet"/></next:Column>
						<next:Column header="补充意见" field="opinion" width="40%" editable="false"><next:TextField/></next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="somFlowDataSet"/>
					</next:BottomBar>
				</next:EditGridPanel>
			</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>
</next:ViewPort>
<jsp:include page="../../../comm/upload/uploadWindow.jsp" flush="true"/>
<jsp:include page="../../../comm/people/groupPeopleDetail.jsp" flush="true"/>
</body>
</html>