<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<next:ScriptManager />
<script type="text/javascript">
	var method ='<%=request.getParameter("method")%>';
	var organCode ='<%=request.getParameter("organCode")%>';
	var level ='<%=request.getParameter("level")%>';
	var inputId = '<%=request.getParameter("inputId")%>';
</script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request, "cams.js")%>"></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request, "camsCheck.js")%>"></script>
<script type="text/javascript" src="city_edit.js"></script>
</head>
<body>

<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.bpt.capital.cmd.BPTCapitalBudgetQueryCmd" method="queryCity" global="true">
		<model:record fromBean="com.inspur.cams.bpt.capital.data.BPTCapitalBudget">
			<model:field name="upperTotal" type="string"/>
			<model:field name="currentTotal" type="string"/>
			<model:field name="total" type="string"/>
		</model:record>
	</model:dataset>
</model:datasets>
<next:Panel autoHeight="true" bodyStyle="width:100%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="save" />
		<next:ToolBarItem symbol="-"></next:ToolBarItem>
		<next:ToolBarItem iconCls="disable" text="关闭" handler="fun_close" />
	</next:TopBar>
	<next:Panel title="预算信息" height="100%" width="100%"
		autoScroll="false" id="Panel">
		<next:Html>
			<fieldset>
			<form id="form" method="post" dataset="ds" onsubmit="return false"
				style="padding: 5px;" class="L5form">
			<table border="0" width="99%">
				<tr>
					<td class="FieldLabel"></td>
					<td class="FieldInput" colspan="5">&nbsp;&nbsp;单位：万元</td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width:16%">年份</td>
					<td class="FieldInput" style="width:16%"><input type="text" id="year" name="year" field="year" maxlength="4" onchange="checkYear(this)"/></td>
					<td class="FieldLabel" style="width:16%">抚恤补助经费(上级)</td>
					<td class="FieldInput" style="width:16%"><input type="text" id="compensationSubsidyUp" field="compensationSubsidyUp" onchange="checkIfFload(this);computeSumMon();"/></td>
					<td class="FieldLabel" style="width:20%">优抚事业单位补助经费(上级)</td>
					<td class="FieldInput" style="width:16%"><input type="text" id="institutionSubsidyUp" field="institutionSubsidyUp" onchange="checkIfFload(this);computeSumMon();"/></td>
				</tr>
				<tr>
					<td class="FieldLabel">医疗补助经费(上级)</td>
					<td class="FieldInput"><input type="text" id="medicalSubsidyUp" field="medicalSubsidyUp" onchange="checkIfFload(this);computeSumMon();"/></td>
					<td class="FieldLabel">住房补助经费(上级)</td>
					<td class="FieldInput"><input type="text" id="houseSubsidyUp" field="houseSubsidyUp" onchange="checkIfFload(this);computeSumMon();"/></td>
					<td class="FieldLabel">上级补助经费小计</td>
					<td class="FieldInput"><label id="upperTotal" field="upperTotal"/></td>
				</tr>
				<tr>
					<td class="FieldLabel">抚恤补助经费</td>
					<td class="FieldInput"><input type="text" id="compensationSubsidy" field="compensationSubsidy" onchange="checkIfFload(this);computeSumMon();"/></td>
					<td class="FieldLabel">优抚事业单位补助经费</td>
					<td class="FieldInput"><input type="text" id="institutionSubsidy" field="institutionSubsidy" onchange="checkIfFload(this);computeSumMon();"/></td>
					<td class="FieldLabel">医疗补助经费</td>
					<td class="FieldInput"><input type="text" id="medicalSubsidy" field="medicalSubsidy" onchange="checkIfFload(this);computeSumMon();"/></td>
				</tr>
				<tr>
					<td class="FieldLabel">住房补助经费</td>
					<td class="FieldInput"><input type="text" id="houseSubsidy" field="houseSubsidy" onchange="checkIfFload(this);computeSumMon();"/></td>
					<td class="FieldLabel">合计</td>
					<td class="FieldInput" colspan="3"><label id="total" field="total"/></td>
				</tr>
				<tr>
					<td class="FieldLabel">备注</td>
					<td class="FieldInput" colspan="5"><textarea type="text" id="note" field="note" style="width:98%" rows="2"/></td>
				</tr>
			</table>
			</form>
			</fieldset>
		</next:Html>
	</next:Panel>
</next:Panel>
</body>
</html>