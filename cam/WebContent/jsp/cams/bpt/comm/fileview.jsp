<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.bsp.id.util.MaxValueUtil"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="com.inspur.cams.bpt.manage.cmd.BptElectronicCommand"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
	<%
	response.setHeader("Expires", "Sat, 6 May 1995 12:00:00 GMT");  
	response.setHeader("Cache-Control", "no-store,no-cache,must-revalidate");  
	response.addHeader("Cache-Control", "post-check=0, pre-check=0");  
	response.setHeader("Pragma", "no-cache");  

	String electronicId= request.getParameter("electronicId")==null?"":(String)request.getParameter("electronicId"); 
	
	%>

<html>
<head>
<title>电子资料浏览1</title>
</head>
<body>
<table border="0" width="100%" align="center">
	<%
	BptElectronicCommand bec = new BptElectronicCommand();
	java.util.HashMap m1=new java.util.HashMap();
	ArrayList<HashMap> list = (ArrayList)bec.getElectronic(electronicId);
	String rangeFlag="1";
	for (int i=0;i<list.size();i++)
	{
		m1=(HashMap)list.get(i);	
		//System.out.println(m1);
		rangeFlag=(String)m1.get("rangeFlag");
		//System.out.println(rangeFlag);
		if(rangeFlag.equals("1"))
		{			
	%>
	<tr>
		<td nowrap="nowrap" align="center">		
		<img src="<%=SkinUtils.getRootUrl(request) %>bptdownload?fileName=<%=m1.get("fileName")%>&fileId=<%=m1.get("fileId")%>"
			width="750" height="1000"><br>
			<%=m1.get("fileName")+"："%></td>
	</tr>
	<%
		}
		else
		{
	%>
	<tr>
		<td nowrap="nowrap" align="center">		
		<img src="<%=SkinUtils.getRootUrl(request) %>bptdownload?fileName=<%=m1.get("fileName")%>.jpg&fileId=<%=m1.get("fileId")%>"
			width="1000" height="750"><br>
			<%=m1.get("fileName")+"："%></td>
	</tr>
	<% 
		}
	}
	%>
	</tr>
</table>
</body>
</html>