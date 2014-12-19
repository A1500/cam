<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<html>
<head>
<title>灾区民房恢复重建</title>
<%
    String ifDetail = request.getParameter("ifDetail");
%>
<next:ScriptManager />
<script language="javascript">
	var organCode = '<%=BspUtil.getOrganCode()%>';
	var organName = '<%=BspUtil.getOrganName()%>';
	var method = '<%=request.getParameter("method")%>';
	var batchId='<%=request.getParameter("batchId")%>';
	var batchDetailId='<%=request.getParameter("batchDetailId")%>';
	var infoId='<%=request.getParameter("infoId")%>';
	var uu32='<%=IdHelp.getUUID32()%>';
	var uu321='<%=IdHelp.getUUID32()%>';
</script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="../../comm/disComm.js"></script>
<script type="text/javascript" src="cjDoleGoodsRollEdit.js"></script>
</head>
<body>
<model:datasets>
	<!-- 批次信息 -->
	<model:dataset id="batchDs"
		cmd="com.inspur.cams.dis.base.cmd.DisReliefBatchQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisReliefBatch">
		</model:record>
	</model:dataset>
	<model:dataset id="disDetailBatchSourceDs"
		cmd="com.inspur.cams.dis.base.cmd.DisDetailBatchSourceQueryCmd"
		method="queryDisDetailBatchSource" pageAble="false">
		<model:record
			fromBean="com.inspur.cams.dis.base.data.DisDetailBatchSource"></model:record>
	</model:dataset>
	<!-- 档案信息 -->
	<model:dataset id="infoDs"
		cmd="com.inspur.cams.dis.base.cmd.DisReliefInfoQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisReliefInfo">
		</model:record>
	</model:dataset>
	<!-- 发放明细表 -->
	<model:dataset id="doleDetailDs" cmd="com.inspur.cams.dis.base.cmd.DisReliefDoleDetailQueryCmd"
		global="true" pageSize="100">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisReliefDoleDetail">
		</model:record>
	</model:dataset>
	<model:dataset id="disReliefDoleMeteDetailDs" cmd="com.inspur.cams.dis.base.cmd.DisReliefDoleMeteDetailQueryCmd"
		global="true" pageSize="100">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisReliefDoleMeteDetail">
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
	<!-- 户口类型 -->
	<model:dataset id="DisFamilyRegister" enumName="DIS.FAMILY_REGISTER"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 发放单位  -->
	<model:dataset id="DisGrantType" enumName="DIS.GRANT_TYPE"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 灾害种类 -->
	<model:dataset id="DisDisasterType"
		enumName="DIS.DISASTER_TYPE" autoLoad="true" global="true">
	</model:dataset>
	<!-- 发放物资类型-->
	<model:dataset id="dmDisMaterialTypeDs"
		cmd="com.inspur.cams.dis.base.cmd.DicDisMaterialTypeQueryCmd"
		autoLoad="true" pageAble="false" global="true">
		<model:record
			fromBean="com.inspur.cams.dis.base.data.DicDisMaterialType">
			<model:field name="value" mapping="code" type="string" />
			<model:field name="text" mapping="name" type="string" />
		</model:record>
	</model:dataset>
</model:datasets>
<next:Panel width="100%" height="65%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<%if(!"1".equals(ifDetail)){ %>
		<next:ToolBarItem text="保存" iconCls="save" handler="save"/>
		<%} %>
		<next:ToolBarItem iconCls="return" text="关闭" handler="back" />
	</next:TopBar>

	<next:Html>
		<fieldset>
		<form id="cjForm" method="post" dataset="infoDs"
			onsubmit="return false" class="L5form">
		<table border="0" width="100%" cellspacing="0" cellpadding="0">
			<tr>
				<td class="FieldLabel" style="width: 15%" nowrap>户主姓名:</td>
				<td class="FieldInput" style="width: 35%"><label field="name" /></td>
				<td class="FieldLabel" style="width: 15%" nowrap>身份证号码:</td>
				<td class="FieldInput" style="width: 35%"><label field="idCard"/></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%" nowrap>家庭人口（人）:</td>
				<td class="FieldInput" style="width: 35%"><label  field="familyNum"/></td>
				<td class="FieldLabel" style="width: 15%" nowrap>家庭类型:</td>
				<td class="FieldInput" style="width: 35%"><label field="familyType"  dataset="DisFamilyType"/></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%" nowrap>户口类型:</td>
				<td class="FieldInput" style="width: 35%"><label field="familyRegister" dataset="DisFamilyRegister" /></td>
				<td class="FieldLabel" style="width: 15%" nowrap>行政村（社区）:</td>
				<td class="FieldInput" style="width: 35%"><label field="acceptAreaName" /></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%" nowrap>房屋间数（间）:</td>
				<td class="FieldInput" style="width: 35%"><label field="houseCount" /></td>
				<td class="FieldLabel" style="width: 15%" nowrap>房屋结构:</td>
				<td class="FieldInput" style="width: 35%"><label field="houseStructure" dataset="DisHouseStructure"/></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%" nowrap>受灾时间:</td>
				<td class="FieldInput" style="width: 35%"><label field="damageTime" /></td>
				<td class="FieldLabel" style="width: 15%" nowrap>灾害种类:</td>
				<td class="FieldInput" style="width: 35%"><label field="disasterType" dataset="DisDisasterType"/></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%" nowrap>倒塌房屋（间）:</td>
				<td class="FieldInput" style="width: 35%"><label field="collapsedHouse"/></td>
				<td class="FieldLabel" style="width: 15%" nowrap>严重损坏房屋（间）:</td>
				<td class="FieldInput" style="width: 35%"><label field="seriousDamageHouse" /></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%" nowrap>一般损坏房屋（间）:</td>
				<td class="FieldInput" style="width: 35%" ><label field="generalDamageHouse" /></td>
				<td class="FieldLabel" style="width: 15%" nowrap>需重建房屋（间）:</td>
				<td class="FieldInput" style="width: 35%"><label field="rebuildHouse" /></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%" nowrap>需修缮房屋（间）:</td>
				<td class="FieldInput" style="width: 35%"><label field="repairedHouse" /></td>
				<td class="FieldLabel" style="width: 15%" nowrap>核准重建间数（间）:</td>
				<td class="FieldInput" style="width: 35%"><label field="approvalRebuiledHouse" /></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%" nowrap>核准修缮间数（间）:</td>
				<td class="FieldInput" style="width: 35%"><label field="approvalRepairedHouse"/></td>
				<td class="FieldLabel" style="width: 15%" nowrap>核准补助资金（元）:</td>
				<td class="FieldInput" style="width: 35%"><label field="approvalMoney" /></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%" nowrap>发放单位:</td>
				<td class="FieldInput" style="width: 35%"><label field="grantType" dataset="DisGrantType"/></td>
				<td class="FieldLabel" style="width: 15%" nowrap>发放方式:</td>
				<td class="FieldInput" style="width: 35%"><label field="allocationType" dataset="DisAllocationType"/></td>
			</tr>
			<tr id="yhTr">
				<td class="FieldLabel" style="width: 15%" nowrap>开户银行:</td>
				<td class="FieldInput" style="width: 35%"><label field="bank"/></td>
				<td class="FieldLabel" style="width: 15%" nowrap>开户银行帐号:</td>
				<td class="FieldInput" style="width: 35%"><label field="accountCode"/></td>
			</tr>
			<tr id="yhTr2">
				<td class="FieldLabel" style="width: 15%" nowrap>开户银行地址:</td>
				<td class="FieldInput" style="width: 35%"  colspan="3"><label field="bankAdds"/></td>
			</tr>
		</table>
		</form>
		</fieldset>
	</next:Html>
</next:Panel>
<next:EditGridPanel id="grid" width="100%" height="240"
				dataset="disDetailBatchSourceDs">
				<next:TopBar>
					<next:ToolBarItem text="总物资"></next:ToolBarItem>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
				</next:TopBar>
				<next:Columns>
					<next:RowNumberColumn></next:RowNumberColumn>
					<next:Column header='物资类型' field="meterialType"
						renderer="meterialTypeRenderer" width="130">
						<next:TextField editable="false" />
					</next:Column>
					<next:Column header="物资单位" field="meterialUnit" align="center"
						width="80">
						<next:TextField editable="false" />
					</next:Column>
					<next:Column header="物资数量" field="meterialNumBalance"
						align="right" width="120">
						<next:TextField editable="false" />
					</next:Column>
					<next:Column id="meterialNumPay" header="实际使用数量"
						field="meterialNumPay" width="120" align="right">
						<next:TextField />
					</next:Column>
				</next:Columns>
</next:EditGridPanel>
</body>
</html>
