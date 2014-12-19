<%@ page contentType="text/html; charset=UTF-8"%>
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
	
%>
<script>
	var xzqu = '<%=request.getParameter("xzqu")%>';
</script>
<html>
<head>
<next:ScriptManager />
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="RegistrationDeptQueryQx.js"></script>
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
	<model:dataset id="ds"
		cmd="com.inspur.cams.marry.query.papers.cmd.MarryRegistrarQueryCmd" global="true" method="query"
		autoLoad="false">
		<model:record>
			<model:field name="ORGAN_CODE"/>
			<model:field name="ORGAN_NAME"/>
			<model:field name="TOTAL_NUM"/>
			<model:field name="XZ"/>
			<model:field name="CGGL"/>
			<model:field name="QESYB"/>
			<model:field name="CHU"/>
			<model:field name="KE"/>
			<model:field name="FUKE"/>
			<model:field name="GUJI"/>
			<model:field name="AREA"/>
			<model:field name="THREEA"/>
			<model:field name="FOURA"/>
			<model:field name="FIVEA"/>
			
		</model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
	<next:Panel width="100%" border="0"
		bodyStyle="background-color:#EAF4FD;padding-bottom:10px;padding-top:12px;"
		height="100%" autoScroll="true">
		<next:Html>
			<div align="center" id="reDiv" style="display: none;">
			<div align="center" style="width: 90%;">
			<div align="center"><span id="reportTitle"
				style="font-size: large;">登记机关统计分析</span></div>
			</div>
			<div align="right" class="L5form">
			<button onclick="forExcel()">导出Excel</button>&nbsp;&nbsp;&nbsp;&nbsp;
			<button onclick="back()">返回</button>
			</div>
			<br />
			<table style="border-style: hidden; width: 90%" cellpadding="0" cellspacing="0"
				border="0">
				 <tr>
					<td colspan="32" style="border-width: 0px">
					<div align="left"><span class="btTitle">统计单位：<%= BspUtil.getOrganName()%></span></div></td>
				</tr>
				<tr >
					<td colspan="4" style="border-width: 0px">
					<table width="100%" dataset="ds" align="center" >
						<tbody id="resultsBody">
						<tr>
							<td class="tdTitle" width="12%" align="center" rowspan="2">单位</td>
							<td class="tdTitle" width="4%" align="center" rowspan="2">总数</td>
							<td class="tdTitle" width="4%" align="center" colspan="3">性质</td>
							<td class="tdTitle" width="4%" align="center" colspan="4">级别</td>
							<td class="tdTitle" width="4%" align="center" colspan="3">等级</td>
							
						</tr>
						<tr>
							<td class="tdTitle" width="2%" align="center" >行政</td>
							<td class="tdTitle" width="2%" align="center" >参公<br>管理</td>
							<td class="tdTitle" width="2%" align="center" >金额<br>拨款</td>
							<td class="tdTitle" width="2%" align="center" >处</td>
							<td class="tdTitle" width="2%" align="center" >科</td>
							<td class="tdTitle" width="2%" align="center" >副科</td>
							<td class="tdTitle" width="2%" align="center" >股级</td>
							<td class="tdTitle" width="2%" align="center" >3A</td>
							<td class="tdTitle" width="2%" align="center" >4A</td>
							<td class="tdTitle" width="2%" align="center" >5A</td>
						</tr>
						<tr repeat="true">
							<td align="center"><label field="ORGAN_NAME"/></label></td>
							<td align="right"><label style="width: 80px;height: 20px;" field="TOTAL_NUM"/></label></td>
							<td align="right"><label style="width: 50px;height: 20px;" field="XZ"/></label></td>
							<td align="right"><label style="width: 50px;height: 20px;" field="CGGL"/></label></td>
							<td align="right"><label style="width: 50px;height: 20px;" field="QESYB"/></label></td>
							<td align="right"><label style="width: 50px;height: 20px;" field="CHU"/></label></td>
							<td align="right"><label style="width: 50px;height: 20px;" field="KE"/></label></td>
							<td align="right"><label style="width: 50px;height: 20px;" field="FUKE"/></label></td>
							<td align="right"><label style="width: 50px;height: 20px;" field="GUJI"/></label></td>
							<td align="right"><label style="width: 50px;height: 20px;" field="THREEA"/></label></td>
							<td align="right"><label style="width: 50px;height: 20px;" field="FOURA"/></label></td>
							<td align="right"><label style="width: 50px;height: 20px;" field="FIVEA"/></label></td>
						
						</tr>
						
						</tbody>
					</table>
					</td >
				</tr>
				<tr>
							<td colspan="3" style="border-width: 0px">
							<div align="left"><span class="btTitle">制表人：<%=username %></span></div></td>
							<td colspan="2" style="border-width: 0px">
							<div align="right"><span class="btTitle">制表时间：<%=date %></span></div></td>
						</tr>
			</table>
			</div>
			
		</next:Html>
	</next:Panel>
</next:ViewPort>
</body>
</html>
