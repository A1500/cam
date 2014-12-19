<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<script type="text/javascript">
</script>
<html>
<head>
<title>退役士兵信息</title>
<next:ScriptManager />
<script>
			var idField='<%=request.getParameter("idField")%>';
</script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'>
</script>
<script type="text/javascript" src="prsretiredsoldiers_detail.js"></script>
</head>
<body>

<next:Panel  bodyStyle="width:100%;height:100% ">
	<next:TabPanel>
		<next:Tabs>
			<next:Panel title="退役士兵基本信息">
				<next:Html>
					<iframe id="insability"
						src="../readonly/prsretiredsoldiers.jsp?dataBean=<%=request.getParameter("idField")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0"
						scrolling="no" allowtransparency="yes" width="100%" height="530">
					</iframe>
				</next:Html>
			</next:Panel>

			<next:Panel title="退役士兵部队信息">
				<next:Html>
					<iframe id="instanceability"
						src="../readonly/prssoldiersarmy.jsp?dataBean=<%=request.getParameter("idField")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0"
						scrolling="no" allowtransparency="yes" width="100%" height="450">
					</iframe>
				</next:Html>
			</next:Panel>
			
			<next:Panel title="退役士兵培训信息">
				<next:Html>
					<iframe id="instanceDisability"
						src="../readonly/prssoldierstrain.jsp?dataBean=<%=request.getParameter("idField")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0"
						scrolling="no" allowtransparency="yes" width="100%" height="450">
					</iframe>
				</next:Html>
			</next:Panel>
			
			<next:Panel id="placementInfo" title="接收安置信息" >
				<next:Html>
					<iframe id="instanceDisability"
						src="../readonly/prssoldiersplacement.jsp?dataBean=<%=request.getParameter("idField")%>"
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
