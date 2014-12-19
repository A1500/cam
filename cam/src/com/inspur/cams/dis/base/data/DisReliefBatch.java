package com.inspur.cams.dis.base.data;

import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.data.StatefulDatabean;
/**
 * @title:DisReliefInfo
 * @description:
 * @author:
 * @since:2012-10-12
 * @version:1.0
*/
 @Table(tableName = "DIS_RELIEF_BATCH" , keyFields = "batchId")
public class DisReliefBatch extends StatefulDatabean {
   //批次id
   	@Rule(value="require")
	@Column(name = "BATCH_ID")
   private String batchId;
   //救助类型
	@Column(name = "RELIEF_TYPE")
   private String reliefType;
	//年度
	@Column(name = "YEAR")
   private String year;
   //批次名称
	@Column(name = "BATCH_NAME")
   private String batchName;
   //需要填报单位区划总
	@Column(name = "AREA_CODE")
   private String areaCode;
   //创建单位
	@Column(name = "CREATE_ORGAN")
   private String createOrgan;
   //创建人
	@Column(name = "CREATE_PERSON")
   private String createPerson;
   //创建时间
	@Column(name = "CREATE_TIME")
   private String createTime;
   //创建单位区划
	@Column(name = "CREATE_ORGAN_CODE")
   private String createOrganCode;
	public String getBatchId() {
		return batchId;
	}
	public void setBatchId(String batchId) {
		this.batchId = batchId;
	}
	public String getReliefType() {
		return reliefType;
	}
	public void setReliefType(String reliefType) {
		this.reliefType = reliefType;
	}
	public String getBatchName() {
		return batchName;
	}
	public void setBatchName(String batchName) {
		this.batchName = batchName;
	}
	public String getAreaCode() {
		return areaCode;
	}
	public void setAreaCode(String areaCode) {
		this.areaCode = areaCode;
	}
	public String getCreateOrgan() {
		return createOrgan;
	}
	public void setCreateOrgan(String createOrgan) {
		this.createOrgan = createOrgan;
	}
	public String getCreatePerson() {
		return createPerson;
	}
	public void setCreatePerson(String createPerson) {
		this.createPerson = createPerson;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public String getCreateOrganCode() {
		return createOrganCode;
	}
	public void setCreateOrganCode(String createOrganCode) {
		this.createOrganCode = createOrganCode;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}

}