<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.sdmz.comm.util.BspUtil" %>
<html>
<head>
<next:ScriptManager/>
<script type="text/javascript" src="reportOfYear.js"></script>
<style>
<!--
body {
background-color:#EAF4FD;
}
table {
border-collapse:collapse;
}
input {
background-color:#EAF4FD;
border-style: none;
}
td {
border-style: solid;
border-color: #000000;
border-width: 1px;
}
.tdTitle {
border-style: solid;
border-color: #000000;
border-width: 1.5px;
font-weight: bold;
}
.tdIma {
background-image:url(line.bpm); 
background-repeat:no-repeat; 
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
	<model:dataset id="ds" cmd="com.inspur.sdmz.comm.query.assistanceOfAreaQuery.cmd.HelpOfAreaQueryCmd" global="true" autoLoad="false">
		<model:record>
		</model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
<next:Panel  name="form" width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="25%" >
	<next:Html>
	<fieldset style="overflow: visible;" class="GroupBox"><legend class="GroupBoxTitle">查询条件 <img class="GroupBoxExpandButton" src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>" onclick="collapse(this)" /> </legend>
		<div>
			<form style="width: 95%; height: 100%;" class="L5form">
				<table  border="1" width="100%" >
					<tr>
						<td class="FieldLabel" nowrap>救助年份:</td>
						<td class="FieldInput">
							<select id="yearQuery">
								<option value=""></option>
								<option value="2008">2008年</option>
								<option value="2009">2009年</option>
								<option value="2010">2010年</option>
								<option value="2011">2011年</option>
								<option value="2012">2012年</option>
								<option value="2013">2013年</option>
							</select>
						</td>
						<td class="FieldInput">
							<input type="hidden" id="jzlxquery"><button onclick="query()">查 询</button>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<button onclick="reset()">重 置</button>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</fieldset>
	</next:Html>
</next:Panel>
<next:Panel width="100%" border="0" bodyStyle="background-color:#EAF4FD;padding-bottom:10px;padding-top:12px;" autoHeight="25%" >
<next:Html>
<div align="center" id="reDiv" style="display:none">
<table dataset="ds">
	<tr height=25 align="center" nowrap>
		<td class="tdTitle" colspan="5"><strong><span id="reportTitle">各单位救助成果年统计报表</span></strong></td>
	</tr>
	<tr height=49>
		<td class="tdTitle" height=49 width=193 style='height:36.95pt;width:145pt'>
			<span>业务统计</span><br><span>救助单位</span>
		</td>
		<td class="tdTitle" align="center">实施救助活动次数</td>
		<td class="tdTitle" align="center">救助户数</td>
		<td class="tdTitle" align="center">救助人数</td>
		<td class="tdTitle" align="center">资金投入（元）</td>
	</tr>
	<tr repeat="true">
		<td style='width:145pt' align="left"><input type="text" field="PLAN_ORGAN_NAME" width="100%" readonly="true"/></td>
		<td style='width:110pt' align="right"><input type="text" field="NUM" readonly="true"/></td>
		<td style='width:101pt' align="right"><input type="text" field="FAMILY_NUM" readonly="true"/></td>
		<td style='width:101pt' align="right"><input type="text" field="PEOPLE_NUM" readonly="true"/></td>
		<td style='width:103pt' align="right"><input type="text" field="FUND" readonly="true"/></td>
	</tr>
</table>
</div>
</next:Html>
</next:Panel>
</next:ViewPort>
</body>
</html>
