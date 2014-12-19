<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy年MM月dd日");
	String date=sdf.format(new Date());	
	String username= GetBspInfo.getBspInfo(request).getUserName();
%>
<script>
	var xzqu = '<%=request.getParameter("xzqu")%>';
	var cxsjq = '<%=request.getParameter("cxsjq")%>';
	var cxsjz = '<%=request.getParameter("cxsjz")%>';
	var military = '<%=request.getParameter("military")%>';
	var pageflag ='<%=request.getParameter("pageflag")%>';
</script>
<html>
<head>
<next:ScriptManager />
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="query_military.js"></script>
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
		<model:dataset id="OrgNameDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="false">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CITY'></model:param>
			<model:param name="value" value='ID'></model:param>
			<model:param name="text" value='FULL_NAME'></model:param>
		</model:params>
	</model:dataset>
		<model:dataset id="ds"
		cmd="com.inspur.cams.prs.query.cmd.PrsMilitaryCmd" global="true"
		autoLoad="false">
		<model:record>
			<model:field name="ORGAN_CODE" type="string" />
			<model:field name="ORGAN_NAME" type="string" />
			
			<model:field name="retiredSoldiers" type="string" />
			<model:field name="transferredOfficer" type="string" />
			<model:field name="demobilizedOfficer" type="string" />
			<model:field name="disabilitySoldiers" type="string" />
			<model:field name="totalCount" type="string" />
			
		</model:record>
	</model:dataset>
	<model:dataset id="MilitaryRegionCodeDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_MILITARY_REGION_CODE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>
<next:ViewPort>
	<next:Panel width="100%" border="0"
		bodyStyle="background-color:#EAF4FD;padding-bottom:10px;padding-top:12px;"
		height="100%" autoScroll="true">
		<next:Html>
			<div align="center" id="reDiv" style="display: none;">
			<div align="center" style="width: 99%;">
				<div  >
					<div style="float: right;" class="L5Form">
						<button id="excel" onclick="exportCSV()">导出Excel</button>
					</div>
					<div style="float: right;" class="L5form">
					<button onclick="back()">返回</button>
					</div>
				</div>
			<div align="center"><span id="reportTitle"
				style="font-size: large;">山东省退役士兵统计表</span></div>
			</div>
			<br />
			<table style="border-style: hidden; width: 90%" cellpadding="0"
				cellspacing="0" border="0">
				<tr style="border-width: 0px">
					<td colspan="2" style="border-width: 0px">
					<div align="left"><span class="btTitle">统计单位：<%=BspUtil.getOrganName()%></span></div>
					<td colspan="2" style="border-width: 0px">
					<div align="right"><span class="btTitle">统计时间：<label id="statisticsTime" /></span></div>
				</tr>
				<tr>
					<td colspan="4" style="border-width: 0px">
					<table width="100%" dataset="ds" align="center">
						<tr>
							<td class="tdTitle" width="30%" align="center" > 地&nbsp;&nbsp;&nbsp;区</td>
							<td class="tdTitle" width="10%" align="center" >总计</td>
							<td class="tdTitle" width="10%" align="center" >退伍义务兵</td>
							<td class="tdTitle" width="10%" align="center"   >转业士官</td>
							<td class="tdTitle" width="10%" align="center" >复员干部</td>
							<td class="tdTitle" width="10%" align="center" >伤病残士兵</td>

						</tr>
						
						<tr repeat="true">
							<td align="center"><a href="#"><label readonly="true" style="width:100px;height: 20px;line-height:20px;"
								onclick="test(this)" field="ORGAN_NAME" /></label><label
								style="display: none" readonly="true" field="ORGAN_CODE" /></label></a></td>
							
							<td align="right"><a href="#"><label  onclick="querydetail(this,'5')"  field="totalCount" ></label><label
								style="display: none"  field="ORGAN_CODE" ></label></a></td>
							<td align="right"><a href="#"><label  onclick="querydetail(this,'1')"  field="retiredSoldiers" ></label><label
								style="display: none"  field="ORGAN_CODE" ></label></a></td>
								
							<td align="right"><a href="#"><label  onclick="querydetail(this,'2')"  field="transferredOfficer" ></label><label
								style="display: none"  field="ORGAN_CODE" ></label></a></td>
								
							<td align="right"><a href="#"><label  onclick="querydetail(this,'3')"  field="demobilizedOfficer" ></label><label
								style="display: none"  field="ORGAN_CODE" ></label></a></td>
								
							<td align="right"><a href="#"><label  onclick="querydetail(this,'4')"  field="disabilitySoldiers" ></label><label
								style="display: none"  field="ORGAN_CODE" ></label></a></td>
							
						</tr>
						
					</table>
					</td>
				</tr>
				<tr>
					<td colspan="2" style="border-width: 0px">
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