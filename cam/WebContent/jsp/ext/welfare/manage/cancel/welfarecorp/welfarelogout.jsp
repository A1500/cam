<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<next:ScriptManager />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<style type='text/css'>
<!--
.style1 {
	color: #FF0000;
	font-weight: bold;
}
-->
</style>
<STYLE>
body {
	background-color: #ffffff;
	color: #000000;
	margin-left: 0;
	margin-top: 0;
	margin-width: 0;
	margin-height: 0;
	margin: 0px;
	font-size: 12px;
	font-family: '宋体 ';
	font-weight: normal;
	line-height: 18px;
}

table {
	color: #000000;
	font-size: 14px;
	font-family: '宋体 ';
	font-weight: normal;
}

textarea {
	overflow-x: hidden;
	overflow-y: hidden;
}

.text {
	font-size: 14px;
	line-height: 20px;
}

.text1 {
	font-size: 16px;
	letter-spacing: normal;
}

.text2 {
	font-size: 14px;
	line-height: 30px;
	letter-spacing: normal;
}

.unnamed1 {
	border: 1 solid #000000;
	font-size: 18px;
}

.unnamed2 {
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #000000;
	font-size: 18px;
}

.unnamed3 {
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	font-size: 18px;
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #000000;
	border-left-width: 1px;
	border-left-style: solid;
	border-left-color: #000000;
}

.unnamed4 {
	border-top-width: 1px;
	border-top-style: solid;
	border-top-color: #000000;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	font-size: 18px;
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #000000;
}
.thead1 {
	font-family: '宋体';
	font-size: 20px;
	font-weight: bold;
	color: #000000;
}
</STYLE>
<div id="float"><input type="button" value="保存"
	style="height: 25px; width: 80px; position: absolute; margin-left: 20px;" />
</div>
<table align="center">
	<tr><td height="80"></td></tr>
	<tr>
		<td align="center" class="thead1"><strong>社会福利企业</strong></td>
	</tr>
	<tr>
		<td align="center" class="thead1"><strong>注销备案表</strong></td>
	</tr>
	<tr>
		<td>
		<form action="post" onsubmit="return false">
		<table width="600" align="center" border=1 cellpadding="0" class='unnamed1'	cellspacing="0">
			<tr>
				<td colspan="2" nowrap="nowrap" align="center" class='unnamed1'>企业名称</td>
				<td colspan="3" class='unnamed1'>
				<p align="left"><input type="text" name="企业名称" id="企业名称" /></p>
				</td>
				<td colspan="2" align="center" class='unnamed1'>编&nbsp;&nbsp;号</td>
				<td colspan="3" class='unnamed1'>
				<p align="left"><input type="text" name="编号" id="编号" /></p>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center" class='unnamed1'>联系人</td>
				<td colspan="3" class='unnamed1'>
				<p align="left"><input type="text" name="联系人" id="联系人" /></p>
				</td>
				<td colspan="2" class='unnamed1'>联系电话</td>
				<td colspan="3" class='unnamed1'>
				<p align="left"><input type="text" name="联系电话" id="联系电话" /></p>
				</td>
			</tr>
			<tr>
				<td rowspan="16" colspan="2" align="center" valign="middle"
					class='unnamed1'><br />
				<br />
				注<br />
				销<br />
				原<br />
				因<br />
				<br />
				<br />
				</td>
				<td rowspan="16" colspan="8" class='unnamed1'><textarea
					rows="15" cols="100"></textarea></td>
			</tr>
			<tr></tr>
			<tr></tr>
			<tr></tr>
			<tr></tr>
			<tr></tr>
			<tr></tr>
			<tr></tr>
			<tr></tr>
			<tr></tr>
			<tr></tr>
			<tr></tr>
			<tr></tr>
			<tr></tr>
			<tr></tr>
			<tr></tr>
			<tr></tr>
			<tr></tr>
			<tr></tr>
			<tr>
				<td rowspan="6" colspan="5" class='unnamed1'><br />
				<p align="left">&nbsp;法定代表人</p>
				<p align="left">&nbsp;&nbsp;&nbsp;签章：</p>
				<p align="right"><input type="text" name="year" id="year"
					size=30 format="Y年m月d日" onclick="LoushangDate(this)"
					readonly="readonly" style="text-align: center" /></p>
				</td>



				<td rowspan="6" colspan="5" class='unnamed1'><br />
				<p align="left">&nbsp;企业盖章</p>
				<br />
				<br />
				<p align="right"><input type="text" name="year" id="year"
					size=30 format="Y年m月d日" onclick="LoushangDate(this)"
					readonly="readonly" style="text-align: center" /></p>
				</td>
			</tr>
		</table>
		</form>
		</td>
	</tr>
</body>
</html>