package com.inspur.cams.sorg.base.data;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;
import org.loushang.next.upload.UploadFile;

/**
 * @title:党建党内奖惩
 * @description:
 * @author:
 * @since:2012-04-08
 * @version:1.0
 */
@Table(tableName = "SOM_PARTY_PRAISE", keyFields = "praiseId")
public class SomPartyPraise extends StatefulDatabean {
	// 党内奖惩ID
	private String praiseId;
	// 党建/党员id
	private String memberId;
	//奖惩类别 0:表彰;1:惩罚
	private String praiseOrPunnish;
	//党组织还是党员
	private String praiseType;
	//奖惩事项分类
	private String praiseItemType;
	//授予称号
	private String grantedTitle;
	// 奖惩批准日期
	private String praiseDate;
	// 奖惩名称
	private String praiseName;
	// 批准奖惩组织名称
	private String praiseOrg;
	// 文件号
	private String fileNo;
	// 相关文件
	private String fileName;
	//文件
	private UploadFile files;
	public String getPraiseId() {
		return praiseId;
	}
	public void setPraiseId(String praiseId) {
		this.praiseId = praiseId;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getPraiseType() {
		return praiseType;
	}
	public void setPraiseType(String praiseType) {
		this.praiseType = praiseType;
	}
	public String getPraiseDate() {
		return praiseDate;
	}
	public void setPraiseDate(String praiseDate) {
		this.praiseDate = praiseDate;
	}
	public String getPraiseName() {
		return praiseName;
	}
	public void setPraiseName(String praiseName) {
		this.praiseName = praiseName;
	}
	public String getPraiseOrg() {
		return praiseOrg;
	}
	public void setPraiseOrg(String praiseOrg) {
		this.praiseOrg = praiseOrg;
	}
	public String getFileNo() {
		return fileNo;
	}
	public void setFileNo(String fileNo) {
		this.fileNo = fileNo;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public UploadFile getFiles() {
		return files;
	}
	public void setFiles(UploadFile files) {
		this.files = files;
	}
	public String getPraiseOrPunnish() {
		return praiseOrPunnish;
	}
	public void setPraiseOrPunnish(String praiseOrPunnish) {
		this.praiseOrPunnish = praiseOrPunnish;
	}
	public String getGrantedTitle() {
		return grantedTitle;
	}
	public void setGrantedTitle(String grantedTitle) {
		this.grantedTitle = grantedTitle;
	}
	public String getPraiseItemType() {
		return praiseItemType;
	}
	public void setPraiseItemType(String praiseItemType) {
		this.praiseItemType = praiseItemType;
	}
}