<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
	<head>
		<title>COM_SUBSYS_CONFIG</title>
		<next:ScriptManager/>
		<script>
			var idField='<%=request.getParameter("dataBean")%>';
			var method='<%=request.getParameter("method")%>';
			var sysId="<%=IdHelp.getUUID32() %>";
		</script>
		<script type="text/javascript" src="subsysConfigEdit.js"></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ComSubsysConfigDataSet" cmd="com.inspur.cams.comm.subsys.cmd.ComSubsysConfigQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.comm.subsys.data.ComSubsysConfig"></model:record>
	</model:dataset>
	<model:dataset id="ComSubsysRolesDataSet" cmd="com.inspur.cams.comm.subsys.cmd.ComSubsysRolesCmd" method="getAssignedRoles" global="true">
		<model:record fromBean="org.loushang.bsp.permit.pap.role.data.Role"></model:record>
	</model:dataset>
	<model:dataset id="ableRolesDataset" pageSize="-1" global="true"
		cmd="com.inspur.cams.comm.subsys.cmd.ComSubsysRolesCmd" method="getAbleRoles">
		<model:record fromBean="org.loushang.bsp.permit.pap.role.data.Role">
		</model:record>
	</model:dataset>
	<model:dataset id="menuTypeds" cmd="com.inspur.cams.comm.menuconfig.cmd.MenuConfigCommand" method="getMenuType" pageSize="50"  autoLoad="true"  global="true">
		<model:record>
			<model:field name="value" mapping="MENU_TYPE_ID" type="string" />
			<model:field name="text" mapping="MENU_TYPE_NAME" type="string" />
		</model:record>
	</model:dataset>
	<!-- 是否 -->
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true"	global="true"></model:dataset>
</model:datasets>
<next:ViewPort>
<next:AnchorLayout>
<next:Panel >
		<next:TopBar>
			<next:ToolBarItem symbol="->" ></next:ToolBarItem>			
			<next:ToolBarItem iconCls="save" text="保存" handler="saveClick" />
			<next:ToolBarItem iconCls="undo" text="返回" handler="returnClick" />
		</next:TopBar>
		<next:Html>
		<form id="ComSubsysConfigForm" method="post" dataset="ComSubsysConfigDataSet" onsubmit="return false" style="padding: 5px;" class="L5form">
			<table border="0"  width="100%" >
			
		   <tr>
				<td  class="FieldLabel" style="width:25%">系统名称:</td>
				<td class="FieldInput" style="width:25%">
				  <input  type="text" name="sysName" field="sysName"  onblur="setShortName(this.value)"/><font color="red">*</font>  
				</td>
				<td  class="FieldLabel"  style="width:25%">系统菜单:</td>
				<td class="FieldInput"  style="width:25%" >
				 <select id="sysMenuType" field="sysMenuType">
					<option dataset="menuTypeds" ></option>
				 </select>
				<font color="red">*</font>  </td>
		   </tr>
			
		   <tr>
				<td  class="FieldLabel" >系统简称:</td>
				<td class="FieldInput" ><input  type="text" name="shortName" field="shortName"  /><font color="red">*</font>  </td>
		      	<td  class="FieldLabel" >排序:</td>
				<td class="FieldInput" ><input  type="text" name="orderNum" field="orderNum" value="100"/> <font color="red">*</font> </td>
		   </tr>	
		   <tr>
				<td  class="FieldLabel" >系统图标:</td>
				<td class="FieldInput" ><input  type="text" name="sysIco" field="sysIco"  /><font color="red">*</font> </td>
				<td  class="FieldLabel" >是否显示:</td>
				<td class="FieldInput" ><select id='showFlg' field='showFlg' style='width:100'><option dataset='comm_yesorno'/></select><font color="red">*</font> </td>
		   </tr>		
		   <tr>
				<td  class="FieldLabel" >顶部图片:</td>
				<td class="FieldInput" ><input  type="text" name="topPic" field="topPic"  />  </td>
		        <td  class="FieldLabel" >版本号缩进:</td>
                <td class="FieldInput" ><input  type="text" name="verMargin" field="verMargin"  />  </td>
				
		   </tr>
		   <tr>
				<td  class="FieldLabel" >子系统首页:</td>
                <td class="FieldInput" colspan='3'><input  type="text" name="mainPic" field="mainPic"  style="width:70%"/>  </td>
		
		   </tr>
			 <tr>
				<td  class="FieldLabel" >是否直接跳转到相应菜单:</td>
                <td class="FieldInput" colspan='3'><select id='showFlg' field='ifJumpMain' style='width:100'><option dataset='comm_yesorno'/></select><font color="red">*</font> </td>
		
		   </tr>
			</table>
		</form>
	   </next:Html>
</next:Panel>
<next:Panel id="roleEditPanel"
		title='角色' width="100%" height="100%"
		autoScroll="true">
	<next:Html>
		<form onsubmit="return false" dataset="ComSubsysConfigDataSet" class="L5form">
			<input type="hidden" systype="itemselector" id="grantRolecmp"
				field="grantedRoles">
			<div id="grantRoleDiv"></div>
		</form>
	</next:Html>
</next:Panel>
</next:AnchorLayout>
</next:ViewPort>
</body>
</html>
