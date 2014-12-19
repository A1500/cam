<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>遗属人员信息查看</title>
<next:ScriptManager />
		<script>
			var peopleId='<%=request.getParameter("peopleId")%>';
		</script>
<script type="text/javascript" src="dependantTypeDetail.js"></script>
</head>
<body>
<model:datasets>
	
	<!-- 遗属信息 -->
	<model:dataset id="DependantDataset" cmd="com.inspur.cams.bpt.manage.cmd.BptPeopleDependantQueryCommand" method="queryDependantInfo" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptPeopleDependant">
			<model:field name="dependantStateCode" type="string" rule="require"/>
			<model:field name="dependantNo" type="string" rule="require"/>
			<model:field name="handicapFlag" type="string" rule="require"/>
			<model:field name="dependantTypeCode" type="string" rule="require"/>
			<model:field name="oldLonelyFlag" type="string" rule="require"/>
			<model:field name="orphanFlag" type="string" rule="require"/>
			<model:field name="workAbilityCode" type="string" rule="require"/>
			<model:field name="workAbilityDescribe" type="string" />
			<model:field name="viabilityCode" type="string" rule="require"/>
			<model:field name="supportPattern" type="string" rule="require"/>
			<model:field name="jobStatusDescribe" type="string" />
			<model:field name="bank" type="string"/>
			<model:field name="accountName" type="string"/>
			<model:field name="accountCode" type="string" rule="number"/>
		</model:record>
	</model:dataset>
	
	<!-- 优抚对象状态 -->
	<model:dataset id="ObjectStateDataset" enumName="OBJECT.STATE" autoLoad="true" global="true"></model:dataset>
	
	<!-- 三属类别 -->
	<model:dataset id="DependantTypeDataset" enumName="DEPENDANT.CODE" autoLoad="true" global="true"></model:dataset>
	
	<!-- 与牺牲病故军人关系 -->
	<model:dataset id="RelationTypeEnum" enumName="RELATION.TYPE" autoLoad="true" global="true"></model:dataset>
	
	<!-- 开户银行代码 -->
	<model:dataset id="BankEnum" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BANK'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	
	<!-- 是否残疾 -->
	<model:dataset id="HandicapFlagEnum" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	
	<!-- 是否正在上学 -->
	<model:dataset id="StudnetFlagEnum" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	
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
	
	<!-- 性别 -->
	<model:dataset id="SexDataset" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
	
</model:datasets>

			<next:Panel width="100%" height="100%" autoScroll="true">
				
				
				<next:Html>
					<form id="editForm" dataset="DependantDataset"
						onsubmit="return false" style="padding: 5px;" class="L5form">
					<table border="1" width="98%">
						<tr>
							<td class="FieldLabel" nowrap style="width:15%">优抚对象类别：</td>
							<td class="FieldInput" style="width:15%"><label name="dependantTypeCode" field="dependantTypeCode" dataset="DependantTypeDataset"></label></td>
							
							<td class="FieldLabel" nowrap style="width:15%">与牺牲病故军人关系：</td>
							<td class="FieldInput" style="width:15%"><label name="relationship" field="relationship" dataset="RelationTypeEnum"/></td>
							
							<td class="FieldLabel" nowrap style="width:15%">优抚对象状态：</td>
							<td class="FieldInput" style="width:15%"><label name="dependantStateCode" field="dependantStateCode" dataset="ObjectStateDataset"></label></td>
							
						</tr>
						
						<tr>	
							<td class="FieldLabel" nowrap>定期抚恤证编号：</td>
							<td class="FieldInput"><label name="dependantNo" field="dependantNo"/></td>
						
							<td class="FieldLabel" >批准日期：</td>
							<td class="FieldInput" ><label name="approvalDate" field="approvalDate"></td>
						
							<td class="FieldLabel" nowrap>是否正在上学：</td>
							<td class="FieldInput"><label name="studentFlag" field="studentFlag" dataset="StudnetFlagEnum"></label></td>
						</tr>
						<tr>
							<td class="FieldLabel">是否残疾：</td>
							<td class="FieldInput"><label name="handicapFlag" field="handicapFlag" dataset="HandicapFlagEnum"></label></td>
							
							<td class="FieldLabel" >是否孤老：</td>
							<td class="FieldInput"><label name="oldLonelyFlag" field="oldLonelyFlag" dataset="OldLonelyFlagEnum"></label></td>
						
							<td class="FieldLabel">是否孤儿：</td>
							<td class="FieldInput"><label name="orphanFlag" field="orphanFlag" dataset="OrphanFlagEnum"></label></td>
						
						</tr>
						
						<tr>
							<td class="FieldLabel">劳动能力：</td>
							<td class="FieldInput"><label name="workAbilityCode" field="workAbilityCode" dataset="WorkAbilityCodeEnum"></label></td>
						
							<td class="FieldLabel">生活能力：</td>
							<td class="FieldInput"><label name="viabilityCode" field="viabilityCode" dataset="ViabilityCodeEnum"></label></td>
							
							<td class="FieldLabel">供养方式：</td>
							<td class="FieldInput" nowrap="nowrap"><label name="supportPattern" field="supportPattern" dataset="SupportPatternEnum"></label></td>
						</tr>
						<tr>
							<td class="FieldLabel" >是否持证人：</td>
							<td class="FieldInput"><label name="holderFlag" field="holderFlag" dataset="HolderFlagEnum"></label></td>
						
							<td class="FieldLabel" nowrap="nowrap">烈士（牺牲，病故军人）证书字号：</td>
							<td class="FieldInput"><label name="lezswCertificateId" field="lezswCertificateId"/></td>
						
							<td class="FieldLabel" nowrap="nowrap">烈士（牺牲、病故军人）姓名：</td>
							<td class="FieldInput"><label name="lezswName" field="lezswName"/></td>
						</tr>
						
						<tr>
							<td class="FieldLabel">性别：</td>
							<td class="FieldInput"><label name="lezswSex" field="lezswSex" dataset="SexDataset"></label></td>
						
							<td class="FieldLabel">出生日期：</td>
							<td class="FieldInput"><label name="lezswBirthday" field="lezswBirthday"/></td>

							<td class="FieldLabel">入伍（工作）时间：</td>
							<td class="FieldInput"><label name="conscriptDate" field="conscriptDate"/></td>
						</tr>
						
						<tr>
							<td class="FieldLabel" >生前所在单位：</td>
							<td class="FieldInput"><label name="workUnit" field="workUnit" /></td>
						
							<td class="FieldLabel">生前职务：</td>
							<td class="FieldInput"><label name="position" field="position" /></td>
						 
							<td class="FieldLabel" >牺牲病故时间：</td>
							<td class="FieldInput"><label name="deathDate" field="deathDate"/>
							</td>
						</tr>
						
						<tr>
							<td class="FieldLabel">牺牲病故地点：</td>
							<td class="FieldInput"><label name="deathAddress" field="deathAddress"/></td>
						
							<td class="FieldLabel"nowrap="nowrap">烈士（牺牲、病故军人）批准时间：</td>
							<td class="FieldInput" colspan="3"><label name="lezswApproveDate" field="lezswApproveDate"/></td>
						</tr>
						
						<tr>
							<td class="FieldLabel">牺牲病故原因：</td>
							<td class="FieldInput" colspan="5"><label name="deathReason" field="deathReason"></label></td>
						</tr>
						
						<tr>
							<td  class="FieldLabel">开户银行：</td>
							<td class="FieldInput"><label name="bank" field="bank" dataset="BankEnum"></label></td>
				
							<td  class="FieldLabel" >开户名称：</td>
							<td class="FieldInput"><label name="accountName" field="accountName"/></td>
 
 							<td  class="FieldLabel" >银行账号：</td>
							<td class="FieldInput" ><label name="accountCode" field="accountCode"></label></td>
						</tr>
						
						<tr>
							<td class="FieldLabel">备注：</td>
							<td class="FieldInput" colspan="5"><label name="note" field="note"></label></td>
						</tr>
					</table>
					</form>
				</next:Html>
			</next:Panel>

</body>
</html>
