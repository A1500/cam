package com.inspur.cams.bpt.capital.data;
import java.math.BigDecimal;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
/**
 * @title BptRetiredMartyrSta
 * @author Lin Yangyang
 * @version 1.0
 * @since 2012-08-30
 * @description 优抚农村退役士兵及烈士子女补助标准
 */
@Table(tableName = "BPT_RETIRED_MARTYR_STA", keyFields = "id")
public class BptCapitalRetMarSta extends StatefulDatabean{	
	private String id;//标准ID
	private String objectType;//优抚对象类别：农村退役士兵81，烈士子女B1
	private String standardsCounties;//所属县区
	private String startDate;//生效日期起
	private String endDate;//生效日期止
	private BigDecimal proStaMon;//省标准（元）
	private BigDecimal localSubsidyMon;//地方补贴（元）
	private String note;//备注
	private String regId;//录入人ID
	private String regTime;//录入时间
	private String modId;//修改人ID
	private String modTime;//修改时间
	/**
	 * 以下都是get，set方法
	 *
	 */
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getObjectType(){
		return objectType;
	}
	public void setObjectType(String objectType){
		this.objectType = objectType;
	}
	public String getStandardsCounties() {
		return standardsCounties;
	}
	public void setStandardsCounties(String standardsCounties) {
		this.standardsCounties = standardsCounties;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public BigDecimal getProStaMon() {
		return proStaMon;
	}
	public void setProStaMon(BigDecimal proStaMon) {
		this.proStaMon = proStaMon;
	}
	public BigDecimal getLocalSubsidyMon() {
		return localSubsidyMon;
	}
	public void setLocalSubsidyMon(BigDecimal localSubsidyMon) {
		this.localSubsidyMon = localSubsidyMon;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public String getRegId() {
		return regId;
	}
	public void setRegId(String regId) {
		this.regId = regId;
	}
	public String getRegTime() {
		return regTime;
	}
	public void setRegTime(String regTime) {
		this.regTime = regTime;
	}
	public String getModId() {
		return modId;
	}
	public void setModId(String modId) {
		this.modId = modId;
	}
	public String getModTime() {
		return modTime;
	}
	public void setModTime(String modTime) {
		this.modTime = modTime;
	}
}

