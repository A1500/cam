package com.inspur.cams.drel.info.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.info.data.D204d39;

/**
 * 地税-投资方纳税信息domain
 * @author 
 * @date 2014-08-26
 */
public interface ID204d39Domain {

	/**
	 * 查询 地税-投资方纳税信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 地税-投资方纳税信息
	 * @param pset
	 * @return
	 */
	public D204d39 get(String d204d39Id);

	/**
	 * 增加 地税-投资方纳税信息
	 * @param d204d39
	 */
	@Trans
	public void insert(D204d39 d204d39);
	
	/**
	 * 修改 地税-投资方纳税信息
	 * @param d204d39
	 */
	@Trans
	public void update(D204d39 d204d39);
	
	/**
	 * 删除 地税-投资方纳税信息
	 * @param d204d39Id
	 */
	@Trans
	public void delete(String d204d39Id);

}