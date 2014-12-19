<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ page import="com.inspur.cams.comm.extuser.util.ExtBspInfo"%>
<html>
<head>
<link rel="shortcut icon" href="jsp/favicon.ico" type="image/x-icon"/>
<title>福利企业网上年检平台</title>
<next:ScriptManager/>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/ext/welfare/login/index.css"/>
<script type="text/javascript">
<%
	String username = ExtBspInfo.getUserInfo(request).getUserName();
	String organArea = ExtBspInfo.getUserInfo(request).getAreaCode();//获取外部单位行政区划12位
	String organType = ExtBspInfo.getUserInfo(request).getOrganType();//获取外部单位的类型 

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
function menuClick(title,pageName){
	var url='';
	if(pageName=='000'){
		url='jsp/ext/welfare/manage/baseinfo/unit/unitBaseinfo.jsp';
	}
	if(pageName=='001'){
		url='jsp/ext/welfare/manage/apply/welfarecorp/welfarecorpList.jsp';
	}
	if(pageName=='002'){
		url='jsp/ext/welfare/manage/check/welfarecorp/welfarecorpCheckList.jsp';
	}
	if(pageName=='003'){
		url='jsp/ext/welfare/manage/change/welfarecorp/welfarechange1.jsp';
	}
	if(pageName=='004'){
		url='jsp/ext/welfare/manage/cancel/welfarecorp/welfarelogout.jsp';
	}
	if(pageName=='100'){
		url='jsp/ext/welfare/manage/baseinfo/fit/fitBaseinfo.jsp';
	}
	if(pageName=='101'){
		url='jsp/ext/welfare/manage/apply/prosthesis/prosthesisList.jsp';
	}
	if(pageName=='102'){
		url='jsp/ext/welfare/manage/check/prosthesis/prosthesischecklist.jsp';
	}
	if(pageName=='103'){
		url='jsp/ext/welfare/manage/change/prosthesis/prosthesischange.jsp';
	}
	if(pageName=='104'){
		url='jsp/ext/welfare/manage/cancel/prosthesis/prosthesiscancel.jsp';
	}
	loadPage(title,url);
}
function menuClickM(title,pageName){
	var url='jsp/ext/welfare/manage/'+pageName+'.jsp';	
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
	document.location.href=L5.webPath+"/camsext_logout?loginType=welfare";
}
function head(){
	var tabPanel=L5.getCmp('center');
	var panel = tabPanel.getItem(0);
	panel.setTitle("首页");
	var iframes=panel.body.query('iframe');
	iframes[0].src=L5.webPath+"/jsp/ext/welfare/login/head.jsp";
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

<next:Panel title="网上年检" bodyStyle="background-color:#DFE8F6;overflow-y:auto;overflow-x:hidden">
<next:Html>
	<table class="menuTable">
		<% if("FL".equals(organType)){ %>
		<tr>
			<td onclick="menuClick('网上年检','002')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>网上年检</p></td>
		</tr>
		<% } %>
		<% if("JZ".equals(organType)){ %>
		<tr>
			<td onclick="menuClick('网上年检','102')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>网上年检</p></td>
		</tr>
		<% } %>
	</table>
</next:Html>
</next:Panel>
<!-- 福利企业 -->
<% if("FL".equals(organType)){ %>
<next:Panel title="福利企业功能菜单" bodyStyle="background-color:#DFE8F6;overflow-y:auto;overflow-x:hidden">
<next:Html>
	<table class="menuTable">
		<tr>
			<td onclick="menuClick('网上申报','001')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>资格认定申报</p></td>
		</tr>
		<tr>
			<td onclick="menuClick('基本信息查看','000')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>基本信息查看</p></td>
		</tr>
		<%-- 
		<tr>
			<td onclick="menuClick('网上申报','001')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>资格认定申报</p></td>
		</tr>
		<!-- 引入路径 福利的 -->
		
		<tr>
			<td onclick="menuClick('企业变更','003')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>事项变更备案</p></td>
		</tr>
		<tr>
			<td onclick="menuClick('注销','004')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>注销备案</p></td>
		</tr>
		--%>
		
</table>
</next:Html>
</next:Panel>
<% } %>
<!-- 假肢生产(变更记录/注销) -->
<% if("JZ".equals(organType)){ %>
<next:Panel title="假肢矫形功能菜单" bodyStyle="background-color:#DFE8F6;overflow-y:auto;overflow-x:hidden">
<next:Html>
	<table class="menuTable">
		<tr>
			<td onclick="menuClick('网上申报','101')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>资格认定申报</p></td>
		</tr>
		<tr>
			<td onclick="menuClick('基本信息查看','100')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>基本信息查看</p></td>
		</tr>
		<%--
		<tr>
			<td onclick="menuClick('网上申报','101')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>资格认定申报</p></td>
		</tr>
		<tr>
			<td onclick="menuClick('事项备案','103')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>事项变更备案</p></td>
		</tr>
		<tr>
			<td height="20"></td>
		</tr>
		<tr>
			<td onclick="menuClick('注销备案','104')" class="menuTd">
			<img src="images/balance.png" class="menuImg"><p>注销备案</p></td>
		</tr>
		--%>
	</table>
</next:Html>
</next:Panel>
<% } %>
<next:Panel title="系统管理" bodyStyle="background-color:#DFE8F6;overflow-y:auto;overflow-x:hidden">
<next:Html>
	<table class="menuTable">
		<tr>
			<td onclick="menuClickM('系统设置','loginUserEdit')" class="menuTd">
			<img src="images/system.png" class="menuImg"><p>系统设置</p></td>
		</tr>
		<tr>
			<td height="20"></td>
		</tr>
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
						src="<%=request.getContextPath()%>/jsp/ext/welfare/login/head.jsp"></iframe>
			</next:Html>
		</next:Panel>
	</next:Tabs>
</next:TabPanel>
</next:Center>
</next:BorderLayout>
</next:ViewPort>
<script for="window" event="onbeforeunload">
if(document.body.clientWidth-event.clientX<170&&event.clientY< 0||event.altKey){
	startRequest(L5.webPath+"/camsext_logout?loginType=welfare");
}
</script>
</body>
</html>