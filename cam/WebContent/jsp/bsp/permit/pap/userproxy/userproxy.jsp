<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ include file="/jsp/public/resources_jspdir.jsp"%>
<%@page import="org.loushang.bsp.security.context.BspInfo"%>
<%@page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@page import="org.loushang.bsp.util.DateUtil"%>

<%@page import="org.loushang.next.skin.SkinUtils"%><html>
<%  String userId = GetBspInfo.getBspInfo().getUserId();
	boolean isAdmin= GetBspInfo.getBspInfo().isAdmin();
	if(isAdmin){
	}
	//pageMode 表示当前页面是增加还是修改 pageMode='1' 是增加，pageMode='3'是修改
	String pageMode = (String) request.getParameter("pageMode");
	String proxyUserId = (String)request.getParameter("proxyUserId");
	String proxyType = (String)request.getParameter("proxyType");
	String currentDateTime=DateUtil.getCurrentDateTime();
	String nextTowMonthDateTime=DateUtil.getNextTowMonthDateTime();
%>
<head>
<meta http-equiv="Content-Tres" content="text/html; charset=utf-8">
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript">
	var RES_PROMOT='<%=res.get("MSG.PROMOT")%>';
	var RES_NOCHANGE='<%=res.get("MSG.NOCHANGE")%>';
	var RES_SAVE='<%=res.get("MSG.SAVE")%>';
	var RES_DELETE='<%=res.get("ASK.DELETE")%>';
	var RES_UNVALIDATED='<%=res.get("MSG.UNVALIDATED")%>';
	var struTypeId='<%=request.getParameter("struTypeId")%>';
	if(struTypeId == null) struTypeId = '00';
	var jsp_userId = '<%=userId%>';
	var jsp_isAdmin = '<%=isAdmin%>';
	var pageMode = '<%=pageMode%>';
	var proxyUserId = '<%=proxyUserId%>';
	var proxyType = '<%=proxyType%>';
	var currentDateTime='<%=currentDateTime%>';
	var nextTowMonthDateTime='<%=nextTowMonthDateTime%>';
</script>
	<script type="text/javascript" src="userproxy.js"></script>
</head>
<body >
<model:datasets>
	<model:dataset id="userProxyDst" cmd="org.loushang.bsp.permit.pap.userproxy.cmd.UserProxyQueryCommand" global="true">
		<model:record fromBean="org.loushang.bsp.permit.pap.userproxy.data.UserProxy">
		</model:record>
	</model:dataset>
	<model:dataset id="userProxyPermissionDataSet" cmd="org.loushang.bsp.permit.pap.userproxy.cmd.ProxyPermissionQueryCommand"
	   global="true" >
		<model:record >
			<model:field name="value" mapping="proxyPermissionId" type="string"/>
			<model:field name="text" mapping="proxyPermissionName" type="string"/>
		</model:record>
	</model:dataset>
</model:datasets>
<next:Panel width="100%" >
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="保存" handler="saveProxy" iconCls="save"></next:ToolBarItem>
		<next:ToolBarItem text="返回" handler="turnback" iconCls="undo"></next:ToolBarItem>
		<next:ToolBarItem></next:ToolBarItem>
	</next:TopBar>
	<next:Panel id="insertPanel" width="100%" hidden="true" autoScroll="true">
		<next:Html>
			<form dataset="userProxyDst" class="L5form">
			<table width="100%" >
				<tr>
					<td class="FieldLabel">委托人</td>
					<td class="FieldInput"><input type="text" id="userId" field="userId" disabled="disabled"/></td>
				</tr>
				<tr>
					<td class="FieldLabel">代理人</td>
					<td class="FieldInput"><input id="proxyUserId" field="proxyUserId" type="text" readonly="readonly" /><img id="proxyUserIdImg"
						 src="<%=SkinUtils.getImage(request,"l5/help.gif")%>" style="cursor:hand" onclick="getUser(this)" />
					<font color="red">*</font></td>
				</tr>
				<tr>
					<td class="FieldLabel">权限类型</td>
					<td class="FieldInput" ><select id="proxyType" onchange="synFiled()" >
						<option value="0">全代理</option>
					</select>
					</td>
				</tr>
				<tr>
					<td class="FieldLabel">生效日期</td>
					<td class="FieldInput"><input type="text" id="startTime" format="Ymd H:i:s"
						field="startTime" readonly="true" onclick="LoushangDatetime(this)"></td>
				</tr>
				<tr>
					<td class="FieldLabel">失效日期</td>
					<td class="FieldInput"><input type="text" id="endTime" format="Ymd H:i:s"
						 field="endTime"  readonly="true" onclick="LoushangDatetime(this)"></td>
				</tr>

			</table>
			</form>
		</next:Html>
	</next:Panel>

	<next:Panel id="updatePanel" width="100%" hidden="true" autoScroll="true">
		<next:Html>
			<form dataset="userProxyDst" class="L5form">
			<table width="100%">
				<tr>
					<td class="FieldLabel">委托人</td>
					<td class="FieldInput"><input type="text" id="userId" field="userId" disabled="disabled"/></td>
				</tr>
				<tr>
					<td class="FieldLabel">代理人</td>
					<td class="FieldInput"><input id="proxyUserId" field="proxyUserId" type="text"  disabled="disabled"/></td>
				</tr>
				<tr>
					<td class="FieldLabel">权限类型</td>
					<td class="FieldInput" ><input type="text" id="proxyType1" field="proxyType" disabled="disabled"/>
					</td>
				</tr>
				<tr>
					<td class="FieldLabel">生效日期</td>
					<td class="FieldInput"><input type="text" id="startTime" format="Ymd H:i:s"
						field="startTime" onclick="LoushangDatetime(this)"></td>
				</tr>
				<tr>
					<td class="FieldLabel">失效日期</td>
					<td class="FieldInput"><input type="text" id="endTime" format="Ymd H:i:s"
						 field="endTime" onclick="LoushangDatetime(this)"></td>
				</tr>
			</table>
			</form>
		</next:Html>
	</next:Panel>
</next:Panel>
</body>
</html>