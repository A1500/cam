<%@page contentType="text/html;charset=GB2312"%> 
<%@page import="java.io.*" %>
<HTML>
<BODY>   
 <%	//�����Ӧ�ͻ���������� 
  		 OutputStream   o=response.getOutputStream();   
        //����ļ��õ��ֽ�����,ÿ�η���500���ֽڵ��������
        byte b[]=new byte[500];
        //���ص��ļ���
          File   fileLoad=new   File(request.getSession().getServletContext().getRealPath("")+"/jsp/cams/fis/wf/","manual.doc");
        //�ͻ�ʹ�ñ����ļ��ĶԻ���   
         String filename="��Ĺ���������ֲ�.doc";
        response.setHeader("Content-disposition","attachment;filename="+new String(filename.getBytes("gb2312"),"iso8859-1"));
        //֪ͨ�ͻ��ļ���MIME���ͣ�   
          response.setContentType("application/x-doc");
        //֪ͨ�ͻ��ļ��ĳ��ȣ�   
          long   fileLength=fileLoad.length(); 
          String   length=String.valueOf(fileLength);   
          response.setHeader("Content_Length",length);   
        //��ȡ�ļ�book.zip,�����͸��ͻ�����: 
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
