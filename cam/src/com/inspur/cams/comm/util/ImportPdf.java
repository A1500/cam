package com.inspur.cams.comm.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import oracle.sql.BLOB;

public class ImportPdf {
	public static Connection getConn() {
		Connection conn = null;
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver ");
			conn = DriverManager.getConnection(
					"jdbc:oracle:thin:@10.9.12.11:1521:CAMS ", "cams", "cams");
			conn.setAutoCommit(false);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return conn;
	}

	public static void doImport() {
		String fileName = "D:\\1.txt ";
		File f = new File(fileName);
		// 填充Blob值,用于提交到数据库
		try {
			FileInputStream fin;
			fin = new FileInputStream(f);
			System.out.println("file   size   =   " + fin.available());
			BLOB     blob   =   null; 
			OutputStream out = blob.getBinaryOutputStream();
			byte[] data = new byte[(int) fin.available()];
			String id = IdHelp.getUUID30();
			WriteOraBlob.insertBlob(getConn(), id, data,
					"UPLOAD_TEST","ID","FILE");
			
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	public static void main(String[] args){
		doImport();
	}
}
