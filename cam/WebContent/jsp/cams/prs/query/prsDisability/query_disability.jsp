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
	var xzqu = '<%=request.getParameter("xzqu")%>';
	var cxsjq = '<%=request.getParameter("cxsjq")%>';
	var cxsjz = '<%=request.getParameter("cxsjz")%>';
	var pageflag ='<%=request.getParameter("pageflag")%>';
</script>
<html>
<head>
<next:ScriptManager />
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="query_disability.js"></script>
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
		cmd="com.inspur.cams.prs.query.cmd.PrsDisabilityCmd" global="true"
		autoLoad="false">
		<model:record>
			<model:field name="ORGAN_CODE" type="string" />
			<model:field name="ORGAN_NAME" type="string" />
			<model:field name="OTHER" type="string" />

			<model:field name="YB_1" type="string" />
			<model:field name="YZ_1" type="string" />
			<model:field name="YG_1" type="string" />

			<model:field name="YB_2" type="string" />
			<model:field name="YZ_2" type="string" />
			<model:field name="YG_2" type="string" />

			<model:field name="YB_3" type="string" />
			<model:field name="YZ_3" type="string" />
			<model:field name="YG_3" type="string" />

			<model:field name="YB_4" type="string" />
			<model:field name="YZ_4" type="string" />
			<model:field name="YG_4" type="string" />


		</model:record>
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
				style="font-size: large;">山东省退役士兵统计表</span></div>
			</div>
			<div align="right" class="L5form">
			<button onclick="back()">返回</button>
			</div>
			<br />
			<table style="border-style: hidden; width: 90%" cellpadding="0"
				cellspacing="0" border="0">
				<tr>
					<td colspan="2" style="border-width: 0px">
					<div align="left"><span class="btTitle">统计单位：<%=BspUtil.getOrganName()%></span></div>
					<td colspan="2" style="border-width: 0px">
					<div align="right"><span class="btTitle">统计时间：<label id="statisticsTime" /></span></div>
				</tr>
				<tr>
					<td colspan="4" style="border-width: 0px">
					<table width="99.9%" dataset="ds" align="center">
						<tr>
							<td class="tdTitle" width="15%" align="center" rowspan="3">单&nbsp;&nbsp;&nbsp;&nbsp;位</td>
							<td class="tdTitle" width="4%" align="center" rowspan="3">非伤残</br>退役士兵</td>
							<td class="tdTitle" width="70%" align="center" colspan="12" >残疾退役士兵</td>
						</tr>
						<tr>
							<td class="tdTitle" width="8%" align="center" colspan="3">一级</td>
							<td class="tdTitle" width="8%" align="center" colspan="3">二级</td>
							<td class="tdTitle" width="8%" align="center" colspan="3">三级</td>
							<td class="tdTitle" width="8%" align="center" colspan="3">四级</td>
						</tr>
						<tr>
							<td class="tdTitle" width="4%" align="center" >因战</td>
							<td class="tdTitle" width="4%" align="center" >因公</td>
							<td class="tdTitle" width="4%" align="center" >因病</td>

							<td class="tdTitle" width="4%" align="center" >因战</td>
							<td class="tdTitle" width="4%" align="center" >因公</td>
							<td class="tdTitle" width="4%" align="center" >因病</td>

							<td class="tdTitle" width="4%" align="center" >因战</td>
							<td class="tdTitle" width="4%" align="center" >因公</td>
							<td class="tdTitle" width="4%" align="center" >因病</td>

							<td class="tdTitle" width="4%" align="center" >因战</td>
							<td class="tdTitle" width="4%" align="center" >因公</td>
							<td class="tdTitle" width="4%" align="center" >因病</td>
						</tr>
						<tr repeat="true">
							<td align="center"><a href="#"><label 
								onclick="test(this)" field="ORGAN_NAME" style="width: 100px;height: 20px;line-height:20px;"  ></label><label
								style="display: none"  field="ORGAN_CODE" ></label></a></td>
							
							<td align="right"><a href="#"><label  onclick="querydetail(this,'1')"  field="OTHER" ></label><label
								style="display: none"  field="ORGAN_CODE" ></label></a></td>
							
							<td align="right"><a href="#"><label onclick="querydetail(this,'2')"  field="YZ_1" ></label><label
								style="display: none"  field="ORGAN_CODE" ></label></a></td>
							
							<td align="right"><a href="#"><label onclick="querydetail(this,'3')"  field="YG_1" ></label><label
								style="display: none"  field="ORGAN_CODE" ></label></a></td>

							<td align="right"><a href="#"><label onclick="querydetail(this,'4')"  field="YB_1" ></label><label
								style="display: none"  field="ORGAN_CODE" ></label></a></td>
								
							<td align="right"><a href="#"><label onclick="querydetail(this,'5')"  field="YZ_2" ></label><label
								style="display: none"  field="ORGAN_CODE" ></label></a></td>
								
							<td align="right"><a href="#"><label onclick="querydetail(this,'6')"  field="YG_2" ></label><label
								style="display: none"  field="ORGAN_CODE" ></label></a></td>
							
							<td align="right"><a href="#"><label onclick="querydetail(this,'7')"  field="YB_2" ></label><label
								style="display: none"  field="ORGAN_CODE" ></label></a></td>
								
							<td align="right"><a href="#"><label onclick="querydetail(this,'8')"  field="YZ_3" ></label><label
								style="display: none"  field="ORGAN_CODE" ></label></a></td>
								
							<td align="right"><a href="#"><label onclick="querydetail(this,'9')"  field="YG_3" ></label><label
								style="display: none"  field="ORGAN_CODE" ></label></a></td>
								
							<td align="right"><a href="#"><label onclick="querydetail(this,'10')"  field="YB_3" ></label><label
								style="display: none"  field="ORGAN_CODE" ></label></a></td>
								
							<td align="right"><a href="#"><label onclick="querydetail(this,'11')"  field="YZ_4" ></label><label
								style="display: none"  field="ORGAN_CODE" ></label></a></td>
								
							<td align="right"><a href="#"><label onclick="querydetail(this,'12')"  field="YG_4" ></label><label
								style="display: none"  field="ORGAN_CODE" ></label></a></td>
								
							<td align="right"><a href="#"><label onclick="querydetail(this,'13')"  field="YB_4" ></label><label
								style="display: none"  field="ORGAN_CODE" ></label></a></td>
								
						</tr>
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