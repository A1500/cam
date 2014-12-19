<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>一站结算_住院登记编辑</title>
<next:ScriptManager />
<script>
	var balanceId='<%=request.getParameter("balanceId")%>';
	var strike='<%=request.getParameter("strike")%>';
	var peopleId='<%=request.getParameter("peopleId")%>';
	var familyId='<%=request.getParameter("familyId")%>';
	
</script>

<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src="samMBalanceReg.js"></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
</head>
<body>
<model:datasets>
    <!-- 一站式救助查询救助人员基本信息 -->
	<model:dataset id="peopleDs"
		cmd="com.inspur.cams.drel.mbalance.cmd.SamMBalanceQueryCmd"
		method="queryPeople">
	</model:dataset>
	<!-- 家庭信息基本 -->
	<model:dataset id="familyDs"
		cmd="com.inspur.cams.drel.sam.cmd.SamBaseFamilyQueryCmd"
		method="queryFamily">
		<model:record
			fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoFamily"></model:record>
	</model:dataset>
	<!-- 救助基本信息 -->
	<model:dataset id="familyAssistanceDs"
		cmd="com.inspur.cams.drel.sam.cmd.SamFamilyAssistanceCmd">
		<model:record
			fromBean="com.inspur.cams.drel.sam.data.SamFamilyAssistance"></model:record>
	</model:dataset>
	<!-- 一站式救助信息 -->
	<model:dataset id="mBalanceDS"
		cmd="com.inspur.cams.drel.mbalance.cmd.SamMBalanceQueryCmd"
		global="true" autoLoad="false">
		<model:record
			fromBean="com.inspur.cams.drel.mbalance.data.SamMBalance">
			</model:record>
	</model:dataset>
	<!-- 一站式结算住院历史信息 -->
	<model:dataset id="hisDs"
		cmd="com.inspur.cams.drel.mbalance.cmd.SamMBalanceQueryCmd"
		method="queryForBalanceHistory"  >
	</model:dataset>
	
	<!-- 医前救助 -->
	<model:dataset id="beforeDs"
		cmd="com.inspur.cams.drel.mbalance.cmd.SamMedicalBeforeQueryCmd">
		<model:record
			fromBean="com.inspur.cams.drel.mbalance.data.SamMedicalBefore"></model:record>
	</model:dataset>
	<!-- 行政区划 -->
	<model:dataset id="cityDataset" global="true" autoLoad="true"
		cmd="com.inspur.cams.comm.diccity.cmd.DicCityQueryCommand">
		<model:record fromBean="com.inspur.cams.comm.diccity.data.DicCity"></model:record>
		<model:params>
			<model:param name="ID"
				value="1"></model:param>
		</model:params>
	</model:dataset>
	<!-- 封顶线 -->
	<model:dataset id="topLineDataset"
		cmd="com.inspur.cams.drel.mbalance.cmd.SamMedicalTopLineQueryCmd"
		global="true">
		<model:record
			fromBean="com.inspur.cams.drel.mbalance.data.SamMedicalTopLine"></model:record>
	</model:dataset>
	<!-- 一站式救助救助比例 -->
	<model:dataset id="perDataset"
		cmd="com.inspur.cams.drel.mbalance.cmd.SamMedicalPerQueryCmd"
		global="true">
		<model:record
			fromBean="com.inspur.cams.drel.mbalance.data.SamMedicalPer"></model:record>
	</model:dataset>
	<!-- 优抚救助比例列表 -->
	<model:dataset id="SamMedicalPerDS" autoLoad="true"
		cmd="com.inspur.cams.drel.mbalance.cmd.SamMedicalSpPerQueryCmd">
		<model:record
			fromBean="com.inspur.cams.drel.mbalance.data.SamMedicalSpPer"></model:record>
	</model:dataset>
	<!-- 性别 -->
	<model:dataset id="SexDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SEX'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
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
	<!-- 救助类型 -->
	<model:dataset id="assitanceTypeDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_assitance_Type'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 证书类型 -->
	<model:dataset id="cardTypeDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_sam_card_Type'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>

	<!-- 优抚对象类别 -->
	<model:dataset id="bptTypeDS" enumName="SAM.MEDICAL.TYPE" global="true"
		autoLoad="true">
	</model:dataset>
	<!-- 伤残等级 -->
	<model:dataset id="disabilityLevelDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_DISABILITY_LEVEL'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
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
<next:Panel width="98.5%">

	<next:Panel title="城乡居民医疗救助结算单" width="100%">
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="save" text="保存" handler="save" />
			<next:ToolBarItem iconCls="undo" text="返回" handler="back" />
		</next:TopBar>
		<next:Html>
			<form id="editForm" dataset="mBalanceDS" onsubmit="return false"
				style="padding: 5px;" class="L5form">
			<table border="1" width="100%">
				<tr>
					<td width="10%" class="FieldLabel" rowspan="4">基本信息</td>
					<td width="20%" class="FieldLabel">身份证号</td>
					<td width="23%" class="FieldInput">
					  <input id="idCard" name="idCard" style="width:150px" maxlength="18" 
					    onblur="getPeopleInfo(this.value)" />
					</td>
					
					<td width="15%" class="FieldLabel">性别</td>
					<td width="27%" class="FieldInput"><label id="sex" name="sex"
						dataset="SexDataset"> </label></td>
				</tr>
				<tr>
					<td  class="FieldLabel">姓名</td>
					<td class="FieldInput"><label id="name"	name="name" ></label></td>
					<td class="FieldLabel">工作单位</td>
					<td class="FieldInput"><label id="workUnitName" name="workUnitName" ></label></td>
				</tr>
				<tr>
					<td class="FieldLabel">家庭住址</td>
					<td colspan="3" class="FieldInput"><label id="address" name="address" ></label></td>
				</tr>
				<tr>
					<td class="FieldLabel">救助对象类别</td>
					<td class="FieldInput"><select name="assitanceType" style="width:150px"
						field="assitanceType" disabled="disabled"><option dataset="assitanceTypeDataset"> </select></td>
					<td class="FieldLabel">证件编号</td>
					<td class="FieldInput"><label name="cardNo" field="samCardNo" ></label></td>
				</tr>				
				<tr>
					<td class="FieldLabel" rowspan="3">住院信息</td>
				
					<td class="FieldLabel">入住医院</td>
					<td class="FieldInput">
					  <input name="hospitalName" field="hospitalName" style="width:150px" maxlength="25" />
					</td>
					<td class="FieldLabel">入住科室</td>
					<td class="FieldInput">
					    <input name="hospitalDep" field="hospitalDep" style="width:150px" maxlength="25" >
				    </td>
				</tr>
				<tr>
					<td class="FieldLabel">住院号</td>
					<td class="FieldInput"><input name="hospitalRecordId"
						field="hospitalRecordId" style="width:150px" maxlength="15" /></td>
					<td class="FieldLabel">病种</td>
					<td class="FieldInput"><input name="disease" field="disease" style="width:150px" maxlength="25"></td>
				</tr>
				<tr>
					<td class="FieldLabel">入院日期</td>
					<td class="FieldInput"><input type="text" name="inTime" style="width:150px" 
						field="inDate" format="Y-m-d" 
						readonly="readonly" onclick="LoushangDate(this)"/></td>
					<td class="FieldLabel">出院日期</td>
					<td class="FieldInput"><input type="text"  name="leaveTime" style="width:150px" 
						id="leaveDate" field="leaveDate" format="Y-m-d" 
						readonly="readonly" onclick="LoushangDate(this)"></td>
				<tr>
					<td class="FieldLabel" rowspan="2">医保信息</td>
					<td class="FieldLabel">住院总费用（元）:</td>
					<td class="FieldInput"><input type="text"  id="totalExpense" style="width:150px" 
						maxlength="16"  onblur="formatTotal(this.value)" name="totalExpense"
						field="totalExpense" /></td>
					<td class="FieldLabel">保险险种</td>
					<td class="FieldInput"><select name="insuranceType"  style="width:150px"
						field="insuranceType"><option dataset="SafeguardDataset" /> </select></td>
				</tr>
				<tr>
					<td class="FieldLabel">纳入保险报销费用（元）:</td>
					<td class="FieldInput"><input type="text"  id="insuranceExpense" style="width:150px" 
						maxlength="16" onblur="formatInsuranceExpense(this.value)"
						 name="insuranceExpense" field="insuranceExpense" /></td>
					<td class="FieldLabel">保险支付金额（元）:</td>
					<td class="FieldInput"><input type="text"  id="insurancePay" style="width:150px" 
						maxlength="16" onblur="formatInsurancePay(this.value)"
						name="insurancePay" field="insurancePay" /></td>
				</tr>
				<tr>
					<td class="FieldLabel" rowspan="1">其他信息</td>
					<td class="FieldLabel">商业保险报销（元）</td>
					<td class="FieldInput"><input id="illnessInsurancePay"  style="width:150px"   onchange="balancePay(this.value)" name="illnessInsurancePay" 
						field="illnessInsurancePay" > </input></td>
					<td class="FieldLabel">医院减免（元）</td>
					<td class="FieldInput"><input id="hospitalPay" onblur="balanceHospitalPay(this.value)" name="hospitalPay"  style="width:150px" 
						field="hospitalPay" > </input></td>
				</tr>
				<tr>
					<td class="FieldLabel" rowspan="2">医疗救助信息</td>
					<td class="FieldLabel">其他救助金额（元）</td>
					<td class="FieldInput"><label id="otherPay" name="otherPay" field="otherPay"></label></td>
					<td class="FieldLabel">救助比例（%）</td>
					<td class="FieldInput"><label id="assitancePer"	name="assitancePer" field="assitancePer" ></label></td>
				</tr>
				<tr>
					<td class="FieldLabel">医疗救助金额（元）</td>
					<td class="FieldInput"><label id="assitancePay"
						name="assitancePay" field="assitancePay" ></label></td>
					<td class="FieldLabel">自付费用（元）</td>
					<td class="FieldInput"><label id="personalPay"
						name="personalPay" field="personalPay" ></label></td>
				</tr>
			</table>
			</form>
		</next:Html>
	</next:Panel>
</next:Panel>
</body>
</html>
