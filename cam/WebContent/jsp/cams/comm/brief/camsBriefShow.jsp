<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<%@page import="com.inspur.cams.comm.util.*"%>
<%
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
	String date=sdf.format(new Date());
	String organCode = BspUtil.getCorpOrgan().getOrganCode();
	String organName=DicUtil.getTextValueFromDic("DIC_CITY","ID",organCode,"NAME");
	
%>
<script>
	var organCode = '<%=organCode%>';
	var organName = '<%=organName%>';
</script>
<html>
<head>
<next:ScriptManager />
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="camsBriefShow.js"></script>
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
	font-size:20px;
}
.btTitle {
	word-break: break-all;
	font-weight: bold;
	font-size: x-small;
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
	<model:dataset id="camsBriefCountDataSet" cmd="com.inspur.cams.comm.brief.cmd.CamsBriefCountQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.comm.brief.data.CamsBriefCount"/>
	</model:dataset>
	<!-- 填报期数-->
	<model:dataset id="tbqsDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='CAMS_REPORT_WORK'></model:param>
			<model:param name="value" value='WORK_ID'></model:param>
			<model:param name="text" value='WORK_DESC'></model:param>
		</model:params>
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
				<tr>
					<td class="FieldLabel" width="10%">区划名称:</td>
					<td class="FieldInput" width="20%">
					<input type="text" name="区划名称" id="organName" field="organName" maxlength="50" style="width:80%" readonly />
					<img id="img" src="<%=SkinUtils.getImage(request,"l5/help.gif")%>"  style="cursor:hand" onclick="func_ForDomicileSelect()" />
					<input type="hidden" name="organCode" id="organCode"/></td>
					<td class="FieldLabel" width="10%">填报期数</td>
				     <td class="FieldInput" width="20%">
						<select id="reportSeason" name="填报期数" style="width:90%">
		                 <option dataset="tbqsDataSet"></option>
		            	</select>
					</td>
					<td class="FieldLabel">
					<button onclick="query()" id="queryButton">查 询</button>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<button type="reset">重 置</button>
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
				style="font-size: large;"></span></div>
			</div>
			<div align="right" class="L5form">
			<button onclick="forExcel()">导出Excel</button>&nbsp;&nbsp;
			</div>
			<br />
			<table style="border-style: hidden; width: 70%" cellpadding="0" cellspacing="0"
				border="0">
				 <tr>
					<td colspan="2" style="border-width: 0px">
					<div align="right"><span class= "btTitle"><%=date %></span></div></td>
				</tr>
				<tr >
					<td colspan="4" style="border-width: 0px">
					<table width="100%" dataset="camsBriefCountDataSet" align="center" id = "sourceTable">
						<tbody id="resultsBody">
						<tr>
							<td class="tdTitle" width="3%" align="center" >项目</td>
							<td class="tdTitle" width="1%" align="center" >单位</td>
							<td class="tdTitle" width="1%" align="center" >数量</td>
						</tr>
						<tr repeat="true">
							<td align="left" style="padding-right: 2px"><label style="width: 500px;font-size:18px;" field="showName"/></label></td>
							<td align="center" style="padding-right: 2px"><label style="width: 60px;font-size:18px;" field="unit"/></label></td>
							<td align="center" style="padding-right: 2px"><label style="width: 100px;font-size:18px;" field="count"/></label></td>
						</tr>
						</tbody>
					</table>
					</td >
				</tr>
			</table>
			</div>
			
		</next:Html>
	</next:Panel>
	
</next:ViewPort>
</body>
</html>
