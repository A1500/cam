package com.inspur.cams.drel.info.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.info.data.D204b13;

/**
 * 财产性收入domain
 * @author 
 * @date 2014-06-09
 */
public interface ID204b13Domain {

	/**
	 * 查询 财产性收入
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 财产性收入
	 * @param pset
	 * @return
	 */
	public D204b13 get(String d204b13Id);

	/**
	 * 增加 财产性收入
	 * @param d204b13
	 */
	@Trans
	public void insert(D204b13 d204b13);
	
	/**
	 * 修改 财产性收入
	 * @param d204b13
	 */
	@Trans
	public void update(D204b13 d204b13);
	
	/**
	 * 删除 财产性收入
	 * @param d204b13Id
	 */
	@Trans
	public void delete(String d204b13Id);

}