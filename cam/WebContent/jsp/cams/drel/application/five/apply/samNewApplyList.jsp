<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>新申请业务页面</title>
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
			
			<next:Panel title="新申请待办" width="100%" height="100%">
				<next:Html>
				   <iframe id="newApplyDaiBanIframe" src="samFiveDaiBanList.jsp?name=<%=request.getParameter("name")%>&flag=<%=request.getParameter("flag")%>"
							frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
		   		   </iframe>
				</next:Html>
			</next:Panel>
			<next:Panel title="新申请已办" width="100%" height="100%">
				<next:Html>
				   <iframe id="newApplyYiBanIframe" src="samFiveYiBanList.jsp?name=<%=request.getParameter("name")%>"
							frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
		   		   </iframe>
				</next:Html>
			</next:Panel>
			<next:Panel title="新申请结束" width="100%" height="100%">
				<next:Html>
				   <iframe id="newApplyJieShuIframe" src="samFiveJieShuList.jsp?name=<%=request.getParameter("name")%>"
							frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
		   		   </iframe>
				</next:Html>
			</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:ViewPort>
</body>
</html>