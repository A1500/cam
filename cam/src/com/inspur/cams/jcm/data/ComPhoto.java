package com.inspur.cams.jcm.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

import com.inspur.cams.comm.lob.Blob;

/**
 * 人员照片表databean
 * @author 
 * @date 2014-05-16
 */
@Table(tableName = "COM_PHOTO", keyFields = "photoId")
public class ComPhoto extends StatefulDatabean {

	// 主键
	private String photoId;

	// 照片类型
	private String photoKind;

	// 照片大小
	private double photoSize;

	// 照片类别
	private String photoType;

	// 照片
	private Blob photoContent;

	// 创建日期
	private String createDate;

	// 创建组织机构
	private String createOrgan;

	// 备注
	private String note;

	// 创建人
	private String createOpr;

	// 照片内容
	private Blob cardPhotoContent;

	/**
	 * 获取 主键
	 * @return String
	 */
	public String getPhotoId() {
		return photoId;
	}

	/**
	 * 设置 主键
	 */
	public void setPhotoId(String photoId) {
		this.photoId = photoId;
	}

	/**
	 * 获取 照片类型
	 * @return String
	 */
	public String getPhotoKind() {
		return photoKind;
	}

	/**
	 * 设置 照片类型
	 */
	public void setPhotoKind(String photoKind) {
		this.photoKind = photoKind;
	}

	/**
	 * 获取 照片大小
	 * @return double
	 */
	public double getPhotoSize() {
		return photoSize;
	}

	/**
	 * 设置 照片大小
	 */
	public void setPhotoSize(double photoSize) {
		this.photoSize = photoSize;
	}

	/**
	 * 获取 照片类别
	 * @return String
	 */
	public String getPhotoType() {
		return photoType;
	}

	/**
	 * 设置 照片类别
	 */
	public void setPhotoType(String photoType) {
		this.photoType = photoType;
	}

	/**
	 * 获取 照片
	 * @return Blob
	 */
	public Blob getPhotoContent() {
		return photoContent;
	}

	/**
	 * 设置 照片
	 */
	public void setPhotoContent (Blob photoContent) {
		this.photoContent = photoContent;
	}

	/**
	 * 获取 创建日期
	 * @return String
	 */
	public String getCreateDate() {
		return createDate;
	}

	/**
	 * 设置 创建日期
	 */
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	/**
	 * 获取 创建组织机构
	 * @return String
	 */
	public String getCreateOrgan() {
		return createOrgan;
	}

	/**
	 * 设置 创建组织机构
	 */
	public void setCreateOrgan(String createOrgan) {
		this.createOrgan = createOrgan;
	}

	/**
	 * 获取 备注
	 * @return String
	 */
	public String getNote() {
		return note;
	}

	/**
	 * 设置 备注
	 */
	public void setNote(String note) {
		this.note = note;
	}

	/**
	 * 获取 创建人
	 * @return String
	 */
	public String getCreateOpr() {
		return createOpr;
	}

	/**
	 * 设置 创建人
	 */
	public void setCreateOpr(String createOpr) {
		this.createOpr = createOpr;
	}

	/**
	 * 获取 照片内容
	 * @return Blob
	 */
	public Blob getCardPhotoContent() {
		return cardPhotoContent;
	}

	/**
	 * 设置 照片内容
	 */
	public void setCardPhotoContent (Blob cardPhotoContent) {
		this.cardPhotoContent = cardPhotoContent;
	}

}