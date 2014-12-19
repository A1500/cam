package com.inspur.cams.drel.info.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.info.data.D204z58;

/**
 * 涉农信息domain
 * @author 
 * @date 2014-06-09
 */
public interface ID204z58Domain {

	/**
	 * 查询 涉农信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 涉农信息
	 * @param pset
	 * @return
	 */
	public D204z58 get(String d204z58Id);

	/**
	 * 增加 涉农信息
	 * @param d204z58
	 */
	@Trans
	public void insert(D204z58 d204z58);
	
	/**
	 * 修改 涉农信息
	 * @param d204z58
	 */
	@Trans
	public void update(D204z58 d204z58);
	
	/**
	 * 删除 涉农信息
	 * @param d204z58Id
	 */
	@Trans
	public void delete(String d204z58Id);

}