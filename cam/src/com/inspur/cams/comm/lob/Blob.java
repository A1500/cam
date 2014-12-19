package com.inspur.cams.comm.lob;

import java.io.ByteArrayInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;

import org.loushang.next.upload.UploadFile;

import com.inspur.cams.comm.util.StrUtil;

public class Blob implements UploadFile{
	
	private byte[] data;

	public byte[] getData() {
		return data;
	}
	
	public String getDataStr() {
		return StrUtil.getBASE64(data);
	}
	
	public void setData(byte[] data) {
		this.data = data;
	}
	
	public void setData(String data) {
		this.data = StrUtil.getFromBASE64(data);
	}
	
	public InputStream getInputStream() throws FileNotFoundException,
			IOException {
		ByteArrayInputStream stream = new ByteArrayInputStream(this.data);
		return stream;
	}

	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	

	public byte[] getFileData() throws FileNotFoundException, IOException {
		return this.data;
	}

	@Deprecated
	public String getFileName() {
		return null;
	}

	@Deprecated
	public String getFilePath() {
		return null;
	}

	@Deprecated
	public int getFileSize() {
		return 0;
	}

	

	@Deprecated
	public void setContentType(String arg0) {
		
	}

	@Deprecated
	public void setFileName(String arg0) {
		
	}

	@Deprecated
	public void setFileSize(int arg0) {
		
	}

	@Deprecated
	public String getContentType() {
		return null;
	}

}
