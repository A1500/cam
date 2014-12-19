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
	L5.lib.Ajax.timeout='300000';
</script>
<html>
<head>
<next:ScriptManager />

<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="lowAreaSortQuery.js"></script>
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
	<model:dataset id="ds" cmd="com.inspur.cams.low.query.cmd.LowAreaSortQueryCmd" global="true" method="query" autoLoad="false">
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
	 	<next:Panel name="form" width="100%" border="0"
		bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="25%">
		<next:Html>
			<fieldset style="overflow: visible;" class="GroupBox"><legend
				class="GroupBoxTitle">查询条件 <img
				class="GroupBoxExpandButton"
				src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>"
				onclick="collapse(this)" /> </legend>
			<div>
			<form id="queryForm" style="width: 100%; height: 100%;" class="L5form">
			<table border="1" width="100%">
				<tr>
					<td class="FieldLabel" width="10%">统计时间:</td>
					<td class="FieldInput" width="20%"  colspan="2">
	                     <input type="text" id="cxsj_q" format="Ymd" name="cxsj_q"  style="width:36%"  onclick="LoushangDate(this)" readonly="readonly"/> -----
					     <input type="text" id="cxsj_z" format="Ymd" name="cxsj_z"  style="width:36%"  onclick="LoushangDate(this)" readonly="readonly"/></td>
					<td class="FieldLabel" nowrap="nowrap" width="10%">所属机构：</td>
				    <td class="FieldInput" width="20%" ><input type="text" id="domicileName" style="width: 150" class="TextEditor" title="属地行政区划" onclick="query_selectDomicile()" /> <input
					      type="hidden" id="domicileCode" class="TextEditor" title="属地行政区划" />  </td>
					<td class="FieldLabel" >
						<button onclick="query()">查 询</button> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<button onclick="reset()">重 置</button>
					</td>
				</tr>
			</table>
			</form>
			</div>
			</fieldset>
		</next:Html>
	</next:Panel>
	<next:Panel width="100%" border="0" bodyStyle="background-color:#EAF4FD;padding-bottom:10px;padding-top:12px;" height="100%" autoScroll="true"><div> 
		</div><next:Html><div> 
			</div><div align="center" id="reDiv" style="display: none;"><div> 
			</div><div align="center" style="width: 90%;">
			<div align="center"><span id="reportTitle"
				style="font-size: large;font-weight:bold;">城市低保保障情况统计</span></div>
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
					<table width="99.9%" dataset="ds" align="center" >
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
						    <td align="right" style="padding-right: 2px"> <label style="width: 30px;height: 20px;" field="TOTAL_FAMILY_NUM"   /></label> </td>
						    <td align="right" style="padding-right: 2px"> <label style="width: 30px;height: 20px;" field="TOTAL_PEOPLE_NUM"   /></label> </td>
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
