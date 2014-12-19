<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<html>
<head>
<title>js调试设置页面</title>
<next:ScriptManager></next:ScriptManager>
<script language="javascript">
function init(){
	var debug=L5.get("debugger");
	if(L5.getDebug()){
		debug.dom.firstChild.nodeValue="关闭调试";
	}else{
		debug.dom.firstChild.nodeValue="开启调试";
	}
}
function debug(){
	var debug=L5.get("debugger");
	if(debug.dom.firstChild.nodeValue=="开启调试"){
		L5.setDebug(true);
		debug.dom.firstChild.nodeValue="关闭调试";
	}else{
		L5.setDebug(false);
		debug.dom.firstChild.nodeValue="开启调试";
	}
}
</script>
</head>
<body>
<button id="debugger" name="debugger" onclick="debug()">开启调试</button>

</body>
</html>