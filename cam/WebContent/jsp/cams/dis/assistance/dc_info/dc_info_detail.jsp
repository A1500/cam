
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
	<head>
		<title>DIS_RELIEF_INFO明细</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="dc_info_detail.js"></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.dis.base.cmd.DisReliefInfoQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisReliefInfo"></model:record>
		<model:params>
			<model:param name="INFO_ID" value='<%=request.getParameter("infoId")%>'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>

<next:Panel  title="DIS_RELIEF_INFO">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
	    <next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="undo"  text="返回" handler="back"/>
	</next:TopBar>
	<next:Html>
		<form id="editForm"   dataset="ds" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="100%" >
		
	   		<tr>
				<td  class="FieldLabel" >救助类型</td>
				<td class="FieldInput"><input type="text" name="reliefType" field="reliefType"  /> </td>
			
				<td  class="FieldLabel" >需口粮救助（公斤）</td>
				<td class="FieldInput"><input type="text" name="requiredForFood" field="requiredForFood"  /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >需衣被救助（件）</td>
				<td class="FieldInput"><input type="text" name="requiredForClothes" field="requiredForClothes"  /> </td>
			
				<td  class="FieldLabel" >需取暖救助（元）</td>
				<td class="FieldInput"><input type="text" name="requiredForHeat" field="requiredForHeat"  /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >需伤病救助（元）</td>
				<td class="FieldInput"><input type="text" name="requiredForDisease" field="requiredForDisease"  /> </td>
			
				<td  class="FieldLabel" >需其他救助（元）</td>
				<td class="FieldInput"><input type="text" name="requiredForOthers" field="requiredForOthers"  /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >受灾时间</td>
				<td class="FieldInput"><input type="text" name="damageTime" field="damageTime"  /> </td>
			
				<td  class="FieldLabel" >灾害种类</td>
				<td class="FieldInput"><input type="text" name="disasterType" field="disasterType"  /> </td>
			</tr>
	   		
	   		
	   		<tr>
				
				<td  class="FieldLabel" >核准救助时段</td>
				<td class="FieldInput"><input type="text" name="approvalTimes" field="approvalTimes"  /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >核准救助粮食（公斤）</td>
				<td class="FieldInput"><input type="text" name="approvalFood" field="approvalFood"  /> </td>
			
				<td  class="FieldLabel" >核准救助衣被（件）</td>
				<td class="FieldInput"><input type="text" name="approvalClothes" field="approvalClothes"  /> </td>
			</tr>
	   		
	   		<tr>
				<td  class="FieldLabel" >核准救助资金（元）</td>
				<td class="FieldInput"><input type="text" name="approvalMonry" field="approvalMonry"  /> </td>
			
				<td  class="FieldLabel" >村级填报人姓名</td>
				<td class="FieldInput"><input type="text" name="acceptPeopleName" field="acceptPeopleName"  /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >填报日期</td>
				<td class="FieldInput"><input type="text" name="acceptDate" field="acceptDate"  /> </td>
			
				
			</tr>
	   		<tr>
				<td  class="FieldLabel" >乡镇（街道）审核人名称</td>
				<td class="FieldInput"><input type="text" name="checkPeopleName" field="checkPeopleName"  /> </td>
			
				<td  class="FieldLabel" >审核日期</td>
				<td class="FieldInput"><input type="text" name="checkDate" field="checkDate"  /> </td>
			</tr>
	   		<tr>
				
				<td  class="FieldLabel" >县级批准人名称</td>
				<td class="FieldInput"><input type="text" name="auditPeopleName" field="auditPeopleName"  /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >批准日期</td>
				<td class="FieldInput"><input type="text" name="auditDate" field="auditDate"  /> </td>
			
				
			</tr>
	   		<tr>
				<td  class="FieldLabel" >发放人名称</td>
				<td class="FieldInput"><input type="text" name="grantPeopleName" field="grantPeopleName"  /> </td>
			
				<td  class="FieldLabel" >发放日期</td>
				<td class="FieldInput"><input type="text" name="grantTime" field="grantTime"  /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >备注</td>
				<td class="FieldInput"><input type="text" name="note" field="note"  /> </td>
			
				
			</tr>
	   		<tr>
				<td  class="FieldLabel" >填报单位名称</td>
				<td class="FieldInput"><input type="text" name="organName" field="organName"  /> </td>
			
				<td  class="FieldLabel" >流程跳转状态</td>
				<td class="FieldInput"><input type="text" name="workflowStatus" field="workflowStatus"  /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >流程接收单位</td>
				<td class="FieldInput"><input type="text" name="workflowReceiveOrgan" field="workflowReceiveOrgan"  /> </td>
			
				</tr>		
		</table>
		</form>
   </next:Html>
</next:Panel>
</body>
</html>
