<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<next:ScriptManager/>
<html>
<head>
<title>单位人员管理</title>
<%
	String userId= "370000000000";
%>
<script type="text/javascript" src="jcmManage.js"></script>
<script type="text/javascript">
	var userId ='<%=userId%>';
	var loginName='<%=""%>';
	var peopleArea='<%=""%>';
</script>
</head>
<body>
<next:ViewPort>
<next:BorderLayout>
	<next:Left split="true" cmargins="5 0 0 0" margins="5 0 0 0">
		<next:Panel title="单位人员管理" collapsible="true" autoScroll="true" width="20%" anchor="100% 100%">
			<next:Html>
				<next:Tree id="companytree" width="100%" border="false" lines="true">
					<next:TreeDataSet dataset="stru" root="rootdata">
						<next:TreeLoader cmd="com.inspur.cams.jcm.cmd.JcmCompanyProfileQueryCmd" method="getOrgan" trigger="cityTrigger">
							<next:treeRecord name="cityRecord" idField="companyId" fromBean="com.inspur.cams.jcm.data.JcmCompanyProfile"/>
							<next:TreeBaseparam name="companyId" value="getId"></next:TreeBaseparam>
							<next:TreeBaseparam name="companyName" value="getName"></next:TreeBaseparam>
							<next:TreeBaseparam name="organType" value="getLeve"></next:TreeBaseparam>
							<next:TreeBaseparam name="orderCompanyId" value="getUps"></next:TreeBaseparam>
						</next:TreeLoader>
  						<next:TreeLoader cmd="com.inspur.cams.jcm.cmd.JcmPeopleInfoQueryCmd" method="getPeople" trigger="userTrigger">
							<next:treeRecord name="userRecord" idField="peopleId" fromBean="com.inspur.cams.jcm.data.JcmPeopleInfo"/>
							<next:TreeBaseparam name="peopleId" value="getPeopleId"></next:TreeBaseparam>
							<next:TreeBaseparam name="companyId" value="getId"></next:TreeBaseparam>
							<next:TreeBaseparam name="peopleName" value="getPeopleName"></next:TreeBaseparam>
						</next:TreeLoader>
					</next:TreeDataSet>
					<next:TreeNodemodel recordType="cityRecord">
						<next:TreeNodeAttribute name="text" mapping="companyName"></next:TreeNodeAttribute>
						<next:TreeNodeAttribute name="disabled" handler="getStrudisabled"></next:TreeNodeAttribute>
						<next:TreeNodeAttribute name="icon" handler="getIcon"></next:TreeNodeAttribute>
						<next:RightmouseMenu menuId="cityMenu">
							<next:MenuItem text="增加单位" handler="addOrgan"></next:MenuItem>
							<next:MenuItem text="增加部门" handler="addDept"></next:MenuItem>
							<next:MenuItem text="增加人员" handler="addPeo"></next:MenuItem>
							<next:MenuItem text="修改单位" handler="editOrgan"></next:MenuItem>
							<next:MenuItem text="删除单位" handler="delCom"></next:MenuItem>
						</next:RightmouseMenu>
						<next:RightmouseMenu trigger="handlerOther"  menuId="menuId3">
							<next:MenuItem text="增加人员" handler="addPeo"></next:MenuItem>
							<next:MenuItem text="修改部门" handler="editDept"></next:MenuItem>
							<next:MenuItem text="删除部门" handler="delCom"></next:MenuItem>
						</next:RightmouseMenu>
						<next:Listeners>
							<next:Listener eventName="selected" handler="comSelect"></next:Listener>
						</next:Listeners>
					</next:TreeNodemodel>
					<next:TreeNodemodel recordType="userRecord">
						<next:TreeNodeAttribute name="text" mapping="peopleName"></next:TreeNodeAttribute>
						<next:TreeNodeAttribute name="icon" handler="getIcon"></next:TreeNodeAttribute>
						<next:TreeNodeAttribute name="leaf" handler="true"></next:TreeNodeAttribute>
						<next:RightmouseMenu menuId="userMenu">
							<next:MenuItem text="修改人员" handler="editUser"></next:MenuItem>
							<next:MenuItem text="删除人员" handler="delUser"></next:MenuItem>
						</next:RightmouseMenu>
						<next:Listeners>
							<next:Listener eventName="selected" handler="peoSelect"></next:Listener>
						</next:Listeners>
					</next:TreeNodemodel>
				</next:Tree>
			</next:Html>
		</next:Panel>
	</next:Left>
	<next:Center floatable="true">
		<next:Panel>
			<next:Html><iframe id="nodeFrame" name="nodeFrame" width="100%" height="100%"></iframe></next:Html>
		</next:Panel>
	</next:Center>
</next:BorderLayout>
</next:ViewPort>
</body>
</html>