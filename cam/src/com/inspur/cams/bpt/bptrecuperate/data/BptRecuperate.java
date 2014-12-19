package com.inspur.cams.bpt.bptrecuperate.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:轮养修养批次表 databean
 */
 @Table(tableName = "BPT_RECUPERATE" , keyFields = "id")
public class BptRecuperate extends StatefulDatabean {
	 //ID
    private String id;
    //年度
    private String year;
    //批次名称
    private String batchName;
    //所属单位代码
    private String domicileCode;
    // 编制单位名称
    private String domicileName;
    //编制日期
    private String createTime;
    //开始日期
    private String beginTime;;
    //轮养结束日期
    private String endTime;
    //人数
    private String peopleCount;
    //备注
    private String note;
    //录入人ID
    private String regId;
    //录入时间
    private String regTime;
    //修改人ID
    private String modId;
    //修改时间
    private String modTime;
	//录入单位行政区划
	@Column(name = "REG_ORGAN_CODE")
   private String regOrganCode;
	
	public String getRegOrganCode() {
		return regOrganCode;
	}
	public void setRegOrganCode(String regOrganCode) {
		this.regOrganCode = regOrganCode;
	}
	/**
	 * @return the id
	 */
	public String getId() {
		return id;
	}
	/**
	 * @param id the id to set
	 */
	public void setId(String id) {
		this.id = id;
	}
	/**
	 * @return the year
	 */
	public String getYear() {
		return year;
	}
	/**
	 * @param year the year to set
	 */
	public void setYear(String year) {
		this.year = year;
	}
	/**
	 * @return the batchName
	 */
	public String getBatchName() {
		return batchName;
	}
	/**
	 * @param batchName the batchName to set
	 */
	public void setBatchName(String batchName) {
		this.batchName = batchName;
	}
	/**
	 * @return the domicileCode
	 */
	public String getDomicileCode() {
		return domicileCode;
	}
	/**
	 * @param domicileCode the domicileCode to set
	 */
	public void setDomicileCode(String domicileCode) {
		this.domicileCode = domicileCode;
	}
	/**
	 * @return the domicileName
	 */
	public String getDomicileName() {
		return domicileName;
	}
	/**
	 * @param domicileName the domicileName to set
	 */
	public void setDomicileName(String domicileName) {
		this.domicileName = domicileName;
	}
	/**
	 * @return the createTime
	 */
	public String getCreateTime() {
		return createTime;
	}
	/**
	 * @param createTime the createTime to set
	 */
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	/**
	 * @return the beginTime
	 */
	public String getBeginTime() {
		return beginTime;
	}
	/**
	 * @param beginTime the beginTime to set
	 */
	public void setBeginTime(String beginTime) {
		this.beginTime = beginTime;
	}
	/**
	 * @return the endTime
	 */
	public String getEndTime() {
		return endTime;
	}
	/**
	 * @param endTime the endTime to set
	 */
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	/**
	 * @return the peopleCount
	 */
	public String getPeopleCount() {
		return peopleCount;
	}
	/**
	 * @param peopleCount the peopleCount to set
	 */
	public void setPeopleCount(String peopleCount) {
		this.peopleCount = peopleCount;
	}
	/**
	 * @return the note
	 */
	public String getNote() {
		return note;
	}
	/**
	 * @param note the note to set
	 */
	public void setNote(String note) {
		this.note = note;
	}
	/**
	 * @return the regId
	 */
	public String getRegId() {
		return regId;
	}
	/**
	 * @param regId the regId to set
	 */
	public void setRegId(String regId) {
		this.regId = regId;
	}
	/**
	 * @return the regTime
	 */
	public String getRegTime() {
		return regTime;
	}
	/**
	 * @param regTime the regTime to set
	 */
	public void setRegTime(String regTime) {
		this.regTime = regTime;
	}
	/**
	 * @return the modId
	 */
	public String getModId() {
		return modId;
	}
	/**
	 * @param modId the modId to set
	 */
	public void setModId(String modId) {
		this.modId = modId;
	}
	/**
	 * @return the modTime
	 */
	public String getModTime() {
		return modTime;
	}
	/**
	 * @param modTime the modTime to set
	 */
	public void setModTime(String modTime) {
		this.modTime = modTime;
	}
    
}