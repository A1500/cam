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
<title>殡仪馆基本情况统计</title>
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
<script type="text/javascript" src="fisFuneralOrganStatistics.js"></script>
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
	<!-- 殡仪馆基本情况 -->
	<model:dataset id="fisFuneralOrganManageDS"
		cmd="com.inspur.cams.fis.base.cmd.FisFuneralOrganManageQueryCmd"
		method="queryFuneralOrganSum" pageAble="flase">
	</model:dataset>
</model:datasets>

<next:Panel name="form" width="100%" border="0">
	<next:Html>
		<fieldset>
		<div>
		<form class="L5form">
		<table width="100%">
			<tr>
				<td class="FieldLabel" style="display: none;">统计时间:</td>
				<td class="FieldLabel" style="display: none;"><input type="text" id="SCremationTime"
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
				<button type="reset" style="display: none;">重 置</button>
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
				style="font-size: large;">殡仪馆基本情况统计表</span></div>
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
				<td colspan="13" style="border-width: 0px" class="td2">
				<div align="left"><span class="btTitle">填报单位：<%=BspUtil.getOrganName()%></span></div>
				</td>
			</tr>
			<table width="850px" class="table2" dataset="fisFuneralOrganManageDS" align="center">
				<tr class="tr2">
					<td class="tdTitle" align="center" rowspan="2">单位</td>
					<td class="tdTitle" align="center" colspan="7">机构性质</td>
					<td class="tdTitle" align="center" rowspan="2">编制人数</td>
					<td class="tdTitle" align="center" rowspan="2">实有人数</td>
					<td class="tdTitle" align="center" rowspan="2">占地面积<BR />（亩）</td>
					<td class="tdTitle" align="center" rowspan="2">建筑面积<BR />（㎡）</td>
					<td class="tdTitle" align="center" rowspan="2">固定资产<BR />（万元）</td>
				</tr>
				<tr class="tr2">
					<td class="tdTitle" align="center">合计</td>
					<td class="tdTitle" align="center">全额<BR />拨款</td>
					<td class="tdTitle" align="center">差额<BR />拨款</td>
					<td class="tdTitle" align="center">自收<BR />自支</td>
					<td class="tdTitle" align="center">企业</td>
					<td class="tdTitle" align="center">民办<BR />非企业</td>
					<td class="tdTitle" align="center">其他</td>
				</tr>
				<tr repeat="true" class="tr2" >
					<td class="td2" width="330px" align="center"><label field="NAME"
						onclick="forDown(this.parentNode.parentNode)" style="color: #0000FF"/></td>
						
					<td class="td2" width="90" align="right"><label field="PROPTOTAL"
						size="20" onclick="forDetail(this.parentNode.parentNode,'PROPTOTAL')" /></td>
						
					<td class="td2" width="90" align="right"><label field="PROP01"
						size="20" onclick="forDetail(this.parentNode.parentNode,'PROP01')"/></td>
					<td class="td2" width="90" align="right"><label field="PROP02"
						size="20" onclick="forDetail(this.parentNode.parentNode,'PROP02')"/></td>
					<td class="td2" width="90" align="right"><label field="PROP03"
						size="20" onclick="forDetail(this.parentNode.parentNode,'PROP03')"/></td>
					<td class="td2" width="90" align="right"><label field="PROP04"
						size="20" onclick="forDetail(this.parentNode.parentNode,'PROP04')"/></td>
					<td class="td2" width="90" align="right"><label field="PROP06"
						size="20" onclick="forDetail(this.parentNode.parentNode,'PROP06')"/></td>
					<td class="td2" width="90" align="right"><label field="PROP05"
						size="20" onclick="forDetail(this.parentNode.parentNode,'PROP05')"/></td>
						
					<td class="td2" width="90" align="right"><label field="NUMOF"
						size="20" onclick="forDetail(this.parentNode.parentNode,'NUMOF')"/></td>
						
					<td class="td2" width="90" align="right"><label field="NUMREAL"
						size="20" onclick="forDetail(this.parentNode.parentNode,'NUMREAL')"/></td>
						
					<td class="td2" width="90" align="right"><label field="TOTALAREA"
						size="20" onclick="forDetail(this.parentNode.parentNode,'TOTALAREA')"/></td>
					<td class="td2" width="90" align="right"><label field="BUILTAREA"
						size="20" onclick="forDetail(this.parentNode.parentNode,'BUILTAREA')"/></td>
						
					<td class="td2" width="90" align="right"><label field="FIXEDASSETS"
						size="20" onclick="forDetail(this.parentNode.parentNode,'FIXEDASSETS')"/></td>
				</tr>
			</table>
			<table width="850px" class="table2">
				<tr class="tr2">
					<td class="td2" colspan="6" style="border-width: 0px">
					<div align="left"><span class="btTitle">制表人：<%=BspUtil.getEmpOrgan().getShortName()%></span></div>
					</td>
					<td class="td2" colspan="7" style="border-width: 0px">
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