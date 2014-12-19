package com.inspur.cams.comm.dicm.data;

import org.loushang.next.dao.Column;
import org.loushang.next.dao.Table;
import org.loushang.next.data.Rule;
import org.loushang.next.data.StatefulDatabean;

/**
 * 字典详细信息databean
 * @author luguosui
 * @date 2011-8-31
 */

@Table(tableName = "DIC_DETAILS" , keyFields= {"DIC_TYPE","CODE"}) 
public class DicDetails extends StatefulDatabean{

	//字典类型
	@Column(name="DIC_TYPE")
	@Rule(value = "require")
	private String dicType;
	
	//代码
	@Column(name="CODE")
	@Rule(value = "require")
	private String code;
	
	//名称
	@Column(name="name")
	@Rule(value = "require")
	private String name;
	
	//是否有效
	@Column(name="FLAG")
	@Rule(value = "require")
	private String flag;
	
	//排序字段名
	@Column(name="ORDER_NUM")
	private String orderNum;

	public String getDicType() {
		return dicType;
	}

	public void setDicType(String dicType) {
		this.dicType = dicType;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}

	public String getOrderNum() {
		return orderNum;
	}

	public void setOrderNum(String orderNum) {
		this.orderNum = orderNum;
	}
}
