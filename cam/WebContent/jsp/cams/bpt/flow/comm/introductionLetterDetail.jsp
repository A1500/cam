<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>鉴定介绍信修改</title>
<next:ScriptManager />
		<script>
			var peopleId = '<%= (String)request.getParameter("peopleId")%>';
			var applyId = '<%= (String)request.getParameter("applyId")%>';
		</script>
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
	<next:Html>
		<form id="editForm"   dataset="DisabilityIdentiDataset" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="98%">
		
	   		<tr>
				<td  class="FieldLabel" >编号：</td>
				<td class="FieldInput"><label name="numbering" field="numbering"/></td>
			
				<td  class="FieldLabel" >鉴定单位：</td>
				<td class="FieldInput"><label name="identificationUnit" field="identificationUnit"/></td>
			
				<td  class="FieldLabel" >介绍单位：</td>
				<td class="FieldInput"><label type="text" name="introductionUnit" field="introductionUnit"/></td>
			</tr>
			
	   		<tr>
				<td  class="FieldLabel" >介绍时间：</td>
				<td class="FieldInput"><label name="introductionDate" field="introductionDate"/></td>

				<td  class="FieldLabel" >鉴定时间：</td>
				<td class="FieldInput"><label name="identificationDate" field="identificationDate"/></td>
			
				<td  class="FieldLabel" >经办人：</td>
				<td class="FieldInput"><label name="agent" field="agent"/></td>
			</tr>
			
	   		<tr>
				<td  class="FieldLabel" >经办人电话：</td>
				<td class="FieldInput" colspan="5"><label name="agentPhone" field="agentPhone"/></td>
			</tr>
			
	   		<tr>
	   			<td  class="FieldLabel" >姓名：</td>
				<td class="FieldInput"><label name="name" field="name"/></td>
				
				<td  class="FieldLabel" >性别：</td>
				<td class="FieldInput"><label name="sex" field="sex" dataset="SexDataset"></label></td>
				
				<td  class="FieldLabel" >出生年月：</td>
				<td class="FieldInput"><label name="birthday" field="birthday"/></td>
			</tr>
			
	   		<tr>
	   			<td  class="FieldLabel" >身份证号：</td>
				<td class="FieldInput"><label name="idCard" field="idCard"/></td>
	   		
				<td  class="FieldLabel" >户籍地：</td>
				<td class="FieldInput"><label name="domicileName"  title="属地行政区划" field="domicileName"/></td>
			
				<td  class="FieldLabel" >住址：</td>
				<td class="FieldInput"><label name="address" field="address"/></td>
			</tr>
			
	   		<tr>
	   			<td  class="FieldLabel" >工作单位名称：</td>
				<td class="FieldInput"><label name="workUnitName" field="workUnitName"/></td>
	   		
				<td  class="FieldLabel" >受伤时身份：</td>
				<td class="FieldInput"><label name="injuryStatus" field="injuryStatus"  /> </td>

				<td  class="FieldLabel" >负伤时间：</td>
				<td class="FieldInput"><label name="disabilityDate" field="disabilityDate"/></td>
			</tr>
			
	   		<tr>	
				<td  class="FieldLabel" >致残情况：</td>
				<td class="FieldInput"  colspan="5"><label name="disabilityBody" field="disabilityBody"/></td>
			</tr>

	   		<tr>
	   			<td  class="FieldLabel" >致残原因：</td>
				<td class="FieldInput" colspan="5">
					<label name="disabilityReason" field="disabilityReason"></label>
				</td>
			</tr>
	   		<tr>
				<td  class="FieldLabel">附送材料情况：</td>
				<td class="FieldInput" colspan="5">
					<label name="dataSituation" field="dataSituation"></label>
				 </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >备注：</td>
				<td class="FieldInput" colspan="5">
					<label name="note" field="note"></label>
				 </td>
			</tr>
		</table>
		</form>
   </next:Html>
</next:Panel>
</body>
<script type="text/javascript">
function init() {
	var DisabilityIdentiDataset = L5.DatasetMgr.lookup("DisabilityIdentiDataset");
	DisabilityIdentiDataset.setParameter("PEOPLE_ID",peopleId);
	DisabilityIdentiDataset.setParameter("APPLY_ID",applyId);
	DisabilityIdentiDataset.load();
	L5.QuickTips.init();
}
</script>
</html>
