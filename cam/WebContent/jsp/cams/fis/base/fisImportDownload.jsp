<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%> 
<%@page import="java.io.*" %>
<%@page import="com.inspur.cams.fis.util.ImportDownload;"%>
<HTML>
<BODY>   
   <%
       String recordId = request.getParameter("recordId");
       String unitId = request.getParameter("unitId");
	   OutputStream   o=response.getOutputStream();   
	   //输出文件用的字节数组,每次发送500个字节到输出流：
	   byte b[]=new byte[500];
	   //下载的文件：
	     File   fileLoad=ImportDownload.downloadFile(recordId,unitId);
	   //客户使用保存文件的对话框：   
	   String fileName=request.getParameter("fileName")+"decode.sql";
	   response.setHeader("Content-disposition","attachment;filename="+fileName);
	   //通知客户文件的MIME类型：   
	     response.setContentType("application/x-download");
	   //通知客户文件的长度：   
	     long   fileLength=fileLoad.length(); 
	     String   length=String.valueOf(fileLength);   
	     response.setHeader("Content_Length",length);   
	   //读取文件book.zip,并发送给客户下载: 
	   FileInputStream in=new FileInputStream(fileLoad);
	   int n=0;
	   while((n=in.read(b))!=-1){
	   	o.write(b,0,n);
	   }
	   out.clear();  
	   out = pageContext.pushBody(); 
   %>
</BODY>   
</HTML>   
