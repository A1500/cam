<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>新建补录救助任务</title>
<next:ScriptManager />
<script type="text/javascript" src="batch_info_insert.js"></script>
<script type="text/javascript">
   var organCode = '<%=BspUtil.getOrganCode()%>';
   var organName = '<%=BspUtil.getOrganName()%>';
   var userName = '<%=BspUtil.getEmpOrgan().getOrganName()%>';
</script>
</head>
<body>
<model:datasets>	
	<!--批次-->
	<model:dataset id="batchds"
		cmd="com.inspur.cams.dis.base.cmd.DisReliefBatchQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisReliefBatch">
			<model:field type="string" name="year" rule="require"/>
			<model:field type="string" name="reliefType" rule="require"/>
			<model:field type="string" name="batchName" rule="require"/>
			<model:field type="string" name="grantType" rule="require"/>
			<model:field type="string" name="allocationType" rule="require"/>
			<model:field type="string" name="createPerson" rule="require"/>
			<model:field type="string" name="createOrgan" rule="require"/>
			<model:field type="string" name="areaName" rule="require"/>
		</model:record>
	</model:dataset>
	<!--救助类型-->
	<model:dataset id="ReliefTypeDataset" enumName="DIS.ALLOCATION_PURPOSE"
		autoLoad="true" global="true"></model:dataset>
	<!--发放单位-->
	<model:dataset id="grantTypeDataset" enumName="DIS.GRANT_TYPE"
		autoLoad="true" global="true"></model:dataset>
	<!--发放方式-->
	<model:dataset id="allocationTypeDataset"
		enumName="DIS.INFO_ALLOCATION_TYPE" autoLoad="true" global="true"></model:dataset>
	<!--冬春救灾本年度批次-->
	<model:dataset id="dcReliefBatchDs"
		enumName="DIS.DC_RELIEF_BATCH" autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:ViewPort>
	<next:AnchorLayout>
		<next:Panel title="救助任务">
			<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="save" text="保存并下发救助任务" handler="save" />
			</next:TopBar>
			<next:Html>
				<form id="BatchForm" method="post" dataset="batchds"
					onsubmit="return false" class="L5form">
				<table border="1" width="100%">
					<tr>
						<td class="FieldLabel" width="17%">年度</td>
						<td class="FieldInput" width="33%"><input type="text" format="Y"
							style="width: 100px;" name="year" field="year" maxlength="4"
							id="year" title="年度"/> <font color="red">*</font></td>
						<td class="FieldLabel" width="17%">任务名称</td>
						<td class="FieldInput" width="33%"><input type="text" name="batchName"
							field="batchName" style="width: 230px" maxlength="50" title="任务名称"/> <font color="red">*</font></td>
					</tr>
					<tr>
						<td class="FieldLabel">救助类型</td>
						<td class="FieldInput"><select name="reliefType"
							field="reliefType" style="width: 200px" title="救助类型" onchange="onChange(this)"/>
							<option dataset="ReliefTypeDataset"></option>
						</select><font color="red">*</font></td>
						<td class="FieldLabel"><label id="dcLabel" >本年度批次</label></td>
						<td class="FieldInput"><select id="dcSelect" name="dcReliefBatch"
							field="dcReliefBatch" title="本年度批次"/>
							<option dataset="dcReliefBatchDs"></option>
						</select></td>
					</tr>
					<tr>
						<td class="FieldLabel">发放方式</td>
						<td class="FieldInput"><select name="allocationType"
							field="allocationType" title="发放方式"/>
							<option dataset="allocationTypeDataset"></option>
						</select> <font color="red">*</font></td>
						<td class="FieldLabel">发放单位</td>
						<td class="FieldInput"><select name="grantType"
							field="grantType" title="发放单位"/>
							<option dataset="grantTypeDataset"></option>
						</select><font color="red">*</font></td>
					</tr>
					<tr>
						<td class="FieldLabel">创建人</td>
						<td class="FieldInput"><label field="createPerson" /></td>
						<td class="FieldLabel">创建单位</td>
						<td class="FieldInput"><label field="createOrgan" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">需填报单位</td>
						<td class="FieldInput" colspan="3"><textarea rows="2"
							name="areaName" readonly="readonly" field="areaName"
							style="width: 90%" title="需填报单位"></textarea> <input type="hidden"
							id="areaCode" name="areaCode" field="areaCode" /> <img
							src="<%=SkinUtils.getImage(request,"l5/help.gif")%>"
							style="cursor: hand" onclick="forOrganSelect()" /><font
							color="red">*</font></td>
					</tr>
					<tr>
						<td class="FieldLabel"></td>
						<td class="FieldInput" colspan="3"><font
							color="red">补录信息请谨慎填写，保存后不能删除！</font></td>
					</tr>
				</table>
				</form>
			</next:Html>
		</next:Panel>
	</next:AnchorLayout>
</next:ViewPort>
</body>
</html>
