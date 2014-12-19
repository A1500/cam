package com.inspur.cams.comm.diccity.data;
import org.loushang.next.dao.*;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

@Table(tableName = "PUB_CANT", keyFields = "cantCode")
public class DicPubCant extends StatefulDatabean {
	@Rule(value = "require")
	private String cantCode;
	@Column(name = "CANT_NAME")
	private String cantName;
	@Column(name = "SHORT_NAME")
	private String shortName;
	@Column(name = "CANT_TYPE")
	private String cantType;
	@Column(name = "SUPER_CODE")
	private String superCode;
	@Column(name = "IN_USE")
	private String inUse;
	@Column(name = "COUNTRY_CODE")
	private String countryCode;
	@Column(name = "CANT_NOTE")
	private String cantNote;
	public String getCantCode() {
		return cantCode;
	}
	public void setCantCode(String cantCode) {
		this.cantCode = cantCode;
	}
	public String getCantName() {
		return cantName;
	}
	public void setCantName(String cantName) {
		this.cantName = cantName;
	}
	public String getShortName() {
		return shortName;
	}
	public void setShortName(String shortName) {
		this.shortName = shortName;
	}
	public String getCantType() {
		return cantType;
	}
	public void setCantType(String cantType) {
		this.cantType = cantType;
	}
	public String getSuperCode() {
		return superCode;
	}
	public void setSuperCode(String superCode) {
		this.superCode = superCode;
	}
	public String getInUse() {
		return inUse;
	}
	public void setInUse(String inUse) {
		this.inUse = inUse;
	}
	public String getCountryCode() {
		return countryCode;
	}
	public void setCountryCode(String countryCode) {
		this.countryCode = countryCode;
	}
	public String getCantNote() {
		return cantNote;
	}
	public void setCantNote(String cantNote) {
		this.cantNote = cantNote;
	}

}
