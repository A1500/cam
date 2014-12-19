<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.portal.util.PortalJspUtil" %>
<%
  String webPath=PortalJspUtil.webPath(request);
%>
<html>
<head>
  <next:ScriptManager></next:ScriptManager>
  <title></title>
  <link rel="stylesheet" type="text/css" href="<%=webPath %>/jsp/portal/css/portal.css" />
  <script type="text/javascript" src="<%=webPath %>/jsp/portal/js/Portal.js"></script>
  <script type="text/javascript" src="<%=webPath %>/jsp/portal/index1.js"></script>
</head>
<model:datasets>
	<model:dataset id="portalWidgetDataset" cmd="org.loushang.portal.layout.cmd.PortalUserLayoutQueryCmd" global="true" method="queryCurUserPortalPageLayout">
		<model:record fromBean="org.loushang.portal.widget.data.PortalWidget"></model:record>
	</model:dataset>
	<model:dataset id="portalMenuDataset" cmd="org.loushang.portal.layout.cmd.PortalUserLayoutQueryCmd" global="true" autoLoad="true" method="queryCurUserPortalPageJson">
		<model:record fromBean="org.loushang.portal.page.data.PortalPage"></model:record>
	</model:dataset>
</model:datasets>
<body >
  <next:ViewPort>
	<next:BorderLayout>
		<next:Center>
			<next:Panel bodyStyle="overflow-y:auto">
				<next:Html >
					<img id="headImg" alt="" width="100%" height="100%" src="<%=webPath %>/jsp/public/images/pic.JPG" style="display:none"/>
				</next:Html>
				<next:Panel  id="widgetContainer" width="100%" border="false">
		          <next:Panel xtype="portal" id="portal" width="100%" border="false">
		          </next:Panel>
		          <next:Panel xtype="absportal" id="absportal" height="100%" width="100%" border="false">
		          </next:Panel>
				</next:Panel>
				<next:Panel hidden="true" id="maxWidgetContainer" width="100%" border="false" cls="l-portal-maxwidgetcontainer">
				</next:Panel>
			</next:Panel>
		</next:Center>
		<next:Right split="true" >
			<next:Panel id="widgetSelector" width="200" height="100%" 
					 bodyStyle="overflow:auto;" border="0"  collapsible="true"  collapseMode="mini">
				<next:Html >
					 <iframe height="100%" width="100%" src="<%=webPath %>/jsp/portal/help/widgethelper.jsp?isFilterWidget='1'">
					 </iframe>
				</next:Html>
			</next:Panel>
		</next:Right>
  </next:BorderLayout>
 </next:ViewPort>
</body>
</html>