<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<%@page import="java.net.URLDecoder"%>
<%
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy年MM月dd日");
	String date=sdf.format(new Date());
	String username=(String)request.getParameter("username");
	if(username == null){
		username = "";
	}else{
		username = URLDecoder.decode((String)username, "UTF-8");
	}
	String userId = request.getParameter("userId");
	String organId = request.getParameter("organId");
	String primaryKey = request.getParameter("primaryKey");
	String applyType = request.getParameter("applyType");
%>
<script>
	var date = '<%=date%>'; 
	var userId = '<%=userId%>';
	var username= '<%=username%>';
	var organId = '<%=organId%>';
	var cxsjq = '<%=request.getParameter("cxsjq")%>';
	var cxsjz = '<%=request.getParameter("cxsjz")%>';
	var primaryKey = '<%=primaryKey%>';
	var applyType = '<%=applyType%>';
</script>
<html>
<head>
<next:ScriptManager />
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="workflowQueryThirdLevel.js"></script>
<style>
body {
	background-color: #EAF4FD;
}

table {
	border-collapse: collapse;
}

input {
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

tr{   
	yexj00:expression(this.style.background=(rowIndex%2==1)? 'white ': '#EAF4FD ')
} 

td {
	border-style: solid;
	border-color: #000000;
	border-width: 1px;
}
.tdIma {
	background-image: url(line.bpm);
	background-repeat: no-repeat;
}
</style>

</head>
<body>
<model:datasets>
	<!-- 按照日期查询 已办理过的业务中指定的社会组织对应的所有环节情况 -->
	<model:dataset id="ds1" cmd="com.inspur.cams.sorg.query.cmd.SomWorkflowQueryCmd" global="true" method="queryDetail" >
	</model:dataset>
	<model:dataset id="opinionSelect" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:ViewPort>
	<next:Panel id="dataPanel" title="当前登录用户已处理的业务流程查询统计" bodyStyle="background-color:#EAF4FD;padding-bottom:10px;padding-top:12px;" height="100%" autoScroll="true">
		<next:Html>
			<div align="center" id="reDiv" style="display: none;">
			<div align="center" style="width: 90%;">
			<div align="center"><span id="reportTitle"
				style="font-size: large;">业务流程查询统计表</span></div>
			</div>
			<div align="right" class="L5form">
				<button onclick="forExcel()">导出Excel</button>&nbsp;&nbsp;
				<button onclick="back()">返回上一层</button>&nbsp;&nbsp;
				<button onclick="backFirst()">返回第一层</button>&nbsp;&nbsp;
			</div>
			<br />
			<table style="border-style: hidden; width: 90%" cellpadding="0" cellspacing="0" border="0">
				 <tr>
					<td colspan="2" style="border-width: 0px">
					<div align="left"><span class= "btTitle">统计人员：<%=username%></span></div></td>
					<td colspan="2" style="border-width: 0px">
					<div align="right"><span class= "btTitle">统计时间：<label id="statisticsTime" class= "btTitle"></span></div></td>
				</tr>
				<tr style="text-align:center">
					<td colspan="4" style="border-width: 0px">
						<table width="100%" dataset="ds1" style="margin:auto" align="center" id = "sourceTable" >
							<tr>
								<td class="tdTitle" style="height:20px;line-height:30px;" colspan="2" >业务类型：<label id="PROC_DEF_NAME"></label></td>
								<td class="tdTitle" style="height:20px;line-height:30px;" colspan="2" >流程是否完结：<label id="ifFinish"></label></td>
								<td class="tdTitle" style="height:20px;line-height:30px;" colspan="2" >流程创建时间：<label id="PROC_CREATE_TIME"></label></td>
								<td id="procEndTime" class="tdTitle" style="height:20px;line-height:30px;" colspan="2" >流程结束时间：<label id="PROC_END_TIME"></label></td>
								<td id="activeActDefNames" class="tdTitle" style="height:20px;line-height:30px;" colspan="2" >当前处理环节：<label id="ACTIVE_ACT_DEF_NAMES"></label></td>
							</tr>
							<tr>
								<td class="tdTitle" style="width:6%;height:20px;line-height:30px;" align="center" >环节</td>
								<td class="tdTitle" style="width:8%;height:20px;line-height:30px;" align="center" >环节创建时间</td>
								<td class="tdTitle" style="width:8%;height:20px;line-height:30px;" align="center" >环节结束时间</td>
								<td class="tdTitle" style="width:8%;height:20px;line-height:30px;" align="center" >处理人</td>
								<td class="tdTitle" style="width:6%;height:20px;line-height:30px;" align="center" >处理意见</td>
								<td class="tdTitle" style="width:8%;height:20px;line-height:30px;" align="center" >补充意见</td>
								<td class="tdTitle" style="width:8%;height:20px;line-height:30px;" align="center" >处理人所在单位</td>
								<td class="tdTitle" style="width:8%;height:20px;line-height:30px;" align="center" >处理人所在部门</td>
							</tr>
							<tr repeat="true">
								<td align="center"><label style="height: 20px;line-height: 30px;" field="ACT_DEF_NAME"></label></td>
								<td align="center"><label style="height: 20px;line-height: 30px;" field="CREATE_TIME"></label></td>
								<td align="center"><label style="height: 20px;line-height: 30px;" field="END_TIME"></label></td>
								<td align="center"><label style="height: 20px;line-height: 30px;" field="ACTOR_NAME"></label></td>
								<td align="center"><label style="height: 20px;line-height: 30px;" field="OPINION_ID" dataset="opinionSelect"></label></td>
								<td align="center"><label style="height: 20px;line-height: 30px;" field="OPINION"></label></td>
								<td align="center"><label style="height: 20px;line-height: 30px;" field="ORGAN_NAME"></label></td>
								<td align="center"><label style="height: 20px;line-height: 30px;" field="DEPT_NAME"></label></td>
							</tr>
						</table>
					</td >
				</tr>
				<tr>
					<td colspan="2" style="border-width: 0px">
					<div align="left"><span class= "btTitle">制表人：<%=username %></span></div></td>
					<td colspan="2" style="border-width: 0px">
					<div align="right"><span class= "btTitle">制表时间：<%=date %></span></div></td>
				</tr>
			</table>
			</div>
		</next:Html>
	</next:Panel>
</next:ViewPort>
</body>
</html>
