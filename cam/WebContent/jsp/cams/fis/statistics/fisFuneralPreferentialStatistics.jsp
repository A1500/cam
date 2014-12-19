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
<title>享受惠民政策分殡仪馆统计</title>
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
</script>
<script type="text/javascript" src="../comm/common.js"></script>
<script type="text/javascript" src="../comm/common_selectCity.js"></script>
<script type="text/javascript" src="fisFuneralPreferentialStatistics.js"></script>
<script type="text/javascript" src="../comm/fisDeadInfoDetailComm.js"></script>
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
	<!-- 享受惠民政策分殡仪馆统计信息 -->
	<model:dataset id="fisFuneralDeadInfoDS"
		cmd="com.inspur.cams.fis.base.cmd.FisFuneralDeadInfoQueryCmd"
		method="queryDeathReduInfoSumByUnit" pageAble="flase">
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
				<td class="FieldLabel">统计时间:</td>
				<td class="FieldInput"><input type="text" id="SCremationTime"
					onpropertychange="changeDateStyle(this)" onblur="check(this)"
					format="Y-m-d" maxlength="10" value="2012-01-01"/><img
					src="../../../../skins/images/default/rl.gif" align="middle"
					onclick="getDay(this);"> &nbsp;至&nbsp; <input type="text"
					id="ECremationTime" onpropertychange="changeDateStyle(this)"
					onblur="check(this)" format="Y-m-d" maxlength="10"  value="2012-07-30"/><img
					src="../../../../skins/images/default/rl.gif" align="middle"
					onclick="getDay(this);"></td>
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
		<div align="center" style="width: 950px;">
			<div align="center"><span id="reportTitle"
				style="font-size: large;">享受惠民政策分殡仪馆统计表</span></div>
		</div>
		<div align="right" class="L5form">
			<button id="backBtn" onclick="back()" style="display: none;">返回</button>
			&nbsp;&nbsp;
			<button onclick="exportExcel()" style="right: 50px;">导出Excel</button>&nbsp;&nbsp;&nbsp;&nbsp;
		</div>
		<br />
		<table style="border-style: hidden; width: 950px;" class="table2"
			cellpadding="0" cellspacing="0" border="0" >
			<tr class="tr2">
				<td colspan="8" style="border-width: 0px" class="td2">
				<div align="left"><span class="btTitle">填报单位：<%=BspUtil.getOrganName()%></span></div>
				<td colspan="9" style="border-width: 0px" class="td2">
				<div align="right"><span class="btTitle">填报时间：<label
					id="statisticsTime" class="btTitle"></span></div>
			</tr>
			<table width="950px" class="table2" dataset="fisFuneralDeadInfoDS" align="center">
				<tr class="tr2">
					<td class="tdTitle" align="center" rowspan="3">单位</td>
					<td class="tdTitle" align="center" rowspan="3">总<BR />数量</td>
					<td class="tdTitle" align="center" rowspan="3">总<BR />金额</td>
					<td class="tdTitle" align="center" colspan="14">享受惠民政策</td>
				</tr>
				<tr class="tr2">
					<td class="tdTitle" align="center" colspan="2">全民普惠</td>
					<td class="tdTitle" align="center" colspan="2">城乡低保对象</td>
					<td class="tdTitle" align="center" colspan="2">农村五保对象</td>
					<td class="tdTitle" align="center" colspan="2">城市“三无”人员</td>
					<td class="tdTitle" align="center" colspan="2">优抚对象</td>
					<td class="tdTitle" align="center" colspan="2">因灾死亡人员</td>
					<td class="tdTitle" align="center" colspan="2">无名尸</td>
				</tr>
				<tr class="tr2">
					<td class="tdTitle" align="center">数量</td>
					<td class="tdTitle" align="center">金额</td>
					<td class="tdTitle" align="center">数量</td>
					<td class="tdTitle" align="center">金额</td>
					<td class="tdTitle" align="center">数量</td>
					<td class="tdTitle" align="center">金额</td>
					<td class="tdTitle" align="center">数量</td>
					<td class="tdTitle" align="center">金额</td>
					<td class="tdTitle" align="center">数量</td>
					<td class="tdTitle" align="center">金额</td>
					<td class="tdTitle" align="center">数量</td>
					<td class="tdTitle" align="center">金额</td>
					<td class="tdTitle" align="center">数量</td>
					<td class="tdTitle" align="center">金额</td>
				</tr>
				<tr repeat="true" class="tr2" >
					<td class="td2" width="350px" align="center"><label field="NAME"
						onclick="forDown(this.parentNode.parentNode)" style="color: #0000FF"/></td>
						
					<td class="td2" width="80px" align="right"><label field="TOTALNUM"
						size="20" onclick="forDetail(this.parentNode.parentNode,'TOTALNUM')" /></td>
					<td class="td2" width="80px" align="right"><label field="TOTALMONEY"
						size="20" onclick="forDetail(this.parentNode.parentNode,'TOTALMONEY')"/></td>
						
					<td class="td2" width="80px" align="right"><label field="PRE00"
						size="20" onclick="forDetail(this.parentNode.parentNode,'PRE00')"/></td>
					<td class="td2" width="80px" align="right"><label field="PRE00M"
						size="20" onclick="forDetail(this.parentNode.parentNode,'PRE00M')"/></td>
						
					<td class="td2" width="80px" align="right"><label field="PREC1"
						size="20" onclick="forDetail(this.parentNode.parentNode,'PREC1')"/></td>
					<td class="td2" width="80px" align="right"><label field="PREC1M"
						size="20" onclick="forDetail(this.parentNode.parentNode,'PREC1M')"/></td>
						
					<td class="td2" width="80px" align="right"><label field="PREC2"
						size="20" onclick="forDetail(this.parentNode.parentNode,'PREC2')"/></td>
					<td class="td2" width="80px" align="right"><label field="PREC2M"
						size="20" onclick="forDetail(this.parentNode.parentNode,'PREC2M')"/></td>
						
					<td class="td2" width="80px" align="right"><label field="PREC3"
						size="20" onclick="forDetail(this.parentNode.parentNode,'PREC3')"/></td>
					<td class="td2" width="80px" align="right"><label field="PREC3M"
						size="20" onclick="forDetail(this.parentNode.parentNode,'PREC3M')"/></td>
						
					<td class="td2" width="80px" align="right"><label field="PREC4"
						size="20" onclick="forDetail(this.parentNode.parentNode,'PREC4')"/></td>
					<td class="td2" width="80px" align="right"><label field="PREC4M"
						size="20" onclick="forDetail(this.parentNode.parentNode,'PREC4M')"/></td>
						
					<td class="td2" width="80px" align="right"><label field="PRED2"
						size="20" onclick="forDetail(this.parentNode.parentNode,'PRED2')"/></td>
					<td class="td2" width="80px" align="right"><label field="PRED2M"
						size="20" onclick="forDetail(this.parentNode.parentNode,'PRED2M')"/></td>
						
					<td class="td2" width="80px" align="right"><label field="PRED3"
						size="20" onclick="forDetail(this.parentNode.parentNode,'PRED3')"/></td>
					<td class="td2" width="80px" align="right"><label field="PRED3M"
						size="20" onclick="forDetail(this.parentNode.parentNode,'PRED3M')"/></td>
				</tr>
			</table>
			<table width="950px" class="table2">
				<tr class="tr2">
					<td class="td2" colspan="8" style="border-width: 0px">
					<div align="left"><span class="btTitle">制表人：<%=BspUtil.getEmpOrgan().getShortName()%></span></div>
					</td>
					<td class="td2" colspan="9" style="border-width: 0px">
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