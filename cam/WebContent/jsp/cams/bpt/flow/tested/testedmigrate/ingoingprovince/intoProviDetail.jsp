<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>查看外省参试人员迁入我省信息</title>
<next:ScriptManager />
		<script>
			var applyId='<%=request.getParameter("applyId")%>';
		</script>
</head>
<body>
<model:datasets>
	
	<!-- 参试信息 -->
	<model:dataset id="TestedDataset" cmd="com.inspur.cams.bpt.manage.cmd.BptApplyIntoprovinceQueryCommand" method="queryTestedIntoProvince" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptPeopleTested">
			<model:field name="insanityFlag" type="string" rule="require"/>
			<model:field name="oldLonelyFlag" type="string" rule="require"/>
			<model:field name="workAbilityCode" type="string" rule="require"/>
			<model:field name="workAbilityDescribe" type="string" />
			<model:field name="viabilityCode" type="string" rule="require"/>
			<model:field name="supportPattern" type="string" rule="require"/>
			<model:field name="jobStatusDescribe" type="string" />
			<model:field name="bank" type="string" rule="require"/>
			<model:field name="accountName" type="string" rule="require"/>
			<model:field name="accountCode" type="string" rule="number"/>
			<model:field name="warStateCode" type="string" rule="require"/>
			<model:field name="warNo" type="string"/>
			
			<!-- 外省参试人员抚恤关系迁入我省审批表字段 -->
			<model:field name="ingoingAddress" type="string" rule="require"/>
			<model:field name="ingoingReason" type="string" rule="require"/>
			<model:field name="oldPaperNo" type="string" rule="require"/>	
			<model:field name="allowanceMonth" type="string" rule="require"/>
			<model:field name="serviceType" type="string"/>
		</model:record>
	</model:dataset>
	
	<!-- 伤残等级 -->
	<model:dataset id="DisabilityLevelDataset" enumName="LEVEL.CODE" autoLoad="true" global="true"></model:dataset>
	
	<!-- 健康状况 -->
	<model:dataset id="dsHealth"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_HEALTH'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	
	<!-- 优抚对象状态 -->
	<model:dataset id="ObjectStateDataset" enumName="OBJECT.STATE"
		autoLoad="true" global="true"></model:dataset>
	<!--生活状况代码-->
	<model:dataset id="dsLife" enumName="LIFE.LIFE_STATE_CODE"
		autoLoad="true"></model:dataset>
	<!--参试类别代码-->
	<model:dataset id="dsTest" enumName="TESTED.TYPE" autoLoad="true"></model:dataset>
	<!--是否参加职业健康-->
	<model:dataset id="dsHestth" enumName="COMM.YESORNO" autoLoad="true"></model:dataset>
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
	<!-- 优抚供养方式 -->
	<model:dataset id="SupportPatternEnum" enumName="SUPPORT.PATTERN"
		autoLoad="true" global="true"></model:dataset>
	<!-- 孤老标志 -->
	<model:dataset id="OldLonelyFlagEnum" enumName="COMM.YESORNO"
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
		enumName="DEPENDANT.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 就业状况 -->
	<model:dataset id="EmploymentCodeDataset" enumName="EMPLOYMENT.CODE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 工作单位性质 -->
	<model:dataset id="WorkUnitCharacterDataset"
		enumName="WORKUNIT.CHARACTER" autoLoad="true" global="true"></model:dataset>
</model:datasets>

			<next:Panel width="100%" height="100%" autoHeight="true" autoScroll="true">
				<next:Html>
					<form id="editForm" dataset="TestedDataset"
						onsubmit="return false" style="padding: 5px;" class="L5form">
					<table border="1" width="98%">
						<tr>
						<!-- 	<td class="FieldLabel" nowrap>优抚对象状态：</td>
							<td class="FieldInput"><label name="warStateCode"
								field="warStateCode" title="优抚对象状态" dataset="ObjectStateDataset">
							</td>
					-->
							
							<!--  <td class="FieldLabel" nowrap>批准日期：</td>
							<td class="FieldInput"><label  
								name="approvalDate" field="approvalDate" format="Y-m-d"
								 title="批准日期"/></td>
								 -->
						</tr>
						<tr>
							<td class="FieldLabel" nowrap>入伍(参加工作)时间：</td>
							<td class="FieldInput"><label 
								name="conscriptcDate" title="入伍时间" field="conscriptcDate"
								format="Y-m-d" />
							</td>
							<td class="FieldLabel" nowrap>退伍时间：</td>
							<td class="FieldInput"><label  
								name="decruitmentDate" title="退伍时间" field="decruitmentDate"
								format="Y-m-d" ></td>

							<td class="FieldLabel" nowrap>离退休时间：</td>
							<td class="FieldInput"><label   name="retiredDate"
								title="离退休时间" field="retiredDate" format="Y-m-d"
								 /></td>
						</tr>
						<tr>
							<td class="FieldLabel" nowrap>退伍证号：</td>
							<td class="FieldInput"><label   name="asdpNo"
								title="退伍证号" field="asdpNo" /></td>


							<td class="FieldLabel" nowrap>原部队代号：</td>
							<td class="FieldInput"><label   name="forcesNo"
								field="forcesNo" title="原部队代号" />
							</td>
						
							<td class="FieldLabel" nowrap>职务（级别）：</td>
							<td class="FieldInput"><label   name="position"
								field="position" title="职务（级别）" /> </td>
						</tr>
						<tr>
							<td class="FieldLabel" nowrap>参试类别：</td>
							<td class="FieldInput"><label style="width: 120px;"
								title="参试类别" id="testedType" field="testedType" dataset="dsTest"/>
								 </td>
							
							<td class="FieldLabel" nowrap>职业健康检查：</td>
							<td class="FieldInput"><label style="width: 120px;"
								title="职业健康检查" dataset="dsHestth" id="isHealthFlag" field="isHealthFlag" />
								 </td>
							
							<td class="FieldLabel" nowrap>健康状况：</td>
							<td class="FieldInput"><label style="width: 120px;"
								title="健康状况代码" id="healthStateCode" dataset="dsHealth" field="healthStateCode"/>
								 </td>
							
						</tr>
						<tr id="examinationDate">
							<td class="FieldLabel" nowrap>本次查体时间：</td>
							<td class="FieldInput"><label  name="thisExaminationDate" id="thisExaminationDate"
								title="本次查体时间" field="thisExaminationDate" format="Y-m-d"
								 /></td>
							
							<td class="FieldLabel" nowrap>上次查体时间：</td>
							<td class="FieldInput" ><label   name="theExaminationDate" id="theExaminationDate"
								title="上次查体时间" field="theExaminationDate" format="Y-m-d"
								  /></td>
							<td class="FieldLabel" nowrap>原生活补助证编号：</td>
							<td class="FieldInput"><label  name="oldPaperNo" field="oldPaperNo" title="原生活补助证编号"></input><font color="red">*</font></td>
							
						</tr>
						<tr>
							<td class="FieldLabel" nowrap>是否孤老：</td>
							<td class="FieldInput"><label name="oldLonelyFlag"
								field="oldLonelyFlag" title="是否孤老" dataset="OldLonelyFlagEnum"/>
							 </td>
							
							<td class="FieldLabel" nowrap>是否精神病：</td>
							<td class="FieldInput"><label name="insanityFlag"
								field="insanityFlag" dataset="InsanityFlagEnum" title="是否精神病"/>
								 </td>
							
							<td class="FieldLabel" nowrap>劳动能力：</td>
							<td class="FieldInput" nowrap><label name="workAbilityCode"
								field="workAbilityCode" title="劳动能力" dataset="WorkAbilityCodeEnum" />
							</td>
						
						</tr>
						<tr>
							<td class="FieldLabel" nowrap>生活状况：</td>
							<td class="FieldInput"><label style="width: 120px;"
								title="生活状况代码" dataset="dsLife" id="lifeStateCode" field="lifeStateCode" />
							</td>
							
							<td class="FieldLabel" nowrap>生活能力：</td>
							<td class="FieldInput"><label name="viabilityCode"
								field="viabilityCode" title="生活能力" dataset="ViabilityCodeEnum"/>
							</td>
							
							
							<td class="FieldLabel" nowrap>供养方式：</td>
							<td class="FieldInput"><label name="supportPattern"
								field="supportPattern" title="供养方式" dataset="SupportPatternEnum" />
							</td>
						</tr>
						<tr>
							<td class="FieldLabel" nowrap>残疾等级：</td>
							<td class="FieldInput"><label style="width: 120px;"
								id="disabilityLevelCode" dataset="DisabilityLevelDataset" field="disabilityLevelCode" title="残疾等级" />
							</td>
							
							<td class="FieldLabel" nowrap>先天性残疾子女数：</td>
							<td class="FieldInput" colspan="3"><label 
								name="disabilityNum" field="disabilityNum" title="先天性残疾子女数"/></td>
						</tr>
						<tr>
							<td class="FieldLabel" nowrap>身份认定依据：</td>
							<td class="FieldInput" colspan="5">
								<label  
								  name="identityBasis" field="identityBasis" title="身份认定依据" /></td>		
						</tr>
						<tr>
							<td class="FieldLabel" nowrap>开户银行：</td>
							<td class="FieldInput"><label name="bank" field="bank" title="开户银行" dataset="BankEnum"></td>
							<td  class="FieldLabel" nowrap>开户名称：</td>
							<td class="FieldInput"><label  name="accountName" field="accountName" title="开户名称"/></td>
							<td  class="FieldLabel" nowrap>银行账号：</td>
							<td class="FieldInput" colspan="5"><label name="accountCode" field="accountCode" title="银行帐号" style="width:200" /></td>	
						</tr>
						
						<tr>
							<td class="FieldLabel">由何地迁入</td>
							<td class="FieldInput"><label name="ingoingAddress" field="ingoingAddress" title="由何地迁入"/></td>
							<td class="FieldLabel">抚恤金已发至月份</td>
							<td class="FieldInput" colspan="3"><label   name="allowanceMonth" field="allowanceMonth" title="抚恤金已发至月份"/></td>
						</tr>
						
						<tr>
							<td class="FieldLabel">迁入原因</td>
							<td class="FieldInput" colspan="5"><label     name="ingoingReason" field="ingoingReason" style="width:90%" title="迁入原因" /></td>
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
	var TestedDataset = L5.DatasetMgr.lookup("TestedDataset");
	TestedDataset.setParameter("APPLY_ID",applyId);
	TestedDataset.load();
	L5.QuickTips.init(); 
}
	
</script>
</html>
