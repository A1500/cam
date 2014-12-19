<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy年MM月dd日");
	String date=sdf.format(new Date());	
	String username= GetBspInfo.getBspInfo(request).getUserName();
%>
<script>
	var organCode = '<%=BspUtil.getOrganCode()%>';
	var orgName;
	var myDate = new Date();
	var year = myDate.getFullYear()-1;
	var cu = new Date(year,myDate.getMonth(),myDate.getDate());	
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
<script type="text/javascript" src="prsMain.js"></script>
<script type="text/javascript" src="prsComm.js"></script>
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
</head>
<body>
<model:datasets>
	<model:dataset id="ds"
		cmd="com.inspur.cams.prs.query.cmd.PrsPlacementCmd" global="true"
		autoLoad="false">
		<model:record>
			<model:field name="ORGAN_CODE" type="string" />
			<model:field name="ORGAN_NAME" type="string" />
			<model:field name="UNPLACED" type="string" />
			<model:field name="SELF_EMPLOYMENT" type="string" />
			<model:field name="FUXUEFUGONG" type="string" />
			<model:field name="PLACEMENT_GOV" type="string" />
			<model:field name="EMPLOYED" type="string" />
			<model:field name="SELF_EMPLOYED" type="string" />
			<model:field name="TOTAL_PLACED" type="string" />
			<model:field name="TOTALCOUNT" type="string" />
			
		</model:record>
	</model:dataset>
	<model:dataset id="OrgNameDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="false">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CITY'></model:param>
			<model:param name="value" value='ID'></model:param>
			<model:param name="text" value='FULL_NAME'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>
<next:ViewPort>
	<next:Panel width="100%" border="0"
		bodyStyle="background-color:#EAF4FD;padding-bottom:10px;padding-top:12px;"
		height="100%" autoScroll="true">
		<next:Html>
			<div align="center" id="reDiv" style="display: none;">
			<div align="center" style="width: 90%;">
			<div align="center"><span id="reportTitle"
				style="font-size: large;">山东省退役士兵安置统计表</span></div>
			</div>			
			<br />
			<div align="right" class="L5form">
			<button onclick="exportCSV()" style="right: 50px;">导出Excel</button>&nbsp;&nbsp;&nbsp;&nbsp;
		</div>
		<br />
			<table style="border-style: hidden; width: 90%" cellpadding="0"
				cellspacing="0" border="0">
				<tr style="border-width: 0px">
					<td colspan="2" style="border-width: 0px">
					<div align="left"><span class="btTitle">统计单位：<%=BspUtil.getOrganName()%></span></div>
					<td colspan="2" style="border-width: 0px">
					<div align="right"><span class="btTitle">统计时间：<label id="statisticsTime" /></span></div>
				</tr>
				<tr >
					<td colspan="4" style="border-width: 0px">
					<table width="100%" dataset="ds" align="center">
						<tr>
							<td class="tdTitle"  align="center" rowspan="3">地&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;区</td>
							<td class="tdTitle"  align="center" rowspan="3">总计</td>
							<td class="tdTitle"  align="center" rowspan="3" >未安置</td>
							<td class="tdTitle"  align="center" colspan="6" >安置</td>
						</tr>
						<tr>
							<td class="tdTitle"  align="center"  rowspan="2">合计</td>
							<td class="tdTitle"  align="center"rowspan="2">自主就业</td>
							<td class="tdTitle"  align="center" colspan="4"> 政府指导</td>
						</tr>
						<tr>
							<td class="tdTitle"  align="center" >复工复学</td>
							<td class="tdTitle"  align="center" >政府安置</td>
							<td class="tdTitle"  align="center" >自谋职业</td>
							<td class="tdTitle"  align="center" >自找单位</td>
							
						</tr>
						<tr repeat="true"  style="border-width: 0px">
							<td style="display: none" class="td">
								<label readonly="true" field="ORGAN_CODE" /></label>
							</td>
							<td align="center"><a href="#"><label   style="width: 100px;height: 20px;line-height:20px;"
								onclick="test(this)" field="ORGAN_NAME" /></label> <label
								style="display: none" readonly="true" field="ORGAN_CODE" /></label></a></td>
							
							<td align="right"><label field="TOTALCOUNT" ></label></td>
							<td align="right"><label  field="UNPLACED" ></label><label
								style="display: none"  field="ORGAN_CODE" ></label></td>	 
							<td align="right"><label  field="TOTAL_PLACED" ></label><label
								style="display: none"  field="ORGAN_CODE" ></label></td>
								
							<td align="right"><label  field="SELF_EMPLOYMENT" ></label><label
								style="display: none"  field="ORGAN_CODE" ></label></td>
								
							<td align="right"><label  field="FUXUEFUGONG" ></label><label
								style="display: none"  field="ORGAN_CODE" ></label></td>
							
							<td align="right"><label  field="PLACEMENT_GOV" ></label><label
								style="display: none"  field="ORGAN_CODE" ></label></td>
							
							<td align="right"><label  field="EMPLOYED" ></label><label
								style="display: none"  field="ORGAN_CODE" ></label></td>
							
							<td align="right"><label field="SELF_EMPLOYED" ></label><label
								style="display: none"  field="ORGAN_CODE" ></label></td>
						</tr>
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
</next:ViewPort>
</body>
</html>