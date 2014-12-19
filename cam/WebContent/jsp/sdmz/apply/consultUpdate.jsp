<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>救助业务受理</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="assistanceInsert.js"></script>
<script type="text/javascript" src="consultUpdate.js"></script>
<script type="text/javascript" src="../jtxx/IDCard.js"></script>
<script type="text/javascript" src="../jtxx/jtxxComm.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="consultDataset"
		cmd="com.inspur.sdmz.apply.cmd.SamApplyQueryCmd" autoLoad="true" method="samapplyUpdate">
		<model:record fromBean="com.inspur.sdmz.apply.data.SamApply"></model:record>
		<model:params>
			<model:param name="APPLY_ID" value='<%=request.getParameter("applyId")%>'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="MoveupDataset"
		cmd="com.inspur.sdmz.apply.cmd.SamApplyCmd" autoLoad="true" method="querySjdw">
		<model:record fromBean="com.inspur.sdmz.apply.data.SamApply"></model:record>
	</model:dataset>
	<model:dataset id="MovehorizonDataset"
		cmd="com.inspur.sdmz.apply.cmd.SamApplyCmd" autoLoad="true" method="queryPjdw">
		<model:record fromBean="com.inspur.sdmz.apply.data.SamApply"></model:record>
	</model:dataset>
	<model:dataset id="SexDataSet" enumName="APPLY_SEX.TYPE" autoLoad="true"
		global="true"></model:dataset>
	<model:dataset id="ConsultDataSet" enumName="APPLY_WAY.TYPE"
		autoLoad="true" global="true"></model:dataset>
	<model:dataset id="HandleMarkDataSet" enumName="HANDLE.MARK"
		autoLoad="true" global="true"></model:dataset>
	<model:dataset id="sftyDataset" enumName="AGREE_STATE.TYPE"
		autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel width="800">

	<next:Panel title="咨询服务办理单">
		<next:Html>
			<form id="consultForm" method="post" dataset="consultDataset"
				onsubmit="return false" class="L5form">
			<table width="100%">
				<tr>
					<td colspan="4" align="center">咨询业务变更</td>
				</tr>
				<tr>
					<td class="FieldLabel"><label>咨询人:</label></td>
					<td class="FieldInput"><input type="text" name="applyPeople"
						field="applyPeople" onchange="checkCN('applyPeople','applyIdcard','咨询人');"/><font color="red">*</font></td>
					<td class="FieldLabel"><label>性别:</label></td>
					<td class="FieldInput"><input type="radio" name="applySex"
						field="applySex" dataset="SexDataSet" /></td>
					
				</tr>

				<tr>
					<td class="FieldLabel"><label>身份证号:</label></td>
					<td class="FieldInput"><input type="text" name="applyIdcard"
						field="applyIdcard" style="width: 140px" onchange="checkIDCardJzfa('applyIdcard','身份证');"/><font color="red">*</font></td>
					
					<td class="FieldLabel"><label>咨询方式:</label></td>
					<td class="FieldInput"><select name="applyWay" field="applyWay" >
						<option dataset="ConsultDataSet"></option>
					</select></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label>联系电话:</label></td>
					<td class="FieldInput"><input type="text" name="applyTel"
						field="applyTel" onchange="checkDhhm()"/></td>
					<td class="FieldLabel"><label>家庭住址:</label></td>
					<td class="FieldInput"><input type="text" name="applyAdd"
						field="applyAdd" maxlength="100" /></td>
				</tr>

				<tr>
					<td class="FieldLabel"><label>咨询日期:</label></td>
					<td class="FieldInput"><input type="text" name="applyDate" field="applyDate" disabled="disabled"/></td>
					<td class="FieldLabel"><label>受理单位:</label></td>
					<td class="FieldInput"><input type="text" name="currentOrgName" field="currentOrgName" disabled="disabled"/></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label>咨询内容:<br/>
					<font color="red" size="1">*不得超过250字</font></label></td>
					<td colspan="3" class="FieldInput"><textarea name="applyReasons"
						field="applyReasons" cols="100" rows="5" onchange="checkTextarea(250,'applyReasons')" /></textarea></td>
				</tr>
				
				<tr>
					<td class="FieldLabel"><label>办理人:</label></td>
					<td class="FieldInput" colspan="3"><input type="text" name="currentHanPeo" field="currentHanPeo" disabled="disabled"/></td>
				</tr>
			</table>
			</form>
		</next:Html>
	</next:Panel>
	<next:Panel border="false" width="500">
		<next:Buttons>
		   		<next:ToolButton  text="确定" handler="Evt_butsave_onclick" ></next:ToolButton>
		   		<next:ToolButton  text="返回" handler="Evt_butreturn_onclick"></next:ToolButton>
		    </next:Buttons>
		</next:Panel>
</next:Panel>
</body>
</html>
