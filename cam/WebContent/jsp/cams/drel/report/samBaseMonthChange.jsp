<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
								<!-- 低保、五保新增、减少户数情况统计表 -->
<%
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy年MM月dd日");
	String date=sdf.format(new Date());
	String username= GetBspInfo.getBspInfo(request).getUserName();
%>
<script>
		var organCode = '<%=BspUtil.getOrganCode()%>';
    	var organArea = '<%=BspUtil.getCorpOrgan().getOrganCode()%>';
        var organName = '<%=BspUtil.getCorpOrgan().getOrganName()%>';
        var organId = '<%=BspUtil.getCorpOrganId()%>';
		var query_organCode="<%=request.getParameter("query_organCode")%>";//点击的行政区划
		var autoQuery = "<%=request.getParameter("autoQuery")%>"
		var startTime = "<%=request.getParameter("startTime")%>";//起始时间
		var endTime="<%=request.getParameter("endTime")%>";//结束时间
</script>
<html>
<head>
<next:ScriptManager />
<script type="text/javascript" src="samBaseMonthChange.js"></script>
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
	<model:dataset id="ds" cmd="com.inspur.cams.drel.report.cmd.SamBaseCaseReportQueryCmd" global="true" method="queryBaseCaseChangeByMonth" autoLoad="false">
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
					<td class="FieldLabel">统计时间:</td>
					<td class="FieldInput" colspan="2" style="width: 40%">
	                     <input type="text" id="startMonth" format="Y-m"  onclick="setmonth(this)" style = "padding-right:20px;background:url('<%= SkinUtils.getImage(request, "default/rl.gif ") %> ') no-repeat scroll right center transparent; "/> 
	                           
	                          
	                       至<input type="text" id="endMonth" format="Y-m"  onclick="setmonth(this)" style = "padding-right:20px;background:url('<%= SkinUtils.getImage(request, "default/rl.gif ") %> ') no-repeat scroll right center transparent; "/>
	                </td>
					<td class="FieldLabel">
						<button onclick="query()" id="queryB">查 询</button> 
                    </td>    
				</tr>
				<tr>
					<td class="FieldLabel">救助对象类别:</td>
					<td class="FieldInput" colspan="2">
	                    <select id="assistanceType">
                    		<option value="01">城市低保</option>
                    		<option value="02">农村低保</option>
                    		<option value="03">农村五保</option>
	                    </select></td>
					<td class="FieldLabel">
						<button onclick="reset()" id="resetB">重 置</button>
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
				style="font-size: large;font-weight:bold;">低保、五保新增、减少户数情况统计表</span></div>
			</div>
			<div align="right" class="L5form">
			<button id="excelB" onclick="exportExcel()">导出Excel</button>&nbsp;&nbsp;
			</div>
			<br/>
			<table style="border-style: hidden; width: 90%" cellpadding="0" cellspacing="0" border="0">
			   <tr>
					<td colspan="4" style="border-width: 0px">
					 <div align="left"><span class= "btTitle"></span></div>
					 <td colspan="4" style="border-width: 0px">
					 <div align="right"><span class= "btTitle">单位：户 、人 、元</span></div>
					</td>			
			   </tr>
				<tr style="border-color: #000000;">
					<td colspan="4" style="border-width: 0px">
					<div align="left"><span class= "btTitle">统计单位：<%= BspUtil.getOrganName()%></span></div>
					<td colspan="4" style="border-width: 0px">
					<div align="right"><span class= "btTitle">统计时间：<label id="statisticsTime" class= "btTitle"></span></div>
				</tr>
				<tr >
					<td colspan="14" style="border-width: 0px">
					<table width="99.9%" dataset="ds" align="center" >
						<tbody id="resultsBody">
						<tr>
							<td class="tdTitle" width="200" align="center" rowspan="2">单位</td>
							<td class="tdTitle" width="1200"  align="center" colspan="12" ><label id="titleLabel"></label></td>
						</tr>
					    <tr>
							<td class="tdTitle" width="100" align="center" >新增户数</td>
							<td class="tdTitle" width="100" align="center" >新增保障人数</td>
							<td class="tdTitle" width="100" align="center" >新增保障金的金额</td>
							<td class="tdTitle"  width="100" align="center" >停保户数</td>
							<td class="tdTitle" width="100" align="center" >停保保障人数</td>
							<td class="tdTitle" width="100" align="center" >停保保障金的金额</td>
							<td class="tdTitle"  width="100" align="center" >保障金增加的户数</td>
							<td class="tdTitle" width="100" align="center" >保障金增加的保障人数</td>
							<td class="tdTitle"  width="100" align="center" >保障金增加的金额</td>
							<td class="tdTitle" width="100" align="center" >保障金减少的户数</td>
							<td class="tdTitle" width="100" align="center" >保障金减少的保障人数</td>
							<td class="tdTitle" width="100" align="center" >保障金减少的金额</td>
						</tr>
						 <tr>
							<td  style="padding-right: 2px" align="center" ><label>合计</label></td>
							<td  style="padding-right: 2px" align="right" ><label id='label1'></label></td>
								<td  style="padding-right: 2px" align="right" ><label id='labela'></label></td>
							<td  style="padding-right: 2px" align="right" ><label id='label7'></label></td>
							<td  style="padding-right: 2px" align="right" ><label id='label2'></label></td>
									<td  style="padding-right: 2px" align="right" ><label id='labelb'></label></td>
							<td  style="padding-right: 2px" align="right" ><label id='label8'></label></td>
							<td  style="padding-right: 2px" align="right" ><label id='label3'></label></td>
									<td  style="padding-right: 2px" align="right" ><label id='labelc'></label></td>
							<td  style="padding-right: 2px" align="right" ><label id='label4'></label></td>
							<td  style="padding-right: 2px" align="right" ><label id='label5'></label></td>
									<td  style="padding-right: 2px" align="right" ><label id='labeld'></label></td>
							<td  style="padding-right: 2px" align="right" ><label id='label6'></label></td>
						</tr>
						<tr repeat="true" >
							 <td style="display: none">
								<label  field="ID"/></label>
				            </td>
							<td align="center"><a href="#"><label style="width:100%;cursor: hand;" field="NAME"  onclick="queryNextLevel(this)" /></label></a></td>
							<td align="right" style="padding-right: 2px"><a href="#"><label  field="NEW_COUNT"   renderer='getMoneyFormatNoPoint' onclick="getDbMxxz(this)"/></label></a></td>
							<td align="right" style="padding-right: 2px"><label  field="NEW_PEO" renderer='getMoneyFormatNoPoint'/></label></td>
							<td align="right" style="padding-right: 2px"><label  field="NEW_MON"   renderer='getMoneyFormat' /></label></td>
							<td align="right" style="padding-right: 2px"><a href="#"><label   field="END_COUNT"    renderer='getMoneyFormatNoPoint' onclick="getDbMxtb(this)"/></label></a></td>
							<td align="right" style="padding-right: 2px"><label  field="END_PEO" renderer='getMoneyFormatNoPoint'/></label></td>
							<td align="right" style="padding-right: 2px"><label   field="END_MON"    renderer='getMoneyFormat' /></label></td>
							<td align="right" style="padding-right: 2px"><a href="#"><label   field="ADD_COUNT" renderer='getMoneyFormatNoPoint' onclick="getDbMxbzjxz(this)"/></label></a></td>
					        <td align="right" style="padding-right: 2px"><label  field="ADD_PEO" renderer='getMoneyFormatNoPoint'/></label></td>
					        <td align="right" style="padding-right: 2px"><label   field="ADD_MON"  renderer='getMoneyFormat'/></label></td>
							<td align="right" style="padding-right: 2px"><a href="#"><label  field="LOW_COUNT" renderer='getMoneyFormatNoPoint'  onclick="getDbMxbzjjs(this)"/></label></a></td>
					      <td align="right" style="padding-right: 2px"><label  field="LOW_PEO" renderer='getMoneyFormatNoPoint'/></label></td>
					        <td align="right" style="padding-right: 2px"><label  field="LOW_MON"  renderer='getMoneyFormat'/></label></td>
						</tr>
						</tbody>
					</table>
					</td >
				</tr>
				<tr>
					<td colspan="6" style="border-width: 0px">
					<div align="left"><span class= "btTitle">制表人：<%=username %></span></div></td>
					<td colspan="8" style="border-width: 0px">
					<div align="right"><span class= "btTitle">制表时间：<%=date %></span></div>
				</tr>
			</table>
			</div>
			
		</next:Html>
	</next:Panel>
</next:ViewPort>
</body>
</html>
