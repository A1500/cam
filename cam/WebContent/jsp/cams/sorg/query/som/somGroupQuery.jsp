<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
<!-- 社会团体详细信息 -->
<head>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="somGroupQuery.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js")%>'></script>
<script type="text/javascript">var rootPath='<%=SkinUtils.getRootUrl(request)%>';</script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/somPhoto.js") %>'></script>
<script type="text/javascript" src="<%=SkinUtils.getRootUrl(request)%>skins/js/ISEditPhoto.js"></script>
<script type="text/javascript">
var sorgId='<%=request.getParameter("sorgId")%>';
var fileCode = "S074";
var dutyId='';
var initLegalRecord="";//法定代表人的record
var taskCode="";

	function init(){
		var somOrganDataSet=L5.DatasetMgr.lookup("somOrganDataSet");
		somOrganDataSet.setParameter("SORG_ID@=",sorgId);
		somOrganDataSet.load();
		somOrganDataSet.on("load",function(ds){
			if(ds.getCount()<1){
				ds.newRecord();
			}else{
				var rec=ds.getAt(0);
				var borgName = rec.get('borgName');
				var nowBorgName = getBorgName(borgName);
				rec.set('nowBorgName', nowBorgName);
			}
		});
		
		var somSessionDataSet=L5.DatasetMgr.lookup("somSessionDataSet");
		somSessionDataSet.setParameter("SORG_ID@=",sorgId);
		somSessionDataSet.load();
		L5.getCmp("sessionGrid").on("rowclick",function(grid,rowIndex,e){
			var record=grid.getSelectionModel().getSelected();
			if(record){
				var sessionId=record.get('sessionId');
				var somDutyInsertDataSet=L5.DatasetMgr.lookup("somDutyInsertDataSet");
				somDutyInsertDataSet.setParameter("SESSION_ID",record.get('sessionId'));
				somDutyInsertDataSet.load();
				somDutyInsertDataSet.on('load',function(){
					var peopleId='';
					somDutyInsertDataSet.each(function(record, index){
						
						if(record.get('sorgDuties') == "00012" && record.get('regStatus')=="1"){
							initLegalRecord=record;
							peopleId=record.get('peopleId');
						}
					});
					somDutyInsertDataSet.filterBy(function(record, id){
						if(record.get('sorgDuties') != "00012"){
							if(record.get('peopleId') == peopleId){
								record.set('ifLegal','1');
							}
							return record;
						}
					});
					somDutyInsertDataSet.commitChanges();
				});
			}
		});
		
		var AccountDS=L5.DatasetMgr.lookup("AccountDS");
		AccountDS.setParameter("SORG_ID@=",sorgId);
		AccountDS.load();
		var OfficeDS=L5.DatasetMgr.lookup("OfficeDS");
		OfficeDS.setParameter("SORG_ID@=",sorgId);
		OfficeDS.load();
		var FeeDS=L5.DatasetMgr.lookup("FeeDS");
		FeeDS.setParameter("SORG_ID@=",sorgId);
		FeeDS.load();
		var EntityDS=L5.DatasetMgr.lookup("EntityDS");
		EntityDS.setParameter("SORG_ID@=",sorgId);
		EntityDS.load();
		somCertDatasetF.load();
		somCertDatasetF.on('load',function(){
			if(somCertDatasetF.getCount() == 0){
				somCertDatasetF.newRecord();
			}
		});
		somCertDatasetZ.load();
		somCertDatasetZ.on('load',function(){
			if(somCertDatasetZ.getCount() == 0){
				somCertDatasetZ.newRecord();
			}
		});
	}
	
function detailPeople(){
	var grid=L5.getCmp("peopleGrid");
	var record=grid.getSelectionModel().getSelected();
	if(!record){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	//个人简历处理
	var somResumeInsertDataSet=L5.DatasetMgr.lookup("somResumeInsertDataSet");
	somResumeInsertDataSet.setParameter("DUTY_ID",record.get('dutyId'));
	somResumeInsertDataSet.load();
	somResumeInsertDataSet.on('load',function(){
		taskCode=record.get('taskCode');
		somPeopleElectronicDataSet_load(fileCode,record.get('dutyId'));//同步法律要件
		L5.getCmp("peopleWin").show();
		showAge();
		synPhotoDetail(record.get("photoId"),"1");//同步照片
	});
}
function showAge(birthday){
	var day=new Date();
	var year=day.getYear();
	var birthYear=birthday.substring(0,4);
	document.getElementById("age").innerHTML=parseInt(year)-parseInt(birthYear);
}
function detailAccount(){
	var grid=L5.getCmp("accountgrid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	
	var data=new L5.Map();
	data.put("method","detail");
	data.put("id",records[0].get("id"));
	data.put("cnName",encodeURIComponent(encodeURIComponent(somOrganDataSet.get("cnName"))));
	data.put("sorgCode",somOrganDataSet.get("sorgCode"));
	var url="jsp/cams/sorg/manage/group/groupAccountDetail.jsp";
	L5.forward(url,'',data);
}
function detailFee(){
	var grid=L5.getCmp("feegrid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var data=new L5.Map();
	data.put("method","detail");
	data.put("feeId",records[0].get("feeId"));
	data.put("cnName",encodeURIComponent(encodeURIComponent(somOrganDataSet.get("cnName"))));
	data.put("sorgCode",somOrganDataSet.get("sorgCode"));
	var url="jsp/cams/sorg/manage/group/groupFeeDetail.jsp";
	L5.forward(url,'',data);
}
function detailOffice(){
	var grid=L5.getCmp("officegrid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var data=new L5.Map();
	data.put("method","detail");
	data.put("id",records[0].get("id"));
	data.put("cnName",encodeURIComponent(encodeURIComponent(somOrganDataSet.get("cnName"))));
	data.put("sorgCode",somOrganDataSet.get("sorgCode"));
	var url="jsp/cams/sorg/manage/group/groupOfficeDetail.jsp";
	L5.forward(url,'',data);
}
function detailEntity(){
	var grid=L5.getCmp("entitygrid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var data=new L5.Map();
	data.put("method","detail");
	data.put("id",records[0].get("id"));
	data.put("cnName",encodeURIComponent(encodeURIComponent(somOrganDataSet.get("cnName"))));
	data.put("sorgCode",somOrganDataSet.get("sorgCode"));
	var url="jsp/cams/sorg/manage/group/groupEntityDetail.jsp";
	L5.forward(url,'',data);
}
function detailRule(){
	var grid=L5.getCmp("rulegrid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var data=new L5.Map();
	data.put("method","detail");
	data.put("ruleId",records[0].get("ruleId"));
	data.put("cnName",encodeURIComponent(encodeURIComponent(somOrganDataSet.get("cnName"))));
	data.put("sorgCode",somOrganDataSet.get("sorgCode"));
	var url="jsp/cams/sorg/manage/group/groupRuleDetail.jsp";
	L5.forward(url,'',data);
}
/** *查询信息* **/
function getBorgName(borgCode){
	var publicCmd = new L5.Command("com.inspur.cams.sorg.base.cmd.SomBorgChangeCmd");
	publicCmd.setParameter("borgCode", borgCode);
	publicCmd.execute("nowBorgName");
	var getReturns = publicCmd.getReturn("borgName");
	if (getReturns == null || getReturns == "" || getReturns == undefined){
		return "";
	}else {
		return getReturns;
	}
}
</script>
</head>
<body>
<!-- 定义dataset -->
<model:datasets>
	<%--基本信息--%>
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" method="queryOrgan" global="true" >
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan">
			<model:field name="nowBorgName" type="string"/>
		</model:record>
	</model:dataset>
	<model:dataset id="somSessionDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomSessionQueryCmd" sortField="seq">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomSession"></model:record>
	</model:dataset>
	<!-- 负责人信息 -->
	<model:dataset id="somDutyInsertDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true" method="queryPeople">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<%--电子档案--%>
	<model:dataset id="somElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true" autoLoad="true" method="queryArchiveCatalog" isGroup="true" groupField="taskCode" pageSize="500">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
		<model:params>
			<model:param name="sorgId" value='<%=request.getParameter("sorgId")%>'></model:param>
		</model:params>
	</model:dataset>
	<%--下载窗口--%>
	<model:dataset id="downloadDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" method="queryElectronic">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<!-- 证书正本 -->
	<model:dataset id="somCertDatasetZ" cmd="com.inspur.cams.sorg.base.cmd.SomCertQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomCert"></model:record>
		<model:params>
			<model:param name="sorg_Id" value='<%=request.getParameter("sorgId")%>'></model:param>
				<model:param name="cert_Type" value='0'></model:param>
				<model:param name="cert_status" value='1'></model:param>
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
	<!-- 证书副本 -->
	<model:dataset id="somCertDatasetF" cmd="com.inspur.cams.sorg.base.cmd.SomCertQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomCert"></model:record>
		<model:params>
			<model:param name="cert_Type" value='1'></model:param>
			<model:param name="sorg_Id" value='<%=request.getParameter("sorgId")%>'></model:param>
			<model:param name="cert_status" value='1'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="OfficeDS" cmd="com.inspur.cams.sorg.base.cmd.SomOfficeQueryCmd" autoLoad="true"  global="true" >
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOffice"></model:record>
		<model:params>
			<model:param name="sorg_Id" value='<%=request.getParameter("sorgId")%>'></model:param>
		</model:params>
	</model:dataset>
	<!-- 账户 -->
	<model:dataset id="AccountDS" cmd="com.inspur.cams.sorg.base.cmd.SomAccountQueryCmd" global="true" >
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomAccount"></model:record>
		<model:params>
			<model:param name="sorg_Id" value='<%=request.getParameter("sorgId")%>'></model:param>
		</model:params>
	</model:dataset>
	<!-- 会费备案 -->
	<model:dataset id="FeeDS" cmd="com.inspur.cams.sorg.base.cmd.SomFeeQueryCmd" method="queryFee">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomFee"/>
	</model:dataset>
	<!-- 办事机构 -->
	<model:dataset id="somRuleDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomRuleQueryCmd" method="queryRule" autoLoad="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomRule"/>
		<model:params>
			<model:param name="sorg_Id"
				value='<%=request.getParameter("sorgId")%>'></model:param>
		</model:params>
	</model:dataset>
	<!-- 举办实体 -->
	<model:dataset id="EntityDS" cmd="com.inspur.cams.sorg.base.cmd.SomEntityQueryCmd" autoLoad="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomEntity"></model:record>
		<model:params>
			<model:param name="sorg_Id" value='<%=request.getParameter("sorgId")%>'></model:param>
		</model:params>
	</model:dataset>

	<!-- 证书发证原因 -->
	<model:dataset id="issueReasonSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CERT_ISSUEREASON'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
		<%--人员电子档案--%>
	<model:dataset id="somPeopleElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true" method="queryPeopleCatalog">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<!-- 证书类别枚举 -->
	<model:dataset id="certTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CERT_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="sorgDutiesDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_DUTY'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 社会组织类别 -->
	<model:dataset id="sorgKindSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_GROUP_KIND'></model:param>
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
	<!-- 所属行（事)业 -->
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
	<!-- 是否专/兼职 -->
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
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>	
	<model:dataset id="sexSelect" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<!-- 定义界面 -->
<next:Panel width="100%" height="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="undo" text="返回" handler="returnQueryList"></next:ToolBarItem>
	</next:TopBar>
	<next:TabPanel>
		<next:Tabs>
			<next:Panel title="社会团体基本信息" width="100%" height="100%" autoScroll="true">
				<next:Html>
					<form method="post" dataset="somOrganDataSet" onsubmit="return false" class="L5form">
					<table width="100%">
						<tr>
							<td class="FieldLabel"><label>登记证号：</label></td>
							<td class="FieldInput" colspan="5"><label field="sorgCode" style="width:90%"/></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>社团名称/中文：</label></td>
							<td class="FieldInput" colspan="5"><label field="cnName" style="width:90%"/></td>
						<tr>
							<td class="FieldLabel"><label>社团名称/英文：</label></td>
							<td class="FieldInput" colspan="3"><label field="enName" style="width:97%"/></td>
							<td class="FieldLabel"><label>社团名称/缩写：</label></td>
							<td class="FieldInput"><label field="abName" style="width:90%"/></td>
						</tr>	
						<tr>
							<td class="FieldLabel"><label>组织机构代码：</label></td>
							<td class="FieldInput" colspan="3"><label field="organCode" style="width:97%"/></td>
							<td class="FieldLabel"><label>社会团体类型：</label></td>
							<td class="FieldInput"><label field="sorgKind" dataset="sorgKindSelect" style="width:90%"/></td>
						</tr>
						<tr>	
							<td class="FieldLabel"><label>住所：</label></td>
							<td class="FieldInput" colspan="5"><label field="residence" style="width:98%"/></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>住所来源：</label></td>
							<td class="FieldInput"><label  field="resideSource" dataset="resideSourceSelect"  style="width:90%"/></td>
							<td class="FieldLabel"><label>社团邮编：</label></td>
							<td class="FieldInput"><label field="sorgPost" style="width:90%"/></td>
							<td class="FieldLabel"><label>社团传真：</label></td>
							<td class="FieldInput"><label field="sorgFax" style="width:90%"/></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>租（借）期限：</label></td>
							<td class="FieldInput" colspan="5"><label field="leasePeriod" style="width:98%"/></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>社团电话：</label></td>
							<td class="FieldInput" colspan="5"><label field="sorgPhone" style="width:90%"/></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>活动地域：</label></td>
							<td class="FieldInput" colspan="5"><label field="actArea" style="width:100%" style="width:98%"/></td>
						</tr>
						<tr>	
							<td class="FieldLabel"><label>社团宗旨：</label></td>
							<td class="FieldInput" colspan="5"><textarea rows="10" field="purpose" readonly="readonly" style="width:98%"></textarea></td>
						</tr>
						<tr>	
							<td class="FieldLabel"><label>业务范围：</label></td>
							<td class="FieldInput" colspan="5"><textarea rows="10" field="business" readonly="readonly" style="width:98%"></textarea></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>业务主管单位：</label></td>
							<td class="FieldInput" colspan="3"><label field="newBorgName" style="width:97%" /></td>
							<td class="FieldLabel"><label>主管单位审查日期：</label></td>
							<td class="FieldInput"><label field="borgCheckDate" format="Y-m-d" style="width:90%"/></td>
						</tr>
						<tr>	
							<td class="FieldLabel" style="width:17%"><label>单位会员数：</label></td>
							<td class="FieldInput" style="width:17%"><label field="unitsNum" style="width:90%"/></td>
							<td class="FieldLabel" style="width:17%"><label>个人会员数：</label></td>
							<td class="FieldInput" style="width:17%"><label field="peopleNum" style="width:90%"/></td>
							<td class="FieldLabel" style="width:15%"><label>理事数：</label></td>
							<td class="FieldInput" style="width:17%"><label field="councilNum" style="width:90%"/></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>常务理事数：</label></td>
							<td class="FieldInput"><label field="standCouncilNum" style="width:90%"/></td>
							<td class="FieldLabel"><label>活动资金数额（万元）：</label></td>
							<td class="FieldInput" colspan="3"><label field="regMon" style="width:30%"/></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>出资人：</label></td>
							<td class="FieldInput" colspan="5"><textarea field="fundingPeople" style="width:98%" readonly="readonly"></textarea></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>验资单位：</label></td>
							<td class="FieldInput" colspan="5"><label field="checkCapitalOrgan" style="width:98%"></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>经费来源：</label></td>
							<td class="FieldInput" colspan="5"><textarea rows="5" field="moneySource" readonly="readonly" style="width:98%"></textarea></td>
						</tr>
						<tr>	
							<td class="FieldLabel"><label>住所产权单位：</label></td>
							<td class="FieldInput" colspan="3"><label field="housingOrgan" style="width:97%"/></td>
							<td class="FieldLabel"><label>用房面积（平方米）：</label></td>
							<td class="FieldInput"><label field="housingArea" /></td>
						</tr>
						
						<tr>
							<td class="FieldLabel"><label>登记人：</label></td>
							<td class="FieldInput"><label field="regPeople" style="width:90%"/></td>
							<td class="FieldLabel"><label>登记日期：</label></td>
							<td class="FieldInput"><label field="regDate" format="Y-m-d" style="width:90%"/></td>
							<td class="FieldLabel"><label>成立日期：</label></td>
							<td class="FieldInput"><label field="buildDate" format="Y-m-d" style="width:90%"/></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>所属行（事）业：</label></td>
							<td class="FieldInput" colspan="5"><label field="busScope" dataset="busScopeSelect" style="width:17.5%"/></td>
						</tr>
						<tr>	
							<td class="FieldLabel"><label>社团通信地址：</label></td>
							<td class="FieldInput" colspan="5"><label field="sorgAdds" style="width:98%"/></td>
						</tr>
						<tr>	
							<td class="FieldLabel"><label>社团网址：</label></td>
							<td class="FieldInput" colspan="3"><label field="sorgWeb" style="width:97%"/></td>
							<td class="FieldLabel"><label>社团电子邮箱：</label></td>
							<td class="FieldInput"><label field="sorgEmail" style="width:90%"/></td>
						</tr>
					</table>
					</form>
				</next:Html>
			</next:Panel>
			
			<next:Panel title="社会团体人员信息" width="100%" height="100%" >
				<next:EditGridPanel id="sessionGrid" dataset="somSessionDataSet" width="100%" stripeRows="true" height="40%">
					<next:TopBar>
						<next:ToolBarItem symbol="届次信息"></next:ToolBarItem>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="届次" field="seq" width="5%" editable="false" align="center"><next:TextField/></next:Column>
						<next:Column header="时间" field="createTime" width="15%" editable="false" align="center"><next:TextField/></next:Column>
						<next:Column header="届次名称" field="sessionName" width="20%" editable="false" align="center"><next:TextField/></next:Column>
						<next:Column header="本届任期（年）" field="tenure" width="10%" editable="false" align="center"><next:TextField/></next:Column>
						<next:Column header="本届开始日期" field="startDate" width="10%" editable="false" align="center"><next:TextField/></next:Column>
						<next:Column header="章程规定换届日期" field="endDate" width="15%" editable="false" align="center"><next:TextField/></next:Column>
						<next:Column header="换届日期" field="realEndDate" width="10%" editable="false" align="center"><next:TextField/></next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="somSessionDataSet"/>
					</next:BottomBar>
				</next:EditGridPanel>
				<next:EditGridPanel id="peopleGrid" dataset="somDutyInsertDataSet" width="100%" stripeRows="true" height="100%">
					<next:TopBar>
						<next:ToolBarItem symbol="负责人信息"></next:ToolBarItem>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem iconCls="detail" text="查看" handler="detailPeople"></next:ToolBarItem>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="身份证号" field="idCard" width="15%" editable="false"><next:TextField/></next:Column>
						<next:Column header="姓名" field="name" width="10%" editable="false"><next:TextField/></next:Column>
						<next:Column header="性别" field="sex" width="10%" editable="false"><next:ComboBox dataset="sexSelect"/></next:Column>
						<next:Column header="出生年月" field="birthday" width="10%" editable="false"><next:TextField/></next:Column>
						<next:Column header="担任职务" field="sorgDuties" width="10%" editable="false"><next:ComboBox dataset="sorgDutiesDataSet"/></next:Column>
						<next:Column header="是否在任" field="ifServe" width="10%" editable="false"><next:ComboBox dataset="comm_yesorno"/></next:Column>
						<next:Column header="是否法定代表人" field="ifLegal" width="10%" editable="false"><next:ComboBox dataset="comm_yesorno"/></next:Column>
						<next:Column header="任职开始日期" field="startDate" width="10%" editable="false"><next:TextField/></next:Column>
						<next:Column header="任职结束日期" field="endDate" width="10%" editable="false"><next:TextField/></next:Column>
					</next:Columns>
					<next:BottomBar>
					<next:PagingToolBar dataset="somDutyInsertDataSet"/>
					</next:BottomBar>
				</next:EditGridPanel>
			</next:Panel>
			<next:Panel title="社会团体证书信息" width="100%" height="100%">
				<next:TabPanel>
					<next:Tabs>
						<next:Panel title="社会团体证书正本" width="100%" height="100%" autoScroll="true">
							<next:Html>
								<form method="post" onsubmit="return false" class="L5form"
									dataset="somCertDatasetZ">
								<table width="100%">
									<tr>
										<td class="FieldLabel" style="width: 5%;"><label>登记证号：</label></td>
										<td class="FieldInput" style="width: 5%;"><label
											field="sorgCode" readonly="readonly" /></td>
										<td class="FieldLabel" style="width: 5%;"><label>组织机构代码：</label></td>
										<td class="FieldInput" style="width: 5%;"><label
											field="organCode" readonly="readonly" /></td>
										<td class="FieldLabel" style="width: 5%;"><label>证件类型：</label></td>
										<td class="FieldInput" style="width: 10%;"><label
											field="certType" readonly="readonly" dataset="certTypeSelect" /></td>
									</tr>
									<tr>
										<td class="FieldLabel"><label>社会团体名称：</label></td>
										<td class="FieldInput" colspan="5"><label
											field="sorgName" readonly="readonly" /></td>
									</tr>
									<tr>
										<td class="FieldLabel"><label>业务范围：</label></td>
										<td class="FieldInput" colspan="5"><label
											style="height: 50px;" field="business" readonly="readonly" /></td>
									</tr>
									<tr></tr>

									<tr>
										<td class="FieldLabel"><label>住所：</label></td>
										<td class="FieldInput" colspan="5"><label
											field="residence" readonly="readonly" /></td>
									</tr>
									<tr>
										<td class="FieldLabel"><label>法定代表人：</label></td>
										<td class="FieldInput"><label field="legalPeople"
											readonly="readonly" /></td>
										<td class="FieldLabel"><label>活动地域：</label></td>
										<td class="FieldInput"><label field="actArea"
											readonly="readonly" /></td>
										<td class="FieldLabel"><label>注册资金(万元)：</label></td>
										<td class="FieldInput"><label field="regMon"
											readonly="readonly" /></td>
									</tr>
									<tr>
										<td class="FieldLabel"><label>业务主管单位：</label></td>
										<td class="FieldInput" colspan="3"><label id="borgName"
											field="borgName" readonly="readonly" /></td>
										<td class="FieldLabel"><label>登记日期：</label></td>
										<td class="FieldInput"><label id="regDate"
											field="regDate" readonly="readonly" /></td>
									</tr>
									<tr>
										<td class="FieldLabel" style="width: 10%;"><label>有效期起：</label></td>
										<td class="FieldInput" style="width: 10%;"><label
											field="signBeginDate" readonly="readonly" /></td>
										<td class="FieldLabel" style="width: 10%;"><label>有效期止：</label></td>
										<td class="FieldInput" style="width: 10%;"><label
											field="signEndDate" readonly="readonly" /></td>
										<td class="FieldLabel" style="width: 10%;"><label>有效期：</label></td>
										<td class="FieldInput" style="width: 10%;"><label
											field="signPeriod" readonly="readonly" /></td>
									</tr>
									<tr>
										<td class="FieldLabel"><label>发证原因：</label></td>
										<td class="FieldInput"><label field="issueReason"
											dataset="issueReasonSelect" /></td>
										<td class="FieldLabel"><label>发证机关：</label></td>
										<td class="FieldInput"><label field="signOrgan"
											readonly="readonly" /></td>
										<td class="FieldLabel"><label>发证日期：</label></td>
										<td class="FieldInput"><label field="signDate"
											readonly="readonly" /></td>
									</tr>
									<tr>
										<td class="FieldLabel"><label>发证原因描述：</label></td>
										<td class="FieldInput" colspan="5"><label
											style="height: 50px;" field="issueReasonSelectDesc"
											readonly="readonly" /></td>
									</tr>
									<tr></tr>
									<tr>
										<td class="FieldLabel"><label>制证人：</label></td>
										<td class="FieldInput"><label field="printPeople"
											readonly="readonly" /></td>
										<td class="FieldLabel"><label>制证时间：</label></td>
										<td class="FieldInput"><label field="printTime"
											readonly="readonly" /></td>
										<td class="FieldLabel"><label></label></td>
										<td class="FieldInput"></td>
									</tr>
									<tr>
										<td class="FieldLabel"><label>领证人：</label></td>
										<td class="FieldInput"><label field="fetchPeople"
											readonly="readonly" /></td>
										<td class="FieldLabel"><label>领证日期：</label></td>
										<td class="FieldInput"><label field="fetchDate"
											readonly="readonly" /></td>
										<td class="FieldLabel"><label>发证人</label></td>
										<td class="FieldInput"><label field="issuePeople"
											readonly="readonly" /></td>
									</tr>
									<tr id="receive" style="display: none;">
										<td class="FieldLabel"><label>收缴标志：</label></td>
										<td class="FieldInput"><label field="ifReceive"
											readonly="readonly" /></td>
										<td class="FieldLabel"><label>收缴人：</label></td>
										<td class="FieldInput"><label field="receivePeople"
											readonly="readonly" /></td>
										<td class="FieldLabel"><label>收缴日期：</label></td>
										<td class="FieldInput"><label field="receiveDate"
											readonly="readonly" /></td>
									</tr>
									<tr style="display: none;">
										<td class="FieldLabel"><label>证件状态：</label></td>
										<td class="FieldInput"><input type="text"
											id="wincertStatus" field="certStatus" readonly="readonly" /></td>
									</tr>
								</table>
								</form>
							</next:Html>
						</next:Panel>
						<next:Panel title="社会团体证书副本" width="100%" height="100%" autoScroll="true">
							<next:Html>
								<form method="post" onsubmit="return false" class="L5form"
									dataset="somCertDatasetF">
								<table width="100%">
									<tr>
										<td class="FieldLabel" style="width: 5%;"><label>登记证号：</label></td>
										<td class="FieldInput" style="width: 5%;"><label
											field="sorgCode" readonly="readonly" /></td>
										<td class="FieldLabel" style="width: 5%;"><label>组织机构代码：</label></td>
										<td class="FieldInput" style="width: 5%;"><label
											field="organCode" readonly="readonly" /></td>
										<td class="FieldLabel" style="width: 5%;"><label>证件类型：</label></td>
										<td class="FieldInput" style="width: 10%;"><label
											dataset="certTypeSelect" field="certType" readonly="readonly" /></td>
									</tr>
									<tr>
										<td class="FieldLabel"><label>社会团体名称：</label></td>
										<td class="FieldInput" colspan="5"><label
											field="sorgName" readonly="readonly" /></td>
									</tr>
									<tr>
										<td class="FieldLabel"><label>业务范围：</label></td>
										<td class="FieldInput" colspan="5"><label
											style="height: 50px;" field="business" readonly="readonly" /></td>
									</tr>
									<tr></tr>

									<tr>
										<td class="FieldLabel"><label>住所：</label></td>
										<td class="FieldInput" colspan="5"><label
											field="residence" readonly="readonly" /></td>
									</tr>
									<tr>
										<td class="FieldLabel"><label>法定代表人：</label></td>
										<td class="FieldInput"><label field="legalPeople"
											readonly="readonly" /></td>
										<td class="FieldLabel"><label>活动地域：</label></td>
										<td class="FieldInput"><label field="actArea"
											readonly="readonly" /></td>
										<td class="FieldLabel"><label>注册资金(万元)：</label></td>
										<td class="FieldInput"><label field="regMon"
											readonly="readonly" /></td>
									</tr>
									<tr>
										<td class="FieldLabel"><label>业务主管单位：</label></td>
										<td class="FieldInput" colspan="3"><label id="borgName"
											field="borgName" readonly="readonly" /></td>
										<td class="FieldLabel"><label>登记日期：</label></td>
										<td class="FieldInput"><label id="regDate"
											field="regDate" readonly="readonly" /></td>
									</tr>
									<tr>
										<td class="FieldLabel" style="width: 10%;"><label>有效期起：</label></td>
										<td class="FieldInput" style="width: 10%;"><label
											field="signBeginDate" readonly="readonly" /></td>
										<td class="FieldLabel" style="width: 10%;"><label>有效期止：</label></td>
										<td class="FieldInput" style="width: 10%;"><label
											field="signEndDate" readonly="readonly" /></td>
										<td class="FieldLabel" style="width: 10%;"><label>有效期：</label></td>
										<td class="FieldInput" style="width: 10%;"><label
											field="signPeriod" readonly="readonly" /></td>
									</tr>
									<tr>
										<td class="FieldLabel"><label>发证原因：</label></td>
										<td class="FieldInput"><label field="issueReason"
											dataset="issueReasonSelect" /></td>
										<td class="FieldLabel"><label>发证机关：</label></td>
										<td class="FieldInput"><label field="signOrgan"
											readonly="readonly" /></td>
										<td class="FieldLabel"><label>发证日期：</label></td>
										<td class="FieldInput"><label field="signDate"
											readonly="readonly" /></td>
									</tr>
									<tr>
										<td class="FieldLabel"><label>发证原因描述：</label></td>
										<td class="FieldInput" colspan="5"><label
											style="height: 50px;" field="issueReasonSelectDesc"
											readonly="readonly" /></td>
									</tr>
									<tr></tr>
									<tr>
										<td class="FieldLabel"><label>制证人：</label></td>
										<td class="FieldInput"><label field="printPeople"
											readonly="readonly" /></td>
										<td class="FieldLabel"><label>制证时间：</label></td>
										<td class="FieldInput"><label field="printTime"
											readonly="readonly" /></td>
										<td class="FieldLabel"><label></label></td>
										<td class="FieldInput"></td>
									</tr>
									<tr>
										<td class="FieldLabel"><label>领证人：</label></td>
										<td class="FieldInput"><label field="fetchPeople"
											readonly="readonly" /></td>
										<td class="FieldLabel"><label>领证日期：</label></td>
										<td class="FieldInput"><label field="fetchDate"
											readonly="readonly" /></td>
										<td class="FieldLabel"><label>发证人</label></td>
										<td class="FieldInput"><label field="issuePeople"
											readonly="readonly" /></td>
									</tr>
									<tr id="receive" style="display: none;">
										<td class="FieldLabel"><label>收缴标志：</label></td>
										<td class="FieldInput"><label field="ifReceive"
											readonly="readonly" /></td>
										<td class="FieldLabel"><label>收缴人：</label></td>
										<td class="FieldInput"><label field="receivePeople"
											readonly="readonly" /></td>
										<td class="FieldLabel"><label>收缴日期：</label></td>
										<td class="FieldInput"><label field="receiveDate"
											readonly="readonly" /></td>
									</tr>
									<tr style="display: none;">
										<td class="FieldLabel"><label>证件状态：</label></td>
										<td class="FieldInput"><input type="text"
											id="wincertStatus" field="certStatus" readonly="readonly" /></td>
									</tr>
								</table>
								</form>
							</next:Html>
						</next:Panel>
					</next:Tabs>
				</next:TabPanel>
			</next:Panel>
			<next:Panel title="社会团体备案信息" width="100%" height="100%">
				<next:TabPanel>
					<next:Tabs>
						<next:Panel title="社会团体账户备案信息" width="100%" height="100%" autoScroll="true">
							<next:EditGridPanel id="accountgrid" dataset="AccountDS" width="100%" stripeRows="true" height="100%">
								<next:TopBar>
									<next:ToolBarItem symbol="账户信息"></next:ToolBarItem>
									<next:ToolBarItem symbol="->"></next:ToolBarItem>
									<next:ToolBarItem iconCls="detail" text="查看" handler="detailAccount"></next:ToolBarItem>
								</next:TopBar>
								<next:Columns>
									<next:RowNumberColumn/>
									<next:RadioBoxColumn></next:RadioBoxColumn>
									<next:Column header="账户名称" id="name" field="name" resizable="true" width="15%"></next:Column>
									<next:Column header="开户银行账户" field="accountCode" resizable="true" width="20%"></next:Column>
									<next:Column header="开户银行" field="bank" resizable="true" width="15%"></next:Column>
									<next:Column header="开户时间" field="accountDate" width="15%"></next:Column>
									<next:Column header="备案人" field="regPeople" width="15%"></next:Column>
									<next:Column header="备案日期" field="regDate" width="10%"></next:Column>
								</next:Columns>
								<next:BottomBar>
									<next:PagingToolBar dataset="AccountDS"/>
								</next:BottomBar>
							</next:EditGridPanel>
						</next:Panel>
						<next:Panel title="社会团体会费备案信息" width="100%" height="100%" autoScroll="true">
							<next:EditGridPanel id="feegrid" dataset="FeeDS" width="100%" stripeRows="true" height="100%">
								<next:TopBar>
									<next:ToolBarItem symbol="会费信息"></next:ToolBarItem>
									<next:ToolBarItem symbol="->"></next:ToolBarItem>
									<next:ToolBarItem iconCls="detail" text="查看" handler="detailFee"></next:ToolBarItem>
								</next:TopBar>
								<next:Columns>
									<next:RowNumberColumn/>
									<next:RadioBoxColumn></next:RadioBoxColumn>
									<next:Column header="会议名称" field="meetingName" width="25%"></next:Column>
									<next:Column header="时间" field="meetingDate" width="10%"></next:Column>
									<next:Column header="备案人" field="regPeople" width="15%"></next:Column>
									<next:Column header="备案日期" field="regDate" width="10%"></next:Column>
								</next:Columns>
								<next:BottomBar>
									<next:PagingToolBar dataset="FeeDS"/>
								</next:BottomBar>
							</next:EditGridPanel>
						</next:Panel>
						<next:Panel title="社会团体办事机构备案信息" width="100%" height="100%" autoScroll="true">
							<next:EditGridPanel id="officegrid" dataset="OfficeDS" width="100%" stripeRows="true" height="100%">
								<next:TopBar>
									<next:ToolBarItem symbol="办事机构信息"></next:ToolBarItem>
									<next:ToolBarItem symbol="->"></next:ToolBarItem>
									<next:ToolBarItem iconCls="detail" text="查看" handler="detailOffice"></next:ToolBarItem>
								</next:TopBar>
								<next:Columns>
									<next:RowNumberColumn/>
									<next:RadioBoxColumn></next:RadioBoxColumn>
									<next:Column header="办事机构名称" field="name" width="15%"></next:Column>
									<next:Column header="场所" field="place" width="20%"></next:Column>
									<next:Column header="电话" field="phone" width="15%"></next:Column>
									<next:Column header="备案人" field="regPeople" width="15%"></next:Column>
									<next:Column header="备案日期" field="regDate" width="10%"></next:Column>
								</next:Columns>
								<next:BottomBar>
									<next:PagingToolBar dataset="OfficeDS"/>
								</next:BottomBar>
							</next:EditGridPanel>
						</next:Panel>
						<next:Panel title="社会团体举办实体备案信息" width="100%" height="100%" autoScroll="true">
							<next:EditGridPanel id="entitygrid" dataset="EntityDS" width="100%" stripeRows="true" height="100%">
								<next:TopBar>
									<next:ToolBarItem symbol="举办实体信息"></next:ToolBarItem>
									<next:ToolBarItem symbol="->"></next:ToolBarItem>
									<next:ToolBarItem iconCls="detail" text="查看" handler="detailEntity"></next:ToolBarItem>
								</next:TopBar>
								<next:Columns>
									<next:RowNumberColumn/>
									<next:RadioBoxColumn></next:RadioBoxColumn>
									<next:Column header="实体名称" field="name" width="20%"></next:Column>
									<next:Column header="地址" field="adds" width="24%"></next:Column>
									<next:Column header="注册时间"  field="registDate" width="20%"></next:Column>
									<next:Column header="备案人" field="regPeople" width="15%"></next:Column>
									<next:Column header="备案日期" field="regDate" width="10%"></next:Column>
								</next:Columns>
								<next:BottomBar>
									<next:PagingToolBar dataset="EntityDS"/>
								</next:BottomBar>
							</next:EditGridPanel>
						</next:Panel>
						<next:Panel title="社会团体章程核准信息" width="100%" height="100%" autoScroll="true">
							<next:EditGridPanel id="rulegrid" dataset="somRuleDataSet" width="100%" stripeRows="true" height="100%">
								<next:TopBar>
									<next:ToolBarItem symbol="章程信息"></next:ToolBarItem>
									<next:ToolBarItem symbol="->"></next:ToolBarItem>
									<next:ToolBarItem iconCls="detail" text="查看" handler="detailRule"></next:ToolBarItem>
								</next:TopBar>
								<next:Columns>
									<next:RowNumberColumn/>
									<next:RadioBoxColumn></next:RadioBoxColumn>
									<next:Column header="会议名称" field="meetingName" width="25%"></next:Column>
									<next:Column header="时间" field="meetingDate" width="10%"></next:Column>
									<next:Column header="是否章程草案" field="ifDraft" width="10%" editable="false"><next:ComboBox dataset="comm_yesorno"/></next:Column>
								</next:Columns>
								<next:BottomBar>
									<next:PagingToolBar dataset="somRuleDataSet"/>
								</next:BottomBar>
							</next:EditGridPanel>
						</next:Panel>
					</next:Tabs>
				</next:TabPanel>
			</next:Panel>
			<next:Panel title="电子档案" width="100%" height="100%" autoScroll="true">
							<next:EditGridPanel id="fileGrid" width="100%" stripeRows="true" height="100%" dataset="somElectronicDataSet">
								<next:GroupingView forceFit="true"></next:GroupingView>
								<next:TopBar>
									<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
									<next:ToolBarItem symbol="->"></next:ToolBarItem>
								</next:TopBar>
				
								<next:Columns>
									<next:RowNumberColumn />
									<next:RadioBoxColumn></next:RadioBoxColumn>
									<next:Column header="档案目录名"  field="catalogCode" width="38%" editable="false" dataset="cataLogCodeSelect"><next:TextField /></next:Column>
									<next:Column header="附件名称"    field="fileName" width="30%" editable="false"><next:TextField /></next:Column>
									<next:Column header="附件描述"    field="fileMess" width="20%" editable="false"><next:TextField /></next:Column>
									<next:Column header="下载附件"    field="" width="10%" editable="false" renderer="clickDownloadHrefForArchive"><next:TextField /></next:Column>
									<next:Column header="档案目录"    field="taskCode" hidden="true">
										<next:ExtendConfig>
											groupRenderer:grender
										</next:ExtendConfig>
									</next:Column>
									<next:Column header="业务类型"    field="applyType" hidden="true"></next:Column>
									<next:Column header="创建时间"    field="createTime" hidden="true"></next:Column>
								</next:Columns>
								<next:BottomBar>
									<next:PagingToolBar dataset="somElectronicDataSet" />
								</next:BottomBar>
							</next:EditGridPanel>
			</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>
<jsp:include page="../../comm/upload/uploadWindow.jsp" flush="true"/>
<jsp:include page="../../comm/people/groupPeopleDetail.jsp" flush="true"/>
</body>
</html>