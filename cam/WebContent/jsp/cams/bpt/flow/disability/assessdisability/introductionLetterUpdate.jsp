<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<script type="text/javascript">
   var organCode = '<%=BspUtil.getOrganCode()%>';
   var organCodeSub = organCode.substr(0,6);
</script>
<html>
<head>
<title>鉴定介绍信修改</title>
<next:ScriptManager />
		<script>
			var peopleId='<%=request.getParameter("peopleId")%>';
			var applyId='<%=request.getParameter("applyId")%>';
		</script>
<script type="text/javascript" src="introductionLetterUpdate.js"></script>
<script type="text/javascript" src="../../../comm/bptComm.js"></script>
</head>
<body>
<model:datasets>
	<!-- 残疾情况医学鉴定介绍信 -->
	<model:dataset id="DisabilityIdentiDataset" cmd="com.inspur.cams.bpt.manage.cmd.DisabilityIdentificationQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.DisabilityIdentification">
			<model:field name="domicileName" type="string" />
		</model:record>
	</model:dataset>
	<!-- 性别 -->
	<model:dataset id="SexDataset" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel width="100%" height="100%" autoScroll="true" >
		<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="print" text="生成" handler="print" />
				<next:ToolBarItem iconCls="save" text="保存" handler="saveClick" />
				<next:ToolBarItem iconCls="disable" text="关闭" handler="func_Close"/>
		</next:TopBar>
	<next:Html>
		<form id="editForm"   dataset="DisabilityIdentiDataset" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="99%">
	   		<tr>
				<td class="FieldLabel" colspan="2" width="20%">编号：</td>
				<td class="FieldInput"colspan="5"><input type="text" name="numbering" field="numbering" title="编号" style="width:85%" readonly="readonly"/><font color="red">*</font> </td>
			</tr>
			<tr>
				<td class="FieldLabel" colspan="2" width="20%">鉴定单位：</td>
				<td class="FieldInput" colspan="5"><input type="text" name="identificationUnit" field="identificationUnit" title="鉴定单位" style="width:85%"/><font color="red">*</font> </td>
				
			</tr>
			<tr>
				<td class="FieldLabel" colspan="2" width="20%">介绍单位：</td>
				<td class="FieldInput" colspan="5"><input type="text" name="introductionUnit" field="introductionUnit" title="介绍单位" style="width:85%"/><font color="red">*</font> </td>
			</tr>
			
			<tr>
				<td class="FieldLabel" colspan="2" width="20%">介绍时间：</td>
				<td class="FieldInput"><input type="text" format="Y-m-d" maxlength="10"style="width: 100px;" name="introductionDate" field="introductionDate" title="介绍时间" onpropertychange="changeDateStyle(this)" /><img  src="../../../../../../skins/images/default/rl.gif" align="middle"  onclick="getTimes(this)"  ><font color="red">*</font> </td>
				<td class="FieldLabel"  >鉴定时间：</td>
				<td class="FieldInput" colspan="5"><input type="text" format="Y-m-d" maxlength="10"style="width: 100px;" name="identificationDate" field="identificationDate" title="鉴定时间" onpropertychange="changeDateStyle(this)" /><img  src="../../../../../../skins/images/default/rl.gif" align="middle"  onclick="getTimes(this)"  ></td>
			</tr>
	   		<tr>
				
				<td class="FieldLabel" colspan="2" width="20%">经办人：</td>
				<td class="FieldInput"><input type="text" name="agent" field="agent"  /></td>
				<td class="FieldLabel" >经办人电话：</td>
				<td class="FieldInput" colspan="5"><input type="text" name="agentPhone" field="agentPhone"  /></td>
			</tr>
	   		<tr>
	   			<td class="FieldLabel" rowspan="3">被鉴定人<br/>基本情况</td>
	   			<td class="FieldLabel">姓名：</td>
				<td class="FieldInput"><label name="name" field="name"/></td>
				<td class="FieldLabel">性别：</td>
				<td class="FieldInput"><label name="sex" field="sex" dataset="SexDataset"></label></td>
				<td class="FieldLabel">出生年月：</td>
				<td class="FieldInput"><label name="birthday" field="birthday"/></td>
			</tr>
	   		<tr>
	   			<td class="FieldLabel">身份证号：</td>
				<td class="FieldInput"><label name="idCard" field="idCard"/></td>
				<td class="FieldLabel">户籍地：</td>
				<td class="FieldInput"><label name="domicileName"  title="属地行政区划" field="domicileName"/></td>
				<td class="FieldLabel">住址：</td>
				<td class="FieldInput"><label name="address" field="address"/></td>
			</tr>
	   		<tr>
	   			<td class="FieldLabel" nowrap="nowrap">工作单位名称：</td>
				<td class="FieldInput"><label name="workUnitName" field="workUnitName"/></td>
				<td class="FieldLabel" nowrap="nowrap">受伤时身份：</td>
				<td class="FieldInput"><input type="text" name="injuryStatus" field="injuryStatus"/></td>
				<td class="FieldLabel" nowrap="nowrap">负伤时间：</td>
				<td class="FieldInput"><label name="disabilityDate" field="disabilityDate"/></td>
			</tr>
			<tr>
	   			<td class="FieldLabel" colspan="2">致残原因：</td>
				<td class="FieldInput" colspan="5"><input type="text" id="disabilityReason" name="disabilityReason" field="disabilityReason" style="width:85%" disabled="true"/><font color="red">*</font></td>
			</tr>
	   		<tr>	
				<td class="FieldLabel" colspan="2">致残情况：</td>
				<td class="FieldInput" colspan="5"><input type="text" id="disabilityBody" name="disabilityBody" field="disabilityBody" style="width:85%" disabled="true"/><font color="red">*</font></td>
			</tr>
	   		<tr>
				<td class="FieldLabel" colspan="2">附送材料情况：</td>
				<td class="FieldInput" colspan="5"><textarea name="dataSituation" field="dataSituation" style="width:90%" rows="2" ></textarea></td>
			</tr>
	   		<tr>
				<td class="FieldLabel" colspan="2">备注：</td>
				<td class="FieldInput" colspan="5"><textarea name="note" field="note" style="width:90%" rows="2" ></textarea></td>
			</tr>
		</table>
		
		<!-- 打印相关 -->
		<input type="hidden" id="docpath" value="jsp/cams/bpt/flow/disability/assessdisability/print/introductionLetter.doc"/>
		<input type="hidden" id="peopleId" name="printQuery" queryData="queryData" value="<%=request.getParameter("peopleId")%>"/>
		<input type="hidden" id="applyId" name="printQuery" queryData="queryData" value="<%=request.getParameter("applyId")%>"/>
		<input type="hidden" id="scaconfPath" value="assDisdislityApp/assDisdislityAppPrintDao"/>
		<input type="hidden" id="method" value="queryDisIdenti"/>
		</form>
   </next:Html>
</next:Panel>
</body>
</html>
