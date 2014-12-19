package com.inspur.cams.cdc.base.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.dao.Transient;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * 基础信息社区服务信息�?databean
 * @author 
 * @date [Mon Dec 19 11:31:22 GMT 2011]
 */
@Table(tableName = "CDC_SERVICE_INFO", keyFields = "serviceId")
public class CdcServiceInfo extends StatefulDatabean {

	// 服务内码
	private String serviceId;

	// 统计内码
	private String recordId;

	// 服务类型
	@Rule(value="require")
	private String serviceType;

	// 服务名称
	@Rule(value="require")
	private String serviceName;

	// 服务地点
	private String serviceAdds;

	// 服务成立时间
	private String foundDate;

	// 公共服务服务方式
	private String serviceMode;

	// 便民利民服务性质
	private String serviceKind;

	// 服务内容
	private String content;
	
	@Transient
	private String contents;
	
	// 服务场所面积
	private BigDecimal serviceArea;

	// 从事服务人数
	@Rule( value = "number" )
	private BigDecimal peopleNum;

	// 主管单位
	private String morgName;

	// 负责�?
	private String headmen;

	// 服务时间
	private String serviceTime;

	// 志愿者注册人�?
	@Rule( value = "number" )
	private BigDecimal registeNum;


	/**
	 * 设置 服务内码
	 * @return String
	 */
	public String getServiceId() {
		return serviceId;
	}

	/**
	 * 设置 服务内码
	 */
	public void setServiceId(String serviceId) {
		this.serviceId = serviceId;
	}

	public String getRecordId() {
		return recordId;
	}

	public void setRecordId(String recordId) {
		this.recordId = recordId;
	}

	/**
	 * 设置 服务类型
	 * @return String
	 */
	public String getServiceType() {
		return serviceType;
	}

	/**
	 * 设置 服务类型
	 */
	public void setServiceType(String serviceType) {
		this.serviceType = serviceType;
	}

	/**
	 * 设置 服务名称
	 * @return String
	 */
	public String getServiceName() {
		return serviceName;
	}

	/**
	 * 设置 服务名称
	 */
	public void setServiceName(String serviceName) {
		this.serviceName = serviceName;
	}

	/**
	 * 设置 服务地点
	 * @return String
	 */
	public String getServiceAdds() {
		return serviceAdds;
	}

	/**
	 * 设置 服务地点
	 */
	public void setServiceAdds(String serviceAdds) {
		this.serviceAdds = serviceAdds;
	}

	/**
	 * 设置 服务成立时间
	 * @return String
	 */
	public String getFoundDate() {
		return foundDate;
	}

	/**
	 * 设置 服务成立时间
	 */
	public void setFoundDate(String foundDate) {
		this.foundDate = foundDate;
	}

	/**
	 * 设置 公共服务服务方式
	 * @return String
	 */
	public String getServiceMode() {
		return serviceMode;
	}

	/**
	 * 设置 公共服务服务方式
	 */
	public void setServiceMode(String serviceMode) {
		this.serviceMode = serviceMode;
	}

	/**
	 * 设置 便民利民服务性质
	 * @return String
	 */
	public String getServiceKind() {
		return serviceKind;
	}

	/**
	 * 设置 便民利民服务性质
	 */
	public void setServiceKind(String serviceKind) {
		this.serviceKind = serviceKind;
	}

	/**
	 * 设置 服务内容
	 * @return String
	 */
	public String getContent() {
		return content;
	}

	/**
	 * 设置 服务内容
	 */
	public void setContent(String content) {
		this.content = content;
	}
	
	/**
	 * 设置 服务内容（非表列）
	 * @return String
	 */
	public String getContents() {
		return contents;
	}

	/**
	 * 设置 服务内容
	 */
	public void setContents(String contents) {
		this.contents = contents;
	}

	/**
	 * 设置 服务场所面积
	 * @return BigDecimal
	 */
	public BigDecimal getServiceArea() {
		return serviceArea;
	}

	/**
	 * 设置 服务场所面积
	 */
	public void setServiceArea(BigDecimal serviceArea) {
		this.serviceArea = serviceArea;
	}

	/**
	 * 设置 从事服务人数
	 * @return BigDecimal
	 */
	public BigDecimal getPeopleNum() {
		return peopleNum;
	}

	/**
	 * 设置 从事服务人数
	 */
	public void setPeopleNum(BigDecimal peopleNum) {
		this.peopleNum = peopleNum;
	}

	/**
	 * 设置 主管单位
	 * @return String
	 */
	public String getMorgName() {
		return morgName;
	}

	/**
	 * 设置 主管单位
	 */
	public void setMorgName(String morgName) {
		this.morgName = morgName;
	}

	/**
	 * 设置 负责�?
	 * @return String
	 */
	public String getHeadmen() {
		return headmen;
	}

	/**
	 * 设置 负责�?
	 */
	public void setHeadmen(String headmen) {
		this.headmen = headmen;
	}

	/**
	 * 设置 服务时间
	 * @return String
	 */
	public String getServiceTime() {
		return serviceTime;
	}

	/**
	 * 设置 服务时间
	 */
	public void setServiceTime(String serviceTime) {
		this.serviceTime = serviceTime;
	}

	/**
	 * 设置 志愿者注册人�?
	 * @return BigDecimal
	 */
	public BigDecimal getRegisteNum() {
		return registeNum;
	}

	/**
	 * 设置 志愿者注册人�?
	 */
	public void setRegisteNum(BigDecimal registeNum) {
		this.registeNum = registeNum;
	}

}