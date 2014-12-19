<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<html>
	<head>
		<title></title>
		<next:ScriptManager/>
		<script type="text/javascript">
		 	var organCode = '<%=BspUtil.getOrganCode()%>';
			var xmlPath = '<%=request.getParameter("xmlPath")%>';
			var enumsPath = '<%=request.getParameter("enumsPath")%>';
			var user = '<%=GetBspInfo.getBspInfo().getUserId()%>'
		</script>
		<script type="text/javascript" src="excelToTable.js"></script>
	</head>
<body>


<next:Panel  title="" autoHeight="true" autoWidth="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="yes" text="开始导入" handler="click_upload"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form id="form_content" method="post" onsubmit="return false" class="L5form">
		<table width="100%">
			
			<tr>
				<td class="FieldLabel" >Excel</td>
				<td class="FieldInput" ><input type="file" id="excel"  name="excel" field="edocuments" style="width:350"/></td>
    		</tr>
    		<tr>
    			<td class="FieldLabel">信息:</td>
    			<td class="FieldInput"><label id="msg">请选择正确的Excel模板!</label></td>
    		</tr>
		</table>
		</form>
   </next:Html>
</next:Panel>
</body>
</html>
