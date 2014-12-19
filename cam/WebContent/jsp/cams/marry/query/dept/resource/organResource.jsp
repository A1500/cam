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
	String titel ="登记机关办公设备统计表";
%>
<script>
	var organCode = '<%=BspUtil.getOrganCode()%>';
</script>
<html>
<head>
<next:ScriptManager />
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="organResource.js"></script>
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

.tdTitle {
	border-style: solid;
	border-color: #000000;
	border-width: 1.5px;
	height: 20px;
	word-break: break-all;
	font-weight: bold;
}
.btTitle {
	word-break: break-all;
	font-weight: bold;
	font-size: x-small;
}

.tdBottom {
	border-style: solid;
	border-color: #000000;
	border-width: 1.5px;
	height: 20px;
	word-break: break-all;
	font-weight: bold;
	border-top-style: none;
	border-left-style: none;
	border-right-style: none;
    border-bottom-style: none;
    FONT-SIZE: 10pt;
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
	<model:dataset id="ds" cmd="com.inspur.cams.marry.query.dept.cmd.OrganResourceQueryCmd" global="true" method="query" autoLoad="false">
		<model:record>
			<model:field name="ORGAN_CODE"/>
			<model:field name="ORGAN_NAME"/>
			<model:field name="CUM_NUM"/>
			<model:field name="PRINTER_NUM"/>
			<model:field name="CARD_READER_NUM"/>
			<model:field name="COPIER_NUM"/>
			<model:field name="SCANNER_NUM"/>
			<model:field name="FAX_NUM"/>
			<model:field name="TV_NUM"/>
			<model:field name="CAL_NUM"/>
			<model:field name="SCREEN_NUM"/>
			<model:field name="MONITORING_NUM"/>
			<model:field name="EVALUATION_NUM"/>
		</model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
	<next:Panel width="100%" border="0" bodyStyle="background-color:#EAF4FD;padding-bottom:10px;padding-top:12px;" height="100%" autoScroll="true">
		<next:Html>
			<div align="center" id="reDiv">
				<div align="center" style="width: 90%;">
					<div align="center"><span id="reportTitle"
						style="font-size: large;font-weight:bold;"><%=titel %></span></div>
				</div>
				<div align="right" class="L5form">
			<button onclick="forExcel()">导出Excel</button>&nbsp;&nbsp;
			</div>
			<br/>
			<table style="border-style: hidden; width: 90%" cellpadding="0" cellspacing="0" border="0">
				<tr style="border-color: #000000;">
					<td colspan="2" style="border-width: 0px">
					<div align="left"><span class= "btTitle">统计单位：<%= BspUtil.getOrganName()%></span></div>
					<td colspan="2" style="border-width: 0px">
					<div align="right"><span class= "btTitle">统计时间：<%= date.substring(0,8)%> </span></div>
				</tr>
				<tr >
					<td colspan="4" style="border-width: 0px">
						<table width="99.9%" dataset="ds" align="center" >
							<tbody id="resultsBody">
						<tr>
							<td class="tdTitle" width="3%" align="center" >单位</td>
							<td class="tdTitle" width="3%"  align="center"  >计算机（台）</td>
							<td class="tdTitle" width="3%" align="center"  >打印机（台）</td>
							<td class="tdTitle" width="3%" align="center"  >读卡器（个）</td>
							<td class="tdTitle" width="2%" align="center" >复印机</td>
							<td class="tdTitle"  width="2%" align="center" >传真机</td>
							<td class="tdTitle"  width="2%" align="center" >扫描仪</td>
							<td class="tdTitle" width="3%" align="center"  >电视机</td>
							<td class="tdTitle" width="3%" align="center"  >叫号机</td>
							<td class="tdTitle" width="2%" align="center" >电子显示屏</td>
							<td class="tdTitle"  width="2%" align="center" >监控设备</td>
							<td class="tdTitle"  width="2%" align="center" >服务评价系统</td>
						</tr>
						<tr  repeat="true">
							<td align="center" ><a href="#"><label style="width: 150px;"
									field="ORGAN_NAME" onclick="queryNextLevel(this)" /></label><label style="display: none;"
									field="ORGAN_CODE" /></label></a></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="CUM_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="PRINTER_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="CARD_READER_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="COPIER_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="SCANNER_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="FAX_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="TV_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="CAL_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="SCREEN_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="MONITORING_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="EVALUATION_NUM"/></label></td>
						</tr>
						</tbody>
						</table>
					</td >
				</tr>
				<tr>
					<td colspan="2" style="border-width: 0px">
					<div align="left"><span class= "btTitle">制表人：<%=username %></span></div></td>
					<td colspan="4" style="border-width: 0px">
					<div align="right"><span class= "btTitle">制表时间：<%=date %></span></div>
				</tr>
			</table>
			</div>
		</next:Html>
	</next:Panel>
</next:ViewPort>
</body>
</html>