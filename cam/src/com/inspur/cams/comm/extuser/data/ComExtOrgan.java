package com.inspur.cams.comm.extuser.data;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 外部单位信息
 * @author shgtch
 * @date 2011-6-28
 */
@Table(tableName = "COM_EXT_ORGAN", keyFields = "organId")
public class ComExtOrgan extends StatefulDatabean {

	// 1-单位编码
	private String organId;
	
	// 2-单位名称
	private String organName;
	
	// 3-单位级别
	private String organLev;
	
	// 4-单位类型
	private String organType;
	
	// 5-单位地址
	private String organAdds;
	
	// 6-单位联系人
	private String organPeople;
	
	// 7-单位联系电话
	private String organPhone;

	// 8-单位状态
	private String organStatus;
	
	// 9-管理机关组织结构内码
	private String morgId;
	
	// 10-所属行政区划
	private String areaCode;
	
	// 11-所属行政区划名称
	private String areaName;
	
	// 12-创建人
	private String createPeople;
	
	// 13-创建时间
	private String createTime;
	// 14-是否可用
	private String inUse;
	
	//龙头企业扩展字段 开始 2012年03月30 日
	private String organOrder;//--15-单位顺序（预留）
	private String zipCode;//--16-邮政编码
	private String organWeb;//--17-网址
	private String organMail;//18-电子邮箱
	private String organLegal;//19-法人代表
	private String organChairman;//20-董事长
	private String organChairmanPhone;//21-董事长联系方式
	private String organManager;//22-总经理
	private String organManagerPhone;//23-总经理联系方式
	private String organRegType;//24-登记注册类型
	private String organOprType;//25-经营类型
	private String reportPeople;//26-填表人
	private String reportPhone;//27-填表人联系方式
    private String organGrades;//28-龙头企业级别
    private String saveStatus;//29-保存初始化状态标志
    private String ifBranch;//30-是否有分支机构
	//龙头企业扩展字段 结束 2012年03月30 日
    
	public String getOrganId() {
		return organId;
	}
	public void setOrganId(String organId) {
		this.organId = organId;
	}
	public String getOrganName() {
		return organName;
	}
	public void setOrganName(String organName) {
		this.organName = organName;
	}
	public String getOrganLev() {
		return organLev;
	}
	public void setOrganLev(String organLev) {
		this.organLev = organLev;
	}
	public String getOrganType() {
		return organType;
	}
	public void setOrganType(String organType) {
		this.organType = organType;
	}
	public String getOrganAdds() {
		return organAdds;
	}
	public void setOrganAdds(String organAdds) {
		this.organAdds = organAdds;
	}
	public String getOrganPeople() {
		return organPeople;
	}
	public void setOrganPeople(String organPeople) {
		this.organPeople = organPeople;
	}
	public String getOrganPhone() {
		return organPhone;
	}
	public void setOrganPhone(String organPhone) {
		this.organPhone = organPhone;
	}
	public String getOrganStatus() {
		return organStatus;
	}
	public void setOrganStatus(String organStatus) {
		this.organStatus = organStatus;
	}
	public String getMorgId() {
		return morgId;
	}
	public void setMorgId(String morgId) {
		this.morgId = morgId;
	}
	public String getAreaCode() {
		return areaCode;
	}
	public void setAreaCode(String areaCode) {
		this.areaCode = areaCode;
	}
	public String getAreaName() {
		return areaName;
	}
	public void setAreaName(String areaName) {
		this.areaName = areaName;
	}
	public String getCreatePeople() {
		return createPeople;
	}
	public void setCreatePeople(String createPeople) {
		this.createPeople = createPeople;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public String getInUse() {
		return inUse;
	}
	public void setInUse(String inUse) {
		this.inUse = inUse;
	}
	public String getZipCode() {
		return zipCode;
	}
	public void setZipCode(String zipCode) {
		this.zipCode = zipCode;
	}
	public String getOrganWeb() {
		return organWeb;
	}
	public void setOrganWeb(String organWeb) {
		this.organWeb = organWeb;
	}
	public String getOrganMail() {
		return organMail;
	}
	public void setOrganMail(String organMail) {
		this.organMail = organMail;
	}
	public String getOrganLegal() {
		return organLegal;
	}
	public void setOrganLegal(String organLegal) {
		this.organLegal = organLegal;
	}
	public String getOrganChairman() {
		return organChairman;
	}
	public void setOrganChairman(String organChairman) {
		this.organChairman = organChairman;
	}
	public String getOrganChairmanPhone() {
		return organChairmanPhone;
	}
	public void setOrganChairmanPhone(String organChairmanPhone) {
		this.organChairmanPhone = organChairmanPhone;
	}
	public String getOrganManager() {
		return organManager;
	}
	public void setOrganManager(String organManager) {
		this.organManager = organManager;
	}
	public String getOrganManagerPhone() {
		return organManagerPhone;
	}
	public void setOrganManagerPhone(String organManagerPhone) {
		this.organManagerPhone = organManagerPhone;
	}
	public String getOrganRegType() {
		return organRegType;
	}
	public void setOrganRegType(String organRegType) {
		this.organRegType = organRegType;
	}
	public String getOrganOprType() {
		return organOprType;
	}
	public void setOrganOprType(String organOprType) {
		this.organOprType = organOprType;
	}
	public String getReportPeople() {
		return reportPeople;
	}
	public void setReportPeople(String reportPeople) {
		this.reportPeople = reportPeople;
	}
	public String getReportPhone() {
		return reportPhone;
	}
	public void setReportPhone(String reportPhone) {
		this.reportPhone = reportPhone;
	}
	public String getOrganGrades() {
		return organGrades;
	}
	public void setOrganGrades(String organGrades) {
		this.organGrades = organGrades;
	}
	public String getSaveStatus() {
		return saveStatus;
	}
	public void setSaveStatus(String saveStatus) {
		this.saveStatus = saveStatus;
	}
	public String getOrganOrder() {
		return organOrder;
	}
	public void setOrganOrder(String organOrder) {
		this.organOrder = organOrder;
	}
	public String getIfBranch() {
		return ifBranch;
	}
	public void setIfBranch(String ifBranch) {
		this.ifBranch = ifBranch;
	}
	
 
}
