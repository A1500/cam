<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>退役士兵老年生活补助审核、审批表</title>
<next:ScriptManager />
		<script>
			var peopleId="<%=request.getParameter("peopleId")%>";
		</script>
</head>
<body>
	<input type="hidden" id="docpath"  value="jsp/cams/bpt/flow/countretiredsoldier/print/SoldierAppPrint.doc"/>
	<input type="hidden" id="peopleId" name="printQuery" queryData="queryData" value="<%=request.getParameter("peopleId")%>"/>
	<input type="hidden" id="applyId" name="printQuery" queryData="queryData" value="<%=request.getParameter("applyId")%>"/>
	<input type="hidden" id="method" name="queryData" queryData="queryData" value="querySoldierData"/>
	<input type="hidden" id="scaconfPath"  value="MartyrOffspringApp/MartyrOffspringAppPrintDao"/>
</body>
<script type="text/javascript">
	function init() { // 跳转打印页面
		var url="../../../comm/print/jspcommonprint.jsp?";
		var text='退役士兵老年生活补助审核、审批表';
		var width = 1024;
		var height = 768;
	    window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	}  
</script>

</html> 
