package com.inspur.cams.dis.base.servlet;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;

import com.inspur.cams.dis.base.data.DisPhoto;

@SuppressWarnings({ "unchecked", "serial" })
public class ShowPicServlet extends HttpServlet {
	
	private static Log log = LogFactory.getLog(ShowPicServlet.class);
	
	public ShowPicServlet() {
		
	}
	
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
	}

	public void doGet(HttpServletRequest req, HttpServletResponse resp)
	   throws ServletException, IOException {
		this.doPost(req, resp);
	}
	
	
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
	   throws ServletException, IOException {
		 req.setCharacterEncoding("utf-8");
		 EntityDao<DisPhoto> dao = (EntityDao<DisPhoto>) DaoFactory
				.getDao("com.inspur.cams.dis.base.dao.support.DisPhotoDao");
		 String pid = req.getParameter("pid");
		 DisPhoto photo = dao.get(pid);
		 
		resp.setContentType("image/*");
		
		OutputStream os = null;
		InputStream in = null;
		
		try{
			os = resp.getOutputStream();
			in = photo.getPhotoContent().getInputStream();
			byte[] b = new byte[2048];
			int len = 0;
			while((len = in.read(b)) > 0) {
				os.write(b, 0, len);
			}
			os.flush();
			
		} catch(FileNotFoundException e) {
			log.error(e);
		}catch(Exception e) {
			log.error(e);
		} finally {
			if(os != null) {
				os.close();
			}
			if(in != null) {
				in.close();
			}
		}
	 }
	
	public void destroy() {
		super.destroy();
	}
}
