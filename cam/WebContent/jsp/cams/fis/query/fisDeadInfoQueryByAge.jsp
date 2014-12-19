<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<html>
	<head>
		<title>火化数据分年龄段统计</title>
		<next:ScriptManager/>
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
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy年MM月dd日");
	String date=sdf.format(new Date());
	int i=0;
%>
		<script type="text/javascript">
		    var orgCode ='<%=BspUtil.getOrganCode()%>';
			var orgName ='<%=BspUtil.getOrganName()%>';
		</script>
		<script type="text/javascript" src="fisDeadInfoQueryByAge.js"></script>
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
	<!-- 逝者信息 -->
	<model:dataset id="fisDeadInfoDS" cmd="com.inspur.cams.fis.base.cmd.FisFuneralDeadInfoQueryCmd"
		pageAble="false" method="queryNumByAge">
	</model:dataset>
</model:datasets>
<next:Panel  name="form" width="100%" border="0">
	<next:Html>	
	<fieldset><legend>查询条件
	<img class="GroupBoxExpandButton"
					src=<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%> onclick="collapse(this)" /> </legend>
				<div>
					<form class="L5form">
						<table width="100%" >
							<tr>
						        <td class="FieldLabel" width="15%">火化时间</td>
						        <td class="FieldInput" width="35%">
									<input type="text" id="cremationTimeBegin" style="text-align:right" onpropertychange="changeDateStyle(this)" onblur="check(this)"  format="Y-m-d" maxlength="10"/><img src="../../../../skins/images/default/rl.gif" align="middle" onclick="getDay(this);">
									&nbsp;至&nbsp;
									<input type="text" id="cremationTimeEnd" style="text-align:right" onpropertychange="changeDateStyle(this)" onblur="check(this)"  format="Y-m-d" maxlength="10"/><img src="../../../../skins/images/default/rl.gif" align="middle" onclick="getDay(this);">
						        </td>
						        <td  nowrap="nowrap" class="FieldLabel"  colspan="2">
									<button onclick="query()">查 询</button>&nbsp;<button onclick="undo()">重 置</button>
							    </td>
						     </tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>
<next:Panel width="100%" border="0" id="printPanel"
		bodyStyle="background-color:#EAF4FD;padding-bottom:10px;padding-top:12px;"
		height="100%" autoScroll="true">
		<next:Html>
			<div align="center" id="reDiv" style="display: none;" >
			<div align="center" style="width: 95%">
			<div align="center"><span id="reportTitle"
			style="font-size: large;">火化数据分年龄段统计报表</span></div>
			</div>
			<div align="right" class="L5form">
			<button onclick="exportExcel()">导出Excel</button>&nbsp;&nbsp;&nbsp;&nbsp;
			</div>
			<br/>
			<table style="border-style: hidden; width: 650px;" cellpadding="0" cellspacing="0" border="0">
				 <tr>
					<td colspan="2" style="border-width: 0px">
					<div align="left"><span class= "btTitle">统计单位：<%=BspUtil.getOrganName()%></span></div>
					<td colspan="2" style="border-width: 0px">
					<div align="right"><span class= "btTitle">统计时间：<label id="statisticsTime" class= "btTitle"></span></div>
				</tr>
				<table width="650px;" align="center" >
				<tr>
					<td class="tdTitle" align="center" width="5%" >区间</td>
					<td class="tdTitle"  align="center" width="10%" >0-49岁</td>
					<td class="tdTitle"  align="center" width="10%" >50-59岁</td>
					<td class="tdTitle"  align="center" width="10%" >60-69岁</td>
					<td class="tdTitle"  align="center" width="10%" >70-79岁</td>
					<td class="tdTitle"  align="center" width="10%" >80-89岁</td>
					<td class="tdTitle" align="center" width="10%" >90岁以上</td>
					
				</tr>
				<tr repeat="true" dataset="fisDeadInfoDS">
					<td class="tdTitle" align="center" width="5%" >数量</td>
					<td width="4%" align="right" class="td2"><label type="text"   field="ONE_NUM"
						size="20" readonly="true"></label></td> 
					<td width="4%" align="right" class="td2"><label type="text"  field="TWO_NUM" id="TWO_NUM"
						size="20" readonly="true" /></td>
					<td width="4%" align="right" class="td2"><label type="text" field="THREE_NUM" id="THREE_NUM"
						size="20" readonly="true" /></td>  
					<td width="4%" align="right" class="td2"><label type="text" field="FOUR_NUM" id="FOUR_NUM"
						size="20" readonly="true" /></td>
					<td width="4%" align="right" class="td2"><label type="text" field="FIVE_NUM" id="FIVE_NUM" 
						size="20" readonly="true" /></td>
					<td width="4%" align="right" class="td2"><label type="text" field="SIX_NUM"  id="SIX_NUM"  
						size="20" readonly="true" /></td>
					</tr>
					</table>
					<table width="650px;">	
					<tr>
					<td colspan="2" style="border-width: 0px">
					<div align="left"><span class= "btTitle">制表人：<%=BspUtil.getEmpOrgan().getShortName()%></span></div></td>
					<td colspan="4" style="border-width: 0px">
					<div align="right"><span class= "btTitle">制表时间：<%=date %></span></div>
				</tr></table>
		</table>
		</div>
		</next:Html>
		</next:Panel>

</body>
</html>