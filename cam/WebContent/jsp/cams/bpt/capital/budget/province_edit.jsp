<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<next:ScriptManager />
<script type="text/javascript">
	var method ='<%=request.getParameter("method")%>';
	var inputId = '<%=request.getParameter("inputId")%>';
	var inputId1 = '<%=request.getParameter("inputId1")%>';
</script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request, "cams.js")%>"></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request, "camsCheck.js")%>"></script>
<script type="text/javascript" src="province_edit.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.bpt.capital.cmd.BPTCapitalBudgetQueryCmd" method="queryProvince" global="true">
		<model:record>
			<model:field name="INPUT_ID" type="string"/>
			<model:field name="INPUT_ID1" type="string"/>
			<model:field name="YEAR" type="string"/>
			<model:field name="COMPENSATION_SUBSIDY"/>
			<model:field name="INSTITUTION_SUBSIDY"/>
			<model:field name="MEDICAL_SUBSIDY"/>
			<model:field name="HOUSE_SUBSIDY"/>
			<model:field name="COMPENSATION_SUBSIDY1"/>
			<model:field name="INSTITUTION_SUBSIDY1"/>
			<model:field name="MEDICAL_SUBSIDY1"/>
			<model:field name="HOUSE_SUBSIDY1"/>
			<model:field name="NOTE" type="string"/>
			
			<model:field name="CENTRAL_TOTAL" type="string"/>
			<model:field name="PROVINCE_TOTAL" type="string"/>
			<model:field name="TOTAL" type="string"/>
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
	<next:Panel title="资金投入管理" height="100%" width="100%" autoScroll="false" id="Panel">
		<next:Html>
			<fieldset>
			<form id="form" method="post" dataset="ds" onsubmit="return false" style="padding: 5px;" class="L5form">
			<table border="0" width="100%">
				<tr>
					<td class="FieldLabel"></td>
					<td class="FieldInput" colspan="5">&nbsp;&nbsp;单位：万元</td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width:18%">年份</td>
					<td class="FieldInput" style="width:16%"><input type="text" id="YEAR" name="YEAR" field="YEAR" maxlength="4" onchange="checkYear(this)"/></td>
					<td class="FieldLabel" style="width:13%">中央抚恤补助经费</td>
					<td class="FieldInput" style="width:16%"><input type="text" id="COMPENSATION_SUBSIDY" field="COMPENSATION_SUBSIDY" onchange="checkIfFload(this);computeSumMon();"/></td>
					<td class="FieldLabel" style="width:18%">中央优抚事业单位补助经费</td>
					<td class="FieldInput" style="width:16%"><input type="text" id="INSTITUTION_SUBSIDY" field="INSTITUTION_SUBSIDY" onchange="checkIfFload(this);computeSumMon();"/></td>
				</tr>
				<tr>
					<td class="FieldLabel">中央医疗补助经费</td>
					<td class="FieldInput"><input type="text" id="MEDICAL_SUBSIDY" field="MEDICAL_SUBSIDY" onchange="checkIfFload(this);computeSumMon();"/></td>
					<td class="FieldLabel">中央住房补助经费</td>
					<td class="FieldInput"><input type="text" id="HOUSE_SUBSIDY" field="HOUSE_SUBSIDY" onchange="checkIfFload(this);computeSumMon();"/></td>
					<td class="FieldLabel">中央小计</td>
					<td class="FieldInput"><label id="CENTRAL_TOTAL" field="CENTRAL_TOTAL"/></td>
				</tr>
				<tr>
					<td class="FieldLabel">省抚恤补助经费</td>
					<td class="FieldInput"><input type="text" id="COMPENSATION_SUBSIDY1" field="COMPENSATION_SUBSIDY1" onchange="checkIfFload(this);computeSumMon();"/></td>
					<td class="FieldLabel">省优抚事业单位补助经费</td>
					<td class="FieldInput"><input type="text" id="INSTITUTION_SUBSIDY1" field="INSTITUTION_SUBSIDY1" onchange="checkIfFload(this);computeSumMon();"/></td>
					<td class="FieldLabel">省医疗补助经费</td>
					<td class="FieldInput"><input type="text" id="MEDICAL_SUBSIDY1" field="MEDICAL_SUBSIDY1" onchange="checkIfFload(this);computeSumMon();"/></td>
				</tr>
				<tr>
					<td class="FieldLabel">省住房补助经费</td>
					<td class="FieldInput"><input type="text" id="HOUSE_SUBSIDY1" field="HOUSE_SUBSIDY1" onchange="checkIfFload(this);computeSumMon();"/></td>
					<td class="FieldLabel">省小计</td>
					<td class="FieldInput"><label id="PROVINCE_TOTAL" field="PROVINCE_TOTAL"/></td>
					<td class="FieldLabel">合计</td>
					<td class="FieldInput"><label id="TOTAL" field="TOTAL"/></td>
				</tr>
				<tr>
					<input type="hidden" id="INPUT_ID" field="INPUT_ID"/>
					<input type="hidden" id="INPUT_ID1" field="INPUT_ID1"/>
					<td class="FieldLabel">备注</td>
					<td class="FieldInput" colspan="5"><textarea type="text" id="NOTE" field="NOTE" style="width:90%" rows="3"/></td>
				</tr>
			</table>
			</form>
			</fieldset>
		</next:Html>
	</next:Panel>
</next:Panel>
</body>
</html>