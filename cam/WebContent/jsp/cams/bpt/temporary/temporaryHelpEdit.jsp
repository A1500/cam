<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.bsp.security.context.GetBspInfo"%>
<html>
<head>
<title>临时救助申请业务受理编辑</title>
<next:ScriptManager />
<script>
			var peopleId='<%=request.getParameter("peopleId")%>';
			var applyId='<%=request.getParameter("applyId")%>';
			var method='<%=request.getParameter("method")%>';
			var currentUserName = '<%= GetBspInfo.getBspInfo().getUserName()%>';
		</script>
<script type="text/javascript" src="temporaryHelpEdit.js"></script>
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
		<next:ToolBarItem iconCls="print" text="生成" handler="print" />
	</next:TopBar>
	<next:Html>
		<form id="editForm" dataset="ds" onsubmit="return false"
			style="padding: 5px;" class="L5form">
		<table border="1" width="100%">
			<tr>
				<input type="hidden" name="peopleId" field="peopleId" />
				<td class="FieldLabel" colspan="2" nowrap>姓名:</td>
				<td class="FieldInput"><label type="text" name="name"
					field="name" /></td>
				<td class="FieldLabel" nowrap>性别:</td>
				<td class="FieldInput"><label id="sex" name="sex" field="sex" dataSet="SexDataset">
					</td>
			</tr>
			<tr>
				<td class="FieldLabel" colspan="2" nowrap>年龄:</td>
				<td class="FieldInput"><label type="text" name="age" field="age" /></td>
				<td class="FieldLabel" nowrap>民族:</td>
				<td class="FieldInput"><label id="nation" name="nation" dataSet="NationDataset" field="nation">
					<font color="red">*</font></td>
			</tr>
			<tr>
				<td class="FieldLabel" colspan="2" nowrap>优抚对象类别:</td>
				<td class="FieldInput"><label id="objectType"
					name="objectType" field="objectType"  dataSet="objectDs">
					<font color="red">*</font></td>
				<td class="FieldLabel" nowrap>家庭人口:</td>
				<td class="FieldInput"><label type="text" name="familyNum"
					field="familyNum"  /></td>
			</tr>
			<tr>
					<td class="FieldLabel" colspan="2" nowrap>身份证号码:</td>
				<td class="FieldInput"><label type="text" name="idCord"
					field="idCord" /><font color="red">*</font></td>
                <td class="FieldLabel"  nowrap>家庭住址:</td>
				<td class="FieldInput"><label name="address" field="address"
					rows="2" cols="40" ></label></td>
			</tr>
			<tr>
				<td class="FieldLabel" colspan="2" nowrap>救助类别:</td>
				<td class="FieldInput"><select id="helpType" name="helpType"
					field="helpType">
					<option dataSet="dsHelp" />
				</select><font color="red">*</font></td>
				
				<td class="FieldLabel" nowrap>申请救助金额:</td>
				<td class="FieldInput"><input type="text" name="applyMon"
					field="applyMon" /></td>
			</tr>
			<tr>
				<td class="FieldLabel" colspan="2" nowrap>申请事由:</td>
				<td colspan="3"><textarea rows="2" cols="136" id="applySubject"
					name="applySubject" field="applySubject"></textarea><font
					color="red">*</font>
					</td>
			</tr>
			<tr>
				<td class="FieldLabel" colspan="2">备注</td>
				<td class="FieldInput" colspan="3"><textarea rows="2"
					cols="136" name="note" field="note"></textarea></td>
			</tr>
            <input type="hidden" name="domicileCode" field="domicileCode" />
		</table>
		<input type="hidden" id="docpath" value="jsp/cams/bpt/temporary/table/temp_apptable.doc"/>
		<input type="hidden" id="peopleId" name="printQuery" queryData="queryData" value="<%=request.getParameter("peopleId")%>"/>
		<input type="hidden" id="scaconfPath" value="tempApp/tempAppPrintDao"/>
		</form>
	</next:Html>
</next:Panel>

</body>
</html>
