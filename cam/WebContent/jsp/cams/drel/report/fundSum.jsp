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
	String titel ="城市低保保障金及分类施保金统计表";
%>
<script>
	var organCode = '<%=BspUtil.getOrganCode()%>';
	var cxsjq = '<%=request.getParameter("cxsjq")%>';
	var cxsjz = '<%=request.getParameter("cxsjz")%>';
</script>
<html>
<head>
<next:ScriptManager />

<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"DatePicker.js")%>'></script>
<script type="text/javascript" src="fundSum.js"></script>
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
	text-align: left;
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
	height:25px; 
	line-height:25px; 
	overflow:hidden; 
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
	<model:dataset id="ds" cmd="com.inspur.cams.drel.funds.release.cmd.SamReleaseSummaryQueryCmd" global="true" method="queryReleaseMoneyStat" autoLoad="false">
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
	                     <input type="text" id="queryDate" format="Y-m" onclick="setmonth(this)" style = "width:46%;padding-right:20px;background:url('<%= SkinUtils.getImage(request, "default/rl.gif ") %> ') no-repeat scroll right center transparent; "/> 
	                        
					</td>
					<td class="FieldButton" >
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
	<next:Panel width="100%" border="0"  bodyStyle="background-color:#EAF4FD;padding-bottom:10px;padding-top:12px;" height="100%" autoScroll="true"><div> 
		</div><next:Html><div> 
			</div><div align="center" id="reDiv" style="display: none;">
			<div><!--style="display: none;"-->
			</div><div align="center" style="width: 90%;">
			<div align="center"><span id="reportTitle"
				style="font-size: large;font-weight:bold;"><%=titel %></span></div>
			</div>
			<div align="right" class="L5form">
			<button onclick="exportExcel()" >导出Excel</button>&nbsp;&nbsp;
			</div>
			<br/>
			<table style="border-style: hidden; width: 90%" cellpadding="0" cellspacing="0" border="0">
			   <tr>
					<td colspan="2" style="border-width: 0px">
					 <div align="left"><span class= "btTitle"></span></div>
					 <td colspan="2" style="border-width: 0px">
					 <div align="right"><span class= "btTitle">单位：元</span></div>
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
							<td class="tdTitle" width="3%" align="center" rowspan="2">单位</td>
							<td class="tdTitle" width="3%"  align="center" colspan="4">低保金额</td>
							<td class="tdTitle" width="3%" align="center"  colspan="4">分类施保</td>
							<td class="tdTitle" width="3%" align="center"  colspan="2">低保金+分类施保</td>
							<td class="tdTitle" width="2%" align="center" rowspan="2">总计</td>
						</tr>
						<tr>	
							<td class="tdTitle"  width="2%" align="center" >中央</td>
							<td class="tdTitle"  width="2%" align="center" >省级</td>
							<td class="tdTitle"  width="2%" align="center" >市级</td>
							<td class="tdTitle"  width="2%" align="center" >区级</td>
							<td class="tdTitle"  width="2%" align="center" >中央</td>
							<td class="tdTitle"  width="2%" align="center" >省级</td>
							<td class="tdTitle"  width="2%" align="center" >市级</td>
							<td class="tdTitle"  width="2%" align="center" >区级</td>
							<td class="tdTitle"  width="2%" align="center" >低保金</td>
							<td class="tdTitle"  width="2%" align="center" >分类施保</td>
						</tr>
						<tr>
							<td align="center" style="padding-right: 2px">
									<label />合计</label>
							</td>
							<td align="right" style="padding-right: 2px">
									<label id='label1' style="width: 30px;height: 20px;"  /></label>
							</td>
							<td align="right" style="padding-right: 2px">
									<label id='label2' style="width: 30px;height: 20px;"  /></label>
							</td>
							<td align="right" style="padding-right: 2px">
									<label id='label3' style="width: 30px;height: 20px;"  /></label>
							</td>
							<td align="right" style="padding-right: 2px">
									<label id='label4' style="width: 30px;height: 20px;"  /></label>
							</td>
							<td align="right" style="padding-right: 2px">
									<label id='label5' style="width: 30px;height: 20px;"  /></label>
							</td>
							<td align="right" style="padding-right: 2px">
									<label id='label6' style="width: 30px;height: 20px;"  /></label>
							</td>
							<td align="right" style="padding-right: 2px">
									<label id='label7' style="width: 30px;height: 20px;"  /></label>
							</td>
							<td align="right" style="padding-right: 2px">
									<label id='label8' style="width: 30px;height: 20px;"  /></label>
							</td>
							<td align="right" style="padding-right: 2px">
									<label id='label9' style="width: 30px;height: 20px;"  /></label>
							</td>
							<td align="right" style="padding-right: 2px">
									<label id='label10' style="width: 30px;height: 20px;"  /></label>
							</td>
							<td align="right" style="padding-right: 2px">
									<label id='label11' style="width: 30px;height: 20px;"  /></label>
							</td>
						</tr>
					<tr  repeat="true">
							 <td style="display: none">
								<label readonly="true" field="ID" /></label>
				            </td>
							<td align="center"><a href="#"><label style="width: 100px;cursor: hand;" field="NAME"  onclick="queryNextLevel(this)" /></label><label style="display: none;" field="ID" /></label></a></td>
							<td align="right" style="padding-right: 2px">
									<label style="width: 30px;height: 20px;" field="CENTRAL_ASSISTANCE_MON"  renderer="getMoneyFormat"/></label>
								</td>
							<td align="right" style="padding-right: 2px">
									<label style="width: 30px;height: 20px;"  field="PROVINCE_ASSISTANCE_MON"  renderer="getMoneyFormat"/></label>
								</td>
					        <td align="right" style="padding-right: 2px">
									<label style="width: 30px;height: 20px;" field="CITY_ASSISTANCE_MON"  renderer="getMoneyFormat"/></label>
								</td>
					        <td align="right" style="padding-right: 2px">
									<label style="width: 30px;height: 20px;" field="COUNTY_ASSISTANCE_MON"  renderer="getMoneyFormat"/></label>
								</td>
						    <td align="right" style="padding-right: 2px">
									<label style="width: 30px;height: 20px;" field="CENTRAL_CLASS_MON"  renderer="getMoneyFormat"/></label>
								</td>
							<td align="right" style="padding-right: 2px">
									<label style="width: 30px;height: 20px;" field="PROVINCE_CLASS_MON"  renderer="getMoneyFormat"/></label>
								</td>
					        <td align="right" style="padding-right: 2px">
									<label style="width: 30px;height: 20px;" field="CITY_CLASS_MON"  renderer="getMoneyFormat"/></label>
								</td>
						    <td align="right" style="padding-right: 2px">
									<label style="width: 30px;height: 20px;"  field="COUNTY_CLASS_MON" renderer="getMoneyFormat"/></label>
								</td>
							<td align="right" style="padding-right: 2px">
									<label style="width: 30px;height: 20px;"  field="ASSISTANCE_MON_SUM"  renderer="getMoneyFormat"/></label>
								</td>
					        <td align="right" style="padding-right: 2px">
									<label style="width: 30px;height: 20px;" field="ASSISTANCE_CLASS_MON_SUM" renderer="getMoneyFormat" /></label>
								</td>
						    <td align="right" style="padding-right: 2px">
									<label style="width: 30px;height: 20px;" field="RELEASE_MON_SUM"  renderer="getMoneyFormat"/></label>
								</td>
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