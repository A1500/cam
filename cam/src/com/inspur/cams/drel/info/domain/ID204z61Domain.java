package com.inspur.cams.drel.info.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.info.data.D204z61;

/**
 * 船舶信息domain
 * @author 
 * @date 2014-06-09
 */
public interface ID204z61Domain {

	/**
	 * 查询 船舶信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 船舶信息
	 * @param pset
	 * @return
	 */
	public D204z61 get(String d204z61Id);

	/**
	 * 增加 船舶信息
	 * @param d204z61
	 */
	@Trans
	public void insert(D204z61 d204z61);
	
	/**
	 * 修改 船舶信息
	 * @param d204z61
	 */
	@Trans
	public void update(D204z61 d204z61);
	
	/**
	 * 删除 船舶信息
	 * @param d204z61Id
	 */
	@Trans
	public void delete(String d204z61Id);

}