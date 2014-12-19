<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title></title>
</head>
<next:ScriptManager />
<script>
function init() {
document.getElementById("printrightorleft").style.display="none";

}
function change() {
var serviceType;
var changeFlag;
var printtype = document.getElementById("printtype").value;
 if(printtype==""||printtype=="1") { 
 		document.getElementById("printrightorleft").style.display="none";
		serviceType="13";
		changeFlag="3";
	} else if(printtype=="2") {
		
		serviceType="18";
		changeFlag=document.getElementById("printrightorleft").value;
	}
	window.returnValue=serviceType+";"+changeFlag;
	window.close();
}
function changeStyle() {
var printtype = document.getElementById("printtype").value;
 if(printtype==""||printtype=="1") { 
 	document.getElementById("printrightorleft").style.display="none";
 	} else if(printtype=="2") {
 	document.getElementById("printrightorleft").style.display="";
	}
}
</script>
<body>
<table >
	<tr>
		<td>
		<select name="printtype" id="printtype" onchange="changeStyle()">
		<option value="1">打证
		<option value="2">变更
		</select>
		</td>
		<td>
		<select name="printrightorleft" id="printrightorleft" >
		<option value="0">左变更
		<option value="1">右变更
		</select>
		</td>
		<td><input type="button" name="close" value="确定" onClick="change();" />

</td>
	</tr>
</table>
</body>
</html>