
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ include file="/jsp/public/resources_jspdir.jsp"%>
<html>
<head>
<title><%=res.get("PUB_MENU_TYPE.TIELE")%></title>
<next:ScriptManager/>
<script type="text/javascript" src="js/menu_edit.js"></script>
<script language="javascript">
	var method='<%=request.getParameter("method")%>';
	var RES_PROMOT='<%=res.get("MSG.PROMOT")%>';
	var RES_NOCHANGE='<%=res.get("MSG.NOCHANGE")%>';
	var RES_SAVE='<%=res.get("MSG.SAVE")%>';
	var RES_DELETE='<%=res.get("ASK.DELETE")%>';
	var RES_UNVALIDATED='<%=res.get("MSG.UNVALIDATED")%>';
	var ASK_SELETE_DELETE = '<%=res.get("UTIL.SELECT_DELETE")%>';
	var ALERT_SELECT_ONE = '<%=res.get("ALETR_SELECT_ONE")%>';
	var menuTypeId = '<%=request.getParameter("menuTypeId") %>';
	var parentMenuId = '<%=request.getParameter("parentMenuId") %>';
	var menuId = '<%=request.getParameter("menuId") %>';
	var isLeaf = '<%=request.getParameter("isLeaf") %>';
	var menuName = '<%=request.getParameter("menuName")%>';
	var isSys = '<%=request.getParameter("isSys")%>';
	var rootFlag = '<%=request.getParameter("rootFlag")%>';
	var seq = '<%=request.getParameter("seq")%>';
	var menuStruId= '<%=request.getParameter("menuStruId")%>';
</script>
</head>
<body  style="width:100%">

<model:datasets>
	<model:dataset id="menuDataSet" cmd="org.loushang.bsp.permit.menu.cmd.MenuItemQueryCmd" global="true">
		<model:record fromBean="org.loushang.bsp.permit.menu.data.MenuItem">
			<model:field name="appName" type="string" />
			<model:field name="moduleName" type="string" />
			<model:field name="functionName" type="string" />
			<model:field name="seq" type="int" />
		</model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
<next:Panel id="menuEdit" height="100%" width="100%">
	<next:TopBar>
		<next:ToolBarItem  symbol="->"  />
		<next:ToolBarItem id="submit" iconCls="save"  text='<%=res.get("BUT.SAVE")%>' handler="save_click"/>
		<next:ToolBarItem id="save" iconCls="save"  text='<%=res.get("BUT.SAVE")%>' handler="save_url_click"/>
	</next:TopBar>
<next:Html>
<form id="menutype" method="post" dataset="menuDataSet" onsubmit="return false" class="L5form">
	<input type="text" style="display:none;" name="oldMenuName" id="oldMenuName" field="menuName" />
	<input type="text" style="display:none;" name="menuTypeId" id="menuTypeId" value=<%=request.getParameter("menuTypeId") %> />
	<table width="100%">
		<tr>
			<td  class="FieldLabel" ><%=res.get("MENU_NAME")%></td>
			<td class="FieldInput" ><input  type="text" name="menuName" field="menuName" /><font color="red">*</font></td>
		</tr>
		<tr>
			<td  class="FieldLabel" ><%=res.get("MENU_PARENT")%></td>
			<td class="FieldInput" >
				<input type="text"  name="menuParentName" id="menuParentName" disabled="disabled"/>
				<input type="text" name="parentMenuId" id="parentMenuId" value=<%=request.getParameter("parentMenuId") %> style="display:none;" />
			</td>
		</tr>
	
		<tr  id="noneLeafMenuReqAction">
			<td  class="FieldLabel" ><%=res.get("REQUEST_ACTION")%></td>
			<td class="FieldInput" >
				<input type="text"  name="requestAction" id="requestAction" field="requestAction"/>
			</td>
		</tr>	
		
		<tr style="display: none">
			<td  class="FieldLabel" ><%=res.get("APP_ID")%></td>
			<td class="FieldInput" >
				<input type="text"  name="appName" id="appName" field="appName"/>
				<input type="text" style="display:none;" name="appId" id="appId" field="appId" />
				<img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>"  style="cursor:hand" />
			</td>
		</tr>
		<%

		if(request.getParameter("isLeaf")!=null&&request.getParameter("isLeaf").equals("1")){
			if(request.getParameter("isSys")!=null&&request.getParameter("isSys").equals("1")){
		%>
		<tr>
			<td  class="FieldLabel" ><%=res.get("MODULE_ID")%></td>
			<td class="FieldInput" >
				<input type="text"  name="moduleName" id="moduleName" field="moduleName"/>
				<input type="text" style="display:none;" name="moduleId" id="moduleId" field="moduleId" />
				<img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>"  style="cursor:hand" />
			</td>
		</tr>

		<tr>
			<td  class="FieldLabel" ><%=res.get("FUNCTION_ID")%></td>
			<td class="FieldInput" >
				<input type="text"  name="functionName" id="functionName" field="functionName"/>
				<input type="text" style="display:none;" name="functionId" id="functionId" field="functionId" />
				<img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>"  style="cursor:hand" />
			</td>
		</tr>
		<%
		}
		%>
		<tr>
			<td  class="FieldLabel" ><%=res.get("REQUEST_ACTION")%></td>
			<td class="FieldInput" >
				<input type="text" style="width: 350;"  name="requestAction" id="requestAction" field="requestAction"/>
			</td>
		</tr>
		<tr>
			<td  class="FieldLabel" ><%=res.get("TARGET")%></td>
			<td class="FieldInput" >
				<input type="text"  name="target" id="target" field="target"/>
			</td>
		</tr>
		
		<tr>
			<td  class="FieldLabel" ><%=res.get("MENU_ICON")%></td>
			<td class="FieldInput" >
				<input type="text" style="width: 350;" name="icon" id="icon" field="icon"/>
			</td>
		</tr> 
		
		<%
		}
		if(request.getParameter("isSys")!=null&&!request.getParameter("isSys").equals("1")){
		%>
		
		<tr>
			<td  class="FieldLabel" >顺序号</td>
			<td class="FieldInput" >
				<input type="text"  name="seq" id="seq" />
			</td>
		</tr>
		<%
		}
		%>
	</table>
</form>
</next:Html>
</next:Panel>
</next:ViewPort>
</body>
</html>