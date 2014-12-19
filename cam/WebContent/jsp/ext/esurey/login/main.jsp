<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ page import="com.inspur.cams.comm.extuser.util.ExtBspInfo"%>
<%@ page import="com.inspur.cams.drel.comm.SureyHeadMsg"%>
<%
	String username = ExtBspInfo.getUserInfo(request).getUserName();
    String areaCode = ExtBspInfo.getUserInfo(request).getAreaCode();
    String organType = ExtBspInfo.getUserInfo(request).getOrganType();
    String ListUrl="";
    String QueryUrl="";
    if("01".equals(organType)){
    	ListUrl="jsp/ext/esurey/manage/esureySocialDetail.jsp";
    	QueryUrl="jsp/ext/esurey/manage/esureyExternalSocial.jsp";
	}
	if("02".equals(organType)){
		ListUrl="jsp/ext/esurey/manage/esureyHouseDetail.jsp";
		QueryUrl="jsp/ext/esurey/manage/esureyExternalHouse.jsp";
	}
	if("03".equals(organType)){
		ListUrl="jsp/ext/esurey/manage/esureyBusinessDetail.jsp";
		QueryUrl="jsp/ext/esurey/manage/esureyExternalBusiness.jsp";
	}
	if("04".equals(organType)){
		ListUrl="jsp/ext/esurey/manage/esureyCarDetail.jsp";
		QueryUrl="jsp/ext/esurey/manage/esureyExternalCar.jsp";
	}
	if("05".equals(organType)){
		ListUrl="jsp/ext/esurey/manage/esureyTaxDetail.jsp";
		QueryUrl="jsp/ext/esurey/manage/esureyExternalGTax.jsp";
	}
	if("06".equals(organType)){
		ListUrl="jsp/ext/esurey/manage/esureyTaxDetail.jsp";
		QueryUrl="jsp/ext/esurey/manage/esureyExternalDTax.jsp";
	}
	if("07".equals(organType)){
		ListUrl="jsp/ext/esurey/manage/esureyFundDetail.jsp";
		QueryUrl="jsp/ext/esurey/manage/esureyExternalHousingFund.jsp";
	}
	if("08".equals(organType)){
		ListUrl="jsp/ext/esurey/manage/esureyBankDetail.jsp";
		QueryUrl="jsp/ext/esurey/manage/esureyExternalBank.jsp";
	}
	if("09".equals(organType)){
		ListUrl="jsp/ext/esurey/manage/esureySecuritiesDetail.jsp";
		QueryUrl="jsp/ext/esurey/manage/esureyExternalSecurities.jsp";
	}
	if("10".equals(organType)){
		ListUrl="jsp/ext/esurey/manage/esureyInsuranceDetail.jsp";
		QueryUrl="jsp/ext/esurey/manage/esureyExternalInsurance.jsp";
	}
%>
<%
    String organIdOuter=ExtBspInfo.getUserInfo(request).getOrganId();
	String organAreaOuter = ExtBspInfo.getUserInfo(request).getAreaCode();
	String typeOuter = "";
	if(organAreaOuter.substring(4).equals("00000000")){
		typeOuter = "A1";
	}
	int sureyCityNum = 0;
	SureyHeadMsg msg = new SureyHeadMsg();
	sureyCityNum = msg.getCityEsureyOuter(organIdOuter);
%>
<html>
<head>
<link rel="shortcut icon" href="jsp/favicon.ico" type="image/x-icon"/>
<title>经济核对业务平台</title>
<next:ScriptManager/>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/ext/esurey/login/index.css"/>
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
//左边菜单的点击事件。
function leftClick(node,e){
	var record = node.record;
	var href = record.get("url");
	if(href){
		e.stopEvent();
		var tabs=L5.getCmp('center');
		loadPage(tabs, record);
	}
}
window.load=function(node){
	 if(node.href){
		var tabs=L5.getCmp('center');
		loadPage(tabs, node.record);
	}
};
function logout(){
    if(!confirm("您确定要退出系统吗？")) return;
	document.location.href=L5.webPath+"/camsext_logout?loginType=esurey";
}
function head(){
	var tabPanel=L5.getCmp('center');
	var panel = tabPanel.getItem(0);
	panel.setTitle("首页");
	var iframes=panel.body.query('iframe');
	iframes[0].src=L5.webPath+"/jsp/ext/esurey/login/head.jsp";
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
<%if("A1".equals(typeOuter) && typeOuter!=null){%>
<DIV id=eMeng style="BORDER-RIGHT: #455690 1px solid; BORDER-TOP: #a6b4cf 1px solid; Z-INDEX:99999; LEFT: 0px; VISIBILITY: hidden; BORDER-LEFT: #a6b4cf 1px solid; WIDTH: 340px; BORDER-BOTTOM: #455690 1px solid; POSITION: absolute; TOP: 0px; HEIGHT: 120px; BACKGROUND-COLOR: #c9d3f3">
	<TABLE style="BORDER-TOP: #ffffff 1px solid; BORDER-LEFT: #ffffff 1px solid" cellSpacing=0 cellPadding=0 width="100%" bgColor=#cfdef4 border=0>
	<TBODY>
		<TR>
			<TD style="FONT-SIZE: 12px; BACKGROUND-IMAGE: url(msgTopBg.gif); COLOR: #0f2c8c" width=30 height=24></TD>
			<TD style="FONT-WEIGHT: normal; FONT-SIZE: 12px; BACKGROUND-IMAGE: url(msgTopBg.gif); COLOR: #1f336b; PADDING-TOP: 4px;PADDING-left: 4px" vAlign=center width="100%"> 消息提示：</TD>
			<TD style="BACKGROUND-IMAGE: url(msgTopBg.gif); PADDING-TOP: 2px;PADDING-right:2px" vAlign=center align=right width=19><span title=关闭 style="CURSOR: hand;color:red;font-size:12px;font-weight:bold;margin-right:4px;" onclick=closeDiv() >×</span><!-- <IMG title=关闭 style="CURSOR: hand" onclick=closeDiv() hspace=3 src="msgClose.jpg"> --></TD>
		</TR>
		<%if(sureyCityNum>0){%>
		<TR>
			<TD style="PADDING-RIGHT: 1px; BACKGROUND-IMAGE: url(1msgBottomBg.jpg); PADDING-BOTTOM: 1px" colSpan=3 height=120>
				<DIV  class='div' style="BORDER-RIGHT: #b9c9ef 1px solid; PADDING-RIGHT: 13px; BORDER-TOP: #728eb8 1px solid; PADDING-LEFT: 13px; FONT-SIZE: 12px; PADDING-BOTTOM: 13px; BORDER-LEFT: #728eb8 1px solid; WIDTH: 100%; COLOR: #1f336b; PADDING-TOP: 18px; BORDER-BOTTOM: #b9c9ef 1px solid; HEIGHT: 100%">您有:<br>&nbsp&nbsp&nbsp&nbsp<a  href='javascript:void(0)' onclick='openUrl("<%=ListUrl %>")'>经济核对<span style="color:red"><%=sureyCityNum%></span>条</a><br>请及时处理!
					<DIV align=center style="word-break:break-all"></DIV>
				</DIV>
			</TD>
		</TR><%} else { %>
		  <TR>
			<TD style="PADDING-RIGHT: 1px; BACKGROUND-IMAGE: url(1msgBottomBg.jpg); PADDING-BOTTOM: 1px" colSpan=3 height=120>
				<DIV  class='div' style="BORDER-RIGHT: #b9c9ef 1px solid; PADDING-RIGHT: 13px; BORDER-TOP: #728eb8 1px solid; PADDING-LEFT: 13px; FONT-SIZE: 12px; PADDING-BOTTOM: 13px; BORDER-LEFT: #728eb8 1px solid; WIDTH: 100%; COLOR: #1f336b; PADDING-TOP: 18px; BORDER-BOTTOM: #b9c9ef 1px solid; HEIGHT: 100%">目前没有经济核对需要处理!
				</DIV>
			</TD>
		</TR>
		<%} %>
	</TBODY>
	</TABLE>
</DIV>
<%} %>
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
					<p align="right"><font color="black"><%=username%>您好，欢迎光临经济核对系统</font></p>
				</div>
			</div>
		</div>
		
	</next:Html>
</next:Panel>
</next:Top>

<next:Left split="true">
<next:Panel id="leftPanel" width="200" bodyStyle="background-color:#DFE8F6;overflow-y:auto;overflow-x:hidden" collapsible="true" title="功能导航">
	<next:AccordionLayout>
	 <% if("02,40,50,60,70,80,90,100,110,120,130,140,150,160,250".indexOf(organType)>=0){ %>
	  <next:Panel title="困难家庭管理" bodyStyle="background-color:#DFE8F6;overflow-y:auto;overflow-x:hidden">
		<next:Html>
		 <table class="menuTable">
		  <tr>
            <td onclick="loadPage('困难家庭登记','jsp/ext/esurey/jtxx/ygjzjtxx_list.jsp')" class="menuTd">
              <img src="images/list.png" class="menuImg">
              <p>困难家庭登记</p>
		    </td>
		  </tr>
          </table>
          <table class="menuTable">
		  <tr>
            <td onclick="loadPage('困难家庭审批','jsp/ext/esurey/jtxx/ygjzjtxx_exam_list.jsp')" class="menuTd">
              <img src="images/list.png" class="menuImg">
              <p>困难家庭审批</p>
		    </td>
		  </tr>
          </table>
          <table class="menuTable">
		  <tr>
            <td onclick="loadPage('困难家庭更正','jsp/ext/esurey/jtxx/ygjzjtxx_correct_list.jsp')" class="menuTd">
              <img src="images/list.png" class="menuImg">
              <p>困难家庭更正</p>
		    </td>
		  </tr>
          </table>
          <table class="menuTable">
		  <tr>
            <td onclick="loadPage('困难家庭查询','jsp/ext/esurey/jtxx/ygjzjtxx_state_list.jsp')" class="menuTd">
              <img src="images/list.png" class="menuImg">
              <p>困难家庭查询</p>
		    </td>
		  </tr>
          </table>
		</next:Html>
       </next:Panel>
      <next:Panel title="救助业务" bodyStyle="background-color:#DFE8F6;overflow-y:auto;overflow-x:hidden">
		<next:Html>
		<table class="menuTable">
		  <tr>
            <td onclick="loadPage('困难家庭查询','jsp/ext/esurey/jzfa/jzfaKnjtQuery.jsp')" class="menuTd">
              <img src="images/list.png" class="menuImg">
              <p>困难家庭查询</p>
		    </td>
		  </tr>
          </table>		
		<table class="menuTable">
		  <tr>
            <td onclick="loadPage('救助信息查询','jsp/ext/esurey/jzfa/jzfassQuery.jsp')" class="menuTd">
              <img src="images/list.png" class="menuImg">
              <p>救助信息查询</p>
		    </td>
		  </tr>
          </table>
		  <table class="menuTable">
		  <tr>
            <td onclick="loadPage('救助方案录入','jsp/ext/esurey/jzfa/jzfaQuery.jsp')" class="menuTd">
              <img src="images/list.png" class="menuImg">
              <p>救助方案录入</p>
		    </td>
		  </tr>
          </table>
          <table class="menuTable">
		  <tr>
            <td onclick="loadPage('受助信息查询','jsp/ext/esurey/jzfa/jzfaHisQuery.jsp')" class="menuTd">
              <img src="images/list.png" class="menuImg">
              <p>受助信息查询</p>
		    </td>
		  </tr>
          </table>
          <table class="menuTable">
		  <tr>
            <td onclick="loadPage('救助统计分析','jsp/ext/esurey/jzfa/jzfafxQuery.jsp')" class="menuTd">
              <img src="images/list.png" class="menuImg">
              <p>救助统计分析</p>
		    </td>
		  </tr>
          </table>
		</next:Html>
      </next:Panel>
      <% } %>
      <% if("01,02,03,04,05,06,07,08,09,10".indexOf(organType)>=0 ){ %>
	  <next:Panel title="经济核对" bodyStyle="background-color:#DFE8F6;overflow-y:auto;overflow-x:hidden">
		<next:Html>
		<table class="menuTable">
		  <tr>
            <td onclick="loadPage('核对管理','<%=ListUrl %>')" class="menuTd">
              <img src="images/list.png" class="menuImg">
              <p>核对管理</p>
		    </td>
		  </tr>
          </table>
          <br/>
        <table class="menuTable">
		   <tr>
             <td onclick="loadPage('统计查询','<%=QueryUrl %>')" class="menuTd">
               <img src="images/report.png" class="menuImg">
               <p>统计查询</p>
		     </td>
		   </tr>
           </table>
		</next:Html>
      </next:Panel>
      <% } %>
      <next:Panel title="低保低收入家庭核对" bodyStyle="background-color:#DFE8F6;overflow-y:auto;overflow-x:hidden">
		<next:Html>
		<table class="menuTable">
		  <tr>
            <td onclick="loadPage('核对管理','jsp/ext/esurey/manage/assistance/sureyCheckList.jsp')" class="menuTd">
              <img src="images/list.png" class="menuImg">
              <p>核对管理</p>
		    </td>
		  </tr>
          </table>
          <br/>
        <table class="menuTable">
		   <tr>
             <td onclick="loadPage('核对结果','jsp/ext/esurey/manage/assistance/sureyCheckQuery.jsp')" class="menuTd">
               <img src="images/list.png" class="menuImg">
               <p>核对结果</p>
		     </td>
		   </tr>
           </table>
          <br/>
        <table class="menuTable">
		   <tr>
             <td onclick="loadPage('统计查询','jsp/ext/esurey/manage/assistance/sureyCheckQueryList.jsp')" class="menuTd">
               <img src="images/report.png" class="menuImg">
               <p>统计查询</p>
		     </td>
		   </tr>
           </table>           
		</next:Html>
      </next:Panel>
      <next:Panel title="系统管理" bodyStyle="background-color:#DFE8F6;overflow-y:auto;overflow-x:hidden">
		<next:Html>
		   <table class="menuTable">
		   <tr>
             <td onclick="loadPage('系统设置','jsp/ext/esurey/manage/loginUserEdit.jsp')" class="menuTd">
               <img src="images/system.png" class="menuImg">
               <p>系统设置</p>
		     </td>
		   </tr>
           </table>
           <br/>
           <table class="menuTable">
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
						src="<%=request.getContextPath()%>/jsp/ext/esurey/login/head.jsp"></iframe>
			</next:Html>
		</next:Panel>
	</next:Tabs>
</next:TabPanel>
</next:Center>
</next:BorderLayout>
</next:ViewPort>
<script type="text/javascript">

</script>
<script for="window" event="onbeforeunload">
if(document.body.clientWidth-event.clientX<170&&event.clientY< 0||event.altKey){
	startRequest(L5.webPath+"/camsext_logout?loginType=esurey");
}
</script>
<script language="javascript">
function openUrl(urlPath){
	var panel = L5.getCmp('center').getItem(0);
	var title="首页";
	if(title){
		panel.setTitle(title);
	}
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
	if(urlPath.indexOf("http")==0||urlPath.indexOf("www")>=0)
	    iframes[0].src =urlPath;
	else{
		iframes[0].src=L5.webPath+"/"+urlPath;
	}
}
<%
 if(sureyCityNum >= 0){%>
/*去掉此注释，可以弹出提示框
 	window.onload = getMsg;
		window.onresize = resizeDiv;
		window.onerror = function(){}
		//短信提示使用(asilas添加)
		var divTop,divLeft,divWidth,divHeight,docHeight,docWidth,objTimer;
		function getMsg(){
			try{
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
					objTimer = window.setInterval("resizeDiv()",1);
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
*/
 <% }%>
 </script>
</body>
</html>