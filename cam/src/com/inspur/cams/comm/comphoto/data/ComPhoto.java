package com.inspur.cams.comm.comphoto.data;

import java.math.BigDecimal;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

import com.inspur.cams.comm.util.StrUtil;
import com.inspur.cams.comm.lob.Blob;


@Table(tableName="COM_PHOTO",keyFields = "photoId")
public class ComPhoto extends StatefulDatabean{
	
	/**
	 * 
	 */
	@Column(name = "PHOTO_ID")
	private String photoId;
	@Column(name = "PHOTO_KIND")
	private String photoKind;
	@Column(name = "PHOTO_SIZE")
	private BigDecimal photoSize;
	@Column(name = "PHOTO_TYPE")
	private String photoType;
	@Column(name = "PHOTO_CONTENT")
	private Blob photoContent;
	@Column(name = "CARD_PHOTO_CONTENT")
	private Blob cardPhotoContent;
	@Column(name = "CREATE_DATE")
	private String createDate;
	@Column(name = "CREATE_ORGAN")
	private String createOrgan;
	@Column(name = "CREATE_OPR")
	private String createOpr;
	
	public String getPhotoId() {
		return photoId;
	}
	public void setPhotoId(String photoId) {
		this.photoId = photoId;
	}
	public String getPhotoKind() {
		return photoKind;
	}
	public void setPhotoKind(String photoKind) {
		this.photoKind = photoKind;
	}
	public BigDecimal getPhotoSize() {
		return photoSize;
	}
	public void setPhotoSize(BigDecimal photoSize) {
		this.photoSize = photoSize;
	}
	public String getPhotoType() {
		return photoType;
	}
	public void setPhotoType(String photoType) {
		this.photoType = photoType;
	}
	public Blob getPhotoContent() {
		return photoContent;
	}
	public void setPhotoContent(Blob photoContent) {
		this.photoContent = photoContent;
	}
	public void setPhotoContent(String photo) {
		Blob blob = new Blob();
		blob.setData(photo);
		this.photoContent = blob;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateOrgan(String createOrgan) {
		this.createOrgan = createOrgan;
	}
	public String getCreateOrgan() {
		return createOrgan;
	}
	public void setCreateOpr(String createOpr) {
		this.createOpr = createOpr;
	}
	public String getCreateOpr() {
		return createOpr;
	}
	public Blob getCardPhotoContent() {
		return cardPhotoContent;
	}
	public void setCardPhotoContent(Blob cardPhotoContent) {
		this.cardPhotoContent = cardPhotoContent;
	}

}
