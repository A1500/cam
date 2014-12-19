<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>救助需求分析</title>
<next:ScriptManager />
<script type="text/javascript" src="reqList.js"></script>
<script language="javascript">
		var organCode = '<%=BspUtil.getOrganCode()%>';
		var organType = '<%=BspUtil.getOrganType()%>';
		var organName = '<%=BspUtil.getOrganName()%>';
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
</head>
<body>
<next:Panel id="reqPanel" width="100%" height="100%">
	<next:Html>
		<iframe id="reqFrame" name="reqFrame" frameborder="no" border="0"
			marginwidth="0" marginheight="0" scrolling="no"
			allowtransparency="yes" width="100%" height="100%"> </iframe>
	</next:Html>
</next:Panel>
</body>
</html>
