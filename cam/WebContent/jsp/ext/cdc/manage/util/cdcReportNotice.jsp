<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<head>
<style type="text/css">
	#eMeng a {text-decoration:none;color: blue;}
	#eMeng a:visited {text-decoration:none; color: blue;}
</style>
</head>
<model:datasets>
<model:dataset id="cdcReportNoticeDataset" cmd="com.inspur.cams.cdc.base.cmd.CdcNoticeQueryCmd" method="query">
	</model:dataset>
</model:datasets>
<script type="text/javascript">
	window.onresize = resizeDiv;
	window.onerror = function(){}

	function ifReport(record,type){
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

	//短信提示使用(asilas添加)
	var divTop,divLeft,divWidth,divHeight,docHeight,docWidth,objTimer;
	function getMsg(){
		try{
			var innerHtml = "";
			var OrgCodeDataset = L5.DatasetMgr.lookup("OrgCodeDataset");
			var cdcReportNoticeDataset = L5.DatasetMgr.lookup("cdcReportNoticeDataset");
			cdcReportNoticeDataset.on("load",function(){
				innerHtml+='<TABLE style="BORDER-TOP: #ffffff 1px solid; BORDER-LEFT: #ffffff 1px solid" cellSpacing=0 cellPadding=0 width="100%" bgColor=#cfdef4 border=0>'
				innerHtml+='<TR><TD style="FONT-SIZE: 12px; BACKGROUND-IMAGE: url(msgTopBg.gif); COLOR: #0f2c8c" width=30 height=24></TD>'
				innerHtml+='<TD style="FONT-WEIGHT: normal; FONT-SIZE: 12px; BACKGROUND-IMAGE: url(msgTopBg.gif); COLOR: #1f336b; PADDING-TOP: 4px;PADDING-left: 4px" vAlign=center width="100%"> 未完成任务：</TD>'
				innerHtml+='<TD style="BACKGROUND-IMAGE: url(msgTopBg.gif); PADDING-TOP: 2px;PADDING-right:2px" vAlign=center align=right width=19>'+
					'<span title=关闭 style="CURSOR: hand;color:red;font-size:12px;font-weight:bold;margin-right:4px;" onclick=closeDiv() >×</span></TD></TR>';
				innerHtml+='<TR><TD style="PADDING-RIGHT: 1px; BACKGROUND-IMAGE: url(1msgBottomBg.jpg); PADDING-BOTTOM: 1px" colSpan=3 height=120>';
				innerHtml+='<DIV  class="div" style="BORDER-RIGHT: #b9c9ef 1px solid; PADDING-RIGHT: 13px; BORDER-TOP: #728eb8 1px solid; PADDING-LEFT: 13px; FONT-SIZE: 12px; PADDING-BOTTOM: 13px; BORDER-LEFT: #728eb8 1px solid; WIDTH: 100%; COLOR: #1f336b; PADDING-TOP: 18px; BORDER-BOTTOM: #b9c9ef 1px solid; HEIGHT: 100%">';
				
				var count = cdcReportNoticeDataset.getCount();
				if(count>0){
					for(var i = 0;i<count;i++){
						if(cdcReportNoticeDataset.getAt(i).get("REPORT_ID")=="report1"){
							if(ifReport(cdcReportNoticeDataset.getAt(i),"1")){
								innerHtml+='<h1>填报日期：'+cdcReportNoticeDataset.getAt(i).get("REPORT_DATE")+'</h1><p>未填报任务:';
								if(communityType=="C"){
									if(cdcReportNoticeDataset.getAt(i).get("POPULATE")<=0){
										innerHtml += "<a href ='../../manage/populate/cdcPopulateInfoEdit.jsp?method=insert'>人口状况</a>&nbsp;&nbsp;"
									}
									if(cdcReportNoticeDataset.getAt(i).get("PEOPLE")<=0){
										innerHtml += "<a href ='../../manage/people/cdcPeopleReportEdit.jsp?method=insert'>人员信息</a>&nbsp;&nbsp;"
									}
									if(cdcReportNoticeDataset.getAt(i).get("FACILITIES")<=0){
										innerHtml += "<a href ='../../manage/facilities/cdcFacilitiesReportEdit.jsp?method=insert'>基础设施</a>&nbsp;&nbsp;"
									}
									if(cdcReportNoticeDataset.getAt(i).get("SERVICE")<=0){
										innerHtml += "<a href ='../../manage/service/cdcServiceInfoEdit.jsp?method=insert'>社区服务</a>&nbsp;&nbsp;"
									}
									if(cdcReportNoticeDataset.getAt(i).get("FUND")<=0){
										innerHtml += "<a href ='../../manage/fund/cdcFundInfoEdit.jsp?method=insert'>社区经费</a>&nbsp;&nbsp;"
									}
									if(cdcReportNoticeDataset.getAt(i).get("ECONOMY")<=0){
										innerHtml += "<a href ='../../manage/economy/cdcEconomyInfoEdit.jsp?method=insert'>社区资产</a>&nbsp;&nbsp;"
									}
									if(cdcReportNoticeDataset.getAt(i).get("ORGAN1")<=0){
										innerHtml += "<a href ='../../manage/organ/cdcOrganInfoEdit.jsp?method=insert'>民间组织</a>&nbsp;&nbsp;"
									}
									if(cdcReportNoticeDataset.getAt(i).get("ORGAN2")<=0){
										innerHtml += "<a href ='../../manage/organ/cdcAdminInfoEdit.jsp?method=insert'>社区管理与共建</a>&nbsp;&nbsp;"
									}
								}else if(communityType=="N"){
									if(cdcReportNoticeDataset.getAt(i).get("POPULATE")<=0){
										innerHtml += "<a href ='../../manage/populate/vcdcPopulateInfoEdit.jsp?method=insert'>人口状况</a>&nbsp;&nbsp;"
									}
									if(cdcReportNoticeDataset.getAt(i).get("NATURE")<=0){
										innerHtml += "<a href ='../../manage/natural/vcdcNaturalInfoEdit.jsp?method=insert'>自然状况</a>&nbsp;&nbsp;"
									}
									if(cdcReportNoticeDataset.getAt(i).get("PEOPLE")<=0){
										innerHtml += "<a href ='../../manage/people/vcdcPeopleReportEdit.jsp?method=insert'>人员信息</a>&nbsp;&nbsp;"
									}
									if(cdcReportNoticeDataset.getAt(i).get("FACILITIES")<=0){
										innerHtml += "<a href ='../../manage/facilities/vcdcFacilitiesReportEdit.jsp?method=insert'>基础设施</a>&nbsp;&nbsp;"
									}
									if(cdcReportNoticeDataset.getAt(i).get("SERVICE")<=0){
										innerHtml += "<a href ='../../manage/service/vcdcServiceInfoEdit.jsp?method=insert'>社区服务</a>&nbsp;&nbsp;"
									}
									if(cdcReportNoticeDataset.getAt(i).get("FUND")<=0){
										innerHtml += "<a href ='../../manage/fund/vcdcFundInfoEdit.jsp?method=insert'>社区经费</a>&nbsp;&nbsp;"
									}
									if(cdcReportNoticeDataset.getAt(i).get("ECONOMY")<=0){
										innerHtml += "<a href ='../../manage/economy/vcdcEconomyInfoEdit.jsp?method=insert'>社区资产</a>&nbsp;&nbsp;"
									}
									if(cdcReportNoticeDataset.getAt(i).get("ORGAN1")<=0){
										innerHtml += "<a href ='../../manage/organ/vcdcOrganInfoEdit.jsp?method=insert'>民间组织</a>&nbsp;&nbsp;"
									}
									if(cdcReportNoticeDataset.getAt(i).get("ORGAN2")<=0){
										innerHtml += "<a href ='../../manage/organ/vcdcAdminInfoEdit.jsp?method=insert'>社区管理与共建</a>&nbsp;&nbsp;"
									}
									if(cdcReportNoticeDataset.getAt(i).get("CONSTRUCT")<=0){
										innerHtml += "<a href ='../../manage/construct/vcdcConstructInfoEdit.jsp?method=insert'>社区规划</a>&nbsp;&nbsp;"
									}
								}else{
									if(cdcReportNoticeDataset.getAt(i).get("FACILITIES")<=0){
										innerHtml += "<a href ='../../manage/facilities/cdcOwnFacilitiesReportEdit.jsp?method=insert'>城市社区基础设施</a>&nbsp;&nbsp;"
									}
									if(cdcReportNoticeDataset.getAt(i).get("ORGAN1")<=0){
										innerHtml += "<a href ='../../manage/organ/cdcOrganInfoEdit.jsp?method=insert'>城市社区民间组织</a>&nbsp;&nbsp;"
									}
									if(cdcReportNoticeDataset.getAt(i).get("COORDINATE")<=0){
										innerHtml += "<a href ='../../manage/coordinate/vcdcCoordinateInfoEdit.jsp?method=insert'>农村社区领导协调机制</a>&nbsp;&nbsp;"
									}
									if(cdcReportNoticeDataset.getAt(i).get("PLAN")<=0){
										innerHtml += "<a href ='../../manage/plan/vcdcPlanInfoEdit.jsp?method=insert'>农村社区建设规划</a>&nbsp;&nbsp;"
									}
									if(cdcReportNoticeDataset.getAt(i).get("FINANCE")<=0){
										innerHtml += "<a href ='../../manage/finance/vcdcFinanceInfoEdit.jsp?method=insert'>农村社区经济基本情况</a>&nbsp;&nbsp;"
									}
									if(cdcReportNoticeDataset.getAt(i).get("SERVICE")<=0){
										innerHtml += "<a href ='../../manage/servicefacilities/vcdcServiceFacilitiesEdit.jsp?method=insert'>农村社区服务设施</a>&nbsp;&nbsp;"
									}
									if(cdcReportNoticeDataset.getAt(i).get("SERVICEMODE")<=0){
										innerHtml += "<a href ='../../manage/ownService/vcdcServiceInfoEdit.jsp?method=insert'>农村社区服务情况</a>&nbsp;&nbsp;"
									}
								}
							}
						}else if(cdcReportNoticeDataset.getAt(i).get("REPORT_ID")=="report3"){
							if(ifReport(cdcReportNoticeDataset.getAt(i),"3")){
								innerHtml+='<h1>填报日期：'+cdcReportNoticeDataset.getAt(i).get("REPORT_DATE")+'</h1><p>未填报任务:';
								if(communityType=="C"){
									if(cdcReportNoticeDataset.getAt(i).get("DECISION")<=0){
										innerHtml += "<a href ='../../manage/decision/cdcDecisionInfoEdit.jsp?method=insert'>民主决策</a>&nbsp;&nbsp;"
									}
									if(cdcReportNoticeDataset.getAt(i).get("MANAGE")<=0){
										innerHtml += "<a href ='../../manage/manage/cdcManageInfoEdit.jsp?method=insert'>民主管理</a>&nbsp;&nbsp;"
									}
									if(cdcReportNoticeDataset.getAt(i).get("SUPERVISE")<=0){
										innerHtml += "<a href ='../../manage/supervise/cdcSuperviseInfoEdit.jsp?method=insert'>民主监督</a>&nbsp;&nbsp;"
									}
								}else if(communityType=="N"){
									if(cdcReportNoticeDataset.getAt(i).get("DECISION")<=0){
										innerHtml += "<a href ='../../manage/decision/vcdcDecisionInfoEdit.jsp?method=insert'>民主决策</a>&nbsp;&nbsp;"
									}
									if(cdcReportNoticeDataset.getAt(i).get("MANAGE")<=0){
										innerHtml += "<a href ='../../manage/manage/vcdcManageInfoEdit.jsp?method=insert'>民主管理</a>&nbsp;&nbsp;"
									}
									if(cdcReportNoticeDataset.getAt(i).get("SUPERVISE")<=0){
										innerHtml += "<a href ='../../manage/supervise/vcdcSuperviseInfoEdit.jsp?method=insert'>民主监督</a>&nbsp;&nbsp;"
									}
								}
							}	
						}else{
							if(cdcReportNoticeDataset.getAt(i).get("ELECTION")<=0){
								innerHtml+='<h1>填报日期：'+cdcReportNoticeDataset.getAt(i).get("REPORT_DATE")+'</h1><p>未填报任务:';
								if(communityType=="C"){
									innerHtml += "<a href ='../../manage/elect/city/cdcElectionInfoEdit.jsp?method=insert' >民主选举</a>&nbsp&nbsp"
								}else if(communityType=="N"){
									innerHtml += "<a href ='../../manage/elect/country/cdcElectionInfoEdit.jsp?method=insert' >民主选举</a>&nbsp&nbsp"
								}
							}
						}
						innerHtml += '</p>';
					}
					innerHtml += '<DIV align=center style="word-break:break-all"></DIV></DIV></TD></TR></TABLE>'; 
					document.getElementById("eMeng").innerHTML= innerHtml;
				}
			});
			
			
			OrgCodeDataset.setParameter("filterSql","user_id = '"+organCode+"'");
			OrgCodeDataset.load();
			OrgCodeDataset.on("load",function() {
				if(organLevel=="SQ"){
					cdcReportNoticeDataset.setParameter("organCode",organCode);
					cdcReportNoticeDataset.setParameter("communityType",communityType);
					cdcReportNoticeDataset.load();
				}else{
					orgCode = OrgCodeDataset.get("text");
					cdcReportNoticeDataset.setParameter("organCode",organCode);
					cdcReportNoticeDataset.setParameter("organC",orgCode);
					cdcReportNoticeDataset.setParameter("communityType",communityType);
					cdcReportNoticeDataset.load();
				}
			});
			divTop = parseInt(document.getElementById("eMeng").style.top,10);
			divLeft = parseInt(document.getElementById("eMeng").style.left,10);
			divHeight = parseInt(document.getElementById("eMeng").offsetHeight,10);
			divWidth = parseInt(document.getElementById("eMeng").offsetWidth,10);
			docWidth = document.body.clientWidth;
			docHeight = document.body.clientHeight;
			document.getElementById("eMeng").style.top = parseInt(document.body.scrollTop,10) + docHeight + 10;//  divHeight
			document.getElementById("eMeng").style.left = parseInt(document.body.scrollLeft,10) + docWidth - divWidth;
			document.getElementById("eMeng").style.visibility="visible";
			objTimer = window.setInterval("moveDiv()",10);
		}
		catch(e){}
	} 
	function resizeDiv(){
		try{
			divHeight = parseInt(document.getElementById("eMeng").offsetHeight,10);
			divWidth = parseInt(document.getElementById("eMeng").offsetWidth,10);
			docWidth = document.body.clientWidth;
			docHeight = document.body.clientHeight;
			document.getElementById("eMeng").style.top = docHeight - divHeight + parseInt(document.body.scrollTop,10);
			document.getElementById("eMeng").style.left = docWidth - divWidth + parseInt(document.body.scrollLeft,10);
			setTimeout("closeDiv()",60000);
		}
		catch(e){}
	}
	function moveDiv(){
		try{
			if(parseInt(document.getElementById("eMeng").style.top,10) <= (docHeight - divHeight + parseInt(document.body.scrollTop,10))){
				window.clearInterval(objTimer);
				objTimer = window.setInterval("resizeDiv()",10);
			}
			divTop = parseInt(document.getElementById("eMeng").style.top,10);
			document.getElementById("eMeng").style.top = divTop - 4;
		}
		catch(e){
		}
	}

	function closeDiv(){
		document.getElementById('eMeng').style.visibility='hidden';
		if(objTimer) window.clearInterval(objTimer)
	}
</script>
<body>
<DIV id=eMeng style="BORDER-RIGHT: #455690 1px solid; BORDER-TOP: #a6b4cf 1px solid; Z-INDEX:99999; LEFT: 0px; VISIBILITY: hidden; BORDER-LEFT: #a6b4cf 1px solid; WIDTH: 340px; BORDER-BOTTOM: #455690 1px solid; POSITION: absolute; TOP: 0px; HEIGHT: 120px; BACKGROUND-COLOR: #c9d3f3">
</DIV>
</body>