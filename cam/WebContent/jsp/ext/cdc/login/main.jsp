<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ page import="com.inspur.cams.comm.extuser.util.ExtBspInfo"%>
<%@ page import="com.inspur.cams.comm.extuser.data.ComExtUser"%>
<%
	ComExtUser user = ExtBspInfo.getUserInfo(request);
	String communityBelongs = user.getCommunityBelongs();
	String username = user.getUserName();
	String organType = user.getOrganType();
	String communityType = user.getCommunityType();
	String ifVillage = user.getIfVillage();
	String organCode = user.getUserId();
	boolean cityFlag = true;
	boolean villageFlag = true;
	if ("JD".equals(organType)) {
		cityFlag = true;
		villageFlag = true;
	} else {
		if ("C".equals(communityType)) {
			cityFlag = true;
			villageFlag = false;
		} else if ("N".equals(communityType)) {
			cityFlag = false;
			villageFlag = true;
		}
	}
%>
<html>
<head>
<link rel="shortcut icon" href="jsp/favicon.ico" type="image/x-icon"/>
<title>基层政权与社区建设管理信息系统</title>
<next:ScriptManager/>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/ext/cdc/login/index.css"/>
<script type="text/javascript">
var xmlHttp;
function createXMLHttpRequest(){
	if(window.ActiveXObject){
		xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
	}else if (window.XMLHttpRequest){
		xmlHttp = new XMLHttpRequest();
	}
}
function startRequest(url){
	createXMLHttpRequest();
	xmlHttp.open("GET", url, false);
	xmlHttp.send(null);
	return xmlHttp.responseText;
}
function menuClick(title,pageName){
	var url='jsp/ext/cdc/manage/'+pageName+'.jsp';	
	loadPage(title,url);
}
//页面加载时候使用的加载loading展现。
function loadPage(title,url){
	var tabs=L5.getCmp('center');
	var panel = tabs.getItem(0);
	if(title)panel.setTitle(title);
	var iframes=panel.body.query('iframe');
	var loading=L5.fly('loadmask',panel.body);
	loading.setStyle("display","block");
	iframes[0].style.visibility="hidden";
	iframes[0].onload=iframes[0].onreadystatechange=function(){
	if(this.readyState=="complete"||!this.readyState){
		(function(){
			iframes[0].style.visibility="visible";
			loading.dom.style.display="none";
		}).defer(50);
		}
	}
	if(url.indexOf("http")==0||url.indexOf("www")>=0)
	     iframes[0].src=url;
	else
		iframes[0].src=L5.webPath+"/"+url;
}
function logout(){
    if(!confirm("您确定要退出系统吗？")) return;
	document.location.href=L5.webPath+"/camsext_logout?loginType=cdc";
}
function head(){
	var tabPanel=L5.getCmp('center');
	var panel = tabPanel.getItem(0);
	panel.setTitle("首页");
	var iframes=panel.body.query('iframe');
	iframes[0].src=L5.webPath+"/jsp/ext/cdc/login/head.jsp";
}
//top上面菜单的点击事件。
function topclick(link){
	L5.fly("menu").child(".selected").removeClass("selected");
	L5.fly(link).parent(".item").addClass("selected");
	var tree = L5.getCmp("tree");
	tree.innerCt.setVisible(false);
	tree.setRootNode(rootData.getAt(link.id));
	tree.innerCt.slideIn('t', {duration:.30,easing:'easeIn'});
}

</script>
</head>
<body>
<next:ViewPort id="viewport">
<next:BorderLayout>
<next:Top>
<next:Panel autoHeight="true" autoScroll="false" id="top">
	<next:Html>
		<div id="nomenu">
			<div class="left"></div>
			<div class="center">
				<div class="pics"></div>
			</div>
			<div class="right">
				<div class="right1"></div>
				<div class="right2">
					<div class="pics">
						<div class="top"></div>
						<a hidefocus="true" href="javascript:head()">首页</a>
						<div class="sys"></div>
						<a hidefocus="true" href="#">消息</a>
						<div class="out"></div>
						<a hidefocus="true" href="javascript:logout()">注销</a>
					</div>
					<p align="right"><font color="white">当前登录单位：<%=username%></font></p>
				</div>
			</div>
		</div>
	</next:Html>
</next:Panel>
</next:Top>
<next:Left split="true">
<next:Panel id="leftPanel" width="200" bodyStyle="background-color:#DFE8F6;overflow-y:auto;overflow-x:hidden" collapsible="true" title="功能导航">
<next:AccordionLayout>
<% if(cityFlag){ %>
<next:Panel title="社区基本信息" bodyStyle="background-color:#DFE8F6;overflow-y:auto;overflow-x:hidden">
<next:Html>
	<!-- 
	"C".equals(communityType)
	<table class="menuTable">
		<tr>
			<td onclick="menuClick('社区居委会下属委员会成员基本情况','peopleInfo/cdcPeopleInfoUnderingList')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>下属委员会成员基本情况</p></td>
		</tr>
	</table>
	<table class="menuTable">
		<tr>
			<td onclick="menuClick('社区居民小组长、楼长基本情况','peopleInfo/cdcPeopleInfoHeadManList')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>居民小组长、楼长基本情况</p></td>
		</tr>
	</table>
	<table class="menuTable">
		<tr>
			<td onclick="menuClick('社区家庭情况','basePeople/cdcBaseinfoFamilyList')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>社区家庭情况</p></td>
		</tr>
	</table>
	 -->
	<% if("C".equals(communityType)){ %>
	<table class="menuTable">
		<tr>
			<td onclick="menuClick('社区居委会成员基本情况','peopleInfo/cdcPeopleInfoCommitteeList')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>社区居委会成员基本情况</p></td>
		</tr>
	</table>
	<table class="menuTable">
		<tr>
			<td onclick="menuClick('党组织成员基本情况','peopleInfo/cdcPeopleInfoPartyList')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>党组织成员基本情况</p></td>
		</tr>
	</table>
	<table class="menuTable">
		<tr>
			<td onclick="menuClick('社区工作者基本情况','peopleInfo/cdcPeopleInfoWorkerList')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>社区工作者基本情况</p></td>
		</tr>
	</table>
	<table class="menuTable">
		<tr>
			<td onclick="menuClick('社区共建单位','buildOrganInfo/cdcOrganInfoList')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>社区共建单位</p></td>
		</tr>
	</table>
	<%} %>
	<table class="menuTable">
		<tr>
			<td onclick="menuClick('社区社会组织','organInfo/cdcOrganInfoList')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>社区社会组织</p></td>
		</tr>
	</table>
</next:Html>
</next:Panel>
<%} %>
<% if(cityFlag){ %>
<next:Panel title="城市社区填报信息" bodyStyle="background-color:#DFE8F6;overflow-y:auto;overflow-x:hidden">
<next:Html>
	<table class="menuTable">
		<tr>
			<td onclick="menuClick('人口状况','populate/cdcPopulateInfoList')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>人口状况</p></td>
		</tr>
	</table>
	<table class="menuTable">
		<tr>
			<td onclick="menuClick('人员信息','people/cdcPeopleReportList')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>人员信息</p></td>
		</tr>
	</table>
	<table class="menuTable">
		<tr>
			<td onclick="menuClick('社区综合服务设施','facilities/cdcFacilitiesReportList')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>社区综合服务设施</p></td>
		</tr>
	</table>
	<table class="menuTable">
		<tr>
			<td onclick="menuClick('社区服务情况','service/cdcServiceInfoList')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>社区服务情况</p></td>
		</tr>
	</table>
	<table class="menuTable">
		<tr>
			<td onclick="menuClick('社区经费情况','fund/cdcFundInfoList')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>社区经费情况</p></td>
		</tr>
	</table>
	<table class="menuTable">
		<tr>
			<td onclick="menuClick('社区资产状况','economy/cdcEconomyInfoList')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>社区资产状况</p></td>
		</tr>
	</table>
	<table class="menuTable">
		<tr>
			<td onclick="menuClick('社区社会组织','organ/cdcOrganInfoList')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>社区社会组织</p></td>
		</tr>
	</table>
	<table class="menuTable">
		<tr>
			<td onclick="menuClick('社区管理与共建','organ/cdcAdminInfoList')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>社区管理与共建</p></td>
		</tr>
	</table>
	<table class="menuTable">
		<tr>
			<td onclick="menuClick('城市物业情况','tenement/cdcTenementInfoList')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>城市社区物业情况</p></td>
		</tr>
	</table>
</next:Html>
</next:Panel>
<% } %>
<% if("N".equals(communityType)){ %>
<next:Panel title="社区基本信息" bodyStyle="background-color:#DFE8F6;overflow-y:auto;overflow-x:hidden">
<next:Html>
	<table class="menuTable">
		<tr>
			<td onclick="menuClick('社区村委会成员基本情况','peopleInfo/cdcPeopleInfoCommitteeList')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>社区村委会成员基本情况</p></td>
		</tr>
	</table>
	<!-- 
	<table class="menuTable">
		<tr>
			<td onclick="menuClick('社区居委会下属委员会成员基本情况','peopleInfo/cdcPeopleInfoUnderingList')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>下属委员会成员基本情况</p></td>
		</tr>
	</table>
	<table class="menuTable">
		<tr>
			<td onclick="menuClick('社区居民小组长、楼长基本情况','peopleInfo/cdcPeopleInfoHeadManList')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>村民小组长、楼长基本情况</p></td>
		</tr>
	</table>
	<table class="menuTable">
		<tr>
			<td onclick="menuClick('社区家庭情况','basePeople/cdcBaseinfoFamilyList')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>社区家庭情况</p></td>
		</tr>
	</table>
	 -->
	<table class="menuTable">
		<tr>
			<td onclick="menuClick('社区工作者基本情况','peopleInfo/cdcPeopleInfoWorkerList')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>社区工作者基本情况</p></td>
		</tr>
	</table>
	<table class="menuTable">
		<tr>
			<td onclick="menuClick('社区社会组织','organInfo/cdcOrganInfoList')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>社区社会组织</p></td>
		</tr>
	</table>
	<table class="menuTable">
		<tr>
			<td onclick="menuClick('社区共建单位','buildOrganInfo/cdcOrganInfoList')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>社区共建单位</p></td>
		</tr>
	</table>
	<% if("1".equals(ifVillage)){ %>
	<table class="menuTable">
		<tr>
			<td onclick="menuClick('农村社区下辖村情况基本信息','underGovemnsInfo/cdcundergovemnsinfo_list')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>农村社区下辖村情况基本信息</p></td>
		</tr>
	</table>
	<% } %>
</next:Html>
</next:Panel>
<% } %>
<% if(villageFlag&&(communityBelongs.equals(organCode))){ %>
<next:Panel title="农村社区填报信息" bodyStyle="background-color:#DFE8F6;overflow-y:auto;overflow-x:hidden">
<next:Html>
	<table class="menuTable">
		<tr>
			<td onclick="menuClick('人口状况','populate/vcdcPopulateInfoList')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>人口状况</p></td>
		</tr>
	</table>
	<table class="menuTable">
		<tr>
			<td onclick="menuClick('农村社区自然状况','natural/vcdcNaturalList')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>自然状况</p></td>
		</tr>
	</table>
	<table class="menuTable">
		<tr>
			<td onclick="menuClick('人员信息','people/vcdcPeopleReportList')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>人员信息</p></td>
		</tr>
	</table>
	<table class="menuTable">
		<tr>
			<td onclick="menuClick('社区综合服务设施','facilities/vcdcFacilitiesReportList')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>社区综合服务设施</p></td>
		</tr>
	</table>
	<table class="menuTable">
		<tr>
			<td onclick="menuClick('社区服务情况','service/vcdcServiceInfoList')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>社区服务情况</p></td>
		</tr>
	</table>
	<table class="menuTable">
		<tr>
			<td onclick="menuClick('社区经费情况','fund/vcdcFundInfoList')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>社区经费情况</p></td>
		</tr>
	</table>
	<table class="menuTable">
		<tr>
			<td onclick="menuClick('社区资产状况','economy/vcdcEconomyInfoList')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>村（社区）资产状况</p></td>
		</tr>
	</table>
	<table class="menuTable">
		<tr>
			<td onclick="menuClick('社区社会组织','organ/vcdcOrganInfoList')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>社区社会组织</p></td>
		</tr>
	</table>
	<table class="menuTable">
		<tr>
			<td onclick="menuClick('社区管理与共建','organ/vcdcAdminInfoList')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>社区管理与共建</p></td>
		</tr>
	</table>
	<table class="menuTable">
		<tr>
			<td onclick="menuClick('社区规划','construct/vcdcConstructInfoList')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>社区规划</p></td>
		</tr>
	</table>
</next:Html>
</next:Panel>
<% } %>
<next:Panel title="民主选举" bodyStyle="background-color:#DFE8F6;overflow-y:auto;overflow-x:hidden">
<next:Html>
	<table class="menuTable">
	<% if(cityFlag){ %>
		<tr>
			<td onclick="menuClick('城市民主选举情况','elect/city/cdcElectionList')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>城市民主选举情况</p></td>
		</tr>
		<% } %>
		<% if(villageFlag){ %>
		<tr>
			<td onclick="menuClick('农村民主选举情况','elect/country/cdcElectionList')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>农村民主选举情况</p></td>
		</tr>
		<% } %>
		</table>
</next:Html>
</next:Panel>
<% if((communityBelongs.equals(organCode))){ %>
<next:Panel title="民主决策" bodyStyle="background-color:#DFE8F6;overflow-y:auto;overflow-x:hidden">
<next:Html>
	<table class="menuTable">
		<% if(cityFlag){ %>
		<tr>
			<td onclick="menuClick('城市民主决策情况','decision/cdcDecisionInfoList')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>城市民主决策情况</p></td>
		</tr>
		<% } %>
		<% if(villageFlag){ %>
		<tr>
			<td onclick="menuClick('农村民主决策情况','decision/vcdcDecisionInfoList')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>农村民主决策情况</p></td>
		</tr>
		<% } %>
	</table>
</next:Html>
</next:Panel>
<next:Panel title="民主管理" bodyStyle="background-color:#DFE8F6;overflow-y:auto;overflow-x:hidden">
<next:Html>
	<table class="menuTable">
		<% if(cityFlag){ %>
		<tr>
			<td onclick="menuClick('城市民主管理情况','manage/cdcManageInfoList')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>城市民主管理情况</p></td>
		</tr>
		<% } %>
		<% if(villageFlag){ %>
		<tr>
			<td onclick="menuClick('农村民主管理情况','manage/vcdcManageInfoList')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>农村民主管理情况</p></td>
		</tr>
		<% } %>
	</table>
</next:Html>
</next:Panel>
<next:Panel title="民主监督" bodyStyle="background-color:#DFE8F6;overflow-y:auto;overflow-x:hidden">
<next:Html>
	<table class="menuTable">
		<% if(cityFlag){ %>
		<tr>
			<td onclick="menuClick('城市民主监督情况','supervise/cdcSuperviseInfoList')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>城市民主监督情况</p></td>
		</tr>
		<% } %>
		<% if(villageFlag){ %>
		<tr>
			<td onclick="menuClick('农村民主监督情况','supervise/vcdcSuperviseInfoList')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>农村民主监督情况</p></td>
		</tr>
		<% } %>
	</table>
</next:Html>
</next:Panel>
<% if (!("SQ".equals(organType))){ %>
<next:Panel title="社区建设" bodyStyle="background-color:#DFE8F6;overflow-y:auto;overflow-x:hidden">
<next:Html>

	<table class="menuTable">
		<tr>
			<td onclick="menuClick('农村社区建设领导协调机制','coordinate/vcdcCoordinateInfoList')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>农村社区建设领导协调机制</p></td>
		</tr>
		<tr>
			<td onclick="menuClick('农村社区建设规划','plan/vcdcPlanInfoList')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>农村社区建设规划</p></td>
		</tr>
		<tr>
			<td onclick="menuClick('经济基本情况','finance/vcdcFinanceInfoList')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>经济基本情况</p></td>
		</tr>
		<tr>
			<td onclick="menuClick('社区服务设施','servicefacilities/vcdcServiceFacilitiesList')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>社区服务设施</p></td>
		</tr>
		<tr>
			<td onclick="menuClick('社区服务情况','ownService/vcdcServiceInfoList')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>社区服务情况</p></td>
		</tr>
	</table>
</next:Html>
</next:Panel>
<% } %>
<next:Panel title="志愿者" bodyStyle="background-color:#DFE8F6;overflow-y:auto;overflow-x:hidden">
<next:Html>
	<table class="menuTable">
		<tr>
			<td onclick="menuClick('注册志愿者信息','voluntary/cdcVoluntaryInfoList')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>注册志愿者信息</p></td>
		</tr>
	</table>
	<table class="menuTable">
		<tr>
			<td onclick="menuClick('志愿者活动','voluntary/cdcVoluntaryCaperInfoList')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>志愿者活动</p></td>
		</tr>
	</table>
</next:Html>
</next:Panel>
<next:Panel title="工作与信息交流" bodyStyle="background-color:#DFE8F6;overflow-y:auto;overflow-x:hidden">
<next:Html>
	<table class="menuTable">
		<tr>
			<td onclick="menuClick('社区工作图片展示','pic/cdcPicInfoShow')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>社区工作图片展示</p></td>
		</tr>
	</table>
	<table class="menuTable">
		<tr>
			<td onclick="menuClick('工作简报','workbrief/cdcWorkBriefList')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>工作简报</p></td>
		</tr>
	</table>
	<table class="menuTable">
		<tr>
			<td onclick="menuClick('工作计划','workplan/cdcWorkPlanList')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>工作计划</p></td>
		</tr>
	</table>
	<table class="menuTable">
		<tr>
			<td onclick="menuClick('通讯录','maillist/cdcMailListList')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>通讯录</p></td>
		</tr>
	</table>
	<table class="menuTable">
		<tr>
			<td onclick="menuClick('通知公告','reportAndNotice/cdcNoticeManage')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>通知公告</p></td>
		</tr>
	</table>
	<table class="menuTable">
		<tr>
			<td onclick="menuClick('申报材料','reportAndNotice/cdcReportManage')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>申报材料</p></td>
		</tr>
	</table>
</next:Html>
</next:Panel>
<% } %>
<next:Panel title="系统管理" bodyStyle="background-color:#DFE8F6;overflow-y:auto;overflow-x:hidden">
<next:Html>
	<table class="menuTable">
		<tr>
			<td onclick="loadPage('系统设置','jsp/ext/cdc/manage/loginUser/loginUserDetail.jsp')"  class="menuTd">
			<img src="images/system.png" class="menuImg"><p>系统设置</p></td>
		</tr>
	</table>
	<%if("JD".equals(organType)){%>
	<table class="menuTable">
		<tr>
			<td onclick="loadPage('社区账号管理','jsp/ext/cdc/users/createUsers.jsp')"  class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>社区账号管理</p></td>
		</tr>
	</table>
	<table class="menuTable">
		<tr>
			<td onclick="loadPage('账号导出','jsp/ext/cdc/users/accountList.jsp')"  class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>账号导出</p></td>
		</tr>
	</table>
	<%} %>
	<table class="menuTable">
		<tr>
			<td onclick="javascript:logout();" class="menuTd">
			<img src="images/log_off.png" class="menuImg"><p>注销</p></td>
		</tr>
	</table>
</next:Html>
</next:Panel>
</next:AccordionLayout>
</next:Panel>
</next:Left>
<next:Center>
<next:TabPanel id="center" enableTabScroll="true" activeTab="0">
	<next:Tabs>
		<next:Panel title="首页" closable="false" autoScroll="false">
			<next:Html>
				<div id="loadmask" style="display: none;" class="loading">
					<img src="<%=request.getContextPath()%>/skins/images/default/extanim32.gif"
						width="32" height="32" style="margin-right: 8px;"/>正在加载...</div>
					<iframe id="frame1" frameborder="no" border="0" marginwidth="0"
						marginheight="0" allowtransparency="yes" width="100%"
						style="overflow: auto" height="100%"
						src="<%=request.getContextPath()%>/jsp/ext/cdc/login/head.jsp"></iframe>
			</next:Html>
		</next:Panel>
	</next:Tabs>
</next:TabPanel>
</next:Center>
</next:BorderLayout>
</next:ViewPort>
<script for="window" event="onbeforeunload">
if(document.body.clientWidth-event.clientX<170&&event.clientY< 0||event.altKey){
	startRequest(L5.webPath+"/camsext_logout?loginType=cdc");
}
</script>
</body>
</html>