package com.inspur.cams.drel.mbalance.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;
/***
 * 一站结算_救助封顶线bean
 * @author yanliangliang
 * @date 2011-6-15
 */
@Table(tableName = "sam_medical_top_line" , keyFields = "ID")
public class SamMedicalTopLine extends StatefulDatabean{
	
	//流水号
	private String id;
	//救助对象属地
	@Column(name = "DOMICILE_CODE")
	private String domicileCode;
	//救助对象类型
	private String type;
	//年份
	private String year;
	//救助封顶线
	private String topLine;
	//修改人
	private String modPeople;
	//修改单位
	private String modOrgan;
	//修改时间
	private String modTime;
	
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getTopLine() {
		return topLine;
	}
	public void setTopLine(String topLine) {
		this.topLine = topLine;
	}
	public String getModPeople() {
		return modPeople;
	}
	public void setModPeople(String modPeople) {
		this.modPeople = modPeople;
	}
	public String getModOrgan() {
		return modOrgan;
	}
	public void setModOrgan(String modOrgan) {
		this.modOrgan = modOrgan;
	}
	public String getModTime() {
		return modTime;
	}
	public void setModTime(String modTime) {
		this.modTime = modTime;
	}
	public String getDomicileCode() {
		return domicileCode;
	}
	public void setDomicileCode(String domicileCode) {
		this.domicileCode = domicileCode;
	}
	
}
