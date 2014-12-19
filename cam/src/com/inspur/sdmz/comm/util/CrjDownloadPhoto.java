package com.inspur.sdmz.comm.util;


import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

public class CrjDownloadPhoto extends HttpServlet {
	/**
	 *
	 */
	public CrjDownloadPhoto() {
	}

	public void init(ServletConfig config) throws ServletException {
		super.init(config);
	}

	public void destroy() {
		super.destroy();
	}

//	public void service(HttpServletRequest requst, HttpServletResponse response)
//			throws ServletException, IOException {
//		requst.setCharacterEncoding("utf-8");
//		getBytes(requst, response);
//	}

	private static final long serialVersionUID = 5343026004456076987L;

	private static final Log logger = LogFactory.getLog(CrjDownloadPhoto.class);
	
	 public void doGet(HttpServletRequest request, HttpServletResponse response)
	   throws ServletException, IOException {
		 doPost(request,response);
	 }
	 
	 public void doPost(HttpServletRequest request, HttpServletResponse response)
	   throws ServletException, IOException {
		 request.setCharacterEncoding("utf-8");
		getBytes(request, response);
	 }


	//获取当前系统的数据源
	private static DataSource getDataSource() {
		DataSource dataSource = (DataSource) DataSourceFactory.defaultFactory.getDataSource("dataSource");
		return dataSource;
	}

	/**
	 * 输出照片
	 * @param requst
	 * @param response
	 */
    private void getBytes(HttpServletRequest requst, HttpServletResponse response) {
        byte[] blobRaw = null;
        String pk = requst.getParameter("primaryKey");
        String type = requst.getParameter("type");
        Connection conn = null;
        OutputStream outStream = null;
        if (pk != null) {
            try {
                conn = getDataSource().getConnection(); 
                if (type == null || "".equals(type)) {
                    // 正常照片表取照片
                    if (pk.length() > 6) { 
                        blobRaw = WriteOraBlob.queryBlob(conn, "COM_PHOTO_06",
                                "PHOTO_CONTENT", "PHOTO_ID", pk); 
                    } else {
                        logger.info("主键不存在，没能取到照片");
                    }
                } else if ("11".equals(type)) {
                    // 不准入境人员照片
                    blobRaw = WriteOraBlob.queryBlob(conn, "CM_NOTIN_PHOTO_DOC", "PHOTO",
                            "PEOPLE_CODE", pk);
                }  else if ("signature".equals(type)) {
                    // 手写签名照片
                    blobRaw = WriteOraBlob.queryBlob(conn, "ICM_SIGNATURE_INFO", "SIG_CONTENT",
                            "TASK_CODE", pk);
                }
                response.setHeader("Pragma", "No-cache");
                response.setHeader("Cache-Control", "no-cache");
                response.setDateHeader("Expires", 0);
               
                outStream = response.getOutputStream();
                if (blobRaw != null) {
                    outStream.write(blobRaw);
                } 
                outStream.flush();
            } catch (SQLException e) {
                 e.printStackTrace();
            } catch (IOException e) {
                 e.printStackTrace();
            } finally {
                blobRaw = null;
                try {
                    if (outStream != null) outStream.close();
                } catch (IOException e) {}
                try {
                    if (conn != null) conn.close();
                } catch (SQLException e) {}
            }
        } else {
            logger.info("主键不存在，没能取到照片");
        }
    }
}
