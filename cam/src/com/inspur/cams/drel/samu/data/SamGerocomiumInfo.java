package com.inspur.cams.drel.samu.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 敬老院基础信息databean
 * @author 
 * @date 2012-09-26
 */
@Table(tableName = "SAM_GEROCOMIUM_INFO", keyFields = "recordId")
public class SamGerocomiumInfo extends StatefulDatabean {
	
	// 记录ID RECORD_ID
	private String recordId;
	// 敬老院ID
	private String gerocomiumId;

	// 年份
	private String year;

	// 名称
	private String gerocomiumName;

	// 建院时间
	private String establishDate;
	
	// 主管单位名称
	private String manaLevel;
	
	// 主管单位ID
	private String manaLevelId;
	
	// 所属行政区划
	private String areaLevel;
	
	// 所属行政区划ID
	private String areaLevelId;
	
	// 法人代表
	private String legelPeople;

	// 等级
	private String gerocomiumLevel;

	// 占地面积
	private BigDecimal totalArea;

	// 建筑面积
	private BigDecimal buildArea;

	// 室外娱乐场所面积
	private BigDecimal outdoorArea;

	// 室内娱乐场所面积
	private BigDecimal indoorArea;

	// 固定资产
	private BigDecimal fixedAssets;

	// 五保对象供养标准
	private BigDecimal supportStandard;

	// 管理工作经费
	private BigDecimal managementFunds;

	// 年副业收入
	private BigDecimal yearSidelineIncome;

	// 联系电话
	private String contactPhone;

	// 所在地址
	private String location;

	// 房屋性质
	private String houseProperty;

	// 所服务乡镇
	private String serveTowns;
	
	// 所服务乡镇
	private String serveTownsId;

	// 取暖方式
	private String heatingWay;

	// 管理制度是否健全
	private String isManagePerfect;

	// 岗位责任制是否健全
	private String isPostPerfect;

	// 是否建立院管委会
	private String isEstablish;

	// 开展活动情况
	private String activityAbout;

	// 院务是否公开
	private String isManagePublic;

	// 财务是否公开
	private String isFinancialPublic;

	// 娱乐健身器材情况
	private String equipmentAbout;

	// 年种植蔬菜面积
	private BigDecimal vegetablesArea;

	// 年蔬菜产量
	private BigDecimal vegetablesYield;
	
	//总房间数
	private BigDecimal totalRoomNum;
	
	//总床位数
	private BigDecimal totalBedNum;
	// 备注
	private String remarks;
	
	//是否最新年份
	private String ifCurrent;
	
	public String getRecordId() {
		return recordId;
	}

	public void setRecordId(String recordId) {
		this.recordId = recordId;
	}
	
	/**
	 * 获取 敬老院ID
	 * @return String
	 */
	public String getGerocomiumId() {
		return gerocomiumId;
	}

	/**
	 * 设置 敬老院ID
	 */
	public void setGerocomiumId(String gerocomiumId) {
		this.gerocomiumId = gerocomiumId;
	}

	/**
	 * 获取 年份
	 * @return String
	 */
	public String getYear() {
		return year;
	}

	/**
	 * 设置 年份
	 */
	public void setYear(String year) {
		this.year = year;
	}

	/**
	 * 获取 名称
	 * @return String
	 */
	public String getGerocomiumName() {
		return gerocomiumName;
	}

	/**
	 * 设置 名称
	 */
	public void setGerocomiumName(String gerocomiumName) {
		this.gerocomiumName = gerocomiumName;
	}

	/**
	 * 获取 建院时间
	 * @return String
	 */
	public String getEstablishDate() {
		return establishDate;
	}

	/**
	 * 设置 建院时间
	 */
	public void setEstablishDate(String establishDate) {
		this.establishDate = establishDate;
	}
	public String getManaLevel() {
		return manaLevel;
	}
	
	public void setManaLevel(String manaLevel) {
		this.manaLevel = manaLevel;
	}
	
	public String getManaLevelId() {
		return manaLevelId;
	}
	
	public void setManaLevelId(String manaLevelId) {
		this.manaLevelId = manaLevelId;
	}
	
	public String getAreaLevel() {
		return areaLevel;
	}
	
	public void setAreaLevel(String areaLevel) {
		this.areaLevel = areaLevel;
	}
	
	public String getAreaLevelId() {
		return areaLevelId;
	}
	
	public void setAreaLevelId(String areaLevelId) {
		this.areaLevelId = areaLevelId;
	}

	/**
	 * 获取 法人代表
	 * @return String
	 */
	public String getLegelPeople() {
		return legelPeople;
	}

	/**
	 * 设置 法人代表
	 */
	public void setLegelPeople(String legelPeople) {
		this.legelPeople = legelPeople;
	}

	/**
	 * 获取 等级
	 * @return String
	 */
	public String getGerocomiumLevel() {
		return gerocomiumLevel;
	}

	/**
	 * 设置 等级
	 */
	public void setGerocomiumLevel(String level) {
		this.gerocomiumLevel = level;
	}

	/**
	 * 获取 占地面积
	 * @return BigDecimal
	 */
	public BigDecimal getTotalArea() {
		return totalArea;
	}

	/**
	 * 设置 占地面积
	 */
	public void setTotalArea(BigDecimal totalArea) {
		this.totalArea = totalArea;
	}

	/**
	 * 获取 建筑面积
	 * @return BigDecimal
	 */
	public BigDecimal getBuildArea() {
		return buildArea;
	}

	/**
	 * 设置 建筑面积
	 */
	public void setBuildArea(BigDecimal buildArea) {
		this.buildArea = buildArea;
	}

	/**
	 * 获取 室外娱乐场所面积
	 * @return BigDecimal
	 */
	public BigDecimal getOutdoorArea() {
		return outdoorArea;
	}

	/**
	 * 设置 室外娱乐场所面积
	 */
	public void setOutdoorArea(BigDecimal outdoorArea) {
		this.outdoorArea = outdoorArea;
	}

	/**
	 * 获取 室内娱乐场所面积
	 * @return BigDecimal
	 */
	public BigDecimal getIndoorArea() {
		return indoorArea;
	}

	/**
	 * 设置 室内娱乐场所面积
	 */
	public void setIndoorArea(BigDecimal indoorArea) {
		this.indoorArea = indoorArea;
	}

	/**
	 * 获取 固定资产
	 * @return BigDecimal
	 */
	public BigDecimal getFixedAssets() {
		return fixedAssets;
	}

	/**
	 * 设置 固定资产
	 */
	public void setFixedAssets(BigDecimal fixedAssets) {
		this.fixedAssets = fixedAssets;
	}

	/**
	 * 获取 五保对象供养标准
	 * @return BigDecimal
	 */
	public BigDecimal getSupportStandard() {
		return supportStandard;
	}

	/**
	 * 设置 五保对象供养标准
	 */
	public void setSupportStandard(BigDecimal supportStandard) {
		this.supportStandard = supportStandard;
	}

	/**
	 * 获取 管理工作经费
	 * @return BigDecimal
	 */
	public BigDecimal getManagementFunds() {
		return managementFunds;
	}

	/**
	 * 设置 管理工作经费
	 */
	public void setManagementFunds(BigDecimal managementFunds) {
		this.managementFunds = managementFunds;
	}

	/**
	 * 获取 年副业收入
	 * @return BigDecimal
	 */
	public BigDecimal getYearSidelineIncome() {
		return yearSidelineIncome;
	}

	/**
	 * 设置 年副业收入
	 */
	public void setYearSidelineIncome(BigDecimal yearSidelineIncome) {
		this.yearSidelineIncome = yearSidelineIncome;
	}

	/**
	 * 获取 联系电话
	 * @return String
	 */
	public String getContactPhone() {
		return contactPhone;
	}

	/**
	 * 设置 联系电话
	 */
	public void setContactPhone(String contactPhone) {
		this.contactPhone = contactPhone;
	}

	/**
	 * 获取 所在地址
	 * @return String
	 */
	public String getLocation() {
		return location;
	}

	/**
	 * 设置 所在地址
	 */
	public void setLocation(String location) {
		this.location = location;
	}

	/**
	 * 获取 房屋性质
	 * @return String
	 */
	public String getHouseProperty() {
		return houseProperty;
	}

	/**
	 * 设置 房屋性质
	 */
	public void setHouseProperty(String houseProperty) {
		this.houseProperty = houseProperty;
	}

	/**
	 * 获取 所服务乡镇
	 * @return String
	 */
	public String getServeTowns() {
		return serveTowns;
	}

	/**
	 * 设置 所服务乡镇
	 */
	public void setServeTowns(String serveTowns) {
		this.serveTowns = serveTowns;
	}
	/**
	 * 获取 所服务乡镇id
	 * @return String
	 */
	public String getServeTownsId() {
		return serveTownsId;
	}

	/**
	 * 设置 所服务乡镇id
	 */
	public void setServeTownsId(String serveTownsId) {
		this.serveTownsId = serveTownsId;
	}
	/**
	 * 获取 取暖方式
	 * @return String
	 */
	public String getHeatingWay() {
		return heatingWay;
	}

	/**
	 * 设置 取暖方式
	 */
	public void setHeatingWay(String heatingWay) {
		this.heatingWay = heatingWay;
	}

	/**
	 * 获取 管理制度是否健全
	 * @return String
	 */
	public String getIsManagePerfect() {
		return isManagePerfect;
	}

	/**
	 * 设置 管理制度是否健全
	 */
	public void setIsManagePerfect(String isManagePerfect) {
		this.isManagePerfect = isManagePerfect;
	}

	/**
	 * 获取 岗位责任制是否健全
	 * @return String
	 */
	public String getIsPostPerfect() {
		return isPostPerfect;
	}

	/**
	 * 设置 岗位责任制是否健全
	 */
	public void setIsPostPerfect(String isPostPerfect) {
		this.isPostPerfect = isPostPerfect;
	}

	/**
	 * 获取 是否建立院管委会
	 * @return String
	 */
	public String getIsEstablish() {
		return isEstablish;
	}

	/**
	 * 设置 是否建立院管委会
	 */
	public void setIsEstablish(String isEstablish) {
		this.isEstablish = isEstablish;
	}

	/**
	 * 获取 开展活动情况
	 * @return String
	 */
	public String getActivityAbout() {
		return activityAbout;
	}

	/**
	 * 设置 开展活动情况
	 */
	public void setActivityAbout(String activityAbout) {
		this.activityAbout = activityAbout;
	}

	/**
	 * 获取 院务是否公开
	 * @return String
	 */
	public String getIsManagePublic() {
		return isManagePublic;
	}

	/**
	 * 设置 院务是否公开
	 */
	public void setIsManagePublic(String isManagePublic) {
		this.isManagePublic = isManagePublic;
	}

	/**
	 * 获取 财务是否公开
	 * @return String
	 */
	public String getIsFinancialPublic() {
		return isFinancialPublic;
	}

	/**
	 * 设置 财务是否公开
	 */
	public void setIsFinancialPublic(String isFinancialPublic) {
		this.isFinancialPublic = isFinancialPublic;
	}

	/**
	 * 获取 娱乐健身器材情况
	 * @return String
	 */
	public String getEquipmentAbout() {
		return equipmentAbout;
	}

	/**
	 * 设置 娱乐健身器材情况
	 */
	public void setEquipmentAbout(String equipmentAbout) {
		this.equipmentAbout = equipmentAbout;
	}

	/**
	 * 获取 年种植蔬菜面积
	 * @return BigDecimal
	 */
	public BigDecimal getVegetablesArea() {
		return vegetablesArea;
	}

	/**
	 * 设置 年种植蔬菜面积
	 */
	public void setVegetablesArea(BigDecimal vegetablesArea) {
		this.vegetablesArea = vegetablesArea;
	}

	/**
	 * 获取 年蔬菜产量
	 * @return BigDecimal
	 */
	public BigDecimal getVegetablesYield() {
		return vegetablesYield;
	}

	/**
	 * 设置 年蔬菜产量
	 */
	public void setVegetablesYield(BigDecimal vegetablesYield) {
		this.vegetablesYield = vegetablesYield;
	}

	/**
	 * 获取 备注
	 * @return String
	 */
	public String getRemarks() {
		return remarks;
	}

	/**
	 * 设置 备注
	 */
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public String getIfCurrent() {
		return ifCurrent;
	}

	public void setIfCurrent(String ifCurrent) {
		this.ifCurrent = ifCurrent;
	}

	public BigDecimal getTotalRoomNum() {
		return totalRoomNum;
	}

	public void setTotalRoomNum(BigDecimal totalRoomNum) {
		this.totalRoomNum = totalRoomNum;
	}

	public BigDecimal getTotalBedNum() {
		return totalBedNum;
	}

	public void setTotalBedNum(BigDecimal totalBedNum) {
		this.totalBedNum = totalBedNum;
	}

}