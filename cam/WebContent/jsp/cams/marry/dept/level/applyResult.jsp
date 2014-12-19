
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
	<head>
		<title>等级评定信息表编辑</title>
		<next:ScriptManager/>
		
	</head>
<body>
	<form id="form1" name="form1" action="">
 	 <div id="messages">
 	 <table align="center">
 	 <tr align="center"><td align="center">
 		 <font size="4" color="red"><%=java.net.URLDecoder.decode(request.getParameter("title"), "UTF-8")%></font>
 	 </td></tr>
 	 <tr align="left"> <td align="left" id="xianshi">
 		 
 	 </td></tr>
 	 </table>
 		 
 	 </div>
 	 
  </form>
</body>
<script type="text/javascript">
		var jgDiv4a="----------------------------";
		var heads='<font size="4" color="red">';
		var ends='</font>';
			var results='<%=request.getParameter("results")%>';
			var res=results.split(",");
			for (i=0;i<res.length ;i++ ){    
   			  document.getElementById("xianshi").innerHTML+=heads+res[i]+ends+'<br>';
  			}  
  		 
  			
		</script>
</html>