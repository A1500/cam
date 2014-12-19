<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<script type="text/javascript">
</script>
<html>
<head>
<title>公墓年检信息</title>
<next:ScriptManager />
<script>
	var idField='<%=request.getParameter("idField")%>';
	var checkNum='<%=request.getParameter("checkNum")%>';
</script>
<script type="text/javascript" src="profitInspection_detail.js"></script>
</head>
<body>
<next:ViewPort>
	<next:AnchorLayout>
		<next:Panel width="100%" height="100%">
			<next:TabPanel width="100%" height="100%" id="tab">
				<next:Tabs>

					<next:Panel title="公墓基本信息 ">
						<next:Html>
							<iframe id="cemeteryinformation"
								src="profitCemeteryInfo.jsp?dataBean=<%=request.getParameter("idField")%>"
								frameborder="no" border="0" marginwidth="0" marginheight="0"
								scrolling="no" allowtransparency="yes" width="100%" height="99%">
							</iframe>
						</next:Html>
					</next:Panel>

					<next:Panel title="公墓年检打分情况" id="profit">
						<next:Html>
							<iframe id="profit_score"
								src="profit_score.jsp?dataBean=<%=request.getParameter("idField")%>"
								frameborder="no" border="0" marginwidth="0" marginheight="0"
								scrolling="no" allowtransparency="yes" width="100%" height="99%">
							</iframe>
						</next:Html>
					</next:Panel>

					<next:Panel title="分数合计及年检报告">
						<next:Html>
							<iframe id="annualreport"
								src="annualreport_score.jsp?dataBean=<%=request.getParameter("idField")%>&checkNum=<%=request.getParameter("checkNum")%>"
								frameborder="no" border="0" marginwidth="0" marginheight="0"
								scrolling="no" allowtransparency="yes" width="100%" height="99%">
							</iframe>
						</next:Html>
					</next:Panel>

					<next:Panel title="公墓年检附件信息">
						<next:Html>
							<iframe id="businessmaterials"
								src="businessmaterials.jsp?dataBean=<%=request.getParameter("idField")%>"
								frameborder="no" border="0" marginwidth="0" marginheight="0"
								scrolling="no" allowtransparency="yes" width="100%" height="99%">
							</iframe>
						</next:Html>
					</next:Panel>

				</next:Tabs>
			</next:TabPanel>
		</next:Panel>
	</next:AnchorLayout>
</next:ViewPort>
</body>
</html>
