<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="com.inspur.cams.sorg.online.extuser.util.SomExtBspInfo"%>
<%@ page import="com.inspur.cams.comm.extuser.data.ComExtUser"%>
<%@ page import="com.inspur.cams.sorg.util.ApplyType"%>
<html>
<head>
<link rel="shortcut icon" href="jsp/favicon.ico" type="image/x-icon"/>
<title>民间组织网上填报系统</title>
<next:ScriptManager/>
<script type="text/javascript" src="direction.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/ext/somsd/login/index.css"/>
<script type="text/javascript">
<%
	ComExtUser comExtUser = (ComExtUser)SomExtBspInfo.getUserInfo(request).getComExtUser();
	String username = comExtUser.getUserName();
	String organArea = comExtUser.getAreaCode();//获取外部单位行政区划12位
	String organType = comExtUser.getOrganType();//获取外部单位的类型 ST:社团  MF:民非  JJ：基金会
	String menuInfo = SomExtBspInfo.getUserInfo(request).getMenuInfo();
	String[] menuInfoArr;
	if(menuInfo != null){
		menuInfoArr = menuInfo.split(",");
	}else{
		menuInfoArr = new String[0];
	}
	Boolean ifHasCheck = false;
%>
var organArea='<%=organArea%>';
var organType='<%=organType%>';
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
	document.location.href=L5.webPath+"/camsext_logout?loginType=somsd";
}
function head(){
	var tabPanel=L5.getCmp('center');
	var panel = tabPanel.getItem(0);
	panel.setTitle("首页");
	var iframes=panel.body.query('iframe');
	iframes[0].src=L5.webPath+"/jsp/ext/somsd/login/head.jsp";
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
<next:Panel id="leftPanel" width="210" bodyStyle="background-color:#DFE8F6;overflow-y:auto;overflow-x:hidden" collapsible="true" title="功能导航">
<next:AccordionLayout>
	<% for(int i = 0;i<menuInfoArr.length;i++){%>
		<%if(menuInfoArr[i].equals(ApplyType.SOM_GROUP_YEAR_CHECK)||menuInfoArr[i].equals(ApplyType.SOM_FUND_YEAR_CHECK)||menuInfoArr[i].equals(ApplyType.SOM_UNGOV_YEAR_CHECK)){%>
			<next:Panel title="网上年检" bodyStyle="background-color:#DFE8F6;overflow-y:auto;overflow-x:hidden">
				<next:Html>
					<table class="menuTable">
						<% if("ST".equals(organType)){ %>
							<tr>
								<td onclick="menuClick('网上年检','014')" class="menuTd">
								<img src="images/balance.png" class="menuImg"><p>网上年检</p></td>
							</tr>

						<% }else if("JJ".equals(organType)) { %>
							<tr>
								<td onclick="menuClick('网上年检','214')" class="menuTd">
								<img src="images/balance.png" class="menuImg"><p>网上年检</p></td>
							</tr>
						<% }else if("MF".equals(organType)){ %>
							<tr>
								<td onclick="menuClick('网上年检','114')" class="menuTd">
								<img src="images/balance.png" class="menuImg"><p>网上年检</p></td>
							</tr>
						<% }%>
						<tr>
								<td onclick="menuClick('党建年检','015')" class="menuTd">
								<img src="images/balance.png" class="menuImg"><p>党建年检</p></td>
							</tr>
					</table>
				</next:Html>
			</next:Panel>
		<%}%>
	<%}%>
	<% if("ST".equals(organType)){ %>
		<next:Panel title="社会团体业务办理" bodyStyle="background-color:#DFE8F6;overflow-y:auto;overflow-x:hidden">
		<next:Html>
			<table class="menuTable">
				<% for(int i = 0;i<menuInfoArr.length;i++){%>
						<%if(menuInfoArr[i].equals(ApplyType.SOM_GROUP_NAME_APPROVAL)){%>
							<tr>
								<td onclick="menuClick('申请名称核准','<%= menuInfoArr[i]%>')" class="menuTd">
								<img src="../manage/apply/images/nameApproval.png" class="menuImg"><p>申请名称核准</p></td>
							</tr>
						<%}%>
						<%if(menuInfoArr[i].equals(ApplyType.SOM_GROUP_PREPARE)){%>
							<tr>
								<td onclick="menuClick('筹备登记','<%= menuInfoArr[i]%>')" class="menuTd">
								<img src="../manage/apply/images/prepare.png" class="menuImg"><p>筹备成立</p></td>
							</tr>
						<%}%>
						<%if(menuInfoArr[i].equals(ApplyType.SOM_GROUP_BUILD)){%>
							<tr>
								<td onclick="menuClick('成立登记','<%= menuInfoArr[i]%>')" class="menuTd">
								<img src="../manage/apply/images/bulid.png" class="menuImg"><p>成立登记</p></td>
							</tr>
						<%}%>
						<%if(menuInfoArr[i].equals(ApplyType.SOM_GROUP_CHANGE)){%>
							<tr>
								<td onclick="menuClick('变更登记','<%= menuInfoArr[i]%>')" class="menuTd">
								<img src="../manage/apply/images/change.png" class="menuImg"><p>变更登记</p></td>
							</tr>
						<%}%>
						<%if(menuInfoArr[i].equals(ApplyType.SOM_GROUP_CANCEL)){%>
							<tr>
								<td onclick="menuClick('注销登记','<%= menuInfoArr[i]%>')" class="menuTd">
								<img src="../manage/apply/images/cancel.png" class="menuImg"><p>注销登记</p></td>
							</tr>
						<%}%>
						<%if(menuInfoArr[i].equals(ApplyType.SOM_GROUP_BRANCH_BUILD)){%>
							<tr>
								<td onclick="menuClick('分支/代表机构设立登记','<%= menuInfoArr[i]%>')" class="menuTd">
								<img src="../manage/apply/images/brachBuild.png" class="menuImg"><p>分支/代表机构设立登记</p></td>
							</tr>
						<%}%>
						<%if(menuInfoArr[i].equals(ApplyType.SOM_GROUP_BRANCH_CHANGE)){%>
							<tr>
								<td onclick="menuClick('分支/代表机构变更登记','<%= menuInfoArr[i]%>')" class="menuTd">
								<img src="../manage/apply/images/branchChange.png" class="menuImg"><p>分支/代表机构变更登记</p></td>
							</tr>
						<%}%>
						<%if(menuInfoArr[i].equals(ApplyType.SOM_GROUP_BRANCH_CANCEL)){%>
							<tr>
								<td onclick="menuClick('分支/代表机构注销登记','<%= menuInfoArr[i]%>')" class="menuTd">
								<img src="../manage/apply/images/branchCancel.png" class="menuImg"><p>分支/代表机构注销登记</p></td>
							</tr>
						<%}%>
						<%if(menuInfoArr[i].equals(ApplyType.SOM_GROUP_CHARGER)){%>
							<tr>
								<td onclick="menuClick('负责人换届备案','<%= menuInfoArr[i]%>')" class="menuTd">
								<img src="../manage/apply/images/ungovBuildPartner.png" class="menuImg"><p>负责人换届备案</p></td>
							</tr>
						<%}%>
						<%if(menuInfoArr[i].equals(ApplyType.SOM_GROUP_RULE_CHECK)){%>
							<tr>
								<td onclick="menuClick('章程核准','<%= menuInfoArr[i]%>')" class="menuTd">
								<img src="../manage/apply/images/rule.png" class="menuImg"><p>章程核准</p></td>
							</tr>
						<%}%>
						<%if(menuInfoArr[i].equals(ApplyType.SOM_GROUP_ELECTION_CHECK)){%>
							<tr>
								<td onclick="menuClick('换届（成立）事先报批','<%= menuInfoArr[i]%>')" class="menuTd">
								<img src="../manage/apply/images/election.png" class="menuImg"><p>换届（成立）事先报批</p></td>
							</tr>
						<%}%>
						<%if(menuInfoArr[i].equals(ApplyType.SOM_GROUP_ELECTION_CHECK_DELAY)){%>
							<tr>
								<td onclick="menuClick('延期换届选举报批','<%= menuInfoArr[i]%>')" class="menuTd">
								<img src="../manage/apply/images/delayElection.png" class="menuImg"><p>延期换届选举报批</p></td>
							</tr>
						<%}%>
						<%if(menuInfoArr[i].equals(ApplyType.SOM_GROUP_CHARGER_CENTRE)){%>
							<tr>
								<td onclick="menuClick('负责人届中备案','<%= menuInfoArr[i]%>')" class="menuTd">
								<img src="../manage/apply/images/ungovBuildPartner.png" class="menuImg"><p>负责人届中备案</p></td>
							</tr>
						<%}%>
						<%if(menuInfoArr[i].equals(ApplyType.SOM_GROUP_FEE)){%>
							<tr>
								<td onclick="menuClick('会费标准备案','<%= menuInfoArr[i]%>')" class="menuTd">
								<img src="../manage/apply/images/delayElection.png" class="menuImg"><p>会费标准备案</p></td>
							</tr>
						<%}%>

				<%}%>
			</table>
		</next:Html>
		</next:Panel>
	<% }else if("JJ".equals(organType)) { %>
		<next:Panel title="基金会功能菜单" bodyStyle="background-color:#DFE8F6;overflow-y:auto;overflow-x:hidden">
		<next:Html>
			<table class="menuTable">
				<% for(int i = 0;i<menuInfoArr.length;i++){%>
						<%if(menuInfoArr[i].equals(ApplyType.SOM_FUND_NAME_APPROVAL)){%>
							<tr>
								<td onclick="menuClick('申请名称核准','<%= menuInfoArr[i]%>')" class="menuTd">
								<img src="../manage/apply/images/nameApproval.png" class="menuImg"><p>申请名称核准</p></td>
							</tr>
						<%}%>
						<%if(menuInfoArr[i].equals(ApplyType.SOM_FUND_BUILD)){%>
							<tr>
								<td onclick="menuClick('设立登记','<%= menuInfoArr[i]%>')" class="menuTd">
								<img src="../manage/apply/images/bulid.png" class="menuImg"><p>设立登记</p></td>
							</tr>
						<%}%>
						<%if(menuInfoArr[i].equals(ApplyType.SOM_FUND_CHANGE)){%>
							<tr>
								<td onclick="menuClick('变更登记','<%= menuInfoArr[i]%>')" class="menuTd">
								<img src="../manage/apply/images/change.png" class="menuImg"><p>变更登记</p></td>
							</tr>
						<%}%>
						<%if(menuInfoArr[i].equals(ApplyType.SOM_FUND_CANCEL)){%>
							<tr>
								<td onclick="menuClick('注销登记','<%= menuInfoArr[i]%>')" class="menuTd">
								<img src="../manage/apply/images/cancel.png" class="menuImg"><p>注销登记</p></td>
							</tr>
						<%}%>
						<%if(menuInfoArr[i].equals(ApplyType.SOM_FUND_BRANCH_BUILD)){%>
							<tr>
								<td onclick="menuClick('分支/代表机构设立登记','<%= menuInfoArr[i]%>')" class="menuTd">
								<img src="../manage/apply/images/brachBuild.png" class="menuImg"><p>分支/代表机构设立登记</p></td>
							</tr>
						<%}%>
						<%if(menuInfoArr[i].equals(ApplyType.SOM_FUND_BRANCH_CHANGE)){%>
							<tr>
								<td onclick="menuClick('分支/代表机构变更登记','<%= menuInfoArr[i]%>')" class="menuTd">
								<img src="../manage/apply/images/branchChange.png" class="menuImg"><p>分支/代表机构变更登记</p></td>
							</tr>
						<%}%>
						<%if(menuInfoArr[i].equals(ApplyType.SOM_FUND_BRANCH_CANCEL)){%>
							<tr>
								<td onclick="menuClick('分支/代表机构注销登记','<%= menuInfoArr[i]%>')" class="menuTd">
								<img src="../manage/apply/images/branchCancel.png" class="menuImg"><p>分支/代表机构注销登记</p></td>
							</tr>
						<%}%>
						<%if(menuInfoArr[i].equals(ApplyType.SOM_FUND_RULE_CHECK)){%>
							<tr>
								<td onclick="menuClick('章程核准','<%= menuInfoArr[i]%>')" class="menuTd">
								<img src="../manage/apply/images/rule.png" class="menuImg"><p>章程核准</p></td>
							</tr>
						<%}%>
						<%if(menuInfoArr[i].equals(ApplyType.SOM_FUND_ELECTION_CHECK)){%>
							<tr>
								<td onclick="menuClick('换届（成立）事先报批','<%= menuInfoArr[i]%>')" class="menuTd">
								<img src="../manage/apply/images/election.png" class="menuImg"><p>换届（成立）事先报批</p></td>
							</tr>
						<%}%>
						<%if(menuInfoArr[i].equals(ApplyType.SOM_FUND_ELECTION_CHECK_DELAY)){%>
							<tr>
								<td onclick="menuClick('延期换届选举报批','<%= menuInfoArr[i]%>')" class="menuTd">
								<img src="../manage/apply/images/delayElection.png" class="menuImg"><p>延期换届选举报批</p></td>
							</tr>
						<%}%>
						<%if(menuInfoArr[i].equals(ApplyType.SOM_FUND_CHARGER)){%>
							<tr>
								<td onclick="menuClick('负责人换届备案','<%= menuInfoArr[i]%>')" class="menuTd">
								<img src="../manage/apply/images/ungovBuildPartner.png" class="menuImg"><p>负责人换届备案</p></td>
							</tr>
						<%}%>
						<%if(menuInfoArr[i].equals(ApplyType.SOM_FUND_CHARGER_CENTRE)){%>
							<tr>
								<td onclick="menuClick('负责人届中备案','<%= menuInfoArr[i]%>')" class="menuTd">
								<img src="../manage/apply/images/ungovBuildPartner.png" class="menuImg"><p>负责人届中备案</p></td>
							</tr>
						<%}%>
				<%}%>
			</table>
		</next:Html>
		</next:Panel>
	<% }else if("MF".equals(organType)){ %>
		<next:Panel title="民办非企业单位功能菜单" bodyStyle="background-color:#DFE8F6;overflow-y:auto;overflow-x:hidden">
		<next:Html>
			<table class="menuTable">
				<% for(int i = 0;i<menuInfoArr.length;i++){%>
						<%if(menuInfoArr[i].equals(ApplyType.SOM_UNGOV_NAME_APPROVAL)){%>
							<tr>
								<td onclick="menuClick('申请名称核准','<%= menuInfoArr[i]%>')" class="menuTd">
								<img src="../manage/apply/images/nameApproval.png" class="menuImg"><p>申请名称核准</p></td>
							</tr>
						<%}%>
						<%if(menuInfoArr[i].equals(ApplyType.SOM_UNGOV_BUILD_LEGAL)){%>
							<tr>
								<td onclick="menuClick('民办非企业单位（法人）成立登记','<%= menuInfoArr[i]%>')" class="menuTd">
								<img src="../manage/apply/images/ungovBuildLegal.png" class="menuImg"><p>民办非企业单位（法人）成立登记</p></td>
							</tr>
						<%}%>
						<%if(menuInfoArr[i].equals(ApplyType.SOM_UNGOV_BUILD_PARTNERSHIP)){%>
							<tr>
								<td onclick="menuClick('民办非企业单位（合伙）成立登记','<%= menuInfoArr[i]%>')" class="menuTd">
								<img src="../manage/apply/images/ungovBuildPartner.png" class="menuImg"><p>民办非企业单位（合伙）成立登记</p></td>
							</tr>
						<%}%>
						<%if(menuInfoArr[i].equals(ApplyType.SOM_UNGOV_BUILD_INDIVIDUAL)){%>
							<tr>
								<td onclick="menuClick('民办非企业单位（个体）成立登记','<%= menuInfoArr[i]%>')" class="menuTd">
								<img src="../manage/apply/images/ungovBuildIndividual.png" class="menuImg"><p>民办非企业单位（个体）成立登记</p></td>
							</tr>
						<%}%>
						<%if(menuInfoArr[i].equals(ApplyType.SOM_UNGOV_CHANGE)){%>
							<tr>
								<td onclick="menuClick('变更登记','<%= menuInfoArr[i]%>')" class="menuTd">
								<img src="../manage/apply/images/change.png" class="menuImg"><p>变更登记</p></td>
							</tr>
						<%}%>
						<%if(menuInfoArr[i].equals(ApplyType.SOM_UNGOV_CANCEL)){%>
							<tr>
								<td onclick="menuClick('注销登记','<%= menuInfoArr[i]%>')" class="menuTd">
								<img src="../manage/apply/images/cancel.png" class="menuImg"><p>注销登记</p></td>
							</tr>
						<%}%>
						<%if(menuInfoArr[i].equals(ApplyType.SOM_UNGOV_RULE_CHECK)){%>
							<tr>
								<td onclick="menuClick('章程核准','<%= menuInfoArr[i]%>')" class="menuTd">
								<img src="../manage/apply/images/rule.png" class="menuImg"><p>章程核准</p></td>
							</tr>
						<%}%>
				<%}%>
			</table>
		</next:Html>
		</next:Panel>
	<% }%>

<next:Panel title="系统管理" bodyStyle="background-color:#DFE8F6;overflow-y:auto;overflow-x:hidden">
<next:Html>
	<table class="menuTable">
		<tr>
			<td onclick="loadPage('系统设置','jsp/ext/somsd/manage/loginUserEdit.jsp')"  class="menuTd">
			<img src="images/system.png" class="menuImg"><p>系统设置</p></td>
		</tr>
	</table>
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
						src="<%=request.getContextPath()%>/jsp/ext/somsd/login/head.jsp"></iframe>
			</next:Html>
		</next:Panel>
	</next:Tabs>
</next:TabPanel>
</next:Center>
</next:BorderLayout>
</next:ViewPort>
<script for="window" event="onbeforeunload">
if(document.body.clientWidth-event.clientX<170&&event.clientY< 0||event.altKey){
	startRequest(L5.webPath+"/camsext_logout?loginType=somsd");
}
</script>
</body>
</html>