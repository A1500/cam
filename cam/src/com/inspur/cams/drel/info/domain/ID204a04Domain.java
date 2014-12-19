package com.inspur.cams.drel.info.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.info.data.D204a04;

/**
 * 区划信息domain
 * @author 
 * @date 2014-06-09
 */
public interface ID204a04Domain {

	/**
	 * 查询 区划信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 区划信息
	 * @param pset
	 * @return
	 */
	public D204a04 get(String d204a04Id);

	/**
	 * 增加 区划信息
	 * @param d204a04
	 */
	@Trans
	public void insert(D204a04 d204a04);
	
	/**
	 * 修改 区划信息
	 * @param d204a04
	 */
	@Trans
	public void update(D204a04 d204a04);
	
	/**
	 * 删除 区划信息
	 * @param d204a04Id
	 */
	@Trans
	public void delete(String d204a04Id);

}