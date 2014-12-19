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
	String titel = "敬老院基本情况统计表（二）";
%>
<script>
	var organArea='<%=BspUtil.getCorpOrgan().getOrganCode()%>';
	var organName='<%=BspUtil.getCorpOrgan().getOrganName()%>';
</script>
<html>
<head>
<next:ScriptManager />
	<script type="text/javascript" src="geroInfoReportOther.js"></script>
	<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
	<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
	<script type="text/javascript" src='<%=SkinUtils.getJS(request,"DatePicker.js")%>'></script>
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
	<model:dataset id="ds" cmd="com.inspur.cams.drel.samu.cmd.SamGerocomiumInfoQueryCmd" global="true" method="reportGeroInfo">
		<model:record fromBean="com.inspur.cams.drel.samu.data.SamGerocomiumInfo"/>
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
					<td class="FieldLabel" width="30%">统计年度:</td>
					<td class="FieldInput" width="40%" colspan="2">
	                     <input type="text" id="queryYear" maxlength="4"/>
	                </td>
					<td class="FieldLabel" >
						<button onclick="query()">查 询</button>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<button onclick="resetQuery()">重 置</button>
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
			</div><div align="center" id="reDiv" style="display: none;"><div><!--style="display: none;"-->
			</div><div align="center" style="width: 90%;">
			<div align="center"><span id="reportTitle"
				style="font-size: large;font-weight:bold;"><%=titel %></span></div>
			</div>
			<div align="right" class="L5form">
			<button onclick="exportExcel()">导出Excel</button>&nbsp;&nbsp;
			</div>
			<br/>
			<table style="width: 90%" cellpadding="0" cellspacing="0" border="0">
			   <tr>
					<td colspan="2" style="border-width: 0px">
					 <div align="left"><span class= "btTitle"></span></div>
					 <td colspan="2" style="border-width: 0px">
					</td>			
			   </tr>
				<tr style="border-color: #000000;">
					<td colspan="2" style="border-width: 0px">
					<div align="left"><span class= "btTitle">统计单位：<%= BspUtil.getOrganName()%></span></div>
					<td colspan="2" style="border-width: 0px">
					<div align="right"><span class= "btTitle">统计时间：<label id="statisticsTime" class= "btTitle"></span></div>
				</tr>
				<tr>
					<td colspan="4" style="border-width: 0px">
						<table width="99.9%" dataset="ds" align="center" >
							<tbody id="resultsBody">
								<tr>
									<td class="tdTitle" width="3%" align="center" >单位</td>
									<td class="tdTitle" width="3%" align="center" >总数</td>
									<td class="tdTitle" width="3%" align="center" >固定资产<br>（万元）</td>
									<td class="tdTitle" width="3%" align="center" >管理工作经费<br>（万元）</td>
									<td class="tdTitle" width="3%" align="center" >年副业收入<br>（万元）</td>
									<td class="tdTitle" width="3%" align="center" >年均供养标准<br>（元）</td>
									<td class="tdTitle" width="3%" align="center" >蔬菜种植面积<br>（亩）</td>
									<td class="tdTitle" width="3%" align="center" >蔬菜产量<br>（吨）</td>
								</tr>
								 <tr>
								 	<td align="center" style="padding-right: 2px">
										<label />合计</label>
									</td>
									<td align="right" style="padding-right: 2px">
										<label id='label1'/></label>
									</td>
									<td align="right" style="padding-right: 2px">
										<label id='label2'/></label>
									</td>
									<td align="right" style="padding-right: 2px">
										<label id='label3'/></label>
									</td>
									<td align="right" style="padding-right: 2px">
										<label id='label4'/></label>
									</td>
									<td align="right" style="padding-right: 2px">
										<label id='label5'/></label>
									</td>
									<td align="right" style="padding-right: 2px">
										<label id='label6'/></label>
									</td>
									<td align="right" style="padding-right: 2px">
										<label id='label7'/></label>
									</td>
								</tr>
								<tr repeat="true">
									<td style="display: none">
									<label readonly="true" field="ID" /></label>
				            		</td>
							<td align="center"><a href="#"><label id="mylabel" style="width: 100px;cursor: hand;" field="NAME" onclick="queryNextLevel(this)" /></label><label style="display: none;" field="ID" /></label></a></td>
							
									<td align="right" style="padding-right: 2px">
										<label field="NUM_SUM" size="20"   readonly="true" renderer='nullToZero'/></label>
									</td>
									<td align="right" style="padding-right: 2px">
										<label field=FIXED_ASSETS_SUM size="20" readonly="true" renderer="getMoneyFormat"/></label>
									</td>
									<td align="right" style="padding-right: 2px">
										<label field="MANAGEMENT_FUNDS_SUM" size="20" readonly="true" renderer="getMoneyFormat"/></label>
									</td>
									<td align="right" style="padding-right: 2px">
										<label field="YEAR_SIDELINE_SUM" size="20" readonly="true" renderer="getMoneyFormat"/></label>
									</td>
								    <td align="right" style="padding-right: 2px">
										<label field="SUPPORT_STANDARD_SUM" size="20" readonly="true" renderer="getMoneyFormat"/></label>
								   	</td>
									<td align="right" style="padding-right: 2px">
										<label field="VEGETABLES_AREA_SUM" size="20" readonly="true" renderer="getMoneyFormat"/></label>
									</td>
									<td align="right" style="padding-right: 2px">
										<label field="VEGETABLES_YIELD_SUM" size="20" readonly="true" renderer="getMoneyFormat"/></label>
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