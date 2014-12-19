package com.inspur.cams.drel.info.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.info.data.D204d36;

/**
 * 大额支出domain
 * @author 
 * @date 2014-06-09
 */
public interface ID204d36Domain {

	/**
	 * 查询 大额支出
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 大额支出
	 * @param pset
	 * @return
	 */
	public D204d36 get(String d204d36Id);

	/**
	 * 增加 大额支出
	 * @param d204d36
	 */
	@Trans
	public void insert(D204d36 d204d36);
	
	/**
	 * 修改 大额支出
	 * @param d204d36
	 */
	@Trans
	public void update(D204d36 d204d36);
	
	/**
	 * 删除 大额支出
	 * @param d204d36Id
	 */
	@Trans
	public void delete(String d204d36Id);

}