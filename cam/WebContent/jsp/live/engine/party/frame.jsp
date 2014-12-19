<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<next:ScriptManager></next:ScriptManager>
<title>联系人</title>
</head>
<body>
<next:ViewPort>
<next:TabPanel  width="530" height="100%" activeTab="0">
<next:Tabs>
<next:Panel title="用户">
<next:Html>
	<iframe src="usertree.jsp" width="530" height="100%"></iframe>	
</next:Html>
</next:Panel>
<next:Panel title="角色">
<next:Html>
	<iframe src="roletree.jsp" width="530" height="100%"></iframe>
</next:Html>
</next:Panel>
<next:Panel title="我的联系人">
<next:Html>
	<iframe src="contactList.jsp" width="530" height="100%"></iframe>
</next:Html>
</next:Panel>
</next:Tabs>
</next:TabPanel>
</next:ViewPort>
</body>
<script type="text/javascript">
window.onunload = function(){
	try{
		window.opener.partyWndExist = false;		
	}catch(e){
	}
}
</script>
</html>

<!--<next:Panel title="系统联系人">
<next:Html>
	<iframe src="sysContactList.jsp" width="530" height="100%"></iframe>
</next:Html>
</next:Panel>
-->