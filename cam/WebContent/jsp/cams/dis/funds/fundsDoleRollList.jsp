<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<html>
<head>
<title>资金发放名册管理</title>
<next:ScriptManager />
<%
	String flag=request.getParameter("flag");
%>
<script language="javascript">
 	 var organCode = '<%=BspUtil.getOrganCode()%>';
	 var organName = '<%=BspUtil.getOrganName()%>';
     var organType = '<%=BspUtil.getOrganType()%>';
     var ifDetail = '<%=request.getParameter("ifDetail")%>';
     var batchId = '<%=request.getParameter("batchId")%>';
     var batchDetailId = '<%=request.getParameter("batchDetailId")%>';
     var doleId = '<%=request.getParameter("doleId")%>';
     var uu32='<%=IdHelp.getUUID32()%>';
     
 	 //查询条件打开合并函数
	 function collapse(element){
		var fieldsetParent=L5.get(element).findParent("fieldset");
		if(element.expand==null||element.expand==true){
			fieldsetParent.getElementsByTagName("div")[0].style.display="none";
			element.src = '<%=SkinUtils.getImage(request, "groupbox_expand.gif")%>';
			element.expand=false;
		}else{
			fieldsetParent.getElementsByTagName("div")[0].style.display="";
			element.src = "<%=SkinUtils.getImage(request, "groupbox_collapse.gif")%>";
			element.expand =true;
		}
	}
</script>
<script type="text/javascript"
	src="<%=SkinUtils.getJS(request, "cams.js")%>"></script>
<script type="text/javascript"
	src="<%=SkinUtils.getJS(request, "camsCheck.js")%>"></script>
<script type="text/javascript" src="../../comm/disComm.js"></script>
</head>
<body>

<next:Panel title="分析汇总" width="100%" height="100%">
	<next:Html>
		<% 
				if("CJ".equals(flag)){
		%>
		<iframe id="cjSumList" name="cjSumList"
			src='../dole/cj/cjDoleRollList.jsp?batchId=<%=request.getParameter("batchId")%>&batchDetailId=<%=request.getParameter("batchDetailId")%>&doleId=<%=request.getParameter("doleId")%>&ifDetail=T'
			frameborder="no" border="0" marginwidth="0" marginheight="0"
			scrolling="no" allowtransparency="yes" width="100%" height="100%">
		</iframe>
		<%
				}else{
		%>
		<iframe id="dcSumList" name="dcSumList"
			src='../dole/dc/dcDoleRollList.jsp?batchId=<%=request.getParameter("batchId")%>&batchDetailId=<%=request.getParameter("batchDetailId")%>&doleId=<%=request.getParameter("doleId")%>&ifDetail=T'
			frameborder="no" border="0" marginwidth="0" marginheight="0"
			scrolling="no" allowtransparency="yes" width="100%" height="100%">
		</iframe>
		<%
				}
		%>
	</next:Html>
</next:Panel>
</body>
</html>