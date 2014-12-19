
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
	<head>
		<title>DIS_BASE_FAMILY_RECORD明细</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="disbasefamilyrecord_detail.js"></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.dis.base.cmd.DisBaseFamilyRecordQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.dis.base.dao.DisBaseFamilyRecord"></model:record>
		<model:params>
			<model:param name="RECORD_ID" value='<%=request.getParameter("recordId")%>'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>

<next:Panel  title="DIS_BASE_FAMILY_RECORD">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
	    <next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="undo"  text="返回" handler="back"/>
	</next:TopBar>
	<next:Html>
		<form id="editForm"   dataset="ds" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="100%" >
		
	   		<tr>
				<td  class="FieldLabel" >RECORD_ID</td>
				<td class="FieldInput"><label field="recordId" /> </td>
			
				<td  class="FieldLabel" >ORGAN_CODE</td>
				<td class="FieldInput"><label field="organCode" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >ORGAN_NAME</td>
				<td class="FieldInput"><label field="organName" /> </td>
			
				<td  class="FieldLabel" >TOWN_CODE</td>
				<td class="FieldInput"><label field="townCode" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >VILLIAGE_CODE</td>
				<td class="FieldInput"><label field="villiageCode" /> </td>
			
				<td  class="FieldLabel" >NAME</td>
				<td class="FieldInput"><label field="name" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >ID_CARD</td>
				<td class="FieldInput"><label field="idCard" /> </td>
			
				<td  class="FieldLabel" >FAMILY_NUM</td>
				<td class="FieldInput"><label field="familyNum" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >FAMILY_TYPE</td>
				<td class="FieldInput"><label field="familyType" /> </td>
			
				<td  class="FieldLabel" >FAMILY_REGISTER</td>
				<td class="FieldInput"><label field="familyRegister" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >HOUSE_COUNT</td>
				<td class="FieldInput"><label field="houseCount" /> </td>
			
				<td  class="FieldLabel" >HOUSE_STRUCTURE</td>
				<td class="FieldInput"><label field="houseStructure" /> </td>
			</tr>			
		</table>
		</form>
   </next:Html>
</next:Panel>
</body>
</html>
