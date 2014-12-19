<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>查看外省参试人员迁入我省信息</title>
<next:ScriptManager />
		<script>
			var applyId='<%=request.getParameter("applyId")%>';
			var peopleId ='<%=request.getParameter("peopleId")%>';
		</script>
</head>
<body>
<model:datasets>
	
	<!-- 部分烈士（错杀被平反人员）子女信息 -->  
	<model:dataset id="MartyrOffspringDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptPeopleMartyrOffspringQueryCommand" method="getMartyrOffsprinInforUpdate" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptPeopleMartyrOffspring">
			<model:field name="oldLonelyFlag" type="string" rule="require"/>
			<model:field name="orphanFlag" type="string" rule="require"/>
			<model:field name="workAbilityCode" type="string" rule="require"/>
			<model:field name="viabilityCode" type="string" rule="require"/>
			<model:field name="supportPattern" type="string" rule="require"/>
			<model:field name="bank" type="string" />
			<model:field name="accountName" type="string"/>
			<model:field name="accountCode" type="string"/> 
			<model:field name="ingoingAddress" type="string" rule="require"/>
			<model:field name="ingoingReason" type="string" rule="require"/>
			<model:field name="allowanceMonth" type="string" rule="require"/>
			<model:field name="ingoingCode" type="string" />
			<model:field name="applyId" type="string"/>
		</model:record>
	</model:dataset>
	<!-- 与牺牲者关系 -->
	<model:dataset id="RelationShipEnum" enumName="RELATION.SHIP" autoLoad="true" global="true"></model:dataset>
    <!-- 开户银行代码 -->
	<model:dataset id="BankEnum" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BANK'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
    <!-- 是否持证人 -->
	<model:dataset id="HolderFlagEnum" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
    <!-- 孤老标志 -->
	<model:dataset id="OldLonelyFlagEnum" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
    <!-- 孤儿标志 -->
	<model:dataset id="OrphanFlagEnum" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
    <!-- 劳动能力代码 -->
	<model:dataset id="WorkAbilityCodeEnum" enumName="WORK.ABILITY.CODE" autoLoad="true" global="true"></model:dataset>
    <!-- 优抚生活能力代码 -->   
	<model:dataset id="ViabilityCodeEnum" enumName="VIABILITY.CODE" autoLoad="true" global="true"></model:dataset>
    <!-- 优抚供养方式 --> 
	<model:dataset id="SupportPatternEnum" enumName="SUPPORT.PATTERN" autoLoad="true" global="true"></model:dataset>
	<!-- 生活状况-->
    <model:dataset id="lifeStateEnum" enumName="LIFE.LIFE_STATE_CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 身份类别 -->
	<model:dataset id="StatusTypeEnum" enumName="STATUS.TYPE" autoLoad="true" global="true"></model:dataset>
</model:datasets>

			<next:Panel width="100%" height="100%" autoHeight="true" autoScroll="true">
				<next:Html>
					<form id="editForm" dataset="MartyrOffspringDataSet"
						onsubmit="return false" style="padding: 5px;" class="L5form">
					<table border="1" width="98%">
						<tr>
							<td class="FieldLabel" nowrap="nowrap" style="width: 16%">身份类别：</td>
								<td class="FieldInput" ><label id="statusType" name="statusType"
									field="statusType" title="身份类别" dataset="StatusTypeEnum"></label></td>
							<td class="FieldLabel" style="width: 16%">牺牲者姓名：</td>
							<td class="FieldInput" style="width: 16%"><label id="lezswName" name="lezswName" field="lezswName" title="牺牲者姓名" /></td>
							<td class="FieldLabel" style="width: 16%">牺牲时间：</td>
							<td class="FieldInput" style="width: 16%"><label id="sacrificeDate" name="sacrificeDate" field="sacrificeDate"/></td>
						</tr>
						<tr>
							<td class="FieldLabel">批准烈士（平反）时间：</td>
							<td class="FieldInput"><label id="lezswApproveDate" name="lezswApproveDate" field="lezswApproveDate" title="批准烈士（平反）时间"/></td>
							<td class="FieldLabel" nowrap>与牺牲者关系：</td>
							<td class="FieldInput"><label id="relationship" name="relationship" field="relationship" title="与牺牲者关系" dataset="RelationShipEnum" /></td>
							<td class="FieldLabel">是否持证人：</td>
							<td class="FieldInput"><label id="holderFlag" name="holderFlag" field="holderFlag" title="是否持证人" dataset="HolderFlagEnum" /></td>
						</tr>
						<tr>	
							<td class="FieldLabel">是否孤老：</td>
							<td class="FieldInput"><label id="oldLonelyFlag" name="oldLonelyFlag"
								field="oldLonelyFlag" title="是否孤老" dataset="OldLonelyFlagEnum" /></td>
							<td class="FieldLabel">是否孤儿：</td>
							<td class="FieldInput"><label id="orphanFlag" name="orphanFlag"
								field="orphanFlag" title="是否孤儿" dataset="OrphanFlagEnum" /></td>
							<td class="FieldLabel" nowrap>生活状况：</td>
							<td class="FieldInput"><label id="lifeStateCode" name="lifeStateCode" field="lifeStateCode" title="生活状况" dataset="lifeStateEnum" /></td>
						</tr>
						<tr>
							<td class="FieldLabel">劳动能力：</td>
							<td class="FieldInput"><label id="workAbilityCode" name="workAbilityCode"
								field="workAbilityCode" title="劳动能力" dataset="WorkAbilityCodeEnum" /></td>
							<td class="FieldLabel">生活能力：</td>
							<td class="FieldInput"><label id="viabilityCode" name="viabilityCode"
								field="viabilityCode" title="生活能力" dataset="ViabilityCodeEnum" /></td>

							<td class="FieldLabel">供养方式：</td>
							<td class="FieldInput"><label name="supportPattern"
								field="supportPattern" title="供养方式" dataset="SupportPatternEnum" /></td>
						</tr>
						<tr>
							<td  class="FieldLabel" nowrap>享受低保待遇：</td>
							<td class="FieldInput">
				     			<label id="guarantFlag" name="guarantFlag" field="guarantFlag" title="享受低保待遇" dataset="HolderFlagEnum" />
							</td>
							<td  class="FieldLabel" nowrap>享受五保待遇：</td>
							<td class="FieldInput">
				     			<label id="fiveGuarantFlag" name="fiveGuarantFlag" field="fiveGuarantFlag" title="享受五保待遇" dataset="HolderFlagEnum" />
							</td>
							<td  class="FieldLabel" nowrap>享受过抚恤金：</td>
							<td class="FieldInput">
				     			<label id="enjoyedTreatFlag" name="enjoyedTreatFlag" field="enjoyedTreatFlag" title="享受过抚恤金" dataset="HolderFlagEnum" />
							</td>
						</tr>
						<tr>
							<td class="FieldLabel">开户银行：</td>
							<td class="FieldInput">
							    <label name="bank" field="bank" title="开户银行" dataset="BankEnum" /> </td>
							<td class="FieldLabel">开户名称：</td>
							<td class="FieldInput"><label name="accountName" field="accountName" title="开户名称" /></td>

							<td class="FieldLabel">银行账号：</td>
							<td class="FieldInput"><label name="accountCode" field="accountCode" title="银行账号"></label></td>
						</tr>
						<tr>
							<td class="FieldLabel">由何地迁入</td>
							<td class="FieldInput"><label name="ingoingAddress" onclick="getCodeAndName()" readonly="readonly" field="ingoingAddress" title="由何地迁入"/></td>
							<td class="FieldLabel">抚恤金已发至月份</td>
							<td class="FieldInput" colspan="3"><label name="allowanceMonth" field="allowanceMonth" title="抚恤金已发至月份"  readonly="readonly" format="Y-12" style="width: 100px;" maxlength="10"/></td>
						</tr>
						
						<tr>
							<td class="FieldLabel">迁入原因</td>
							<td class="FieldInput" colspan="5"><label rows="2" name="ingoingReason" field="ingoingReason" style="width:90%" title="迁入原因"/></td>
						</tr>
						<tr>
							<td class="FieldLabel" nowrap>备注(类别信息)：</td>
							<td class="FieldInput" colspan="5"><label  
								name="note" field="note" title="备注(类别信息)" /></td>
						</tr>
					</table>
					</form>
				</next:Html>
			</next:Panel>

</body>
<script type="text/javascript">
	function init() {
	var MartyrOffspringDataSet = L5.DatasetMgr.lookup("MartyrOffspringDataSet");
	MartyrOffspringDataSet.setParameter("applyId",applyId);
	MartyrOffspringDataSet.setParameter("peopleId",peopleId);
	MartyrOffspringDataSet.load();
	L5.QuickTips.init(); 
}
	
</script>
</html>
