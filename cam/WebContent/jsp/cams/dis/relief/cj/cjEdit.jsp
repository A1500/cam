<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>灾区民房恢复重建</title>
<next:ScriptManager />
<script language="javascript">
	var organCode = '<%=BspUtil.getOrganCode()%>';
	var organName = '<%=BspUtil.getOrganName()%>';
	var method = '<%=request.getParameter("method")%>';
	var batchId='<%=request.getParameter("batchId")%>';
	var batchDetailId='<%=request.getParameter("batchDetailId")%>';
	var infoId='<%=request.getParameter("infoId")%>';
</script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="../../comm/disComm.js"></script>
<script type="text/javascript" src="cjEdit.js"></script>
</head>
<body>
<model:datasets>
	<!-- 批次信息 -->
	<model:dataset id="batchDs"
		cmd="com.inspur.cams.dis.base.cmd.DisReliefBatchQueryCmd"
		global="true">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisReliefBatch">
		</model:record>
	</model:dataset>
	
	<!-- 批次明细信息 -->
	<model:dataset id="batchDetailDs"
		cmd="com.inspur.cams.dis.base.cmd.DisReliefBatchDetailQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisReliefBatchDetail">
		</model:record>
	</model:dataset>

	<!-- 档案信息 -->
	<model:dataset id="infoDs"
		cmd="com.inspur.cams.dis.base.cmd.DisReliefInfoQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisReliefInfo">
			<model:field name="name" type="string" rule="require"></model:field>
			<model:field name="idCard" type="string" rule="require"></model:field>
			<model:field name="familyNum" type="string" rule="require"></model:field>
			<model:field name="familyType" type="string" rule="require"></model:field>
			<model:field name="familyRegister" type="string" rule="require"></model:field>
			<model:field name="acceptAreaCode" type="string" rule="require"></model:field>
			
			<model:field name="houseCount" type="float" rule="require"></model:field>
			<model:field name="approvalMoney" type="float" rule="require"></model:field>
			<model:field name="approvalRebuiledHouse" type="float" rule="require"></model:field>
			<model:field name="approvalRepairedHouse" type="float" rule="require"></model:field>
			<model:field name="acceptPeopleName" type="string" rule="require"></model:field>
			<model:field name="acceptDate" type="string" rule="require"></model:field>
			<model:field name="houseCount" type="float" rule="require"></model:field>
		</model:record>
	</model:dataset>

	<!-- 家庭类型 -->
	<model:dataset id="DisFamilyType" enumName="DIS.FAMILY_TYPE"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 房屋结构 -->
	<model:dataset id="DisHouseStructure" enumName="DIS.HOUSE_STRUCTURE"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 发放方式 -->
	<model:dataset id="DisAllocationType"
		enumName="DIS.INFO_ALLOCATION_TYPE" autoLoad="true" global="true">
	</model:dataset>
	<!-- 灾害种类 -->
	<model:dataset id="DisDisasterType" enumName="DIS.DISASTER_TYPE"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 户口类型 -->
	<model:dataset id="DisFamilyRegister" enumName="DIS.FAMILY_REGISTER"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 发放单位  -->
	<model:dataset id="DisGrantType" enumName="DIS.GRANT_TYPE"
		autoLoad="true" global="true">
	</model:dataset>
</model:datasets>
<next:Panel width="100%" height="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="saveClick" />
		<next:ToolBarItem id="conBtn" iconCls="save" text="保存并继续"
			handler="saveClickContinue" />
	</next:TopBar>

	<next:Html>
		<fieldset>
		<form id="cjForm" method="post" dataset="infoDs"
			onsubmit="return false" class="L5form">
		<table border="0" width="100%" cellspacing="0" cellpadding="0">
			<tr>
				<td class="FieldLabel" style="width: 15%" nowrap>户主姓名:</td>
				<td class="FieldInput" style="width: 35%"><input type="text"
					id="name" name="name" field="name" title="户主姓名" maxlength="20" 
					onchange="checkCN('name','户主姓名');"/>
				<font color="red">*</font></td>
				<td class="FieldLabel" style="width: 15%" nowrap>身份证号码:</td>
				<td class="FieldInput" style="width: 35%"><input type="text"
					id="idCard" name="idCard" field="idCard" title="身份证号码"
					maxlength="18" style="width: 200px" onchange="CheckIdCardMessage()"/>
					<font color="red">*</font></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%" nowrap>家庭人口（人）:</td>
				<td class="FieldInput" style="width: 35%"><input type="text"
					id="familyNum" name="familyNum" field="familyNum" title="家庭人口（人）"
					maxlength="2" onchange="CheckTxt('familyNum','家庭人口');"/>
					<font color="red">*</font></td>
				<td class="FieldLabel" style="width: 15%" nowrap>家庭类型:</td>
				<td class="FieldInput" style="width: 35%"><select
					id="familyType" name="familyType" field="familyType" title="家庭类型">
					<option dataset="DisFamilyType"></option>
				</select> <font color="red">*</font></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%" nowrap>户口类型:</td>
				<td class="FieldInput" style="width: 35%"><select
					name="familyRegister" id="familyRegister" field="familyRegister"
					title="户口类型">
					<option dataset="DisFamilyRegister"></option>
				</select> <font color="red">*</font></td>
				<td class="FieldLabel" style="width: 15%" nowrap>行政村（社区）:</td>
				<td class="FieldInput" style="width: 35%"><input type="text"
					id="acceptAreaName" field="acceptAreaName" readonly="true"
					style="width: 200" title="行政村（社区）" /> <input type="hidden"
					id="acceptAreaCode" name="acceptAreaCode" field="acceptAreaCode"
					title="行政村（社区）" /> <img
					src="<%=SkinUtils.getImage(request,"l5/help.gif")%>"
					style="cursor: hand" onclick="forOrganSelect()" /><font
					color="red">*</font></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%" nowrap>房屋间数（间）:</td>
				<td class="FieldInput" style="width: 35%"><input type="text"
					id="houseCount" name="houseCount" field="houseCount"
					title="房屋间数（间）" maxlength="4" onchange="CheckTxt('houseCount','房屋间数');"/>
					<font color="red">*</font></td>
				<td class="FieldLabel" style="width: 15%" nowrap>房屋结构:</td>
				<td class="FieldInput" style="width: 35%"><select
					id="houseStructure" name="houseStructure" field="houseStructure"
					title="房屋结构">
					<option dataset="DisHouseStructure"></option>
				</select> <font color="red">*</font></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%" nowrap>受灾时间:</td>
				<td class="FieldInput" style="width: 35%" colspan="3"><input
					type="text" id="damageTime" name="damageTime" field="damageTime"
					title="受灾时间" format="Y-m-d" maxlength="10"
					onpropertychange="changeDateStyle(this)" /><img
					src="../../../../../skins/images/default/rl.gif" align="middle"
					onclick="getTimes(this)" /> <font color="red">*</font></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%" nowrap>倒塌房屋（间）:</td>
				<td class="FieldInput" style="width: 35%"><input type="text"
					id="collapsedHouse" name="collapsedHouse" field="collapsedHouse" 
					title="倒塌房屋（间）" onchange="CheckTxt('collapsedHouse','倒塌房屋');"/></td>
				<td class="FieldLabel" style="width: 15%" nowrap>严重损坏房屋（间）:</td>
				<td class="FieldInput" style="width: 35%"><input type="text"
					id="seriousDamageHouse" name="seriousDamageHouse" field="seriousDamageHouse"
					title="严重损坏房屋（间）" onchange="CheckTxt('seriousDamageHouse','严重损坏房屋');"/></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%" nowrap>一般损坏房屋（间）:</td>
				<td class="FieldInput" style="width: 35%"><input type="text"
					id="generalDamageHouse" name="generalDamageHouse" field="generalDamageHouse"
					title="一般损坏房屋（间）" onchange="CheckTxt('generalDamageHouse','一般损坏房屋');"/></td>
				<td class="FieldLabel" style="width: 15%" nowrap>需重建房屋（间）:</td>
				<td class="FieldInput" style="width: 35%"><input type="text"
					id="rebuildHouse" name="rebuildHouse" field="rebuildHouse" title="需重建房屋（间）" 
					onchange="CheckTxt('rebuildHouse','需重建房屋');"/></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%" nowrap>需修缮房屋（间）:</td>
				<td class="FieldInput" style="width: 35%" colspan="3"><input type="text"
					id="repairedHouse" name="repairedHouse" field="repairedHouse" title="需修缮房屋（间）" 
					onchange="CheckTxt('repairedHouse','需修缮房屋');"/></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%" nowrap>核准重建间数（间）:</td>
				<td class="FieldInput" style="width: 35%"><input type="text"
					id="approvalRebuiledHouse" name="approvalRebuiledHouse" field="approvalRebuiledHouse"
					title="核准重建间数（间）" onchange="CheckTxt('approvalRebuiledHouse','核准重建间数');"/></td>
				<td class="FieldLabel" style="width: 15%" nowrap>核准修缮间数（间）:</td>
				<td class="FieldInput" style="width: 35%"><input type="text"
					id="approvalRepairedHouse" name="approvalRepairedHouse" 
					field="approvalRepairedHouse" title="核准修缮间数（间）" 
					onchange="CheckTxt('approvalRepairedHouse','核准修缮间数');"/></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%" nowrap>核准补助资金（元）:</td>
				<td class="FieldInput" style="width: 35%" colspan="3"><input type="text"
					id="approvalMoney" name="approvalMoney" field="approvalMoney" 
					title="核准补助资金（元）" onchange="CheckTxt('approvalMoney','核准补助资金');"/>
					<font color="red">*</font></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%" nowrap>发放单位:</td>
				<td class="FieldInput" style="width: 35%"><select
					id="grantType" name="grantType" field="grantType" title="发放单位" disabled="disabled">
					<option dataset="DisGrantType"></option>
				</select></td>
				<td class="FieldLabel" style="width: 15%" nowrap>发放方式:</td>
				<td class="FieldInput" style="width: 35%"><select
					id="allocationType" name="allocationType" field="allocationType"
					title="发放方式" disabled="disabled">
					<option dataset="DisAllocationType"></option>
				</select> <font color="red">*</font></td>
			</tr>
			<tr id="yhTr">
				<td class="FieldLabel" style="width: 15%" nowrap>开户银行:</td>
				<td class="FieldInput" style="width: 35%"><input type="text"
					name="bank" field="bank" title="开户银行" /></td>
				<td class="FieldLabel" style="width: 15%" nowrap>开户银行帐号:</td>
				<td class="FieldInput" style="width: 35%"><input type="text"
					name="accountCode" field="accountCode" title="开户银行帐号" /></td>
			</tr>
			<tr id="yhTr2">
				<td class="FieldLabel" style="width: 15%" nowrap>开户银行地址:</td>
				<td class="FieldInput" style="width: 35%" colspan="3"><input
					type="text" name="bankAdds" field="bankAdds" title="开户银行地址"
					style="width: 71.5%" /></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%" nowrap>村级填报人姓名:</td>
				<td class="FieldInput" style="width: 35%"><input type="text"
					id="acceptPeopleName" name="acceptPeopleName"
					field="acceptPeopleName" title="村级填报人姓名"
					onchange="checkCN('acceptPeopleName','村级填报人姓名');" /> <font
					color="red">*</font></td>
				<td class="FieldLabel" style="width: 15%" nowrap>村级填报日期:</td>
				<td class="FieldInput" style="width: 35%"><input type="text"
					name="acceptDate" field="acceptDate" title="村级填报日期" format="Y-m-d"
					maxlength="10" onpropertychange="changeDateStyle(this)"
					style="width: 25%" /><img
					src="../../../../../skins/images/default/rl.gif" align="middle"
					onclick="getTimes(this)" /><font color="red">*</font></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%" nowrap>备注:</td>
				<td class="FieldInput" style="width: 35%" colspan="3" rowspan="2">
				<textarea name="note" field="note" title="备注" style="width: 71.5%"></textarea></td>
			</tr>
		</table>
		</form>
		</fieldset>
	</next:Html>
</next:Panel>
</body>
</html>
