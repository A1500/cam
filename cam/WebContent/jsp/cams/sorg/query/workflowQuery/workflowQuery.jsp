<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<%
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy年MM月dd日");
	String date=sdf.format(new Date());
	String username= GetBspInfo.getBspInfo(request).getUserName();
	String userId = GetBspInfo.getBspInfo(request).getUserId();
	String organId = GetBspInfo.getBspInfo(request).getEmployeeOrganId();
%>
<script>
	var userId = '<%=userId%>';
	var username= decodeURIComponent('<%=username%>');
	var organId = '<%=organId%>';
	var date = '<%=date%>';
	var cxsjq = '<%=request.getParameter("cxsjq")%>';
	var cxsjz = '<%=request.getParameter("cxsjz")%>';
</script>
<html>
<head>
<next:ScriptManager />
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="workflowQuery.js"></script>
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

<script language="javascript">
 	 //查询条件打开合并函数
	 function collapse(element){
		var fieldsetParent=L5.get(element).findParent("fieldset");
		if(element.expand==null||element.expand==true){
			fieldsetParent.getElementsByTagName("div")[0].style.display="none";
			element.src = '<%=SkinUtils.getImage(request, "groupbox_expand.gif")%>';
			element.expand=false;
		}else{
			fieldsetParent.getElementsByTagName("div")[0].style.display="";
			element.src = "<%=SkinUtils.getImage(request, "groupbox_collapse.gif")%>";
			element.expand =true;
		}
	}
</script>
</head>
<body>
<model:datasets>
	<!-- 按照日期查询 已办理过的业务数量 -->
	<model:dataset id="ds1" cmd="com.inspur.cams.sorg.query.cmd.SomWorkflowQueryCmd" global="true" method="queryNum" >
	</model:dataset>
</model:datasets>
<next:ViewPort>
	<next:Panel name="form" width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="25%">
		<next:Html>
			<fieldset style="overflow: visible;" class="GroupBox"><legend
				class="GroupBoxTitle">查询条件 <img
				class="GroupBoxExpandButton"
				src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>"
				onclick="collapse(this)" /> </legend>
			<div>
			<form style="width: 95%; height: 100%;" class="L5form">
			<table border="1" width="100%">
				<tr>
					<td class="FieldLabel">统计时间:</td>
					<td class="FieldInput" colspan="2" >
						<input type="text" name="cxsjq_y" id="cxsjq_y" onchange="CheckTxt('y','cxsjq_y');" maxlength="4" style=" width: 60px;"/>年
						<select id = "cxsjq_m" style="width: 50px;"></select>月
						<input type="text" name="cxsjq_d" id="cxsjq_d" onchange="CheckTxt('d','cxsjq_d');" maxlength="2" style=" width: 30px;"/>日
						------
						<input type="text" name="cxsjz_y" id="cxsjz_y" onchange="CheckTxt('y','cxsjz_y');" maxlength="4" style=" width: 60px;"/>年
						<select id = "cxsjz_m" style="width: 50px;"></select>月
						<input type="text" name="cxsjz_d" id="cxsjz_d" onchange="CheckTxt('d','cxsjz_d');" maxlength="2" style=" width: 30px;"/>日
					<td class="FieldLabel">
						<button onclick="query()" id="queryButton">查 询</button>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<button onclick="initTime()">重 置</button>
					</td>
				</tr>
			</table>
			</form>
			</div>
			</fieldset>
		</next:Html>
	</next:Panel>
	<next:Panel id="dataPanel" title="当前登录用户已处理的业务流程查询统计" bodyStyle="background-color:#EAF4FD;padding-bottom:10px;padding-top:12px;" height="100%" autoScroll="true">
		<next:Html>
			<div align="center" id="reDiv" style="display: none;">
			<div align="center" style="width: 90%;">
			<div align="center"><span id="reportTitle"
				style="font-size: large;">业务流程查询统计表</span></div>
			</div>
			<div align="right" class="L5form">
					<button onclick="forExcel()">导出Excel</button>&nbsp;&nbsp;
				</div>
			<br />
			<table style="border-style: hidden; width: 90%" cellpadding="0" cellspacing="0" border="0">
				 <tr>
					<td colspan="2" style="border-width: 0px">
					<div align="left"><span class= "btTitle">统计人员：<%=username%></span></div></td>
					<td colspan="2" style="border-width: 0px">
					<div align="right"><span class= "btTitle">统计时间：<label id="statisticsTime" class= "btTitle"></span></div></td>
				</tr>
				<tr >
					<td colspan="4" style="border-width: 0px">
						<table width="100%" dataset="ds1" align="center" id = "sourceTable" >
							<tr>
								<td class="tdTitle" style="width:8%;height:20px;line-height:30px;" align="center" >社会组织种类</td>
								<td class="tdTitle" width="20%" align="center" >业务种类</td>
								<td class="tdTitle" width="10%" align="center" >合计</td>
							</tr>
							<tr repeat="true">
								<td align="center"><label style="width: 100px;height: 20px;line-height: 30px;" field="SORG_TYPE" ></label></td>
								<td align="left" style="padding-left:5px"><label field="APPLY_TYPE_NAME" ></label></td>
								<td align="center"><a href="javascript:void(0)" style="cursor:pointer;text-decoration:none"><label field="NUM" onclick="queryNextLevel(this)" style="font-size:20px;width:50px"></label><label style="display: none;" field="APPLY_TYPE" ></label></a></td>
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
