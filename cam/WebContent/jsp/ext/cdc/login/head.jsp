<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title></title>
<next:ScriptManager/>
<script type="text/javascript" src="vcdcConstructInfoList.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript">
	userStatus="head.jsp"
</script>
<jsp:include page="../manage/util/cdcOrgan.jsp" flush="true"/>
<html>
<head>
<style type="text/css">
	#pagelist {padding:0px;font-size:x-small; list-style-type:disc;list-style-position: inside;}
	#pagelist li {font-size:x-small;padding-left: 20px;padding-right: 20px;}
	#pagelist li a .lbt {display:block; font-size:x-small; float:left; text-decoration:none; white-space:nowrap; text-overflow:ellipsis; overflow: hidden; display:inline;}
	#pagelist li a .ldt {display:block; font-size:x-small; float:right; text-align:center; color:#069; text-decoration:none; display:inline;}
	#pagelist li a {height:20px; display:block; line-height:20px;text-decoration:none; cursor:hand;}
	#pagelist li a:hover{ color:#03c; text-decoration:none;}
	#pagelist li a:hover .ldt {color:#000;}
	#lists a {padding-left:10px;text-decoration:none;color: #03c;}
	#lists b {font-size: x-small;padding-left: 20px;}
	#lists p {font-size: x-small;padding-left: 20px;}
	#lists  {font-size: x-small;padding-left: 20px;}
	#lists a:visited {text-decoration:none; color: #03c;}
	#more {text-decoration:none;font-size: x-small;float: right;}
	#more a {text-decoration:none;}
	#more a:hover{text-decoration:none;color: #03c; }
	#more a:visited{text-decoration:none; color: #03c;}
	#template a{text-decoration:none;}
	#template a:visited{text-decoration:none; color: #03c;}
</style>
</head>
<body >
<model:datasets>
	<model:dataset id="cdcNoticeDataset" cmd="com.inspur.cams.cdc.base.cmd.CdcNoticeInfoQueryCmd" method="queryNotice"  pageSize="5">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcNoticeInfo">
			<model:field name="noticeId" mapping="NOTICE_ID" type="string" />
			<model:field name="name" mapping="NAME" type="string" />
			<model:field name="noticeType" mapping="NOTICE_TYPE" type="string" />
			<model:field name="flag" mapping="FLAG" type="string" />
			<model:field name="organName" mapping="ORGAN_NAME" type="string" />
			<model:field name="createTime" mapping="CREATE_TIME" type="string" />
		</model:record>
	</model:dataset>
	<model:dataset id="cdcNoticeCheckDataset" cmd="com.inspur.cams.cdc.base.cmd.CdcNoticeCheckQueryCommand">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcNoticeCheck" />
	</model:dataset>
	<model:dataset id="cdcReportNoticeDataset" cmd="com.inspur.cams.cdc.base.cmd.CdcNoticeQueryCmd" method="query">
	</model:dataset>
	<model:dataset id="OrgCodeDataset"
	cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
	autoLoad="false">
	<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
	<model:params>
		<model:param name="dic" value='COM_EXT_USER'></model:param>
		<model:param name="value" value='USER_ID'></model:param>
		<model:param name="text" value='AREA_CODE'></model:param>
	</model:params>
</model:dataset>
</model:datasets>
<next:Panel width="100%" border="0" height="100%">
<next:Html>
<table style="position: relative;left: 20px;top: 10px;width: 70%;padding: 30px;" >
	<tr>
		<td >
			<fieldset id="cdcFieldset">
				<legend><b>&nbsp;&nbsp; 通知通告</b></legend>
				<table width="70%"><tr><td align="left">
					<div id = "list" style="width: 80%;"></div>
					<div id = "more"><a href ="../manage/reportAndNotice/cdcNoticeList.jsp">更多...</a></div>
				</td></tr></table>
			</fieldset>
		</td>
	</tr>
	<tr>
		<td >
			<fieldset id="cdcFieldset">
				<legend><b>&nbsp;&nbsp;未填报任务</b></legend>
				<table width="95%"><tr><td>
					<div id = "lists"></div>
				</td></tr></table>
			</fieldset>
		</td>
	</tr>
	<tr>
		<td >
			<fieldset id="templateFieldset" >
				<legend><b>&nbsp;&nbsp;模板下载</b></legend>
				<table width="95%"><tr><td>
					<div id = "template" style="padding-left: 20px;"><a id="fj" href = "#" onclick="downloadFile()"><font size=2>模板下载</font></a></div>
				</td></tr></table>
			</fieldset>
		</td>
	</tr>
</table>
</next:Html>
</next:Panel>
</body>
<script type="text/javascript" >
var  orgCode ;
function init(){
	if(organLevel!="JD"){
		var s = document.getElementById("fj");
		s.disabled = true;
	}
	var OrgCodeDataset = L5.DatasetMgr.lookup("OrgCodeDataset");
	var cdcReportNoticeDataset = L5.DatasetMgr.lookup("cdcReportNoticeDataset");
	cdcReportNoticeDataset.on("load",function(){
		var innerHtml = "";
		var count = cdcReportNoticeDataset.getCount();
		var iffinished= true;
		if(count>0){
			if(true){
				for(var i = 0;i<count;i++){
					if(cdcReportNoticeDataset.getAt(i).get("REPORT_ID")=="report1"){
						if(report(cdcReportNoticeDataset.getAt(i),"1")){
							innerHtml+='<b>填报日期：'+cdcReportNoticeDataset.getAt(i).get("REPORT_DATE")+'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;类型：'+cdcReportNoticeDataset.getAt(i).get("REPORTTYPE")+'</b><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;未填报任务：';
							iffinished = false;
							if(communityType=="C"){
								if(cdcReportNoticeDataset.getAt(i).get("POPULATE")<=0){
									innerHtml += "<a href ='../manage/populate/cdcPopulateInfoEdit.jsp?method=insert'>人口状况</a>"
								}
								if(cdcReportNoticeDataset.getAt(i).get("PEOPLE")<=0){
									innerHtml += "<a href ='../manage/people/cdcPeopleReportEdit.jsp?method=insert'>人员信息</a>"
								}
								if(cdcReportNoticeDataset.getAt(i).get("FACILITIES")<=0){
									innerHtml += "<a href ='../manage/facilities/cdcFacilitiesReportEdit.jsp?method=insert'>基础设施</a>"
								}
								if(cdcReportNoticeDataset.getAt(i).get("SERVICE")<=0){
									innerHtml += "<a href ='../manage/service/cdcServiceInfoEdit.jsp?method=insert'>社区服务</a>"
								}
								if(cdcReportNoticeDataset.getAt(i).get("FUND")<=0){
									innerHtml += "<a href ='../manage/fund/cdcFundInfoEdit.jsp?method=insert'>社区经费</a>"
								}
								if(cdcReportNoticeDataset.getAt(i).get("ECONOMY")<=0){
									innerHtml += "<a href ='../manage/economy/cdcEconomyInfoEdit.jsp?method=insert'>社区资产</a>"
								}
								if(cdcReportNoticeDataset.getAt(i).get("ORGAN1")<=0){
									innerHtml += "<a href ='../manage/organ/cdcOrganInfoEdit.jsp?method=insert'>民间组织</a>"
								}
								if(cdcReportNoticeDataset.getAt(i).get("ORGAN2")<=0){
									innerHtml += "<a href ='../manage/organ/cdcAdminInfoEdit.jsp?method=insert'>社区管理与共建</a>"
								}
								if(cdcReportNoticeDataset.getAt(i).get("TENEMENT")<=0){
									innerHtml += "<a href ='../manage/tenement/cdcTenementInfoEdit.jsp?method=insert'>城市社区物业情况</a>"
								}
							}else if(communityType=="N"){
								if(cdcReportNoticeDataset.getAt(i).get("POPULATE")<=0){
									innerHtml += "<a href ='../manage/populate/vcdcPopulateInfoEdit.jsp?method=insert'>人口状况</a>"
								}
								if(cdcReportNoticeDataset.getAt(i).get("NATURE")<=0){
									innerHtml += "<a href ='../manage/natural/vcdcNaturalInfoEdit.jsp?method=insert'>自然状况</a>"
								}
								if(cdcReportNoticeDataset.getAt(i).get("PEOPLE")<=0){
									innerHtml += "<a href ='../manage/people/vcdcPeopleReportEdit.jsp?method=insert'>人员信息</a>"
								}
								if(cdcReportNoticeDataset.getAt(i).get("FACILITIES")<=0){
									innerHtml += "<a href ='../manage/facilities/vcdcFacilitiesReportEdit.jsp?method=insert'>基础设施</a>"
								}
								if(cdcReportNoticeDataset.getAt(i).get("SERVICE")<=0){
									innerHtml += "<a href ='../manage/service/vcdcServiceInfoEdit.jsp?method=insert'>社区服务</a>"
								}
								if(cdcReportNoticeDataset.getAt(i).get("FUND")<=0){
									innerHtml += "<a href ='../manage/fund/vcdcFundInfoEdit.jsp?method=insert'>社区经费</a>"
								}
								if(cdcReportNoticeDataset.getAt(i).get("ECONOMY")<=0){
									innerHtml += "<a href ='../manage/economy/vcdcEconomyInfoEdit.jsp?method=insert'>社区资产</a>"
								}
								if(cdcReportNoticeDataset.getAt(i).get("ORGAN1")<=0){
									innerHtml += "<a href ='../manage/organ/vcdcOrganInfoEdit.jsp?method=insert'>民间组织</a>"
								}
								if(cdcReportNoticeDataset.getAt(i).get("ORGAN2")<=0){
									innerHtml += "<a href ='../manage/organ/vcdcAdminInfoEdit.jsp?method=insert'>社区管理与共建</a>"
								}
								if(cdcReportNoticeDataset.getAt(i).get("CONSTRUCT")<=0){
									innerHtml += "<a href ='../manage/construct/vcdcConstructInfoEdit.jsp?method=insert'>社区规划</a>"
								}
							}else{
								if(cdcReportNoticeDataset.getAt(i).get("FACILITIES")<=0){
									innerHtml += "<a href ='../manage/facilities/cdcOwnFacilitiesReportEdit.jsp?method=insert'>城市社区基础设施</a>"
								}
								if(cdcReportNoticeDataset.getAt(i).get("ORGAN1")<=0){
									innerHtml += "<a href ='../manage/organ/cdcOrganInfoEdit.jsp?method=insert'>城市社区民间组织</a>"
								}
								if(cdcReportNoticeDataset.getAt(i).get("COORDINATE")<=0){
									innerHtml += "<a href ='../manage/coordinate/vcdcCoordinateInfoEdit.jsp?method=insert'>农村社区领导协调机制</a>"
								}
								if(cdcReportNoticeDataset.getAt(i).get("PLAN")<=0){
									innerHtml += "<a href ='../manage/plan/vcdcPlanInfoEdit.jsp?method=insert'>农村社区建设规划</a>"
								}
								if(cdcReportNoticeDataset.getAt(i).get("FINANCE")<=0){
									innerHtml += "<a href ='../manage/finance/vcdcFinanceInfoEdit.jsp?method=insert'>农村社区经济基本情况</a>"
								}
								if(cdcReportNoticeDataset.getAt(i).get("SERVICE")<=0){
									innerHtml += "<a href ='../manage/servicefacilities/vcdcServiceFacilitiesEdit.jsp?method=insert'>农村社区服务设施</a>"
								}
								if(cdcReportNoticeDataset.getAt(i).get("SERVICEMODE")<=0){
									innerHtml += "<a href ='../manage/ownService/vcdcServiceInfoEdit.jsp?method=insert'>农村社区服务情况</a>"
								}
							}
						}
					}else if(cdcReportNoticeDataset.getAt(i).get("REPORT_ID")=="report3"){
						if(report(cdcReportNoticeDataset.getAt(i),"3")){
							iffinished = false;
							innerHtml+='<b>填报日期：'+cdcReportNoticeDataset.getAt(i).get("REPORT_DATE")+'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;类型：'+cdcReportNoticeDataset.getAt(i).get("REPORTTYPE")+'</b><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;未填报任务：';
							if(communityType=="C"){
								if(cdcReportNoticeDataset.getAt(i).get("DECISION")<=0){
									innerHtml += "<a href ='../manage/decision/cdcDecisionInfoEdit.jsp?method=insert'>民主决策</a>"
								}
								if(cdcReportNoticeDataset.getAt(i).get("MANAGE")<=0){
									innerHtml += "<a href ='../manage/manage/cdcManageInfoEdit.jsp?method=insert'>民主管理</a>"
								}
								if(cdcReportNoticeDataset.getAt(i).get("SUPERVISE")<=0){
									innerHtml += "<a href ='../manage/supervise/cdcSuperviseInfoEdit.jsp?method=insert'>民主监督</a>"
								}
							}else if(communityType=="N"){
								if(cdcReportNoticeDataset.getAt(i).get("DECISION")<=0){
									innerHtml += "<a href ='../manage/decision/vcdcDecisionInfoEdit.jsp?method=insert'>民主决策</a>"
								}
								if(cdcReportNoticeDataset.getAt(i).get("MANAGE")<=0){
									innerHtml += "<a href ='../manage/manage/vcdcManageInfoEdit.jsp?method=insert'>民主管理</a>"
								}
								if(cdcReportNoticeDataset.getAt(i).get("SUPERVISE")<=0){
									innerHtml += "<a href ='../manage/supervise/vcdcSuperviseInfoEdit.jsp?method=insert'>民主监督</a>"
								}
							}
						}	
					}else{
						if(cdcReportNoticeDataset.getAt(i).get("ELECTION")<=0){
							iffinished = false;
							innerHtml+='<b>填报日期：'+cdcReportNoticeDataset.getAt(i).get("REPORT_DATE")+'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;类型：'+cdcReportNoticeDataset.getAt(i).get("REPORTTYPE")+'</b><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;未填报任务：';
							if(communityType=="C"){
								innerHtml += "<a href ='../manage/elect/city/cdcElectionInfoEdit.jsp?method=insert' >民主选举</a>"
							}else if(communityType=="N"){
								innerHtml += "<a href ='../manage/elect/country/cdcElectionInfoEdit.jsp?method=insert' >民主选举</a>"
							}
						}
					}
					innerHtml += "</p>"
				}
			}else {
				for(var i = 0;i<count;i++){
					if((cdcReportNoticeDataset.getAt(i).get("REPORT_ID")=="report2")){
						if(cdcReportNoticeDataset.getAt(i).get("ELECTION")<=0){
							iffinished = false;
							innerHtml+='<b>填报日期：'+cdcReportNoticeDataset.getAt(i).get("REPORT_DATE")+'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;类型：'+cdcReportNoticeDataset.getAt(i).get("REPORTTYPE")+'</b><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;未填报任务：';
							if(communityType=="C"){
								innerHtml += "<a href ='../manage/elect/city/cdcElectionInfoEdit.jsp?method=insert' >民主选举</a>"
							}else if(communityType=="N"){
								innerHtml += "<a href ='../manage/elect/country/cdcElectionInfoEdit.jsp?method=insert' >民主选举</a>"
							}
						}
						innerHtml += "</p>"
					}
				}
			}
			if(iffinished){
				innerHtml += "<d>暂无填报任务</d></p>"
			}
		}
		document.getElementById("lists").innerHTML = innerHtml;
	});
	OrgCodeDataset.setParameter("filterSql","user_id = '"+organCode+"'");
	OrgCodeDataset.load();
	OrgCodeDataset.on("load",function() {
		if(organLevel=="SQ"){
			organCode = OrgCodeDataset.get("text");
			cdcReportNoticeDataset.setParameter("organCode",organCode);
			cdcReportNoticeDataset.setParameter("communityType",communityType);
			cdcReportNoticeDataset.load();
		}else{
			orgCode = OrgCodeDataset.get("text");
			organCode = orgCode.substring(0,9)+"000";
			cdcReportNoticeDataset.setParameter("organCode",organCode);
			cdcReportNoticeDataset.setParameter("organC",orgCode);
			cdcReportNoticeDataset.setParameter("communityType",communityType);
			cdcReportNoticeDataset.load();
		}
	});
	var cdcNoticeDataset=L5.DatasetMgr.lookup("cdcNoticeDataset");
	cdcNoticeDataset.setParameter("organCode",organCode);
	cdcNoticeDataset.setParameter("level",organLevel);
	cdcNoticeDataset.on("load",function(){
		var innerHtml ="<ul id ='pagelist'> ";
		var count = cdcNoticeDataset.getCount();
		if(count>0){
			for(var i = 0;i<count;i++){
				innerHtml+=' <li><a href="javascript:checkOut(\''+cdcNoticeDataset.getAt(i).get("NOTICE_ID")+'\' , \''+
					cdcNoticeDataset.getAt(i).get("FILE_ID") +'\') "><span class="lbt">'+cdcNoticeDataset.getAt(i).get("NAME") +
					'</span><span class="ldt">'+cdcNoticeDataset.getAt(i).get("CREATE_TIME")+'</span></a> </li>';
			}
		}else{
			innerHtml+='  <li> 暂无通知</li>';
		}
		innerHtml+=" </ul>";
		document.getElementById("list").innerHTML = innerHtml;
		
	});
	cdcNoticeDataset.load();
}
function checkOut(noticeId,fileId){
	var cdcNoticeCheckDataset=L5.DatasetMgr.lookup("cdcNoticeCheckDataset");
	cdcNoticeCheckDataset.setParameter("ORGAN_CODE@=",organCode);
	cdcNoticeCheckDataset.setParameter("NOTICE_ID@=",noticeId);
	cdcNoticeCheckDataset.on("load",function(){
		if(cdcNoticeCheckDataset.getCount()<=0){
			cdcNoticeCheckDataset.newRecord({"organCode":organCode,"organName":organName,"noticeId":noticeId,
				"createTime":getCurDate()});
			var record = cdcNoticeCheckDataset.getCurrent();
			var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcNoticeCheckCommand");
			command.setParameter("record",record);
			command.execute("save");
		}
		var data=new L5.Map();
		data.put("noticeId",noticeId);
		data.put("fileId",fileId);
		var url="jsp/ext/cdc/manage/reportAndNotice/cdcNoticeDetail.jsp";
		L5.forward(url,'',data);
	});
	cdcNoticeCheckDataset.load();
}
function report(record,type){
	var flag = 0;
	if(type =="1"){
		if(communityType=="T"){
			flag = record.get("FACILITIES")+record.get("ORGAN1")+record.get("COORDINATE")+
				record.get("PLAN")+record.get("FINANCE")+record.get("SERVICE")+record.get("SERVICEMODE");
			if(Number(flag)<7){
				return true;
			}	
		}else{
			flag = record.get("POPULATE")+record.get("PEOPLE")+record.get("SERVICE")+record.get("FUND")
				+record.get("ECONOMY")+record.get("ORGAN2")+record.get("CONSTRUCT")
				+record.get("NATURE")+record.get("ORGAN1")+record.get("FACILITIES");	
			if(communityType=="N"){
				if(Number(flag)<10){return true;}
			}else{
				if(Number(flag)<8){return true;}
			}
		}
	}else{
		flag = record.get("DECISION")+record.get("MANAGE")+record.get("SUPERVISE");	
			if(Number(flag)<3){return true;}
	}
	return false;
}

function downloadFile(){
	if(organLevel!="JD"){
		return;
	}
	var file = encodeURI(encodeURI("template.rar"));
	var filePath ="jsp/ext/cdc/manage/elect/template/template.rar";
	filePath=encodeURI(encodeURI(filePath));
	var url = L5.webPath + "/fileDownload?project=1&filePath=" + filePath + "&fileName="
			+ file;
	window.location.href = url;
}
	</script>
</html>
