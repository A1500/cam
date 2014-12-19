
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
	<head>
		<title>DIS_FUNDS_SOURCE明细</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="fundsmanage_detail.js"></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.dis.base.cmd.DisFundsSourceQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisFundsSource"></model:record>
		<model:params>
			<model:param name="ID" value='<%=request.getParameter("id")%>'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>

<next:Panel  title="DIS_FUNDS_SOURCE">
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
				<td  class="FieldLabel" >UP_ALLOCATION_NUM</td>
				<td class="FieldInput"><label field="upAllocationNum" /> </td>
			
				<td  class="FieldLabel" >UP_ALLOCATION_TYPE</td>
				<td class="FieldInput"><label field="upAllocationType" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >UP_ALLOCATION_PURPOSE</td>
				<td class="FieldInput"><label field="upAllocationPurpose" /> </td>
			
				<td  class="FieldLabel" >UP_ALLOCATION_TOTAL_COUNT</td>
				<td class="FieldInput"><label field="upAllocationTotalCount" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >ALLOCATION_STATUS</td>
				<td class="FieldInput"><label field="allocationStatus" /> </td>
			
				<td  class="FieldLabel" >ALLOCATION_LEVEL</td>
				<td class="FieldInput"><label field="allocationLevel" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >ZY_ALLOCATION_NUM</td>
				<td class="FieldInput"><label field="zyAllocationNum" /> </td>
			
				<td  class="FieldLabel" >ZY_ALLOCATION_TOTAL</td>
				<td class="FieldInput"><label field="zyAllocationTotal" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >ZY_ALLOCATION_TYPE</td>
				<td class="FieldInput"><label field="zyAllocationType" /> </td>
			
				<td  class="FieldLabel" >ZY_ALLOCATION_PURPOSE</td>
				<td class="FieldInput"><label field="zyAllocationPurpose" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >ST_ALLOCATION_NUM</td>
				<td class="FieldInput"><label field="stAllocationNum" /> </td>
			
				<td  class="FieldLabel" >ST_ALLOCATION_TOTAL</td>
				<td class="FieldInput"><label field="stAllocationTotal" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >ST_ALLOCATION_TYPE</td>
				<td class="FieldInput"><label field="stAllocationType" /> </td>
			
				<td  class="FieldLabel" >ST_ALLOCATION_PURPOSE</td>
				<td class="FieldInput"><label field="stAllocationPurpose" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >CS_ALLOCATION_NUM</td>
				<td class="FieldInput"><label field="csAllocationNum" /> </td>
			
				<td  class="FieldLabel" >CS_ALLOCATION_TOTAL</td>
				<td class="FieldInput"><label field="csAllocationTotal" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >CS_ALLOCATION_TYPE</td>
				<td class="FieldInput"><label field="csAllocationType" /> </td>
			
				<td  class="FieldLabel" >CS_ALLOCATION_PURPOSE</td>
				<td class="FieldInput"><label field="csAllocationPurpose" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >QX_ALLOCATION_NUM</td>
				<td class="FieldInput"><label field="qxAllocationNum" /> </td>
			
				<td  class="FieldLabel" >QX_ALLOCATION_TOTAL</td>
				<td class="FieldInput"><label field="qxAllocationTotal" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >QX_ALLOCATION_TYPE</td>
				<td class="FieldInput"><label field="qxAllocationType" /> </td>
			
				<td  class="FieldLabel" >QX_ALLOCATION_PURPOSE</td>
				<td class="FieldInput"><label field="qxAllocationPurpose" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >RECEIVE_ORGAN_NAME</td>
				<td class="FieldInput"><label field="receiveOrganName" /> </td>
			
				<td  class="FieldLabel" >RECEIVE_ORGAN_CODE</td>
				<td class="FieldInput"><label field="receiveOrganCode" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >FILL_ORGAN_CODE</td>
				<td class="FieldInput"><label field="fillOrganCode" /> </td>
			
				<td  class="FieldLabel" >FILL_ORGAN_NAME</td>
				<td class="FieldInput"><label field="fillOrganName" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >FILL__PEOPLE_NAME</td>
				<td class="FieldInput"><label field="fillPeopleName" /> </td>
			
				<td  class="FieldLabel" >FILL_TIME</td>
				<td class="FieldInput"><label field="fillTime" /> </td>
			</tr>			
		</table>
		</form>
   </next:Html>
</next:Panel>
</body>
</html>
