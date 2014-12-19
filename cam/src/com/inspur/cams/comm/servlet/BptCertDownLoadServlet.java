package com.inspur.cams.comm.servlet;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class BptCertDownLoadServlet  extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		downLoad(req, resp);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		downLoad(req, resp);
	}

	/**
	 * 文件下载
	 */
	private void downLoad(HttpServletRequest request,HttpServletResponse response) throws ServletException {
		String fileUrl = request.getParameter("filePath"); // 下载文件路径
		BufferedInputStream bis = null;
		BufferedOutputStream bos = null;

		try {
			// 通知客户文件的MIME类型：
			File file = new File(fileUrl);
			if (file.exists()) { // 文件存在下载模板
				response.reset();
				response.setContentType("application/octet-stream");
				response.setCharacterEncoding("utf-8");
				bis = new BufferedInputStream(new FileInputStream((file)));
				bos = new BufferedOutputStream(response.getOutputStream());
				byte[] buff = new byte[2048];
				int bytesRead;
				while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
					bos.write(buff, 0, bytesRead);
				}
				bos.flush();
			} /*
				 * else { // 文件不存在 response.reset();
				 * response.setCharacterEncoding("utf-8");
				 * response.setContentType("application/octet-stream");
				 * PrintWriter pwriter = response.getWriter(); String out = "<script
				 * type='text/javascript'>" + "alert('文件不存在');" +
				 * "window.location='"+pageUrl+"';" + "</script>";
				 * pwriter.write(out); pwriter.flush(); }
				 */
		} catch (IOException e) {
			//e.printStackTrace();
		} finally {
			if (null != bis) {
				try {
					bis.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
				bis = null;
			}
			if (null != bos) {
				try {
					bos.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
				bos = null;
			}
		}

	}
}
