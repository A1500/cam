package com.inspur.cams.drel.samu.data;

import java.math.BigDecimal;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 床位信息databean
 * @author 
 * @date 2012-09-26
 */
@Table(tableName = "SAM_BED_INFO", keyFields = "bedId")
public class SamBedInfo extends StatefulDatabean {

	// 床位ID
	private String bedId;

	// 房间ID
	private String roomId;

	// 床位编号或名称
	private String bedName;

	// 备注
	private String remarks;

	/**
	 * 获取 床位ID
	 * @return String
	 */
	public String getBedId() {
		return bedId;
	}

	/**
	 * 设置 床位ID
	 */
	public void setBedId(String bedId) {
		this.bedId = bedId;
	}

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
	 * 获取 床位编号或名称
	 * @return String
	 */
	public String getBedName() {
		return bedName;
	}

	/**
	 * 设置 床位编号或名称
	 */
	public void setBedName(String bedName) {
		this.bedName = bedName;
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