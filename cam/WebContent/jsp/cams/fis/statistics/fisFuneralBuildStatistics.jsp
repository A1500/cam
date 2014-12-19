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
<title>殡仪馆建设情况统计</title>
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
<script type="text/javascript" src="fisFuneralBuildStatistics.js"></script>
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
	<!-- 殡仪馆建设情况 -->
	<model:dataset id="fisFuneralOrganManageDS"
		cmd="com.inspur.cams.fis.base.cmd.FisFuneralOrganManageQueryCmd"
		method="queryFuneralOrganBuildSum" pageAble="flase">
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
		<div align="center" style="width: 1000px;">
			<div align="center"><span id="reportTitle"
				style="font-size: large;">殡仪馆建设情况统计表</span></div>
		</div>
		<div align="right" class="L5form">
			<button id="backBtn" onclick="back()" style="display: none;">返回</button>
			&nbsp;&nbsp;
			<button onclick="exportExcel()" style="right: 50px;">导出Excel</button>&nbsp;&nbsp;&nbsp;&nbsp;
		</div>
		<br />
		<table style="border-style: hidden; width: 1000px;" class="table2"
			cellpadding="0" cellspacing="0" border="0" >
			<tr class="tr2">
				<td colspan="18" style="border-width: 0px" class="td2">
					<div align="left"><span class="btTitle">填报单位：<%=BspUtil.getOrganName()%></span></div>
				</td>
			</tr>
			<table width="1000px" class="table2" dataset="fisFuneralOrganManageDS" align="center">
				<tr class="tr2">
					<td class="tdTitle" align="center">单位</td>
					<td class="tdTitle" align="center">合计<BR />（㎡）</td>
					<td class="tdTitle" align="center">业务<BR />办理区<BR />（㎡）</td>
					<td class="tdTitle" align="center">告别区<BR />（㎡）</td>
					<td class="tdTitle" align="center">守灵区<BR />（㎡）</td>
					<td class="tdTitle" align="center">冷藏区<BR />（㎡）</td>
					<td class="tdTitle" align="center">防腐区<BR />（㎡）</td>
					<td class="tdTitle" align="center">整容区<BR />（㎡）</td>
					<td class="tdTitle" align="center">火化区<BR />（㎡）</td>
					<td class="tdTitle" align="center">骨灰<BR />寄存区<BR />（㎡）</td>
					<td class="tdTitle" align="center">丧属<BR />休息区<BR />（㎡）</td>
					<td class="tdTitle" align="center">停车场<BR />（㎡）</td>
					<td class="tdTitle" align="center">办公区<BR />（㎡）</td>
					<td class="tdTitle" align="center">职工<BR />休息区<BR />（㎡）</td>
					<td class="tdTitle" align="center">职工<BR />值班室<BR />（㎡）</td>
					<td class="tdTitle" align="center">职工<BR />食堂<BR />（㎡）</td>
					<td class="tdTitle" align="center">绿化<BR />面积<BR />（㎡）</td>
					<td class="tdTitle" align="center">其他<BR />（㎡）</td>
				</tr>
				<tr repeat="true" class="tr2" >
					<td class="td2" width="430px" align="center"><label field="NAME"
						onclick="forDown(this.parentNode.parentNode)" style="color: #0000FF"/></td>
						
					<td class="td2" width="80px" align="right"><label field="TOTALNUM"
						size="20" onclick="forDetail(this.parentNode.parentNode,'TOTALNUM')" /></td>
						
					<td class="td2" width="80px" align="right"><label field="NUM01"
						size="20" onclick="forDetail(this.parentNode.parentNode,'NUM01')"/></td>
					<td class="td2" width="80px" align="right"><label field="NUM02"
						size="20" onclick="forDetail(this.parentNode.parentNode,'NUM02')"/></td>
						
					<td class="td2" width="80px" align="right"><label field="NUM03"
						size="20" onclick="forDetail(this.parentNode.parentNode,'NUM03')"/></td>
					<td class="td2" width="80px" align="right"><label field="NUM04"
						size="20" onclick="forDetail(this.parentNode.parentNode,'NUM04')"/></td>
						
					<td class="td2" width="80px" align="right"><label field="NUM05"
						size="20" onclick="forDetail(this.parentNode.parentNode,'NUM05')"/></td>
					<td class="td2" width="80px" align="right"><label field="NUM06"
						size="20" onclick="forDetail(this.parentNode.parentNode,'NUM06')"/></td>
						
					<td class="td2" width="80px" align="right"><label field="NUM07"
						size="20" onclick="forDetail(this.parentNode.parentNode,'NUM07')"/></td>
					<td class="td2" width="80px" align="right"><label field="NUM08"
						size="20" onclick="forDetail(this.parentNode.parentNode,'NUM08')"/></td>
						
					<td class="td2" width="80px" align="right"><label field="NUM09"
						size="20" onclick="forDetail(this.parentNode.parentNode,'NUM09')"/></td>
					<td class="td2" width="80px" align="right"><label field="NUM10"
						size="20" onclick="forDetail(this.parentNode.parentNode,'NUM10')"/></td>
						
					<td class="td2" width="80px" align="right"><label field="NUM11"
						size="20" onclick="forDetail(this.parentNode.parentNode,'NUM11')"/></td>
					<td class="td2" width="80px" align="right"><label field="NUM12"
						size="20" onclick="forDetail(this.parentNode.parentNode,'NUM12')"/></td>
						
					<td class="td2" width="80px" align="right"><label field="NUM13"
						size="20" onclick="forDetail(this.parentNode.parentNode,'NUM13')"/></td>
					<td class="td2" width="80px" align="right"><label field="NUM14"
						size="20" onclick="forDetail(this.parentNode.parentNode,'NUM14')"/></td>
						
					<td class="td2" width="80px" align="right"><label field="NUM15"
						size="20" onclick="forDetail(this.parentNode.parentNode,'NUM15')"/></td>
					<td class="td2" width="80px" align="right"><label field="NUM16"
						size="20" onclick="forDetail(this.parentNode.parentNode,'NUM16')"/></td>
				</tr>
			</table>
			<table width="1000px" class="table2">
				<tr class="tr2">
					<td class="td2" colspan="9" style="border-width: 0px">
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