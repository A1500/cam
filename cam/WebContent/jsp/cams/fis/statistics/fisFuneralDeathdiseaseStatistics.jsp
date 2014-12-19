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
<title>病故病种分殡仪馆统计</title>
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
<script type="text/javascript" src="fisFuneralDeathdiseaseStatistics.js"></script>
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
	<!-- 数据上报逝者信息 -->
	<model:dataset id="fisFuneralDeadInfoDS"
		cmd="com.inspur.cams.fis.base.cmd.FisFuneralDeadInfoQueryCmd"
		method="queryDeathDiseaseInfoSumByUnit" pageAble="flase">
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
		<div align="center" style="width: 850px;">
			<div align="center"><span id="reportTitle"
				style="font-size: large;">病故病种分殡仪馆统计表</span></div>
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
				<td colspan="10" style="border-width: 0px" class="td2">
				<div align="left"><span class="btTitle">填报单位：<%=BspUtil.getOrganName()%></span></div>
				<td colspan="15" style="border-width: 0px" class="td2">
				<div align="right"><span class="btTitle">填报时间：<label
					id="statisticsTime" class="btTitle"></span></div>
			</tr>
			<table width="850px" class="table2" dataset="fisFuneralDeadInfoDS" align="center">
				<tr class="tr2">
					<td class="tdTitle" align="center" rowspan="3">单位</td>
					<td class="tdTitle" style="border-bottom-width: 0px" align="center" colspan="3" rowspan="2">总数</td>
					<td class="tdTitle" align="center" colspan="22">病故病种</td>
				</tr>
				<tr class="tr2" style="height: 80px;">
					<td class="tdTitle" style="border-bottom-width: 0px" align="center" colspan="2">传染病</td>
					<td class="tdTitle" style="border-bottom-width: 0px" align="center" colspan="2">肿瘤</td>
					<td class="tdTitle" style="border-bottom-width: 0px" align="center" colspan="2">血液病</td>
					<td class="tdTitle" style="border-bottom-width: 0px" align="center" colspan="2">呼吸/消化<br />系统疾病</td>
					<td class="tdTitle" style="border-bottom-width: 0px" align="center" colspan="2">皮肤病</td>
					<td class="tdTitle" style="border-bottom-width: 0px" align="center" colspan="2">神经病</td>
					<td class="tdTitle" style="border-bottom-width: 0px" align="center" colspan="2">心脑血管<br />疾病</td>
					<td class="tdTitle" style="border-bottom-width: 0px" align="center" colspan="2">骨骼/肌肉<br />系统疾病</td>
					<td class="tdTitle" style="border-bottom-width: 0px" align="center" colspan="2">免疫系统<br />疾病</td>
					<td class="tdTitle" style="border-bottom-width: 0px" align="center" colspan="2">泌尿生殖<br />系统疾病</td>
					<td class="tdTitle" style="border-bottom-width: 0px" align="center" colspan="2">其他</td>
				</tr>
				<tr class="tr2">
					<td class="tdTitle" style="border-top-width: 0px"  align="center">&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td class="tdTitle" align="center">男</td>
					<td class="tdTitle" align="center">女</td>
					<td class="tdTitle" style="border-top-width: 0px"  align="center">&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td class="tdTitle" align="center">女</td>
					<td class="tdTitle" style="border-top-width: 0px"  align="center">&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td class="tdTitle" align="center">女</td>
					<td class="tdTitle" style="border-top-width: 0px"  align="center">&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td class="tdTitle" align="center">女</td>
					<td class="tdTitle" style="border-top-width: 0px"  align="center">&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td class="tdTitle" align="center">女</td>
					<td class="tdTitle" style="border-top-width: 0px"  align="center">&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td class="tdTitle" align="center">女</td>
					<td class="tdTitle" style="border-top-width: 0px" align="center">&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td class="tdTitle" align="center">女</td>
					<td class="tdTitle" style="border-top-width: 0px" align="center">&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td class="tdTitle" align="center">女</td>
					<td class="tdTitle" style="border-top-width: 0px" align="center">&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td class="tdTitle" align="center">女</td>
					<td class="tdTitle" style="border-top-width: 0px" align="center">&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td class="tdTitle" align="center">女</td>
					<td class="tdTitle" style="border-top-width: 0px" align="center">&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td class="tdTitle" align="center">女</td>
					<td class="tdTitle" style="border-top-width: 0px" align="center">&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td class="tdTitle" align="center">女</td>
				</tr>
				<tr repeat="true" class="tr2" >
					<td class="td2" width="320px" align="center"><label field="NAME"
						onclick="forDown(this.parentNode.parentNode)" style="color: #0000FF"/></td>
						
					<td class="td2" width="90" align="right"><label field="TOTALNUM"
						size="20" onclick="forDetail(this.parentNode.parentNode,'TOTALNUM')" /></td>
					<td class="td2" width="90" align="right"><label field="TOTALNUMM"
						size="20" onclick="forDetail(this.parentNode.parentNode,'TOTALNUMM')" /></td>
					<td class="td2" width="90" align="right"><label field="TOTALNUMW"
						size="20" onclick="forDetail(this.parentNode.parentNode,'TOTALNUMW')"/></td>
						
					<td class="td2" width="90" align="right"><label field="NUM01"
						size="20" onclick="forDetail(this.parentNode.parentNode,'NUM01')"/></td>
					<td class="td2" width="90" align="right"><label field="NUM01W"
						size="20" onclick="forDetail(this.parentNode.parentNode,'NUM01W')"/></td>
						
					<td class="td2" width="90" align="right"><label field="NUM02"
						size="20" onclick="forDetail(this.parentNode.parentNode,'NUM02')"/></td>
					<td class="td2" width="90" align="right"><label field="NUM02W"
						size="20" onclick="forDetail(this.parentNode.parentNode,'NUM02W')"/></td>
						
					<td class="td2" width="90" align="right"><label field="NUM03"
						size="20" onclick="forDetail(this.parentNode.parentNode,'NUM03')"/></td>
					<td class="td2" width="90" align="right"><label field="NUM03W"
						size="20" onclick="forDetail(this.parentNode.parentNode,'NUM03W')"/></td>
						
					<td class="td2" width="90" align="right"><label field="NUM04"
						size="20" onclick="forDetail(this.parentNode.parentNode,'NUM04')"/></td>
					<td class="td2" width="90" align="right"><label field="NUM04W"
						size="20" onclick="forDetail(this.parentNode.parentNode,'NUM04W')"/></td>
						
					<td class="td2" width="90" align="right"><label field="NUM05"
						size="20" onclick="forDetail(this.parentNode.parentNode,'NUM05')"/></td>
					<td class="td2" width="90" align="right"><label field="NUM05W"
						size="20" onclick="forDetail(this.parentNode.parentNode,'NUM05W')"/></td>
						
					<td class="td2" width="90" align="right"><label field="NUM06"
						size="20" onclick="forDetail(this.parentNode.parentNode,'NUM06')"/></td>
					<td class="td2" width="90" align="right"><label field="NUM06W"
						size="20" onclick="forDetail(this.parentNode.parentNode,'NUM06W')"/></td>
						
					<td class="td2" width="90" align="right"><label field="NUM07"
						size="20" onclick="forDetail(this.parentNode.parentNode,'NUM07')"/></td>
					<td class="td2" width="90" align="right"><label field="NUM07W"
						size="20" onclick="forDetail(this.parentNode.parentNode,'NUM07W')"/></td>
						
					<td class="td2" width="90" align="right"><label field="NUM08"
						size="20" onclick="forDetail(this.parentNode.parentNode,'NUM08')"/></td>
					<td class="td2" width="90" align="right"><label field="NUM08W"
						size="20" onclick="forDetail(this.parentNode.parentNode,'NUM08W')"/></td>
						
					<td class="td2" width="90" align="right"><label field="NUM09"
						size="20" onclick="forDetail(this.parentNode.parentNode,'NUM09')"/></td>
					<td class="td2" width="90" align="right"><label field="NUM09W"
						size="20" onclick="forDetail(this.parentNode.parentNode,'NUM09W')"/></td>
						
					<td class="td2" width="90" align="right"><label field="NUM10"
						size="20" onclick="forDetail(this.parentNode.parentNode,'NUM10')"/></td>
					<td class="td2" width="90" align="right"><label field="NUM10W"
						size="20" onclick="forDetail(this.parentNode.parentNode,'NUM10W')"/></td>
						
					<td class="td2" width="90" align="right"><label field="NUM11"
						size="20" onclick="forDetail(this.parentNode.parentNode,'NUM11')"/></td>
					<td class="td2" width="90" align="right"><label field="NUM11W"
						size="20" onclick="forDetail(this.parentNode.parentNode,'NUM11W')"/></td>
				</tr>
			</table>
			<table width="850px" class="table2">
				<tr class="tr2">
					<td class="td2" colspan="10" style="border-width: 0px">
					<div align="left"><span class="btTitle">制表人：<%=BspUtil.getEmpOrgan().getShortName()%></span></div>
					</td>
					<td class="td2" colspan="15" style="border-width: 0px">
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