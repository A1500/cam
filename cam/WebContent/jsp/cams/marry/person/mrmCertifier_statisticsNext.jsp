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
	String username = GetBspInfo.getBspInfo(request).getUserName();
%>
<script>
	var xzqu = '<%=request.getParameter("xzqu")%>';
	var selId = '<%=request.getParameter("selId")%>';
	var organName = '<%=BspUtil.getOrganName()%>';
	var pageflag ='<%=request.getParameter("pageflag")%>';
</script>
<html>
<head>
<next:ScriptManager />
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="mrmCertifier_statisticsNext.js"></script>
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
		cmd="com.inspur.cams.marry.query.papers.cmd.MarriageCertifierQueryCmd" global="true" method="query"
		autoLoad="false">
		<model:record>
			<model:field name="ITEM_CODE"/>
			<model:field name="ITEM_NAME"/>
			<model:field name="TOTAL_NUM"/>
			<model:field name="XZDW_NUM"/>
			<model:field name="CGGLSYDW_NUM"/>
			<model:field name="QEBKSYDW_NUM"/>
			<model:field name="MAN_NUM"/>
			<model:field name="WOMAN_NUM"/>
			<model:field name="HANZU_NUM"/>
			<model:field name="SHAO_NUM"/>
			<model:field name="AGE_AVG"/>
			<model:field name="AGE35_NUM"/>
			<model:field name="PARTY_NUM"/>
			<model:field name="LEAGUE_NUM"/>
			<model:field name="UNDERGRADUATES_NUM"/>
			<model:field name="JUNIOR_NUM"/>
			<model:field name="YEAR5_NUM"/>
			<model:field name="YEAR6_10_NUM"/>
			<model:field name="YEAR11_20_NUM"/>
			<model:field name="YEAR21_NUM"/>
			<model:field name="FIRST_TOTAL_NUM"/>
			<model:field name="FIRST_HG_NUM"/>
			<model:field name="FIRST_BK_NUM"/>
			<model:field name="FIRST_BKHG_NUM"/>
			<model:field name="FIRST_BKBHG_NUM"/>
			<model:field name="LAST_YK_NUM"/>
			<model:field name="LAST_SK_NUM"/>
			<model:field name="LAST_HG_NUM"/>
			<model:field name="LAST_BK_NUM"/>
			<model:field name="LAST_BKHG_NUM"/>
			<model:field name="LAST_CXZGZ_NUM"/>
			<model:field name="LAST_ZGZZDSX_NUM"/>
			<model:field name="DEPARTURE_NUM"/>
		</model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
	<next:Panel width="100%" border="0"
		bodyStyle="background-color:#EAF4FD;padding-bottom:10px;padding-top:12px;"
		height="100%" autoScroll="true">
		<next:Html>
			<div align="center" id="reDiv" style="display: none">
			<div align="center" style="width: 90%;">
			<div align="center"><span id="reportTitle"
				style="font-size: large;">婚姻颁证员统计分析</span></div>
			</div>
			<div align="right" class="L5form">
			<button onclick="forExcel()">导出Excel</button>&nbsp;&nbsp;
			<button onclick="back()">返回</button>&nbsp;&nbsp;
			</div>
			<br />
			<table style="border-style: hidden; width: 90%" cellpadding="0"
				cellspacing="0" border="0">
				 <tr>
					<td colspan="4" style="border-width: 0px">
					<div align="left"><span class="btTitle">统计单位：<%=BspUtil.getOrganName()%></span></div></td>
				</tr>
				<tr>
					<td colspan="4" style="border-width: 0px">
					<table width="100%" dataset="ds" align="center" >
						<tbody id="resultsBody">
						<tr>
							<td class="tdTitle" width="12%" align="center" rowspan="2">单位</td>
							<td class="tdTitle" width="4%" align="center" rowspan="2">总数<br>(人)</td>
							<td class="tdTitle" width="4%" align="center" colspan="3">性质</td>
							<td class="tdTitle" width="4%" align="center" colspan="2">性别</td>
							<td class="tdTitle" width="4%" align="center" colspan="2">民族</td>
							<td class="tdTitle" width="4%" align="center" colspan="2">年龄</td>
							<td class="tdTitle" width="4%" align="center" colspan="2">政治面貌</td>
							<td class="tdTitle" width="4%" align="center" colspan="2">学历</td>
							<td class="tdTitle" width="4%" align="center" colspan="4">从事工作时间</td>
							<td class="tdTitle" width="4%" align="center" colspan="5">首次考试</td>
							<td class="tdTitle" width="4%" align="center" colspan="7">复考情况</td>
							<td class="tdTitle" width="4%" align="center" rowspan="2">离岗人数</td>
						</tr>
						<tr>
							<td class="tdTitle" width="2%" align="center" >行政</td>
							<td class="tdTitle" width="2%" align="center" >参公<br>管理</td>
							<td class="tdTitle" width="2%" align="center" >金额<br>拨款</td>
							<td class="tdTitle" width="2%" align="center" >男</td>
							<td class="tdTitle" width="2%" align="center" >女</td>
							<td class="tdTitle" width="2%" align="center" >汉</td>
							<td class="tdTitle" width="2%" align="center" >少</td>
							<td class="tdTitle" width="2%" align="center" >平均</td>
							<td class="tdTitle" width="2%" align="center" >35岁<br>以下</td>
							<td class="tdTitle" width="2%" align="center" >党</td>
							<td class="tdTitle" width="2%" align="center" >团</td>
							<td class="tdTitle" width="2%" align="center" >全日本<br>科以上</td>
							<td class="tdTitle" width="2%" align="center" >大专</td>
							<td class="tdTitle" width="2%" align="center" >5年<br>以下</td>
							<td class="tdTitle" width="2%" align="center" >6-10<br>年</td>
							<td class="tdTitle" width="2%" align="center" >11-20<br>年</td>
							<td class="tdTitle" width="2%" align="center" >21年<br>以上</td>
							<td class="tdTitle" width="2%" align="center" >总数</td>
							<td class="tdTitle" width="2%" align="center" >合格<br>人数</td>
							<td class="tdTitle" width="2%" align="center" >补考<br>人数</td>
							<td class="tdTitle" width="2%" align="center" >补考<br>合格</td>
							<td class="tdTitle" width="2%" align="center" >补考<br>不合格</td>
							<td class="tdTitle" width="2%" align="center" >应考<br>人数</td>
							<td class="tdTitle" width="2%" align="center" >实考<br>人数</td>
							<td class="tdTitle" width="2%" align="center" >合格</td>
							<td class="tdTitle" width="2%" align="center" >补考</td>
							<td class="tdTitle" width="2%" align="center" >补考<br>合格</td>
							<td class="tdTitle" width="2%" align="center" >撤销资<br>格证</td>
							<td class="tdTitle" width="2%" align="center" >资格证自<br>动失效</td>
						</tr>
						<tr repeat="true">
							<td align="center"><a href="#"><label 
								field="ITEM_NAME" onclick="queryNextLevel(this)" style="width: 200px;"/></label><label style="display: none;"
								field="ITEM_CODE" /></label></a></td>
							<td align="right"><label style="width: 50px;height: 20px;" field="TOTAL_NUM"/></label></td>
							<td align="right"><label style="width: 50px;height: 20px;" field="XZDW_NUM"/></label></td>
							<td align="right"><label style="width: 50px;height: 20px;" field="CGGLSYDW_NUM"/></label></td>
							<td align="right"><label style="width: 50px;height: 20px;" field="QEBKSYDW_NUM"/></label></td>
							<td align="right"><label style="width: 50px;height: 20px;" field="MAN_NUM"/></label></td>
							<td align="right"><label style="width: 50px;height: 20px;" field="WOMAN_NUM"/></label></td>
							<td align="right"><label style="width: 50px;height: 20px;" field="HANZU_NUM"/></label></td>
							<td align="right"><label style="width: 50px;height: 20px;" field="SHAO_NUM"/></label></td>
							<td align="right"><label style="width: 50px;height: 20px;" field="AGE_AVG"/></label></td>
							<td align="right"><label style="width: 50px;height: 20px;" field="AGE35_NUM"/></label></td>
							<td align="right"><label style="width: 50px;height: 20px;" field="PARTY_NUM"/></label></td>
							<td align="right"><label style="width: 50px;height: 20px;" field="LEAGUE_NUM"/></label></td>
							<td align="right"><label style="width: 50px;height: 20px;" field="UNDERGRADUATES_NUM"/></label></td>
							<td align="right"><label style="width: 50px;height: 20px;" field="JUNIOR_NUM"/></label></td>
							<td align="right"><label style="width: 50px;height: 20px;" field="YEAR5_NUM"/></label></td>
							<td align="right"><label style="width: 50px;height: 20px;" field="YEAR6_10_NUM"/></label></td>
							<td align="right"><label style="width: 50px;height: 20px;" field="YEAR11_20_NUM"/></label></td>
							<td align="right"><label style="width: 50px;height: 20px;" field="YEAR21_NUM"/></label></td>
							<td align="right"><label style="width: 50px;height: 20px;" field="FIRST_TOTAL_NUM"/></label></td>
							<td align="right"><label style="width: 50px;height: 20px;" field="FIRST_HG_NUM"/></label></td>
							<td align="right"><label style="width: 50px;height: 20px;" field="FIRST_BK_NUM"/></label></td>
							<td align="right"><label style="width: 50px;height: 20px;" field="FIRST_BKHG_NUM"/></label></td>
							<td align="right"><label style="width: 50px;height: 20px;" field="FIRST_BKBHG_NUM"/></label></td>
							<td align="right"><label style="width: 50px;height: 20px;" field="LAST_YK_NUM"/></label></td>
							<td align="right"><label style="width: 50px;height: 20px;" field="LAST_SK_NUM"/></label></td>
							<td align="right"><label style="width: 50px;height: 20px;" field="LAST_HG_NUM"/></label></td>
							<td align="right"><label style="width: 50px;height: 20px;" field="LAST_BK_NUM"/></label></td>
							<td align="right"><label style="width: 50px;height: 20px;" field="LAST_BKHG_NUM"/></label></td>
							<td align="right"><label style="width: 50px;height: 20px;" field="LAST_CXZGZ_NUM"/></label></td>
							<td align="right"><label style="width: 50px;height: 20px;" field="LAST_ZGZZDSX_NUM"/></label></td>
							<td align="right"><label style="width: 50px;height: 20px;" field="DEPARTURE_NUM"/></label></td>
						</tr>
						</tbody>
					</table>
					</td>
				</tr>
				<tr>
					<td colspan="3" style="border-width: 0px">
					<div align="left"><span class="btTitle">制表人：<%=username %></span></div></td>
					<td colspan="2" style="border-width: 0px">
					<div align="right"><span class="btTitle">制表时间：<%=date %></span></div></td>
					<input type="hidden" id = "deptId"	/>
				</tr>
			</table>
			</div>
		</next:Html>
	</next:Panel>
</next:ViewPort>
</body>
</html>
