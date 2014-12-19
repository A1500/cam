<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
	<head>
		<title></title>
		<next:ScriptManager></next:ScriptManager>
		<script type="text/javascript" src="assistanceInsert.js"></script>
		<script type="text/javascript" src="assistanceUpdate.js"></script>
		<script type="text/javascript" src="../jtxx/IDCard.js"></script>
		<script type="text/javascript" src="../jtxx/jtxxComm.js"></script>
	</head>
<body>
<model:datasets>
	<model:dataset  id="applyDataset" cmd="com.inspur.sdmz.apply.cmd.SamApplyQueryCmd" method="samapplyUpdate">
		<model:record fromBean="com.inspur.sdmz.apply.data.SamApply"></model:record>
		<model:params>
			<model:param name="APPLY_ID" value='<%=request.getParameter("applyId")%>'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset  id="sjdwDataset" cmd="com.inspur.sdmz.apply.cmd.SamApplyCmd" autoLoad="true" method="querySjdw">
		<model:record fromBean="com.inspur.sdmz.apply.data.SamApply"></model:record>
	</model:dataset>
	<model:dataset  id="pjdwDataset" cmd="com.inspur.sdmz.apply.cmd.SamApplyCmd" autoLoad="true" method="queryPjdw">
		<model:record fromBean="com.inspur.sdmz.apply.data.SamApply"></model:record>
	</model:dataset>
	<model:dataset id="sftyDataset" enumName="AGREE_STATE.TYPE"  autoLoad="true" global="true"></model:dataset>
	<model:dataset id="applywayDataset" enumName="APPLY_WAY.TYPE"  autoLoad="true" global="true"></model:dataset>
	<model:dataset id="xbdmDataset" enumName="APPLY_SEX.TYPE"  autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel width="800">
		<next:Panel title="救助服务办理单">
			<next:Html>
			<form id="applyForm" method="post" dataset="applyDataset" onsubmit="return false" class="L5form">
			<table width="100%">
				<tr>
				<td colspan="4" align="center"><font size="20" >救助业务变更</font></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label>申请人:</label></td>
					<td class="FieldInput"><input type="text" name="applyPeople" field="applyPeople" onchange="checkCN('applyPeople','applyIdcard','申请人');"/><font color="red">*</font></td>
					<td class="FieldLabel"><label>身份证号:</label></td>
					<td class="FieldInput"><input type="text" name="applyIdcard" field="applyIdcard" style="width: 140px" onchange="checkIDCardJzfa('applyIdcard','身份证');"/><font color="red">*</font></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label>家庭人口:</label></td>
					<td class="FieldInput"><input type="text" name="applyPeopleNum" field="applyPeopleNum"  maxlength="50" style="width: 30px" onchange="CheckJtrk()"/><font color="red">*</font></td>
					<td class="FieldLabel"><label>家庭成员:</label></td>
					<td class="FieldInput"><input type="text" name="familyMember" field="familyMember" /></td>
				</tr>
				<tr>					
					<td class="FieldLabel"><label>联系电话:</label></td>
					<td class="FieldInput"><input type="text" name="applyTel" field="applyTel" onchange="checkDhhm()"/></td>
					<td class="FieldLabel"><label>申请方式:</label></td>
					<td class="FieldInput"><select name="applyWay" field="applyWay" ><option dataset="applywayDataset"></option></select><font color="red">*</font></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label>性别:</label></td>
					<td colspan="3" class="FieldInput"><input type="radio" name="applySex" field="applySex" dataset="xbdmDataset" /></td>
				</tr>	
				<tr>
					<td class="FieldLabel"><label>家庭住址:</label></td>
					<td colspan="3" class="FieldInput"><input type="text"  name="applyAdd" field="applyAdd" style="width: 500px" /></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label>申请日期:</label></td>
					<td class="FieldInput"><input type="text" name="applyDate" field="applyDate"  disabled="disabled"/></td>
					<td class="FieldLabel"><label>受理单位:</label></td>
					<td class="FieldInput"><input type="text" name="currentOrgName" field="currentOrgName" disabled="disabled"/></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label>申请事由:</label></td>
					<td colspan="3" class="FieldInput"><textarea  name="applyReasons" field="applyReasons" cols="100" rows="5" /></textarea></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label>受理人姓名:</label></td>
					<td colspan="3" class="FieldInput"><input type="text" name="currentHanPeo" field="currentHanPeo"  disabled="disabled"/></td>
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
