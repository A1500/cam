package com.inspur.cams.drel.sam.data;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;

/**
 * @title:身份代码
 * @description:
 * @author:zhangjian
 * @since:2011-06-18
 * @version:1.0
 */
@Table(tableName = "SAM_ID_CARD", keyFields = "ID")
public class SamIdCard extends StatefulDatabean {
	// 内码
	private String id;
	// 男性身份代码
	private String idCardMan;
	// 女性身份代码
	private String idCardWoman;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getIdCardMan() {
		return idCardMan;
	}
	public void setIdCardMan(String idCardMan) {
		this.idCardMan = idCardMan;
	}
	public String getIdCardWoman() {
		return idCardWoman;
	}
	public void setIdCardWoman(String idCardWoman) {
		this.idCardWoman = idCardWoman;
	}
}