<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="com.inspur.cams.comm.util.IdHelp"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%
	String familyId = IdHelp.getUUID30();
	String peopleId = IdHelp.getUUID30();
%>
<html>
<head>
<title>带病回乡退伍军人信息</title>
<next:ScriptManager />
<script>
	var peopleId=<%=request.getParameter("peopleId")%>;
</script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="illMigrationInsert.js"></script>
<script type="text/javascript" src="../../../comm/bptComm.js"></script>
</head>
<body>
<model:datasets>

	<!-- 带病回乡退伍军人 -->
	<model:dataset id="DemobilizedIllnessDataset" cmd="com.inspur.cams.bpt.manage.cmd.BptPeopleDemobilizedIllnessQueryCommand" method="queryDemobilizedIllnessBPTPeople" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptPeopleDemobilizedIllness">
			<model:field name="demobilizedStateCode" type="string" />
			<model:field name="demobilizedNo" type="string"  />
			<model:field name="name" type="string"/>
			<model:field name="sex" type="string"/>
			<model:field name="familyId" type="string"/>
			<model:field name="peopleId" type="string"/>
			<model:field name="serviceType" type="string"/>
			<model:field name="idCard" type="string"/>
			<model:field name="nation" type="string"/>
			<model:field name="birthday" type="string"/>
			<model:field name="address" type="string"/>
			<model:field name="demobilizedNo" type="string"/>
			<model:field name="insanityFlag" type="string"  />
			<model:field name="oldLonelyFlag" type="string"  />
			<model:field name="orphanFlag" type="string"  />
			<model:field name="workAbilityCode" type="string"  />
			<model:field name="workAbilityDescribe" type="string" />
			<model:field name="viabilityCode" type="string" />
			<model:field name="supportPattern" type="string"  />
			<model:field name="jobStatusDescribe" type="string" />
			<model:field name="bank" type="string" />
			<model:field name="dependantTypeCode" type="string" />
			<model:field name="disabilityTypeCode" type="string" />

			<model:field name="accountName" type="string" />
			<model:field name="accountCode" type="string" />
			<!-- 行政区划 字段 -->
			<model:field name="apanageName" type="string"/>
			<!-- 带病回乡 信息字段 -->
			<model:field name="ingoingAddress" type="string"/>
			<model:field name="allowanceMonth" type="string"/>
			<model:field name="townCheckPhone" type="string"/>
			<model:field name="ingoingCode" type="string"/>
		</model:record>
	</model:dataset>
	<!-- 性别 -->
	<model:dataset id="SexDataset" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
	<!-- 民族 -->
	<model:dataset id="NationDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset> 
	<!-- 身体状况 -->
	<model:dataset id="PhysiclalStatusEnum" enumName="PHYSICLAL.STATUS" autoLoad="true" global="true"></model:dataset>
	<!-- 是否精神病标志 -->
	<model:dataset id="InsanityFlagEnum" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
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
	<!-- 家庭经济状况 -->
	<model:dataset id="FamilyEconomicsEnum" enumName="FAMILY.ECONOMICS" autoLoad="true" global="true"></model:dataset>
	<!-- 开户银行代码 -->
	<model:dataset id="BankEnum" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BANK'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 是否参战 -->
	<model:dataset id="isWarEnum" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 是否涉核 -->
	<model:dataset id="isInnuclearEnum" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 优抚对象状态 -->
	<model:dataset id="ObjectStateDataset" enumName="OBJECT.STATE" autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:Panel height="100%" width="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="save"  text="保存" handler="save"/>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="disable" text="关闭" handler="func_Close" />
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
					<form id="editForm" dataset="DemobilizedIllnessDataset" onsubmit="return false" style="padding: 5px;" class="L5form">
					<table border="1" border="0" width="98%">
					<tr>
							<td class="FieldLabel" style="width:15%">身份证号：</td>
							<td class="FieldInput" style="width:15%"><input readonly="readonly" type="text" id ="idCard" name="idCard" maxlength="18" field="idCard" style="width:135"/>
											<img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>" style="cursor:hand" onclick="getIdCard()"/>
							</td>
							<td class="FieldLabel" style="width:15%">姓名：</td>
							<td class="FieldInput" style="width:15%"><label id="name" name="name" field="name"/></td>
							<td class="FieldLabel" style="width:15%">性别：</td>
							<td class="FieldInput" style="width:15%"><label id="sex" name="sex" field="sex" dataset="SexDataset"></label></td>
				   		</tr>
				   		
				   		<tr>
				   			<td class="FieldLabel">民族：</td>
							<td class="FieldInput"><label id="nation" name="nation" field="nation" dataset="NationDataset"></label></td>
				   			<td class="FieldLabel">出生年月：</td>
							<td class="FieldInput" colspan="3"><label id="birthday" name="birthday" field="birthday"/></td>
				   		</tr>
				   		
						<tr>
							<td class="FieldLabel">优抚对象状态：</td>
							<td class="FieldInput"><label name="demobilizedStateCode" field="demobilizedStateCode" dataset="ObjectStateDataset" title="优抚对象状态"></label></td>
							<td class="FieldLabel">生活补助证编号:</td>
							<td class="FieldInput"><label name="demobilizedNo" field="demobilizedNo" title="生活补助证编号"></label></td>
							<td class="FieldLabel" nowrap>批准日期：</td>
							<td class="FieldInput"><label name="approvalDate" field="approvalDate" title="批准日期"></label></td>
						</tr>
						<tr>
							<td class="FieldLabel" nowrap>入伍时间：</td>
							<td class="FieldInput"><label name="conscriptDate" 	field="conscriptDate" title="入伍时间"></label></td>
							<td class="FieldLabel" nowrap>退伍时间：</td>
							<td class="FieldInput"><label name="decruitmentDate" field="decruitmentDate" title="退伍时间"></label></td>
							<td class="FieldLabel" nowrap>退伍证号：</td>
							<td class="FieldInput"><label name="asdpNo" field="asdpNo" title="退伍证号"></label></td>
						</tr>
						<tr>
							<td class="FieldLabel" nowrap>职务：</td>
							<td class="FieldInput"><label name="position" field="position" title="职务"></label></td>
							<td class="FieldLabel" nowrap>是否参战：</td>
							<td class="FieldInput"><label name="isWar" field="isWar" dataset="isWarEnum" title="是否参战"></label></td>
							<td class="FieldLabel" nowrap>是否涉核：</td>
							<td class="FieldInput"><label name="isInnuclear" field="isInnuclear" dataset="isInnuclearEnum" title="是否参试"></label></td>
                       </tr>
                       <tr>
							<td class="FieldLabel" nowrap>是否孤老：</td>
							<td class="FieldInput"><label name="oldLonelyFlag" field="oldLonelyFlag" dataset="OldLonelyFlagEnum" title="是否孤老"></label></td>
                            <td class="FieldLabel" nowrap>是否精神病：</td>
							<td class="FieldInput"><label name="insanityFlag" field="insanityFlag" dataset="InsanityFlagEnum" title="是否精神病"></label></td>
                            <td class="FieldLabel" nowrap>劳动能力：</td>
							<td class="FieldInput"><label name="workAbilityCode" field="workAbilityCode" dataset="WorkAbilityCodeEnum" title="劳动能力"></label></td>
						</tr>
						<tr>
                            <td class="FieldLabel" nowrap>生活能力：</td>
							<td class="FieldInput"><label name="viabilityCode" field="viabilityCode" dataset="ViabilityCodeEnum" title="生活能力"></label></td>
                            <td class="FieldLabel" nowrap>供养方式：</td>
							<td class="FieldInput"><label name="supportPattern" field="supportPattern" dataset="SupportPatternEnum" title="供养方式"></label></td>
                            <td class="FieldLabel" nowrap>身体状况：</td>
							<td class="FieldInput"><label name="physiclalStatus" field="physiclalStatus" dataset="PhysiclalStatusEnum" title="身体状况"></label></td>
						</tr>
						<tr>
                            <td class="FieldLabel" nowrap>开户银行：</td>
							<td class="FieldInput"><label name="bank" field="bank" dataset="BankEnum" title="开户银行"></label></td>
							<td class="FieldLabel" nowrap>开户名称：</td>
							<td class="FieldInput"><label name="accountName" field="accountName" title="开户名称"></label></td>
							<td class="FieldLabel" nowrap>银行账号：</td>
							<td class="FieldInput"><label name="accountCode" field="accountCode" title="银行帐号" style="width: 200"></label></td>
						</tr>
						<tr>
							<td class="FieldLabel" nowrap>家庭经济状况：</td>
							<td class="FieldInput" colspan="5"><label name="familyEconomics" field="familyEconomics" dataset="FamilyEconomicsEnum" title="家庭经济状况"></label></td>
						</tr>
						<tr>
							<td class="FieldLabel" nowrap>在部队期间患病信息：</td>
							<td class="FieldInput" colspan="5"><label name="illessInfo" field="illessInfo" title="在部队期间患病信息"></label></td>
						</tr>
                        <tr>
							<td class="FieldLabel" nowrap>备注(类别信息)：</td>
							<td class="FieldInput" colspan="5"><label name="note" field="note"  title="备注(类别信息)" style="width: 200" /></td>
								<input type="hidden" id="peopleId" field="peopleId">
								<input type="hidden" id="familyId" field="familyId">
								<input type="hidden" id="serviceType" value="4B">
						</tr>
						<tr>
							<td class="FieldLabel" nowrap="nowrap">迁入地民政局：</td>
							<td class="FieldInput"><input type="hidden" id="ingoingCode" name="ingoingCode" field="ingoingCode"/>
													<input type="text" id="ingoingAddress" name="ingoingAddress" field="ingoingAddress" onclick="getCodeAndName()"/>
													<font color="red">*</font></td>
							<td class="FieldLabel" nowrap="nowrap">带病回乡抚恤金已发至：</td>
							<td class="FieldInput"><input type="text" id="allowanceMonth" name="allowanceMonth" field="allowanceMonth" format="Y-12" style="width: 100px;" maxlength="10"/><img  src="../../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ><font color="red">*</font></td>
							<td class="FieldLabel" nowrap="nowrap">迁出地民政部门联系电话：</td>
							<td class="FieldInput"><input type="text" name="townCheckPhone" field="townCheckPhone"/></td>
						</tr>
						
				</table>
			</form>
		</next:Html>
</next:Panel>
</body>
</html>
