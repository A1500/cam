package com.inspur.cams.comm.comfile.data;

import java.math.BigDecimal;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

import com.inspur.cams.comm.lob.Blob;

/**
 * 文件管理databean
 * @author shgtch
 * @date 2012-3-2
 */
@Table(tableName="COM_FILE",keyFields = "fileId")
public class ComFile extends StatefulDatabean{
	
	// 文件内码
	private String fileId;
	
	// 业务种类
	private String applyType;
	
	// 文件类型
	private String fileName;
	
	// 文件类型
	private String fileType;
	
	// 文件格式
	private String fileFormat;
	
	// 文件大小
	private BigDecimal fileSize;
	
	// 文件内容
	private Blob fileContent;
	
	// 创建单位
	private String createOrgan;
	
	// 创建人
	private String createOpr;
	
	// 创建时间
	private String createTime;

	/**
	 * 获取 文件内码
	 * @return
	 */
	public String getFileId() {
		return fileId;
	}

	/**
	 * 设置 文件内码
	 * @param fileId
	 */
	public void setFileId(String fileId) {
		this.fileId = fileId;
	}

	/**
	 * 获取 业务种类
	 * @return
	 */
	public String getApplyType() {
		return applyType;
	}

	/**
	 * 设置 业务种类
	 * @param applyType
	 */
	public void setApplyType(String applyType) {
		this.applyType = applyType;
	}

	/**
	 * 获取 文件类型
	 * @return
	 */
	public String getFileType() {
		return fileType;
	}

	/**
	 * 设置 文件类型
	 * @param fileType
	 */
	public void setFileType(String fileType) {
		this.fileType = fileType;
	}

	/**
	 * 获取 文件格式
	 * @return
	 */
	public String getFileFormat() {
		return fileFormat;
	}

	/**
	 * 设置 文件格式
	 * @param fileFormat
	 */
	public void setFileFormat(String fileFormat) {
		this.fileFormat = fileFormat;
	}

	/**
	 * 获取 文件大小
	 * @return
	 */
	public BigDecimal getFileSize() {
		return fileSize;
	}

	/**
	 * 设置 文件大小
	 * @param fileSize
	 */
	public void setFileSize(BigDecimal fileSize) {
		this.fileSize = fileSize;
	}

	/**
	 * 获取 文件内容
	 * @return
	 */
	public Blob getFileContent() {
		return fileContent;
	}

	/**
	 * 设置 文件内容
	 * @param fileContent
	 */
	public void setFileContent(Blob fileContent) {
		this.fileContent = fileContent;
	}

	/**
	 * 获取 创建单位
	 * @return
	 */
	public String getCreateOrgan() {
		return createOrgan;
	}

	/**
	 * 设置 创建单位
	 * @param createOrgan
	 */
	public void setCreateOrgan(String createOrgan) {
		this.createOrgan = createOrgan;
	}

	/**
	 * 获取 创建人
	 * @return
	 */
	public String getCreateOpr() {
		return createOpr;
	}

	/**
	 * 设置 创建人
	 * @param createOpr
	 */
	public void setCreateOpr(String createOpr) {
		this.createOpr = createOpr;
	}

	/**
	 * 获取 创建时间
	 * @return
	 */
	public String getCreateTime() {
		return createTime;
	}

	/**
	 * 设置 创建时间
	 * @param createTime
	 */
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	
	/**
	 * 获取 文件名
	 * @return fileName
	 */
	public String getFileName() {
		return fileName;
	}
	
	/**
	 * 获取 文件名
	 * @param fileName
	 */
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	
}
