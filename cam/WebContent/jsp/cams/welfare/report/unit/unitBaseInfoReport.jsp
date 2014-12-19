<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@page import="java.util.*"%>
<%@page import="com.inspur.cams.comm.dicm.IDicDao"%>
<%@page import="org.loushang.next.dao.DaoFactory"%>
<html>
	<head>
		<title>福利企业基本情况统计</title>
		<next:ScriptManager />
		<script type="text/javascript" src="unitBaseInfoReport.js"></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"DatePicker.js")%>'></script>
		<script type="text/javascript">
		
		    <%
		    SimpleDateFormat sdf=new SimpleDateFormat("yyyy年MM月dd日");
			String date=sdf.format(new Date());
			String username= GetBspInfo.getBspInfo(request).getUserName();
			String titel ="福利企业基本情况统计";
		    String organArea=BspUtil.getCorpOrgan().getOrganCode();
			String organName=DicUtil.getTextValueFromDic("DIC_CITY","ID",organArea,"NAME");
		    %>
			var organArea='<%=organArea%>';
			var organName='<%=organName%>';
		</script>
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
	<model:dataset id="ds" cmd="com.inspur.cams.welfare.welfarecorp.query.cmd.UnitReportQueryCmd" global="true" method="queryBaseinfoReport" autoLoad="false">
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
					<td nowrap="nowrap" class="FieldButton" colspan="2">
                   <button id="queryId" onclick="query()">开始统计</button>
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
			<br/>
			<div align="right" class="L5form">
				<button onclick="exportExcel()" id="excelId">导出Excel</button>&nbsp;&nbsp;
			</div>
			<table style="border-style: hidden; width: 90%" cellpadding="0" cellspacing="0" border="0">
			   <tr>
					<td colspan="2" style="border-width: 0px">
					 <div align="left"><span class= "btTitle"></span></div>
					 <td colspan="2" style="border-width: 0px">
					 <div align="right"><span class= "btTitle"></span></div>
					</td>			
			   </tr>
				<tr style="border-color: #000000;">
					<td colspan="2" style="border-width: 0px">
					<div align="left"><span class= "btTitle">填报单位：<%= BspUtil.getOrganName()%></span></div>
					<td colspan="2" style="border-width: 0px">
					 <div align="right"><span class= "btTitle"></span></div>
				</tr>
				<tr >
					<td colspan="12" style="border-width: 0px">
						<table width="99.9%" dataset="ds"  align="center" >
							<tbody id="resultsBody">
						<tr>
							<td class="tdTitle" width="3%" rowspan="2" align="center" >地区</td>
							<td class="tdTitle" width="3%" rowspan="2" align="center"  >企业总数</td>
							<td class="tdTitle" width="3%" colspan="6" align="center"  >经济性质</td>
							<td class="tdTitle" width="3%" rowspan="2" align="center"  >职工总数</td>
							<td class="tdTitle" width="3%" rowspan="2" align="center"  >残疾人数</td>
							<td class="tdTitle" width="3%" rowspan="2" align="center"  >残疾人<br/>比例%</td>
							<td class="tdTitle" width="3%" rowspan="2" align="center"  >注册资金<br/>（万元）</td>
						</tr>
						<%
							IDicDao dao = (IDicDao) DaoFactory.getDao("com.inspur.cams.comm.dicm.DicDao");
						%>
						<tr>
							<td class="tdTitle" width="3%"  align="center"  ><%= dao.getValueByValue("WEAL_DIC_ECONOMICNATURE","NAME","01") %></td>
							<td class="tdTitle" width="3%"  align="center"  ><%= dao.getValueByValue("WEAL_DIC_ECONOMICNATURE","NAME","02") %></td>
							<td class="tdTitle" width="3%"  align="center"  ><%= dao.getValueByValue("WEAL_DIC_ECONOMICNATURE","NAME","03") %></td>
							<td class="tdTitle" width="3%"  align="center"  ><%= dao.getValueByValue("WEAL_DIC_ECONOMICNATURE","NAME","04") %></td>
							<td class="tdTitle" width="3%"  align="center"  ><%= dao.getValueByValue("WEAL_DIC_ECONOMICNATURE","NAME","05") %></td>
							<td class="tdTitle" width="3%"  align="center"  >其他</td>
						</tr>
					<tr id="countTotle" style="display: none;">
							 <td align="center">
								<label />合计</label>
				            </td>
				             <td align="center" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;" id="label1"></label>
				            </td>
							<td align="center" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;" id="label2"></label>
							</td>
							<td align="center" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;" id="label3"></label>
							</td>
							 <td align="center" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;" id="label4"></label>
				            </td>
				             <td align="center" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;" id="label5"></label>
				            </td>
							<td align="center" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;" id="label6"></label>
							</td>
							<td align="center" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;" id="label7"></label>
							</td>
							<td align="center" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;" id="label8"></label>
							</td>
							<td align="center" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;" id="label9"></label>
							</td>
							<td align="center" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;" id="label10"></label>
							</td>
							<td align="center" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;" id="label11"></label>
							</td>
						</tr>
					<tr  repeat="true">
							 <td style="display: none">
								<label readonly="true" field="ID" /></label>
				            </td>
							<td align="center"><a href="#"><label style="width: 100px;cursor: hand;" field="NAME"  onclick="queryNextLevel(this)" /></label><label style="display: none;" field="ID" /></label></a></td>
							<td align="center" valign="middle" style="padding-right: 2px">
									<label style="width: 30px;height: 20px;" field="UNIT_NUM" renderer="getMoneyFormatNoPoint"/></label>
							</td>
							<td align="center" valign="middle" style="padding-right: 2px">
									<label style="width: 30px;height: 20px;" field="ECONOMIC_ONE" renderer="getMoneyFormatNoPoint"/></label>
							</td>
								
							<td align="center" valign="middle" style="padding-right: 2px">
									<label style="width: 30px;height: 20px;" field="ECONOMIC_TWO" renderer="getMoneyFormatNoPoint"/></label>
							</td>
							<td align="center" valign="middle" style="padding-right: 2px">
									<label style="width: 30px;height: 20px;" field="ECONOMIC_THREE" renderer="getMoneyFormatNoPoint"/></label>
							</td>	
							<td align="center" valign="middle" style="padding-right: 2px">
									<label style="width: 30px;height: 20px;" field="ECONOMIC_FOUR" renderer="getMoneyFormatNoPoint"/></label>
							</td>	
							<td align="center" valign="middle" style="padding-right: 2px">
									<label style="width: 30px;height: 20px;" field="ECONOMIC_FIVE" renderer="getMoneyFormatNoPoint"/></label>
							</td>	
							<td align="center" valign="middle" style="padding-right: 2px">
									<label style="width: 30px;height: 20px;" field="ECONOMIC_SIX" renderer="getMoneyFormatNoPoint"/></label>
							</td>
							<td align="center" valign="middle" style="padding-right: 2px">
									<label style="width: 30px;height: 20px;" field="WORKERS_ALL" renderer="getMoneyFormatNoPoint"/></label>
							</td>	
							<td align="center" valign="middle" style="padding-right: 2px">
									<label style="width: 30px;height: 20px;" field="WORKERS_DEFORM" renderer="getMoneyFormatNoPoint"/></label>
							</td>	
							<td align="center" valign="middle" style="padding-right: 2px">
									<label style="width: 30px;height: 20px;" field="SCALE_LIMB" renderer="getMoneyFormat"/></label>
							</td>
							<td align="center" valign="middle" style="padding-right: 2px">
									<label style="width: 30px;height: 20px;" field="REG_FUND" renderer="getMoneyFormat"/></label>
							</td>		
						</tr>
						</tbody>
						</table>
					</td >
				</tr>
				<tr>
					<td colspan="2" style="border-width: 0px">
					<div align="left"><span class= "btTitle">制表人：<%=username %></span></div></td>
					<td colspan="2" style="border-width: 0px">
					<div align="right"><span class= "btTitle">制表时间：<%=date %></span></div>
				</tr>
			</table>
			</div>
		</next:Html>
	</next:Panel>
</next:ViewPort>	
	</body>
</html>