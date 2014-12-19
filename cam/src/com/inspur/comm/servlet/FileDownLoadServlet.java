package com.inspur.comm.servlet;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.inspur.mems.sys.util.ParamDef;
import com.inspur.mems.sys.util.SysParamUtil;

public class FileDownLoadServlet extends HttpServlet {

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
	 * 
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws SQLException
	 */
	private void downLoad(HttpServletRequest request,
			HttpServletResponse response) throws ServletException {
		String uploadFilePath=SysParamUtil.getString(ParamDef.UPLOAD_FILE_PATH);
		String uploadXsFilePath=SysParamUtil.getString(ParamDef.UPLOAD_XS_FILE_PATH);

		String pageUrl = request.getHeader("Referer"); //从哪个页面跳转来的
		String project = request.getParameter("project"); // 文件是否在项目中
		String fileUrl = request.getParameter("filePath"); // 下载文件路径
		if ("studentInfo.xls".equals(fileUrl) || "enrollmentResult.xls".equals(fileUrl)) {//学生信息模板.xls、招生结果.xls
			StringBuffer pathBf=new StringBuffer();
			pathBf.append(uploadXsFilePath);
			pathBf.append(File.separator);
			pathBf.append(fileUrl);
			fileUrl=pathBf.toString();
		}
		String fileName = request.getParameter("fileName"); // 下载文件名称
		BufferedInputStream bis = null;
		BufferedOutputStream bos = null;


		try {
			if ("1".equals(project)) { // 文件路径在项目中
				fileUrl = request.getSession().getServletContext().getRealPath(
						fileUrl);
			}
			if(!fileUrl.startsWith(uploadFilePath) && !fileUrl.startsWith(uploadXsFilePath) ){
				response.setCharacterEncoding("utf-8");
				response.setContentType("application/octet-stream");
				PrintWriter pwriter = response.getWriter();
				String out = "<script type='text/javascript'>"
						+ "alert('无法获取下载文件路径！');" 
						+ "window.location='" + pageUrl
						+ "';" + "</script>";
				pwriter.write(out);
				pwriter.flush();
			}
			
			fileName = URLDecoder.decode(fileName, "utf-8");

			if (request.getHeader("User-Agent").toLowerCase()
					.indexOf("firefox") > 0) {
				fileName = new String(fileName.getBytes("UTF-8"), "ISO8859-1");// firefox浏览器
			} else if (request.getHeader("User-Agent").toUpperCase().indexOf(
					"MSIE") > 0) {
				fileName = URLEncoder.encode(fileName, "UTF-8");// IE浏览器
			}

			// 通知客户文件的MIME类型：
			File file = new File(fileUrl);

			if (file.exists()) { // 文件存在下载模板
				response.reset();
				response.setContentType("application/octet-stream");
				response.setCharacterEncoding("utf-8");
				response.setHeader("Content-Disposition",
						"attachment; filename=" + fileName);

				bis = new BufferedInputStream(new FileInputStream((file)));
				bos = new BufferedOutputStream(response.getOutputStream());
				byte[] buff = new byte[2048];
				int bytesRead;
				while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
					bos.write(buff, 0, bytesRead);
				}
				bos.flush();
			} else { // 文件不存在 response.reset();
				response.setCharacterEncoding("utf-8");
				response.setContentType("application/octet-stream");
				PrintWriter pwriter = response.getWriter();
				String out = "<script type='text/javascript'>"
						+ "alert('所要下载的文件不存在！');" 
						+ "window.location='" + pageUrl
						+ "';" + "</script>";
				pwriter.write(out);
				pwriter.flush();
			}
				 
		} catch (IOException e) {
			e.printStackTrace();
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
