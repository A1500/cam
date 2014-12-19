<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>

<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<title>社 会 团 体</title>
<%
	String taskCode = (String) request.getParameter("taskCode");
	taskCode = "8a898b1634bbc0ad0134bbc11aed0001";
%>
<next:ScriptManager />
<script type="text/javascript" src="../../js/float.js"></script>
<link href="../../css/float.css" type="text/css" rel="stylesheet" />
<script language="javascript">
	function SetWinHeight(obj){
		var win=obj;
		if (document.getElementById){
			if (win && !window.opera){
				if (win.contentDocument && win.contentDocument.body.offsetHeight){ 
					win.height = win.contentDocument.body.offsetHeight; 
				}else if(win.Document && win.Document.body.scrollHeight){
					//删除浮动条
					win.Document.body.removeChild(win.Document.getElementsByTagName("div")[0]);
					win.height = win.Document.body.scrollHeight;
				}
			}
		}
	}

	
</script>
</head>
<body>
<model:datasets>

</model:datasets>
<iframe marginwidth=0 marginheight=0 width=100% height="100%" onload="Javascript:SetWinHeight(this)" scrolling="no" src="../detail/groupCheckDetail01.jsp?taskCode=<%= taskCode%>" frameborder=0></iframe>
<iframe marginwidth=0 marginheight=0 width=100% height="100%" onload="Javascript:SetWinHeight(this)" scrolling="no" src="../detail/groupCheckDetail02.jsp?taskCode=<%= taskCode%>" frameborder=0></iframe>
<iframe marginwidth=0 marginheight=0 width=100% height="100%" onload="Javascript:SetWinHeight(this)" scrolling="no" src="../detail/groupCheckDetail03.jsp?taskCode=<%= taskCode%>" frameborder=0></iframe>
<iframe marginwidth=0 marginheight=0 width=100% height="100%" onload="Javascript:SetWinHeight(this)" scrolling="no" src="../detail/groupCheckDetail1.jsp?taskCode=<%= taskCode%>" frameborder=0></iframe>
<iframe marginwidth=0 marginheight=0 width=100% height="100%" onload="Javascript:SetWinHeight(this)" scrolling="no" src="../detail/groupCheckDetail2.jsp?taskCode=<%= taskCode%>" frameborder=0></iframe>
<iframe marginwidth=0 marginheight=0 width=100% height="100%" onload="Javascript:SetWinHeight(this)" scrolling="no" src="../detail/groupCheckDetail3.jsp?taskCode=<%= taskCode%>" frameborder=0></iframe>
<iframe marginwidth=0 marginheight=0 width=100% height="100%" onload="Javascript:SetWinHeight(this)" scrolling="no" src="../detail/groupCheckDetail4.jsp?taskCode=<%= taskCode%>" frameborder=0></iframe>
<iframe marginwidth=0 marginheight=0 width=100% height="100%" onload="Javascript:SetWinHeight(this)" scrolling="no" src="../detail/groupCheckDetail5.jsp?taskCode=<%= taskCode%>" frameborder=0></iframe>
<iframe marginwidth=0 marginheight=0 width=100% height="100%" onload="Javascript:SetWinHeight(this)" scrolling="no" src="../detail/groupCheckDetail6.jsp?taskCode=<%= taskCode%>" frameborder=0></iframe>
<iframe marginwidth=0 marginheight=0 width=100% height="100%" onload="Javascript:SetWinHeight(this)" scrolling="no" src="../detail/groupCheckDetail7.jsp?taskCode=<%= taskCode%>" frameborder=0></iframe>
<iframe marginwidth=0 marginheight=0 width=100% height="100%" onload="Javascript:SetWinHeight(this)" scrolling="no" src="../detail/groupCheckDetail8.jsp?taskCode=<%= taskCode%>" frameborder=0></iframe>
<iframe marginwidth=0 marginheight=0 width=100% height="100%" onload="Javascript:SetWinHeight(this)" scrolling="no" src="../detail/groupCheckDetail9.jsp?taskCode=<%= taskCode%>" frameborder=0></iframe>
<iframe marginwidth=0 marginheight=0 width=100% height="100%" onload="Javascript:SetWinHeight(this)" scrolling="no" src="../detail/groupCheckDetail10.jsp?taskCode=<%= taskCode%>" frameborder=0></iframe>
<iframe marginwidth=0 marginheight=0 width=100% height="100%" onload="Javascript:SetWinHeight(this)" scrolling="no" src="../detail/groupCheckDetail11.jsp?taskCode=<%= taskCode%>" frameborder=0></iframe>
<iframe marginwidth=0 marginheight=0 width=100% height="100%" onload="Javascript:SetWinHeight(this)" scrolling="no" src="../detail/groupCheckDetail12.jsp?taskCode=<%= taskCode%>" frameborder=0></iframe>
<iframe marginwidth=0 marginheight=0 width=100% height="100%" onload="Javascript:SetWinHeight(this)" scrolling="no" src="../detail/groupCheckDetail13.jsp?taskCode=<%= taskCode%>" frameborder=0></iframe>
<iframe marginwidth=0 marginheight=0 width=100% height="100%" onload="Javascript:SetWinHeight(this)" scrolling="no" src="../detail/groupCheckDetail14.jsp?taskCode=<%= taskCode%>" frameborder=0></iframe>
<iframe marginwidth=0 marginheight=0 width=100% height="100%" onload="Javascript:SetWinHeight(this)" scrolling="no" src="../detail/groupCheckDetail15.jsp?taskCode=<%= taskCode%>" frameborder=0></iframe>
<iframe marginwidth=0 marginheight=0 width=100% height="100%" onload="Javascript:SetWinHeight(this)" scrolling="no" src="../detail/groupCheckDetail16.jsp?taskCode=<%= taskCode%>" frameborder=0></iframe>
<iframe marginwidth=0 marginheight=0 width=100% height="100%" onload="Javascript:SetWinHeight(this)" scrolling="no" src="../detail/groupCheckDetail17.jsp?taskCode=<%= taskCode%>" frameborder=0></iframe>
<iframe marginwidth=0 marginheight=0 width=100% height="100%" onload="Javascript:SetWinHeight(this)" scrolling="no" src="../detail/groupCheckDetail18.jsp?taskCode=<%= taskCode%>" frameborder=0></iframe>
</body>
</html>

