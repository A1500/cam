<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<!-- 城市低保基本情况统计报表页面 -->
<%
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy年MM月dd日");
	String date=sdf.format(new Date());
	String username= GetBspInfo.getBspInfo(request).getUserName();
	String assistanceType=request.getParameter("assistanceType");
	String titel ="";
	if("01".equals(assistanceType)){
		titel ="城市低保基本情况统计";
	}else if("02".equals(assistanceType)){
		titel ="农村低保基本情况统计";
	}
%>
<script>
	var organCode = '<%=BspUtil.getOrganCode()%>';
	var assistanceType = '<%=request.getParameter("assistanceType")%>';
	var code = '<%=request.getParameter("code")%>';
</script>
<html>
<head>
<next:ScriptManager />

<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"DatePicker.js")%>'></script>
<script type="text/javascript" src="cityBaseCaseReportMap.js"></script>
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
	<model:dataset id="ds" cmd="com.inspur.cams.drel.report.cmd.SamBaseCaseReportQueryCmd" global="true" method="queryBaseCaseByMonth" autoLoad="false">
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
					<td class="FieldLabel" width="30%">统计时间:</td>
					<td class="FieldInput" width="40%"  colspan="2">
	                     <input type="text" id="queryDate"  format="Y-m" name="statTime"    onclick="setmonth(this)"  readonly="readonly"/> 
					</td>
					<td class="FieldLabel" >
						<button onclick="query()" id="queryId">查 询</button> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<button onclick="reset()" id="resetId">重 置</button>
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
			<div align="center"><span ><font color="red">（每天12:30、15:30更新数据）</font></span></div>
			</div>
		<div align="right" class="L5form">
			<button onclick="exportExcel()" id="excelId">导出Excel</button>&nbsp;&nbsp;
		</div>
		<br/>
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
					<div align="left"><span class= "btTitle">统计单位：<%= BspUtil.getOrganName()%></span></div>
					<td colspan="2" style="border-width: 0px">
					<div align="right"><span class= "btTitle">统计时间：<label id="statisticsTime" class= "btTitle"></span></div>
				</tr>
				<tr >
					<td colspan="4" style="border-width: 0px">
						<table width="99.9%" dataset="ds" align="center" >
							<tbody id="resultsBody">
						<tr>
							<td class="tdTitle" width="3%"  align="center" rowspan="3">单位</td>
							<td class="tdTitle" width="3%"  align="center" colspan="7" style="border-bottom:none">合计</td>
							<td class="tdTitle" width="3%" align="center"   colspan="7"style="border-bottom:none">中属</td>
							<td class="tdTitle" width="3%" align="center"   colspan="7"style="border-bottom:none">省属</td>
							<td class="tdTitle" width="3%" align="center"   colspan="7"style="border-bottom:none">市属</td>
							<td class="tdTitle" width="3%" align="center"   colspan="7"style="border-bottom:none">区（县）属</td>
						</tr>
						<tr>
							<td class="tdTitle" width="3%"  align="center" colspan="2" style="border-bottom:none">户数</td>
							<td class="tdTitle" width="3%" align="center"   colspan="2"style="border-bottom:none">人数</td>
							<td class="tdTitle" width="3%" align="center"   colspan="3"style="border-bottom:none">月保障额（元）</td>
							<td class="tdTitle" width="3%"  align="center" colspan="2" style="border-bottom:none">户数</td>
							<td class="tdTitle" width="3%" align="center"   colspan="2"style="border-bottom:none">人数</td>
							<td class="tdTitle" width="3%" align="center"   colspan="3"style="border-bottom:none">月保障额（元）</td>
							<td class="tdTitle" width="3%"  align="center" colspan="2" style="border-bottom:none">户数</td>
							<td class="tdTitle" width="3%" align="center"   colspan="2"style="border-bottom:none">人数</td>
							<td class="tdTitle" width="3%" align="center"   colspan="3"style="border-bottom:none">月保障额（元）</td>
							<td class="tdTitle" width="3%"  align="center" colspan="2" style="border-bottom:none">户数</td>
							<td class="tdTitle" width="3%" align="center"   colspan="2"style="border-bottom:none">人数</td>
							<td class="tdTitle" width="3%" align="center"   colspan="3"style="border-bottom:none">月保障额（元）</td>
							<td class="tdTitle" width="3%"  align="center" colspan="2" style="border-bottom:none">户数</td>
							<td class="tdTitle" width="3%" align="center"   colspan="2"style="border-bottom:none">人数</td>
							<td class="tdTitle" width="3%" align="center"   colspan="3"style="border-bottom:none">月保障额（元）</td>
						</tr>
						<tr>
							<td class="tdTitle" width="3%"  align="center" style="border-top:none"></td>
							<td class="tdTitle" width="3%" align="center" >其中<br>分类施保</td>
							<td class="tdTitle" width="3%"  align="center" style="border-top:none"></td>
							<td class="tdTitle" width="3%" align="center" >其中<br>分类施保</td>
							<td class="tdTitle" width="3%"  align="center" >合  计</td>
							<td class="tdTitle" width="3%"  align="center">户月保障金</td>
							<td class="tdTitle" width="3%" align="center" >分类施保金</td>
							
							<td class="tdTitle" width="3%"  align="center" style="border-top:none"></td>
							<td class="tdTitle" width="3%" align="center" >其中<br>分类施保</td>
							<td class="tdTitle" width="3%"  align="center" style="border-top:none"></td>
							<td class="tdTitle" width="3%" align="center" >其中<br>分类施保</td>
							<td class="tdTitle" width="3%"  align="center" >合  计</td>
							<td class="tdTitle" width="3%"  align="center">户月保障金</td>
							<td class="tdTitle" width="3%" align="center" >分类施保金</td>
							
							<td class="tdTitle" width="3%"  align="center" style="border-top:none"></td>
							<td class="tdTitle" width="3%" align="center" >其中<br>分类施保</td>
							<td class="tdTitle" width="3%"  align="center" style="border-top:none"></td>
							<td class="tdTitle" width="3%" align="center" >其中<br>分类施保</td>
							<td class="tdTitle" width="3%"  align="center" >合  计</td>
							<td class="tdTitle" width="3%"  align="center">户月保障金</td>
							<td class="tdTitle" width="3%" align="center" >分类施保金</td>
							
							<td class="tdTitle" width="3%"  align="center" style="border-top:none"></td>
							<td class="tdTitle" width="3%" align="center" >其中<br>分类施保</td>
							<td class="tdTitle" width="3%"  align="center" style="border-top:none"></td>
							<td class="tdTitle" width="3%" align="center" >其中<br>分类施保</td>
							<td class="tdTitle" width="3%"  align="center" >合  计</td>
							<td class="tdTitle" width="3%"  align="center">户月保障金</td>
							<td class="tdTitle" width="3%" align="center" >分类施保金</td>
							
							<td class="tdTitle" width="3%"  align="center" style="border-top:none"></td>
							<td class="tdTitle" width="3%" align="center" >其中<br>分类施保</td>
							<td class="tdTitle" width="3%"  align="center" style="border-top:none"></td>
							<td class="tdTitle" width="3%" align="center" >其中<br>分类施保</td>
							<td class="tdTitle" width="3%"  align="center" >合  计</td>
							<td class="tdTitle" width="3%"  align="center">户月保障金</td>
							<td class="tdTitle" width="3%" align="center" >分类施保金</td>
						</tr>
						<tr >
							 <td align="center">
								<label />合计</label>
				            </td>
				             <td align="right" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;" id="label1"></label>
				            </td>
							<td align="right" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;" id="label2"></label>
							</td>
							<td align="right" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;" id="label3"></label>
							</td>
							 <td align="right" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;" id="label4"></label>
				            </td>
				             <td align="right" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;" id="label5"></label>
				            </td>
							<td align="right" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;" id="label6"></label>
							</td>
							<td align="right" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;" id="label7"></label>
							</td>
							<td align="right" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;" id="label8"></label>
				            </td>
							
							<td align="right" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;" id="label9"></label>
				            </td>
							<td align="right" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;" id="label10"></label>
							</td>
							
							 <td align="right" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;" id="label11"></label>
				            </td>
				             <td align="right" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;" id="label12"></label>
				            </td>
							<td align="right" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;" id="label13"></label>
							</td>
							<td align="right" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;" id="label14"></label>
							</td>
							<td align="right" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;" id="label15"></label>
				            </td>
							
							<td align="right" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;" id="label16"></label>
				            </td>
							<td align="right" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;" id="label17"></label>
							</td>
							
							<td align="right" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;" id="label18"></label>
				            </td>
				             <td align="right" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;" id="label19"></label>
				            </td>
							<td align="right" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;" id="label20"></label>
							</td>
							<td align="right" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;" id="label21"></label>
							</td>
							<td align="right" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;" id="label22"></label>
				            </td>
							
							<td align="right" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;" id="label23"></label>
				            </td>
				            
							<td align="right" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;" id="label24"></label>
							</td>
							 
							 <td align="right" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;" id="label25"></label>
				            </td>
				             <td align="right" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;" id="label26"></label>
				            </td>
							<td align="right" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;" id="label27"></label>
							</td>
							<td align="right" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;" id="label28"></label>
							</td>
							<td align="right" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;" id="label29"></label>
				            </td>
							
							<td align="right" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;" id="label30"></label>
				            </td>
							<td align="right" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;" id="label31"></label>
							</td>
							 
							 <td align="right" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;" id="label32"></label>
				            </td>
				             <td align="right" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;" id="label33"></label>
				            </td>
							<td align="right" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;" id="label34"></label>
							</td>
							<td align="right" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;" id="label35"></label>
							</td>
						</tr>
						<tr  repeat="true">
							 <td style="display:none">
								<label field="DOMICILE_CODE" id="codeId"/></label>
				            </td>
							 <td align="center">
								<a href="#"><label readonly="true" field="NAME" style="width: 100px;cursor: hand;"  onclick="queryNextLevel(this)"/></label></a>
				            </td>
				             <td align="right" style="padding-right: 2px">
								<label readonly="true" field="FAMILY_SUM" renderer='getMoneyFormatNoPoint'/></label>
				            </td>
							<td align="right" style="padding-right: 2px">
								<label  field="CLASS_FAMILY_SUM"  renderer='getMoneyFormatNoPoint'/></label>
							</td>
							<td align="right" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;" field="ASSISTANCE_PEOPLE_SUM" renderer='getMoneyFormatNoPoint'/></label>
							</td>
							 <td align="right" style="padding-right: 2px">
								<label readonly="true" field="CLASS_PEOPLE_SUM" renderer='getMoneyFormatNoPoint' /></label>
				            </td>
				             <td align="right" style="padding-right: 2px">
								<label readonly="true" field="MONEY_SUM"  renderer="getMoneyFormat"/></label>
				            </td>
							<td align="right" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;"  field="ASSISTANCE_MONEY_SUM"  renderer="getMoneyFormat"/></label>
							</td>
							<td align="right" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;"  field="CLASS_MONEY_SUM"  renderer="getMoneyFormat"/></label>
							</td>
							<td align="right" style="padding-right: 2px">
								<label readonly="true" field="CENTRAL_FAMILY_SUM" renderer='getMoneyFormatNoPoint'/></label>
				            </td>
							<td align="right" style="padding-right: 2px">
								<label readonly="true" field="CENTRAL_CLASS_FAMILY_SUM" renderer='getMoneyFormatNoPoint'/></label>
				            </td>
							<td align="right" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;" field="CENTRAL_PEOPLE_SUM" renderer='getMoneyFormatNoPoint'/></label>
							</td>
							 <td align="right" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;" field="CENTRAL_CLASS_PEOPLE_SUM" renderer='getMoneyFormatNoPoint'/></label>
							</td>
				             <td align="right" style="padding-right: 2px">
								<label readonly="true" field="CENTRAL_MATCHING_MON"  renderer="getMoneyFormat"/></label>
				            </td>
							<td align="right" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;"  field="CENTRAL_ASSISTANCE_MON"  renderer="getMoneyFormat"/></label>
							</td>
							<td align="right" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;"  field="CENTRAL_CLASS_MON"  renderer="getMoneyFormat"/></label>
							</td>
							<td align="right" style="padding-right: 2px">
								<label readonly="true" field="PROVINCE_FAMILY_SUM" renderer='getMoneyFormatNoPoint'/></label>
				            </td>
							<td align="right" style="padding-right: 2px">
								<label readonly="true" field="PROVINCE_CLASS_FAMILY_SUM" renderer='getMoneyFormatNoPoint'/></label>
				            </td>
							<td align="right" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;" field="PROVINCE_PEOPLE_SUM" renderer='getMoneyFormatNoPoint'/></label>
							</td>
							 <td align="right" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;" field="PROVINCE_CLASS_PEOPLE_SUM" renderer='getMoneyFormatNoPoint'/></label>
							</td>
				             <td align="right" style="padding-right: 2px">
								<label readonly="true" field="PROVINCE_MATCHING_MON"  renderer="getMoneyFormat"/></label>
				            </td>
							<td align="right" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;"  field="PROVINCE_ASSISTANCE_MON"  renderer="getMoneyFormat"/></label>
							</td>
							<td align="right" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;"  field="PROVINCE_CLASS_MON"  renderer="getMoneyFormat"/></label>
							</td>
							<td align="right" style="padding-right: 2px">
								<label readonly="true" field="CITY_FAMILY_SUM" renderer='getMoneyFormatNoPoint'/></label>
				            </td>
							<td align="right" style="padding-right: 2px">
								<label readonly="true" field="CITY_CLASS_FAMILY_SUM" renderer='getMoneyFormatNoPoint'/></label>
				            </td>
							<td align="right" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;" field="CITY_PEOPLE_SUM" renderer='getMoneyFormatNoPoint'/></label>
							</td>
							<td align="right" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;" field="CITY_CLASS_PEOPLE_SUM" renderer='getMoneyFormatNoPoint'/></label>
							</td>
				             <td align="right" style="padding-right: 2px">
								<label readonly="true" field="CITY_MATCHING_MON"  renderer="getMoneyFormat"/></label>
				            </td>
							<td align="right" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;"  field="CITY_ASSISTANCE_MON"  renderer="getMoneyFormat"/></label>
							</td>
							<td align="right" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;"  field="CITY_CLASS_MON"  renderer="getMoneyFormat"/></label>
							</td>
							<td align="right" style="padding-right: 2px">
								<label readonly="true" field="COUNTY_FAMILY_SUM" renderer='getMoneyFormatNoPoint'/></label>
				            </td>
							<td align="right" style="padding-right: 2px">
								<label readonly="true" field="COUNTY_CLASS_FAMILY_SUM" renderer='getMoneyFormatNoPoint'/></label>
				            </td>
							<td align="right" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;" field="COUNTY_PEOPLE_SUM" renderer='getMoneyFormatNoPoint'/></label>
							</td>
							 <td align="right" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;" field="COUNTY_CLASS_PEOPLE_SUM" renderer='getMoneyFormatNoPoint'/></label>
							</td>
				             <td align="right" style="padding-right: 2px">
								<label readonly="true" field="COUNTY_MATCHING_MON"  renderer="getMoneyFormat"/></label>
				            </td>
							<td align="right" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;"  field="COUNTY_ASSISTANCE_MON"  renderer="getMoneyFormat"/></label>
							</td>
							<td align="right" style="padding-right: 2px">
								<label style="width: 30px;height: 20px;"  field="COUNTY_CLASS_MON"  renderer="getMoneyFormat"/></label>
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