<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="java.util.*"%>
<html>
<head>
<title>页面列描述列表</title>
<next:ScriptManager></next:ScriptManager>
<style>
.body2 {
	background-color: #EAF4FD;
}

.table2 {
	border-collapse: collapse;
}

.input2 {
	background-color: #EAF4FD;
	border-style: none;
	text-align: right;
}

.btTitle {
	word-break: break-all;
	font-weight: bold;
	font-size: x-small;
}

.tdTitle {
	border-style: solid;
	border-color: #000000;
	border-width: 1.5px;
	height: 20px;
	word-break: break-all;
	font-weight: bold;
}

.tr2 {
	yexj00: expression(this . style . background =( rowIndex % 2 == 1) ?  
		'white ' :   '#EAF4FD ' )
}

.td2 {
	border-style: solid;
	border-color: #000000;
	border-width: 1px;
}

.tdIma {
	background-image: url(line.bpm);
	background-repeat: no-repeat;
}
</style>
<%
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月dd日");
	String date = sdf.format(new Date());
%>
<script type="text/javascript">
    var orgCode ='<%=BspUtil.getOrganCode()%>';
	var orgName ='<%=BspUtil.getOrganName()%>';
</script>
<script type="text/javascript" src="fisColumnInfoList.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
</head>
<body>
<model:datasets>
	<model:dataset id="fisColumnInfoDataSet" cmd="com.inspur.cams.fis.base.cmd.FisColumnInfoQueryCmd" pageAble="false" sortField="SEQ">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisColumnInfo"/>
	</model:dataset>
</model:datasets>
<next:Panel width="100%" border="0">
	<next:Html>
	<fieldset style="overflow:visible;" class="GroupBox">
	<legend class="GroupBoxTitle">查询条件</legend>
		<form class="L5form">
			<table border="1" width="100%">
				<tr>
					<td class="FieldButton" style="width:20%"><button onclick="query()">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;<button type="reset">重置</button></td>
				</tr>
			</table>
		</form>
	</fieldset>
	</next:Html>
</next:Panel>
<!--逝者信息列表结束 -->
<next:Panel id="editDeadPanel"  bodyStyle="background-color:#EAF4FD;padding-bottom:10px;padding-top:12px;" width="100%"  
	height="100%" autoScroll="true">
	<next:Html>
		<div align="center" id="reDiv" style="overflow-y: scroll;">
		<div align="center" style="width: 800px;">
			<div align="center"><span id="reportTitle"
				style="font-size: large;">火化量分殡仪馆统计表</span></div>
		</div>
		<div align="right" class="L5form">
		<button onclick="exportExcel()" style="right: 50px;">导出Excel</button>&nbsp;&nbsp;&nbsp;&nbsp;
		</div>
		<br />
		<table style="border-style: hidden; width: 800px;" class="table2"
			cellpadding="0" cellspacing="0" border="0" >
			<tr class="tr2">
				<td colspan="5" style="border-width: 0px" class="td2">
				<div align="left"><span class="btTitle">统计单位：<%=BspUtil.getOrganName()%></span></div>
				<td colspan="4" style="border-width: 0px" class="td2">
				<div align="right"><span class="btTitle">统计时间：<label
					id="statisticsTime" class="btTitle"></span></div>
			</tr>
			<table id="currentT" width="800px" class="table2" align="center">
				<tr class="tr2">
					<td class="tdTitle" align="center" rowspan="3">单位</td>
					<td class="tdTitle" align="center" colspan="2" rowspan="2">总数</td>
					<td class="tdTitle" align="center" colspan="6">年龄段</td>
				</tr>
				<tr class="tr2">
					<td class="tdTitle" align="center" colspan="2">0-35岁</td>
					<td class="tdTitle" align="center" colspan="2">36-49岁</td>
					<td class="tdTitle" align="center" colspan="2">50-59岁</td>
				</tr>
				<tr class="tr2">
					<td class="tdTitle" align="center">&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td class="tdTitle" align="center">女</td>
					<td class="tdTitle" align="center">&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td class="tdTitle" align="center">女</td>
					<td class="tdTitle" align="center">&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td class="tdTitle" align="center">女</td>
					<td class="tdTitle" align="center">&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td class="tdTitle" align="center">女</td>
				</tr>
			</table>
			<table width="800px" class="table2">
				<tr class="tr2">
					<td class="td2" colspan="5" style="border-width: 0px">
					<div align="left"><span class="btTitle">制表人：<%=BspUtil.getEmpOrgan().getShortName()%></span></div>
					</td>
					<td class="td2" colspan="4" style="border-width: 0px">
					<div align="right"><span class="btTitle">制表时间：<%=date%></span></div>
					</td>
				</tr>
			</table>
		</table>
		</div>
	</next:Html>
</next:Panel>
</body>
</html>