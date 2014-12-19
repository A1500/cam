package com.inspur.cams.drel.sam.data;

import java.math.BigDecimal;

import org.loushang.next.dao.Table;
import org.loushang.next.data.StatefulDatabean;
/**
 * 家庭财产信息
 * @author yanliangliang
 *2012年5月2日9:38:52
 */
@Table(tableName = "SAM_FAMILY_ESTATE" , keyFields = "estateId")
public class SamFamilyEstate  extends StatefulDatabean {
	//家庭财产ID
	private String estateId;
	//家庭ID
	private String familyId;
	//财产类型
	private String estateType;
	//财产估值
	private BigDecimal estateValue;
	//备注
	private String remarks;
	
	public String getEstateId() {
		return estateId;
	}
	public void setEstateId(String estateId) {
		this.estateId = estateId;
	}
	public String getFamilyId() {
		return familyId;
	}
	public void setFamilyId(String familyId) {
		this.familyId = familyId;
	}
	public String getEstateType() {
		return estateType;
	}
	public void setEstateType(String estateType) {
		this.estateType = estateType;
	}
	
	public BigDecimal getEstateValue() {
		return estateValue;
	}
	public void setEstateValue(BigDecimal estateValue) {
		this.estateValue = estateValue;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	
}
