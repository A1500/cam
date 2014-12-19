<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
	<head>
		<title>优抚_申请_伤残辅助器械编辑</title>
		<next:ScriptManager/>
		<script>
     		var peopleId='<%=request.getParameter("peopleId")%>' ;
	        var objectType='<%=request.getParameter("objectType")%>';
			var disabilityGenusCode='<%=request.getParameter("disabilityGenusCode")%>' ;
		</script>
		<script type="text/javascript" src="assistiveDevicesInsert.js"></script>
		<script type="text/javascript" src="multiGrid.js"></script>
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
	<model:dataset id="DevicesDataset" cmd="com.inspur.cams.bpt.manage.cmd.BptAssistiveDevicesMaintenaQueryCommand" global="true" > 
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptAssistiveDevicesMaintena">
			<model:field name="num" type="string"/>
		</model:record>
	</model:dataset>
</model:datasets>
<next:Panel width="100%" height="100%" autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="save"  text="保存" handler="save"/>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="disable"  text="关闭" handler="back"/>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form id="editForm"   dataset="AssistiveDevicesDataset" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="99%" >
			
	   		<tr>
				<td  class="FieldLabel" style="width:15%">姓名</td>
				<td  class="FieldInput" style="width:15%"><input type="text" id="name" name="name" field="name" readonly="readonly"/>
						<img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>" style="cursor:hand" onclick="selectPeople()"/>
				</td>
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
				<td  class="FieldInput" colspan="5">
					<textarea id="disabilityCase" name="disabilityCase" field="disabilityCase" style="width:90%" rows="3" title="伤残情形"></textarea>
					<font color="red">*</font></td>
			</tr>
	   		<tr>
				<td  class="FieldLabel">住址</td>
				<td  class="FieldInput" colspan="2"><input type="text" id="address" name="address" field="address" style="width:90%" title="住址"/><font color="red">*</font></td>
				<td  class="FieldLabel">电话</td>
				<td  class="FieldInput" colspan="2"><input type="text" id="telMobile" name="telMobile" field="telMobile"/> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel">申请器械</td>
				<td  class="FieldInput" colspan="3">
						<input type="text" id="apparatusName" readOnly="true" field="apparatusName" style="width:80%" />
							<font color="red">*</font>
							<img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>" style="cursor:hand" onclick="selectDevices()"/>
						<input type="hidden" id="applyApparatusId" name="applyApparatusId" field="applyApparatusId">
				</td>
				<td  class="FieldLabel">配置类别</td>
						<td  class="FieldInput" >
							<select id="configuration" name="configuration" field="configuration" >
								<option value="0">初次配置</option>
								<option value="1">维修</option>
								<option value="2">更换</option>
							</select>
						</td>
			</tr>
	   		<tr>
				<td  class="FieldLabel">申请理由</td>
				<td  class="FieldInput" colspan="5"><textarea id="applyCausa" name="applyCausa" field="applyCausa" style="width:90%" rows="3" ></textarea></td>
			</tr>
	   		<tr>
				<td  class="FieldLabel">备注</td>
				<td  class="FieldInput" colspan="5"><textarea id="note" name="note" field="note" style="width:90%" rows="3" ></textarea></td>
			</tr>
		</table>
		</form>
   </next:Html>
</next:Panel>
</body>
</html>
