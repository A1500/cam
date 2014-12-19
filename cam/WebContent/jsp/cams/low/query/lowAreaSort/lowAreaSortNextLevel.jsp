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
	var cxsjq = '<%=request.getParameter("cxsj_q")%>';
	var cxsjz = '<%=request.getParameter("cxsj_z")%>';
	var xzqu = '<%=request.getParameter("xzqu")%>';
	var organName = '<%=BspUtil.getOrganName()%>';
	var pageflag ='<%=request.getParameter("pageflag")%>';
 
</script>
<html>
<head>
<next:ScriptManager />
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="lowAreaSortNextLevel.js"></script>
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
	<model:dataset id="dsNext" cmd="com.inspur.cams.low.query.cmd.LowAreaSortQueryCmd" global="true" method="query" autoLoad="false">
		<model:record>
			<model:field name="ITEM_CODE"/>
			<model:field name="ITEM_NAME"/>
			<model:field name="CENTER_FAMILY_NUM"/>
			<model:field name="CENTER_PEOPLE_NUM"/>
			<model:field name="CENTER_MONEY_MONTH"/>
			<model:field name="PROVINCE_FAMILY_NUM"/>
			<model:field name="PROVINCE_PEOPLE_NUM"/>
			<model:field name="PROVINCE_MONEY_MONTH"/>
			<model:field name="CITY_FAMILY_NUM"/>
			<model:field name="CITY_PEOPLE_NUM"/>
			<model:field name="CITY_MONEY_MONTH"/>
			<model:field name="TOWN_FAMILY_NUM"/>
			<model:field name="TOWN_PEOPLE_NUM"/>
			<model:field name="TOWN_MONEY_MONTH"/>
			<model:field name="TOTAL_FAMILY_NUM"/>
			<model:field name="TOTAL_PEOPLE_NUM"/>
			<model:field name="TOTAL_MONEY_MONTH"/>
		</model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
	<next:Panel width="100%" border="0" bodyStyle="background-color:#EAF4FD;padding-bottom:10px;padding-top:12px;" height="100%" autoScroll="true"><div> 
		</div><next:Html><div> 
			</div><div align="center" id="reDiv" style="display: none;"><div> 
			</div><div align="center" style="width: 90%;">
			<div align="center"><span id="reportTitle" style="font-size: large;font-weight:bold;">最低生活保障属地划分统计总表</span></div>
			</div>
			<div align="right" class="L5form">
			<button onclick="forExcel()">导出Excel</button>&nbsp;&nbsp;
			</div>
			<br/>
			<table style="border-style: hidden; width: 90%" cellpadding="0" cellspacing="0" border="0">
			   <tr>
					<td colspan="2" style="border-width: 0px">
					 <div align="left"><span class= "btTitle"></span></div>
					 <td colspan="2" style="border-width: 0px">
					 <div align="right"><span class= "btTitle">单位：户 、人 、元</span></div>
					</td>			
			   </tr>
				<tr style="border-color: #000000;">
					<td colspan="2" style="border-width: 0px">
					<div align="left"><span class= "btTitle">统计单位：<%= BspUtil.getOrganName()%></span></div>
					<td colspan="2" style="border-width: 0px">
					<div align="right"><span class= "btTitle">统计时间：<label id="statisticsTime" class= "btTitle"></span></div>
				</tr>
				<tr >
					<td colspan="4" style="border-width: 0px">
					<table width="99.9%" dataset="dsNext" align="center" >
						<tbody id="resultsBody">
						<tr>
							<td class="tdTitle" width="6%" align="center" rowspan="2">单位</td>
							<td class="tdTitle" width="3%"  align="center" colspan="3" >中属保障情况</td>
							<td class="tdTitle" width="3%" align="center" colspan="3" >省属保障情况</td>
							<td class="tdTitle" width="3%" align="center" colspan="3" >市属保障情况</td>
							<td class="tdTitle" width="3%" align="center" colspan="3" >县属保障情况</td>
						    <td class="tdTitle" width="3%" align="center" colspan="3" >保障情况合计</td>
						</tr>
					    <tr>
							<td class="tdTitle" width="2%" align="center" >户数</td>
							<td class="tdTitle"  width="2%" align="center" >人数</td>
							<td class="tdTitle"  width="2%" align="center" >月保障额</td>
							<td class="tdTitle" width="2%" align="center" >户数</td>
							<td class="tdTitle"  width="2%" align="center" >人数</td>
							<td class="tdTitle"  width="2%" align="center" >月保障额</td>
							<td class="tdTitle" width="2%" align="center" >户数</td>
							<td class="tdTitle"  width="2%" align="center" >人数</td>
							<td class="tdTitle"  width="2%" align="center" >月保障额</td>
							<td class="tdTitle" width="2%" align="center" >户数</td>
							<td class="tdTitle"  width="2%" align="center" >人数</td>
							<td class="tdTitle"  width="2%" align="center" >月保障额</td>
							<td class="tdTitle" width="2%" align="center" >户数</td>
							<td class="tdTitle"  width="2%" align="center" >人数</td>
							<td class="tdTitle"  width="2%" align="center" >月保障额</td>
						</tr>
						<tr repeat="true" >
						    <td style="display: none">
								<label readonly="true" field="ITEM_CODE" /></label>
				            </td>
							<td align="center"><a href="#"><label style="width: 100px;" field="ITEM_NAME"  onclick="queryNextLevel(this)" /></label><label style="display: none;" field="ITEM_CODE" /></label></a></td>
							<td align="right" style="padding-right: 2px"><a href="#"><label style="width: 30px;height: 20px;" field="CENTER_FAMILY_NUM"   onclick="redirectFamily(this,'1')" /></label></a></td>
							<td align="right" style="padding-right: 2px"><a href="#"><label style="width: 30px;height: 20px;" field="CENTER_PEOPLE_NUM"   onclick="redirectPeople(this,'1')"/></label></a></td>
							<td align="right" style="padding-right: 2px"><label style="width: 30px;height: 20px;" field="CENTER_MONEY_MONTH"/></label></td>
					        <td align="right" style="padding-right: 2px"><a href="#"><label style="width: 30px;height: 20px;" field="PROVINCE_FAMILY_NUM" onclick="redirectFamily(this,'2')"/></label></a></td>
						    <td align="right" style="padding-right: 2px"><a href="#"><label style="width: 30px;height: 20px;" field="PROVINCE_PEOPLE_NUM" onclick="redirectPeople(this,'2')"/></label></a></td>
						    <td align="right" style="padding-right: 2px"><label style="width: 30px;height: 20px;" field="PROVINCE_MONEY_MONTH"/></label></td>
						    <td align="right" style="padding-right: 2px"><a href="#"><label style="width: 30px;height: 20px;" field="CITY_FAMILY_NUM"     onclick="redirectFamily(this,'3')"/></label></a></td>
						    <td align="right" style="padding-right: 2px"><a href="#"><label style="width: 30px;height: 20px;" field="CITY_PEOPLE_NUM"     onclick="redirectPeople(this,'3')"/></label></a></td>
						    <td align="right" style="padding-right: 2px"><label style="width: 30px;height: 20px;" field="CITY_MONEY_MONTH"/></label></td>
						    <td align="right" style="padding-right: 2px"><a href="#"><label style="width: 30px;height: 20px;" field="TOWN_FAMILY_NUM"     onclick="redirectFamily(this,'4')"/></label></a></td>
						    <td align="right" style="padding-right: 2px"><a href="#"><label style="width: 30px;height: 20px;" field="TOWN_PEOPLE_NUM"     onclick="redirectPeople(this,'4')"/></label></a></td>
						    <td align="right" style="padding-right: 2px"><label style="width: 30px;height: 20px;" field="TOWN_MONEY_MONTH"/></label></td>
						    <td align="right" style="padding-right: 2px"><a href="#"><label style="width: 30px;height: 20px;" field="TOTAL_FAMILY_NUM"    onclick="redirectFamily(this,'5')"/></label></a></td>
						    <td align="right" style="padding-right: 2px"><a href="#"><label style="width: 30px;height: 20px;" field="TOTAL_PEOPLE_NUM"    onclick="redirectPeople(this,'5')"/></label></a></td>
						    <td align="right" style="padding-right: 2px"><label style="width: 30px;height: 20px;" field="TOTAL_MONEY_MONTH"/></label></td>
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
