
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
	<head>
		<title>DIS_RELIEF_INFO编辑</title>
		<next:ScriptManager/>
		<script>
			var idField='<%=request.getParameter("dataBean")%>';
			var method='<%=request.getParameter("method")%>';
		</script>
		<script type="text/javascript" src="cj_info_edit.js"></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.dis.base.cmd.DisReliefInfoQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisReliefInfo"></model:record>
	</model:dataset>
	<model:dataset id="ReliefTypeDataset" enumName="DIS.ALLOCATION_PURPOSE" autoLoad="true"
		global="true"></model:dataset>
</model:datasets>
<next:ViewPort>
<next:AnchorLayout>
<next:Panel  title="灾区民房恢复重建补助">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="save"  text="保存" handler="save"/>
<%-- 		<next:ToolBarItem iconCls="undo"  text="返回" handler="back"/> --%>
	</next:TopBar>
	<next:Html>
		<form id="editForm"   dataset="ds" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="100%" >
		
	   		<tr>
	   		    <td  class="FieldLabel" >救助类型</td>
				<td class="FieldInput"><select name="reliefType" id="reliefType" field="reliefType"  > 
					<option dataset="ReliefTypeDataset" ></option></select>
				</td>
	   		    <td  class="FieldLabel" >档案编号</td>
				<td class="FieldInput"><input type="text" name="recordId" field="recordId"  /> </td>											
			</tr>
	   		<tr>
				<td  class="FieldLabel" >受灾时间</td>
				<td class="FieldInput"><input type="text" name="damageTime" field="damageTime"  /> </td>
			
				<td  class="FieldLabel" >灾害种类</td>
				<td class="FieldInput"><input type="text" name="disasterType" field="disasterType"  /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >倒塌房屋（间）</td>
				<td class="FieldInput"><input type="text" name="collapsedHouse" field="collapsedHouse"  /> </td>
			
				<td  class="FieldLabel" >严重损坏房屋（间）</td>
				<td class="FieldInput"><input type="text" name="seriousDamageHouse" field="seriousDamageHouse"  /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >一般损坏房屋（间）</td>
				<td class="FieldInput"><input type="text" name="generalDamageHouse" field="generalDamageHouse"  /> </td>
			
				<td  class="FieldLabel" >需重建房屋（间）</td>
				<td class="FieldInput"><input type="text" name="rebuildHouse" field="rebuildHouse"  /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >需修缮房屋（间）</td>
				<td class="FieldInput"><input type="text" name="repairedHouse" field="repairedHouse"  /> </td>
			    <td  class="FieldLabel" >填报日期</td>
				<td class="FieldInput"><input type="text" name="acceptDate" field="acceptDate"  /> </td>
				
			</tr>
	   		
	   		<tr>
				<td  class="FieldLabel" >核准重建间数（间）</td>
				<td class="FieldInput"><input type="text" name="approvalRebuiledHouse" field="approvalRebuiledHouse"  /> </td>
			
				<td  class="FieldLabel" >核准修缮间数（间）</td>
				<td class="FieldInput"><input type="text" name="approvalRepairedHouse" field="approvalRepairedHouse"  /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >核准救助资金（元）</td>
				<td class="FieldInput"><input type="text" name="approvalMonry" field="approvalMonry"  /> </td>
			
				<td  class="FieldLabel" >村级填报人姓名</td>
				<td class="FieldInput"><input type="text" name="acceptPeopleName" field="acceptPeopleName"  /> </td>
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
				<td  class="FieldLabel" >填报单位名称</td>
				<td class="FieldInput"><input type="text" name="organName" field="organName"  /> </td>
			
				<td  class="FieldLabel" >流程跳转状态</td>
				<td class="FieldInput"><input type="text" name="workflowStatus" field="workflowStatus"  /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >流程接收单位</td>
				<td class="FieldInput"><input type="text" name="workflowReceiveOrgan" field="workflowReceiveOrgan"  /> </td>
			    
			    <td  class="FieldLabel" >备注</td>
				<td class="FieldInput"><input type="text" name="note" field="note"  /> </td>
			
				</tr>				
		</table>
		</form>
   </next:Html>
</next:Panel>
</next:AnchorLayout>
</next:ViewPort>
</body>
</html>
