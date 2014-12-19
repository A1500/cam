<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils" %>
<%@ include file="/jsp/public/resources_jspdir.jsp" %>
<%@page import="org.loushang.bsp.security.context.BspInfo"%>
<%@page import="org.loushang.bsp.security.context.GetBspInfo"%>
<next:ScriptManager/>
<html>
<%  String loginUserId = GetBspInfo.getBspInfo().getUserId();
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
<script type="text/javascript">
	var dataType=<%=request.getParameter("dataTypeRecord")%>;
	//查询条件打开合并函数
	function collapse(element){
		var fieldsetParent=L5.get(element).findParent("fieldset");
		if(element.expand==null||element.expand==true){
			fieldsetParent.getElementsByTagName("div")[0].style.display="none";
			element.src = '<%=SkinUtils.getImage(request,"groupbox_expand.gif")%>';
			element.expand=false;
		}else{
			fieldsetParent.getElementsByTagName("div")[0].style.display="";
			element.src = "<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>";
			element.expand =true;
		}
	}
	var loginUserId='<%=loginUserId%>';
</script>
<script type="text/javascript" src="user_list.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="userDataset"   pageSize="12" global="true" cmd="org.loushang.bsp.permit.pap.user.cmd.UserQueryCommand" method="queryUsers" >
	<model:record
			fromBean="org.loushang.bsp.permit.pap.user.data.UserView">
	</model:record>
	</model:dataset>
	<model:dataset id="isSysDataset" pageSize="-1" enumName="USER.IS_SYS" global="true" autoLoad="true"></model:dataset>
	<model:dataset id="accountStatusDataset" pageSize="-1" enumName="USER.ACCOUNT_STATUS" global="true" autoLoad="true"></model:dataset>
</model:datasets>
<next:ViewPort >
<next:AnchorLayout>
<next:Panel title='<%=res.get("USER.QUERY_USER") %>' anchor="100% 100%" autoScroll="false"
  border="false">
<next:Panel anchor="100% 30%" autoScroll="false" border="false">
<next:Html>
	<fieldset style="overflow: visible;" class="GroupBox">
		<legend class="GroupBoxTitle"><%=res.get("PUB_USER.SEARCH")%>
			<img class="GroupBoxExpandButton" src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>" onclick="collapse(this);"/>
		</legend>
		<div class="GroupBoxDiv" >
			<form onsubmit="return false;" class="L5form">
				<table  border="0" width="100%">
					<tr>
						<td  class="FieldLabel"><%=res.get("PUB_USER.USERID")%>：</td>
						<td class="FieldInput"><input type="text" id="userid" />
						</td>
						<td  class="FieldLabel"><%=res.get("PUB_USER.EMPLOYEE")%>：</td>
						<td class="FieldInput"><input type="text" id="employeeName"  disabled="disabled"/>
						<input type="text" id="employeeId"  style="display:none"/>
						<img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>"  style="cursor:hand" onclick="selectEmployee(this)" />
						</td>
						<td rowspan="2" class="FieldLabel"><button onclick="query()"><%=res.get("BUT.QUERY")%></button> 
						&nbsp;<button onclick="reset()">重置</button> </td>
					</tr>
					<tr>
						<td  class="FieldLabel"><%=res.get("PUB_USER.USERNAME")%>：</td>
						<td class="FieldInput"><input type="text" id="username"  />
						</td>
						<td  class="FieldLabel"><%=res.get("PUB_USER.DEPT_NAME")%>：</td>
						<td class="FieldInput"><input type="text" id="deptName"  disabled="disabled"/>
						<input type="text" id="deptId" class="TextEditor" style="display:none"/>
						<input type="text" id="organType" class="TextEditor" style="display:none"/>
						<img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>"  style="cursor:hand" onclick="selectDept(this)" />
						</td>
					</tr>
				</table>
			</form>
		</div>
	</fieldset>
</next:Html>
</next:Panel>

<next:GridPanel dataset="userDataset" height="330" autoScroll="false" border="false" anchor="100% 100%">
	<next:Columns>
	 	<next:RowNumberColumn width="30"/>
		<next:Column header='<%=res.get("PUB_USER.USERID")%>' field="USER_ID" width="200"></next:Column>
		<next:Column header='<%=res.get("PUB_USER.USERNAME")%>' field="USER_NAME" width="200"></next:Column>
		<next:Column header='<%=res.get("PUB_USER.ISSYS")%>' field="IS_SYS" renderer="isSysLabel"></next:Column>
		<next:Column header='<%=res.get("PUB_USER.ACCOUNT_STATUS")%>' field="ACCOUNT_STATUS" renderer="accountStatusLabel"></next:Column>
	</next:Columns>
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="edit" text='<%=res.get("BUT.EDIT")%>' handler="edit" />
	</next:TopBar>
	<next:BottomBar>
		<next:PagingToolBar dataset="userDataset" />
	</next:BottomBar>
</next:GridPanel></next:Panel>

</next:AnchorLayout>
</next:ViewPort>
</body>
</html>