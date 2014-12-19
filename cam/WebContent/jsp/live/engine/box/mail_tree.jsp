<%@ page contentType="text/html; charset=utf-8" %>

<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>我的邮箱</title>	
<next:ScriptManager/>
<script type="text/javascript" src="mail_tree.js"></script>
</head>
<body>
<next:ViewPort>
<next:BorderLayout>
	<next:Left split="true" cmargins="5 0 0 0" margins="5 0 0 0" >
	<next:Panel collapsible="true" height="100%" autoScroll="true" width="20%" >
		<next:Html>
		<next:Tree name="strutree" width="100%" id="strutree" title="我的邮箱" height="500" autoScroll="true" lines="true" >
		  <next:TreeDataSet dataset="mailTreeDataset" root="rootdata">
			<next:TreeLoader cmd="org.loushang.live.engine.view.MailBoxQueryCmd">
 				<next:treeRecord name="mailRecord" idField="boxId" fromBean="org.loushang.live.engine.persist.bean.MessageBoxBean">
				</next:treeRecord> 
				<next:TreeBaseparam name="parentId" value="getMailParent"/>
			</next:TreeLoader>			
		</next:TreeDataSet>
		
		<next:TreeNodemodel recordType="mailRecord">
			
			<next:TreeNodeAttribute  name="text" mapping="boxName">
			</next:TreeNodeAttribute>
			<!--定义树节点的右键菜单-->
			<next:RightmouseMenu trigger="handler"  menuId="menuId2">
				<next:MenuItem text="添加其他邮箱" handler="addStru"></next:MenuItem>
			</next:RightmouseMenu>
			<next:Listeners>
				<next:Listener eventName="selected" handler="selectNode">
			</next:Listener>
			</next:Listeners>
		</next:TreeNodemodel>
	</next:Tree>
	</next:Html>
	</next:Panel>
	</next:Left>
	 <next:Center floatable="true">
	 	<next:Panel autoScroll="false" width="100%">
	 		<next:Html>
				<iframe id="nodeFrame" name="nodeFrame" width="100%" scrolling="yes" height="100%" >
				</iframe>
			</next:Html>
	 	</next:Panel>
	 </next:Center>	
</next:BorderLayout>
</next:ViewPort>	
</body>
</html>
