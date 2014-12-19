
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
	<head>
		<title>医保系统连接配置编辑</title>
		<next:ScriptManager/>
		<script>
			var idField='<%=request.getParameter("dataBean")%>';
			var method='<%=request.getParameter("method")%>';
			var conType='<%=request.getParameter("conType")%>';
			var organCode = '<%=BspUtil.getOrganCode()%>';
		</script>
		<script type="text/javascript" src="samMConConfigEdit.js"></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.drel.mbalance.cmd.SamMedicalConConfigQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.mbalance.data.SamMedicalConConfig">
		</model:record>
	</model:dataset>
	<model:dataset id="checkDs" cmd="com.inspur.cams.drel.mbalance.cmd.SamMedicalConConfigQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.mbalance.data.SamMedicalConConfig"><model:field name="hospitalName"/></model:record>
	</model:dataset>
	<!-- 医院 -->
	<model:dataset id="extOrganDs"
		cmd="com.inspur.cams.comm.extuser.cmd.ComExtOrganQueryCmd"
		global="true">
		<model:record fromBean="com.inspur.cams.comm.extuser.data.ComExtOrgan"></model:record>
	</model:dataset>
	<!-- 连接方式 -->
	<model:dataset id="conModDs" enumName="SAM.CON.MOD" autoLoad="true">	</model:dataset>
	<!-- 连接类型 -->
	<model:dataset id="conTypeDs" enumName="SAM.CON.TYPE" autoLoad="true">	</model:dataset>
</model:datasets>
<next:ViewPort>
<next:AnchorLayout>
<next:Panel  title="医保系统连接配置">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="save"  text="保存" handler="save"/>
		<next:ToolBarItem iconCls="undo"  text="返回" handler="back"/>
	</next:TopBar>
	<next:Html>
		<form id="editForm"   dataset="ds" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="100%" >
	   		<tr>
	   		<td  class="FieldLabel" >连接区域：</td>
				<td colspan="3" class="FieldInput">
				<input type="hidden" name="conArea" id="conArea" field="conArea"  />
				<input type="text" name="conAreaName" id="conAreaName" field="conAreaName" onclick='forHelp()'/>
				</td>
			</tr>
	   		<tr>	
				<td  class="FieldLabel" >连接类型：</td>
				<td class="FieldInput"><select name="conType" field="conType">
					<option dataset="conTypeDs"></option>
				</select><font color="red">*</font> </td>
			
				<td  class="FieldLabel" >连接方式：</td>
				<td class="FieldInput"><select id="conMod" name="conMod" field="conMod" >
					<option dataset="conModDs"></option>
				</select></td>
			</tr>
			<tr>
				<td  class="FieldLabel" >URL：</td>
				<td class="FieldInput" colspan="3"><input type="text" name="conUrl" field="conUrl"  style="width: 80%"/> </td>
			</tr>
			<tr>
				<td  class="FieldLabel" >默认命名空间：</td>
				<td class="FieldInput" ><input type="text" name="defaultNamespace" field="defaultNamespace"  style="width: 80%"/> </td>
				<td  class="FieldLabel" >方法名：</td>
				<td class="FieldInput" ><input type="text" name="soapAction" field="soapAction"  style="width: 80%"/> </td>
			
			</tr>
	   		<tr>
				<td  class="FieldLabel" >用户名：</td>
				<td class="FieldInput"><input type="text" name="conUser" field="conUser"  /> </td>
			
				<td  class="FieldLabel" >密码：</td>
				<td class="FieldInput"><input type="text" name="conPwd" field="conPwd"  /> </td>
			</tr>
						
		</table>
		</form>
   </next:Html>
</next:Panel>
</next:AnchorLayout>
</next:ViewPort>
</body>
</html>
