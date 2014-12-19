<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>

<html>
<!-- 一站结算_优抚补助比例主页面-->
<head>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript">
   var struId='<%=BspUtil.getStruId()%>';
   var organCode='<%=BspUtil.getOrganCode()%>';
   var organName='<%=BspUtil.getDeptOrgan().getOrganName()%>';
   var organArea='<%=BspUtil.getCorpOrgan().getOrganCode()%>';
</script>
<script type="text/javascript" src="samMedicalSpPer.js"></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="samMBalanceComm.js"></script>
</head>
<body>
<model:datasets>
	<!-- 优抚补助比例列表 -->
	<model:dataset id="SamMedicalPerDS"
		cmd="com.inspur.cams.drel.mbalance.cmd.SamMedicalSpPerQueryCmd">
		<model:record
			fromBean="com.inspur.cams.drel.mbalance.data.SamMedicalSpPer">
				<model:field name="domicileName" type="string"/>
				</model:record>
	</model:dataset>
	<!-- 优抚补助比例列表 -->
	<model:dataset id="SamMedicalLastPerDS" pageSize="100"
		cmd="com.inspur.cams.drel.mbalance.cmd.SamMedicalSpPerQueryCmd">
		<model:record
			fromBean="com.inspur.cams.drel.mbalance.data.SamMedicalSpPer">
				<model:field name="domicileName" type="string"/>
				</model:record>
	</model:dataset>
	<!-- 优抚补助比例列表 -->
	<model:dataset id="SamMedicalLastCheckPerDS"
		cmd="com.inspur.cams.drel.mbalance.cmd.SamMedicalSpPerQueryCmd">
		<model:record
			fromBean="com.inspur.cams.drel.mbalance.data.SamMedicalSpPer">
				<model:field name="domicileName" type="string"/>
				</model:record>
	</model:dataset>
	<!-- 优抚补助比例添加 -->
	<model:dataset id="SMTLForAdd"
		cmd="com.inspur.cams.drel.mbalance.cmd.SamMedicalSpPerQueryCmd">
		<model:record
			fromBean="com.inspur.cams.drel.mbalance.data.SamMedicalSpPer">
			<model:field name="domicileCode" type="string" rule="require|length{12}" />
			<model:field name="type" type="string" rule="require" />
			<model:field name="year" type="string" rule="require|length{4}" />
			<model:field name="safeguardType" type="string"
				rule="require|length{14}" />
			<model:field name="percentage" type="string"
				rule="require|length{10}" />
		</model:record>
	</model:dataset>
	<!-- 添加修改验证 -->
	<model:dataset id="querySMTLDS"
		cmd="com.inspur.cams.drel.mbalance.cmd.SamMedicalSpPerQueryCmd">
		<model:record
			fromBean="com.inspur.cams.drel.mbalance.data.SamMedicalSpPer">
			<model:field name="domicileCode" type="string" rule="require|length{12}" />
			<model:field name="type" type="string" rule="require" />
			<model:field name="year" type="string" rule="require|length{4}" />
			<model:field name="safeguardType" type="string"
				rule="require|length{14}" />
			<model:field name="percentage" type="string"
				rule="require|length{10}" />
		</model:record>
	</model:dataset>
	<!--  优抚补助比例修改 -->
	<model:dataset id="SMTLForUpdate"
		cmd="com.inspur.cams.drel.mbalance.cmd.SamMedicalSpPerQueryCmd">
		<model:record
			fromBean="com.inspur.cams.drel.mbalance.data.SamMedicalSpPer">
				<model:field name="domicileName" type="string"/>
			<model:field name="domicileCode" type="string" rule="require|length{12}" />
			<model:field name="type" type="string" rule="require" />
			<model:field name="year" type="string" rule="require|length{4}" />
			<model:field name="safeguardType" type="string"
				rule="require|length{14}" />
			<model:field name="percentage" type="string"
				rule="require|length{10}" />
		</model:record>
	</model:dataset>
	<!-- 得到省级补助比例 -->
	<model:dataset id="checkDataset"
		cmd="com.inspur.cams.drel.mbalance.cmd.SamMedicalSpPerQueryCmd">
		<model:record
			fromBean="com.inspur.cams.drel.mbalance.data.SamMedicalSpPer"></model:record>
	</model:dataset>
	<!-- 医疗保障方式 -->
	<model:dataset id="SafeguardDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_MEDICAL_STATUS'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 补助对象类别 -->
	<model:dataset id="bptTypeDataset" enumName="SAM.MEDICAL.TYPE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 伤残等级 -->
	<model:dataset id="disbilityLevelDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_DISABILITY_LEVEL'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>
<next:Panel width="99.9%" border="0">
	<next:Html>
		<form class="L5form">
		<fieldset><legend>查询条件</legend>
		<table width="100%">
			<tr>
				<td class="FieldLabel" style="width: 20%;">优抚对象属地:</td>
				<td class="FieldInput" style="width: 10%;"><input type="text"
					onclick="forCityHelp(this.id)" id="qdomicile"/></td>
				<td style="display: none;"><input type="text" id="qdomicileCode" /></td>
				<td class="FieldLabel" style="width: 17%;">年份:</td>
				<td class="FieldInput" style="width: 9%;"><input type="text" maxlength="4" 
					id="year" /></td>
				<td class="FieldLabel"  style="width: 20%;">医疗保障方式:</td>
				<td class="FieldInput"  style="width: 10%;"><select
					id="safeguardType">
					<option dataset="SafeguardDataset"></option>
				</select></td>
				<td class="FieldButton" style="width: 10%;">
				<button onclick="forQuery();">查询</button>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel">优抚对象类别:</td>
				<td class="FieldInput"><select id="type"
					name="优抚对象类别">
					<option dataset="bptTypeDataset"></option>
				</select></td>
				<td class="FieldLabel" >伤残等级:</td>
				<td class="FieldInput" ><select
					id="disabilityLevel">
					<option dataset="disbilityLevelDataset"></option>
				</select></td>
				<td class="FieldLabel" >补助比例:</td>
				<td class="FieldInput" ><input type="text" maxlength="16" onblur="checkNum(this.id)"
					id="percentage" /></td>
				<td class="FieldButton" >
				<button type="reset">重置</button>
				</td>
			</tr>
		</table>
		</fieldset>
		</form>
	</next:Html>
</next:Panel>




<next:EditGridPanel id="hlistPanel" dataset="SamMedicalPerDS" title="优抚补助比例管理"
	height="100%" width="99.9%">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="批量预设明年补助比例" iconCls="add" handler="setAsLastYear"></next:ToolBarItem>
		<next:ToolBarItem text="增加" iconCls="add" handler="addMedical"></next:ToolBarItem>
		<next:ToolBarItem text="修改" iconCls="detail" handler="updateMedical"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn />
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column header="优抚对象属地" field="domicileName" width="13%"
			editable="false">
			<next:TextField />
		</next:Column>
		<next:Column header="优抚对象类别" field="type" width="13%" editable="false"
			dataset="bptTypeDataset">
			<next:TextField></next:TextField>
		</next:Column>
		<next:Column header="年份" field="year" width="5%" editable="false">
			<next:TextField />
		</next:Column>
		<next:Column header="伤残等级" field="disabilityLevel" width="12%"
			editable="false" dataset="disbilityLevelDataset">
			<next:TextField />
		</next:Column>
		<next:Column header="医疗保障方式" field="safeguardType" width="17%"
			editable="false" dataset="SafeguardDataset">
			<next:TextField />
		</next:Column>
		<next:Column header="补助比例（%）" field="percentage" width="15%"
			editable="false">
			<next:TextField />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="SamMedicalPerDS" />
	</next:BottomBar>
</next:EditGridPanel>


<!-- 优抚优抚比例添加 -->
<next:Window id="addWin" closeAction="hide" title="优抚优抚比例添加" width="500">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="保存" iconCls="save" handler="forAdd"></next:ToolBarItem>
		<next:ToolBarItem text="返回" iconCls="return" handler="closeWin"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form"
			dataset="SMTLForAdd">
		<table width="100%">
			<tr>
				
				<td class="FieldLabel" style="width: 10%"><label>补助对象属地：</label></td>
				<td class="FieldInput" style="width: 10%"><label id="domicile" style="width: 100%;" 
					 name="补助对象属地"/></td>
				<td style="display: none;"><input type="text" id="domicileCode" field="domicileCode" /></td>
				<td class="FieldLabel"style="width: 10%"><label>优抚对象类别：</label></td>
				<td class="FieldInput" style="width: 10%"><select id="TypeAdd"
					field="type" name="优抚对象类别"
					onchange="forType(this.value,'disabilityLevelAdd');">
					<option dataset="bptTypeDataset"></option>
				</select></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>年份：</label></td>
				<td class="FieldInput"><input type="text" 
					field="year" name="年份" maxlength="4" /></td>
				<td class="FieldLabel"><label>伤残等级：</label></td>
				<td class="FieldInput"><select
					id="disabilityLevelAdd" field="disabilityLevel">
					<option dataset="disbilityLevelDataset"></option>
				</select></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>医疗保障方式：</label></td>
				<td class="FieldInput"><select id="safeguardTypeAdd"
					field="safeguardType" name="医疗保障方式">
					<option dataset="SafeguardDataset"></option>
				</select></td>
				<td class="FieldLabel" style="width: 10%"><label>补助比例（%）：</label></td>
				<td class="FieldInput" style="width: 10%"><input type="text" maxlength="16" onblur="checkNum(this.id)"
					id="percentageAdd" field="percentage" name="补助比例" /></td>
			</tr>
		</table>
		</form>
	</next:Html>
</next:Window>


<!-- 优抚优抚比例修改 -->
<next:Window id="updateWin" closeAction="hide" title="优抚补助比例修改"
	width="500">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="修改" iconCls="save" handler="forUpdate"></next:ToolBarItem>
		<next:ToolBarItem text="返回" iconCls="return" handler="closeWin1"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form"
			dataset="SMTLForUpdate">
		<table width="100%">
			<tr>
				<td class="FieldLabel" style="width: 10%"><label>补助对象属地：</label></td>
				<td class="FieldInput" ><label field="domicileName" id="updatedomicile" 
					 name="补助对象属地" style="width: 100%;" /></td>
				<td style="display:none;"><input type="text" id="updatedomicileCode" field="domicileCode" /></td>
				<td class="FieldLabel" style="width: 10%"><label>优抚对象类别：</label></td>
				<td class="FieldInput" style="width: 10%"><select field="type"
					name="优抚对象类别" onchange="forType(this.value,'disabilityLevelMod');">
					<option dataset="bptTypeDataset"></td>
			</tr>

			<tr>
				<td class="FieldLabel"><label>年份：</label></td>
				<td class="FieldInput" style="width: 10%"><input type="text" maxlength="4"
					field="year" name="年份" /></td>
				<td class="FieldLabel"><label>伤残等级：</label></td>
				<td class="FieldInput" style="width: 10%"><select
					id="disabilityLevelMod" field="disabilityLevel">
					<option dataset="disbilityLevelDataset"></option>
				</select></td>

			</tr>
			<tr>
				<td class="FieldLabel"><label>医疗保障方式：</label></td>
				<td class="FieldInput"><select field="safeguardType"
					name="医疗保障方式">
					<option dataset="SafeguardDataset"></option>
				</select></td>
				<td class="FieldLabel" style="width: 10%"><label>补助比例（%）：</label></td>
				<td class="FieldInput" style="width: 10%"><input type="text" maxlength="16" onblur="checkNum(this.id)"
					field="percentage" name="补助比例" /></td>
			</tr>
		</table>
		</form>
	</next:Html>
</next:Window>

</body>
</html>