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
<title>特困家庭汇总表</title>
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
<script type="text/javascript" src="samFamilyByTypeStatistics.js"></script>
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
	<!-- 特困家庭汇总统计 -->
	<model:dataset id="specialpoorFamilyDS"
		cmd="com.inspur.cams.drel.special.cmd.SpecialpoorFamilyQueryCmd"
		method="querySpecialpoorSumByType" pageAble="flase">
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
		<div align="center" id="reDiv" style="display: none; overflow-y: scroll;padding-left: 10px;padding-right: 10px;">
		<div align="center" style="width: 800px;">
			<div align="center"><span id="reportTitle"
				style="font-size: large;">特困家庭汇总表</span></div>
		</div>
		<div align="right" class="L5form">
			<button id="backBtn" onclick="back()" style="display: none;">返回</button>
			&nbsp;&nbsp;
			<button onclick="exportExcel()">导出Excel</button>
		</div>
		<br />
		<table style="border-style: hidden; width: 800px;" class="table2"
			cellpadding="0" cellspacing="0" border="0" >
			<tr class="tr2">
				<td colspan="8" style="border-width: 0px" class="td2">
				<div align="left"><span class="btTitle">填报单位：<%=BspUtil.getOrganName()%></span></div>
				<td colspan="7" style="border-width: 0px" class="td2">
				<div align="right"></div>
			</tr>
			<table width="800px" class="table2" dataset="specialpoorFamilyDS" align="center">
				<tr class="tr2">
					<td class="tdTitle" align="center" rowspan="2">地区</td>
					<td class="tdTitle" style="border-bottom-width: 0px" align="center" colspan="2">因病致贫</td>
					<td class="tdTitle" style="border-bottom-width: 0px" align="center" colspan="2">因残致贫</td>
					<td class="tdTitle" style="border-bottom-width: 0px" align="center" colspan="2">贫困老人</td>
					<td class="tdTitle" style="border-bottom-width: 0px" align="center" colspan="2">贫困儿童</td>
					<td class="tdTitle" style="border-bottom-width: 0px" align="center" colspan="2">其他原因</td>
					<td class="tdTitle" style="border-bottom-width: 0px" align="center" colspan="2">合计</td>
					<td class="tdTitle" style="border-bottom-width: 0px" align="center" colspan="2">特困家庭享受低保情况</td>
				</tr>
				<tr class="tr2">
					<td class="tdTitle" align="center">户数</td>
					<td class="tdTitle" align="center">人数</td>
					<td class="tdTitle" align="center">户数</td>
					<td class="tdTitle" align="center">人数</td>
					<td class="tdTitle" align="center">户数</td>
					<td class="tdTitle" align="center">人数</td>
					<td class="tdTitle" align="center">户数</td>
					<td class="tdTitle" align="center">人数</td>
					<td class="tdTitle" align="center">户数</td>
					<td class="tdTitle" align="center">人数</td>
					<td class="tdTitle" align="center">户数</td>
					<td class="tdTitle" align="center">人数</td>
					<td class="tdTitle" align="center">户数</td>
					<td class="tdTitle" align="center">人数</td>
				</tr>
				<tr repeat="true" class="tr2" >
					<td class="td2" width="340px" align="center"><label field="NAME"
						onclick="forDown(this.parentNode.parentNode)" style="color: #0000FF"/></td>
						
					<td class="td2" width="90" align="right"><label field="A_F_NUM"
						size="20" onclick="forDetail(this.parentNode.parentNode,'A_F_NUM')" /></td>
					<td class="td2" width="90" align="right"><label field="A_P_NUM"
						size="20" onclick="forDetail(this.parentNode.parentNode,'A_P_NUM')"/></td>
						
					<td class="td2" width="90" align="right"><label field="B_F_NUM"
						size="20" onclick="forDetail(this.parentNode.parentNode,'B_F_NUM')" /></td>
					<td class="td2" width="90" align="right"><label field="B_P_NUM"
						size="20" onclick="forDetail(this.parentNode.parentNode,'B_P_NUM')"/></td>
						
					<td class="td2" width="90" align="right"><label field="C_F_NUM"
						size="20" onclick="forDetail(this.parentNode.parentNode,'C_F_NUM')" /></td>
					<td class="td2" width="90" align="right"><label field="C_P_NUM"
						size="20" onclick="forDetail(this.parentNode.parentNode,'C_P_NUM')"/></td>
						
					<td class="td2" width="90" align="right"><label field="D_F_NUM"
						size="20" onclick="forDetail(this.parentNode.parentNode,'D_F_NUM')" /></td>
					<td class="td2" width="90" align="right"><label field="D_P_NUM"
						size="20" onclick="forDetail(this.parentNode.parentNode,'D_P_NUM')"/></td>
						
					<td class="td2" width="90" align="right"><label field="E_F_NUM"
						size="20" onclick="forDetail(this.parentNode.parentNode,'E_F_NUM')" /></td>
					<td class="td2" width="90" align="right"><label field="E_P_NUM"
						size="20" onclick="forDetail(this.parentNode.parentNode,'E_P_NUM')"/></td>
						
					<td class="td2" width="90" align="right"><label field="FAMILY_NUM"
						size="20" onclick="forDetail(this.parentNode.parentNode,'FAMILY_NUM')" /></td>
					<td class="td2" width="90" align="right"><label field="PEOPLE_NUM"
						size="20" onclick="forDetail(this.parentNode.parentNode,'PEOPLE_NUM')"/></td>
						
					<td class="td2" width="90" align="right"><label field="O_F_NUM"
						size="20" onclick="forDetail(this.parentNode.parentNode,'O_F_NUM')" /></td>
					<td class="td2" width="90" align="right"><label field="O_P_NUM"
						size="20" onclick="forDetail(this.parentNode.parentNode,'O_P_NUM')"/></td>
				</tr>
			</table>
			<table width="800px" class="table2">
				<tr class="tr2">
					<td class="td2" colspan="8" style="border-width: 0px">
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