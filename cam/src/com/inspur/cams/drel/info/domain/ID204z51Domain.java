package com.inspur.cams.drel.info.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.info.data.D204z51;

/**
 * 教育信息domain
 * @author 
 * @date 2014-06-09
 */
public interface ID204z51Domain {

	/**
	 * 查询 教育信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 教育信息
	 * @param pset
	 * @return
	 */
	public D204z51 get(String d204z51Id);

	/**
	 * 增加 教育信息
	 * @param d204z51
	 */
	@Trans
	public void insert(D204z51 d204z51);
	
	/**
	 * 修改 教育信息
	 * @param d204z51
	 */
	@Trans
	public void update(D204z51 d204z51);
	
	/**
	 * 删除 教育信息
	 * @param d204z51Id
	 */
	@Trans
	public void delete(String d204z51Id);

}