package com.inspur.cams.comm.inform.privilege;

import java.math.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;

/**
 * @title:InInformPrivilege
 * @description:
 * @author:
 * @since:2009-10-28
 * @version:1.0
 */
@Table(tableName = "APPROVALE_IN_INFORM_PRIVILEGE", keyFields = {"id","receiveman","receivemantype"})
public class InformPrivilege extends StatefulDatabean {
	// ID
	@Rule(value = "require")
	@Column(name = "ID")
	private String id;
	// RECEIVEMAN
	@Rule(value = "require")
	@Column(name = "RECEIVEMAN")
	private String receiveman;
	// RECEIVEMANTYPE
	@Rule(value = "require")
	@Column(name = "RECEIVEMANTYPE")
	private String receivemantype;
	// FLAG
	@Column(name = "FLAG")
	private String flag;//是否已阅
	// RECEIVEORDER
	@Rule(value = "number")
	@Column(name = "RECEIVEORDER")
	private BigDecimal receiveorder;

	/**
	 * getter for ID
	 *
	 * @generated
	 */
	public String getId() {
		return this.id;
	}

	/**
	 * setter for ID
	 *
	 * @generated
	 */
	public void setId(String id) {
		this.id = id;
	}

	/**
	 * getter for RECEIVEMAN
	 *
	 * @generated
	 */
	public String getReceiveman() {
		return this.receiveman;
	}

	/**
	 * setter for RECEIVEMAN
	 *
	 * @generated
	 */
	public void setReceiveman(String receiveman) {
		this.receiveman = receiveman;
	}

	/**
	 * getter for RECEIVEMANTYPE
	 *
	 * @generated
	 */
	public String getReceivemantype() {
		return this.receivemantype;
	}

	/**
	 * setter for RECEIVEMANTYPE
	 *
	 * @generated
	 */
	public void setReceivemantype(String receivemantype) {
		this.receivemantype = receivemantype;
	}

	/**
	 * getter for FLAG
	 *
	 * @generated
	 */
	public String getFlag() {
		return this.flag;
	}

	/**
	 * setter for FLAG
	 *
	 * @generated
	 */
	public void setFlag(String flag) {
		this.flag = flag;
	}

	/**
	 * getter for RECEIVEORDER
	 *
	 * @generated
	 */
	public BigDecimal getReceiveorder() {
		return this.receiveorder;
	}

	/**
	 * setter for RECEIVEORDER
	 *
	 * @generated
	 */
	public void setReceiveorder(BigDecimal receiveorder) {
		this.receiveorder = receiveorder;
	}

}