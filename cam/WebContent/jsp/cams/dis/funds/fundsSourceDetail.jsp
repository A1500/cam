<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.next.skin.SkinUtils" %>
<%@ page import="org.loushang.next.data.Record"%>
<html>
<head>
<title>资金来源管理明细</title>
<next:ScriptManager></next:ScriptManager>
<script>
	var sourceId = '<%=request.getParameter("sourceId")%>';
</script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request, "camsCheck.js")%>'></script>
<script type="text/javascript" src="../comm/disComm.js"></script>
<script type="text/javascript" src="fundsSourceDetail.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="disFundsSourceDs"
		cmd="com.inspur.cams.dis.base.cmd.DisFundsSourceQueryCmd"
		global="true">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisFundsSource"></model:record>
	</model:dataset>
	<model:dataset id="disFundsSourceDetailDs"
		cmd="com.inspur.cams.dis.base.cmd.DisFundsSourceDetailQueryCmd"
		global="true">
		<model:record
			fromBean="com.inspur.cams.dis.base.data.DisFundsSourceDetail"></model:record>
	</model:dataset>
	<!-- 资金类型 -->
	<model:dataset id="disAllocationTypeDs" enumName="DIS.ALLOCATION_TYPE"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 发放物资类型-->
	<model:dataset id="dmDisMaterialTypeDs"
		cmd="com.inspur.cams.dis.base.cmd.DicDisMaterialTypeQueryCmd" autoLoad="true" 
		pageAble="false" global="true">
		<model:record fromBean="com.inspur.cams.dis.base.data.DicDisMaterialType">
	 		<model:field name="value" mapping="code" type="string" />
			<model:field name="text" mapping="name" type="string" />
		</model:record>
	</model:dataset>
	<!-- 灾害种类 -->
	<model:dataset id="DisAllocationPurpose" enumName="DIS.ALLOCATION_PURPOSE" autoLoad="true" global="true">
	</model:dataset>
</model:datasets>
<next:Panel width="100%" >
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
	</next:TopBar>
	<next:Panel id="singleSourcePanel">
		<next:Html>
			<form method="post" onsubmit="return false" class="L5form"
				dataset="disFundsSourceDs">
			<table border="0" width="100%">
				<tr>
					<td class="FieldLabel" width="25%">年度:</td>
					<td class="FieldInput"><label name="年度"
						maxlength="4" field="disYear"  /></td>
					<td class="FieldLabel" width="25%">拨款类型:</td>
					<td class="FieldInput"><label name="拨款类型" style="width: 68%;" 
						field="upAllocationType" dataset="disAllocationTypeDs"/>
					</td>
				</tr>
				<tr>
					<td class="FieldLabel" width="25%">拨款总额:</td>
					<td class="FieldInput" width="100"><label name="拨款总额"
						field="amountTotal"
						style="text-align: right" id="amountTotal" readonly="readonly" /></td>

					<td class="FieldLabel" width="15%" rowspan="3">资金用途:</td>
					<td class="FieldInput" rowspan="3"><input type="checkbox" disabled="disabled"
						name="upAllocationPurpose" value="DC" field="upAllocationPurpose"
						label="冬春生活救助" />冬春生活救助 <br />
					<input type="checkbox" name="upAllocationPurpose" value="YJ" disabled="disabled"
						field="upAllocationPurpose" label="应急生活救助" />应急生活救助 <br />
					<input type="checkbox" name="upAllocationPurpose" value="CJ" disabled="disabled"
						field="upAllocationPurpose" label="灾区民房恢复重建补助 " />灾区民房恢复重建补助 <br />
					<input type="checkbox" name="upAllocationPurpose" value="GD" disabled="disabled"
						field="upAllocationPurpose" label="过渡性生活补助" />过渡性生活补助 <br />
					<input type="checkbox" name="upAllocationPurpose" value="SW" disabled="disabled"
						field="upAllocationPurpose" label="遇难人员家属抚慰" />遇难人员家属抚慰
					</td>
				</tr>
				<tr>
					<td class="FieldLabel" width="15%">拨款资金总额:</td>
					<td class="FieldInput"><label name="拨款资金总额"
						field="amount" 
						style="text-align: right" id="amount" /></td>
				</tr>
				<tr>
					<td class="FieldLabel" width="15%">拨款物资总额:</td>
					<td class="FieldInput"><label name="拨款物资总额"
						field="meterial" 
						style="text-align: right" id="meterial" readonly="readonly"/></td>
				</tr>
			</table>
			</form>
		</next:Html>
	</next:Panel>
	<next:GridPanel id="sourceGrid" dataset="disFundsSourceDetailDs"
		height="100%" hasSum="true">
		<next:TopBar>
			<next:ToolBarItem text="物资明细"></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn width="45" />
			<next:Column header='物资类型' field="meterialType" renderer="meterialTypeRenderer">
				<next:ComboBox dataset="dmDisMaterialTypeDs" typeAble="false" />
			</next:Column>
			<next:Column header="物资单位" field="meterialUnit" align="left">
				<next:TextField editable="false"/>
			</next:Column>
			<next:Column header="物资数量" field="meterialNum" align="right" 
				renderer="formatMoneyForDis" summaryType="sum">
				<next:ExtendConfig>
                    summaryRenderer : formatMoneyForDis
                </next:ExtendConfig>
				<next:TextField />
			</next:Column>
			<next:Column header="物资金额合计" field="meterialAccount" align="right"
				renderer="formatMoneyForDis" summaryType="sum">
				<next:ExtendConfig>
                    summaryRenderer : formatMoneyForDis
                </next:ExtendConfig>
				<next:TextField />
			</next:Column>
		</next:Columns>
	</next:GridPanel>
</next:Panel>
</body>
</html>
