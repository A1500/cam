<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>遗属人员明细查看</title>
<next:ScriptManager />
		<script>
			var peopleId = <%=request.getParameter("peopleId")%> ;
		</script>
<script type="text/javascript" src="dependantDetail.js"></script>
</head>
<body>
<model:datasets>
	<!-- 遗属信息 -->
	<model:dataset id="DependantDataset"
		cmd="com.inspur.cams.bpt.manage.cmd.BptPeopleDependantQueryCommand" method="queryDependantInfo"
		global="true">
		<model:record
			fromBean="com.inspur.cams.bpt.base.data.BptPeopleDependant">
			<model:field name="insanityFlag" type="string" />
			<model:field name="oldLonelyFlag" type="string" />
			<model:field name="orphanFlag" type="string" />
			<model:field name="workAbilityCode" type="string" />
			<model:field name="workAbilityDescribe" type="string" />
			<model:field name="viabilityCode" type="string" />
			<model:field name="supportPattern" type="string" />
			<model:field name="jobStatusDescribe" type="string" />
			<model:field name="bank" type="string"/>
			<model:field name="accountName" type="string"/>
			<model:field name="accountCode" type="string"/>
		</model:record>
	</model:dataset>
	<!-- 开户银行代码 -->
	<model:dataset id="BankEnum" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BANK'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 是否精神病标志 -->
	<model:dataset id="InsanityFlagEnum" enumName="COMM.YESORNO"
		autoLoad="true" global="true"></model:dataset>
	<!-- 孤老标志 -->
	<model:dataset id="OldLonelyFlagEnum" enumName="COMM.YESORNO"
		autoLoad="true" global="true"></model:dataset>
	<!-- 孤儿标志 -->
	<model:dataset id="OrphanFlagEnum" enumName="COMM.YESORNO"
		autoLoad="true" global="true"></model:dataset>
	<!-- 劳动能力代码 -->
	<model:dataset id="WorkAbilityCodeEnum" enumName="WORK.ABILITY.CODE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 优抚生活能力代码 -->
	<model:dataset id="ViabilityCodeEnum" enumName="VIABILITY.CODE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 优抚供养方式 -->
	<model:dataset id="SupportPatternEnum" enumName="SUPPORT.PATTERN"
		autoLoad="true" global="true"></model:dataset>
	<!-- 烈属类别代码 -->
	<model:dataset id="DependantTypeCodeEnum"
		enumName="DEPENDANT.TYPE.CODE" autoLoad="true" global="true"></model:dataset>
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
</model:datasets>

			<next:Panel title="遗属相关信息" autoHeight="true" autoWidth="true" >
				<next:Html>
					<form id="editForm" dataset="DependantDataset"
						onsubmit="return false" style="padding: 5px;" class="L5form">
					<table border="1" width="90%">
						<tr>
							<td class="FieldLabel" nowrap colspan="2">优抚对象类别代码：</td>
							<td class="FieldInput"><label name="objectTypeCode" field="objectTypeCode" dataset="DependantTypeCodeEnum"></label></td>
							
							<td class="FieldLabel" nowrap>烈属与烈士关系：</td>
							<td class="FieldInput"><label type="text" name="relationship" field="relationship"/>
							</td>
						</tr>
						
						<tr>
							<td class="FieldLabel" colspan="2" style="width: 25%">是否精神病：</td>
							<td class="FieldInput" style="width: 25%"><label name="insanityFlag" field="insanityFlag" dataset="InsanityFlagEnum"></label></td>
							
							<td class="FieldLabel" style="width: 20%">优抚供养方式：</td>
							<td class="FieldInput" style="width: 30%"><label name="supportPattern" field="supportPattern" dataset="SupportPatternEnum"></label></td>
						</tr>
						
						<tr>
							<td class="FieldLabel" colspan="2">孤老标志：</td>
							<td class="FieldInput"><label name="oldLonelyFlag" field="oldLonelyFlag" dataset="OldLonelyFlagEnum"></label></td>
							
							<td class="FieldLabel">孤儿标志：</td>
							<td class="FieldInput"><label name="orphanFlag" field="orphanFlag" dataset="OrphanFlagEnum"></label></td>
						</tr>
						
						<tr>
							<td class="FieldLabel" colspan="2">劳动能力：</td>
							<td class="FieldInput"><label name="workAbilityCode" field="workAbilityCode" dataset="WorkAbilityCodeEnum"></label></td>

							<td class="FieldLabel">优抚生活能力：</td>
							<td class="FieldInput"><label name="viabilityCode" field="viabilityCode" dataset="ViabilityCodeEnum"></label></td>
						</tr>
						
						<tr>
							<td class="FieldLabel" colspan="2">劳动能力描述：</td>
							<td class="FieldInput" colspan="3"><label rows="2"
								cols="122%" name="workAbilityDescribe"
								field="workAbilityDescribe"></label></td>	
						</tr>

						<tr>
							<td class="FieldLabel" colspan="2">就业情况描述：</td>
							<td class="FieldInput" colspan="3"><label rows="2"
								cols="122%" name="jobStatusDescribe" field="jobStatusDescribe"></label></td>
						</tr>
						<tr>
							<td class="FieldLabel" colspan="2">烈士姓名：</td>
							<td class="FieldInput"><label type="text" name="lezswName"
								field="lezswName" /></td>

							<td class="FieldLabel">烈士性别：</td>
							<td class="FieldInput"><label name="lezswSex" field="lezswSex" dataset="SexDataset"></label></td>
						</tr>
						
						<tr>
							<td class="FieldLabel" colspan="2">出生日期：</td>
							<td class="FieldInput"><label  name="lezswBirthday" field="lezswBirthday" /></td>

							<td class="FieldLabel">烈士入伍时间：</td>
							<td class="FieldInput"><label name="conscriptDate" field="conscriptDate" /></td>
						</tr>
						
						<tr>
							<td class="FieldLabel" colspan="2">烈士生前所在单位：</td>
							<td class="FieldInput"><label name="workUnit" field="workUnit" /></td>

							<td class="FieldLabel">烈士职务：</td>
							<td class="FieldInput"><label name="position" field="position" /></td>
						</tr>
						
						<tr>
							<td class="FieldLabel" colspan="2">烈士牺牲病故时间：</td>
							<td class="FieldInput"><label name="deathDate" field="deathDate"/>
							</td>

							<td class="FieldLabel">烈士牺牲病故地点：</td>
							<td class="FieldInput"><label name="deathAddress" field="deathAddress" /></td>
						</tr>
						<tr>
							<td class="FieldLabel" colspan="2">烈士牺牲病故原因：</td>
							<td class="FieldInput" colspan="3"><label name="deathReason" field="deathReason" cols="122%" rows="3"></label>
							</td>
						</tr>
						
						<tr>
							<td class="FieldLabel" colspan="2">烈士批准时间：</td>
							<td class="FieldInput"><label name="lezswApproveDate" field="lezswApproveDate" /></td>
							
							<td class="FieldLabel">烈士证书字号：</td>
							<td class="FieldInput"><label name="lezswCertificateId" field="lezswCertificateId" /></td>
						</tr>
						
						<tr>
							<td  class="FieldLabel" colspan="2">开户银行：</td>
							<td class="FieldInput"><label name="bank" field="bank" dataset="BankEnum"></label></td>
				
							<td  class="FieldLabel" >开户名称：</td>
							<td class="FieldInput"><label name="accountName" field="accountName" /> </td>
						</tr>
			
						<tr>
							<td  class="FieldLabel" colspan="2">银行账号：</td>
							<td class="FieldInput" colspan="3"><label name="accountCode" field="accountCode" style="width:500" ></label></td>
						</tr>
						
						<tr>
							<td class="FieldLabel" colspan="2">批准日期：</td>
							<td class="FieldInput"><label name="approvalDate" field="approvalDate" /></td>
							
							<td class="FieldLabel">注销日期：</td>
							<td class="FieldInput"><label name="cancellationDate" field="cancellationDate" /></td>
						</tr>

						<tr>
							<td class="FieldLabel" colspan="2">备注：</td>
							<td class="FieldInput" colspan="3"><label name="note"
								field="note" cols="122%" rows="3"></label></td>
						</tr>

						<tr>
							<td class="FieldLabel" rowspan="2" nowrap>初审（村居）</td>
							<td class="FieldLabel">初审人：</td>
							
							<td class="FieldInput"><label name="checkIncharge" field="checkIncharge" /></td>
							<td class="FieldLabel">初审时间：</td>
							<td class="FieldInput"><label name="checkApproveDate" field="checkApproveDate" /></td>
						</tr>
						
						<tr>
							<td class="FieldLabel">初审意见：</td>
							<td class="FieldInput" colspan="3"><label name="checkAdvice" field="checkAdvice" cols="122%" rows="3"></label></td>
						</tr>

						<tr>
							<td class="FieldLabel" rowspan="2" nowrap>复核（乡镇）</td>
							<td class="FieldLabel">复核人：</td>
							<td class="FieldInput"><label name="aduitIncharge" field="aduitIncharge" /></td>
							
							<td class="FieldLabel">复核时间：</td>
							<td class="FieldInput"><label name="aduitApproveDate" field="aduitApproveDate" /></td>
						</tr>
						
						<tr>
							<td class="FieldLabel">复核意见：</td>
							<td class="FieldInput" colspan="3"><label
								name="aduitAdvice" field="aduitAdvice" cols="122%" rows="3"></label></td>
						</tr>
						
						<tr>
							<td class="FieldLabel" rowspan="2" nowrap>审批意见（县）</td>
							<td class="FieldLabel">审批人：</td>
							<td class="FieldInput"><label name="verifyIncharge" field="verifyIncharge" /></td>
							
							<td class="FieldLabel">审批时间：</td>
							<td class="FieldInput"><label name="verifyApproveDate" field="verifyApproveDate" /></td>
						</tr>
						
						<tr>
							<td class="FieldLabel">审批意见：</td>
							<td class="FieldInput" colspan="3"><label
								name="verifyAdvice" field="verifyAdvice" cols="122%" rows="3"></label>
							</td>
						</tr>
					</table>
					</form>
				</next:Html>
			</next:Panel>
</body>
</html>
