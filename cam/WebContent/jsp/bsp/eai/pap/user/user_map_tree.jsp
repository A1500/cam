<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils" %>
<%@ include file="/jsp/public/resources_jspdir.jsp" %>

<next:ScriptManager/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
<script type="text/javascript">
	var struTypeId='<%=request.getParameter("struTypeId")%>';
	var RES_PROMOT='<%=res.get("MSG.PROMOT")%>';
	var RES_NOCHANGE='<%=res.get("MSG.NOCHANGE")%>';
	var RES_SAVE='<%=res.get("MSG.SAVE")%>';
	var RES_DELETE='<%=res.get("ASK.DELETE")%>';
	var RES_UNVALIDATED='<%=res.get("MSG.UNVALIDATED")%>';
	var ASK_SELETE_DELETE = '<%=res.get("ALETR_SELECT_DELETE")%>';
	var ALERT_SELECT_ONE = '<%=res.get("ALETR_SELECT_ONE")%>';
</script>
<script type="text/javascript" src="user_map_tree.js"></script>
</head>
<body>
<next:ViewPort>
<next:BorderLayout>
	<next:Left split="true" cmargins="5 0 0 0" margins="5 0 0 0" >
		<next:Panel title='<%=res.get("TREE.TITLE")%>' collapsible="true"  autoScroll="true" width="20%" anchor="100% 100%">
			<next:Html>
		   			<next:Tree id="usertree"  width="100%" border="false"  lines="true" >
						<next:TreeDataSet dataset="stru" root="rootdata">
							<next:TreeLoader cmd="org.loushang.bsp.organization.cmd.StruQueryCommand"  method="getEaiUserRoleTreeRoot" trigger="struLoaderTrigger">
								<next:treeRecord name="struRecord" idField="struId" fromBean="org.loushang.bsp.share.organization.bean.StruView"/>
								<next:TreeBaseparam name="parentId" value="getStruParent"></next:TreeBaseparam>
								<next:TreeBaseparam name="struId" value="getStruId"></next:TreeBaseparam>
								<next:TreeBaseparam name="struType" value="getStruType"></next:TreeBaseparam>
								<next:TreeBaseparam name="struTypeId" value="getStruTypeId"></next:TreeBaseparam>
							</next:TreeLoader>
							<next:TreeLoader cmd="org.loushang.bsp.eai.pap.user.cmd.UserQueryCommand" trigger="userLoaderTrigger" method="queryUserByOrgan">
								<next:treeRecord name="userRecord" idField="userId" fromBean="org.loushang.bsp.eai.pap.user.data.User">
								</next:treeRecord>
								<next:TreeBaseparam name="nodeType" value="getNodeType"></next:TreeBaseparam>
								<next:TreeBaseparam name="organId" value="getOrganId"></next:TreeBaseparam>
							</next:TreeLoader>
						</next:TreeDataSet>
					<next:TreeNodemodel recordType="struRecord">
						<next:TreeNodeAttribute name="text" mapping="organName"></next:TreeNodeAttribute>
						<next:TreeNodeAttribute name="disabled" handler="getStrudisabled"></next:TreeNodeAttribute>
						<next:TreeNodeAttribute name="icon" handler="getIcon" ></next:TreeNodeAttribute>
						<next:TreeNodeAttribute name="struPath" mapping="struId"></next:TreeNodeAttribute>
						<next:RightmouseMenu menuId="menuId2" trigger="isRoot">
						<next:MenuItem text='<%=res.get("USER.QUERY_USER")%>' handler="queryUser"></next:MenuItem>
					</next:RightmouseMenu>
					</next:TreeNodemodel>
					<next:TreeNodemodel recordType="userRecord">
						<next:TreeNodeAttribute name="text" handler="getUserInfo"></next:TreeNodeAttribute>
						<next:TreeNodeAttribute name="icon" handler="getIcon" ></next:TreeNodeAttribute>
						<next:TreeNodeAttribute name="leaf" handler="true"></next:TreeNodeAttribute>
						<next:Listeners>
						<next:Listener eventName="selected" handler="selectedNode"></next:Listener>
					</next:Listeners>
					</next:TreeNodemodel>
				</next:Tree>
			</next:Html>
		</next:Panel>
	 </next:Left>
	 <next:Center floatable="true">
	 	<next:Panel>
	 		<next:Html>
				<iframe id="nodeFrame" name="nodeFrame" width="100%" height="100%">
				</iframe>
			</next:Html>
	 	</next:Panel>
	 </next:Center>
  </next:BorderLayout>
</next:ViewPort>
</body>
</html>