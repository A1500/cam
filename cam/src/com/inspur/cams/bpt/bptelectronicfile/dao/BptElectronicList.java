package com.inspur.cams.bpt.bptelectronicfile.dao;

import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:BptElectronicList
 * @description:电子档案列表
 * @author:
 * @since:2011-07-15
 * @version:1.0
*/

@Table(tableName = "BPT_ELECTRONIC_LIST" , keyFields = "id")
public class BptElectronicList extends StatefulDatabean {
   //ID
   	@Rule(value="require")
	@Column(name = "ID")
   private String id;
   //人员ID
	@Column(name = "PEOPLE_ID")
   private String peopleId;
	//目录号ID
	@Column(name = "CONTENT_NUM_ID")
   private String contentNumId;
	//业务类型
	@Column(name = "SERVICE_TYPE")
   private String serviceType;
	//所属区划代码
	@Column(name = "DOMICILE_CODE")
   private String domicileCode;
	//录入人ID
	@Column(name = "REG_ID")
   private String regId;
	//录入时间
	@Column(name = "REG_TIME")
   private String regTime;
	//目录号
	@Transient
   private String contentNumName;
	//档案柜
	@Transient
   private String fileCabinetName;
	//层数
	@Transient
   private String layerNum;
	//盒
	@Transient
   private String boxNum;
	//年度
	@Transient
   private String contentYear;
	//编制日期
	@Transient
   private String plaitDate;
	//室卷编号
   private String archiveNo;
	
   
	public String getArchiveNo() {
		return archiveNo;
	}
	
	public void setArchiveNo(String archiveNo) {
		this.archiveNo = archiveNo;
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
	 * @return the peopleId
	 */
	public String getPeopleId() {
		return peopleId;
	}
	/**
	 * @param peopleId the peopleId to set
	 */
	public void setPeopleId(String peopleId) {
		this.peopleId = peopleId;
	}
	/**
	 * @return the serviceType
	 */
	public String getServiceType() {
		return serviceType;
	}
	/**
	 * @param serviceType the serviceType to set
	 */
	public void setServiceType(String serviceType) {
		this.serviceType = serviceType;
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
	 * @return the contentNumId
	 */
	public String getContentNumId() {
		return contentNumId;
	}
	/**
	 * @param contentNumId the contentNumId to set
	 */
	public void setContentNumId(String contentNumId) {
		this.contentNumId = contentNumId;
	}
	/**
	 * @return the contentNumName
	 */
	public String getContentNumName() {
		return contentNumName;
	}
	/**
	 * @param contentNumName the contentNumName to set
	 */
	public void setContentNumName(String contentNumName) {
		this.contentNumName = contentNumName;
	}
	/**
	 * @return the fileCabinetName
	 */
	public String getFileCabinetName() {
		return fileCabinetName;
	}
	/**
	 * @param fileCabinetName the fileCabinetName to set
	 */
	public void setFileCabinetName(String fileCabinetName) {
		this.fileCabinetName = fileCabinetName;
	}
	/**
	 * @return the layerNum
	 */
	public String getLayerNum() {
		return layerNum;
	}
	/**
	 * @param layerNum the layerNum to set
	 */
	public void setLayerNum(String layerNum) {
		this.layerNum = layerNum;
	}
	/**
	 * @return the boxNum
	 */
	public String getBoxNum() {
		return boxNum;
	}
	/**
	 * @param boxNum the boxNum to set
	 */
	public void setBoxNum(String boxNum) {
		this.boxNum = boxNum;
	}
	/**
	 * @return the contentYear
	 */
	public String getContentYear() {
		return contentYear;
	}
	/**
	 * @param contentYear the contentYear to set
	 */
	public void setContentYear(String contentYear) {
		this.contentYear = contentYear;
	}
	/**
	 * @return the plaitDate
	 */
	public String getPlaitDate() {
		return plaitDate;
	}
	/**
	 * @param plaitDate the plaitDate to set
	 */
	public void setPlaitDate(String plaitDate) {
		this.plaitDate = plaitDate;
	}
}