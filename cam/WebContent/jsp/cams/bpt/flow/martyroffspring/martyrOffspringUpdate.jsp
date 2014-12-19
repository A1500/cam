<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%
	response.setHeader("Expires", "Sat, 6 May 1995 12:00:00 GMT");  
	response.setHeader("Cache-Control", "no-store,no-cache,must-revalidate");  
	response.addHeader("Cache-Control", "post-check=0, pre-check=0");  
	response.setHeader("Pragma", "no-cache");  
%>
<script type="text/javascript">
   var peopleId = '<%=(String)request.getParameter("peopleId")%>';
</script>
<html>
<head>
<title>部分烈士（错杀被平反人员）子女受理</title>
</head>
<body>
<next:ScriptManager />
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="martyrOffspringUpdate.js"></script>
<script type="text/javascript" src="../../comm/bptComm.js"></script>

<model:datasets>
	<!-- 部分烈士（错杀被平反人员）子女信息 -->  
	<model:dataset id="MartyrOffspringDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptPeopleMartyrOffspringQueryCommand" method="getMartyrOffsprinInfor" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptPeopleMartyrOffspring">
			<model:field name="oldLonelyFlag" type="string" rule="require"/>
			<model:field name="orphanFlag" type="string" rule="require"/>
			<model:field name="workAbilityCode" type="string" rule="require"/>
			<model:field name="viabilityCode" type="string" rule="require"/>
			<model:field name="supportPattern" type="string" rule="require"/>
			<model:field name="bank" type="string" />
			<model:field name="accountName" type="string"/>
			<model:field name="accountCode" type="string"/> 
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

<next:Panel bodyStyle="width:100%;height:100%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="saveClick" />
		<next:ToolBarItem iconCls="disable" text="关闭" handler="funClose" />
	</next:TopBar>
			<next:Panel id="typeInfo" title="类别信息" height="100%"  autoScroll="true"
				width="100%" autoHeight="true">
				<next:Html>
					<form id="editForm" dataset="MartyrOffspringDataSet"
						onsubmit="return false" style="padding: 5px;" class="L5form">
					<table border="1" width="99%">
						<tr>
							<td class="FieldLabel" nowrap="nowrap">身份类别：</td>
								<td class="FieldInput" ><select id="statusType" name="statusType"
									field="statusType" title="身份类别" style="width:80%">
									<option dataset="StatusTypeEnum"></option>
								</select><font color="red">*</font></td>
							<td class="FieldLabel">牺牲者姓名：</td>
							<td class="FieldInput"><input type="text" id="lezswName" name="lezswName" field="lezswName" title="牺牲者姓名" /></td>
							<td class="FieldLabel">牺牲时间：</td>
							<td class="FieldInput"><input type="text" id="sacrificeDate" name="sacrificeDate" maxlength="10" field="sacrificeDate"style= "width:100px;"  format="Y-m-d" onpropertychange="changeDateStyle(this)" title="牺牲时间"/><img  src="../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this)"><font color="red">*</font></td>
						</tr>
						<tr>
							<td class="FieldLabel">批准烈士（平反）时间：</td>
							<td class="FieldInput"><input type="text" id="lezswApproveDate" name="lezswApproveDate" maxlength="10" field="lezswApproveDate"style= "width:100px;"  format="Y-m-d" onpropertychange="changeDateStyle(this)" title="批准烈士（平反）时间"/><img  src="../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this)"><font color="red">*</font></td>
							<td class="FieldLabel" nowrap>与牺牲者关系：</td>
							<td class="FieldInput"><select id="relationship" name="relationship"
								field="relationship" title="与牺牲者关系">
								<option dataset="RelationShipEnum"></option>
								</select>
							</td>
							<td class="FieldLabel">是否持证人：</td>
							<td class="FieldInput"><select name="holderFlag"
								field="holderFlag" title="是否持证人">
								<option dataset="HolderFlagEnum"></option>
								</select></td>
						</tr>
						<tr>	
							<td class="FieldLabel">是否孤老：</td>
							<td class="FieldInput"><select name="oldLonelyFlag"
								field="oldLonelyFlag" title="是否孤老">
								<option dataset="OldLonelyFlagEnum"></option>
							</select><font color="red">*</font></td>
							<td class="FieldLabel">是否孤儿：</td>
							<td class="FieldInput"><select name="orphanFlag"
								field="orphanFlag" title="是否孤儿">
								<option dataset="OrphanFlagEnum"></option>
							</select><font color="red">*</font></td>
							<td  class="FieldLabel" nowrap>生活状况：</td>
							<td class="FieldInput">
				     			<select name="lifeStateCode" field="lifeStateCode" title="生活状况">
					     			<option dataset="lifeStateEnum"></option>
				     			</select><font color="red">*</font>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel">劳动能力：</td>
							<td class="FieldInput"><select name="workAbilityCode"
								field="workAbilityCode" title="劳动能力">
								<option dataset="WorkAbilityCodeEnum"></option>
							</select><font color="red">*</font></td>

							<td class="FieldLabel">生活能力：</td>
							<td class="FieldInput"><select name="viabilityCode"
								field="viabilityCode" title="生活能力">
								<option dataset="ViabilityCodeEnum"></option>
							</select><font color="red">*</font></td>

							<td class="FieldLabel">供养方式：</td>
							<td class="FieldInput"><select name="supportPattern"
								field="supportPattern" title="供养方式">
								<option dataset="SupportPatternEnum"></option>
							</select><font color="red">*</font></td>
						</tr>
						<tr>
							<td  class="FieldLabel" nowrap>享受低保待遇：</td>
							<td class="FieldInput">
				     			<select id="guarantFlag" name="guarantFlag" field="guarantFlag" title="享受低保待遇">
					     			<option dataset="HolderFlagEnum"></option>
				     			</select>
							</td>
							<td  class="FieldLabel" nowrap>享受五保待遇：</td>
							<td class="FieldInput">
				     			<select id="fiveGuarantFlag" name="fiveGuarantFlag" field="fiveGuarantFlag" title="享受五保待遇">
					     			<option dataset="HolderFlagEnum"></option>
				     			</select>
							</td>
							<td  class="FieldLabel" nowrap>享受过抚恤金：</td>
							<td class="FieldInput">
				     			<select id="enjoyedTreatFlag" name="enjoyedTreatFlag" field="enjoyedTreatFlag" title="享受过抚恤金">
					     			<option dataset="HolderFlagEnum"></option>
				     			</select>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel">开户银行：</td>
							<td class="FieldInput">
							    <select name="bank" field="bank" title="开户银行">
								<option dataset="BankEnum"></option>
							</select> </td>
							<td class="FieldLabel">开户名称：</td>
							<td class="FieldInput"><input type="text" name="accountName" field="accountName" title="开户名称"/></td>

							<td class="FieldLabel">银行账号：</td>
							<td class="FieldInput"><input type="text" name="accountCode" field="accountCode" title="银行账号" style="width: 200"></input></td>
						</tr>
						<tr>
							<td class="FieldLabel">备注(类别信息)：</td>
							<td class="FieldInput" colspan="5"><textarea name="note" field="note" style="width: 95%" rows="3"></textarea></td>
						</tr>
					</table>
					</form>
				</next:Html>
			</next:Panel>
</next:Panel>
</body>
</html>
