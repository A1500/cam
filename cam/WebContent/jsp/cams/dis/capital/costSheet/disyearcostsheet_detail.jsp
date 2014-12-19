
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
	<head>
		<title>DIS_YEAR_COST_SHEET明细</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="disyearcostsheet_detail.js"></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.dis.base.cmd.DisYearCostSheetQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisYearCostSheet"></model:record>
		<model:params>
			<model:param name="ID" value='<%=request.getParameter("id")%>'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>

<next:Panel  title="DIS_YEAR_COST_SHEET">
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
				<td  class="FieldLabel" >YEAR_COST_SHEET</td>
				<td class="FieldInput"><label field="yearCostSheet" /> </td>
			
				<td  class="FieldLabel" >ASSISTANCE_FOR_SELF</td>
				<td class="FieldInput"><label field="assistanceForSelf" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >DONATION_FOR_SELF</td>
				<td class="FieldInput"><label field="donationForSelf" /> </td>
			
				<td  class="FieldLabel" >ORGAN_CODE</td>
				<td class="FieldInput"><label field="organCode" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >ORGAN_NAME</td>
				<td class="FieldInput"><label field="organName" /> </td>
			
				<td  class="FieldLabel" >FILL_PEOPLE_NAME</td>
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
