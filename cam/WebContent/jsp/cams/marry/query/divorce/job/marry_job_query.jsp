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
<script type="text/javascript" src="marry_job_query.js"></script>
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
		cmd="com.inspur.cams.marry.query.divorce.cmd.MrmJobQueryCmd"
		global="true" method="query" autoLoad="false">
		
		<model:record>
			<model:field name="ITEM_CODE" />
			<model:field name="ITEM_NAME" />
			<model:field name="TOTAL_NUM" />
			<model:field name="JOB0_NUM" />
			<model:field name="JOB0_RATE" />
			<model:field name="JOB1_NUM" />
			<model:field name="JOB1_RATE" />
			<model:field name="JOB2_NUM" />
			<model:field name="JOB2_RATE" />
			<model:field name="JOB3_NUM" />
			<model:field name="JOB3_RATE" />
			<model:field name="JOB4_NUM" />
			<model:field name="JOB4_RATE" />
			<model:field name="JOB5_NUM" />
			<model:field name="JOB5_RATE" />
			<model:field name="JOB6_NUM" />
			<model:field name="JOB6_RATE" />
			<model:field name="JOB7_NUM" />
			<model:field name="JOB7_RATE" />
			<model:field name="JOB8_NUM" />
			<model:field name="JOB8_RATE" />
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
				<tr><td class="FieldLabel">统计时间:</td>
					<td class="FieldInput" colspan="2" >
					<input type="text" name="cxsjq_y" id = "cxsjq_y" onchange="CheckTxt('cxsjq_y');" maxlength="4" style=" width: 60px;">年
					<select id = "cxsjq_m" style="width: 50px;"></select>月------
					<input type="text" name="cxsjz_y" id="cxsjz_y" onchange="CheckTxt('cxsjz_y');" maxlength="4"  style=" width: 60px;">年
					<select id = "cxsjz_m" style="width: 50px;"></select>月
					
					<td class="FieldLabel">
					<button onclick="query()" id="queryButton">查 询</button>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<button onclick="initTime()">重 置</button>
					</td>
				</tr>
			</table>
			</form>
			</div>
			</fieldset>
		</next:Html>
	</next:Panel>
	<next:Panel width="100%" border="0"
		bodyStyle="background-color:#EAF4FD;padding-bottom:10px;padding-top:12px;"
		height="100%" autoScroll="true">
		<next:Html>
			<div align="center" id="reDiv" style="display: none;">
			<div align="center" style="width: 90%;">
			<div align="center"><span id="reportTitle"
				style="font-size: large;">离婚登记当事人职业状况统计表</span></div>
			</div>
			<div align="right" class="L5form">
			<button onclick="forExcel()">导出Excel</button>&nbsp;&nbsp;
			</div>
			<br />
			<table style="border-style: hidden; width: 90%" cellpadding="0"
				cellspacing="0" border="0">
				<tr>
					<td colspan="2" style="border-width: 0px">
					<div align="left"><span class="btTitle">统计单位：<%=BspUtil.getOrganName()%></span></div>
					<td colspan="2" style="border-width: 0px">
					<div align="right"><span class="btTitle">统计时间：<label id="statisticsTime"/></span></div>
					</td>
				</tr>
				<tr>
					<td colspan="4" style="border-width: 0px">
					<table width="100%" dataset="ds" align="center">
						<tbody id="resultsBody">
							<tr>
								<td class="tdTitle" align="center" rowspan="2">地&nbsp;&nbsp;&nbsp;区</td>
								<td class="tdTitle" align="center" rowspan="2">合计(人)</td>
								<td class="tdTitle" align="center" colspan="2">不便分类的<br />
								其他从业人员</td>
								<td class="tdTitle" align="center" colspan="2">军人</td>
								<td class="tdTitle" align="center" colspan="2">生产、运输设备<br />
								操作人员<br />
								及有关人员</td>
								<td class="tdTitle" align="center" colspan="2">农、林、牧、渔、<br />
								水利业<br />
								生产人员</td>
								<td class="tdTitle" align="center" colspan="2">商业、服务业<br />
								人员</td>
								<td class="tdTitle" align="center" colspan="2">办事人员和<br />
								有关人员</td>
								<td class="tdTitle" align="center" colspan="2">专业技术人员</td>
								<td class="tdTitle" align="center" colspan="2">国家机关、<br />
								党群组织、<br />
								企业、<br />
								事业单位负责人</td>
								<td class="tdTitle" align="center" colspan="2">无业人员</td>

							</tr>
							<tr>
								<td class="tdTitle" align="center">人数</td>
								<td class="tdTitle" align="center">%</td>
								<td class="tdTitle" align="center">人数</td>
								<td class="tdTitle" align="center">%</td>
								<td class="tdTitle" align="center">人数</td>
								<td class="tdTitle" align="center">%</td>
								<td class="tdTitle" align="center">人数</td>
								<td class="tdTitle" align="center">%</td>
								<td class="tdTitle" align="center">人数</td>
								<td class="tdTitle" align="center">%</td>
								<td class="tdTitle" align="center">人数</td>
								<td class="tdTitle" align="center">%</td>
								<td class="tdTitle" align="center">人数</td>
								<td class="tdTitle" align="center">%</td>
								<td class="tdTitle" align="center">人数</td>
								<td class="tdTitle" align="center">%</td>
								<td class="tdTitle" align="center">人数</td>
								<td class="tdTitle" align="center">%</td>
							</tr>
							<tr repeat="true">
								<td align="center"><a href="#"><label
									style="width: 100px;" onclick="queryNextLevel(this)" 
									field="ITEM_NAME" /></label> <label style="display: none"
									field="ITEM_CODE" /></label></a></td>
								<td align="right" style="padding-right: 2px;"><label style="width: 30px; height: 20px;" field="TOTAL_NUM"></label></td>
								<td align="right" style="padding-right: 2px;"><label style="width: 30px; height: 20px;" field="JOB0_NUM"></label></td>
								<td align="right" style="padding-right: 2px;"><label style="width: 30px; height: 20px;" field="JOB0_RATE"></label></td>
								<td align="right" style="padding-right: 2px;"><label style="width: 30px; height: 20px;" field="JOB1_NUM"></label></td>
								<td align="right" style="padding-right: 2px;"><label style="width: 30px; height: 20px;" field="JOB1_RATE"></label></td>
								<td align="right" style="padding-right: 2px;"><label style="width: 30px; height: 20px;" field="JOB2_NUM"></label></td>
								<td align="right" style="padding-right: 2px;"><label style="width: 30px; height: 20px;" field="JOB2_RATE"></label></td>
								<td align="right" style="padding-right: 2px;"><label style="width: 30px; height: 20px;" field="JOB3_NUM"></label></td>
								<td align="right" style="padding-right: 2px;"><label style="width: 30px; height: 20px;" field="JOB3_RATE"></label></td>
								<td align="right" style="padding-right: 2px;"><label style="width: 30px; height: 20px;" field="JOB4_NUM"></label></td>
								<td align="right" style="padding-right: 2px;"><label style="width: 30px; height: 20px;" field="JOB4_RATE"></label></td>
								<td align="right" style="padding-right: 2px;"><label style="width: 30px; height: 20px;" field="JOB5_NUM"></label></td>
								<td align="right" style="padding-right: 2px;"><label style="width: 30px; height: 20px;" field="JOB5_RATE"></label></td>
								<td align="right" style="padding-right: 2px;"><label style="width: 30px; height: 20px;" field="JOB6_NUM"></label></td>
								<td align="right" style="padding-right: 2px;"><label style="width: 30px; height: 20px;" field="JOB6_RATE"></label></td>
								<td align="right" style="padding-right: 2px;"><label style="width: 30px; height: 20px;" field="JOB7_NUM"></label></td>
								<td align="right" style="padding-right: 2px;"><label style="width: 30px; height: 20px;" field="JOB7_RATE"></label></td>
								<td align="right" style="padding-right: 2px;"><label style="width: 30px; height: 20px;" field="JOB8_NUM"></label></td>
								<td align="right" style="padding-right: 2px;"><label style="width: 30px; height: 20px;" field="JOB8_RATE"></label></td>
							</tr>
						</tbody>
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