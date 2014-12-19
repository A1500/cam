package com.inspur.cams.drel.info.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.info.data.D204z60;

/**
 * 第三方支付信息domain
 * @author 
 * @date 2014-06-09
 */
public interface ID204z60Domain {

	/**
	 * 查询 第三方支付信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 第三方支付信息
	 * @param pset
	 * @return
	 */
	public D204z60 get(String d204z60Id);

	/**
	 * 增加 第三方支付信息
	 * @param d204z60
	 */
	@Trans
	public void insert(D204z60 d204z60);
	
	/**
	 * 修改 第三方支付信息
	 * @param d204z60
	 */
	@Trans
	public void update(D204z60 d204z60);
	
	/**
	 * 删除 第三方支付信息
	 * @param d204z60Id
	 */
	@Trans
	public void delete(String d204z60Id);

}