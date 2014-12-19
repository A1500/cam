<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>

<html>
<head>
<title>参试人员信息</title>
<next:ScriptManager />
<script>
			var assignmentId = '<%= (String)request.getParameter("assignmentId")%>';
			var processId = '<%= (String)request.getParameter("processId")%>';
		</script>
<script type="text/javascript" src="bpttestedUpdate.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="dsTested"
		cmd="com.inspur.cams.bpt.manage.cmd.BptPeopleTestedQueryCommand"
		global="true" method="queryPeopleTestedInfo" >
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptPeopleTested">
			<model:field name="insanityFlag" type="string" />
			<model:field name="oldLonelyFlag" type="string" />
			<model:field name="orphanFlag" type="string" />
			<model:field name="workAbilityCode" type="string" />
			<model:field name="workAbilityDescribe" type="string" />
			<model:field name="viabilityCode" type="string" />
			<model:field name="supportPattern" type="string" />
			<model:field name="jobStatusDescribe" type="string" />
			<model:field name="bank" type="string" />
			<model:field name="accountName" type="string" />
			<model:field name="accountCode" type="string" />
			<model:field name="warStateCode" type="string" />
			<model:field name="warNo" type="string" />
		</model:record>
	</model:dataset>
	
	<!-- 与户主关系 -->
	<model:dataset id="RelationshipTypeDataset" enumName="RELATIONSHIP.TYPE" autoLoad="true" global="true"></model:dataset>

	<!-- 性别 -->
	<model:dataset id="SexDataset" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
	<!-- 民族 -->
	<model:dataset id="NationDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 文化程度 -->
	<model:dataset id="EducationDataset" enumName="EDUCATION.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 婚姻状况 -->
	<model:dataset id="MarriageDataset" enumName="MARRIAGE.STATE" autoLoad="true" global="true"></model:dataset>
	<!-- 政治面貌 -->
	<model:dataset id="PoliticalDataset" enumName="POLITICAL.LANDSCAPE" autoLoad="true" global="true"></model:dataset>
	<!-- 户籍类别 -->
	<model:dataset id="DomicileDataset" enumName="DOMICILE.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 医疗保障方式 -->
	<model:dataset id="SafeguardDataset" enumName="COMM.MEDICAL_STATUS" autoLoad="true" global="true"></model:dataset>
	
	<!-- 伤残等级 -->
	<model:dataset id="DisabilityLevelDataset" enumName="LEVEL.CODE" autoLoad="true" global="true"></model:dataset>
	
	
	<!-- 职业 -->
	<model:dataset id="CareerDataset" enumName="CAREER.TYPE"
		autoLoad="true" global="true"></model:dataset>

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
		enumName="DEPENDANT.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 就业状况 -->
	<model:dataset id="EmploymentCodeDataset" enumName="EMPLOYMENT.CODE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 工作单位性质 -->
	<model:dataset id="WorkUnitCharacterDataset"
		enumName="WORKUNIT.CHARACTER" autoLoad="true" global="true"></model:dataset>
</model:datasets>


<next:Panel height="100%" autoScroll="true" width="100%" >
	
	<next:Html>
		<form id="editForm" dataset="dsTested" onsubmit="return false"
			style="padding: 5px;" class="L5form">
		<table border="0" width="98%" align="left">
			<tr>	
				<td class="FieldLabel">优抚对象状态：</td>
				<td class="FieldInput">
				<label name="warStateCode" field="warStateCode"  dataset="ObjectStateDataset" title="优抚对象状态"/>
				</td>
			
				<td class="FieldLabel">生活补助证编号：</td>
				<td class="FieldInput">
				<label name="warNo" field="warNo" title="生活补助证编号"/>
				</td>

				<td class="FieldLabel">批准日期：</td>
				<td class="FieldInput">
				<label name="approvalDate" field="approvalDate" title="批准日期"/>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel" nowrap>入伍(参加工作)时间：</td>
				<td class="FieldInput">
				<label name="conscriptcDate" field="conscriptcDate" title="入伍(参加工作)时间"/>
				</td>
				<td class="FieldLabel" nowrap>退伍时间：</td>
				<td class="FieldInput">
				<label name="decruitmentDate" field="decruitmentDate" title="退伍时间"/>
				</td>

				
			
				<td class="FieldLabel" nowrap>离退休时间：</td>
				<td class="FieldInput">
				<label name="retiredDate" field="retiredDate" title="离退休时间"/>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel" nowrap>退伍证号：</td>
				<td class="FieldInput">
				<label name="asdpNo" field="asdpNo" title="退伍证号"/>
				</td>

				<td class="FieldLabel" nowrap>原部队代号：</td>
				<td class="FieldInput">
				<label name="forcesNo" field="forcesNo" title="原部队代号"/>
				</td>
			
				<td class="FieldLabel">职务（级别）：</td>
				<td class="FieldInput">
				<label name="position" field="position" title="职务(级别)"/>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel">参试类别：</td>
				<td class="FieldInput">
				<label name="testedType" field="testedType"  dataset="dsTest" title="参试类别"/>
				</td>
				
				<td class="FieldLabel">职业健康检查：</td>
				<td class="FieldInput">
				<label name="isHealthFlag" field="isHealthFlag" dataset="dsHestth" title="职业健康检查"/>
				</td>
				
				<td class="FieldLabel">健康状况：</td>
				<td class="FieldInput">
				<label name="healthStateCode" field="healthStateCode"  dataset="dsHealth" title="健康状况"/>
				</td>
			</tr>
			<tr id="examinationDate">
				<td class="FieldLabel" nowrap>本次查体时间：</td>
				<td class="FieldInput"><label  name="thisExaminationDate" title="本次查体时间" field="thisExaminationDate" /></td>
				<td class="FieldLabel" nowrap>上次查体时间：</td>
				<td class="FieldInput" colspan="3"><label name="theExaminationDate" title="上次查体时间" field="theExaminationDate" /></td>
							
			</tr>
			<tr>
				<td class="FieldLabel">是否孤老：</td>
				<td class="FieldInput">
				<label name="oldLonelyFlag" field="oldLonelyFlag"  dataset="OldLonelyFlagEnum" title="是否孤老"/>
				</td>
				
				<td class="FieldLabel">是否精神病：</td>
				<td class="FieldInput">
				<label name="insanityFlag" field="insanityFlag"  dataset="InsanityFlagEnum" title="是否精神病"/>
				</td>
				
				<td class="FieldLabel">劳动能力：</td>
				<td class="FieldInput">
				<label name="workAbilityCode" field="workAbilityCode"  dataset="WorkAbilityCodeEnum" title="劳动能力"/>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel">生活状况：</td>
				<td class="FieldInput">
				<label name="lifeStateCode" field="lifeStateCode"  dataset="dsLife" title="生活状况"/>
				</td>

				<td class="FieldLabel">生活能力：</td>
				<td class="FieldInput">
				<label name="viabilityCode" field="viabilityCode"  dataset="ViabilityCodeEnum" title="生活能力"/>
				</td>
			
				<td class="FieldLabel">供养方式：</td>
				<td class="FieldInput">
				<label name="supportPattern" field="supportPattern"  dataset="SupportPatternEnum" title="供养方式"/>
				</td>	
			</tr>
			<tr>
				<td class="FieldLabel">残疾等级：</td>
				<td class="FieldInput">
				<label name="disabilityLevelCode" field="disabilityLevelCode" dataset="DisabilityLevelDataset" title="残疾等级"/>
				</td>
				
				<td class="FieldLabel">先天性残疾子女数：</td>
				<td class="FieldInput"  colspan="3">
				<label name="disabilityNum" field="disabilityNum" title="先天性残疾子女数"/>
				</td>
				
			</tr>
			<tr>
				<td class="FieldLabel">身份认定依据：</td>
				<td class="FieldInput" colspan="5">
				<label name="identityBasis" field="identityBasis" title="身份认定依据"/>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel" nowrap>开户银行：</td>
				<td class="FieldInput">
				<label name="bank"
					field="bank" dataset="BankEnum" title="开户银行"/>
				</td>
				<td  class="FieldLabel" nowrap>开户名称：</td>
				<td class="FieldInput">
				<label name="accountName"
					field="accountName" title="开户名称"/>
				</td>
				<td  class="FieldLabel" nowrap>银行账号：</td>
				<td class="FieldInput" colspan="5">
				<label name="accountCode"
					field="accountCode" title="银行帐号"/>
				</td>	
			</tr>
			<tr>
				<td class="FieldLabel">备注(类别信息)：</td>
				<td class="FieldInput" colspan="5">
				<label name="note" field="note" title="备注(类别信息)"/>
				</td>
			</tr>
		</table>
		</form>
	</next:Html>
</next:Panel>

</body>

<script type="text/javascript">
	function init(){
		var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.WfProcessBusinessCommand");
		if(processId==null || processId == ""){
			command.setParameter("assignmentId",assignmentId);
		}else{
			command.setParameter("PROCESS_ID",processId);
		}
		command.execute("queryBusinessType");
		var peopleId = command.getReturn("peopleId");
	
		var dsTested= L5.DatasetMgr.lookup("dsTested");
		dsTested.setParameter("PEOPLE_ID",peopleId);
		dsTested.load();
		L5.QuickTips.init();
	}
</script>
</html>
