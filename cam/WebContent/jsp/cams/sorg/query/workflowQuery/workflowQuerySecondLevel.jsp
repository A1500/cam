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
	String applyType = request.getParameter("applyType");
%>
<script>
	var date = '<%=date%>'; 
	var userId = '<%=userId%>';
	var username= '<%=username%>';
	var organId = '<%=organId%>';
	var cxsjq = '<%=request.getParameter("cxsjq")%>';
	var cxsjz = '<%=request.getParameter("cxsjz")%>';
	var applyType = '<%=applyType%>';
</script>
<html>
<head>
<next:ScriptManager />
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="workflowQuerySecondLevel.js"></script>
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
	<!-- 按照日期查询 已办理过的指定业务对应的所有社会组织列表 -->
	<model:dataset id="ds1" cmd="com.inspur.cams.sorg.query.cmd.SomWorkflowQueryCmd" global="true" method="queryList" >
	</model:dataset>
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
			</div>
			<br />
			<table style="border-style: hidden; width: 50%" cellpadding="0" cellspacing="0" border="0">
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
								<td class="tdTitle" style="width:2%;height:20px;line-height:30px;" align="center" >次序</td>
								<td class="tdTitle" style="width:8%;height:20px;line-height:30px;" align="center" >社会组织名称</td>
								<td class="tdTitle" style="width:8%;height:20px;line-height:30px;" align="center" >操作</td>
							</tr>
							<tr repeat="true">
								<td align="center"><label style="width: 20px;height: 20px;line-height: 30px;" field="ROW_NUM"></label></td>
								<td align="left" style="padding-left:20px"><a href="javascript:void(0)" style="cursor:pointer;text-decoration:none"><label style="height: 20px;line-height: 30px;" field="CN_NAME" onclick="queryNextLevel(this)"></label><label style="display: none;" field="PRIMARY_KEY" ></label></a></td>
								<td align="left" style="padding-left:20px"><a href="javascript:void(0)" style="cursor:pointer;text-decoration:none"><label style="height: 20px;line-height: 30px;" onclick="showAllApplyInfo(this)">查看业务办理情况</label><label style="display: none;" field="SORG_ID" ></label></a></td>
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
