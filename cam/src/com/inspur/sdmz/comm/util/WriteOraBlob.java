package com.inspur.sdmz.comm.util;


import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.lang.reflect.InvocationTargetException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import oracle.sql.BLOB;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * 功能：向数据库表blob列类型的字段增删改数据的公用类
 * 
 * @author zhangshm mailto:zhangshm@langchao.com Created on 2006-12-21 17:55:06
 * 
 * $Log$
 */

public class WriteOraBlob {
	private static Log log = LogFactory.getLog(PhotoUtil.class);

	private static String getWhere(String[] keyName, String[] value) {
		StringBuffer sql = new StringBuffer();
		int len = keyName.length;
		for (int i = 0; i < len; i++) {
			if (i > 0)
				sql.append(" and ");

			sql.append(" (");
			sql.append((String) keyName[i]);
			sql.append("='");
			sql.append((String) value[i]);
			sql.append("')");

		}

		return sql.toString();
	}

	private static String getKeyValue(String[] value) {
		StringBuffer sql = new StringBuffer();
		int len = value.length;
		for (int i = 0; i < len; i++) {
			if (i > 0)
				sql.append(",");
			sql.append("'");
			sql.append((String) value[i]);
			sql.append("'");

		}

		return sql.toString();
	}

	/**
	 * 
	 * @param conn（数据库连接）
	 * @param dataId
	 *            多主键采用"，"分割
	 * @param data（插入到blob字段的数据：byte[]类型）
	 * @param tableName（表名）
	 * @param keyName
	 *            （主键列名）多主键采用"，"分割 ,并于dataid对应（主键列名）
	 * @param blobName（blob字段的列名）
	 * @throws SQLException
	 * @throws SQLException
	 * @throws IOException
	 * @throws IOException
	 */
	public static void insertBlob(Connection conn, String dataId, byte[] data,
			String tableName, String keyName, String blobName,
			String photoKind, String photoType, String taskType,
			String taskCode, String creatDate, String creatOrgan,
			String creatOpr) {
		Statement stmt = null;
		ResultSet result = null;
		boolean defaultCommit = false;
		OutputStream outStream = null;
		/* 设置为不能自动提交 */
		try {
			defaultCommit = conn.getAutoCommit();
			conn.setAutoCommit(false);

			StringBuffer QuerySQL = new StringBuffer();
			StringBuffer EmptyQuerySQL = new StringBuffer();
			StringBuffer chekexistSQL = new StringBuffer();
			stmt = conn.createStatement();

			chekexistSQL.append("SELECT * FROM ").append(tableName).append(
					" WHERE ").append(
					getWhere(keyName.split(","), dataId.split(",")));

			EmptyQuerySQL
					.append("INSERT INTO ")
					.append(tableName)
					.append("(")
					.append(keyName)
					.append(",")
					.append(blobName)
					.append(",")
					.append(
							"PHOTO_KIND,PHOTO_TYPE,TASK_TYPE,TASK_CODE,CREATE_DATE,CREATE_ORGAN,CREATE_OPR,PHOTO_SIZE,QC_STATUS,QC_RESULT,QC_DESC,QC_TIME,NOTE")
					.append(") VALUES (")
					.append(getKeyValue(dataId.split(","))).append(
							",empty_blob()").append(",'").append(photoKind)
					.append("','").append(photoType).append("','").append(
							taskType).append("','").append(taskCode).append(
							"','").append(creatDate).append("','").append(
							creatOrgan).append("','").append(creatOpr).append(
							"','").append(data.length)
							.append("','").append("")
							.append("','").append("")
							.append("','").append("")
							.append("','").append("")
							.append("','").append("")
							.append("')");

			QuerySQL.append("SELECT  ").append(blobName).append(" FROM ")
					.append(tableName).append(" ").append(" WHERE ").append(
							getWhere(keyName.split(","), dataId.split(",")))
					.append(" FOR UPDATE");

			result = stmt.executeQuery(chekexistSQL.toString());
			if (!result.next()) {
				/* 插入空的附件 sql 中包含empty_blob() */
				stmt.executeUpdate(EmptyQuerySQL.toString());
			}

			/* 查询此BLOB对象并锁定 */
			result = stmt.executeQuery(QuerySQL.toString());

			if (result.next()) {
//				oracle.sql.BLOB blob = (oracle.sql.BLOB) result.getBlob(blobName);
//				outStream = blob.getBinaryOutputStream();
//				// data是传入的byte数组，定义：byte[] data
//				outStream.write(data, 0, data.length);
//				outStream.flush();'
			 

				 Object obj = result.getBlob(blobName);
				 Class clazz = obj.getClass();
				 java.lang.reflect.Method method;
				try {
					 method = clazz.getMethod("getBinaryOutputStream", new Class[]{});
					 outStream = (OutputStream)method.invoke(obj, new Object[]{});
				} catch (Exception e) {
					e.printStackTrace();
				} 
			     BufferedOutputStream bos = new BufferedOutputStream(outStream);
			     //bos.write(data, 0, data.length);
			     bos.write(data);
			     bos.flush();
			     //outStream.write(data, 0, data.length);
			     //outStream.flush();
			} else {
				 //log.info("没有找到数据result=" + result.toString());
			}
			/* 正式提交 */
			conn.commit();

		} catch (IOException e) {
			throw new RuntimeException("保存照片失败!"+e.getMessage());
		} catch (SQLException e) {
			throw new RuntimeException("保存照片失败!"+e.getMessage());
		} finally {
			try {
				if (outStream != null)
					outStream.close();
			} catch (IOException e1) {
				// TODO 自动生成 catch 块
			}
			try {
				if (result != null)
					result.close();
			} catch (SQLException e) {
				// log.debug("close result Exception");
			}
			try {
				if (stmt != null)
					stmt.close();
			} catch (SQLException e) {
				// log.debug("close stmt Exception");
			}
			try {
				if (conn != null)
					conn.setAutoCommit(defaultCommit);
			} catch (SQLException e) {
				// log.debug("close conn Exception");
			}
			// log.debug("finally!end");
		}
	}
	/**
	 * 保质采集  author by chenlq.20091231
	 * @param conn（数据库连接）
	 * @param dataId
	 *            多主键采用"，"分割
	 * @param data（插入到blob字段的数据：byte[]类型）
	 * @param tableName（表名）
	 * @param keyName
	 *            （主键列名）多主键采用"，"分割 ,并于dataid对应（主键列名）
	 * @param blobName（blob字段的列名）
	 * @throws SQLException
	 * @throws SQLException
	 * @throws IOException
	 * @throws IOException
	 */
	public static void insertBlob(Connection conn, String dataId, byte[] data,
			String tableName, String keyName, String blobName,
			String photoKind, String photoType, String taskType,
			String taskCode, String creatDate, String creatOrgan,
			String creatOpr,String qcStatus,String qcResult,String qcDesc,String qcTime,String note) {
		Statement stmt = null;
		ResultSet result = null;
		boolean defaultCommit = false;
		OutputStream outStream = null;
		/* 设置为不能自动提交 */
		try {
			defaultCommit = conn.getAutoCommit();
			conn.setAutoCommit(false);

			StringBuffer QuerySQL = new StringBuffer();
			StringBuffer EmptyQuerySQL = new StringBuffer();
			StringBuffer chekexistSQL = new StringBuffer();
			stmt = conn.createStatement();

			chekexistSQL.append("SELECT * FROM ").append(tableName).append(
					" WHERE ").append(
					getWhere(keyName.split(","), dataId.split(",")));

			EmptyQuerySQL
					.append("INSERT INTO ")
					.append(tableName)
					.append("(")
					.append(keyName)
					.append(",")
					.append(blobName)
					.append(",")
					.append(
							"PHOTO_KIND,PHOTO_TYPE,TASK_TYPE,TASK_CODE,CREATE_DATE,CREATE_ORGAN,CREATE_OPR,PHOTO_SIZE,QC_STATUS,QC_RESULT,QC_DESC,QC_TIME,NOTE")
					.append(") VALUES (")
					.append(getKeyValue(dataId.split(","))).append(
							",empty_blob()").append(",'").append(photoKind)
					.append("','").append(photoType).append("','").append(
							taskType).append("','").append(taskCode).append(
							"','").append(creatDate).append("','").append(
							creatOrgan).append("','").append(creatOpr).append(
							"','").append(data.length)
							.append("','").append(qcStatus)
							.append("','").append(qcResult)
							.append("','").append(qcDesc)
							.append("','").append(qcTime)
							.append("','").append(note)
							.append("')");

			QuerySQL.append("SELECT  ").append(blobName).append(" FROM ")
					.append(tableName).append(" ").append(" WHERE ").append(
							getWhere(keyName.split(","), dataId.split(",")))
					.append(" FOR UPDATE");

			result = stmt.executeQuery(chekexistSQL.toString());
			if (!result.next()) {
				/* 插入空的附件 sql 中包含empty_blob() */
				stmt.executeUpdate(EmptyQuerySQL.toString());
			}

			/* 查询此BLOB对象并锁定 */
			result = stmt.executeQuery(QuerySQL.toString());

			if (result.next()) {
				oracle.sql.BLOB blob = (oracle.sql.BLOB) result
						.getBlob(blobName);
				outStream = blob.getBinaryOutputStream();
				// data是传入的byte数组，定义：byte[] data
				outStream.write(data, 0, data.length);
				outStream.flush();
			} else {
				 //log.info("没有找到数据result=" + result.toString());
			}
			/* 正式提交 */
			conn.commit();

		} catch (IOException e) {
			throw new RuntimeException("保存照片失败!");
		} catch (SQLException e) {
			throw new RuntimeException("保存照片失败!");
		} finally {
			try {
				if (outStream != null)
					outStream.close();
			} catch (IOException e1) {
				// TODO 自动生成 catch 块
			}
			try {
				if (result != null)
					result.close();
			} catch (SQLException e) {
				// log.debug("close result Exception");
			}
			try {
				if (stmt != null)
					stmt.close();
			} catch (SQLException e) {
				// log.debug("close stmt Exception");
			}
			try {
				if (conn != null)
					conn.setAutoCommit(defaultCommit);
			} catch (SQLException e) {
				// log.debug("close conn Exception");
			}
			// log.debug("finally!end");
		}
	}
	public static void updateBlob(InputStream instream, Connection conn,
			String table, String blobColumn, String keyColumn, String keyValue) {
		Statement stmt = null;
		ResultSet rs = null;
		// oracle.sql.BLOB blob = null;
		BLOB blob = null;
		OutputStream outstream = null;
		boolean oldAutoCommit = false;
		StringBuffer sqlBuffer = new StringBuffer();
		try {
			oldAutoCommit = conn.getAutoCommit();
			conn.setAutoCommit(false);
			sqlBuffer.append("select ");
			sqlBuffer.append(blobColumn);
			sqlBuffer.append(" from ");
			sqlBuffer.append(table);
			sqlBuffer.append(" where ");
			sqlBuffer
					.append(getWhere(keyColumn.split(","), keyValue.split(",")));

			sqlBuffer.append("for update ");

			stmt = conn.createStatement();
			rs = stmt.executeQuery(sqlBuffer.toString());
			if (!rs.next()) {
				rs.close();
				stmt.close();
				throw new IllegalArgumentException(
						"no record found for keyValue: '" + keyValue + "'");
			}
			// blob = (oracle.sql.BLOB )rs.getBLOB(1);
			blob = (BLOB) rs.getBlob(1);
			outstream = blob.getBinaryOutputStream();
			int bufferSize = blob.getChunkSize();
			byte[] buffer = new byte[bufferSize];
			int bytesRead = -1;
			while ((bytesRead = instream.read(buffer)) != -1) {
				outstream.write(buffer, 0, bytesRead);
			}
			conn.commit();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO 自动生成 catch 块
			e.printStackTrace();
		} finally {
			try {
				if (outstream != null)
					outstream.close();
				if (instream != null)
					instream.close();
			} catch (IOException e1) {
				// TODO 自动生成 catch 块
				// log.debug("close outStream Exception");
			}
			log.debug("finally!start");
			try {
				if (rs != null)
					rs.close();
			} catch (SQLException e) {
				// log.debug("close result Exception");
			}
			try {
				if (stmt != null)
					stmt.close();
			} catch (SQLException e) {
				// log.debug("close stmt Exception");
			}
			try {
				if (conn != null)
					conn.setAutoCommit(oldAutoCommit);
				conn.close();
			} catch (SQLException e) {
				// log.debug("close conn Exception");
			}
			// log.debug("finally!end");
		}
	}

	public static byte[] queryBlob(Connection conn, String table,
			String blobColumn, String keyColumn, String keyValue)
			throws SQLException, IOException {
		Statement stmt = null;
		ResultSet rs = null;
		StringBuffer sqlBuffer = new StringBuffer();
		byte[] blobbyte = null;
		try {
			sqlBuffer.append("select ");
			sqlBuffer.append(blobColumn);
			sqlBuffer.append(" from ");
			sqlBuffer.append(table);
			sqlBuffer.append(" where ");
			sqlBuffer
					.append(getWhere(keyColumn.split(","), keyValue.split(",")));
			stmt = conn.createStatement();
			rs = (ResultSet) stmt.executeQuery(sqlBuffer.toString());
			if (!rs.next()) { 
				throw new IllegalArgumentException(
						"no record found for keyValue: '" + keyValue + "'");
			} else { 
				blobbyte = readBlob(rs, blobColumn); 
			}

		} catch (SQLException e) {
			 log.debug("SQLException:"+e);
		} catch (Exception e) {
			 log.debug("Exception:"+e);
		} finally {
			  log.debug("finally!start");
			try {
				if (rs != null)
					rs.close();
			} catch (SQLException e) {
				log.debug("close result Exception");
			}
			try {
				if (stmt != null)
					stmt.close();
			} catch (SQLException e) {
				log.debug("close stmt Exception");
			}
			// log.debug("finally!end");
		}
		return blobbyte;

	}

	public static void updateBlob(byte[] data, Connection conn, String table,
			String blobColumn, String keyColumn, String keyValue)
			throws SQLException, IOException {
		ByteArrayInputStream in = new ByteArrayInputStream(data);
		updateBlob(in, conn, table, blobColumn, keyColumn, keyValue);
	}

	public static byte[] readBlob(ResultSet rs, String blobColumn) {
		java.sql.Blob blob;
		byte[] blobToByte;
		InputStream inStream = null;
		ByteArrayOutputStream temp = new ByteArrayOutputStream();
		try {
			log.debug("执行到30");
			blob = rs.getBlob(blobColumn);
			inStream = blob.getBinaryStream();
			log.debug("执行到31");
			byte[] data = new byte[1024];
			int length = -1;
			while ((length = inStream.read(data)) != -1) {
				temp.write(data, 0, length);
				log.debug("执行到循环");
			}
		} catch (SQLException e) {
			// TODO 自动生成 catch 块
			e.printStackTrace();
		} catch (IOException e) {
			// TODO 自动生成 catch 块
			e.printStackTrace();
		} finally {
			// log.debug("finally!start");
			try {
				if (inStream != null)
					inStream.close();
			} catch (IOException e) {
				// log.debug("close result Exception");
			}
			// log.debug("finally!end");
		}
		blobToByte = temp.toByteArray();
		try {
			if (temp != null)
				temp.close();
		} catch (IOException e) {
			//log.debug("close temp Exception");
		}
		log.debug("执行到end");
		return blobToByte;
	}
	
	
	/**
	 * 通知通告添加附件
	 * @param conn
	 * @param attCode
	 * @param infCode
	 * @param attSize
	 * @param attType
	 * @param blobName
	 * @param creatDate
	 * @param createOrgan
	 * @param createOpr
	 * @param buffer
	 */
	public static void writeAttAchmentContents(Connection conn, String attCode, String infCode, double attSize, String attType, String blobName,
		String creatDate,String createOrgan, String createOpr, byte[] buffer, String fileName ){
		Statement stmt = null;
		ResultSet result = null;
		boolean defaultCommit = false;
		OutputStream outStream = null;
		
		try {
			defaultCommit = conn.getAutoCommit();
			conn.setAutoCommit(false);

			String QuerySQL = "select content from PMP_INFO_ATTACHMENTS where att_code='"+attCode+"' for update";
			String EmptyQuerySQL = "insert into PMP_INFO_ATTACHMENTS (ATT_CODE,INF_CODE,ATT_SIZE,ATT_TYPE,CONTENT,CREATE_DATE,CREATE_ORGAN,CREATE_OPR,FILE_NAME) values ('"+attCode+"','"+infCode+"',"+attSize+",'"+attType+"',empty_blob(),'"+creatDate+"','"+createOrgan+"','"+createOpr+"','"+fileName+"')";
			String chekexistSQL = "select att_code from PMP_INFO_ATTACHMENTS where att_code='"+attCode+"'";
			stmt = conn.createStatement();
			log.debug("执行到此0"+"  "+chekexistSQL);
			result = stmt.executeQuery(chekexistSQL);
			log.debug("执行到此01");
			if (!result.next()) {
				/* 插入空的附件 sql 中包含empty_blob() */
				log.debug("执行到此01"+EmptyQuerySQL);
				stmt.executeUpdate(EmptyQuerySQL);
				log.debug("执行到此1");
			}
			
			/* 查询此BLOB对象并锁定 */
			result = stmt.executeQuery(QuerySQL);
			log.debug("执行到此2");
			if (result.next()) {
				oracle.sql.BLOB blob = (oracle.sql.BLOB) result
						.getBlob(blobName);
				outStream = blob.getBinaryOutputStream();
				// data是传入的byte数组，定义：byte[] data
				outStream.write(buffer, 0, buffer.length);
				outStream.flush();
				log.debug("写入数据"+buffer.length);
			} else {
				 log.info("没有找到附件数据result=" + result.toString());
			}
			log.debug("执行到此3");
			/* 正式提交 */
			conn.commit();
		} catch (IOException e) {
			throw new RuntimeException("保存附件失败!");
		} catch (SQLException e) {
			log.debug("exception:"+e.getMessage());
			throw new RuntimeException("保存附件失败!");
		} finally {
			try {
				if (outStream != null)
					outStream.close();
			} catch (IOException e1) {
				// TODO 自动生成 catch 块
			}
			try {
				if (result != null)
					result.close();
			} catch (SQLException e) {
				 log.debug("close result Exception");
			}
			try {
				if (stmt != null)
					stmt.close();
			} catch (SQLException e) {
				 log.debug("close stmt Exception");
			}
			try {
				if (conn != null)
					conn.setAutoCommit(defaultCommit);
			} catch (SQLException e) {
				 log.debug("close conn Exception");
			}
			 log.debug("附件finally!end");
		}
		
	}
	
	public static byte[] readAttAchmentContents(Connection conn, String attCode) {
		
		Statement stmt = null;
		ResultSet result = null;
		byte[] buffer = null;
		String querySql = "select content from PMP_INFO_ATTACHMENTS where att_code='"+attCode+"'";
		log.debug("执行到此20"+querySql);
		try {
			stmt = conn.createStatement();
			log.debug("执行到此21");
			result = stmt.executeQuery(querySql);
			log.debug("执行到此22");
			if(result.next()){
			buffer = readBlob(result, "CONTENT");
			log.debug("执行到此23"+" "+buffer.length);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			try {
				if (result != null)
					result.close();
			} catch (SQLException e) {
				 log.debug("close result Exception");
			}
			try {
				if (stmt != null)
					stmt.close();
			} catch (SQLException e) {
				 log.debug("close stmt Exception");
			}
			if (conn != null){
			}
		}
		log.debug("执行到此END");
		return buffer;
	}
	
	
}
