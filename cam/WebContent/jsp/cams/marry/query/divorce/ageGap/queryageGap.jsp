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
	var organCode = '<%=BspUtil.getOrganCode()%>';
	var cxsjq = '<%=request.getParameter("cxsjq")%>';
	var cxsjz = '<%=request.getParameter("cxsjz")%>';
</script>
<html>
<head>
<next:ScriptManager />
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
	<script type="text/javascript" src="../../../../../comm/highchart/js/jquery.min.js"></script>
<script type="text/javascript" src="../../../../../comm/highchart/js/highcharts.js"></script>
<script type="text/javascript" src="queryageGap.js"></script>
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
		cmd="com.inspur.cams.marry.query.divorce.cmd.DivorceAgeGapQueryCmd" global="true" method="query"
		autoLoad="false">
		<model:record>
			<model:field name="ITEM_CODE"/>
			<model:field name="ITEM_NAME"/>
			<model:field name="SEX_NAME"/>
			<model:field name="TOTAL_NUM"/>
			<model:field name="GAP0_NUM"/>
			<model:field name="GAP0_RATE"/>
			<model:field name="GAP1_NUM"/>
			<model:field name="GAP1_RATE"/>
			<model:field name="GAP2_NUM"/>
			<model:field name="GAP2_RATE"/>
			<model:field name="GAP3_NUM"/>
			<model:field name="GAP3_RATE"/>
			<model:field name="GAP4_NUM"/>
			<model:field name="GAP4_RATE"/>
			<model:field name="GAP5_9_NUM"/>
			<model:field name="GAP5_9_RATE"/>
			<model:field name="GAP10_14_NUM"/>
			<model:field name="GAP10_14_RATE"/>
			<model:field name="GAP15_19_NUM"/>
			<model:field name="GAP15_19_RATE"/>
			<model:field name="GAP20_29_NUM"/>
			<model:field name="GAP20_29_RATE"/>
			<model:field name="GAP30_NUM"/>
			<model:field name="GAP30_RATE"/>
		</model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
	<next:Panel name="form" width="100%" border="0"
		bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="25%">
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
					<input type="text" name="cxsjq_y" id = "cxsjq_y" onchange="CheckTxt('cxsjq_y');" maxlength="4" style=" width: 60px;">年
					<select id = "cxsjq_m" style="width: 50px;"></select>月------
					<input type="text" name="cxsjz_y" id="cxsjz_y" onchange="CheckTxt('cxsjz_y');" maxlength="4" style=" width: 60px;">年
					<select id = "cxsjz_m" style="width: 50px;"></select>月
					<td class="FieldLabel">
					<button onclick="query()" id="queryButton">查 询</button>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<button onclick="initQueryTime()">重 置</button>
					</td>
				</tr>
			</table>
			</form>
			</div>
			</fieldset>
		</next:Html>
	</next:Panel>
	<next:Panel width="100%" border="0"
		height="100%" autoScroll="true">
		<next:TabPanel>
			<next:Tabs>
				<next:Panel id="dataPanel" title="离婚登记男女年龄差统计表" bodyStyle="background-color:#EAF4FD;padding-bottom:10px;padding-top:12px;" height="100%" autoScroll="true">
					<next:Html>
			<div align="center" id="reDiv" style="display: none;">
			<div align="center" style="width: 90%;">
			<div align="center"><span id="reportTitle"
				style="font-size: large;">离婚登记男女年龄差统计表</span></div>
			</div>
			<div align="right" class="L5form">
			<button onclick="forExcel()">导出Excel</button>&nbsp;&nbsp;
			</div>
			<br />
			<table style="border-style: hidden; width: 90%" cellpadding="0" cellspacing="0"
				border="0">
				 <tr>
					<td colspan="2" style="border-width: 0px">
					<div align="left"><span class="btTitle">统计单位：<%= BspUtil.getOrganName()%></span></div>
					<td colspan="2" style="border-width: 0px">
					<div align="right"><span class="btTitle">统计时间：<label id="statisticsTime" ></span></div>
				</tr>
				<tr >
					<td colspan="4" style="border-width: 0px">
					<table width="100%" dataset="ds" align="center"  id ="sourceTable">
						<tbody id="resultsBody">
						<tr>
							<td class="tdTitle" width="8%" align="center" rowspan="2">地区行政<br> 区划名称</td>
							<td class="tdTitle" width="2%" align="center" rowspan="2">性别</td>
							<td class="tdTitle" width="2%" align="center" rowspan="2" >合计</td>
							<td class="tdTitle" width="4%" align="center" colspan="2" >0周岁</td>
							<td class="tdTitle" width="4%" align="center" colspan="2" >1周岁</td>
							<td class="tdTitle" width="4%" align="center" colspan="2" >2周岁</td>
							<td class="tdTitle" width="4%" align="center" colspan="2" >3周岁</td>
							<td class="tdTitle" width="4%" align="center" colspan="2" >4周岁</td>
							<td class="tdTitle" width="4%" align="center" colspan="2" >5-9周岁</td>
							<td class="tdTitle" width="4%" align="center" colspan="2" >10-14周岁</td>
							<td class="tdTitle" width="4%" align="center" colspan="2" >15-19周岁</td>
							<td class="tdTitle" width="4%" align="center" colspan="2" >20-29周岁</td>
							<td class="tdTitle" width="4%" align="center" colspan="2" >30周岁以上</td>
						</tr>
						<tr>
							<td class="tdTitle" width="2%" align="center" >对数</td>
							<td class="tdTitle" width="2%" align="center" >%</td>
							<td class="tdTitle" width="2%" align="center" >对数</td>
							<td class="tdTitle" width="2%" align="center" >%</td>
							<td class="tdTitle" width="2%" align="center" >对数</td>
							<td class="tdTitle" width="2%" align="center" >%</td>
							<td class="tdTitle" width="2%" align="center" >对数</td>
							<td class="tdTitle" width="2%" align="center" >%</td>
							<td class="tdTitle" width="2%" align="center" >对数</td>
							<td class="tdTitle" width="2%" align="center" >%</td>
							<td class="tdTitle" width="2%" align="center" >对数</td>
							<td class="tdTitle" width="2%" align="center" >%</td>
							<td class="tdTitle" width="2%" align="center" >对数</td>
							<td class="tdTitle" width="2%" align="center" >%</td>
							<td class="tdTitle" width="2%" align="center" >对数</td>
							<td class="tdTitle" width="2%" align="center" >%</td>
							<td class="tdTitle" width="2%" align="center" >对数</td>
							<td class="tdTitle" width="2%" align="center" >%</td>
							<td class="tdTitle" width="2%" align="center" >对数</td>
							<td class="tdTitle" width="2%" align="center" >%</td>
							
						</tr>
						<tr repeat="true">
							<td align="center" style="background-color: #EAF4FD;"><a href="#"><label style="width: 50px;"
								field="ITEM_NAME" onclick="queryNextLevel(this)" /></label><label style="display: none;"
								field="ITEM_CODE" /></label></a></td>
							<td align="center"><label style="width: 30px;height: 20px;line-height:20px;" field="SEX_NAME"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="TOTAL_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="GAP0_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="GAP0_RATE"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="GAP1_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="GAP1_RATE"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="GAP2_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="GAP2_RATE"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="GAP3_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="GAP3_RATE"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="GAP4_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="GAP4_RATE"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="GAP5_9_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="GAP5_9_RATE"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="GAP10_14_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="GAP10_14_RATE"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="GAP15_19_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="GAP15_19_RATE"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="GAP20_29_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="GAP20_29_RATE"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="GAP30_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="GAP30_RATE"/></label></td>
						</tr>
						</tbody>
					</table>
					</td >
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
				<next:Panel id= "highcharts" title="离婚登记男女年龄差统计表（图表）" width="100%" height="100%" autoScroll="true" bodyStyle="background-color:#EAF4FD;padding-bottom:10px;padding-top:12px;">
					<next:Html>
						<table width="100%" border="0" cellspacing="0" cellpadding="0" id = "showTable">
					         <tr style="border:1px solid #3BE263;border-collapse:collapse">
					        	<td style="border:1px solid #3BE263;border-collapse:collapse"><div id="container"></div></td>
							</tr>
						 	<tr style="border:1px solid #3BE263;border-collapse:collapse">
				        		<td style="border:1px solid #3BE263;border-collapse:collapse"><div id="charPie"></div></td>
							</tr>
			 	</table>
		</next:Html>
		</next:Panel>
		</next:Tabs></next:TabPanel>
	</next:Panel>
</next:ViewPort>
</body>
</html>
