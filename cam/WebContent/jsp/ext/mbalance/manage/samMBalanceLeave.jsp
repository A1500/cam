<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="com.inspur.cams.comm.extuser.util.ExtBspInfo"%>
<%@page import="com.inspur.cams.drel.mbalance.util.BalanceConfig"%>
<%
	boolean needConnect ;
	if("false".equals(request.getParameter("needConnect"))){
		needConnect = false;
	} else {
		needConnect = BalanceConfig.needConnect(ExtBspInfo.getUserInfo(request).getAreaCode());;
	}
    String assistanceType = request.getParameter("assitanceType");
    String areaCode = ExtBspInfo.getUserInfo(request).getAreaCode();
    
%>
<html>
<head>
<title>一站结算_住院登记编辑</title>
<next:ScriptManager />
<script>
	var balanceId='<%=request.getParameter("balanceId")%>';
	var strike='<%=request.getParameter("strike")%>';
	var peopleId='<%=request.getParameter("peopleId")%>';
	var familyId='<%=request.getParameter("familyId")%>';
	var organCode='<%=ExtBspInfo.getUserInfo(request).getAreaCode() %>'
	var organId='<%=ExtBspInfo.getUserInfo(request).getOrganId()%>';
	var userId='<%=ExtBspInfo.getUserInfo(request).getUserId()%>';
	var userName='<%=ExtBspInfo.getUserInfo(request).getUserName()%>';
	var organName='<%=ExtBspInfo.getUserInfo(request).getOrganName() %>';
	var needConnect=<%=needConnect %>;
	var areaCode=<%=areaCode %>;
	var deductible=<%=BalanceConfig.getDeductible(ExtBspInfo.getUserInfo(request).getAreaCode(), assistanceType) %>;
</script>
<script type="text/javascript">
			function init(){
				peoDataset=L5.DatasetMgr.lookup(peoDataset);
				peoDataset.newRecord();
			}
		</script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"ISPrint.js")%>'></script>
<script type="text/javascript" src="samMBExtComm.js"></script>
<script type="text/javascript" src="samMBalanceLeave.js"></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
</head>
<body>
<model:datasets>
	<model:dataset id="mBalanceDS1"
		cmd="com.inspur.cams.drel.mbalance.cmd.SamMBalanceQueryCmd"
		global="true">
		<model:record
			fromBean="com.inspur.cams.drel.mbalance.data.SamMBalance"></model:record>
	</model:dataset>
	<!-- 新农合接口查询结果(总费用) -->
	<model:dataset id="insuranceDS"
		cmd="com.inspur.cams.drel.mbalance.cmd.SamMBalanceQueryCmd"
		method="doInfoXML">
		<model:record>
			<model:field name="NAME" />
			<model:field name="ID_CARD" />
			<model:field name="INSURANCE_NO" />
			<model:field name="RECORD_NO" />
			<model:field name="IN_DATE" />
			<model:field name="HOSPITAL_DEP" />
			<model:field name="DISEASE_CODE" />
			<model:field name="TOTAL_EXPENSE" />
			<model:field name="INSURANCE_EXPENSE" />
			<model:field name="INSURANCE_PAY" />
			<model:field name="ILLNESS_INSURANCE_PAY" />
			<model:field name="LEAVE_DATE" />
			<model:field name="DISEASE" />
		</model:record>
	</model:dataset>


	<!-- 新农合接口查询结果(费用明细) -->
	<model:dataset id="insuranceDetailDS"
		cmd="com.inspur.cams.drel.mbalance.cmd.SamMBalanceQueryCmd"
		method="doInfoXML">
		<model:record>
			<model:field name="NAME" />
			<model:field name="ID_CARD" />
			<model:field name="INSURANCE_NO" />
			<model:field name="RECORD_NO" />
			<model:field name="CODE" />
			<model:field name="EXP_NAME" />
			<model:field name="TYPE" />
			<model:field name="FORM" />
			<model:field name="EXP_DATE" />
			<model:field name="NUM" />
			<model:field name="PRICE" />
			<model:field name="EXP_MONEY" />
		</model:record>
	</model:dataset>
	<!-- 家庭成员信息 -->
	<model:dataset id="BaseinfoPeopleDataSet1"
		cmd="com.inspur.cams.drel.sam.cmd.BaseinfoPeopleQueryCmd" global="true">
		<model:record
			fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople"></model:record>
	</model:dataset>
	<!-- 一站式结算结算单 -->
	<model:dataset id="printDataset"
		cmd="com.inspur.cams.drel.mbalance.cmd.SamMBalanceQueryCmd"
		method="queryForSamList">
	</model:dataset>
	<!-- 人员基本信息 -->
	<model:dataset id="PeoDataset"
		cmd="com.inspur.cams.drel.mbalance.cmd.SamMBalanceQueryCmd"
		method="queryPeople">
	</model:dataset>
	<!-- 一站式救助信息 -->
	<model:dataset id="mBalanceDS"
		cmd="com.inspur.cams.drel.mbalance.cmd.SamMBalanceQueryCmd"
		autoLoad="false">
		<model:record
			fromBean="com.inspur.cams.drel.mbalance.data.SamMBalance"></model:record>
	</model:dataset>
	<!-- 医前救助 -->
	<model:dataset id="beforeDS"
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
				value="<%=ExtBspInfo.getUserInfo(request).getAreaCode()%>"></model:param>
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
	<!-- 一站式结算住院历史信息 -->
	<model:dataset id="hosDataset"
		cmd="com.inspur.cams.drel.mbalance.cmd.SamMBalanceQueryCmd"
		method="queryForSamList" global="true" >
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
	<!-- 病种 -->
	<model:dataset id="diseaseDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_DISEASE'></model:param>
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
<next:Panel width="99%">

	<next:Panel width="100%">
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="save" id="saveButton" text="保存"
				handler="save" />
			<next:ToolBarItem iconCls="undo" text="返回" handler="back" />
		</next:TopBar>
		<next:Html>
			<form id="editForm" dataset="mBalanceDS" onsubmit="return false"
				style="padding: 5px;" class="L5form">
			<table border="1" width="100%">
				<tr>
					<td width="10%" class="FieldLabel" rowspan="4">基本信息</td>
					<td width="20%" class="FieldLabel">姓名</td>
					<td width="23%" class="FieldInput"><label id="name"
						name="name" /></td>
					<td width="15%" class="FieldLabel">性别</td>
					<td width="27%" class="FieldInput"><label id="sex" name="sex"
						dataset="SexDataset"> </label></td>
				</tr>
				<tr>
					<td class="FieldLabel">身份证号</td>
					<td class="FieldInput"><label id="idCard" name="idCard" /></td>
					<td class="FieldLabel">工作单位</td>
					<td class="FieldInput"><label id="workUnitName"
						name="workUnitName" /></td>
				</tr>
				<tr>
					<td class="FieldLabel">家庭住址</td>
					<td colspan="3" class="FieldInput"><label id="address"
						name="address" /></td>
				</tr>
				<tr>
					<td class="FieldLabel">救助对象类别</td>
					<td class="FieldInput"><label name="assitanceType"
						field="assitanceType" dataset="assitanceTypeDataset"> </label></td>
					<td class="FieldLabel">证件编号</td>
					<td class="FieldInput"><label name="cardNo" field="samCardNo" /></td>
				</tr>
				<tr>
					<td class="FieldLabel" rowspan="2">住院信息</td>
					<td class="FieldLabel">入院日期</td>
					<td class="FieldInput"><label id="inDate" name="inDate"
						readonly="readonly" field="inDate" /></td>
					<td class="FieldLabel">出院日期</td>
					<td class="FieldInput"><input type="text" name="leaveTime" id="leaveDate"
						field="leaveDate" format="Y-m-d" readonly="readonly"
						onclick="LoushangDate(this)"></td>
				</tr>
				<tr>
					<td class="FieldLabel">住院号</td>
					<td class="FieldInput"><label name="hospitalRecordId"
						field="hospitalRecordId" /></td>
					<td class="FieldLabel">病种</td>
					<td class="FieldInput"><label name="disease" field="disease"
						dataset="diseaseDataset"> </label></td>
				</tr>
				<tr>
					<td class="FieldLabel" rowspan="2">医保信息</td>
					<td class="FieldLabel">住院总费用（元）:</td>
					<td class="FieldInput">
					    <input type="text" id="totalExpense" maxlength="16" onchange="formatTotal(this.value)" 
					    <%=needConnect?"readonly='readonly'":"" %>
						name="totalExpense" field="totalExpense" />
					</td>
					<td class="FieldLabel">保险险种</td>
					<td class="FieldInput"><label name="insuranceType" 
						field="insuranceType" dataset="SafeguardDataset"> </label></td>
				</tr>
				<tr>
					<td class="FieldLabel">纳入保险报销费用（元）:</td>
					<td class="FieldInput">
					    <input type="text" id="insuranceExpense" onchange="formatInsuranceExpense(this.value)" 
					    <%=needConnect?"readonly='readonly'":"" %>
						maxlength="16" name="insuranceExpense" field="insuranceExpense" />
					</td>
					<td class="FieldLabel">保险支付金额（元）:</td>
					<td class="FieldInput">
					    <input type="text" id="insurancePay" maxlength="16"  onchange="balance(this.value)"
					    <%=needConnect?"readonly='readonly'":"" %>
						name="insurancePay" field="insurancePay" />
					</td>
				</tr>
				<tr>
					<td class="FieldLabel" rowspan="1">其他信息</td>
					<td class="FieldLabel">商业保险报销（元）</td>
					<td class="FieldInput"><input id="illnessInsurancePay" onchange="balancePay(this.value)" name="illnessInsurancePay" 
						field="illnessInsurancePay" > </input></td>
					<td class="FieldLabel">医院减免（元）</td>
					<td class="FieldInput"><input id="hospitalPay" onblur="balanceHospitalPay(this.value)" name="hospitalPay" 
						field="hospitalPay" > </input></td>
				</tr>
				<tr>
					<td class="FieldLabel" rowspan="2">医疗救助信息</td>
					<td class="FieldLabel">其他救助金额（元）</td>
					<td class="FieldInput"><label id="otherPay" name="otherPay"></label></td>
					<td class="FieldLabel">救助比例</td>
					<td class="FieldInput"><label id="percentage" name="救助比例" percentage""/></td>
				</tr>
				<tr>
					<td class="FieldLabel">医疗救助金额（元）</td>
					<td class="FieldInput"><label id="assitancePay"
						name="assitancePay" field="assitancePay" ></label></td>
					<td class="FieldLabel">自付费用（元）</td>
					<td class="FieldInput"><label id="personalPay"
						name="personalPay" field="personalPay" ></label>
					<input type="hidden" name="balancePeopleId" id="balancePeopleId"
					value="<%=ExtBspInfo.getUserInfo(request).getUserId()%>"
					title="结算操作人ID" />
					<input type="hidden" type="text" name="peopleId" field="peopleId"
						disabled="disabled" />
					<input type="hidden" type="text" name="balanceId" field="balanceId"
						disabled="disabled" />
					<input type="hidden" type="hidden" type="text" name="familyId"
						field="familyId" disabled="disabled" />
					<input type="hidden" type="text" name="hospitalId"
						field="hospitalId" disabled="disabled" />
					</td>
				</tr>
				
			</table>
			</form>
		</next:Html>
	</next:Panel>

	<next:GridPanel height="150" width="100%" id="expGrid"
		title="新农合（城镇医保）系统查询结果" autoScroll="true" autoWidth="true"
		dataset="insuranceDS" hidden="<%=!needConnect%>">
		<next:Columns>
			<next:RowNumberColumn width="15" />
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column id="peopleId" header="姓名" field="NAME" width="10%">
				<next:TextField allowBlank="false" />
			</next:Column>
			<next:Column header="身份证号" field="ID_CARD" width="20%">
				<next:TextField />
			</next:Column>

			<next:Column id="TOTAL_EXPENSE" header="住院总费用" field="TOTAL_EXPENSE"
				width="10%">
				<next:TextField />
			</next:Column>

			<next:Column id="INSURANCE_EXPENSE" header="保内金额"
				field="INSURANCE_EXPENSE" width="10%">
				<next:TextField />
			</next:Column>

			<next:Column id="INSURANCE_PAY" header="（新农合）报销金额"
				field="INSURANCE_PAY" width="20%">
				<next:TextField />
			</next:Column>
			
			<next:Column id="ILLNESS_INSURANCE_PAY" header="大病保险报销"
				field="ILLNESS_INSURANCE_PAY" width="20%">
				<next:TextField />
			</next:Column>

			<next:Column id="DISEASE_CODE" header="病种代码" field="DISEASE_CODE" 
				width="10%" hidden="true">
				<next:TextField />
			</next:Column>

			<next:Column id="DISEASE" header="病种名称" field="DISEASE" width="10%">
				<next:TextField />
			</next:Column>

			<next:Column id="IN_DATE" header="入院日期" field="IN_DATE" width="10%">
				<next:TextField />
			</next:Column>

			<next:Column id="HOSPITAL_DEP" header="入院科室" field="HOSPITAL_DEP"
				width="10%">
				<next:TextField />
			</next:Column>

			<next:Column id="LEAVE_DATE" header="出院日期" field="LEAVE_DATE"
				width="10%">
				<next:TextField />
			</next:Column>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="insuranceDetailDS" />
		</next:BottomBar>
	</next:GridPanel>
</next:Panel>
</body>
</html>
