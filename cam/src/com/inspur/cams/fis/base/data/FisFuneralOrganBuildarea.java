package com.inspur.cams.fis.base.data;

import org.loushang.next.dao.*;
import java.math.BigDecimal;
import org.loushang.next.data.*;

/**
 * @Path com.inspur.cams.fis.base.data.FisFuneralOrganBuildarea
 * @Description: TODO 殡葬业务殡仪馆信息表
 * @author xuexzh
 * @date 2012-7-12
 */
@Table(tableName = "FIS_FUNERAL_ORGAN_BUILDAREA", keyFields = "areaId")
public class FisFuneralOrganBuildarea extends StatefulDatabean {
	// 区域名称编号
	@Column(name = "area_Id")
	private String areaId;
	// 区域面积
	@Column(name = "area_num")
	private BigDecimal areaNum;
	// 登记人
	@Column(name = "create_People")
	private String createPeople;
	// 登记人姓名
	@Column(name = "create_People_Name")
	private String createPeopleName;
	// 登记单位
	@Column(name = "create_Organ")
	private String createOrgan;
	// 登记单位名称
	@Column(name = "create_Organ_Name")
	private String createOrganName;
	// 登记时间
	@Column(name = "create_Time")
	private String createTime;

	public String getAreaId() {
		return areaId;
	}

	public void setAreaId(String areaId) {
		this.areaId = areaId;
	}

	public BigDecimal getAreaNum() {
		return areaNum;
	}

	public void setAreaNum(BigDecimal areaNum) {
		this.areaNum = areaNum;
	}

	public String getCreatePeople() {
		return createPeople;
	}

	public void setCreatePeople(String createPeople) {
		this.createPeople = createPeople;
	}

	public String getCreatePeopleName() {
		return createPeopleName;
	}

	public void setCreatePeopleName(String createPeopleName) {
		this.createPeopleName = createPeopleName;
	}

	public String getCreateOrgan() {
		return createOrgan;
	}

	public void setCreateOrgan(String createOrgan) {
		this.createOrgan = createOrgan;
	}

	public String getCreateOrganName() {
		return createOrganName;
	}

	public void setCreateOrganName(String createOrganName) {
		this.createOrganName = createOrganName;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

}