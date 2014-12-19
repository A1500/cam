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
<title>殡仪馆财政收支统计</title>
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
    var orgCode ='<%=BspUtil.getOrganCode()%>';
	var orgName ='<%=BspUtil.getOrganName()%>';
	var year = '<%=date.substring(0,4)%>';
</script>
<script type="text/javascript" src="../comm/common.js"></script>
<script type="text/javascript" src="../comm/common_selectCity.js"></script>
<script type="text/javascript" src="fisFuneralFinancialStatistics.js"></script>
<script type="text/javascript" src="../funeral/PublicTimeControl.js"></script>
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
	<!-- 殡仪馆工作人员情况 -->
	<model:dataset id="ds"
		cmd="com.inspur.cams.fis.base.cmd.FisFinancialSituationQueryCmd"
		method="queryFuneralFinancialSum" pageAble="flase">
	</model:dataset>
</model:datasets>

<next:Panel name="form" width="100%" border="0">
	<next:Html>
		<fieldset>
		<div>
		<form class="L5form">
		<table width="100%">
			<tr>
				<td class="FieldLabel" width="10%">统计时间:</td>
				<td class="FieldLabel" width="20%"><input type="text" id="SCremationTime"
					maxlength="10" />年&nbsp;至&nbsp; <input type="text"
					id="ECremationTime" maxlength="10" />年
					</td>
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
		<div align="center" style="width: 850px;">
			<div align="center"><span id="reportTitle"
				style="font-size: large;">殡仪馆财政收支统计表</span></div>
		</div>
		<div align="right" class="L5form">
			<button id="backBtn" onclick="back()" style="display: none;">返回</button>
			&nbsp;&nbsp;
			<button onclick="exportExcel()" style="right: 50px;">导出Excel</button>&nbsp;&nbsp;&nbsp;&nbsp;
		</div>
		<br />
		<table style="border-style: hidden; width: 850px;" class="table2"
			cellpadding="0" cellspacing="0" border="0" >
			<tr class="tr2">
				<td colspan="9" style="border-width: 0px" class="td2">
				<div align="left"><span class="btTitle">填报单位：<%=BspUtil.getOrganName()%></span></div>
				</td>
			</tr>
			<table width="850px" class="table2" dataset="ds" align="center">
				<tr class="tr2">
					<td class="tdTitle" align="center" rowspan="2">单位</td>
					<td class="tdTitle" style="border-bottom-width: 0px" align="center"  rowspan="2">结余</td>
					<td class="tdTitle" align="center" colspan="5">收入（万元）</td>
					<td class="tdTitle" align="center" colspan="7">支出（万元）</td>
					
				</tr>
				<tr class="tr2">
					<td class="tdTitle" style="border-bottom-width: 0px" align="center" >服务收入</td>
					<td class="tdTitle" style="border-bottom-width: 0px" align="center" >财政拨款</td>
					<td class="tdTitle" style="border-bottom-width: 0px" align="center" >福彩公益金</td>
					<td class="tdTitle" style="border-bottom-width: 0px" align="center" >银行贷款</td>
					<td class="tdTitle" style="border-bottom-width: 0px" align="center" >其他</td>
					
					<td class="tdTitle" style="border-bottom-width: 0px" align="center" >服务成本</td>
					<td class="tdTitle" style="border-bottom-width: 0px" align="center" >人员工资</td>
					<td class="tdTitle" style="border-bottom-width: 0px" align="center" >财政提留</td>
					<td class="tdTitle" style="border-bottom-width: 0px" align="center" >纳税</td>
					<td class="tdTitle" style="border-bottom-width: 0px" align="center" >基建</td>
					<td class="tdTitle" style="border-bottom-width: 0px" align="center" >设备采购</td>
					<td class="tdTitle" style="border-bottom-width: 0px" align="center" >其他</td>
				</tr>
				<tr repeat="true" class="tr2" >
					<td class="td2" width="380px" align="center"><label field="NAME"
						onclick="forDown(this.parentNode.parentNode)" style="color: #0000FF"/></td>
						
					<td class="td2" width="80px" align="right"><label field="INCOMESUM"
						size="20" onclick="forDetail(this.parentNode.parentNode,'INCOMESUM')"/></td>
					<td class="td2" width="80px" align="right"><label field="SERVICE_INCOMESUM"
						size="20" onclick="forDetail(this.parentNode.parentNode,'SERVICE_INCOMESUM')"/></td>
						
					<td class="td2" width="80px" align="right"><label field="FUND_FINANCESUM"
						size="20" onclick="forDetail(this.parentNode.parentNode,'FUND_FINANCESUM')"/></td>
					<td class="td2" width="80px" align="right"><label field="FUND_LOTTERYSUM"
						size="20" onclick="forDetail(this.parentNode.parentNode,'FUND_LOTTERYSUM')"/></td>
						
					<td class="td2" width="80px" align="right"><label field="FUND_BANKSUM"
						size="20"  onclick="forDetail(this.parentNode.parentNode,'FUND_BANKSUM')"/></td>
					<td class="td2" width="80px" align="right"><label field="OTHER_INCOMESUM"
						size="20" onclick="forDetail(this.parentNode.parentNode,'OTHER_INCOMESUM')"/></td>
						
					<td class="td2" width="80px" align="right"><label field="SERVICE_COSTSUM"
						size="20" onclick="forDetail(this.parentNode.parentNode,'SERVICE_COSTSUM')"/></td>					
					<td class="td2" width="80px" align="right"><label field="EMPLOYEE_SALARYSUM"
						size="20"  onclick="forDetail(this.parentNode.parentNode,'EMPLOYEE_SALARYSUM')"/></td>
						
					<td class="td2" width="80px" align="right"><label field="FISCAL_RESERVESUM"
						size="20" onclick="forDetail(this.parentNode.parentNode,'FISCAL_RESERVESUM')"/></td>
					<td class="td2" width="80px" align="right"><label field="TAX_COSTSUM"
						size="20" onclick="forDetail(this.parentNode.parentNode,'TAX_COSTSUM')"/></td>
						
					<td class="td2" width="80px" align="right"><label field="INFRASTRUCTURE_COSTSUM"
						size="20" onclick="forDetail(this.parentNode.parentNode,'INFRASTRUCTURE_COSTSUM')" /></td>
					<td class="td2" width="80px" align="right"><label field="EQUIPMENT_COSTSUM"
						size="20" onclick="forDetail(this.parentNode.parentNode,'EQUIPMENT_COSTSUM')"/></td>
						
					<td class="td2" width="80px" align="right"><label field="OTHER_COSTSUM"
						size="20" onclick="forDetail(this.parentNode.parentNode,'OTHER_COSTSUM')" /></td>
				</tr>
			</table>
			<table width="850px" class="table2">
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