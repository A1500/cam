<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<html>
<head>
<title>全国收养登记管理信息系统</title>
<script language="javascript">      
var _w = window.screen.availWidth;
var _h = window.screen.availHeight;
var win = window.open('http://adopt.mca.gov.cn/adopt','_blank','height='+_h+',width='+_w+',top=0,left=0,toolbar=yes,menubar=yes,scrollbars=yes, resizable=yes,location=yes, status=yes');
var ifRun = false;
function test(){
	//win.close();
	if(!ifRun)
		win.location="adoptMain.jsp";
	window.opener='';
	window.close();
	window.setTimeout(test, 1000);
}
window.setTimeout(test, 2000);
</script>
</head>
<body>
</body>
</html>
