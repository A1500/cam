
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
	<head>
		<title>应急生活救助明细</title>
		<next:ScriptManager/>
		<script type="text/javascript">
			var infoId = '<%=request.getParameter("infoId")%>';
		</script>
		<script type="text/javascript" src="yj_info_detail.js"></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="infoDs" cmd="com.inspur.cams.dis.base.cmd.DisReliefInfoQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisReliefInfo"></model:record>
	</model:dataset>
	
	<model:dataset id="workflowStateDs" enumName="DIS.RELIEFINFO_WORKFLOW_STATE" autoLoad="true"
		global="true">
	</model:dataset>
	
	<model:dataset id="grantTypeDs" enumName="DIS.GRANT_TYPE" autoLoad="true"
		global="true">
	</model:dataset>
</model:datasets>
<next:Panel id="infoGrid" width="100%" autoHeight="100%" collapsible="true" title="救助信息">
	<next:Html>
		<form id="editForm" dataset="infoDs" onsubmit="return false" style="padding: 5px;" class="L5form">
			<table border="1"  width="100%" >
				<tr>
						
					<td  class="FieldLabel" >需口粮救助（公斤）</td>
					<td class="FieldInput"><label field="requiredForFood" /> </td>
					
					<td  class="FieldLabel" >需衣被救助（件）</td>
					<td class="FieldInput"><label field="requiredForClothes" /> </td>
				</tr>
		   		<tr>
					
					<td  class="FieldLabel" >需取暖救助（元）</td>
					<td class="FieldInput"><label field="requiredForHeat" /> </td>
					
					<td  class="FieldLabel" >需伤病救助（元）</td>
					<td class="FieldInput"><label field="requiredForDisease" /> </td>
				</tr>
		   		<tr>
					<td  class="FieldLabel" >需其他救助（元）</td>
					<td class="FieldInput"><label field="requiredForOthers" /> </td>
					<td  class="FieldLabel"></td>
					<td class="FieldInput"></td>
				</tr>
		   		<tr>
		   			<td  class="FieldLabel" >核准救助人口</td>
					<td class="FieldInput"><label field="approvalFamilyNum" /> </td>
					
					<td  class="FieldLabel" >核准救助粮食（公斤）</td>
					<td class="FieldInput"><label field="approvalFood" /> </td>
					
				</tr>
		   		<tr>
					<td  class="FieldLabel" >核准救助衣被（件）</td>
					<td class="FieldInput"><label field="approvalClothes" /> </td>
					
					<td  class="FieldLabel" >核准救助资金（元）</td>
					<td class="FieldInput"><label field="approvalMonry" /> </td>
				</tr>
				<tr>	
					<td  class="FieldLabel" >村级行政区划名称</td>
					<td class="FieldInput"><label field="acceptAreaName" /> </td>
					
					<td  class="FieldLabel" >村级行政区划</td>
					<td class="FieldInput"><label field="acceptAreaCode" /> </td>
					
				</tr>
		   		<tr>
					<td  class="FieldLabel" >村级填报人姓名</td>
					<td class="FieldInput"><label field="acceptPeopleName" /> </td>
				
					<td  class="FieldLabel" >村级填报日期</td>
					<td class="FieldInput"><label field="acceptDate" /> </td>
				</tr>
		   		
		   		<tr>
					<td  class="FieldLabel" >乡镇（街道）名称</td>
					<td class="FieldInput"><label field="checkOrganName" /> </td>
				
					<td  class="FieldLabel" >乡镇（街道）区划</td>
					<td class="FieldInput"><label field="checkOrganCode" /> </td>
				</tr>
		   		<tr>
					<td  class="FieldLabel" >乡镇（街道）审核人名称</td>
					<td class="FieldInput"><label field="checkPeopleName" /> </td>
				
					<td  class="FieldLabel" >审核日期</td>
					<td class="FieldInput"><label field="checkDate" /> </td>
				</tr>
				<!-- 
		   		<tr>
					<td  class="FieldLabel" >县级名称</td>
					<td class="FieldInput"><label field="auditOrganName" /> </td>
				
					<td  class="FieldLabel" >县区划</td>
					<td class="FieldInput"><label field="auditOrganCode" /> </td>
				</tr>
		   		<tr>
					<td  class="FieldLabel" >县级批准人名称</td>
					<td class="FieldInput"><label field="auditPeopleName" /> </td>
				
					<td  class="FieldLabel" >批准日期</td>
					<td class="FieldInput"><label field="auditDate" /> </td>
				</tr>
				 -->
		   		<tr>
					<td  class="FieldLabel" >发放类别</td>
					<td class="FieldInput"><label field="grantType" dataset="grantTypeDs" /> </td>
				
					<td  class="FieldLabel" >发放单位</td>
					<td class="FieldInput"><label field="grantOrganName" /> </td>
				</tr>
		   		<tr>
					<td  class="FieldLabel" >填报单位代码</td>
					<td class="FieldInput"><label field="organCode" /> </td>
				
					<td  class="FieldLabel" >填报单位名称</td>
					<td class="FieldInput"><label field="organName" /> </td>
				</tr>
		   		<tr>
					<td  class="FieldLabel" >填报时间</td>
					<td class="FieldInput"><label field="fillTime" /> </td>
				
					<td  class="FieldLabel" >当前状态</td>
					<td class="FieldInput"><label field="workflowStatus" dataset="workflowStateDs" /> </td>
					
				</tr>
		   		<tr>
					<td  class="FieldLabel" >备注</td>
					<td class="FieldInput" colspan="3"><label field="note" /> </td>
				</tr>			
			</table>
		</form>
 			</next:Html>
  	</next:Panel>
</body>
</html>
