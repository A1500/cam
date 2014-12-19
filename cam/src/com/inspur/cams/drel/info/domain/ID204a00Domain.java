package com.inspur.cams.drel.info.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.info.data.D204a00;

/**
 * 核对总体情况domain
 * @author 
 * @date 2014-06-09
 */
public interface ID204a00Domain {

	/**
	 * 查询 核对总体情况
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 核对总体情况
	 * @param pset
	 * @return
	 */
	public D204a00 get(String d204a00Id);

	/**
	 * 增加 核对总体情况
	 * @param d204a00
	 */
	@Trans
	public void insert(D204a00 d204a00);
	
	/**
	 * 修改 核对总体情况
	 * @param d204a00
	 */
	@Trans
	public void update(D204a00 d204a00);
	
	/**
	 * 删除 核对总体情况
	 * @param d204a00Id
	 */
	@Trans
	public void delete(String d204a00Id);

}