
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
	<head>
		<title>DIS_FUNDS_ALLOCATION_DETAIL明细</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="disfundsallocationdetail_detail.js"></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.dis.base.cmd.DisFundsAllocationDetailQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.dis.base.dao.DisFundsAllocationDetail"></model:record>
		<model:params>
			<model:param name="ID" value='<%=request.getParameter("id")%>'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>

<next:Panel  title="DIS_FUNDS_ALLOCATION_DETAIL">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
	    <next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="undo"  text="返回" handler="back"/>
	</next:TopBar>
	<next:Html>
		<form id="editForm"   dataset="ds" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="100%" >
		
	   		<tr>
				<td  class="FieldLabel" >ID</td>
				<td class="FieldInput"><label field="id" /> </td>
			
				<td  class="FieldLabel" >DIS_YEAR</td>
				<td class="FieldInput"><label field="disYear" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >ALLOCATION_DATE</td>
				<td class="FieldInput"><label field="allocationDate" /> </td>
			
				<td  class="FieldLabel" >ALLOCATION_NUM</td>
				<td class="FieldInput"><label field="allocationNum" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >ALLOCATION_TOTAL</td>
				<td class="FieldInput"><label field="allocationTotal" /> </td>
			
				<td  class="FieldLabel" >ALLOCATION_TYPE</td>
				<td class="FieldInput"><label field="allocationType" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >ALLOCATION_PURPOSE</td>
				<td class="FieldInput"><label field="allocationPurpose" /> </td>
			
				<td  class="FieldLabel" >ALLOCATE_ORGAN_NAME</td>
				<td class="FieldInput"><label field="allocateOrganName" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >ALLOCATE_ORGAN_CODE</td>
				<td class="FieldInput"><label field="allocateOrganCode" /> </td>
			
				<td  class="FieldLabel" >ALLOCATION_AMOUNT</td>
				<td class="FieldInput"><label field="allocationAmount" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >NOTE</td>
				<td class="FieldInput"><label field="note" /> </td>
			
				<td  class="FieldLabel" >FILL_ORGAN_CODE</td>
				<td class="FieldInput"><label field="fillOrganCode" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >FILL_ORGAN_NAME</td>
				<td class="FieldInput"><label field="fillOrganName" /> </td>
			
				<td  class="FieldLabel" >FILL__PEOPLE_NAME</td>
				<td class="FieldInput"><label field="fillPeopleName" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >FILL_TIME</td>
				<td class="FieldInput"><label field="fillTime" /> </td>
					</tr>			
		</table>
		</form>
   </next:Html>
</next:Panel>
</body>
</html>
