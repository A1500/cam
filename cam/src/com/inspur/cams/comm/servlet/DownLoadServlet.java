package com.inspur.cams.comm.servlet;

import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.bpt.bptelectronicfile.cmd.BptUploadfileCommand;
import com.inspur.cams.bpt.bptelectronicfile.dao.BptUploadfileDao;
import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

public class DownLoadServlet extends HttpServlet {
	private final String TABLE = "table";
	private final String COLUMN = "column";
	private final String PKNAME = "pk";
	private final String SHRINK = "shrink";
	private BptUploadfileDao dao = (BptUploadfileDao) DaoFactory
	.getDao("com.inspur.cams.bpt.bptelectronicfile.dao.BptUploadfileDao");
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		try {
			downLoad(req, resp);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		try {
			downLoad(req, resp);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	private void downLoad(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, SQLException {

		try {
			String shrink="false";
			String fileId =req.getParameter("fileId");
			BptUploadfileCommand bptUploadfileCommand = new BptUploadfileCommand();
			DataSet ds = bptUploadfileCommand.fileloadByid(fileId);
			String fileadd =(String)ds.getRecord(0).get("filePath");
			String fileName =(String)ds.getRecord(0).get("fileName");
			String filetype = (String)ds.getRecord(0).get("fileType");
			String filePath = fileadd+filetype;
			FileInputStream fileBytes;
			fileBytes = new FileInputStream(new File(filePath));
				/*InputStream fileBytes = new BufferedInputStream(blob
						.getBinaryStream());*/
			if (req.getHeader("User-Agent").toLowerCase().indexOf("firefox") >0)
			{
				fileName = new String(fileName.getBytes("UTF-8"), "ISO8859-1");// firefox浏览器
			}else if (req.getHeader("User-Agent").toUpperCase().indexOf("MSIE") >0)
			{
				fileName = URLEncoder.encode(fileName, "UTF-8");// IE浏览器
			}

				resp.reset();
				resp.setContentType("application/octet-stream");
				resp.setHeader("Content-Disposition", "attachment;"+(fileName==null?"":"filename="+fileName));
				OutputStream toClient = new BufferedOutputStream(resp.getOutputStream());
				if ("true".equals(shrink)) {
					Image src = javax.imageio.ImageIO.read(fileBytes);
					BufferedImage tag = new BufferedImage(60, 60,
							BufferedImage.TYPE_INT_RGB);
					tag.getGraphics().drawImage(src, 0, 0, 60, 60, null); // 绘制缩小后的图
					JPEGImageEncoder encoder = JPEGCodec
							.createJPEGEncoder(toClient);
					encoder.encode(tag); // 近JPEG编码
				} else {
					int bytes;
					while ((bytes = fileBytes.read()) != -1) {
						toClient.write(bytes);
					}
				}
				fileBytes.close();
				toClient.flush();
				toClient.close();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {

		}
	}
}
