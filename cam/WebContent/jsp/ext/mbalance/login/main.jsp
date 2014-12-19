<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ page import="com.inspur.cams.comm.extuser.util.ExtBspInfo"%>
<%
	String username = ExtBspInfo.getUserInfo(request).getUserName();
%>
<html>
<head>
<link rel="shortcut icon" href="jsp/favicon.ico" type="image/x-icon"/>
<title>山东省医疗救助暨优抚医疗保障一站式结算系统</title>
<next:ScriptManager/>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/ext/mbalance/login/index.css"/>
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
	var url='jsp/ext/mbalance/manage/'+pageName+'.jsp';	
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
	document.location.href=L5.webPath+"/camsext_logout?loginType=mbalance";
}
function head(){
	var tabPanel=L5.getCmp('center');
	var panel = tabPanel.getItem(0);
	panel.setTitle("首页");
	var iframes=panel.body.query('iframe');
	iframes[0].src=L5.webPath+"/jsp/ext/mbalance/login/head.jsp";
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
					<p align="right"><font color="black"><%=username%>您好，欢迎光临一站式结算系统</font></p>
				</div>
			</div>
		</div>
		
	</next:Html>
</next:Panel>
</next:Top>

<next:Left split="true">
<next:Panel id="leftPanel" width="150" bodyStyle="background-color:#DFE8F6;overflow-y:auto;overflow-x:hidden" collapsible="true" title="功能导航">
	<next:AccordionLayout>
	  <next:Panel title="业务管理" bodyStyle="background-color:#DFE8F6;overflow-y:auto;overflow-x:hidden">
		<next:Html>
		<table class="menuTable">
		  <tr>
            <td onclick="menuClick('入院备案','samMBalancePeople')" class="menuTd">
              <img src="images/hospital.png" class="menuImg">
              <p>入院备案</p>
		    </td>
		  </tr>
          </table>
          <table class="menuTable">
		   <tr>
             <td onclick="menuClick('费用结算','samMBalanceList')" class="menuTd">
               <img src="images/balance.png" class="menuImg">
               <p>费用结算</p>
		     </td>
		   </tr>
           </table>
           <table  class="menuTable">
		   <tr>
             <td  onclick="menuClick('普通门规','samMBalanceOutpatientAss')" class="menuTd">
               <img src="images/doctor_man.png" class="menuImg">
               <p>普通门规</p>
		     </td>
		   </tr>
           </table>
		   <table  class="menuTable">
		   <tr>
             <td  onclick="menuClick('优抚门规','samMBalanceOutpatient')" class="menuTd">
               <img src="images/doctor.png" class="menuImg">
               <p>优抚门规</p>
		     </td>
		   </tr>
           </table>
		   
		</next:Html>
		</next:Panel>
		<next:Panel title="查询统计" bodyStyle="background-color:#DFE8F6;overflow-y:auto;overflow-x:hidden">
		<next:Html>
           <table  class="menuTable">
		   <tr>
             <td onclick="menuClick('综合查询','samMBalanceReport')" class="menuTd">
               <img src="images/query.png" class="menuImg">
               <p>综合查询</p>
		     </td>
		   </tr>
		   </table>
           <table  class="menuTable">
		   <tr>
             <td onclick="menuClick('属地分类汇总（低保五保）','samMBalanceReportByDom')" class="menuTd">
               <img src="images/filter_list.png" class="menuImg">
               <p>属地分类汇总<br/>（低保五保）</p>
		     </td>
		   </tr>
		   </table>
           <table  class="menuTable">
		   <tr>
             <td onclick="menuClick('类别分类汇总（低保五保）','samMBalanceReportByAssType')" class="menuTd">
               <img src="images/list.png" class="menuImg">
               <p>类别分类汇总<br/>（低保五保）</p>
		     </td>
		   </tr>
		   </table>
		   <table  class="menuTable">
		   <tr>
             <td onclick="menuClick('优抚分类汇总','samMBalanceReportByDomBpt')" class="menuTd">
               <img src="images/people_list.png" class="menuImg">
               <p>优抚分类汇总</p>
		     </td>
		   </tr>
		   </table>
		</next:Html>
		</next:Panel>
		<next:Panel title="系统管理" bodyStyle="background-color:#DFE8F6;overflow-y:auto;overflow-x:hidden">
		<next:Html>
           <table class="menuTable">
		   <tr>
             <td onclick="loadPage('系统设置','jsp/ext/mbalance/manage/loginUserEdit.jsp')"  class="menuTd">
               <img src="images/system.png" class="menuImg">
               <p>系统设置</p>
		     </td>
		   </tr>
		   </table>
           <table  class="menuTable">
		   <tr>
             <td onclick="javascript:logout();" class="menuTd">
               <img src="images/log_off.png" class="menuImg">
               <p>注销</p>
		     </td>
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
						src="<%=request.getContextPath()%>/jsp/ext/mbalance/login/head.jsp"></iframe>
			</next:Html>
		</next:Panel>
	</next:Tabs>
</next:TabPanel>
</next:Center>
</next:BorderLayout>
</next:ViewPort>

<script for="window" event="onbeforeunload">
if(document.body.clientWidth-event.clientX<170&&event.clientY< 0||event.altKey){
	startRequest(L5.webPath+"/camsext_logout?loginType=mbalance");
}
</script>
</body>
</html>