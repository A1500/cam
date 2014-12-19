<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>一站结算住院登记</title>
<next:ScriptManager />
<script>
	var idField='<%=request.getParameter("dataBean")%>';
	var method='<%=request.getParameter("method")%>';
	var peopleId='<%=request.getParameter("peopleId")%>';
	var familyId='<%=request.getParameter("familyId")%>';
	var method='<%=request.getParameter("method")%>';
</script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="samMBalanceQueryPeoResult.js"></script>
</head>
<body>
<model:datasets>
	<!-- 一站式结算登记信息 -->
	<model:dataset id="ds"
		cmd="com.inspur.cams.drel.mbalance.cmd.SamMBalanceQueryCmd"
		global="true">
		<model:record
			fromBean="com.inspur.cams.drel.mbalance.data.SamMBalance"></model:record>
	</model:dataset>
	<!-- 家庭成员信息 -->
	<model:dataset id="BaseinfoPeopleDataSet1"
		cmd="com.inspur.cams.drel.sam.cmd.BaseinfoPeopleQueryCommand"
		global="true">
		<model:record
			fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople"></model:record>
	</model:dataset>
	<!-- 人员基本信息 -->
	<model:dataset id="PeoDataset"
		cmd="com.inspur.cams.drel.mbalance.cmd.SamMBalanceQueryCmd"
		method="queryPeople">
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
	<!-- 医疗救助类型 -->
	<model:dataset id="assitanceTypeDataset" autoLoad="true"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_assitance_Type'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 家庭信息基本 -->
	<model:dataset id="BaseinfoFamilyDataSet"
		cmd="com.inspur.cams.drel.sam.cmd.BaseinfoFamilyQueryCommand"
		global="true">
		<model:record
			fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoFamily"></model:record>
	</model:dataset>
	<!-- 救助基本信息 -->
	<model:dataset id="SamFamilyAssistanceDataSet"
		cmd="com.inspur.cams.drel.sam.cmd.SamFamilyAssistanceCommand"
		global="true">
		<model:record
			fromBean="com.inspur.cams.drel.sam.data.SamFamilyAssistance"></model:record>
	</model:dataset>
	<!-- 个人信息 -->
	<model:dataset id="BaseinfoPeopleDataSet"
		cmd="com.inspur.cams.drel.sam.cmd.BaseinfoPeopleQueryCommand"
		global="true">
		<model:record
			fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople"></model:record>
	</model:dataset>
	<!-- 家庭成员信息 -->
	<model:dataset id="BaseinfoPeopleDataSet1"
		cmd="com.inspur.cams.drel.sam.cmd.BaseinfoPeopleQueryCommand"
		global="true">
		<model:record
			fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople"></model:record>
	</model:dataset>
	<!-- 户主信息 -->
	<model:dataset id="BaseinfoPeopleDataSet2"
		cmd="com.inspur.cams.drel.sam.cmd.BaseinfoPeopleQueryCommand"
		global="true">
		<model:record
			fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople"></model:record>
	</model:dataset>
	<!-- 家庭成员信息_患病信息 -->
	<model:dataset id="BasePeopleDiseaseDataSet"
		cmd="com.inspur.cams.drel.sam.cmd.BasePeopleDiseaseQueryCommand"
		global="true">
		<model:record
			fromBean="com.inspur.cams.drel.sam.data.BasePeopleDisease"></model:record>
	</model:dataset>
	<!-- 一站式结算住院历史信息 -->
	<model:dataset id="hosDataset"
		cmd="com.inspur.cams.drel.mbalance.cmd.SamMBalanceQueryCmd"
		method="queryForSamList" global="true" pageSize="8">
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
</model:datasets>


<next:Panel hidden="true" title="基本信息" width="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem id="inHosRegButton" iconCls="add"
			text="入院登记" handler="inHosReg" />
		<next:ToolBarItem iconCls="return" text="返回" handler="back" />
	</next:TopBar>
	<next:Html>
		<form class="L5form" dataset="BaseinfoPeopleDataSet">
		<table width="100%">
			<tr>
				<td class="FieldLabel" width="15%">姓名</td>
				<td class="FieldInput" name="name" field="name"><label></label></td>
				<td class="FieldLabel" width="15%">性别</td>
				<td class="FieldInput"><label name="sex" field="sex"
					dataset="SexDataset"></label></td>
				<td class="FieldLabel" width="15%">身份证件号码</td>
				<td class="FieldInput"><label name="idCard" field="idCard"></label></td>
			</tr>
			<tr>
				<td class="FieldLabel" width="15%">民族</td>
				<td class="FieldInput"><label name="nation" field="nation"></label></td>
				<td class="FieldLabel" width="15%">住址</td>
				<td class="FieldInput"><label name="address" field="address"></label></td>
				<td class="FieldLabel" width="15%">户籍类别</td>
				<td class="FieldInput"><label name="domicileType"
					field="domicileType"></label></td>
			</tr>
			<tr>
				<td class="FieldLabel" width="15%">医疗保障方式</td>
				<td class="FieldInput"><label name="safeguardType"
					field="safeguardType"></label></td>
				<td class="FieldLabel" width="15%">医疗保险</td>
				<td width="15%" class="FieldInput"><select name="medicalCode"
					disabled="disabled" field="medicalCode">
					<option dataset="SafeguardDataset"></option>
				</select></td>
				<td class="FieldLabel" width="15%">本年受助金额/封顶线</td>
				<td class="FieldInput"><label id="personTotal"></label></td>
			</tr>
		</table>
		</form>
	</next:Html>
</next:Panel>

<!-- 个人及家庭信息 -->
<next:Panel id="funCreate" title="" collapsible="true" width="100%"
	autoHeight="true">
	<next:TabPanel name="tabpanel-div" height="420" activeTab="0">
		<next:Tabs>
			<next:Panel autoWidth="ture" title="家庭基本信息" width="100%">
			<next:Panel>
				<next:Html>
					<form id="BaseinfoFamilyForm" method="post"
						dataset="BaseinfoFamilyDataSet" onsubmit="return false"
						style="padding: 5px;" class="L5form">
					<table border="0" width="100%">
						<tr>
							<td class="FieldLabel" style="width: 15%">户主姓名:</td>
							<td class="FieldInput" style="width: 20%"><label
								name="patriarchName" field="patriarchName" /><font color="red">*</font></td>
							<td class="FieldLabel" style="width: 15%">身份证件类型:</td>
							<td class="FieldInput" style="width: 20%"><label
								name="idCardType" field="idCardType" /><font color="red">*</font></td>
							<td class="FieldLabel" style="width: 15%">身份证号:</td>
							<td class="FieldInput" style="width: 20%"><label
								name="idCard" field="idCard" /><font color="red">*</font></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 15%">人口数量:</td>
							<td class="FieldInput" style="width: 20%"><label
								name="popNum" field="popNum" /><font color="red">*</font></td>
							<td class="FieldLabel" style="width: 15%">户籍行政区划:</td>
							<td class="FieldInput" style="width: 20%"><label
								name="domicileCode" field="domicileCode" /><font color="red">*</font></td>
							<td class="FieldLabel" style="width: 15%">属地行政区划:</td>
							<td class="FieldInput" style="width: 20%"><label
								name="apanageCode" field="apanageCode" /><font color="red">*</font></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 10%">家庭住址:</td>
							<td class="FieldInput" style="width: 20%" colspan="5"><label
								name="familyAdd" field="familyAdd" /></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 10%">宅电:</td>
							<td class="FieldInput" style="width: 20%"><label
								name="telFamily" field="telFamily" /></td>
							<td class="FieldLabel" style="width: 10%">手机:</td>
							<td class="FieldInput" style="width: 20%"><label
								name="telMobile" field="telMobile" /></td>
							<td class="FieldLabel" style="width: 10%">其他:</td>
							<td class="FieldInput" style="width: 20%"><label
								name="telOther" field="telOther" /></td>
						</tr>
					</table>
					</form>
				</next:Html>
			</next:Panel>
			
				<next:GridPanel id="peoEditGridPanel" name="sammedicalbalanceGrid"
					width="100%" stripeRows="true" height="250"
					dataset="BaseinfoPeopleDataSet1">
					<next:TopBar>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem id="inHosRegButton"  iconCls="add"
							text="入院登记" handler="inHosReg" />
						<next:ToolBarItem iconCls="return" text="返回" handler="back" />
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn width="15" />
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column id="peopleId" header="人员姓名" field="name" width="90">
							<next:TextField allowBlank="false" />
						</next:Column>
						<next:Column id="peopleId" header="性别" field="sex" width="90">
							<next:ComboBox dataset="SexDataset" displayField="text"
								valueField="value" typeAhead="true" />
						</next:Column>
						<next:Column id="peopleId" header="与户主关系" field="relationshipType"
							width="90">
							<next:TextField allowBlank="false" />
						</next:Column>
						<next:Column id="peopleId" header="出生日期" field="birthday"
							width="90">
							<next:TextField allowBlank="false" />
						</next:Column>
						<next:Column id="peopleId" header="身份证号" field="idCard" width="90">
							<next:TextField allowBlank="false" />
						</next:Column>
						<next:Column header="工作单位" field="workUnitName" width="100"
							sortable="true">
							<next:TextField allowBlank="false" />
						</next:Column>
						<next:Column id="insuranceType" header="保险险种" field="medicalCode"
							width="90">
							<next:ComboBox dataset="SafeguardDataset" displayField="text"
								valueField="value" typeAhead="true" />
						</next:Column>
						<next:Column id="assitanceType" header="医疗救助类型"
							field="assitanceType" width="90">
							<next:ComboBox dataset="assitanceTypeDataset" displayField="text"
								valueField="value" typeAhead="true" />
						</next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="hosDataset" />
					</next:BottomBar>
				</next:GridPanel>
			</next:Panel>
			<next:Panel title="历史救助信息" width="100%">
				<next:GridPanel id="editGridPanel" name="sammedicalbalanceGrid"
					width="100%" stripeRows="true" height="250" dataset="hosDataset">
					<next:Columns>
						<next:RowNumberColumn width="15" />
						<next:Column id="peopleId" header="人员姓名" field="NAME" width="90">
							<next:TextField allowBlank="false" />
						</next:Column>
						<next:Column id="peopleId" header="身份证号" field="ID_CARD"
							width="90">
							<next:TextField allowBlank="false" />
						</next:Column>
						<next:Column header="病种" field="DISEASE" width="100"
							sortable="true">
							<next:ComboBox dataset="diseaseDataset" displayField="text"
								valueField="value" typeAhead="true" />
						</next:Column>
						<next:Column id="insuranceType" header="保险险种"
							field="INSURANCE_TYPE" width="90">
							<next:ComboBox dataset="SafeguardDataset" displayField="text"
								valueField="value" typeAhead="true" />
						</next:Column>
						<next:Column id="assitanceType" header="医疗救助类型"
							field="ASSITANCE_TYPE" width="90">
							<next:ComboBox dataset="assitanceTypeDataset" displayField="text"
								valueField="value" typeAhead="true" />
						</next:Column>

						<next:Column id="TOTAL_EXPENSE" header="住院总费用"
							field="TOTAL_EXPENSE" width="90">
							<next:TextField />
						</next:Column>

						<next:Column id="INSURANCE_EXPENSE" header="保内费用"
							field="INSURANCE_EXPENSE" width="90">
							<next:TextField />
						</next:Column>

						<next:Column id="INSURANCE_PAY" header="保险机构支付费用"
							field="INSURANCE_PAY" width="90">
							<next:TextField />
						</next:Column>

						<next:Column id="ASSITANCE_PAY" header="医疗救助费用"
							field="ASSITANCE_PAY" width="90">
							<next:TextField />
						</next:Column>

						<next:Column id="PERSONAL_PAY" header="个人支付费用"
							field="PERSONAL_PAY" width="90">
							<next:TextField />
						</next:Column>

					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="hosDataset" />
					</next:BottomBar>
				</next:GridPanel>
			</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>
<!-- 入院登记事项窗口 -->
<next:Window id="inRegiste" height="200" width="550">
	<next:Panel title="一站结算住院登记">
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="save" text="保存" handler="save" />
			<next:ToolBarItem iconCls="undo" text="取消" handler="undoReg" />
		</next:TopBar>
		<next:Html>
			<form id="editForm" dataset="ds" onsubmit="return false"
				style="padding: 5px;" class="L5form">
			<table border="1" width="100%">
				<tr>
					<td width="100" class="FieldLabel">住院号</td>
					<td class="FieldInput"><input type="text"
						name="hospitalRecordId" field="hospitalRecordId" /><font
						color="red">*</font></td>
					<td width="100" class="FieldLabel">病种</td>
					<td class="FieldInput"><select name="insuranceType"
						field="disease">
						<option dataset="diseaseDataset"></option>
					</select> <font color="red">*</font></td>
				</tr>
				<tr>
					<td width="100" class="FieldLabel">医疗救助类型</td>
					<td class="FieldInput"><select name="assitanceType"
						field="assitanceType">
						<option dataset="assitanceTypeDataset"></option>
					</select> <font color="red">*</font></td>
					<td width="100" class="FieldLabel">保险险种</td>
					<td class="FieldInput"><select name="insuranceType"
						field="insuranceType">
						<option dataset="SafeguardDataset"></option>
					</select> <font color="red">*</font></td>


				</tr>
				<tr>
					<td width="100" class="FieldLabel">证书类型</td>
					<td class="FieldInput"><select id="cardType" name="cardType"
						field="cardType">
						<option dataset="cardTypeDataset"></option>
					</select><font color="red">*</font></td>

					<td width="100" class="FieldLabel">证书编号</td>
					<td class="FieldInput"><input type="text" name="cardNo"
						field="cardNo" /><font color="red">*</font></td>
				</tr>
				<tr>
					<td width="100" class="FieldLabel">入住科室</td>
					<td class="FieldInput"><input type="text" name="" field="" /></td>
					<td width="100" class="FieldLabel">入院日期</td>
					<td class="FieldInput"><input type="text" name="beginTime"
						id="inTime" field="inTime" format="Y-m-d"
						onclick="LoushangDate(this)"><font color="red">*</font></td>
				</tr>
				<input type="hidden" name="balanceId" id="balanceId"
					value="<%=IdHelp.getUUID30() %>" title="住院流水ID">
				<input type="hidden" name="familyId" id="familyId"
					value="<%=request.getParameter("familyId")%>" title="家庭ID">
				<input type="hidden" name="peopleId" id="peopleId"
					value="<%=request.getParameter("peopleId")%>" title="人员ID">
				<input type="hidden" name="hospitalId" id="hospitalId"
					value="<%=BspUtil.getCorpOrganId() %>" title="医院ID">
			</table>
			</form>
		</next:Html>
	</next:Panel>
</next:Window>
</body>
</html>
