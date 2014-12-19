<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>增加投诉人数</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="assistanceInsert.js"></script>
<script type="text/javascript" src="complaintUpdate.js"></script>
<script type="text/javascript" src="../jtxx/IDCard.js"></script>
<script type="text/javascript" src="../jtxx/jtxxComm.js"></script>
</head>
<body >
<model:datasets>
	<model:dataset  id="complaintDataset" cmd="com.inspur.sdmz.apply.cmd.SamApplyQueryCmd" method="samapplyUpdate">
		<model:record fromBean="com.inspur.sdmz.apply.data.SamApply"></model:record>
		<model:params>
			<model:param name="APPLY_ID" value='<%=request.getParameter("applyId")%>'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="sftyDataset" enumName="AGREE_STATE.TYPE"  autoLoad="true" global="true"></model:dataset>
	<model:dataset id="applywayDataset" enumName="APPLY_WAY.TYPE"  autoLoad="true" global="true"></model:dataset>
	<model:dataset id="xbdmDataset" enumName="APPLY_SEX.TYPE"  autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel width="800" title="投诉服务办理单">
	<next:Panel>
	<next:Html>
		<form name="complaintform" id="complaintform" method="post" dataset="complaintDataset" onsubmit="return false" class="L5form">
		<table width="100%">
			<tr>
				<td colspan="4" align="center"><font size="20" >投诉业务变更</font></td>
			</tr>
			<tr>
				<td class="FieldLabel">投诉人:</td>
				<td class="FieldInput"> <input type="text" name="applyPeople" field="applyPeople"  onchange="checkCN('applyPeople','applyIdcard','投诉人');"/><font color="red">*</font></td>
				<td class="FieldLabel">性别: </td>
				<td class="FieldInput"><input type="radio" name="applySex" field="applySex" dataset="xbdmDataset" /></td>
			</tr>
			<tr>
				<td class="FieldLabel">身份证号: </td>
				<td class="FieldInput"><input type="text" name="applyIdcard" field="applyIdcard" style="width: 140px"  onchange="checkIDCardJzfa('applyIdcard','身份证');"/><font color="red">*</font></td>
				<td class="FieldLabel">投诉方式: </td>
				<td class="FieldInput">
					<select name="applyWay" field="applyWay" ><option dataset="applywayDataset"></option></select><font color="red">*</font>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel">联系电话: </td>
				<td class="FieldInput"><input type="text"  name="applyTel" field="applyTel" onchange="checkDhhm()"/></td>
				<td class="FieldLabel">联系地址: </td>
				<td class="FieldInput"><input type="text" name="applyAdd" field="applyAdd" maxlength="100"/> </td>
			</tr>
			<tr>
				<td class="FieldLabel">投诉日期: </td>
				<td class="FieldInput"><input type="text" id="applyDate" name="applyDate" field="applyDate" disabled="disabled"/> </td>
				<td class="FieldLabel">受理单位: </td>
				<td class="FieldInput"><input type="text" id="currentOrgName" name="currentOrgName" field="currentOrgName" disabled="disabled"/></td>
			</tr>
			<tr>
				<td class="FieldLabel">被投诉单位（人）: </td>
				<td colspan="3" class="FieldInput"><input type="text" name="complaintedOrg" field="complaintedOrg" maxlength="100"/></td>
			</tr>
			<tr>	
				<td class="FieldLabel">投诉内容:<br>
					<font color="red" size="1">*不得超过250字</font></td>
				<td colspan="3" class="FieldInput"><textarea name="applyReasons" field="applyReasons" cols="100" rows="5" onchange="checkTextarea(250,'applyReasons')"/></textarea></td>
			</tr>
			<tr>
				<td class="FieldLabel">办理人:</td>
				<td colspan="3" class="FieldInput"><input type="text" name="currentHanPeo" field="currentHanPeo" disabled="disabled"/></td>
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
