<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.bpt.manage.cmd.BptBaseinfoPeopleQueryCommand" %>
<%@page import="java.util.HashMap" %>
<%@ page import="java.util.Map"%>
<html>
<head>
<title>在乡复员军人信息查看</title>
<next:ScriptManager />
<script>
		    var familyId='<%=request.getParameter("familyId")%>';
			var peopleId='<%=request.getParameter("peopleId")%>';
			var assignmentId = <%= (String)request.getParameter("assignmentId")%>;
			var processId = <%= (String)request.getParameter("processId")%>;
		</script>
		<%
		String serviceType=null;
		Map<String, Object> Idmap = new HashMap<String, Object>();
			BptBaseinfoPeopleQueryCommand command= new BptBaseinfoPeopleQueryCommand();
					String  processId = (String)request.getParameter("processId");
					Idmap = command.queryPeopleByProcessId(processId);
					serviceType =(String) Idmap.get("serviceType");
		%>
</head>
<body>

<next:Panel autoHeight="true"  bodyStyle="width:100%" width="100%" >
	<next:TabPanel>
		<next:Tabs>
			<next:Panel title="基本信息" width="100%" height="100%">
				<next:Html>
					<iframe id="peopleInfo"
						src="../../../comm/peopleDetail.jsp?peopleId=<%=request.getParameter("peopleId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0"
						scrolling="no" allowtransparency="yes" width="100%" height="100%">
					</iframe>
				</next:Html>
			</next:Panel>
			<next:Panel id="typeTabPanel" title="类别信息" width="100%" height="100%">
				<next:Html>
					<iframe id="typeFrame"
						src=""
						frameborder="no" border="0" marginwidth="0" marginheight="0"
						scrolling="no" allowtransparency="yes" width="100%" height="100%">
					</iframe>
				</next:Html>
			</next:Panel>
			<next:Panel title="住房信息" width="100%" height="100%">
				<next:Html>
					<iframe id="house"
						src="../../../comm/houseDetail.jsp?familyId=<%=request.getParameter("familyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0"
						scrolling="no" allowtransparency="yes" width="100%" height="100%">
					</iframe>
				</next:Html>
			</next:Panel>
			<next:Panel title="家庭成员信息" width="100%" height="100%">
				<next:Html>
					<iframe id="member"
						src="../../../comm/memberListDetail.jsp?familyId=<%=request.getParameter("familyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0"
						scrolling="no" allowtransparency="yes" width="100%" height="100%">
					</iframe>
				</next:Html>
			</next:Panel>
		<next:Panel title="电子档案" width="100%" height="100%" id="uploadTabPanel">
				<next:Html>
				  <iframe id="upload" src="../../../comm/uploadfileDetail.jsp?peopleId=<%=request.getParameter("peopleId")%>&serviceType=41&applyId=<%=request.getParameter("applyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>
<script type="text/javascript">
			var url;
			var first = true;
	function init(){
	  
			var typePanel = L5.getCmp("typeTabPanel"); // 设置类别信息url
			 typePanel.on("activate",setPanel); // 设置panel的隐藏
					typePanel.on("activate",funcFrameUrl);
			
			}


	function funcFrameUrl() { //类别信息url跳转
					if(first) {
						document.getElementById("typeFrame").src=url;
						first = false;
					}	
				}
				
				
	function setPanel() { //设置panel的隐藏
		var serviceType ='<%=serviceType%>';
		if(serviceType=="41"){      
			url=L5.webPath+"/jsp/cams/bpt/flow/demobilized/applydemobilized/demobilizedInfo.jsp?peopleId=<%=request.getParameter("peopleId")%>";
		}
		if(serviceType=="45"){
			url = L5.webPath + "/jsp/cams/bpt/flow/demobilizedillness/applydemobilizedillness/demobilizedIllnessInfo.jsp?peopleId='<%=request.getParameter("peopleId")%>'";
		}
		}
</script>
</body>
</html>
