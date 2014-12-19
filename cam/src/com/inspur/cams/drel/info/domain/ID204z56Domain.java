package com.inspur.cams.drel.info.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.info.data.D204z56;

/**
 * 核对统计信息domain
 * @author 
 * @date 2014-06-09
 */
public interface ID204z56Domain {

	/**
	 * 查询 核对统计信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 核对统计信息
	 * @param pset
	 * @return
	 */
	public D204z56 get(String d204z56Id);

	/**
	 * 增加 核对统计信息
	 * @param d204z56
	 */
	@Trans
	public void insert(D204z56 d204z56);
	
	/**
	 * 修改 核对统计信息
	 * @param d204z56
	 */
	@Trans
	public void update(D204z56 d204z56);
	
	/**
	 * 删除 核对统计信息
	 * @param d204z56Id
	 */
	@Trans
	public void delete(String d204z56Id);

}