package com.inspur.sdmz.comm.util;

 

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.sql.DataSource;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.sca.api.ComponentFactory;

import sun.misc.BASE64Decoder;

/**
 * 功能：保存采集的照片入口,包括：采集扫描照片和从摄像头获取的现场照片
 *
 * @author niewt  mailto:niewt@langchao.com
 * Created on 2006-3-13 11:05:06
 *
 * $Log$
 */
public class PhotoUtil {
 

	//	获取当前系统的数据源
	public static DataSource getDataSource() {
		DataSource dataSource = (DataSource) DataSourceFactory.defaultFactory.getDataSource("dataSource");
		return dataSource;
	}

	/**1
	 * 描述：传入从界面上获取的扫描照片的base64编码，保存照片到照片库
	 *      将返回的照片内码保存到相关的业务表中
	 *      照片类型（1：证件照片、2：现场照片、3：户籍照片、4：公安部照片）
	 *  处理非保质采集的情况
	 * @return 照片内码
	 * @throws SQLException
	 * @throws IOException
	 */
	public static String getCrjPhotoId(String base64Code, String photoKind,
			String photoType, String taskType, String taskCode,
			String creatDate, String creatOrgan, String creatOpr) {
		Connection conn = null;
		String id = "";
		try {
			conn = getDataSource().getConnection();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
			String month = sdf.format(new Date());
			id = month + IdHelp.getUUID30();
			WriteOraBlob.insertBlob(conn, id, getFromBASE64(base64Code),
					"COM_PHOTO_06", "PHOTO_ID", "PHOTO_CONTENT",
					photoKind, photoType, taskType, taskCode, creatDate,
					creatOrgan, creatOpr);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
			}
		}
		return id;
	}
	/**
	 * 描述：传入从界面上获取的扫描照片的base64编码，保存照片到照片库
	 *      将返回的照片内码保存到相关的业务表中
	 *      照片类型（1：证件照片、2：现场照片、3：户籍照片、4：公安部照片）
	 * 处理保质采集的情况
	 * @return 照片内码
	 * @throws SQLException
	 * @throws IOException
	 * author by chenlq.20091231
	 */
	public static String getCrjPhotoId(String base64Code, String photoKind,
			String photoType, String taskType, String taskCode,
			String creatDate, String creatOrgan, String creatOpr,
			String qcStatus,String qcResult,String qcDesc,String qcTime,String note) {
		Connection conn = null;
		String id = "";
		try {
			conn = getDataSource().getConnection();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
			String month = sdf.format(new Date());
			id = month + IdHelp.getUUID30();
			WriteOraBlob.insertBlob(conn, id, getFromBASE64(base64Code),
					"COM_PHOTO_" + month, "PHOTO_ID", "PHOTO_CONTENT",
					photoKind, photoType, taskType, taskCode, creatDate,
					creatOrgan, creatOpr,qcStatus,qcResult,qcDesc,qcTime,note);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
			}
		}
		return id;
	}
	/**
	 * 描述：二进制编码，保存照片到照片库
	 *      将返回的照片内码保存到相关的业务表中
	 *      照片类型（1：证件照片、2：现场照片、3：户籍照片、4：公安部照片）
	 * @return 照片内码
	 * @throws SQLException
	 * @throws IOException
	 */
	public static String getCrjPhotoId(byte[] bytes, String photoKind,
			String photoType, String taskType, String taskCode,
			String creatDate, String creatOrgan, String creatOpr) {
		Connection conn = null;
		String id = "";
		try {
			conn = getDataSource().getConnection();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
			String month = sdf.format(new Date());
			id = month + IdHelp.getUUID30();
			WriteOraBlob.insertBlob(conn, id, bytes,
					"COM_PHOTO_" + month, "PHOTO_ID", "PHOTO_CONTENT",
					photoKind, photoType, taskType, taskCode, creatDate,
					creatOrgan, creatOpr);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
			}
		}
		return id;
	}
	   /**
     * 描述：二进制编码，保存照片到照片库
     *      将返回的照片内码保存到相关的业务表中
     *      照片类型（1：证件照片、2：现场照片、3：户籍照片、4：公安部照片）
     * @return 照片内码
     * @throws SQLException
     * @throws IOException
     */
    public static boolean insertCrjPhoto(String photoId, byte[] bytes, String photoKind,
            String photoType, String taskType, String taskCode,
            String creatDate, String creatOrgan, String creatOpr) {
        boolean bOKFlag = false;
        Connection conn = null;
        try {
            if(bytes == null){
                bOKFlag = true;
            } else {
                if (photoId != null && photoId.length() > 6) {
                    conn = getDataSource().getConnection();
                    WriteOraBlob.insertBlob(conn, photoId, bytes,
                            "COM_PHOTO_" + photoId.substring(0, 6), "PHOTO_ID", "PHOTO_CONTENT",
                            photoKind, photoType, taskType, taskCode, creatDate, creatOrgan,
                            creatOpr);
                    bOKFlag = true;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (conn != null)
                    conn.close();
            } catch (SQLException e) {
            }
        }
        return bOKFlag;
    }
	/**
     * 得到照片byte数组
     * @param photoId
     * @return
     */
    public static byte[] getCrjPhotoFromId(String photoId) {
        Connection conn = null;
        byte[] photoByte = null;
        try {
            if (photoId != null && photoId.length() > 6) {
                conn = getDataSource().getConnection();
                photoByte = WriteOraBlob.queryBlob(conn, "COM_PHOTO_" + photoId.substring(0, 6),
                        "PHOTO_CONTENT", "PHOTO_ID", photoId);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (conn != null)
                    conn.close();
            } catch (SQLException e) {
            }
        }
        return photoByte;
    }
	/**
	 * 描述：传入从界面上获取的扫描照片的二进制编码，保存照片到照片库
	 *      将返回的照片内码保存到相关的业务表中
	 * @return 照片内码
	 * @throws SQLException
	 * @throws IOException
	 */
	/*public static String getCrjPhotoId(byte[] photo){
	 log.info("PhotoUtil.getCrjPhotoId----start");
	 Connection conn = null;
	 String id="";
	 try {
	 conn = getDataSource().getConnection();
	 id = "";
	 WriteOraBlob.insertBlob(conn, id, photo,"CRJ_PHOTO", "ID", "PHOTO");
	 } catch (SQLException e) {
	 // TODO 自动生成 catch 块
	 e.printStackTrace();
	 }
	 finally {
	 log.debug("finally!start");
	 try {
	 if(conn!=null)
	 conn.close();
	 } catch (SQLException e) {
	 log.debug("close conn Exception");
	 }
	 log.debug("finally!end");
	 }
	 log.info("PhotoUtil.getCrjPhotoId----end");
	 return id;
	 }*/
	/**
	 * 功能：将base64编码转换为字节流
	 *
	 * @param base64Code
	 * @return
	 */
	public static byte[] getFromBASE64(String base64Code) {

		if (base64Code == null)
			return null;
		BASE64Decoder decoder = new BASE64Decoder();
		try {
			byte[] photo = decoder.decodeBuffer(base64Code);
			return photo;
		} catch (Exception e) {
			return null;
		}
	}

 
}
