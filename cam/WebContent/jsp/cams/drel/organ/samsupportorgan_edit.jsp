
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
	<head>
		<title>救助机构编辑</title>
		<next:ScriptManager/>
		<script>
			var idField='<%=request.getParameter("dataBean")%>';
			var method='<%=request.getParameter("method")%>';
		</script>
		<script type="text/javascript" src="samsupportorgan_edit.js"></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.drel.organ.cmd.SamSupportOrganQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.organ.date.SamSupportOrgan"></model:record>
	</model:dataset>
	<model:dataset id="organTypeDataset" enumName="SAM.SUPPORT.ORGAN.TYPE" autoLoad="true" global="true" />
</model:datasets>
<next:ViewPort>
<next:AnchorLayout>
<next:Panel  title="救助机构">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="save"  text="保存" handler="save"/>
		<next:ToolBarItem iconCls="undo"  text="返回" handler="back"/>
	</next:TopBar>
	<next:Html>
		<form id="editForm"   dataset="ds" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="100%" >
		
	   		<tr>
				<td  class="FieldLabel" >名称:</td>
				<td class="FieldInput"><input type="text" name="organName" field="organName"  /> </td>
				<td  class="FieldLabel" >类型:</td>
				<td class="FieldInput"><select field="organType"  title="类型"> <option dataset = "organTypeDataset"></option> </select></td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >法人代表:</td>
				<td class="FieldInput"><input type="text" name="legelPeople" field="legelPeople"  /> </td>
				<td  class="FieldLabel" >成立日期:</td>
				<td class="FieldInput"><input type="text" name="establishDate" field="establishDate" onclick="LoushangDate(this)"  format="Y-m-d"  /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >总面积:</td>
				<td class="FieldInput"><input type="text" name="totalArea" field="totalArea"  /> </td>
				<td  class="FieldLabel" >建筑面积:</td>
				<td class="FieldInput"><input type="text" name="buildArea" field="buildArea"  /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >房间数:</td>
				<td class="FieldInput"><input type="text" name="roomNum" field="roomNum"  /> </td>
				<td  class="FieldLabel" >床位数:</td>
				<td class="FieldInput"><input type="text" name="bedNum" field="bedNum"  /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >工作人员数量:</td>
				<td class="FieldInput"><input type="text" name="staffNum" field="staffNum"  /> </td>
				<td  class="FieldLabel" >供养人数:</td>
				<td class="FieldInput"><input type="text" name="supportPeopleNum" field="supportPeopleNum"  /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >地址:</td>
				<td class="FieldInput"><input type="text" name="address" field="address"  /> </td>
				<td  class="FieldLabel" >交通路线:</td>
				<td class="FieldInput"><input type="text" name="trafficRoute" field="trafficRoute"  /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >联系人:</td>
				<td class="FieldInput"><input type="text" name="contactPeople" field="contactPeople"  /> </td>
				<td  class="FieldLabel" >联系电话:</td>
				<td class="FieldInput"><input type="text" name="contactPhone" field="contactPhone"  /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >备注:</td>
				<td class="FieldInput" colspan="3"><textarea name="remarks" field="remarks" style="width: 70%" rows="5" /> </td>
			</tr>				
				<input type="hidden" name="organStatus" field="organStatus" value="1" />
		</table>
		</form>
   </next:Html>
</next:Panel>
</next:AnchorLayout>
</next:ViewPort>
</body>
</html>
