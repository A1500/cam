package com.inspur.cams.comm.syscncharspell.data;
//导入 java 类
import java.io.Serializable;
 
public class SysCnCharSpell implements Serializable {

	 
	private String id;
 
	private String cnChar;
 
	private String isGb2312;

	 
	private String spell;

	private int orderX;

	private int orderM;

	public SysCnCharSpell() {
		super();
	}


	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	public String getCnChar() {
		return cnChar;
	}

	public void setCnChar(String cnChar) {
		this.cnChar = cnChar;
	}
	public String getIsGb2312() {
		return isGb2312;
	}
	public void setIsGb2312(String isGb2312) {
		this.isGb2312 = isGb2312;
	}
	public String getSpell() {
		return spell;
	}

	public void setSpell(String spell) {
		this.spell = spell;
	}
	public int getOrderX() {
		return orderX;
	}

	public void setOrderX(int orderX) {
		this.orderX = orderX;
	}
	public int getOrderM() {
		return orderM;
	}
	public void setOrderM(int orderM) {
		this.orderM = orderM;
	}

	public static String getVERInfo() {
		return "$Date$,$Author$,$Revision$";
	}

}