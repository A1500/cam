<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="java.util.*"%>
<html>
<head>
<title>资金分配统计</title>
<next:ScriptManager />
<style>
.body2 {
	background-color: #EAF4FD;
}

.table2 {
	border-collapse: collapse;
}

.input2 {
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

.tdTitleNoTop{
	border-style: solid;
	border-color: #000000;
	border-width: 1.5px;
	height: 20px;
	word-break: break-all;
	font-weight: bold;
	border-top-width: 0px;
}

.tdTitleNoBottom {
	border-style: solid;
	border-color: #000000;
	border-width: 1.5px;
	height: 20px;
	word-break: break-all;
	font-weight: bold;
	border-bottom-width: 0px;
}

.tr2 {
	yexj00: expression(this . style . background =( rowIndex % 2 == 1) ?  
		'white ' :   '#EAF4FD ' )
}

.td2 {
	border-style: solid;
	border-color: #000000;
	border-width: 1px;
}

.tdIma {
	background-image: url(line.bpm);
	background-repeat: no-repeat;
}
</style>
<%
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月dd日");
	String date = sdf.format(new Date());
	int i = 0;
%>
<script type="text/javascript">
	var organCode='<%=BspUtil.getOrganCode()%>';
	var organName='<%=BspUtil.getOrganName()%>';
	var organType='<%=BspUtil.getOrganType()%>';
	var orgAreaCode = organCode.substring(2,8)+"000000";
</script>
<script type="text/javascript" src="fundsAllocationSumsList.js"></script>
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
	<!-- 统计 -->
	<model:dataset id="disFundsSourceDs"
		cmd="com.inspur.cams.dis.base.cmd.DisFundsSourceQueryCmd" method="queryAllocationForSums"
		pageAble="false">
	</model:dataset>
</model:datasets>

<next:Panel name="form" width="100%" border="0">
	<next:Html>
		<fieldset><legend>查询条件 <img
			class="GroupBoxExpandButton"
			src=<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>
			onclick="collapse(this)" /> </legend>
		<div>
		<form class="L5form">
		<table width="100%">
			<tr>
				<td class="FieldLabel">年度:</td>
				<td class="FieldInput"><input type="text" id="qDisYear" maxlength="4" value="2014" disabled="disabled"/></td>
				<td nowrap="nowrap" class="FieldLabel">
					<button onclick="query()">查 询</button>
					&nbsp;
					<button type="reset">重 置</button>
				</td>
			</tr>
		</table>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>
<!--逝者信息列表结束 -->
<next:Panel id="editDeadPanel"  bodyStyle="background-color:#EAF4FD;padding-bottom:10px;padding-top:12px;" width="100%"  
	height="100%" autoScroll="true">
	<next:Html>
		<div align="center" id="reDiv" style="display: none; overflow-y: scroll;">
		<div align="center" style="width: 800px;">
			<div align="center"><span id="reportTitle"
				style="font-size: large;">资金分配情况统计表</span></div>
		</div>
		<div align="right" class="L5form">
			<button id="backBtn" onclick="back()" style="display: none;">返回</button>
			&nbsp;&nbsp;
			<button onclick="exportExcel()" style="right: 50px;">导出Excel</button>&nbsp;&nbsp;&nbsp;&nbsp;
		</div>
		<br />
		<table style="border-style: hidden; width: 800px;" class="table2"
			cellpadding="0" cellspacing="0" border="0" >
			<tr class="tr2">
				<td colspan="9" style="border-width: 0px" class="td2">
				<div align="left"><span class="btTitle">填报单位：<%=BspUtil.getOrganName()%></span></div>
				<td colspan="10" style="border-width: 0px" class="td2">
				<div align="right"><span class="btTitle">填报时间：<label
					id="statisticsTime" class="btTitle"></span></div>
			</tr>
			<table width="800px" class="table2" dataset="disFundsSourceDs" align="center">
				<tr class="tr2">
					<td class="tdTitle" align="center" rowspan="3"><span id="areaName">地区</span></td>
					<td class="tdTitle" style="border-bottom-width: 0px" align="center" colspan="12">来源</td>
					<td class="tdTitle" style="border-bottom-width: 0px" align="center" colspan="3">拨付</td>
					<td class="tdTitle" style="border-bottom-width: 0px" align="center" colspan="3">结余</td>
				</tr>
				<tr class="tr2">
					<td class="tdTitle" style="border-bottom-width: 0px" align="center" colspan="3">合计</td>
					<td class="tdTitle" style="border-bottom-width: 0px" align="center" colspan="3">上级下拨</td>
					<td class="tdTitle" style="border-bottom-width: 0px" align="center" colspan="3">本级投入</td>
					<td class="tdTitle" style="border-bottom-width: 0px" align="center" colspan="3">社会捐赠</td>
					<td class="tdTitle" style="border-bottom-width: 0px" align="center" colspan="3">合计</td>
					<td class="tdTitle" style="border-bottom-width: 0px" align="center" colspan="3">合计</td>
				</tr>
				<tr class="tr2">
					<td class="tdTitle" style="border-bottom-width: 0px" align="center">小计</td>
					<td class="tdTitle" style="border-bottom-width: 0px" align="center">资金</td>
					<td class="tdTitle" style="border-bottom-width: 0px" align="center">物资</td>
					<td class="tdTitle" style="border-bottom-width: 0px" align="center">小计</td>
					<td class="tdTitle" style="border-bottom-width: 0px" align="center">资金</td>
					<td class="tdTitle" style="border-bottom-width: 0px" align="center">物资</td>
					<td class="tdTitle" style="border-bottom-width: 0px" align="center">小计</td>
					<td class="tdTitle" style="border-bottom-width: 0px" align="center">资金</td>
					<td class="tdTitle" style="border-bottom-width: 0px" align="center">物资</td>
					<td class="tdTitle" style="border-bottom-width: 0px" align="center">小计</td>
					<td class="tdTitle" style="border-bottom-width: 0px" align="center">资金</td>
					<td class="tdTitle" style="border-bottom-width: 0px" align="center">物资</td>
					<td class="tdTitle" style="border-bottom-width: 0px" align="center">小计</td>
					<td class="tdTitle" style="border-bottom-width: 0px" align="center">资金</td>
					<td class="tdTitle" style="border-bottom-width: 0px" align="center">物资</td>
					<td class="tdTitle" style="border-bottom-width: 0px" align="center">小计</td>
					<td class="tdTitle" style="border-bottom-width: 0px" align="center">资金</td>
					<td class="tdTitle" style="border-bottom-width: 0px" align="center">物资</td>
				</tr>
				<tr repeat="true" class="tr2" >
					<td class="td2" width="300px" align="center">
						<label field="NAME" style="color: #0000FF"/></td>
						
					<td class="td2" width="90" align="right"><label field="T"
						size="20" /></td>
					<td class="td2" width="90" align="right"><label field="A"
						size="20" /></td>
					<td class="td2" width="90" align="right"><label field="M"
						size="20" /></td>
						
					<td class="td2" width="90" align="right"><label field="A_T"
						size="20" /></td>
					<td class="td2" width="90" align="right"><label field="A_A"
						size="20" /></td>
					<td class="td2" width="90" align="right"><label field="A_M"
						size="20" /></td>
						
					<td class="td2" width="90" align="right"><label field="B_T"
						size="20" /></td>
					<td class="td2" width="90" align="right"><label field="B_A"
						size="20" /></td>
					<td class="td2" width="90" align="right"><label field="B_M"
						size="20" /></td>
						
					<td class="td2" width="90" align="right"><label field="C_T"
						size="20" /></td>
					<td class="td2" width="90" align="right"><label field="C_A"
						size="20" /></td>
					<td class="td2" width="90" align="right"><label field="C_M"
						size="20" /></td>
						
					<td class="td2" width="90" align="right"><label field="BF_T"
						size="20" /></td>
					<td class="td2" width="90" align="right"><label field="BF_A"
						size="20" /></td>
					<td class="td2" width="90" align="right"><label field="BF_M"
						size="20" /></td>
						
					<td class="td2" width="90" align="right"><label field="T_B"
						size="20" /></td>
					<td class="td2" width="90" align="right"><label field="A_B"
						size="20" /></td>
					<td class="td2" width="90" align="right"><label field="M_B"
						size="20" /></td>
				</tr>
			</table>
			<table width="800px" class="table2">
				<tr class="tr2">
					<td class="td2" colspan="9" style="border-width: 0px">
					<div align="left"><span class="btTitle">制表人：<%=BspUtil.getEmpOrgan().getShortName()%></span></div>
					</td>
					<td class="td2" colspan="10" style="border-width: 0px">
					<div align="right"><span class="btTitle">制表时间：<%=date%></span></div>
					</td>
				</tr>
			</table>
		</table>
		</div>
	</next:Html>
</next:Panel>
</body>
</html>