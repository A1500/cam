package com.inspur.cams.drel.info.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.info.data.D204b14;

/**
 * 转移性收入domain
 * @author 
 * @date 2014-06-09
 */
public interface ID204b14Domain {

	/**
	 * 查询 转移性收入
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 转移性收入
	 * @param pset
	 * @return
	 */
	public D204b14 get(String d204b14Id);

	/**
	 * 增加 转移性收入
	 * @param d204b14
	 */
	@Trans
	public void insert(D204b14 d204b14);
	
	/**
	 * 修改 转移性收入
	 * @param d204b14
	 */
	@Trans
	public void update(D204b14 d204b14);
	
	/**
	 * 删除 转移性收入
	 * @param d204b14Id
	 */
	@Trans
	public void delete(String d204b14Id);

}