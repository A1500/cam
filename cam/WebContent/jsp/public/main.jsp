<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.inspur.cams.comm.util.StrUtil"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.inspur.cams.comm.subsys.util.SubsysConfigUtil"%>
<%@page import="com.inspur.cams.comm.subsys.data.ComSubsysConfig"%>
<%@page import="java.util.List"%>
<%@page import="org.loushang.bsp.share.permit.bean.RoleView"%>
<%@page import="org.loushang.bsp.share.permit.security.SecurityFactory"%>
<%@page import="org.loushang.bsp.share.permit.security.provider.ISecurityProvider"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%
    List<ComSubsysConfig> sysList;
    sysList = SubsysConfigUtil.getSysList();
    int sysCount=sysList.size();
	ISecurityProvider sp = SecurityFactory.getISecurityProvider();
	RoleView[] roleViews = sp.getAssignedRole(GetBspInfo.getBspInfo().getUserId());
	List<ComSubsysConfig> ifJumpMainList = new ArrayList<ComSubsysConfig>();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/HTML4.01/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<link rel="shortcut icon" type="image/x-icon" href="jsp/public/subsysimg/favicon.ico" />
	<link rel="icon" type="image/x-icon" href="jsp/public/subsysimg/favicon.ico" />
	<title>山东民政“金民工程”综合业务管理平台</title>
<style>
body { font-size:14px; margin:0;background:url("subsysimg/sysback.png") no-repeat #238DE7 top center;TEXT-ALIGN: center;}
#container {margin:0 auto; width:720px;}
#header { width:100%;height:190px}
#mainContent {float:left;margin:0px auto;}
#mainContent ul{width:720px;margin:0px;padding:0px;list-style-type:none;}
#mainContent ul li{width:120px;height:130px;float:left;text-align:center;color:white;font-size:11pt;font-weight:bold;}
#mainContent li a{TEXT-DECORATION:none;color:white;}
#mainContent2 {float:left;margin:0px auto}
#mainContent2 ul{width:720px;margin:0px;padding:0px;list-style-type:none;}
#mainContent2 ul li{width:120px;height:130px;float:left;text-align:center;color:white;font-size:11pt;font-weight:bold;}
#mainContent2 li a{TEXT-DECORATION:none;color:white;}
img{border:none}
#footer {float:left; bottom:0; width:100%; height:43px;background:url('subsysimg/sysback_bottom.png') top center no-repeat;}
/* IE6 底部固定  */
* html #footer{position:absolute;bottom:auto;top:expression(eval(document.documentElement.scrollTop+document.documentElement.clientHeight-this.offsetHeight-(parseInt(this.currentStyle.marginTop,10)||0)-(parseInt(this.currentStyle.marginBottom,10)||0)));}
.unsel {background:none;text-align:center;}
.sel{background:url("subsysimg/selectbg.png") no-repeat;}
</style>
<form id="goForm" name="goForm" method="post" action="submain.jsp">
  <input type=hidden name="_menuType" id="_menuType" />
  <input type=hidden name="_topPic" id="_topPic" />
  <input type=hidden name="_mainPic" id="_mainPic" />
  <input type=hidden name="_verMargin" id="_verMargin" />
</form>

<script type="text/javascript"><!--
<%
	for (int i=0;i<sysCount;i++){
	   ComSubsysConfig sysConfig = sysList.get(i);
	   if(SubsysConfigUtil.hasPriv(roleViews, sysConfig.getGrantedRoles())){
		 ifJumpMainList.add(sysConfig);
	   }
	}
	if(ifJumpMainList.size() == 1){//有且只有一个菜单的时候
	   if("1".equalsIgnoreCase(ifJumpMainList.get(0).getIfJumpMain())){//是否直接进入菜单的参数为1
		   %>
			jumpMain();
			//获取用户菜单信息 ，进入相应菜单
			function jumpMain(){
				var menuType = '<%=ifJumpMainList.get(0).getSysMenuType()%>';
				var topPic = '<%=ifJumpMainList.get(0).getTopPic()%>';
				var mainPic = '<%=ifJumpMainList.get(0).getMainPic()%>';
				var verMargin = '<%=ifJumpMainList.get(0).getVerMargin()%>';
				goSubsys(menuType,topPic,mainPic,verMargin);

			}
			<%
	   }
	}

%>



	function mouseOver(obj){
		obj.className="sel";
	}
	function mouseOut(obj){
		obj.className="nobg";
	}
	var xmlHttp;
	function createXMLHttpRequest() {
		if (window.ActiveXObject) {
			xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
		else if (window.XMLHttpRequest) {
			xmlHttp = new XMLHttpRequest();
		}
	}
	function goSubsys(menuType,topPic,mainPic,verMargin){
		if(menuType=="0000000026") {//收养
			document.getElementById("goForm").target='_blank';
			document.getElementById("goForm").action='../cams/comm/soo/adopt.jsp';
			document.getElementById("goForm").submit();	
		}else if(menuType=="0000000027") {//流浪乞讨
			document.getElementById("goForm").target='_blank';
			document.getElementById("goForm").action='../cams/comm/soo/beggars.jsp';
			document.getElementById("goForm").submit();	
		}else if(menuType=="0000000028") {//婚姻登记
			document.getElementById("goForm").target='_blank';
			document.getElementById("goForm").action='../cams/comm/soo/marry.jsp';
			document.getElementById("goForm").submit();	
		}else {
			document.getElementById("_menuType").value=menuType;
			document.getElementById("_topPic").value=topPic;
			document.getElementById("_mainPic").value=mainPic;
			document.getElementById("_verMargin").value=verMargin;
			document.getElementById("goForm").submit();
		}
	}
	function logout(){
		if(!confirm("您确定要退出系统吗？"))
			return ;
		document.location.href="<%=request.getContextPath() %>/logout";
	}
--></script>


</head>
<body>
<div id="header"></div>
<div id="container">

  <div id="mainContent">
  <center>
     <%
	   StringBuffer sb1= new StringBuffer();
           int count=1;
		   for (int i=0;i<sysCount;i++){
              if(count==1){
			    sb1.append("<ul> \n");
              }
			  ComSubsysConfig sysConfig = sysList.get(i);
			  if(SubsysConfigUtil.hasPriv(roleViews, sysConfig.getGrantedRoles())){
				 sb1.append("<li onmouseover='mouseOver(this)' onmouseout='mouseOut(this)'> \n");
				 sb1.append("  <a href=\"javascript:goSubsys('"+StrUtil.n2b(sysConfig.getSysMenuType())+"','"+StrUtil.n2b(sysConfig.getTopPic())+"','"+StrUtil.n2b(sysConfig.getMainPic())+"','"+StrUtil.n2b(sysConfig.getVerMargin())+"')\">\n");
				 sb1.append("    <img src='subsysimg/"+sysConfig.getSysIco()+"' /> \n");
				 sb1.append("  <br/>"+sysConfig.getShortName()+" \n</a>");
				 sb1.append("</li>\n");
			   } else {
				   sb1.append("<li> \n");
				   sb1.append("  <img src='subsysimg/"+sysConfig.getSysIco()+"' /> \n");
				   sb1.append("  <br/>"+sysConfig.getShortName()+" \n</a>");
				   sb1.append("</li>\n");
			   }
			  if(count>5 && count/6==1&&i+1!=sysCount){
			    sb1.append("</ul>\n");
				count=1;
              } else {
			    count++;
			  }
			  if(i+1==sysCount){
				  sb1.append("</ul>\n");
			  }
		   }

     %>

    <%=sb1%>
    </center>
    </div>
    <div id="mainContent2">
    <center>
    <ul>
     <li style="float:right" onmouseover='mouseOver(this)' onmouseout='mouseOut(this)' >
	    <a href="javascript:logout()">
	       <img src='subsysimg/exit.png'/>
	    </a>
	 </li>
	 <%
	     if("superadmin".equalsIgnoreCase(GetBspInfo.getBspInfo().getUserId())){
	 %>
		 <li style="float:right" onmouseover='mouseOver(this)' onmouseout='mouseOut(this)'>
		   <a href="javascript:goSubsys('1','','','400')">
		   <img src='subsysimg/config.png' />
		   <br/>系统管理 </a>
		 </li/>
	 <%
	 }
	 %>
    </ul>
  </center>
  </div>
</div>
<div id="footer"></div>
<script for="window" event="onbeforeunload">
function startRequest(url) {
    createXMLHttpRequest();
    xmlHttp.open("GET", url, false);
    xmlHttp.send(null);
    return xmlHttp.responseText;
}
    if(document.body.clientWidth-event.clientX< 170&&event.clientY< 0||event.altKey){
		 	startRequest("<%=request.getContextPath()%>/logout");
    }
</script>
</body>
</html>
