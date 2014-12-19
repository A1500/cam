<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<script type="text/javascript">
     		var processId = <%=request.getParameter("processId")%>;
     		var assignmentId = <%=request.getParameter("assignmentId")%>;
</script>
<html>
	<head>
		<title>优抚_申请_伤残辅助器械编辑查看</title>
		<next:ScriptManager/>
	</head>
<body>
<model:datasets>
		<model:dataset id="AssistiveDevicesDataset" cmd="com.inspur.cams.bpt.manage.cmd.BptApplyAssistiveDevicesQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptApplyAssistiveDevices"></model:record>
</model:dataset>
	
	<!-- 性别 -->
	<model:dataset id="SexDataset" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
	
	<!-- 伤残类别代码 -->
	<model:dataset id="DisabilityTypeCodeEnum" enumName="DISABILITY.TYPE.CODE" autoLoad="true" global="true"></model:dataset>
	
	<!-- 伤残等级 -->
	<model:dataset id="DisabilityLevelDataset" enumName="LEVEL.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 伤残属别 -->
	<model:dataset id="DisabilityGenusDataset" enumName="GENUS.CODE" autoLoad="true" global="true"></model:dataset>
	
	<!-- 伤残器械 -->
	<model:dataset id="DevicesMaintenaDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='BPT_ASSISTIVE_DEVICES_MAINTENA'></model:param>
			<model:param name="value" value='APPLY_APPARATUS_ID'></model:param>
			<model:param name="text" value='APPARATUS_NAME'></model:param>
		</model:params>
	</model:dataset> 
</model:datasets>

<next:Panel  width="100%" height="100%" autoScroll="true">
	<next:Html>
		<form id="editForm"   dataset="AssistiveDevicesDataset" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="99%" >
			
	   		<tr>
				<td  class="FieldLabel" style="width:15%">姓名</td>
				<td  class="FieldInput" style="width:15%"><label id="name" name="name" field="name"/></td>
				
				<td  class="FieldLabel" style="width:15%">性别</td>
				<td  class="FieldInput" style="width:15%"><label id="sex" name="sex" field="sex" dataset="SexDataset" /></td>
			
				<td  class="FieldLabel" style="width:15%">身份证件号码</td>
				<td  class="FieldInput" style="width:15%"><label id="idCard" name="idCard" field="idCard"/></td>
			</tr>
			
	   		<tr>
				<td  class="FieldLabel">优抚对象类别</td>
				<td  class="FieldInput"><label id="objectType" name="objectType" field="objectType" dataset="DisabilityTypeCodeEnum"/></td>

				<td  class="FieldLabel">伤残等级</td>
				<td  class="FieldInput"><label id="disabilityLevel" name="disabilityLevel" field="disabilityLevel" dataset="DisabilityLevelDataset"/></td>
			
				<td  class="FieldLabel">伤残属别</td>
				<td  class="FieldInput"><label id="disabilityGenus" name="disabilityGenus" field="disabilityGenus" dataset="DisabilityGenusDataset"/></td>
			</tr>
			
	   		<tr> 
				<td  class="FieldLabel" nowrap="nowrap">伤残证书编号</td>
				<td  class="FieldInput" colspan="5"><label id="disabilityNo" name="disabilityNo" field="disabilityNo"/></td>
			</tr>
			
			<tr>
				<td  class="FieldLabel" >伤残情形</td>
				<td  class="FieldInput" colspan="5"><label name="disabilityCase" field="disabilityCase"></label></td>
			</tr>
							
	   		<tr>
				<td  class="FieldLabel">住址</td>
				<td  class="FieldInput"><label name="address" field="address"/></td>
			
				<td  class="FieldLabel">电话</td>
				<td  class="FieldInput" colspan="3"><label name="telMobile" field="telMobile"/></td>
			</tr>
			
	   		<tr>
				<td  class="FieldLabel">申请器械</td>
				<td  class="FieldInput" colspan="5">
						<label id="applyApparatusId" field="applyApparatusId"/>
						<input type="hidden" id="applyApparatusQuery" name="applyApparatusQuery" >
				</td>
			</tr>
			
	   		<tr>
				<td  class="FieldLabel">申请事由</td>
				<td  class="FieldInput" colspan="5"><label name="applyCausa" field="applyCausa"></label></td>
			</tr>
			
	   		<tr>
				<td  class="FieldLabel">备注</td>
				<td  class="FieldInput" colspan="5"><label name="note" field="note"></label></td>
			</tr>
			
		</table>
		</form>
   </next:Html>
</next:Panel>

</body>
	<script type="text/javascript">
		function init(){
			var AssistiveDevicesDataset = L5.DatasetMgr.lookup("AssistiveDevicesDataset");
			if(processId == 'null'){
				AssistiveDevicesDataset.setParameter("assignmentId",assignmentId);
			}else{
				AssistiveDevicesDataset.setParameter("PROCESS_ID",processId);
			}
	 		AssistiveDevicesDataset.load();
			L5.QuickTips.init();
		}
	</script>
</html>
