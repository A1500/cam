<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%
    String organArea = BspUtil.getCorpOrgan().getOrganCode();
%>
<html>
<head>
<title>当前业务动态</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript"
	src="<%=SkinUtils.getJS(request, "camsCheck.js")%>"></script>
<script type="text/javascript">
	var organCode='<%=BspUtil.getOrganCode()%>';
</script>
<script type="text/javascript">
	var organArea='<%=organArea%>';
	function init(){
	}
	
</script>
</head>
<body>
<next:ViewPort>
	<next:ColumnLayout>
	<%if("0000000000".equals(organArea.substring(2,12))){ %>
		<next:Panel id="organFundsPanel" width="100%" height="100%">
			<next:Html>
				<iframe id="disMainDepartment" name="disMainDepartment"
					src="reliefMainCity.jsp" frameborder="no" border="0"
					marginwidth="0" marginheight="0" scrolling="no"
					allowtransparency="yes" width="100%" height="100%"> </iframe>
			</next:Html>
		</next:Panel>
	<%}else if("00000000".equals(organArea.substring(4,12))){ %>
		<next:Panel id="organFundsPanel" width="100%" height="100%">
			<next:Html>
				<iframe id="disMainCity" name="disMainCity"
					src="reliefMainCity.jsp" frameborder="no" border="0"
					marginwidth="0" marginheight="0" scrolling="no"
					allowtransparency="yes" width="100%" height="100%"> </iframe>
			</next:Html>
		</next:Panel>
	<%}else if("000000".equals(organArea.substring(6,12))){ %>
		<next:Panel id="organFundsPanel" width="100%" height="100%">
			<next:Html>
				<iframe id="disMainCounty" name="disMainCounty"
					src="reliefMainCounty.jsp" frameborder="no" border="0"
					marginwidth="0" marginheight="0" scrolling="no"
					allowtransparency="yes" width="100%" height="100%"> </iframe>
			</next:Html>
		</next:Panel>
	<%}else{ %>
		<next:Panel id="organFundsPanel" width="100%" height="100%">
			<next:Html>
				<iframe id="disMainTown" name="disMainTown"
					src="reliefMainTown.jsp" frameborder="no" border="0"
					marginwidth="0" marginheight="0" scrolling="no"
					allowtransparency="yes" width="100%" height="100%"> </iframe>
			</next:Html>
		</next:Panel>
	<%}%>
	</next:ColumnLayout>
</next:ViewPort>
</body>
</html>