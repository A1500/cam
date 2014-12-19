package com.inspur.cams.drel.samu.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 房间信息databean
 * @author 
 * @date 2012-09-26
 */
@Table(tableName = "SAM_ROOM_INFO", keyFields = "roomId")
public class SamRoomInfo extends StatefulDatabean {

	// 房间ID
	private String roomId;

	// 敬老院ID
	private String gerocomiumId;

	// 房间编号或名称
	private String roomName;

	// 使用面积
	private BigDecimal inuseArea;

	// 是否带卫生间
	private String isToilet;

	// 床位数
	private BigDecimal bedNum;

	// 当前状态
	private String status;

	// 备注
	private String remarks;

	/**
	 * 获取 房间ID
	 * @return String
	 */
	public String getRoomId() {
		return roomId;
	}

	/**
	 * 设置 房间ID
	 */
	public void setRoomId(String roomId) {
		this.roomId = roomId;
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
	 * 获取 房间编号或名称
	 * @return String
	 */
	public String getRoomName() {
		return roomName;
	}

	/**
	 * 设置 房间编号或名称
	 */
	public void setRoomName(String roomName) {
		this.roomName = roomName;
	}

	/**
	 * 获取 使用面积
	 * @return BigDecimal
	 */
	public BigDecimal getInuseArea() {
		return inuseArea;
	}

	/**
	 * 设置 使用面积
	 */
	public void setInuseArea(BigDecimal inuseArea) {
		this.inuseArea = inuseArea;
	}

	/**
	 * 获取 是否带卫生间
	 * @return String
	 */
	public String getIsToilet() {
		return isToilet;
	}

	/**
	 * 设置 是否带卫生间
	 */
	public void setIsToilet(String isToilet) {
		this.isToilet = isToilet;
	}

	/**
	 * 获取 床位数
	 * @return BigDecimal
	 */
	public BigDecimal getBedNum() {
		return bedNum;
	}

	/**
	 * 设置 床位数
	 */
	public void setBedNum(BigDecimal bedNum) {
		this.bedNum = bedNum;
	}

	/**
	 * 获取 当前状态
	 * @return String
	 */
	public String getStatus() {
		return status;
	}

	/**
	 * 设置 当前状态
	 */
	public void setStatus(String status) {
		this.status = status;
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

}