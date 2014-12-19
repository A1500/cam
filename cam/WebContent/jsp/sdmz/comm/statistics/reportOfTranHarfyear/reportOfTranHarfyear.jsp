<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.sdmz.comm.util.BspUtil" %>
<html>
<head>
<next:ScriptManager/>
<script type="text/javascript" src="reportOfTranHarfyear.js"></script>
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
text-align:right;
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
	<model:dataset id="ds" cmd="com.inspur.sdmz.comm.report.ywsqReportOfMonth.cmd.YwsqReportOfMonthCmd" global="true" autoLoad="false">
		<model:record fromBean="com.inspur.sdmz.comm.report.ywsqReportOfMonth.dao.JavaBean">
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
						<td class="FieldLabel" nowrap>办理年份:</td>
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
							<select id="monthQuery">
								<option value=""></option>
								<option value="s">上半年</option>
								<option value="f">下半年</option>
							</select>
						</td>
						<td class="FieldInput">
							<input type="hidden" id="ywblquery"><button onclick="query()">查 询</button>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<button onclick="reset()">重 置</button>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</fieldset>
	</next:Html>
</next:Panel>
<next:Panel title="半年业务办理年统计报表" width="100%" border="0" bodyStyle="background-color:#EAF4FD;padding-bottom:10px;padding-top:12px;" height="100%" autoScroll="true" >
<next:Html>
<div align="center" id="reDiv" style="display:none">
<table dataset="ds" width="80%">
	<tr height=25 align="center">
		<td class="tdTitle" colspan="13"><strong><span id="reportTitle">各单位业务办理半年统计报表</span></strong></td>
	</tr>
	<tr>
		<td class="tdTitle" width="20%" rowspan="2">
			<span>业务统计</span><br><span>办理单位</span>
		</td>
		<td class="tdTitle" align="center" width="12%" colspan="4">救助业务统计</td>
		<td class="tdTitle" align="center" width="12%" colspan="4">投诉业务统计</td>
		<td class="tdTitle" align="center" width="12%" colspan="4">咨询业务统计</td>
		
	</tr>
	<tr>
		<td class="tdTitle" width="3%" align="center">总数</td>
		<td class="tdTitle" width="3%" align="center">已办结</td>
		<td class="tdTitle" width="3%" align="center">未办结</td>
		<td class="tdTitle" width="3%" align="center">超期办结</td>
		<td class="tdTitle" width="3%" align="center">总数</td>
		<td class="tdTitle" width="3%" align="center">已办结</td>
		<td class="tdTitle" width="3%" align="center">未办结</td>
		<td class="tdTitle" width="3%" align="center">超期办结</td>
		<td class="tdTitle" width="3%" align="center">总数</td>
		<td class="tdTitle" width="3%" align="center">已办结</td>
		<td class="tdTitle" width="3%" align="center">未办结</td>
		<td class="tdTitle" width="3%" align="center">超期办结</td>
	</tr>
	<tr repeat="true">
		<td width="20%" align="left"><input type="text" field="name" readonly="true"/></td>
		<td width="3%" align="right"><input type="text" field="Row1" size="6" readonly="true"/></td>
		<td width="3%" align="right"><input type="text" field="Row2" size="6" readonly="true"/></td>
		<td width="3%" align="right"><input type="text" field="Row3" size="6" readonly="true"/></td>
		<td width="3%" align="right"><input type="text" field="Row4" size="6" readonly="true"/></td>
		<td width="3%" align="right"><input type="text" field="Row5" size="6" readonly="true"/></td>
		<td width="3%" align="right"><input type="text" field="Row6" size="6" readonly="true"/></td>
		<td width="3%" align="right"><input type="text" field="Row7" size="6" readonly="true"/></td>
		<td width="3%" align="right"><input type="text" field="Row8" size="6" readonly="true"/></td>
		<td width="3%" align="right"><input type="text" field="Row9" size="6" readonly="true"/></td>
		<td width="3%" align="right"><input type="text" field="Row10" size="6" readonly="true"/></td>
		<td width="3%" align="right"><input type="text" field="Row11" size="6" readonly="true"/></td>
		<td width="3%" align="right"><input type="text" field="Row12" size="6" readonly="true"/></td>
	</tr>
</table>
</div>
</next:Html>
</next:Panel>
</next:ViewPort>
</body>
</html>