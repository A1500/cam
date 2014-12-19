
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>医前救助编辑</title>
<next:ScriptManager />
<script>
	var idField='<%=request.getParameter("dataBean")%>';
	var method='<%=request.getParameter("method")%>';
	var organId='<%=BspUtil.getCorpOrgan().getOrganId()%>'
	var organCode='<%=BspUtil.getCorpOrgan().getOrganCode()%>';
	var userId='<%=BspUtil.getEmpOrgan().getOrganId()%>'
	var userName='<%=BspUtil.getEmpOrgan().getOrganName()%>';
</script>
<script type="text/javascript" src="samMBeforeEdit.js"></script>
<script type="text/javascript" src="samMBalanceComm.js"></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
</head>
<body>
<model:datasets>
	<model:dataset id="ds"
		cmd="com.inspur.cams.drel.mbalance.cmd.SamMedicalBeforeQueryCmd"
		global="true">
		<model:record
			fromBean="com.inspur.cams.drel.mbalance.data.SamMedicalBefore"></model:record>
	</model:dataset>
	<!-- 医前救助校验 -->
	<model:dataset id="beforeCheckDS"
		cmd="com.inspur.cams.drel.mbalance.cmd.SamMedicalBeforeQueryCmd"
		global="true">
		<model:record
			fromBean="com.inspur.cams.drel.mbalance.data.SamMedicalBefore"></model:record>
	</model:dataset>
	<!-- 个人信息 -->
	<model:dataset id="BaseinfoPeopleDataSet"
		cmd="com.inspur.cams.drel.sam.cmd.BaseinfoPeopleQueryCmd" global="true">
		<model:record
			fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople"></model:record>
	</model:dataset>
	<!-- 病种 -->
	<model:dataset id="diseaseDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_DISEASE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 医前救助使用状态 -->
	<model:dataset id="assBeforeStatusDataset" enumName="ASSISTANCE_BEFORE_STATUS"
		autoLoad="true">
	</model:dataset>
</model:datasets>
<next:ViewPort>
	<next:AnchorLayout>
		<next:Panel title="医前救助">
			<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="save" text="保存" handler="save" />
				<next:ToolBarItem iconCls="undo" text="返回" handler="back" />
			</next:TopBar>
			<next:Html>
				<form id="editForm" dataset="ds" onsubmit="return false"
					style="padding: 5px;" class="L5form">
				<table border="1" width="100%">

					<tr>
						<td class="FieldLabel" width="15%" >身份证件号码</td>
						<td class="FieldInput" width="35%" ><input id="idCard" type="text" style="width:60%" 
							name="身份证件号码" field="idCard" onblur="loadBeforeAssMsg()" /><font
							color="red">*</font></td>

						<td class="FieldLabel" width="15%" >姓名</td>
						<td class="FieldInput" width="35%"><label id="name" maxlength="25" type="text" name="姓名" style="width:45%" 
							field="name" /></td>
					<tr>
						<td class="FieldLabel">病种</td>
						<td class="FieldInput"><select name="病种" field="disease" style="width:60%" >
						<option dataset="diseaseDataset"></option>
					</select><font color="red">*</font></td>
						<td class="FieldLabel">救助金额（元）</td>
						<td class="FieldInput"><input type="text" maxlength="16" name="救助金额" id="assitanceMon" onblur="checkAssMon(this.id)" style="width:45%" 
							field="assitanceMon" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">审批日期</td>
						<td class="FieldInput"><input type="text" name="auditDate" style="width:60%" 
					id="auditDate" format="Y-m-d" field="auditDate" title="审批日期" readonly="readonly"
					onclick="LoushangDate(this)"></td>
						<td class="FieldLabel">使用状态</td>
						<td class="FieldInput"><select id="status" name="使用状态" field="status" style="width:45%" >
					<option dataset="assBeforeStatusDataset"></option>
				</select></td>
					</tr>
					<tr>
						<td class="FieldLabel">经办人</td>
						<td class="FieldInput"><input type="text" maxlength="15" name="经办人" style="width:60%" 
							field="manager" /></td>
						<td class="FieldLabel"></td>
						<td class="FieldInput"></td>
							
							
					</tr>

				</table>
				</form>
			</next:Html>
		</next:Panel>
	</next:AnchorLayout>
</next:ViewPort>
</body>
</html>
