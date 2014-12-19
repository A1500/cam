<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
<!-- 民办非企业组织详细信息 -->
<head>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js")%>'></script>
<script type="text/javascript">var rootPath='<%=SkinUtils.getRootUrl(request)%>';</script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/somPhoto.js") %>'></script>
<script type="text/javascript" src="<%=SkinUtils.getRootUrl(request)%>skins/js/ISEditPhoto.js"></script>
<script type="text/javascript">
var sorgId='<%=request.getParameter("sorgId")%>';


function init(){
	var somOrganDataSet=L5.DatasetMgr.lookup("somOrganDataSet");
	somOrganDataSet.setParameter("SORG_ID@=", sorgId);
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
	somDutyDataSet.setParameter("SORG_ID",sorgId);
	somDutyDataSet.load();
	somDutyDataSet.on('load',function(){
		var peopleId='';
		somDutyDataSet.each(function(record, index){
			if(record.get('sorgDuties') == "00012" && record.get('regStatus')=="1"){
				peopleId=record.get('peopleId');
			}
		});
		somDutyDataSet.filterBy(function(record, id){
			if(record.get('sorgDuties') != "00012"){
				if(record.get('peopleId') == peopleId){
					record.set('ifLegal','1');
				}
				return record;
			}
		});
		somDutyDataSet.commitChanges();
	});

	var AccountDS=L5.DatasetMgr.lookup("AccountDS");
	AccountDS.setParameter("SORG_ID@=",sorgId);
	AccountDS.load();
	AccountDS.on("load",function(){
			if(AccountDS.getCount()==0){
			AccountDS.newRecord();
			}
		}
	);
	var OfficeDS=L5.DatasetMgr.lookup("OfficeDS");
	OfficeDS.setParameter("SORG_ID@=",sorgId);
	OfficeDS.load();
	OfficeDS.on("load",function(){
			if(OfficeDS.getCount()==0){
			OfficeDS.newRecord();
			}
		}
	);

	var somHeldPeopleDataSet=L5.DatasetMgr.lookup("somHeldPeopleDataSet");
	somHeldPeopleDataSet.setParameter("SORG_ID@=",sorgId);
	somHeldPeopleDataSet.load();

	var somHeldOrganDataSet=L5.DatasetMgr.lookup("somHeldOrganDataSet");
	somHeldOrganDataSet.setParameter("SORG_ID@=",sorgId);
	somHeldOrganDataSet.load();
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
	var somResumeInsertDataSet=L5.DatasetMgr.lookup("somResumeInsertDataSet");
	somResumeInsertDataSet.setParameter("DUTY_ID",record.get('dutyId'));
	somResumeInsertDataSet.load();
	L5.getCmp("peopleWin").show();
	var birthday=record.get("birthday");
	showAge(birthday);
}
function showAge(birthday){
	var day=new Date();
	var year=day.getYear();
	var birthYear=birthday.substring(0,4);
	document.getElementById("age").innerHTML=parseInt(year)-parseInt(birthYear);
}
function closePeople(){
	var win=L5.getCmp("peopleWin");
	win.setVisible(false);
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
	var url="jsp/cams/sorg/manage/ungov/ungovRuleDetail.jsp";
	L5.forward(url,'',data);
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
	var url="jsp/cams/sorg/manage/ungov/ungovAccountDetail.jsp";
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
	var url="jsp/cams/sorg/manage/ungov/ungovOfficeDetail.jsp";
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
<script type="text/javascript" src="somGroupQuery.js"></script>
</head>
<body>
<model:datasets>
	<!-- 民办非企业组织dataset -->
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan">
			<model:field name="nowBorgName" type="string"/>
		</model:record>
	</model:dataset>
	<model:dataset id="somSessionDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomSessionQueryCmd">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomSession"></model:record>
	</model:dataset>
	<!-- 负责人信息 -->
	<model:dataset id="somDutyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true" method="queryPeople">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<%--举办人情况--%>
	<model:dataset id="somHeldPeopleDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomHeldPeopleQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomHeldPeople"></model:record>
	</model:dataset>
	<%--举办单位情况--%>
	<model:dataset id="somHeldOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomHeldOrganQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomHeldOrgan"></model:record>
	</model:dataset>
	<%--人员简历 --%>
	<model:dataset id="somResumeInsertDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomPeopleResumeQueryCommand">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeopleResume"></model:record>
	</model:dataset>
	<!-- 证书正本 -->
	<model:dataset id="somCertDatasetZ"
		cmd="com.inspur.cams.sorg.base.cmd.SomCertQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomCert"></model:record>
		<model:params>
			<model:param name="sorg_Id"
				value='<%=request.getParameter("sorgId")%>'></model:param>
				<model:param name="cert_Type" value='0'></model:param>
				<model:param name="cert_status" value='1'></model:param>
		</model:params>
	</model:dataset>
	<%--电子档案--%>
	<model:dataset id="somElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true" autoLoad="true" method="queryArchiveCatalog" isGroup="true" groupField="taskCode" pageSize="500">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
		<model:params>
			<model:param name="sorgId" value='<%=request.getParameter("sorgId")%>'></model:param>
		</model:params>
	</model:dataset>
	<!-- 任职状态 -->
	<model:dataset id="regStatusDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_REG_STATUS'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 证书副本 -->
	<model:dataset id="somCertDatasetF"
		cmd="com.inspur.cams.sorg.base.cmd.SomCertQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomCert"></model:record>
		<model:params>
			<model:param name="cert_Type" value='1'></model:param>
			<model:param name="sorg_Id"
				value='<%=request.getParameter("sorgId")%>'></model:param>
			<model:param name="cert_status" value='1'></model:param>
		</model:params>
	</model:dataset>
	<!-- 账户 -->
	<model:dataset id="AccountDS"
		cmd="com.inspur.cams.sorg.base.cmd.SomAccountQueryCmd"
		 global="true" >
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomAccount"></model:record>
		<model:params>
			<model:param name="sorg_Id"
				value='<%=request.getParameter("sorgId")%>'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="OfficeDS"
		cmd="com.inspur.cams.sorg.base.cmd.SomOfficeQueryCmd"
		autoLoad="true"  global="true" >
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOffice"></model:record>
		<model:params>
			<model:param name="sorg_Id"
				value='<%=request.getParameter("sorgId")%>'></model:param>
		</model:params>
	</model:dataset>
	<!-- 办事机构 -->
	<model:dataset id="somRuleDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomRuleQueryCmd" method="queryRule" autoLoad="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomRule"/>
		<model:params>
			<model:param name="sorg_Id"
				value='<%=request.getParameter("sorgId")%>'></model:param>
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
	<!-- 是否专/兼职 -->
	<model:dataset id="ifFulltimeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_IF_FULLTIME'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 所属行（事）业 -->
	<model:dataset id="busScopes" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BUS_SCOPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 是否最新标准 -->
	<model:dataset id="ifCurrent" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 证书发证原因 -->
	<model:dataset id="issueReason" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CERT_ISSUEREASON'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 证书类别枚举 -->
	<model:dataset id="certType" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CERT_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 社会组织状态 -->
	<model:dataset id="sorgStatus" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SORG_STATUS'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 性别 -->
	<model:dataset id="sex" enumName="COMM.SEX" autoLoad="true"
		global="true"></model:dataset>
	<!-- 是否离退休 -->
	<model:dataset id="ifRetire" enumName="COMM.YESORNO" autoLoad="true"
		global="true"></model:dataset>
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 是否专兼职 -->
	<model:dataset id="ifFulltime" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_IF_FULLTIME'></model:param>
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


		<%--定义字典表--%>
	<model:dataset id="cataLogCodeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_CATALOG'></model:param>
			<model:param name="value" value='CATALOG_CODE'></model:param>
			<model:param name="text" value='CATALOG_NAME'></model:param>
		</model:params>
	</model:dataset>
	<%--下载窗口--%>
	<model:dataset id="downloadDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" method="queryElectronic">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<model:dataset id="sorgDutiesDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_DUTY'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="sexDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SEX'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="yesornoDataSet" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:Panel  width="100%" height="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="undo" text="返回" handler="returnQueryList"></next:ToolBarItem>
	</next:TopBar>
	<next:TabPanel   id="tab">
		<next:Tabs>
			<next:Panel title="民办非企业组织基本信息" width="100%" height='100%' autoScroll="true">
				<next:Html>
					<form method="post" dataset="somOrganDataSet" onsubmit="return false" class="L5form">
						<table width="100%">
							<tr>
								<td class="FieldLabel"><label>登记证号：</label></td>
								<td class="FieldInput" colspan="5"><label field="sorgCode"
									style="width: 100%" /></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>民非企业名称/中文：</label></td>
								<td class="FieldInput" colspan="5"><label field="cnName"
									style="width: 100%" /></td>
							</tr>
							<td class="FieldLabel"><label>民非企业名称/英文：</label></td>
							<td class="FieldInput" colspan="3"><label field="enName"
								style="width: 97.5%" /></td>
							<td class="FieldLabel" style="width: 18%"><label>民非企业名称/缩写：</label></td>
							<td class="FieldInput"><label field="abName" /></td>
							<tr>
								<td class="FieldLabel"><label>组织机构代码：</label></td>
								<td class="FieldInput" colspan="3"><label field="organCode"
									style="width: 97.5%" /></td>
								<td class="FieldLabel"><label>社会组织类型：</label></td>
								<td class="FieldInput"><label field="sorgKind"/></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>住所：</label></td>
								<td class="FieldInput" colspan="5"><label field="residence"
									style="width: 100%" /></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>住所来源：</label></td>
								<td class="FieldInput" colspan="5"><label
									field="residenceSource" style="width: 100%" /></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width: 17%"><label>民非企业邮编：</label></td>
								<td class="FieldInput" style="width: 17%"><label
									field="sorgPost" /></td>
								<td class="FieldLabel" style="width: 17%"><label>民非企业电话：</label></td>
								<td class="FieldInput" style="width: 17%"><label
									field="sorgPhone" /></td>
								<td class="FieldLabel" style="width: 15%"><label>民非企业传真：</label></td>
								<td class="FieldInput" style="width: 17%"><label
									field="sorgFax" /></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>民非企业通信地址：</label></td>
								<td class="FieldInput" colspan="5"><label field="sorgAdds"
									style="width: 100%" /></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>民非企业网址：</label></td>
								<td class="FieldInput" colspan="3"><label field="sorgWeb"
									style="width: 97.5%" /></td>
								<td class="FieldLabel"><label>民非企业电子邮箱：</label></td>
								<td class="FieldInput"><label field="sorgEmail" /></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>活动地域：</label></td>
								<td class="FieldInput" colspan="5"><label field="actArea"
									style="width: 100%" style="width:100%" /></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>民非企业宗旨：</label></td>
								<td class="FieldInput" colspan="5"><label field="purpose"
									style="width: 100%" /></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>业务范围：</label></td>
								<td class="FieldInput" colspan="5"><label field="business"
									style="width: 100%" /></td>
							</tr>
							<span onmousemove="this.setCapture();"onmouseout="this.releaseCapture();">
							<tr>
								<td class="FieldLabel"><label>所属行（事）业：</label></td>
								<td class="FieldInput" colspan="3">
									<label  field="busScope" dataset="busScopes"/>
								</td>
								<td class="FieldLabel"><label>业务范围代码：</label></td>
								<td class="FieldInput"><label field="businessCode"
									dataset="" /></td>
							</tr>
							</span>
							<tr>
								<td class="FieldLabel"><label>业务主管单位：</label></td>
								<td class="FieldInput" colspan="3"><label field="newBorgName" name='"业务主管单位"' style="width:90%" ></label></td>
								<td class="FieldLabel"><label>主管单位审查日期：</label></td>
								<td class="FieldInput"><label field="borgCheckDate"
									format="Y-m-d" /></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>单位会员数：</label></td>
								<td class="FieldInput"><label field="unitsNum" /></td>
								<td class="FieldLabel"><label>个人会员数：</label></td>
								<td class="FieldInput"><label field="peopleNum" /></td>
								<td class="FieldLabel"><label>理事数：</label></td>
								<td class="FieldInput"><label field="councilNum"></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>常务理事数：</label></td>
								<td class="FieldInput"><label field="standCouncilNum" /></td>
								<td class="FieldLabel"><label>活动资金币种：</label></td>
								<td class="FieldInput"><label field="currency" /></td>
								<td class="FieldLabel"><label>活动资金数额（万元）：</label></td>
								<td class="FieldInput"><label field="regMon" /></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>验资单位：</label></td>
								<td class="FieldInput" colspan="5"><label
									field="checkCapitalOrgan" style="width: 100%"></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>经费来源：</label></td>
								<td class="FieldInput" colspan="5"><label
									field="moneySource" style="width: 100%" /></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>产权单位：</label></td>
								<td class="FieldInput" colspan="3"><label
									field="housingOrgan" style="width: 97.5%" /></td>
								<td class="FieldLabel"><label>产权单位用房面积（平方米）：</label></td>
								<td class="FieldInput"><label field="housingArea" /></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>租（借）期限：</label></td>
								<td class="FieldInput" colspan="5"><label
									field="leasePeriod" style="width: 100%" /></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>登记人：</label></td>
								<td class="FieldInput"><label field="regPeople" /></td>
								<td class="FieldLabel"><label>登记日期：</label></td>
								<td class="FieldInput" colspan="3"><label field="regDate"
									format="Y-m-d" /></td>
							</tr>
						</table>
						</form>
					</next:Html>
				</next:Panel>
				<next:Panel title="民办非企业组织人员信息" height="100%" >
					<next:EditGridPanel id="peopleGrid" dataset="somDutyDataSet" width="100%" stripeRows="true" height="100%">
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
							<next:Column header="职务" field="sorgDuties" width="10%" editable="false"><next:TextField/></next:Column>
							<next:Column header="性别" field="sex" width="10%" editable="false"><next:ComboBox dataset="sexDataSet"/></next:Column>
							<next:Column header="出生年月" field="birthday" width="10%" editable="false"><next:TextField/></next:Column>
							<next:Column header="是否在任" field="ifServe" width="10%" editable="false"><next:ComboBox dataset="comm_yesorno"/></next:Column>
							<next:Column header="是否为法定代表人" field="ifLegal" width="10%" editable="false"><next:ComboBox dataset="comm_yesorno"/></next:Column>
							<next:Column header="任职开始日期" field="startDate" width="10%" editable="false"><next:TextField/></next:Column>
							<next:Column header="任职结束日期" field="endDate" width="10%" editable="false"><next:TextField/></next:Column>
						</next:Columns>
						<next:BottomBar>
						<next:PagingToolBar dataset="somDutyDataSet"/>
						</next:BottomBar>
					</next:EditGridPanel>
					<jsp:include page="../../comm/people/ungovPeopleDetail.jsp" flush="true"/>
				</next:Panel>
				<next:Panel title="举办人情况" width="100%" >
					<next:TabPanel width="100%" height="100%" id="tab1">
						<next:Tabs>
							<next:Panel title="举办人（自然人）">
								<next:EditGridPanel id="heldPeopleGrid" dataset="somHeldPeopleDataSet" width="100%" stripeRows="true" height="100%">
									<next:Columns>
										<next:RowNumberColumn/>
										<next:RadioBoxColumn></next:RadioBoxColumn>
										<next:Column header="内码" field="id" width="15%" editable="true" hidden="true"><next:TextField/></next:Column>
										<next:Column header="身份证号" field="idCard" width="15%" editable="false"><next:TextField/></next:Column>
										<next:Column header="姓名" field="name" width="10%" editable="false"><next:TextField/></next:Column>
										<next:Column header="性别" field="sex" width="5%" editable="false"><next:ComboBox dataset="sex"></next:ComboBox></next:Column>
										<next:Column header="出生年月" field="birthday" width="10%" editable="false"><next:DateField format="Y-m-d"/></next:Column>
										<next:Column header="政治面貌" field="politics" width="10%" editable="false"><next:ComboBox dataset="politicsSelect"></next:ComboBox></next:Column>
										<next:Column header="户口所在地" field="populace" width="15%" editable="false"><next:TextField/></next:Column>
										<next:Column header="工作单位" field="workName" width="15%" editable="false"><next:TextField/></next:Column>
										<next:Column header="工作单位职务" field="workDuties" width="10%" editable="false"><next:TextField/></next:Column>
										<next:Column header="联系电话" field="phone" width="10%" editable="false"><next:TextField/></next:Column>
									</next:Columns>
									<next:BottomBar>
										<next:PagingToolBar dataset="somHeldPeopleDataSet"/>
									</next:BottomBar>
								</next:EditGridPanel>
							</next:Panel>
							<next:Panel title="举办人（单位）">
								<next:EditGridPanel id="heldOrganGrid" dataset="somHeldOrganDataSet" width="100%" stripeRows="true" height="100%">
									<next:Columns>
										<next:RowNumberColumn/>
										<next:RadioBoxColumn></next:RadioBoxColumn>
										<next:Column header="内码" field="id" width="15%" editable="false" hidden="true"><next:TextField/></next:Column>
										<next:Column header="举办单位名称" field="name" width="40%" editable="false"><next:TextField/></next:Column>
										<next:Column header="主要负责人" field="heldorganPeople" width="10%" editable="false"><next:TextField/></next:Column>
										<next:Column header="联系电话" field="phone" width="20%" editable="false"><next:TextField/></next:Column>
									</next:Columns>
									<next:BottomBar>
										<next:PagingToolBar dataset="somHeldOrganDataSet"/>
									</next:BottomBar>
								</next:EditGridPanel>
							</next:Panel>
						</next:Tabs>
					</next:TabPanel>
				</next:Panel>
			<next:Panel title="民办非企业组织证书信息"width='100%'height='100%'>
				<next:TabPanel>
					<next:Tabs>
						<next:Panel title="民办非企业组织证书正本" width='100%'height="100%"autoScroll='true'>
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
											dataset="certType" field="certType" readonly="readonly" /></td>
									</tr>
									<tr>
										<td class="FieldLabel"><label>民办非企业组织名称：</label></td>
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
											dataset="issueReason" /></td>
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
											style="height: 50px;" field="issueReasonDesc"
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
											readonly="readonly" />
										</td>
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
						<next:Panel title="民办非企业组织证书副本" width='100%' height="100%"autoScroll='true'>
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
											dataset="certType" field="certType" readonly="readonly" /></td>
									</tr>
									<tr>
										<td class="FieldLabel"><label>民办非企业组织名称：</label></td>
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
											dataset="issueReason" /></td>
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
											style="height: 50px;" field="issueReasonDesc"
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
										</td>
									</tr>
									<tr id="receive" style="display: none;">
										<td class="FieldLabel"><label>收缴标志：</label></td>
										<td class="FieldInput"><label field="ifReceive" eadonly="readonly" /></td>
										<td class="FieldLabel"><label>收缴人：</label></td>
										<td class="FieldInput"><label field="receivePeople" readonly="readonly" /></td>
										<td class="FieldLabel"><label>收缴日期：</label></td>
										<td class="FieldInput"><label field="receiveDate" readonly="readonly" /></td>
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
			<next:Panel title="民办非企业组织备案信息"width='100%'height='100%'>
				<next:TabPanel>
					<next:Tabs>
						<next:Panel title="民办非企业组织账户备案信息"  width="100%"height='100%'>
							<next:EditGridPanel id="accountgrid" dataset="AccountDS" width="100%" stripeRows="true" height='100%'>
								<next:TopBar>
									<next:ToolBarItem symbol="账户信息"></next:ToolBarItem>
									<next:ToolBarItem symbol="->"></next:ToolBarItem>
									<next:ToolBarItem iconCls="detail" text="查看" handler="detailAccount"></next:ToolBarItem>
								</next:TopBar>
								<next:Columns>
									<next:RowNumberColumn/>
									<next:RadioBoxColumn></next:RadioBoxColumn>
									<next:Column header="账户名称" id="name" field="name" resizable="true" width="15%" editable="false"><next:TextField/></next:Column>
									<next:Column header="开户银行账户" field="accountCode" resizable="true" width="20%" editable="false"><next:TextField/></next:Column>
									<next:Column header="开户银行" field="bank" resizable="true" width="15%" editable="false"><next:TextField/></next:Column>
									<next:Column header="开户时间" field="accountDate" width="15%" editable="false"><next:TextField/></next:Column>
									<next:Column header="备案人" field="regPeople" width="15%" editable="false"><next:TextField/></next:Column>
									<next:Column header="备案日期" field="regDate" width="10%" editable="false"><next:TextField/></next:Column>
								</next:Columns>
								<next:BottomBar>
									<next:PagingToolBar dataset="AccountDS"/>
								</next:BottomBar>
							</next:EditGridPanel>
						</next:Panel>

						<next:Panel title="民办非企业组织办事机构备案信息"  width="100%"height='100%'>
							<next:EditGridPanel id="officegrid" dataset="OfficeDS" width="100%" stripeRows="true" height='100%'>
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

						<next:Panel title="民办非企业组织章程备案信息" width="100%"height='100%'>
							<next:Html>
								<next:EditGridPanel id="rulegrid" dataset="somRuleDataSet" width="100%" stripeRows="true" height='100%'>
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
										<next:Column header="是否章程草案" field="ifDraft" width="10%" editable="false"><next:ComboBox dataset="yesornoDataSet"/></next:Column>
									</next:Columns>
									<next:BottomBar>
										<next:PagingToolBar dataset="somRuleDataSet"/>
									</next:BottomBar>
								</next:EditGridPanel>
							</next:Html>
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
<jsp:include page="../../comm/people/ungovPeopleDetail.jsp" flush="true"/>
</body>
</html>