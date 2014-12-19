<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<%
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy年MM月dd日");
	String date=sdf.format(new Date());
	String username= GetBspInfo.getBspInfo(request).getUserName();
%>
<script>
	var organCode = '<%=BspUtil.getOrganCode()%>';
	var cxsjq = '<%=request.getParameter("cxsjq")%>';
	var cxsjz = '<%=request.getParameter("cxsjz")%>';
	var code = '<%=request.getParameter("code")%>';
</script>
<html>
<head>
<next:ScriptManager />
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="marryPeopleTypeQueryMap.js"></script>
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
}
.btTitle {
	word-break: break-all;
	font-weight: bold;
	font-size: x-small;
}

.tdBottom {
	border-style: solid;
	border-color: #000000;
	border-width: 1.5px;
	height: 20px;
	word-break: break-all;
	font-weight: bold;
	border-top-style: none;
	border-left-style: none;
	border-right-style: none;
    border-bottom-style: none;
    FONT-SIZE: 10pt;
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
	<model:dataset id="ds" cmd="com.inspur.cams.marry.query.marry.cmd.MarryPeopleTypeQueryCmd" global="true" method="query" autoLoad="false">
		<model:record>
			<model:field name="ITEM_CODE"/>
			<model:field name="ITEM_NAME"/>
			<model:field name="MARRY_NUM"/>
			<model:field name="MAINLAND_NUM"/>
			<model:field name="FOREIGNER_NUM"/>
			<model:field name="FOREIGNER_WOMAN_NUM"/>
			<model:field name="HK_NUM"/>
			<model:field name="HK_WOMAN_NUM"/>
			<model:field name="MO_NUM"/>
			<model:field name="MO_WOMAN_NUM"/>
			<model:field name="TW_NUM"/>
			<model:field name="TW_WOMAN_NUM"/>
			<model:field name="HQ_NUM"/>
			<model:field name="HQ_WOMAN_NUM"/>
		</model:record>
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
					<td class="FieldLabel">统计时间:</td>
					<td class="FieldInput" colspan="2" >
					<input type="text" name="cxsjq_y" id = "cxsjq_y" onchange="CheckTxt('cxsjq_y');" maxlength="4" style=" width: 60px;">年
					<select id = "cxsjq_m" style="width: 50px;"></select>月------
					<input type="text" name="cxsjz_y" id="cxsjz_y" onchange="CheckTxt('cxsjz_y');" maxlength="4" style=" width: 60px;">年
					<select id = "cxsjz_m" style="width: 50px;"></select>月
					<td class="FieldLabel">
					<button onclick="query()" id="queryButton">查 询</button>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<button onclick="initTime()">重 置</button>
					</td>
				</tr>
			</table>
			</form>
			</div>
			</fieldset>
		</next:Html>
	</next:Panel>
	<next:Panel width="100%" border="0" bodyStyle="background-color:#EAF4FD;padding-bottom:10px;padding-top:12px;" height="100%" autoScroll="true">
		<next:Html>
			<div align="center" id="reDiv" style="display: none;">
			<div align="center" style="width: 90%;">
			<div align="center"><span id="reportTitle"
				style="font-size: large;">结婚登记统计总表</span></div>
			</div>
			<div align="right" class="L5form">
			<button onclick="forExcel()">导出Excel</button>&nbsp;&nbsp;
			</div>
			<br/>
			<table style="border-style: hidden; width: 90%" cellpadding="0" cellspacing="0" border="0">
				 <tr>
					<td colspan="2" style="border-width: 0px">
					<div align="left"><span class= "btTitle">统计单位：<%= BspUtil.getOrganName()%></span></div>
					<td colspan="2" style="border-width: 0px">
					<div align="right"><span class= "btTitle">统计时间：<label id="statisticsTime" class= "btTitle"></span></div>
				</tr>
				<tr >
					<td colspan="4" style="border-width: 0px">
					<table width="99.9%" dataset="ds" align="center" >
						<tbody id="resultsBody">
						<tr>
							<td class="tdTitle" width="8%" align="center" rowspan="3">地区</td>
							<td class="tdTitle" width="2%" align="center" rowspan="3">结婚登记对数</td>
							<td class="tdTitle" width="2%" align="center" colspan="11"  >按居住地分类(对)</td>
						</tr>
						<tr>
							<td class="tdTitle" width="2%" align="center" rowspan="2" >内地居民间</td>
							<td class="tdBottom" width="2%" align="center" style="background-color: #DAE9F3">涉</td>
							<td class="tdBottom" width="2%" align="center" style="BORDER-RIGHT: #000000 1px solid;PADDING-RIGHT: 2px;background-color: #DAE9F3;" ></td>
							<td class="tdBottom" width="2%" align="center" style="background-color: #DAE9F3">涉</td>
							<td class="tdBottom" width="2%" align="center" style="BORDER-RIGHT: #000000 1px solid;PADDING-RIGHT: 2px;background-color: #DAE9F3;"></td>
							<td class="tdBottom" width="2%" align="center" style="background-color: #DAE9F3">涉</td>
							<td class="tdBottom" width="2%" align="center" style="BORDER-RIGHT: #000000 1px solid;PADDING-RIGHT: 2px;background-color: #DAE9F3;"></td>
							<td class="tdBottom" width="2%" align="center" style="background-color: #DAE9F3">涉</td>
							<td class="tdBottom" width="2%" align="center" style="BORDER-RIGHT: #000000 1px solid;PADDING-RIGHT: 2px;background-color: #DAE9F3;"></td>
							<td class="tdBottom" width="2%" align="center" style="background-color: #DAE9F3">涉</td>
							<td class="tdBottom" width="2%" align="center" style="BORDER-RIGHT: #000000 1px solid;PADDING-RIGHT: 2px;background-color: #DAE9F3;"></td>
						</tr>
							<tr>
							<td class="tdBottom" width="2%" align="center" style="BORDER-BOTTOM: #000000 1px solid;PADDING-BOTTOM: 2px;background-color: #DAE9F3;" >外</td>
							<td class="tdTitle" width="2%" align="center" >内地女性</td>
							<td class="tdBottom" width="2%" align="center" style="BORDER-BOTTOM: #000000 1px solid;PADDING-BOTTOM: 2px;background-color: #DAE9F3;">港</td>
							<td class="tdTitle" width="2%" align="center" >内地女性</td>
							<td class="tdBottom" width="2%" align="center" style="BORDER-BOTTOM: #000000 1px solid;PADDING-BOTTOM: 2px;background-color: #DAE9F3;" >澳</td>
							<td class="tdTitle" width="2%" align="center" >内地女性</td>
							<td class="tdBottom" width="2%" align="center" style="BORDER-BOTTOM: #000000 1px solid;PADDING-BOTTOM: 2px;background-color: #DAE9F3;" >台</td>
							<td class="tdTitle" width="2%" align="center" >内地女性</td>
							<td class="tdBottom" width="2%" align="center" style="BORDER-BOTTOM: #000000 1px solid;PADDING-BOTTOM: 2px;background-color: #DAE9F3;">华侨</td>
							<td class="tdTitle" width="2%" align="center" >内地女性</td>
						</tr>
						<tr repeat="true" >
							<td align="center"><a href="#"><label style="width: 100px;" field="ITEM_NAME"  onclick="queryNextLevel(this)" /></label><label style="display: none;" field="ITEM_CODE" /></label></a></td>
							<td align="right" style="padding-right: 2px"><label style="width: 30px;height: 20px;" field="MARRY_NUM"/></label></td>
							<td align="right" style="padding-right: 2px"><label style="width: 30px;height: 20px;" field="MAINLAND_NUM"/></label></td>
							<td align="right" style="padding-right: 2px"><label style="width: 30px;height: 20px;" field="FOREIGNER_NUM"/></label></td>
					        <td align="right" style="padding-right: 2px"><label style="width: 30px;height: 20px;" field="FOREIGNER_WOMAN_NUM"/></label></td>
						    <td align="right" style="padding-right: 2px"><label style="width: 30px;height: 20px;" field="HK_NUM"/></label></td>
						    <td align="right" style="padding-right: 2px"><label style="width: 30px;height: 20px;" field="HK_WOMAN_NUM"/></label></td>
						    <td align="right" style="padding-right: 2px"><label style="width: 30px;height: 20px;" field="MO_NUM"/></label></td>
						    <td align="right" style="padding-right: 2px"><label style="width: 30px;height: 20px;" field="MO_WOMAN_NUM"/></label></td>
						    <td align="right" style="padding-right: 2px"><label style="width: 30px;height: 20px;" field="TW_NUM"/></label></td>
						    <td align="right" style="padding-right: 2px"><label style="width: 30px;height: 20px;" field="TW_WOMAN_NUM"/></label></td>
						    <td align="right" style="padding-right: 2px"><label style="width: 30px;height: 20px;" field="HQ_NUM"/></label></td>
						    <td align="right" style="padding-right: 2px"><label style="width: 30px;height: 20px;" field="HQ_WOMAN_NUM"/></label></td>
						</tr>
						</tbody>
					</table>
					</td >
				</tr>
				<tr>
					<td colspan="2" style="border-width: 0px">
					<div align="left"><span class= "btTitle">制表人：<%=username %></span></div></td>
					<td colspan="4" style="border-width: 0px">
					<div align="right"><span class= "btTitle">制表时间：<%=date %></span></div>
				</tr>
			</table>
			</div>
			
		</next:Html>
	</next:Panel>
</next:ViewPort>
</body>
</html>
