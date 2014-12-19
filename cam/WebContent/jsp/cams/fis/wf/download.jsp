<%@page contentType="text/html;charset=GB2312"%> 
<%@page import="java.io.*" %>
<HTML>
<BODY>   
 <%	//获得响应客户的输出流： 
  		 OutputStream   o=response.getOutputStream();   
        //输出文件用的字节数组,每次发送500个字节到输出流：
        byte b[]=new byte[500];
        //下载的文件：
          File   fileLoad=new   File(request.getSession().getServletContext().getRealPath("")+"/jsp/cams/fis/wf/","manual.doc");
        //客户使用保存文件的对话框：   
         String filename="公墓审批操作手册.doc";
        response.setHeader("Content-disposition","attachment;filename="+new String(filename.getBytes("gb2312"),"iso8859-1"));
        //通知客户文件的MIME类型：   
          response.setContentType("application/x-doc");
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
