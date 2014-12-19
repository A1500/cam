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
<title>火化数据分所属地区统计</title>
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
<script type="text/javascript" src="fisAreaDeadInfoQuery.js"></script>
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
		method="queryDeadInfoSumByArea" pageAble="flase">
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
				<td class="FieldLabel">火化时间:</td>
				<td class="FieldInput"><input type="text" id="SCremationTime"
					onpropertychange="changeDateStyle(this)" onblur="check(this)"
					format="Y-m-d" maxlength="10" value="2012-04-01"/><img
					src="../../../../skins/images/default/rl.gif" align="middle"
					onclick="getDay(this);"> &nbsp;至&nbsp; <input type="text"
					id="ECremationTime" onpropertychange="changeDateStyle(this)"
					onblur="check(this)" format="Y-m-d" maxlength="10"  value="2012-04-30"/><img
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
		<div align="center" style="width: 800px;">
			<div align="center"><span id="reportTitle"
				style="font-size: large;">火化数据分所属地区统计报表</span></div>
		</div>
		<div align="right" class="L5form">
		<button onclick="exportExcel()" style="right: 50px;">导出Excel</button>&nbsp;&nbsp;&nbsp;&nbsp;
		</div>
		<br />
		<table style="border-style: hidden; width: 800px;" class="table2"
			cellpadding="0" cellspacing="0" border="0" >
			<tr class="tr2">
				<td colspan="5" style="border-width: 0px" class="td2">
				<div align="left"><span class="btTitle">统计单位：<%=BspUtil.getOrganName()%></span></div>
				<td colspan="5" style="border-width: 0px" class="td2">
				<div align="right"><span class="btTitle">统计时间：<label
					id="statisticsTime" class="btTitle"></span></div>
			</tr>
			<table width="800px" class="table2" dataset="fisFuneralDeadInfoDS" align="center">
				<tr class="tr2">
					<td class="tdTitle" align="center" rowspan="2">序号</td>
					<td class="tdTitle" align="center" rowspan="2">所属地区</td>
					<td class="tdTitle" align="center" rowspan="2">总火化数(具)</td>
					<td class="tdTitle" align="center" colspan="7">其中，分民政减免类型</td>
				</tr>
				<tr class="tr2">
					<td class="tdTitle" align="center">城乡低保对象</td>
					<td class="tdTitle" align="center">农村五保对象</td>
					<td class="tdTitle" align="center">城市“三无”人员</td>
					<td class="tdTitle" align="center">优抚对象</td>
					<td class="tdTitle" align="center">因灾死亡人员</td>
					<td class="tdTitle" align="center">无名尸体</td>
					<td class="tdTitle" align="center">其它人员</td>
				</tr>
				<tr repeat="true" class="tr2" >
					<td class="td2" width="50px" align="center"><label
						field="ROWNUM" readonly="true"></label></td>
					<td class="td2" width="150px" align="right"><label field="NAME"
						onclick="forDown(this.parentNode.parentNode)" /></td>
					<td class="td2" width="90" align="center"><label field="NUM"
						size="20" onclick="forDetail(this.parentNode.parentNode,'NUM')" /></td>
					<td class="td2" width="90" align="center"><label field="C1"
						size="20" onclick="forDetail(this.parentNode.parentNode,'C1')"/></td>
					<td class="td2" width="90" align="center"><label field="C2"
						size="20" onclick="forDetail(this.parentNode.parentNode,'C2')"/></td>
					<td class="td2" width="90" align="center"><label field="C3"
						size="20" onclick="forDetail(this.parentNode.parentNode,'C3')"/></td>
					<td class="td2" width="90" align="center"><label field="C4"
						size="20" onclick="forDetail(this.parentNode.parentNode,'C4')"/></td>
					<td class="td2" width="90" align="center"><label field="D2"
						size="20" onclick="forDetail(this.parentNode.parentNode,'D2')"/></td>
					<td class="td2" width="90" align="center"><label field="D3"
						size="20" onclick="forDetail(this.parentNode.parentNode,'D3')"/></td>
					<td class="td2" width="90" align="center"><label field="OT"
						size="20" onclick="forDetail(this.parentNode.parentNode,'OT')"/></td>
				</tr>
			</table>
			<table width="800px" class="table2">
				<tr class="tr2">
					<td class="td2" colspan="5" style="border-width: 0px">
					<div align="left"><span class="btTitle">制表人：<%=BspUtil.getEmpOrgan().getShortName()%></span></div>
					</td>
					<td class="td2" colspan="5" style="border-width: 0px">
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