package com.inspur.cams.drel.info.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.info.data.D204b11;

/**
 * 工资性收入domain
 * @author 
 * @date 2014-06-09
 */
public interface ID204b11Domain {

	/**
	 * 查询 工资性收入
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 工资性收入
	 * @param pset
	 * @return
	 */
	public D204b11 get(String d204b11Id);

	/**
	 * 增加 工资性收入
	 * @param d204b11
	 */
	@Trans
	public void insert(D204b11 d204b11);
	
	/**
	 * 修改 工资性收入
	 * @param d204b11
	 */
	@Trans
	public void update(D204b11 d204b11);
	
	/**
	 * 删除 工资性收入
	 * @param d204b11Id
	 */
	@Trans
	public void delete(String d204b11Id);

}