package com.inspur.cams.comm.extuser.data;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * 社会组织年检冻结账号时间配置表
 * @author 闫亮亮
 * @date 2012年7月16日
 */
@Table(tableName = "SORG_CHECK_FREEZE_TIME", keyFields = "freezeId")
public class SorgCheckFreezeTime extends StatefulDatabean {

	// 主键
	private String freezeId;
	
	// 冻结年份
	private String freezeYear;
	
	// 冻结日期
	private String freezeDate;
	
	// 冻结社会组织类型
	private String freezeSorgType;

	public String getFreezeId() {
		return freezeId;
	}

	public void setFreezeId(String freezeId) {
		this.freezeId = freezeId;
	}

	public String getFreezeYear() {
		return freezeYear;
	}

	public void setFreezeYear(String freezeYear) {
		this.freezeYear = freezeYear;
	}

	public String getFreezeDate() {
		return freezeDate;
	}

	public void setFreezeDate(String freezeDate) {
		this.freezeDate = freezeDate;
	}

	public String getFreezeSorgType() {
		return freezeSorgType;
	}

	public void setFreezeSorgType(String freezeSorgType) {
		this.freezeSorgType = freezeSorgType;
	}
	
	
	


}
