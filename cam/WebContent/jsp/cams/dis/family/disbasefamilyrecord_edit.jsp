
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
	<head>
		<title>DIS_BASE_FAMILY_RECORD编辑</title>
		<next:ScriptManager/>
		<script>
			var idField='<%=request.getParameter("dataBean")%>';
			var method='<%=request.getParameter("method")%>';
		</script>
		<script type="text/javascript" src="disbasefamilyrecord_edit.js"></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.dis.base.cmd.DisBaseFamilyRecordQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.dis.base.dao.DisBaseFamilyRecord"></model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
<next:AnchorLayout>
<next:Panel  title="DIS_BASE_FAMILY_RECORD">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="save"  text="保存" handler="save"/>
		<next:ToolBarItem iconCls="undo"  text="返回" handler="back"/>
	</next:TopBar>
	<next:Html>
		<form id="editForm"   dataset="ds" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="100%" >
		
	   		<tr>
				<td  class="FieldLabel" >RECORD_ID</td>
				<td class="FieldInput"><input type="text" name="recordId" field="recordId"  /><font color="red">*</font> </td>
			
				<td  class="FieldLabel" >ORGAN_CODE</td>
				<td class="FieldInput"><input type="text" name="organCode" field="organCode"  /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >ORGAN_NAME</td>
				<td class="FieldInput"><input type="text" name="organName" field="organName"  /> </td>
			
				<td  class="FieldLabel" >TOWN_CODE</td>
				<td class="FieldInput"><input type="text" name="townCode" field="townCode"  /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >VILLIAGE_CODE</td>
				<td class="FieldInput"><input type="text" name="villiageCode" field="villiageCode"  /> </td>
			
				<td  class="FieldLabel" >NAME</td>
				<td class="FieldInput"><input type="text" name="name" field="name"  /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >ID_CARD</td>
				<td class="FieldInput"><input type="text" name="idCard" field="idCard"  /> </td>
			
				<td  class="FieldLabel" >FAMILY_NUM</td>
				<td class="FieldInput"><input type="text" name="familyNum" field="familyNum"  /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >FAMILY_TYPE</td>
				<td class="FieldInput"><input type="text" name="familyType" field="familyType"  /> </td>
			
				<td  class="FieldLabel" >FAMILY_REGISTER</td>
				<td class="FieldInput"><input type="text" name="familyRegister" field="familyRegister"  /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >HOUSE_COUNT</td>
				<td class="FieldInput"><input type="text" name="houseCount" field="houseCount"  /> </td>
			
				<td  class="FieldLabel" >HOUSE_STRUCTURE</td>
				<td class="FieldInput"><input type="text" name="houseStructure" field="houseStructure"  /> </td>
			</tr>
						
		</table>
		</form>
   </next:Html>
</next:Panel>
</next:AnchorLayout>
</next:ViewPort>
</body>
</html>
