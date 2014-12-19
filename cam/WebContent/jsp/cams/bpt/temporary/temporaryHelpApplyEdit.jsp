<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<html>
<head>
<title>临时救助县级审核编辑</title>
<next:ScriptManager />
<script>
			var peopleId='<%=request.getParameter("peopleId")%>';
			var applyId='<%=request.getParameter("applyId")%>';
			var method='<%=request.getParameter("method")%>';
			var organType = '<%=BspUtil.getOrganType()%>';
			var currentUserName = '<%= GetBspInfo.getBspInfo().getUserName()%>';
		</script>
<script type="text/javascript" src="temporaryHelpApplyEdit.js"></script>
<script type="text/javascript" src = "../comm/bptComm.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="ds"
		cmd="com.inspur.cams.bpt.manage.cmd.BptTemporaryHelpQueryCommand"
		global="true" method="queryUpdateTemporaryHelp">
		<model:record
			fromBean="com.inspur.cams.bpt.base.data.BptTemporaryHelp">
			</model:record>
	</model:dataset>
	<!--救助类别-->
	<model:dataset id="dsHelp" enumName="HELP.TYPE" autoLoad="true"></model:dataset>
	<!-- 优抚对象类别-->
	<model:dataset id="objectDs"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BPT_OBJECT_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 民族 -->
	<model:dataset id="NationDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 性别 -->
	<model:dataset id="SexDataset" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:Panel autoHeight="true" autoWidth="true" autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="save" />
		<next:ToolBarItem iconCls="view" id="submitButton" text="审批" handler="createSend"/>
	</next:TopBar>
	<next:Html>
		<form id="editForm" dataset="ds" onsubmit="return false"
			style="padding: 5px;" class="L5form">
		<table border="1" width="100%">
			<tr>
				<td class="FieldLabel" rowspan="2" nowrap>村（居）意见:</td>
				<td class="FieldLabel" width="8%" nowrap>负责人:</td>
				<td class="FieldInput" width="30%"><input type="text" name="checkIncharge" field="checkIncharge" /><font color="red">*</font></td>
			    <td  class="FieldLabel" nowrap>审核时间:</td>
				<td class="FieldInput"><input type="text" name="checkDate" id="checkDate"field="checkDate"  format="Y-m-d" style="width: 100px;" maxlength="10" onpropertychange="changeDateStyle(this)"/><img  src="../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ><font color="red">*</font> </td>
			</tr>
			<tr>
				<td class="FieldLabel" nowrap>审核意见:</td>
				<td colspan="3"><textarea rows="2" cols="136"
					name="checkAdvice" field="checkAdvice"></textarea><font
					color="red">*</font></td>
			</tr>
			<tr>
				<td class="FieldLabel" rowspan="2" nowrap>乡镇（街道办）意见:</td>
				<td class="FieldLabel" width="8%" nowrap>责任人:</td>
				<td class="FieldInput" width="30%"><input type="text" name="auditIncharge" field="auditIncharge" /><font color="red">*</font></td>
				<td  class="FieldLabel" nowrap>审核时间:</td>
				<td class="FieldInput"><input type="text" name="auditDate"id="auditDate" field="auditDate"  format="Y-m-d" style="width: 100px;" maxlength="10" onpropertychange="changeDateStyle(this)"/><img  src="../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ><font color="red">*</font> </td>
			</tr>
			<tr>
				<td class="FieldLabel" nowrap>审核意见:</td>
				<td colspan="3"><textarea rows="2" cols="136"name="auditAdvice" field="auditAdvice"></textarea><font color="red">*</font></td>
			</tr>
			<tr>
				<td class="FieldLabel" rowspan="2" nowrap>县级民政部门意见:</td>
				<td class="FieldLabel" width="8%" nowrap>负责人:</td>
				<td class="FieldInput" width="30%"><input type="text" name="verifyIncharge" field="verifyIncharge" /><font color="red">*</font></td>
				<td  class="FieldLabel" nowrap>审批时间:</td>
				<td class="FieldInput"><input type="text" name="verifyDate"id="verifyDate" field="verifyDate"  format="Y-m-d" style="width: 100px;" maxlength="10" onpropertychange="changeDateStyle(this)"/><img  src="../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ><font color="red">*</font> </td>
			</tr>
			<tr>
				<td class="FieldLabel" nowrap>审批意见:</td>
				<td colspan="3"><textarea rows="2" cols="136"name="verifyAdvice" field="verifyAdvice"></textarea><font color="red">*</font></td>
			</tr>
            <input type="hidden" name="domicileCode" field="domicileCode" />
		</table>
		</form>
	</next:Html>
</next:Panel>

</body>
</html>
