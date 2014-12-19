<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<html>
<head>
<title>参战人员信息</title>
<next:ScriptManager />
<script>
			var peopleId='<%=request.getParameter("peopleId")%>';
		</script>
</head>
<body>
<model:datasets>
	<!-- 参战人员信息 -->
	<model:dataset id="dsWar" cmd="com.inspur.cams.bpt.manage.cmd.BptPeopleWarQueryCommand" global="true" method="queryPeopleWarInfo">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptPeopleWar">
			<model:field name="warNo" type="string" />
			<model:field name="approveDate" type="string" />
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
			<model:field name="approvalDate" type="string" />
			<model:field name="ingoingAddress" type="string" />
			<model:field name="allowanceMonth" type="string" />
			<model:field name="ingoingReason" type="string" />
			<model:field name="oldPaperNo" type="string" />
		</model:record>
	</model:dataset>
	<!--生活状况代码-->
	<model:dataset id="dsLife" enumName="LIFE.LIFE_STATE_CODE" autoLoad="true"></model:dataset>
	<!-- 开户银行代码 -->
	<model:dataset id="BankEnum" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BANK'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>

	<!--参战类别代码-->
	<model:dataset id="dsWarData" cmd="com.inspur.cams.bpt.manage.cmd.DicHealthQueryCommand" global="true" autoLoad="true" method="getAllWaraData">
		<model:record fromBean="com.inspur.cams.bpt.base.data.DicHealth">
			<model:field name="value" mapping="CODE" />
			<model:field name="text" mapping="NAME" />
		</model:record>
	</model:dataset>
	<!-- 优抚对象状态 -->
	<model:dataset id="ObjectStateDataset" enumName="OBJECT.STATE" autoLoad="true" global="true"></model:dataset>
	<!-- 优抚供养方式 -->
	<model:dataset id="SupportPatternEnum" enumName="SUPPORT.PATTERN" autoLoad="true" global="true"></model:dataset>
	<!-- 孤老标志 -->
	<model:dataset id="OldLonelyFlagEnum" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 孤儿标志 -->
	<model:dataset id="OrphanFlagEnum" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 劳动能力代码 -->
	<model:dataset id="WorkAbilityCodeEnum" enumName="WORK.ABILITY.CODE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 优抚生活能力代码 -->
	<model:dataset id="ViabilityCodeEnum" enumName="VIABILITY.CODE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 优抚供养方式 -->
	<model:dataset id="SupportPatternEnum" enumName="SUPPORT.PATTERN"
		autoLoad="true" global="true"></model:dataset>
	<!-- 健康状况 -->
	<model:dataset id="HealthDataset" enumName="HEALTH.TYPE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 是否精神病标志 -->
	<model:dataset id="InsanityFlagEnum" enumName="COMM.YESORNO"
		autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel id="typeInfo" title="类别信息" height="100%" width="100%" autoScroll="true">
				<next:Html>
					<form id="editForm" dataset="dsWar" onsubmit="return false"
						style="padding: 5px;" class="L5form">
					<table border="0" width="98%" align="left" >
						<tr>
						<!--  	<td class="FieldLabel" nowrap>优抚对象状态：</td>
							<td class="FieldInput"><label style="width: 120px;" dataset="ObjectStateDataset"
								id="warStateCode" field="warStateCode" title="优抚对象状态" />
							</td>
							-->
							
					<!-- 	<td class="FieldLabel">批准日期：</td>
							<td class="FieldInput"><label name="approvalDate" field="approvalDate" format="Y-m-d" style="width: 100px;" maxlength="10" title="批准日期" /></td>
					-->
						</tr>
						<tr>
							<td class="FieldLabel" nowrap>入伍（参加工作）时间：</td>
							<td class="FieldInput"><label type="text"
								name="conscriptcDate" title="入伍时间" field="conscriptcDate"
								format="Y-m-d" />
								</td>
							<td class="FieldLabel" nowrap>退伍时间：</td>
							<td class="FieldInput"><label type="text"
								name="decruitmentDate" title="退伍时间" field="decruitmentDate"
								format="Y-m-d" />
								</td>

							<td class="FieldLabel" nowrap>离退休时间：</td>
							<td class="FieldInput"><label type="text" name="retiredDate"
								title="离退休时间" field="retiredDate" format="Y-m-d"
								 /></td>
						</tr>
						<tr>
							<td class="FieldLabel" nowrap>退伍证号：</td>
							<td class="FieldInput"><label type="text" name="asdpNo"
								field="asdpNo" title="退伍证号" /></td>

							<td class="FieldLabel" nowrap>原部队代号：</td>
							<td class="FieldInput"><label type="text" name="forcesNo"
								id="forcesNo" field="forcesNo" title="原部队代号" onblur="func_blur()"/>
							</td>
							
							<td class="FieldLabel" nowrap>职务（级别）：</td>
							<td class="FieldInput"><label type="text" name="position"
								field="position" title="职务(级别)"/></td>
						</tr>
						
						<tr>
							<td class="FieldLabel" nowrap>参战类别：</td>
							<td class="FieldInput"><label  field="warTypeCode" dataset="dsWarData" ></label>
							</td>
							
							<td class="FieldLabel" nowrap>是否孤老：</td>
							<td class="FieldInput"><label field="oldLonelyFlag"  dataset="OldLonelyFlagEnum"></label>
							</td>
							
							<td class="FieldLabel" nowrap>是否精神病：</td>
							<td class="FieldInput"><label field="insanityFlag" dataset="InsanityFlagEnum" ></label>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel" nowrap>劳动能力：</td>
							<td class="FieldInput"><label field="workAbilityCode" dataset="WorkAbilityCodeEnum">
							</td>
						
							
							
							<td class="FieldLabel" nowrap>生活能力：</td>
							<td class="FieldInput"><label field="viabilityCode" dataset="ViabilityCodeEnum"></label></td>
							<td class="FieldLabel" nowrap>供养方式：</td>
							<td class="FieldInput"><label field="supportPattern" dataset="SupportPatternEnum"></label></td>
						</tr>
						<tr>	
							<td class="FieldLabel" nowrap>健康状况：</td>
							<td class="FieldInput"><label  field="healthStateCode" dataset="HealthDataset"></label></td>
						
							<td class="FieldLabel" nowrap>生活状况：</td>
							<td class="FieldInput" ><label field="lifeStateCode" dataset="dsLife"></label></td>
							<td class="FieldLabel" nowrap>原生活补助证编号：</td>
							<td class="FieldInput"><label name="oldPaperNo" field="oldPaperNo" title="原生活补助证编号"></input><font color="red">*</font></td>
						
						</tr>
						<tr>
							<td class="FieldLabel" nowrap>开户银行：</td>
							<td class="FieldInput"><label  field="bank" dataset="BankEnum"></label></td>
							<td  class="FieldLabel" nowrap>开户名称：</td>
							<td class="FieldInput"><label type="text" name="accountName" field="accountName" title="开户名称"/></td>
							<td  class="FieldLabel" nowrap>银行账号：</td>
							<td class="FieldInput" colspan="5"><label type="text" name="accountCode" field="accountCode" title="银行帐号" style="width:200" ></label></td>	
						</tr>
						<tr>
							<td class="FieldLabel">由何地迁入</td>
							<td class="FieldInput"><label type="text" name="ingoingAddress"   field="ingoingAddress" title="由何地迁入"/></td>
							<td class="FieldLabel">抚恤金已发至月份</td>
							<td class="FieldInput" colspan="3"><label type="text" name="allowanceMonth" field="allowanceMonth" title="抚恤金已发至月份"  format="Y-m" /></td>
						</tr>
						
						<tr>
							<td class="FieldLabel">迁入原因</td>
							<td class="FieldInput" colspan="5"><label type="text" rows="2" name="ingoingReason" field="ingoingReason" style="width:90%" title="迁入原因"></label></td>
						</tr>
						<tr>
							<td class="FieldLabel" nowrap>备注(类别信息)：</td>
							<td class="FieldInput" colspan="5"><label rows="3"
								cols="120" name="note" field="note" title="备注(类别信息)"></label></td>
						</tr>
						
					</table>
					<label type="hidden" name="ingoingCode" field="ingoingCode" title="由何地迁入代码">
					</form>
				</next:Html>
			</next:Panel>
			


</body>
<script type="text/javascript">

	function init(){
	var dsWar= L5.DatasetMgr.lookup("dsWar");
	dsWar.setParameter("PEOPLE_ID",peopleId);
	dsWar.load();
	
	L5.QuickTips.init();
}
</script>

</html>
