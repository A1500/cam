<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>类别信息——伤残人员</title>
<next:ScriptManager />
		<script>
			var peopleId='<%=request.getParameter("peopleId")%>';
			var applyId='<%=request.getParameter("applyId")%>';
			var serviceType='<%=request.getParameter("serviceType")%>';
			var organId='<%=BspUtil.getCorpOrgan().getOrganCode()%>';
			var adjust = '<%=request.getParameter("adjust")%>';
			var url="../../../../comm/print/jspcommonprint.jsp?";
			function init() {
				var width = 1024;
				var height = 768;
				 if(serviceType=='11'){//评残
    				document.getElementById("docpath").value = "jsp/cams/bpt/flow/disability/assessdisability/table/open_disability_apptable.doc";
    			}else if(serviceType=='12'){//调残 	
    				document.getElementById("docpath").value = "jsp/cams/bpt/flow/disability/assessdisability/table/open_disability_apptable_adjust.doc";
   				}
			    window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
			}
		</script>
</head>
<body>

						<input type="hidden" id="organId" name="organId" field="organId" />
						<input type="hidden" id="docpath" />
						<input type="hidden" id="peopleId" name="printQuery" queryData="queryData" value="<%=request.getParameter("peopleId")%>"/>
						<input type="hidden" id="applyId" name="printQuery" queryData="queryData" value="<%=request.getParameter("applyId")%>"/>
						<input type="hidden" id="organId" name="printQuery" queryData="queryData" value="<%=BspUtil.getCorpOrgan().getOrganCode()%>"/>
						<input type="hidden" id="method" name="queryData" queryData="queryData" value="queryOpenNotice"/>
						<input type="hidden" id="scaconfPath" value="assDisdislityApp/assDisdislityAppPrintDao"/>
</body>
</html>
