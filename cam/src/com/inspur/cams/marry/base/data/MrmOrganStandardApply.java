package com.inspur.cams.marry.base.data;

import java.math.BigDecimal;

import org.loushang.next.dao.Table;
import org.loushang.next.dao.Transient;
import org.loushang.next.data.StatefulDatabean;

/**
 * 婚姻登记机关等级评定标准业务表databean
 * @author 
 * @date 2012-11-28
 */
@Table(tableName = "MRM_ORGAN_STANDARD_APPLY", keyFields = "applyId")
public class MrmOrganStandardApply extends StatefulDatabean {
	@Transient
	private String dealOrganType;

	// 业务编号
	private String applyId;	

	// 申请类型
	private String applyType;

	// 申请婚姻登记机关
	private String organCode;

	// 申请婚姻登记机关名称
	private String organName;

	// 申请婚姻登记机关级别
	private String organLevel;

	// 申请等级
	private String applyLevel;

	// 申请时间
	private String applyTime;

	// 对外人工或语音咨询电话
	private String phone;

	// 外网地址
	private String web;

	// 机构性质
	private String organType;

	// 上年度工作经费
	private BigDecimal found;

	// 本年度工作经费
	private BigDecimal yearFound;

	// 辖区户籍人口数
	private BigDecimal populateNum;

	// 婚姻登记员人数
	private BigDecimal marriageRegNum;

	// 取得颁证资格人数
	private BigDecimal hasQualifyNum;

	// 婚姻登记员行政编制人数
	private BigDecimal regOneNum;

	// 婚姻登记员参照公务员法管理事业编制人数
	private BigDecimal regTwoNum;

	// 婚姻登记员全额拨款事业编制人数
	private BigDecimal regThreeNum;

	// 上年度工作量
	private BigDecimal workNum;

	// 结婚登记数量
	private BigDecimal marriageNum;

	// 离婚登记数量
	private BigDecimal divorceNum;

	// 补发数量
	private BigDecimal supplyNum;

	// 出具证明数量
	private BigDecimal certNum;

	// 辅导员人数
	private BigDecimal tutorNum;

	// 辅导员来源方式
	private String tutorSource;

	// 辅导员来源方式说明
	private String tutorSourceNote;

	// 候登大厅面积
	private BigDecimal waitArea;

	// 结婚登记窗口个数
	private BigDecimal marriageWinNum;

	// 候登座椅数量
	private BigDecimal waitSeatNum;

	// 填表座椅数量
	private BigDecimal writeSeatNum;

	// 离婚登记室面积
	private BigDecimal divorceArea;

	// 离婚登记窗口数量
	private BigDecimal divorceWinNum;

	// 婚姻家庭辅导室间数
	private BigDecimal tutorRoomNum;

	// 婚姻家庭辅导室面积
	private BigDecimal tutorRoomArea;

	// 颁证大厅面积
	private BigDecimal presentArea;

	// 亲友观礼坐席个数
	private BigDecimal friendSeatNum;

	// 卫生间位置
	private BigDecimal wcNum;

	// 有无无障碍通道
	private String hasAccessiblePathway;

	// 电脑数量
	private BigDecimal computeNum;

	// 打印机数量
	private BigDecimal printerNum;

	// 身份识别系统数量
	private BigDecimal identifyNum;

	// 配有设备
	private String equipment;

	// 实现在线登记时间
	private String onlineDate;

	// 实现数据交互时间
	private String dataChargeDate;

	// 历史数据补录至年份
	private String hisDataDate;

	// 数据量
	private BigDecimal dataNum;

	// 网络预约启动时间
	private String bookingDate;

	// 网络预约数量
	private BigDecimal allBookingNum;

	// 上年度预约数量
	private BigDecimal bookingNum;

	// 当前处理单位代码
	private String curOrganCode;

	// 当前处理单位名称
	private String curOrganName;

	// 审核状态
	private String checkStatus;

	// 审批结果
	private String auditResult;

	// 审批是否结束
	private String ifFinish;

	// 县级民政部门意见
	private String townOpinionId;

	// 县级民政部门补充意见
	private String townOpinion;

	// 县级民政部门代码
	private String townOrganCode;

	// 县级民政部门名称
	private String townOrganName;

	// 县级民政部门审批时间
	private String townAuditTime;

	// 市级民政部门意见
	private String cityOpinionId;

	// 市级民政部门补充意见
	private String cityOpinion;

	// 市级民政部门代码
	private String cityOrganCode;

	// 市级民政部门名称
	private String cityOrganName;

	// 市级民政部门审批时间
	private String cityAuditTime;

	// 省级民政部门意见
	private String provinceOpinionId;

	// 省级民政部门补充意见
	private String provinceOpinion;

	// 省级民政部门代码
	private String provinceOrganCode;

	// 省级民政部门名称
	private String provinceOrganName;

	// 省级民政部门审批时间
	private String provinceAuditTime;

	// 部民政部门意见
	private String departmentOpinionId;

	// 部民政部门补充意见
	private String departmentOpinion;

	// 部民政部门代码
	private String departmentOrganCode;

	// 部民政部门名称
	private String departmentOrganName;

	// 部民政部门审批时间
	private String departmentAuditTime;

	// 系统审查结果
	private String result;
   
	//退出/撤销原因
	private String reason;
	
	//撤销发起单位代码
	private String cancelOrgan;
	
	//撤销发起单位名称
	private String cancelOrganName;
	
	//通知整改时间
	private String correctDate;
	
	//整改发起单位区划
	private String correctOrganCode;
	
	//整改发起单位
	private String correctOrgan;
	
	//整改发起单位等级
	private String correctOrganLevel;
	
	//整改内容
	private String correctContent;
	
	//整改结果
	private String correctResult;
	
	//整改开始日期
	private String startLine;
	
	//整改截至日期
	private String deadLine;
	
	
	/**
	 * @return the deadLine
	 */
	public String getDeadLine() {
		return deadLine;
	}

	/**
	 * @param deadLine the deadLine to set
	 */
	public void setDeadLine(String deadLine) {
		this.deadLine = deadLine;
	}

	/**
	 * 获取撤销发起单位代码
	 * @return String
	 */
	public String getCancelOrgan() {
		return cancelOrgan;
	}

	/**
	 * 获取整改日期
	 * @return String
	 */
	public String getCorrectDate() {
		return correctDate;
	}

	/**
	 * 设置整改日期
	 */
	public void setCorrectDate(String correctDate) {
		this.correctDate = correctDate;
	}

	/**
	 * 获取整改内容
	 * @return String
	 */
	public String getCorrectContent() {
		return correctContent;
	}

	/**
	 * 设置整改内容
	 */
	public void setCorrectContent(String correctContent) {
		this.correctContent = correctContent;
	}

	/**
	 * 获取整改结果
	 * @return String
	 */
	public String getCorrectResult() {
		return correctResult;
	}

	/**
	 * 设置整改结果
	 */
	public void setCorrectResult(String correctResult) {
		this.correctResult = correctResult;
	}

	/**
	 * 设置 撤销发起单位代码
	 */
	public void setCancelOrgan(String cancelOrgan) {
		this.cancelOrgan = cancelOrgan;
	}

	/**
	 * 获取 撤销发起单位名称
	 * @return String
	 */
	public String getCancelOrganName() {
		return cancelOrganName;
	}
 
	/**
	 * 设置撤销发起单位名称
	 */
	public void setCancelOrganName(String cancelOrganName) {
		this.cancelOrganName = cancelOrganName;
	}

	/**
	 * 获取 退出/撤销原因
	 * @return String
	 */
	public String getReason() {
		return reason;
	}

	/**
	 * 设置 退出/撤销原因
	 */
	public void setReason(String reason) {
		this.reason = reason;
	}

	/**
	 * 获取 业务编号
	 * @return String
	 */
	public String getApplyId() {
		return applyId;
	}

	/**
	 * 设置 业务编号
	 */
	public void setApplyId(String applyId) {
		this.applyId = applyId;
	}

	/**
	 * 获取 申请婚姻登记机关
	 * @return String
	 */
	public String getOrganCode() {
		return organCode;
	}

	/**
	 * 设置 申请婚姻登记机关
	 */
	public void setOrganCode(String organCode) {
		this.organCode = organCode;
	}

	/**
	 * 获取 申请婚姻登记机关名称
	 * @return String
	 */
	public String getOrganName() {
		return organName;
	}

	/**
	 * 设置 申请婚姻登记机关名称
	 */
	public void setOrganName(String organName) {
		this.organName = organName;
	}

	/**
	 * 获取 申请婚姻登记机关级别
	 * @return String
	 */
	public String getOrganLevel() {
		return organLevel;
	}

	/**
	 * 设置 申请婚姻登记机关级别
	 */
	public void setOrganLevel(String organLevel) {
		this.organLevel = organLevel;
	}

	/**
	 * 获取 申请等级
	 * @return String
	 */
	public String getApplyLevel() {
		return applyLevel;
	}

	/**
	 * 设置 申请等级
	 */
	public void setApplyLevel(String applyLevel) {
		this.applyLevel = applyLevel;
	}

	/**
	 * 获取 申请时间
	 * @return String
	 */
	public String getApplyTime() {
		return applyTime;
	}

	/**
	 * 设置 申请时间
	 */
	public void setApplyTime(String applyTime) {
		this.applyTime = applyTime;
	}

	/**
	 * 获取 对外人工或语音咨询电话
	 * @return String
	 */
	public String getPhone() {
		return phone;
	}

	/**
	 * 设置 对外人工或语音咨询电话
	 */
	public void setPhone(String phone) {
		this.phone = phone;
	}

	/**
	 * 获取 外网地址
	 * @return String
	 */
	public String getWeb() {
		return web;
	}

	/**
	 * 设置 外网地址
	 */
	public void setWeb(String web) {
		this.web = web;
	}

	/**
	 * 获取 机构性质
	 * @return String
	 */
	public String getOrganType() {
		return organType;
	}

	/**
	 * 设置 机构性质
	 */
	public void setOrganType(String organType) {
		this.organType = organType;
	}

	/**
	 * 获取 上年度工作经费
	 * @return BigDecimal
	 */
	public BigDecimal getFound() {
		return found;
	}

	/**
	 * 设置 上年度工作经费
	 */
	public void setFound(BigDecimal found) {
		this.found = found;
	}

	/**
	 * 获取 本年度工作经费
	 * @return BigDecimal
	 */
	public BigDecimal getYearFound() {
		return yearFound;
	}

	/**
	 * 设置 本年度工作经费
	 */
	public void setYearFound(BigDecimal yearFound) {
		this.yearFound = yearFound;
	}

	/**
	 * 获取 辖区户籍人口数
	 * @return BigDecimal
	 */
	public BigDecimal getPopulateNum() {
		return populateNum;
	}

	/**
	 * 设置 辖区户籍人口数
	 */
	public void setPopulateNum(BigDecimal populateNum) {
		this.populateNum = populateNum;
	}

	/**
	 * 获取 婚姻登记员人数
	 * @return BigDecimal
	 */
	public BigDecimal getMarriageRegNum() {
		return marriageRegNum;
	}

	/**
	 * 设置 婚姻登记员人数
	 */
	public void setMarriageRegNum(BigDecimal marriageRegNum) {
		this.marriageRegNum = marriageRegNum;
	}

	/**
	 * 获取 取得颁证资格人数
	 * @return BigDecimal
	 */
	public BigDecimal getHasQualifyNum() {
		return hasQualifyNum;
	}

	/**
	 * 设置 取得颁证资格人数
	 */
	public void setHasQualifyNum(BigDecimal hasQualifyNum) {
		this.hasQualifyNum = hasQualifyNum;
	}

	/**
	 * 获取 婚姻登记员行政编制人数
	 * @return BigDecimal
	 */
	public BigDecimal getRegOneNum() {
		return regOneNum;
	}

	/**
	 * 设置 婚姻登记员行政编制人数
	 */
	public void setRegOneNum(BigDecimal regOneNum) {
		this.regOneNum = regOneNum;
	}

	/**
	 * 获取 婚姻登记员参照公务员法管理事业编制人数
	 * @return BigDecimal
	 */
	public BigDecimal getRegTwoNum() {
		return regTwoNum;
	}

	/**
	 * 设置 婚姻登记员参照公务员法管理事业编制人数
	 */
	public void setRegTwoNum(BigDecimal regTwoNum) {
		this.regTwoNum = regTwoNum;
	}

	/**
	 * 获取 婚姻登记员全额拨款事业编制人数
	 * @return BigDecimal
	 */
	public BigDecimal getRegThreeNum() {
		return regThreeNum;
	}

	/**
	 * 设置 婚姻登记员全额拨款事业编制人数
	 */
	public void setRegThreeNum(BigDecimal regThreeNum) {
		this.regThreeNum = regThreeNum;
	}

	/**
	 * 获取 上年度工作量
	 * @return BigDecimal
	 */
	public BigDecimal getWorkNum() {
		return workNum;
	}

	/**
	 * 设置 上年度工作量
	 */
	public void setWorkNum(BigDecimal workNum) {
		this.workNum = workNum;
	}

	/**
	 * 获取 结婚登记数量
	 * @return BigDecimal
	 */
	public BigDecimal getMarriageNum() {
		return marriageNum;
	}

	/**
	 * 设置 结婚登记数量
	 */
	public void setMarriageNum(BigDecimal marriageNum) {
		this.marriageNum = marriageNum;
	}

	/**
	 * 获取 离婚登记数量
	 * @return BigDecimal
	 */
	public BigDecimal getDivorceNum() {
		return divorceNum;
	}

	/**
	 * 设置 离婚登记数量
	 */
	public void setDivorceNum(BigDecimal divorceNum) {
		this.divorceNum = divorceNum;
	}

	/**
	 * 获取 补发数量
	 * @return BigDecimal
	 */
	public BigDecimal getSupplyNum() {
		return supplyNum;
	}

	/**
	 * 设置 补发数量
	 */
	public void setSupplyNum(BigDecimal supplyNum) {
		this.supplyNum = supplyNum;
	}

	/**
	 * 获取 出具证明数量
	 * @return BigDecimal
	 */
	public BigDecimal getCertNum() {
		return certNum;
	}

	/**
	 * 设置 出具证明数量
	 */
	public void setCertNum(BigDecimal certNum) {
		this.certNum = certNum;
	}

	/**
	 * 获取 辅导员人数
	 * @return BigDecimal
	 */
	public BigDecimal getTutorNum() {
		return tutorNum;
	}

	/**
	 * 设置 辅导员人数
	 */
	public void setTutorNum(BigDecimal tutorNum) {
		this.tutorNum = tutorNum;
	}

	/**
	 * 获取 辅导员来源方式
	 * @return String
	 */
	public String getTutorSource() {
		return tutorSource;
	}

	/**
	 * 设置 辅导员来源方式
	 */
	public void setTutorSource(String tutorSource) {
		this.tutorSource = tutorSource;
	}

	/**
	 * 获取 辅导员来源方式说明
	 * @return String
	 */
	public String getTutorSourceNote() {
		return tutorSourceNote;
	}

	/**
	 * 设置 辅导员来源方式说明
	 */
	public void setTutorSourceNote(String tutorSourceNote) {
		this.tutorSourceNote = tutorSourceNote;
	}

	/**
	 * 获取 候登大厅面积
	 * @return BigDecimal
	 */
	public BigDecimal getWaitArea() {
		return waitArea;
	}

	/**
	 * 设置 候登大厅面积
	 */
	public void setWaitArea(BigDecimal waitArea) {
		this.waitArea = waitArea;
	}

	/**
	 * 获取 结婚登记窗口个数
	 * @return BigDecimal
	 */
	public BigDecimal getMarriageWinNum() {
		return marriageWinNum;
	}

	/**
	 * 设置 结婚登记窗口个数
	 */
	public void setMarriageWinNum(BigDecimal marriageWinNum) {
		this.marriageWinNum = marriageWinNum;
	}

	/**
	 * 获取 候登座椅数量
	 * @return BigDecimal
	 */
	public BigDecimal getWaitSeatNum() {
		return waitSeatNum;
	}

	/**
	 * 设置 候登座椅数量
	 */
	public void setWaitSeatNum(BigDecimal waitSeatNum) {
		this.waitSeatNum = waitSeatNum;
	}

	/**
	 * 获取 填表座椅数量
	 * @return BigDecimal
	 */
	public BigDecimal getWriteSeatNum() {
		return writeSeatNum;
	}

	/**
	 * 设置 填表座椅数量
	 */
	public void setWriteSeatNum(BigDecimal writeSeatNum) {
		this.writeSeatNum = writeSeatNum;
	}

	/**
	 * 获取 离婚登记室面积
	 * @return BigDecimal
	 */
	public BigDecimal getDivorceArea() {
		return divorceArea;
	}

	/**
	 * 设置 离婚登记室面积
	 */
	public void setDivorceArea(BigDecimal divorceArea) {
		this.divorceArea = divorceArea;
	}

	/**
	 * 获取 离婚登记窗口数量
	 * @return BigDecimal
	 */
	public BigDecimal getDivorceWinNum() {
		return divorceWinNum;
	}

	/**
	 * 设置 离婚登记窗口数量
	 */
	public void setDivorceWinNum(BigDecimal divorceWinNum) {
		this.divorceWinNum = divorceWinNum;
	}

	/**
	 * 获取 婚姻家庭辅导室间数
	 * @return BigDecimal
	 */
	public BigDecimal getTutorRoomNum() {
		return tutorRoomNum;
	}

	/**
	 * 设置 婚姻家庭辅导室间数
	 */
	public void setTutorRoomNum(BigDecimal tutorRoomNum) {
		this.tutorRoomNum = tutorRoomNum;
	}

	/**
	 * 获取 婚姻家庭辅导室面积
	 * @return BigDecimal
	 */
	public BigDecimal getTutorRoomArea() {
		return tutorRoomArea;
	}

	/**
	 * 设置 婚姻家庭辅导室面积
	 */
	public void setTutorRoomArea(BigDecimal tutorRoomArea) {
		this.tutorRoomArea = tutorRoomArea;
	}

	/**
	 * 获取 颁证大厅面积
	 * @return BigDecimal
	 */
	public BigDecimal getPresentArea() {
		return presentArea;
	}

	/**
	 * 设置 颁证大厅面积
	 */
	public void setPresentArea(BigDecimal presentArea) {
		this.presentArea = presentArea;
	}

	/**
	 * 获取 亲友观礼坐席个数
	 * @return BigDecimal
	 */
	public BigDecimal getFriendSeatNum() {
		return friendSeatNum;
	}

	/**
	 * 设置 亲友观礼坐席个数
	 */
	public void setFriendSeatNum(BigDecimal friendSeatNum) {
		this.friendSeatNum = friendSeatNum;
	}

	/**
	 * 获取 卫生间位置
	 * @return BigDecimal
	 */
	public BigDecimal getWcNum() {
		return wcNum;
	}

	/**
	 * 设置 卫生间位置
	 */
	public void setWcNum(BigDecimal wcNum) {
		this.wcNum = wcNum;
	}

	/**
	 * 获取 有无无障碍通道
	 * @return String
	 */
	public String getHasAccessiblePathway() {
		return hasAccessiblePathway;
	}

	/**
	 * 设置 有无无障碍通道
	 */
	public void setHasAccessiblePathway(String hasAccessiblePathway) {
		this.hasAccessiblePathway = hasAccessiblePathway;
	}

	/**
	 * 获取 电脑数量
	 * @return BigDecimal
	 */
	public BigDecimal getComputeNum() {
		return computeNum;
	}

	/**
	 * 设置 电脑数量
	 */
	public void setComputeNum(BigDecimal computeNum) {
		this.computeNum = computeNum;
	}

	/**
	 * 获取 打印机数量
	 * @return BigDecimal
	 */
	public BigDecimal getPrinterNum() {
		return printerNum;
	}

	/**
	 * 设置 打印机数量
	 */
	public void setPrinterNum(BigDecimal printerNum) {
		this.printerNum = printerNum;
	}

	/**
	 * 获取 身份识别系统数量
	 * @return BigDecimal
	 */
	public BigDecimal getIdentifyNum() {
		return identifyNum;
	}

	/**
	 * 设置 身份识别系统数量
	 */
	public void setIdentifyNum(BigDecimal identifyNum) {
		this.identifyNum = identifyNum;
	}

	/**
	 * 获取 配有设备
	 * @return String
	 */
	public String getEquipment() {
		return equipment;
	}

	/**
	 * 设置 配有设备
	 */
	public void setEquipment(String equipment) {
		this.equipment = equipment;
	}

	/**
	 * 获取 实现在线登记时间
	 * @return String
	 */
	public String getOnlineDate() {
		return onlineDate;
	}

	/**
	 * 设置 实现在线登记时间
	 */
	public void setOnlineDate(String onlineDate) {
		this.onlineDate = onlineDate;
	}

	/**
	 * 获取 实现数据交互时间
	 * @return String
	 */
	public String getDataChargeDate() {
		return dataChargeDate;
	}

	/**
	 * 设置 实现数据交互时间
	 */
	public void setDataChargeDate(String dataChargeDate) {
		this.dataChargeDate = dataChargeDate;
	}

	/**
	 * 获取 历史数据补录至年份
	 * @return String
	 */
	public String getHisDataDate() {
		return hisDataDate;
	}

	/**
	 * 设置 历史数据补录至年份
	 */
	public void setHisDataDate(String hisDataDate) {
		this.hisDataDate = hisDataDate;
	}

	/**
	 * 获取 数据量
	 * @return BigDecimal
	 */
	public BigDecimal getDataNum() {
		return dataNum;
	}

	/**
	 * 设置 数据量
	 */
	public void setDataNum(BigDecimal dataNum) {
		this.dataNum = dataNum;
	}

	/**
	 * 获取 网络预约启动时间
	 * @return String
	 */
	public String getBookingDate() {
		return bookingDate;
	}

	/**
	 * 设置 网络预约启动时间
	 */
	public void setBookingDate(String bookingDate) {
		this.bookingDate = bookingDate;
	}

	/**
	 * 获取 网络预约数量
	 * @return BigDecimal
	 */
	public BigDecimal getAllBookingNum() {
		return allBookingNum;
	}

	/**
	 * 设置 网络预约数量
	 */
	public void setAllBookingNum(BigDecimal allBookingNum) {
		this.allBookingNum = allBookingNum;
	}

	/**
	 * 获取 上年度预约数量
	 * @return BigDecimal
	 */
	public BigDecimal getBookingNum() {
		return bookingNum;
	}

	/**
	 * 设置 上年度预约数量
	 */
	public void setBookingNum(BigDecimal bookingNum) {
		this.bookingNum = bookingNum;
	}

	/**
	 * 获取 当前处理单位代码
	 * @return String
	 */
	public String getCurOrganCode() {
		return curOrganCode;
	}

	/**
	 * 设置 当前处理单位代码
	 */
	public void setCurOrganCode(String curOrganCode) {
		this.curOrganCode = curOrganCode;
	}

	/**
	 * 获取 当前处理单位名称
	 * @return String
	 */
	public String getCurOrganName() {
		return curOrganName;
	}

	/**
	 * 设置 当前处理单位名称
	 */
	public void setCurOrganName(String curOrganName) {
		this.curOrganName = curOrganName;
	}

	/**
	 * 获取 审批结果
	 * @return String
	 */
	public String getAuditResult() {
		return auditResult;
	}

	/**
	 * 设置 审批结果
	 */
	public void setAuditResult(String auditResult) {
		this.auditResult = auditResult;
	}

	/**
	 * 获取 审批是否结束
	 * @return String
	 */
	public String getIfFinish() {
		return ifFinish;
	}

	/**
	 * 设置 审批是否结束
	 */
	public void setIfFinish(String ifFinish) {
		this.ifFinish = ifFinish;
	}

	/**
	 * 获取 县级民政部门意见
	 * @return String
	 */
	public String getTownOpinionId() {
		return townOpinionId;
	}

	/**
	 * 设置 县级民政部门意见
	 */
	public void setTownOpinionId(String townOpinionId) {
		this.townOpinionId = townOpinionId;
	}

	/**
	 * 获取 县级民政部门补充意见
	 * @return String
	 */
	public String getTownOpinion() {
		return townOpinion;
	}

	/**
	 * 设置 县级民政部门补充意见
	 */
	public void setTownOpinion(String townOpinion) {
		this.townOpinion = townOpinion;
	}

	/**
	 * 获取 县级民政部门代码
	 * @return String
	 */
	public String getTownOrganCode() {
		return townOrganCode;
	}

	/**
	 * 设置 县级民政部门代码
	 */
	public void setTownOrganCode(String townOrganCode) {
		this.townOrganCode = townOrganCode;
	}

	/**
	 * 获取 县级民政部门名称
	 * @return String
	 */
	public String getTownOrganName() {
		return townOrganName;
	}

	/**
	 * 设置 县级民政部门名称
	 */
	public void setTownOrganName(String townOrganName) {
		this.townOrganName = townOrganName;
	}

	/**
	 * 获取 县级民政部门审批时间
	 * @return String
	 */
	public String getTownAuditTime() {
		return townAuditTime;
	}

	/**
	 * 设置 县级民政部门审批时间
	 */
	public void setTownAuditTime(String townAuditTime) {
		this.townAuditTime = townAuditTime;
	}

	/**
	 * 获取 市级民政部门意见
	 * @return String
	 */
	public String getCityOpinionId() {
		return cityOpinionId;
	}

	/**
	 * 设置 市级民政部门意见
	 */
	public void setCityOpinionId(String cityOpinionId) {
		this.cityOpinionId = cityOpinionId;
	}

	/**
	 * 获取 市级民政部门补充意见
	 * @return String
	 */
	public String getCityOpinion() {
		return cityOpinion;
	}

	/**
	 * 设置 市级民政部门补充意见
	 */
	public void setCityOpinion(String cityOpinion) {
		this.cityOpinion = cityOpinion;
	}

	/**
	 * 获取 市级民政部门代码
	 * @return String
	 */
	public String getCityOrganCode() {
		return cityOrganCode;
	}

	/**
	 * 设置 市级民政部门代码
	 */
	public void setCityOrganCode(String cityOrganCode) {
		this.cityOrganCode = cityOrganCode;
	}

	/**
	 * 获取 市级民政部门名称
	 * @return String
	 */
	public String getCityOrganName() {
		return cityOrganName;
	}

	/**
	 * 设置 市级民政部门名称
	 */
	public void setCityOrganName(String cityOrganName) {
		this.cityOrganName = cityOrganName;
	}

	/**
	 * 获取 市级民政部门审批时间
	 * @return String
	 */
	public String getCityAuditTime() {
		return cityAuditTime;
	}

	/**
	 * 设置 市级民政部门审批时间
	 */
	public void setCityAuditTime(String cityAuditTime) {
		this.cityAuditTime = cityAuditTime;
	}

	/**
	 * 获取 省级民政部门意见
	 * @return String
	 */
	public String getProvinceOpinionId() {
		return provinceOpinionId;
	}

	/**
	 * 设置 省级民政部门意见
	 */
	public void setProvinceOpinionId(String provinceOpinionId) {
		this.provinceOpinionId = provinceOpinionId;
	}

	/**
	 * 获取 省级民政部门补充意见
	 * @return String
	 */
	public String getProvinceOpinion() {
		return provinceOpinion;
	}

	/**
	 * 设置 省级民政部门补充意见
	 */
	public void setProvinceOpinion(String provinceOpinion) {
		this.provinceOpinion = provinceOpinion;
	}

	/**
	 * 获取 省级民政部门代码
	 * @return String
	 */
	public String getProvinceOrganCode() {
		return provinceOrganCode;
	}

	/**
	 * 设置 省级民政部门代码
	 */
	public void setProvinceOrganCode(String provinceOrganCode) {
		this.provinceOrganCode = provinceOrganCode;
	}

	/**
	 * 获取 省级民政部门名称
	 * @return String
	 */
	public String getProvinceOrganName() {
		return provinceOrganName;
	}

	/**
	 * 设置 省级民政部门名称
	 */
	public void setProvinceOrganName(String provinceOrganName) {
		this.provinceOrganName = provinceOrganName;
	}

	/**
	 * 获取 省级民政部门审批时间
	 * @return String
	 */
	public String getProvinceAuditTime() {
		return provinceAuditTime;
	}

	/**
	 * 设置 省级民政部门审批时间
	 */
	public void setProvinceAuditTime(String provinceAuditTime) {
		this.provinceAuditTime = provinceAuditTime;
	}

	/**
	 * 获取 系统审查结果
	 * @return String
	 */
	public String getResult() {
		return result;
	}

	/**
	 * 设置 系统审查结果
	 */
	public void setResult(String result) {
		this.result = result;
	}

	public String getCheckStatus() {
		return checkStatus;
	}

	public void setCheckStatus(String checkStatus) {
		this.checkStatus = checkStatus;
	}

	public String getDepartmentOpinionId() {
		return departmentOpinionId;
	}

	public void setDepartmentOpinionId(String departmentOpinionId) {
		this.departmentOpinionId = departmentOpinionId;
	}

	public String getDepartmentOpinion() {
		return departmentOpinion;
	}

	public void setDepartmentOpinion(String departmentOpinion) {
		this.departmentOpinion = departmentOpinion;
	}

	public String getDepartmentOrganCode() {
		return departmentOrganCode;
	}

	public void setDepartmentOrganCode(String departmentOrganCode) {
		this.departmentOrganCode = departmentOrganCode;
	}

	public String getDepartmentOrganName() {
		return departmentOrganName;
	}

	public void setDepartmentOrganName(String departmentOrganName) {
		this.departmentOrganName = departmentOrganName;
	}

	public String getDepartmentAuditTime() {
		return departmentAuditTime;
	}

	public void setDepartmentAuditTime(String departmentAuditTime) {
		this.departmentAuditTime = departmentAuditTime;
	}

	public String getDealOrganType() {
		return dealOrganType;
	}

	public void setDealOrganType(String dealOrganType) {
		this.dealOrganType = dealOrganType;
	}

	public String getApplyType() {
		return applyType;
	}

	public void setApplyType(String applyType) {
		this.applyType = applyType;
	}

	public String getStartLine() {
		return startLine;
	}

	public void setStartLine(String startLine) {
		this.startLine = startLine;
	}

	public String getCorrectOrganLevel() {
		return correctOrganLevel;
	}

	public void setCorrectOrganLevel(String correctOrganLevel) {
		this.correctOrganLevel = correctOrganLevel;
	}

	public String getCorrectOrganCode() {
		return correctOrganCode;
	}

	public void setCorrectOrganCode(String correctOrganCode) {
		this.correctOrganCode = correctOrganCode;
	}

	public String getCorrectOrgan() {
		return correctOrgan;
	}

	public void setCorrectOrgan(String correctOrgan) {
		this.correctOrgan = correctOrgan;
	}

}