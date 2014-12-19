<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<script type="text/javascript">
</script>
<html>
<head>
<title>伤病残退役士兵信息</title>
<next:ScriptManager />
<script>
	var idField='<%=request.getParameter("idField")%>';
	var method='<%=request.getParameter("method")%>';
	var type='<%=request.getParameter("type")%>';
</script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'>
</script>
<script type="text/javascript" src="illretiredsodiersdetail.js"></script>
</head>
<body>
<next:Panel autoHeight="true" bodyStyle="width:100%">
	<next:TabPanel>
		<next:Tabs>
			<next:Panel title="伤病残退役士兵基本信息">
				<next:Html>
					<iframe id="instanceDisability"
						src="../prsretiredsoldiers/prsretiredsoldiers_edit.jsp?dataBean=<%=request.getParameter("idField")%>&method=<%=request.getParameter("method")%>&type=<%=request.getParameter("type")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0"
						scrolling="no" allowtransparency="yes" width="100%" height="500">
					</iframe>
				</next:Html>
			</next:Panel>
			<next:Panel title="伤病残退役士兵部队信息" id="armyInfo">
				<next:Html>
					<iframe id="instanceDisability"
						src="../prssoldiersarmy/prssoldiersarmy_edit.jsp?dataBean=<%=request.getParameter("idField")%>&method=<%=request.getParameter("method")%>&type=<%=request.getParameter("type")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0"
						scrolling="no" allowtransparency="yes" width="100%" height="450">
					</iframe>
				</next:Html>
			</next:Panel>
			<next:Panel title="伤病残退役士兵培训信息" id="trainInfo">
				<next:Html>
					<iframe id="instanceDisability"
						src="../prssoldierstrain/prssoldierstrain_edit.jsp?dataBean=<%=request.getParameter("idField")%>&method=<%=request.getParameter("method")%>&type=<%=request.getParameter("type")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0"
						scrolling="no" allowtransparency="yes" width="100%" height="450">
					</iframe>
				</next:Html>
			</next:Panel>
			<next:Panel id="placementInfo" title="接收安置信息">
				<next:Html>
					<iframe id="instanceDisability"
						src="../prssoldiersplacement/prssoldiersplacement_edit.jsp?dataBean=<%=request.getParameter("idField")%>&method=<%=request.getParameter("method")%>&type=<%=request.getParameter("type")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0"
						scrolling="no" allowtransparency="yes" width="100%" height="450">
					</iframe>
				</next:Html>
			</next:Panel>

		</next:Tabs>
	</next:TabPanel>
</next:Panel>
</body>
</html>
