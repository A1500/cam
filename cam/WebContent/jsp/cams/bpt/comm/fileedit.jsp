<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="org.loushang.next.dao.DaoFactory"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
	<%
	response.setHeader("Expires", "Sat, 6 May 1995 12:00:00 GMT");  
	response.setHeader("Cache-Control", "no-store,no-cache,must-revalidate");  
	response.addHeader("Cache-Control", "post-check=0, pre-check=0");  
	response.setHeader("Pragma", "no-cache");  

	String electronicId= request.getParameter("electronicId")==null?"":(String)request.getParameter("electronicId"); 
	//System.out.println("sdfsd"+electronicId);
	com.inspur.cams.bpt.base.dao.jdbc.BptElectronicDao BptElectronicDao = (com.inspur.cams.bpt.base.dao.jdbc.BptElectronicDao) DaoFactory.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptElectronicDao");	
	Connection conn=null;
	Statement stmt=null;
	java.util.ArrayList list=new java.util.ArrayList();
	try
	{
		conn=BptElectronicDao.getDataSource().getConnection();
		stmt=conn.createStatement();
		StringBuffer sql=new StringBuffer("select b.file_id,file_name,range_flag,view_order from" +
 				"(select f.file_id,f.file_name,nvl(range_flag,'1') as range_flag,view_order" +
 				"  from bpt_uploadfile f" +
 				" where f.file_id in" +
 				"       (select a.file_id" +
 				"          from bpt_electronic_file a" +
 				"         where a.electronic_id = '"+electronicId+"') " +
 				"         ) b order by view_order,file_id");		
		//System.out.println(sql.toString());
		ResultSet res=stmt.executeQuery(sql.toString());		
		while(res.next())
		{
			java.util.HashMap m=new java.util.HashMap();
			m.put("fileId",res.getString(1));
			m.put("fileName",res.getString(2));
			m.put("rangeFlag",res.getString(3));
			list.add(m);
			//System.out.println("m="+m);
		}
		res.close();
	}catch(Exception e)
	{
		e.printStackTrace();
	}finally{
		if(stmt!=null)stmt.close();
		if(conn!=null)	conn.close();
		
	}
	
	%>

<html>
<head>
<next:ScriptManager/>	
<title>电子资料浏览</title>
<script type="text/javascript" src="fileedit.js"></script>
</head>
<body background="#f4f4f4">

	<table border="0" width="100%" align="center">
		<%
		java.util.HashMap m1=new java.util.HashMap();
		String rangeFlag="1";
		int gs=0;
		int count=0;
		String outprint_tr="<tr>";
		String outprint_td="<td nowrap=\"nowrap\" align=\"center\">";
		String outprint_cont="";
		count=list.size()%5;
		for (int i=0;i<list.size();i++)
		{
			
			gs=i%5;			
			//System.out.println("gs="+gs+"count="+count);
			m1=(HashMap)list.get(i);	
			//System.out.println(m1);
			rangeFlag=(String)m1.get("rangeFlag");
			//System.out.println(rangeFlag);
			
			if(gs==0)
			{
				outprint_cont="";
				%>
				 <tr>
				 <% 
			}
			outprint_cont=outprint_cont+outprint_td+"&nbsp;<a href=\"#\" style=\"color:blue;text-decoration:none\" onclick=\"fileEdit(\'"+electronicId+"\',\'"+m1.get("fileId")+"\')\">修改</a>&nbsp;<a href=\"#\" style=\"color:blue;text-decoration:none\" onclick=\"fileDelete(\'"+electronicId+"\',\'"+m1.get("fileId")+"\')\">删除</a>&nbsp;</br>"+m1.get("fileName")+"</td>";
				if(rangeFlag.equals("1"))
				{			
		%>	
				<td nowrap="nowrap" align="center">						
					<img src="<%=SkinUtils.getRootUrl(request) %>bptdownload?fileName=<%=m1.get("fileName")%>&fileId=<%=m1.get("fileId")%>"	width="150" height="200">
				</td>				
		<%				
				}
				else
				{
		%>
				<td nowrap="nowrap" align="center">		
				<img src="<%=SkinUtils.getRootUrl(request) %>bptdownload?fileName=<%=m1.get("fileName")%>.jpg&fileId=<%=m1.get("fileId")%>"	width="150" height="200">
				</td>
				
		<% 
				}
			if(gs==4)
			{
				%>
			 	</tr>
				<% 
				out.print(outprint_tr+outprint_cont+"</tr>");
			}
			
		}
		%>
			</tr>
		<%
		if(count!=0)
		{
			//System.out.println("gssdfsdfsdf");
			out.print(outprint_tr+outprint_cont+"</tr>");
		}
		%>
	
	</table>
	
</body>
</html>