<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%
	response.setHeader("Expires", "Sat, 6 May 1995 12:00:00 GMT");  
	response.setHeader("Cache-Control", "no-store,no-cache,must-revalidate");  
	response.addHeader("Cache-Control", "post-check=0, pre-check=0");  
	response.setHeader("Pragma", "no-cache");  
%>
<html>
	<head>
		<title>辅助器械配置</title>
		<next:ScriptManager/>
		<script>
     		var peopleId='<%=request.getParameter("peopleId")%>' ;
		</script>
		<script type="text/javascript" src="<%=SkinUtils.getJS(request, "camsCheck.js")%>"></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="AssistiveDevicesDataset" cmd="com.inspur.cams.bpt.manage.cmd.BptApplyAssistiveDevicesQueryCommand" global="true" method="queryAsisDeviceConfig">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptApplyAssistiveDevices">
			<model:field name="approveDate" type="string"/>
			<model:field name="checkIncharge" type="string"/>
			<model:field name="agreeFlag" type="string"/>
			<model:field name="aduitIncharge" type="string"/>
			<model:field name="aduitAdvice" type="string"/>
		</model:record>
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
	<!-- 是否同意 -->
	<model:dataset id="AgreeEnum" enumName="COMM.AGREEORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>
		<next:GridPanel id="editGridPanel" name="configGrid" width="100%" height="21%" stripeRows="true" dataset="AssistiveDevicesDataset" >
			<next:Columns>
			    <next:RowNumberColumn header="序号" width="45"/>
			    <next:RadioBoxColumn></next:RadioBoxColumn>
			    <next:Column id="approveDate" header="申请时间" field="approveDate" width="90" >
					<next:TextField allowBlank="false" />
				</next:Column>
		
				<next:Column id="apparatusName" header="伤残器械" field="apparatusName" width="500">
					<next:TextField allowBlank="false" />
				</next:Column>
		
				
			</next:Columns>
		</next:GridPanel>	
		<next:Panel width="100%" height="100%" autoScroll="true">
			<next:Html>
				<form id="editForm" dataset="AssistiveDevicesDataset" onsubmit="return false" style="padding: 5px;" class="L5form">
				<table border="1"  width="99%">
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
						<td  class="FieldInput" colspan="5">
							<label id="disabilityCase" name="disabilityCase" field="disabilityCase" title="伤残情形"></label>
							</td>
					</tr>
			   		<tr>
						<td  class="FieldLabel">住址</td>
						<td  class="FieldInput"><label id="address" name="address" field="address" title="住址"/></td>
						<td  class="FieldLabel">电话</td>
						<td  class="FieldInput" colspan="3"><label id="telMobile" name="telMobile" field="telMobile"/> </td>
					</tr>
			   		<tr>
						<td  class="FieldLabel">申请器械</td>
						<td  class="FieldInput" colspan="5">
								<label id="apparatusName" readOnly="true" field="apparatusName" style="width:80%" />
								<input type="hidden" id="applyApparatusId" name="applyApparatusId" field="applyApparatusId">
						</td>
					</tr>
			   		<tr>
						<td  class="FieldLabel">申请理由</td>
						<td  class="FieldInput" colspan="5"><label id="applyCausa" name="applyCausa" field="applyCausa" style="width:90%" rows="3" ></label></td>
					</tr>
			   		<tr>
						<td  class="FieldLabel">备注</td>
						<td  class="FieldInput" colspan="5"><label id="note" name="note" field="note" style="width:90%" rows="3" ></label></td>
					</tr>
				</table>
				</form>
		   </next:Html>
		</next:Panel>
</body>
<script type="text/javascript">
	function init(){
		var AssistiveDevicesDataset = L5.DatasetMgr.lookup("AssistiveDevicesDataset");
		AssistiveDevicesDataset.setParameter("peopleId",peopleId);
		AssistiveDevicesDataset.load();
	}
</script>
</html>
