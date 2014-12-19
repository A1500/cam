package com.inspur.cams.bpt.regulations.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

@Table(tableName = "BPT_REGULATIONS", keyFields = "regulationsId")
public class BptRegulations extends StatefulDatabean {
    // 主键ID
    @Rule(value = "require")
    @Column(name = "REGULATIONS_ID")
    private String regulationsId;
    // 文号
    @Rule(value = "require")
    @Column(name = "FILE_NUM")
    private String fileNum;
    // 级别
    @Rule(value = "require")
    @Column(name = "FILE_LEVEL")
    private String fileLevel;
    // 标题
    @Rule(value = "require")
    @Column(name = "REGULATIONS_TITLE")
    private String regulationsTitle;
    // 发布时间
    @Column(name = "RELEASE_DATE")
    private String releaseDate;
    // 录入单位
    @Column(name = "RELEASE_COMPANY")
    private String releaseCompany;
    // 录入人
    @Column(name = "RELEASE_PEOPLE")
    private String releasePeople;
    // 废止时间
    @Column(name = "ABOLISHED_TIME")
    private String abolishedTime;
    // 内容
    @Column(name = "CONTENT")
    private String content;
    // 备注
    @Column(name = "REMARKS")
    private String remarks;
    // 应用状态
    @Column(name = "FLAG")
    private String flag;
    // 类别
    @Column(name = "TYPE")
    private String type;
    /**
     * getter for 主键ID
     * 
     * @generated
     */
    public String getRegulationsId() {
        return this.regulationsId;
    }

    /**
     * setter for 主键ID
     * 
     * @generated
     */
    public void setRegulationsId(String regulationsId) {
        this.regulationsId = regulationsId;
    }

    /**
     * getter for 文号
     * 
     * @generated
     */
    public String getFileNum() {
        return this.fileNum;
    }

    /**
     * setter for 文号
     * 
     * @generated
     */
    public void setFileNum(String fileNum) {
        this.fileNum = fileNum;
    }

    /**
     * getter for 级别
     * 
     * @generated
     */
    public String getFileLevel() {
        return this.fileLevel;
    }

    /**
     * setter for 级别
     * 
     * @generated
     */
    public void setFileLevel(String fileLevel) {
        this.fileLevel = fileLevel;
    }

    /**
     * getter for 标题
     * 
     * @generated
     */
    public String getRegulationsTitle() {
        return this.regulationsTitle;
    }

    /**
     * setter for 标题
     * 
     * @generated
     */
    public void setRegulationsTitle(String regulationsTitle) {
        this.regulationsTitle = regulationsTitle;
    }

    /**
     * getter for 发布时间
     * 
     * @generated
     */
    public String getReleaseDate() {
        return this.releaseDate;
    }

    /**
     * setter for 发布时间
     * 
     * @generated
     */
    public void setReleaseDate(String releaseDate) {
        this.releaseDate = releaseDate;
    }

    /**
     * getter for 录入单位
     * 
     * @generated
     */
    public String getReleaseCompany() {
        return this.releaseCompany;
    }

    /**
     * setter for 录入单位
     * 
     * @generated
     */
    public void setReleaseCompany(String releaseCompany) {
        this.releaseCompany = releaseCompany;
    }

    /**
     * getter for 录入人
     * 
     * @generated
     */
    public String getReleasePeople() {
        return this.releasePeople;
    }

    /**
     * setter for 录入人
     * 
     * @generated
     */
    public void setReleasePeople(String releasePeople) {
        this.releasePeople = releasePeople;
    }

    /**
     * getter for 废止日期
     * 
     * @generated
     */
    public String getAbolishedTime() {
        return this.abolishedTime;
    }

    /**
     * setter for 废止日期
     * 
     * @generated
     */
    public void setAbolishedTime(String abolishedTime) {
        this.abolishedTime = abolishedTime;
    }

    /**
     * getter for 内容
     * 
     * @generated
     */
    public String getContent() {
        return this.content;
    }

    /**
     * setter for 内容
     * 
     * @generated
     */
    public void setContent(String content) {
        this.content = content;
    }

    /**
     * getter for 备注
     * 
     * @generated
     */
    public String getRemarks() {
        return this.remarks;
    }

    /**
     * setter for 备注
     * 
     * @generated
     */
    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public String getFlag() {
        return flag;
    }

    public void setFlag(String flag) {
        this.flag = flag;
    }

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

}