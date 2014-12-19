<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ page import="com.inspur.cams.comm.message.cmd.ComLoginMsg"%>
<%@ page import="org.loushang.next.data.DataSet"%>
<%
String j_auth_action=request.getContextPath()+"/j_bsp_security_check/";
String msg=(String)request.getSession().getAttribute("AuthenticationException");
if(msg==null)msg="";
DataSet msgDs = new DataSet();
ComLoginMsg comLoginMsg = new ComLoginMsg();
msgDs = comLoginMsg.queryMsg();
String ie=request.getHeader("User-Agent"); //得到浏览器等相关信息
String tips="";
if(ie.indexOf("MSIE")==-1){
	tips="您的浏览器非IE浏览器，请使用IE浏览器登录本系统 !";
}else{
	if(ie.indexOf("MSIE 11.0")==-1&&ie.indexOf("MSIE 10.0")==-1&&ie.indexOf("MSIE 9.0")==-1&&ie.indexOf("MSIE 8.0")==-1&&ie.indexOf("MSIE 7.0")==-1){
		tips="您的IE浏览器版本过低，请使用IE7及以上浏览器登录本系统！";
	}
}
String webPath =request.getContextPath()+"/";

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link rel="shortcut icon" type="image/x-icon" href="jsp/public/subsysimg/favicon.ico" />
<link rel="icon" type="image/x-icon" href="jsp/public/subsysimg/favicon.ico" />
<title>山东民政“金民工程”综合业务管理平台</title>
<style>
body { font-family: 宋体;font-size:14px; margin:0;background:url('<%=SkinUtils.getImage(request,"l5/r.png")%>') repeat-x #016fce top center}
.bd {
	font-family: 宋体;
	font-size: 14px;
	color: #376a81;
}
.textfield {
	BORDER-RIGHT: #000000 1px solid;
	BORDER-TOP: #000000 1px solid;
	FONT-WEIGHT: normal;
	BORDER-LEFT: #000000 1px solid;
	COLOR: #105194;
	BORDER-BOTTOM: #000000 1px solid;
	FONT-FAMILY: "Arial", "Helvetica", "sans-serif";
	TEXT-DECORATION: none;
	font-size: 14px;
}
a:link {
	font-family: 宋体;
	font-size: 14px;
	line-height: 150%;
	color: #4E5971;

}
a:visited {
	font-family: 宋体;
	font-size: 14px;
	color: #4E5971;
	text-decoration: none;
	line-height: 150%;
}
a:hover {
	font-family: 宋体;
	font-size: 14px;
	line-height: 150%;
	color: #0000FF;
	text-decoration: none;
}
#container {margin:0 auto; width:100%;background:url('<%=SkinUtils.getImage(request,"l5/loginTop.jpg")%>') no-repeat  top center}
#header { width:100%;height:315px}
#mainContent {overflow:hidden}
#login {width:100%; height:257px ;background:url('<%=SkinUtils.getImage(request,"l5/loginback.png")%>') no-repeat top center;}
#footer {width:100%;height:49px;position:fixed;bottom:0;background:url('<%=SkinUtils.getImage(request,"l5/logbg_bottom.png")%>') no-repeat;
          background-position:center center ;}
* html #footer{position:absolute;bottom:auto;
	  top:expression(eval(document.documentElement.scrollTop+document.documentElement.clientHeight-this.offsetHeight-(parseInt(this.currentStyle.marginTop,10)||0)-(parseInt(this.currentStyle.marginBottom,10)||0)));}
.textTile{height:50px;color:#000000;font-size:18px;text-align:center;vertical-align:middle;}
.textfield{font-size:20px;height:25px;padding-top:4px; }
</style>
<next:ScriptManager />
<script type="text/javascript" src="<%= request.getContextPath()%>/jsp/bsp/md5.js" ></script>
<script language="javascript">
var salt = "1#2$3%4(5)6@7!poeeww$3%4(5)djjkkldss";
window.onload = function(){
init();
//获取随机码
L5.Ajax.request({
url : L5.webPath + "/command/dispatcher/org.loushang.bsp.security.web.RandomCodeCommand",
sync : false,
callback : successHandler
});
function successHandler(options,success,response){
var o = L5.decode(response.responseText);
document.getElementById("rdmCode").value = o.code;
}
}

function doSession(){
if(window.dialogArguments!=null){
  window.dialogArguments.location=self.location;
  window.returnValue="aa";
  parent.close();
  return;
 }
 if(self!=top){top.location=self.location;}
}
doSession();
var bikky = document.cookie;
function getCookie(name) {
    var index = bikky.indexOf(name + "=");
    if (index == -1) return null;
    index = bikky.indexOf("=", index) + 1;
    var endstr = bikky.indexOf(";", index);
    if (endstr == -1) endstr = bikky.length;
    return unescape(bikky.substring(index, endstr));
}
var today = new Date();
var expiry = new Date(today.getTime() + 28 * 24 * 60 * 60 * 1000);
function setCookie(name, value) {
    if (value != null && value != "")
      document.cookie=name + "=" + escape(value) + "; expires=" + expiry.toGMTString();
    bikky = document.cookie;
}
function setall()
{
	var j_username = document.forms[0].j_username.value;
	setCookie("j_username",j_username);

}
function init()
{
	var j_username = getCookie("j_username");
	if (typeof j_username !="undefined" && j_username != null && j_username != "null") {
		document.forms[0].j_username.value = j_username;
	}
}
function doLogin(){
	if(!check()) return;
	setall();
    document.forms[0].action ="<%=j_auth_action%>";
    var password = document.getElementsByName("j_password")[0]; //获取输入密码
	password.value = hex_md5(password.value + "{" + salt + "}"); //对密码进行md5加密
    document.forms[0].submit();
}
function check(){
	var j_username = document.forms[0].j_username;
	if(j_username.value==""){
		alert("请输入用户名!");
		j_username.focus();
		return false;
	}
	j_username.value = j_username.value;
	var j_password = document.forms[0].j_password;
	if(j_password.value==""){
		alert("请输入密码!");
		j_password.focus();
		return false;
	}
	return true;

}
//'enter' key,/=47,*=42,+=43
function keypress(e)
{

	if(!window.event){
		e = e.which;
	}else{
		e = window.event.keyCode;
	}
	if(e==13||e==42)	//'enter' key,*
	{
		doLogin();
	}

}
function createShortcut(){
	try{
		var fso = new ActiveXObject("Scripting.FileSystemObject");
		var shell = new ActiveXObject("WScript.Shell");
		//获取桌面本地桌面地址
		var tagFolder = shell.SpecialFolders("Desktop") ;
		if(!fso.FolderExists(tagFolder )){
			fso.CreateFolder(tagFolder);
		}
		if(!fso.FileExists(tagFolder + "//金民工程.url")){
			//在指定的文件夹下创建名为baidu.lnk的快捷方式
			var link = shell.CreateShortcut(tagFolder + "//金民工程.url");
			//快捷方式指向的链接
			link.TargetPath = L5.webPath+"/";

			link.Save();

    }
	}catch(e) {
     //alert("当前IE安全级别不允许操作！");
	}
}

</script>
</head>
<body onkeydown="keypress(event);"  scroll="no">
 <DIV id=eMeng style="BORDER-RIGHT: #455690 1px solid; BORDER-TOP: #a6b4cf 1px solid; Z-INDEX:99999; right: 0px; VISIBILITY: hidden; BORDER-LEFT: #a6b4cf 1px solid; WIDTH: 340px; BORDER-BOTTOM: #455690 1px solid; POSITION: absolute; bottom: 0px; HEIGHT: 80px; BACKGROUND-COLOR: #c9d3f3">
	<TABLE style="BORDER-TOP: #ffffff 1px solid; BORDER-LEFT: #ffffff 1px solid" cellSpacing=0 cellPadding=0 width="100%" bgColor=#cfdef4 border=0>
	<TBODY>
		<TR>
			<TD style="FONT-WEIGHT: normal; FONT-SIZE: 12px; COLOR: #1f336b; PADDING-TOP: 4px;PADDING-left: 4px" align=left colSpan=2><span title=关闭 style="CURSOR: hand;color:red;font-size:12px;font-weight:bold;margin-right:4px;" onclick=closeDiv() >×</span> 消息提示：</TD>
			<TD style="PADDING-TOP: 2px;PADDING-right:2px" align=right width=19></TD>
		</TR>
		<%for(int k=0;k<msgDs.getCount();k++){%>
		<TR>
			<TD  colSpan=2 height=5 align="left">
				<DIV  style="display:block; font-size:12; float:left; text-decoration:none; white-space:nowrap; text-overflow:ellipsis; overflow: hidden; display:inline;color:#030303;">
				<font style="font-family: 宋体;"><%=msgDs.getRecord(k).get("MESSAGE_TITLE")%></font>
				</DIV>
			</TD>
			<TD  colSpan=1 height=5 align="right">
				<DIV style="display:block; font-size:12; float:left; text-decoration:none; white-space:nowrap; text-overflow:ellipsis; overflow: hidden; display:inline;color:#030303;">
				<a href=<%=webPath%>download?table=COM_MESSAGE_ATTACHMENT&column=FILE_CONTENT&filename=FILE_NAME&pk=ATTACHMENT_ID&ATTACHMENT_ID='<%=msgDs.getRecord(k).get("ATTACHMENT_ID")%>'><font style="font-family: 宋体;">附件</font></a>
				</DIV>
			</TD>
		</TR>
		<%} %>
	</TBODY>
	</TABLE>
</DIV>
<div id="container">
  <div id="header"></div>
  <div id="mainContent">
    <div id="login">
      <center>
	  <form name="frmLogin" method="post" action="">
        <table style="text-align:center">
         <tr>
            <td colspan="2" style="height:55px">&nbsp;</td>
          </tr>
          <tr>
            <td class="textTile">用户名:</td>
            <td ><input type="text" name="j_username"  value=""  class="textfield" size="21"/></td>
          </tr>
          <tr>
            <td class="textTile">密&nbsp;&nbsp;码:</td>
            <td><input type="password" name="j_password"  value="" class="textfield" size="21"/></td>
          </tr>
          <tr>
            <td colspan="2">
              <img style="cursor:hand;" src='<%=SkinUtils.getImage(request,"l5/dl.png")%>'  border="0" onclick="doLogin();" />
			  <!-- 增加存储随机码的隐藏域 -->
			  <input type="hidden" name="rdmCode" id="rdmCode"/>
            </td>
          </tr>
		  <tr>
			<td height="40" align="center" colspan=2><div UNSELECTABLE="on" style="width:400;font-size:12px;color:#FF9900;font-weight:bold;margin-bottom:25;"><%=msg%><br><label style="color:#FF0033;"><%=tips%></label></div></td>
		  </tr>

        </table>
	  </form>
      </center>

    </div>
  </div>
  <div id="footer"></div>
</div>
<script language="javascript">
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
	if(objTimer) window.clearInterval(objTimer);
}
</script>
</body>
</html>