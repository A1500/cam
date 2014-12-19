package com.inspur.cams.drel.samu.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 敬老院业务主表databean
 * @author 
 * @date 2012-10-24
 */
@Table(tableName = "SAM_GERO_APPLY", keyFields = "applyId")
public class SamGeroApply extends StatefulDatabean {

	// 业务ID
	private String applyId;

	// 供养对象ID
	private String personId;

	// 敬老院ID
	private String gerocomiumId;

	// 业务类型
	private String applyType;

	// 入院时间
	private String inDate;

	// 入院时健康状况
	private String inHealth;
	
	// 入院时健康状况描述
	private String inHealthDesc;

	// 入院房间
	private String inRoom;

	// 入院床位
	private String inBed;

	// 出院时间
	private String outDate;

	// 出院原因
	private String reason;

	// 零花钱发放年月
	private String pocketYm;

	// 零花钱发放时间
	private String pocketDate;

	// 零花钱发放金额
	private BigDecimal pocketMoney;

	// 零花钱发放确认状态
	private String pocketStatus;

	// 零花钱发放确认人员
	private String pocketPerson;

	// 零花钱发放确认时间
	private String pocketConfirmDate;

	// 服装发放时间
	private String clothDate;

	// 服装类型
	private String clothType;

	// 服装发放套数
	private BigDecimal clothNum;

	// 服装发放确认状态
	private String clothStatus;

	// 服装发放确认人员
	private String clothPerson;

	// 服装发放确认时间
	private String clothConfirmDate;

	// 查体时间
	private String checkDate;

	// 查体结果
	private String checkResult;

	// 更新人
	private String updatePerson;

	// 更新时间
	private String updateDate;

	// 备注
	private String remarks;

	/**
	 * 获取 业务ID
	 * @return String
	 */
	public String getApplyId() {
		return applyId;
	}

	/**
	 * 设置 业务ID
	 */
	public void setApplyId(String applyId) {
		this.applyId = applyId;
	}

	/**
	 * 获取 供养对象ID
	 * @return String
	 */
	public String getPersonId() {
		return personId;
	}

	/**
	 * 设置 供养对象ID
	 */
	public void setPersonId(String personId) {
		this.personId = personId;
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
	 * 获取 业务类型
	 * @return String
	 */
	public String getApplyType() {
		return applyType;
	}

	/**
	 * 设置 业务类型
	 */
	public void setApplyType(String applyType) {
		this.applyType = applyType;
	}

	/**
	 * 获取 入院时间
	 * @return String
	 */
	public String getInDate() {
		return inDate;
	}

	/**
	 * 设置 入院时间
	 */
	public void setInDate(String inDate) {
		this.inDate = inDate;
	}

	/**
	 * 获取 入院时健康状况
	 * @return String
	 */
	public String getInHealth() {
		return inHealth;
	}

	/**
	 * 设置 入院时健康状况
	 */
	public void setInHealth(String inHealth) {
		this.inHealth = inHealth;
	}

	/**
	 * 获取 入院房间
	 * @return String
	 */
	public String getInRoom() {
		return inRoom;
	}

	/**
	 * 设置 入院房间
	 */
	public void setInRoom(String inRoom) {
		this.inRoom = inRoom;
	}

	/**
	 * 获取 入院床位
	 * @return String
	 */
	public String getInBed() {
		return inBed;
	}

	/**
	 * 设置 入院床位
	 */
	public void setInBed(String inBed) {
		this.inBed = inBed;
	}

	/**
	 * 获取 出院时间
	 * @return String
	 */
	public String getOutDate() {
		return outDate;
	}

	/**
	 * 设置 出院时间
	 */
	public void setOutDate(String outDate) {
		this.outDate = outDate;
	}

	/**
	 * 获取 出院原因
	 * @return String
	 */
	public String getReason() {
		return reason;
	}

	/**
	 * 设置 出院原因
	 */
	public void setReason(String reason) {
		this.reason = reason;
	}

	/**
	 * 获取 零花钱发放年月
	 * @return String
	 */
	public String getPocketYm() {
		return pocketYm;
	}

	/**
	 * 设置 零花钱发放年月
	 */
	public void setPocketYm(String pocketYm) {
		this.pocketYm = pocketYm;
	}

	/**
	 * 获取 零花钱发放时间
	 * @return String
	 */
	public String getPocketDate() {
		return pocketDate;
	}

	/**
	 * 设置 零花钱发放时间
	 */
	public void setPocketDate(String pocketDate) {
		this.pocketDate = pocketDate;
	}

	/**
	 * 获取 零花钱发放金额
	 * @return BigDecimal
	 */
	public BigDecimal getPocketMoney() {
		return pocketMoney;
	}

	/**
	 * 设置 零花钱发放金额
	 */
	public void setPocketMoney(BigDecimal pocketMoney) {
		this.pocketMoney = pocketMoney;
	}

	/**
	 * 获取 零花钱发放确认状态
	 * @return String
	 */
	public String getPocketStatus() {
		return pocketStatus;
	}

	/**
	 * 设置 零花钱发放确认状态
	 */
	public void setPocketStatus(String pocketStatus) {
		this.pocketStatus = pocketStatus;
	}

	/**
	 * 获取 零花钱发放确认人员
	 * @return String
	 */
	public String getPocketPerson() {
		return pocketPerson;
	}

	/**
	 * 设置 零花钱发放确认人员
	 */
	public void setPocketPerson(String pocketPerson) {
		this.pocketPerson = pocketPerson;
	}

	/**
	 * 获取 零花钱发放确认时间
	 * @return String
	 */
	public String getPocketConfirmDate() {
		return pocketConfirmDate;
	}

	/**
	 * 设置 零花钱发放确认时间
	 */
	public void setPocketConfirmDate(String pocketConfirmDate) {
		this.pocketConfirmDate = pocketConfirmDate;
	}

	/**
	 * 获取 服装发放时间
	 * @return String
	 */
	public String getClothDate() {
		return clothDate;
	}

	/**
	 * 设置 服装发放时间
	 */
	public void setClothDate(String clothDate) {
		this.clothDate = clothDate;
	}

	/**
	 * 获取 服装类型
	 * @return String
	 */
	public String getClothType() {
		return clothType;
	}

	/**
	 * 设置 服装类型
	 */
	public void setClothType(String clothType) {
		this.clothType = clothType;
	}

	/**
	 * 获取 服装发放套数
	 * @return BigDecimal
	 */
	public BigDecimal getClothNum() {
		return clothNum;
	}

	/**
	 * 设置 服装发放套数
	 */
	public void setClothNum(BigDecimal clothNum) {
		this.clothNum = clothNum;
	}

	/**
	 * 获取 服装发放确认状态
	 * @return String
	 */
	public String getClothStatus() {
		return clothStatus;
	}

	/**
	 * 设置 服装发放确认状态
	 */
	public void setClothStatus(String clothStatus) {
		this.clothStatus = clothStatus;
	}

	/**
	 * 获取 服装发放确认人员
	 * @return String
	 */
	public String getClothPerson() {
		return clothPerson;
	}

	/**
	 * 设置 服装发放确认人员
	 */
	public void setClothPerson(String clothPerson) {
		this.clothPerson = clothPerson;
	}

	/**
	 * 获取 服装发放确认时间
	 * @return String
	 */
	public String getClothConfirmDate() {
		return clothConfirmDate;
	}

	/**
	 * 设置 服装发放确认时间
	 */
	public void setClothConfirmDate(String clothConfirmDate) {
		this.clothConfirmDate = clothConfirmDate;
	}

	/**
	 * 获取 查体时间
	 * @return String
	 */
	public String getCheckDate() {
		return checkDate;
	}

	/**
	 * 设置 查体时间
	 */
	public void setCheckDate(String checkDate) {
		this.checkDate = checkDate;
	}

	/**
	 * 获取 查体结果
	 * @return String
	 */
	public String getCheckResult() {
		return checkResult;
	}

	/**
	 * 设置 查体结果
	 */
	public void setCheckResult(String checkResult) {
		this.checkResult = checkResult;
	}

	/**
	 * 获取 更新人
	 * @return String
	 */
	public String getUpdatePerson() {
		return updatePerson;
	}

	/**
	 * 设置 更新人
	 */
	public void setUpdatePerson(String updatePerson) {
		this.updatePerson = updatePerson;
	}

	/**
	 * 获取 更新时间
	 * @return String
	 */
	public String getUpdateDate() {
		return updateDate;
	}

	/**
	 * 设置 更新时间
	 */
	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
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

	public String getInHealthDesc() {
		return inHealthDesc;
	}

	public void setInHealthDesc(String inHealthDesc) {
		this.inHealthDesc = inHealthDesc;
	}

}