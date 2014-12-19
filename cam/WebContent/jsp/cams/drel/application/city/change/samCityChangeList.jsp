<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.drel.comm.RoleCmp" %>
<html>
<head>
<title>复查变更业务列表页面</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="<%=SkinUtils.getRootUrl(request)%>skins/js/ISEditPhoto.js"></script>
</head>
<body>
<!-- 加载扫描控件，解决模态窗口不加载控件的问题 -->
<div style="display:none">
  <OBJECT classid="clsid:BE09AB71-8C98-4B7A-B539-08E8F61D5453" 
    codebase=L5.webPath+"/jsp/cams/btp/comm/video.CAB#version=1,0,22,0" width=1 height=1 ></OBJECT>
</div>
<next:ViewPort>
	<next:TabPanel width="100%" height="100%">
		<next:Tabs>
		
			<%
			if(RoleCmp.getIfRoleName("城市低保业务受理审核")){
			%>
			<next:Panel title="复查结果需变更" width="100%" height="100%">
				<next:Html>
				   <iframe id="cityRecheckJieshuIframe" src="cityRecheckJieShuList.jsp"
							frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
		   		   </iframe>
				</next:Html>
			</next:Panel>
			<% 	
				}	
			%>
			
			<next:Panel title="变更业务待办" width="100%" height="100%">
				<next:Html>
				   <iframe id="applyChangeDaiBanIframe" src="samCityChangeDaiBanList.jsp?name=<%=request.getParameter("name")%>&flag=<%=request.getParameter("flag")%>"
							frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
		   		   </iframe>
				</next:Html>
			</next:Panel>
			<next:Panel title="变更业务已办" width="100%" height="100%">
				<next:Html>
				   <iframe id="applyChangeYiBanIframe" src="samCityChangeYiBanList.jsp?name=<%=request.getParameter("name")%>"
							frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
		   		   </iframe>
				</next:Html>
			</next:Panel>
			<next:Panel title="变更业务结束" width="100%" height="100%">
				<next:Html>
				   <iframe id="applyChangeJieShuIframe" src="samCityChangeJieShuList.jsp?name=<%=request.getParameter("name")%>"
							frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
		   		   </iframe>
				</next:Html>
			</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:ViewPort>
</body>
</html>