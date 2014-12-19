<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>证件打印</title>
<style type="text/css">
<!--
.STYLE1 {font-size: x-large}
.STYLE4 {color: #FFFF66}
.STYLE5 {color: #0033FF}
.STYLE7 {font-size: 14px}
.STYLE8 {font-size: 14}
-->
</style>
</head>
<next:ScriptManager />
<script>
function init() {
document.getElementById("printrightorleft").style.display="none";
document.getElementById("changeContent").style.display="none";
}
function change() {
var serviceType;
var changeFlag;
var change;
var printtype = document.getElementById("printtype").value;
 if(printtype==""||printtype=="1") { 
 		document.getElementById("printrightorleft").style.display="none";
 		document.getElementById("changeContent").style.display="none";
		serviceType="13";
		changeFlag="3";
	} else if(printtype=="2") {
		
		serviceType="18";
		changeFlag=document.getElementById("printrightorleft").value;
	}
	if(document.getElementById("printtype").value!=null||document.getElementById("printtype").value!=""){
		change = encodeURI(document.getElementById("change").value);
	}
	window.returnValue=serviceType+";"+changeFlag+";"+change;
	window.close();
}
function changeStyle() {
var printtype = document.getElementById("printtype").value;
 if(printtype==""||printtype=="1") { 
 	document.getElementById("printrightorleft").style.display="none";
 	document.getElementById("changeContent").style.display="none";
 	} else if(printtype=="2") {
 	document.getElementById("printrightorleft").style.display="";
 	document.getElementById("changeContent").style.display="";
	}
}
</script>
<body bgcolor="DFE8F7">
<table align="center" bgcolor="DFE8F7">
    <tr><td  colspan="3" class="STYLE4"><div align="center" class="STYLE1  STYLE5">证件打印</div></td>
    </tr>
    <tr><td  colspan="3"> -------------------------------------------------------------</td></tr>
	<tr>
		<td><span class="STYLE8">请选择打印类型：</span></td>
		<td>
		<select name="printtype" id="printtype" onChange="changeStyle()">
		<option value="1">打证
		<option value="2">变更
		</select>		</td>
		<td width="145">
		<select name="printrightorleft" id="printrightorleft" >
		<option value="0">左变更
		<option value="1">右变更
		</select>	  </td>
  </tr>
		<tr>
		<td colspan="3" id="changeContent"><span class="STYLE7">变更内容：</span>		  <textarea name="change" style="height: 180;width: 300"> </textarea></td>
	</tr>
	<tr>
		  <td colspan="3"><img src="img/sure.jpg" align="right" onClick="change()" />  </td>
	</tr>
</table>
</body>
</html>