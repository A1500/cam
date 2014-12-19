<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="com.inspur.cams.comm.util.IdHelp"%>
<% 
String people =request.getParameter("peopleId");
%>
<html>
<head>
<title>在乡复员军人业务受理</title>
<next:ScriptManager />
		<script>
			var peopleId='<%=request.getParameter("peopleId")%>';
			
		</script>
<script type="text/javascript" src="demobilizedInfo.js"></script>
</head>
<body>
<model:datasets>
	<!-- 在乡复员军人信息 -->
	<model:dataset id="PeopleDemobilizedDataset" cmd="com.inspur.cams.bpt.manage.cmd.BptPeopleDemobilizedQueryCommand" global="true" method="queryDemobilizedBptPeople">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptPeopleDemobilized">
		    <model:field name="demobilizedStateCode" type="string" rule="require"/>
			<model:field name="demobilizedNo" type="string" rule="require"/>
			<model:field name="insanityFlag" type="string" rule="require"/>
			<model:field name="oldLonelyFlag" type="string" rule="require"/>
			<model:field name="orphanFlag" type="string" rule="require"/>
			<model:field name="workAbilityCode" type="string" rule="require"/>
			<model:field name="workAbilityDescribe" type="string"/>
			<model:field name="viabilityCode" type="string" rule="require"/>
			<model:field name="supportPattern" type="string" rule="require"/>
			<model:field name="jobStatusDescribe" type="string"/>
			<model:field name="bank" type="string"/>
			<model:field name="accountName" type="string"/>
			<model:field name="accountCode" type="string"/>
		</model:record>
	</model:dataset>
	<!-- 是否精神病标志 -->
	<model:dataset id="InsanityFlagEnum" enumName="COMM.YESORNO"  autoLoad="true" global="true"></model:dataset>
	<!-- 孤老标志 -->
	<model:dataset id="OldLonelyFlagEnum" enumName="COMM.YESORNO"  autoLoad="true" global="true"></model:dataset>
	<!-- 孤儿标志 -->
	
	<!-- 劳动能力代码 -->
	<model:dataset id="WorkAbilityCodeEnum" enumName="WORK.ABILITY.CODE"  autoLoad="true" global="true"></model:dataset>
	<!-- 优抚生活能力代码 -->
	<model:dataset id="ViabilityCodeEnum" enumName="VIABILITY.CODE"  autoLoad="true" global="true"></model:dataset>
	<!-- 优抚供养方式 -->
	<model:dataset id="SupportPatternEnum" enumName="SUPPORT.PATTERN"  autoLoad="true" global="true"></model:dataset>
	<!-- 开户银行代码 -->
	<model:dataset id="BankEnum" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BANK'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 是否抗美援朝-->
	<model:dataset id="KoeanwarEnum" enumName="COMM.YESORNO"  autoLoad="true" global="true"></model:dataset>
	<!-- 优抚对象状态 -->
	<model:dataset id="ObjectStateDataset" enumName="OBJECT.STATE" autoLoad="true" global="true"></model:dataset>
	<!-- 属于时期-->
	<model:dataset id="warDs" enumName="DEMOBILIZED.BELONGDATE" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel  height="100%" width="100%"  autoScroll="true">
    <next:Html>
		<form id="editForm"  dataset="PeopleDemobilizedDataset"  onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  border="0" width="98%">
		   <tr>
				<td  class="FieldLabel" nowrap>入伍时间：</td>
				<td class="FieldInput"><label name="conscriptDate" field="conscriptDate" title="入伍时间"></label></td>
				<td  class="FieldLabel" nowrap>复员时间：</td>
				<td class="FieldInput"><label name="decruitmentDate" field="decruitmentDate" title="复员时间"></label></td>
			    <td  class="FieldLabel" nowrap>原部队代号：</td>
			    <td class="FieldInput"><label  type="text" name="forcesNo" title="原部队代号"></label></td>
			</tr>
	   		<tr>
	   		    <td  class="FieldLabel" nowrap>职务：</td>
	   		    <td class="FieldInput"><label name="position" field="position" title="职务"></label></td>
				<td  class="FieldLabel" nowrap>属于时期：</td>
				<td class="FieldInput"><label name="belongDate" field="belongDate" dataset="warDs" title="属于时期"></label></td>
			    <td  class="FieldLabel" nowrap>是否抗美援朝：</td>
			    <td class="FieldInput"><label name="isKoeanwar" field="isKoeanwar" dataset="KoeanwarEnum" title="是否抗美援朝"></label></td>
				
			</tr>

	   		<tr>
				<td  class="FieldLabel" nowrap>复员证号：</td><td class="FieldInput" ><label name="asdpNo" field="asdpNo" title="复员证号"></label></td>
				<td  class="FieldLabel" nowrap>是否孤老：</td>
				<td class="FieldInput"><label name="oldLonelyFlag" field="oldLonelyFlag" dataset="OldLonelyFlagEnum" title="是否孤老"></label></td>
				<td  class="FieldLabel" nowrap>是否精神病：</td>
				<td class="FieldInput" ><label name="insanityFlag" field="insanityFlag" dataset="InsanityFlagEnum" title="是否精神病"></label></td>
			</tr>
			<tr>
				<td  class="FieldLabel" nowrap>劳动能力：</td>
				<td class="FieldInput"><label name="workAbilityCode" field="workAbilityCode" dataset="WorkAbilityCodeEnum" title="劳动能力"></label></td>
				<td class="FieldLabel" nowrap>生活能力：</td>
				<td class="FieldInput"><label name="viabilityCode" field="viabilityCode" dataset="ViabilityCodeEnum" title="生活能力"></label></td>
				<td  class="FieldLabel"nowrap>供养方式:</td>
				<td class="FieldInput"><label name="supportPattern" field="supportPattern" dataset="SupportPatternEnum" title="供养方式"></label></td>
			</tr>
	   		<tr>
				<td class="FieldLabel" nowrap>开户银行：</td>
				<td class="FieldInput"><label name="bank" field="bank" dataset="BankEnum" title="开户银行"></label></td>
				<td  class="FieldLabel" nowrap>开户名称：</td>
				<td class="FieldInput"><label name="accountName" field="accountName" title="开户名称"></label></td>
				<td  class="FieldLabel" nowrap>银行账号：</td>
				<td class="FieldInput"><label name="accountCode" field="accountCode" title="银行帐号" style="width:200" ></label></td>	
			</tr>
			<tr>
				<td  class="FieldLabel" nowrap>备注(类别信息)：</td>
				<td class="FieldInput" colspan="5"><label name="note" field="note" title="备注(类别信息)" style="width:200"></label></td>
			</tr>
		</table>
		</form>
   </next:Html>
</next:Panel>
</body>
</html>
